"""
Get pep8 output on current vim buffer using pep8.Checker object
"""
try:
    import pep8
except ImportError:
    pep8 = None

import vim


class VImPep8(object):
    """Vim PEP8 checker"""

    def __init__(self):
        self.fname = vim.current.buffer.name
        self.bufnr = vim.current.buffer.number
        self.output = []
        self.exclude_list = vim.eval("g:pep8_exclude")

    def reporter(self, lnum, col, text, check):
        """Custom reporter for checker report_error method"""
        self.output.append([lnum, col, text])

    def run(self):
        """Run the checker"""
        if not pep8:
            vim.command("echo 'Error: pep8_fn.vim requires module pep8'")
            return

        pep8.process_options(['-r', vim.current.buffer.name])
        checker = pep8.Checker(vim.current.buffer.name)
        checker.report_error = self.reporter
        checker.check_all()
        self.process_output()

    def process_output(self):
        """Transform checker output into quickfix list"""
        vim.command('call setqflist([])')
        qf_list = []
        qf_dict = {}

        for line in self.output:
            skip = False
            for exclude_pattern in self.exclude_list:
                if exclude_pattern in line[2]:
                    skip = True
                    break
            if skip:
                continue
            qf_dict['bufnr'] = self.bufnr
            qf_dict['lnum'] = line[0]
            qf_dict['col'] = line[1]
            qf_dict['text'] = line[2]
            qf_dict['type'] = line[2][0]
            qf_list.append(qf_dict)
            qf_dict = {}

        self.output = []
        vim.command('call setqflist(%s)' % str(qf_list))
        if qf_list:
            vim.command('copen')
