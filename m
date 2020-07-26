Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654E9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 23:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BFAC2070B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 23:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgGZXmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 19:42:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:13850 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgGZXmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 19:42:24 -0400
IronPort-SDR: X1DAA08a+XhgxQ97yyAWK0ARNcINgBqpQifIBeZA9cTjQWdDfN6Ik/7NxfzU8/+zYAMRk8u7Ny
 z0Z3twVmyhqg==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="138444801"
X-IronPort-AV: E=Sophos;i="5.75,400,1589266800"; 
   d="gz'50?scan'50,208,50";a="138444801"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 16:42:20 -0700
IronPort-SDR: Dd4rYXw7wFwALhIA7wn2ALF3M7bOP/EbYgSZaxH9fcxxhqDBMvDvnR+8iQ9H819MGedMCaUZnI
 pr6uurUd0Ekg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,400,1589266800"; 
   d="gz'50?scan'50,208,50";a="327850529"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Jul 2020 16:42:17 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jzqHZ-0001i2-3F; Sun, 26 Jul 2020 23:42:17 +0000
Date:   Mon, 27 Jul 2020 07:41:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:WIP.core/entry 1/1] arch/riscv/kernel/ptrace.c:162:6: error:
 too few arguments to function 'secure_computing'
Message-ID: <202007270753.5QWHCGzU%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git WIP.core/entry
head:   85546baab915492f05f29b91c4003bf15891e89b
commit: 85546baab915492f05f29b91c4003bf15891e89b [1/1] entry: Fix !CONFIG_SECCOMP stub
config: riscv-allnoconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 85546baab915492f05f29b91c4003bf15891e89b
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/kernel/ptrace.c:151:15: warning: no previous prototype for 'do_syscall_trace_enter' [-Wmissing-prototypes]
     151 | __visible int do_syscall_trace_enter(struct pt_regs *regs)
         |               ^~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/ptrace.c: In function 'do_syscall_trace_enter':
>> arch/riscv/kernel/ptrace.c:162:6: error: too few arguments to function 'secure_computing'
     162 |  if (secure_computing() == -1)
         |      ^~~~~~~~~~~~~~~~
   In file included from include/linux/sched.h:21,
                    from arch/riscv/include/asm/syscall.h:14,
                    from arch/riscv/kernel/ptrace.c:11:
   include/linux/seccomp.h:64:19: note: declared here
      64 | static inline int secure_computing(const struct seccomp_data *sd) { return 0; }
         |                   ^~~~~~~~~~~~~~~~
   arch/riscv/kernel/ptrace.c: At top level:
   arch/riscv/kernel/ptrace.c:174:16: warning: no previous prototype for 'do_syscall_trace_exit' [-Wmissing-prototypes]
     174 | __visible void do_syscall_trace_exit(struct pt_regs *regs)
         |                ^~~~~~~~~~~~~~~~~~~~~

vim +/secure_computing +162 arch/riscv/kernel/ptrace.c

e2c0cdfba7f699 Palmer Dabbelt      2017-07-10  146  
e2c0cdfba7f699 Palmer Dabbelt      2017-07-10  147  /*
e2c0cdfba7f699 Palmer Dabbelt      2017-07-10  148   * Allows PTRACE_SYSCALL to work.  These are called from entry.S in
e2c0cdfba7f699 Palmer Dabbelt      2017-07-10  149   * {handle,ret_from}_syscall.
e2c0cdfba7f699 Palmer Dabbelt      2017-07-10  150   */
af33d2433b03d6 Tycho Andersen      2020-02-08  151  __visible int do_syscall_trace_enter(struct pt_regs *regs)
e2c0cdfba7f699 Palmer Dabbelt      2017-07-10  152  {
e2c0cdfba7f699 Palmer Dabbelt      2017-07-10  153  	if (test_thread_flag(TIF_SYSCALL_TRACE))
e2c0cdfba7f699 Palmer Dabbelt      2017-07-10  154  		if (tracehook_report_syscall_entry(regs))
af33d2433b03d6 Tycho Andersen      2020-02-08  155  			return -1;
e2c0cdfba7f699 Palmer Dabbelt      2017-07-10  156  
5340627e3fe080 David Abdurachmanov 2019-10-04  157  	/*
5340627e3fe080 David Abdurachmanov 2019-10-04  158  	 * Do the secure computing after ptrace; failures should be fast.
5340627e3fe080 David Abdurachmanov 2019-10-04  159  	 * If this fails we might have return value in a0 from seccomp
5340627e3fe080 David Abdurachmanov 2019-10-04  160  	 * (via SECCOMP_RET_ERRNO/TRACE).
5340627e3fe080 David Abdurachmanov 2019-10-04  161  	 */
af33d2433b03d6 Tycho Andersen      2020-02-08 @162  	if (secure_computing() == -1)
af33d2433b03d6 Tycho Andersen      2020-02-08  163  		return -1;
5340627e3fe080 David Abdurachmanov 2019-10-04  164  

:::::: The code at line 162 was first introduced by commit
:::::: af33d2433b03d63ed31fcfda842f46676a5e1afc riscv: fix seccomp reject syscall code path

:::::: TO: Tycho Andersen <tycho@tycho.ws>
:::::: CC: Palmer Dabbelt <palmerdabbelt@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--envbJBWh7q8WU6mo
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
C+Dlnebn7LJ7ORwTmf0viqBWFDdKAAA=

--envbJBWh7q8WU6mo--
