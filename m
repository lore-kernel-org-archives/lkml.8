Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A133FC2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 18:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D8BF20801
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 18:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbgDJSEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 14:04:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:49836 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgDJSEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 14:04:15 -0400
IronPort-SDR: 3EUpRiOu8EE81TNhHGoN6PT6iNlslShPc8EAR1a6YobXIr5QFrI2oUqozrDTjGfRP0FR8vI90w
 x9z8V/EZQ2ig==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2020 11:04:13 -0700
IronPort-SDR: SQyx2cnF3tsoRbiwqWSRTvPrK0CDofXhnuRrE3K4hKTI+VenVF0mo+o73EecWKK9Fk7NEUkO8H
 WG4doaYKjnrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,367,1580803200"; 
   d="gz'50?scan'50,208,50";a="255542304"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 Apr 2020 11:04:10 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jMy0f-0001u5-BA; Sat, 11 Apr 2020 02:04:09 +0800
Date:   Sat, 11 Apr 2020 02:03:55 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/riscv/kernel/stacktrace.c:78:8: error: 'sp_in_global' undeclared
Message-ID: <202004110252.LxN9MU4e%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Palmer,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c0cc271173b2e1c2d8d0ceaef14e4dfa79eefc0d
commit: 52e7c52d2ded5908e6a4f8a7248e5fa6e0d6809a RISC-V: Stop relying on GCC's register allocator's hueristics
date:   5 weeks ago
config: riscv-allnoconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 52e7c52d2ded5908e6a4f8a7248e5fa6e0d6809a
        # save the attached .config to linux build tree
        GCC_VERSION=9.3.0 make.cross ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/riscv/kernel/stacktrace.c: In function 'walk_stackframe':
>> arch/riscv/kernel/stacktrace.c:78:8: error: 'sp_in_global' undeclared (first use in this function)
      78 |   sp = sp_in_global;
         |        ^~~~~~~~~~~~
   arch/riscv/kernel/stacktrace.c:78:8: note: each undeclared identifier is reported only once for each function it appears in

vim +/sp_in_global +78 arch/riscv/kernel/stacktrace.c

    67	
    68	static void notrace walk_stackframe(struct task_struct *task,
    69		struct pt_regs *regs, bool (*fn)(unsigned long, void *), void *arg)
    70	{
    71		unsigned long sp, pc;
    72		unsigned long *ksp;
    73	
    74		if (regs) {
    75			sp = user_stack_pointer(regs);
    76			pc = instruction_pointer(regs);
    77		} else if (task == NULL || task == current) {
  > 78			sp = sp_in_global;
    79			pc = (unsigned long)walk_stackframe;
    80		} else {
    81			/* task blocked in __switch_to */
    82			sp = task->thread.sp;
    83			pc = task->thread.ra;
    84		}
    85	
    86		if (unlikely(sp & 0x7))
    87			return;
    88	
    89		ksp = (unsigned long *)sp;
    90		while (!kstack_end(ksp)) {
    91			if (__kernel_text_address(pc) && unlikely(fn(pc, arg)))
    92				break;
    93			pc = (*ksp++) - 0x4;
    94		}
    95	}
    96	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--FCuugMFkClbJLl1L
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
3WKCrf8FLDdmSuxJAAA=

--FCuugMFkClbJLl1L--
