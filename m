Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE2DC433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 19:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0ABFD206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 19:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgGZTr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:47:58 -0400
Received: from mga05.intel.com ([192.55.52.43]:10348 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726244AbgGZTr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 15:47:58 -0400
IronPort-SDR: D14uEZyPsv4ZTOqTQQSOEguHER+OwXHrQ2mTgyowx9jaJeTQ7wR4k7aLxnL+NIzZ/SVK8HWCp5
 VK4CoxmbqdDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="235785943"
X-IronPort-AV: E=Sophos;i="5.75,399,1589266800"; 
   d="gz'50?scan'50,208,50";a="235785943"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 12:47:52 -0700
IronPort-SDR: uZCVbi0SrDITjXfbUdZ3n4hINY0yccJ+8AMHru0zODF6XszCQEVJoFkuBTZ3EVNxZxshcn2ErL
 VDBhCunydIdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,399,1589266800"; 
   d="gz'50?scan'50,208,50";a="363892828"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 26 Jul 2020 12:47:50 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jzmcf-0001bG-Jd; Sun, 26 Jul 2020 19:47:49 +0000
Date:   Mon, 27 Jul 2020 03:47:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: sound/core/timer.c:2084:24: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202007270328.uShc0lYL%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1ada9010e578150984039a770c98f41799b30bc4
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   5 weeks ago
config: openrisc-randconfig-s031-20200726 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-93-g4c6cbe55-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   sound/core/timer.c:2045:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *p @@
   sound/core/timer.c:2045:13: sparse:     expected int const *__gu_addr
   sound/core/timer.c:2045:13: sparse:     got int [noderef] __user *p
>> sound/core/timer.c:2084:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *p @@
   sound/core/timer.c:2084:24: sparse:     expected int *__pu_addr
   sound/core/timer.c:2084:24: sparse:     got int [noderef] __user *p
   sound/core/timer.c:790:25: sparse: sparse: context imbalance in 'snd_timer_process_callbacks' - unexpected unlock
   sound/core/timer.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   sound/core/timer.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   sound/core/timer.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   sound/core/timer.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   sound/core/timer.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   sound/core/timer.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   sound/core/timer.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   sound/core/timer.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   sound/core/timer.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   sound/core/timer.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   sound/core/timer.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   sound/core/timer.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   sound/core/timer.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   sound/core/timer.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   sound/core/timer.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   sound/core/timer.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   sound/core/timer.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   sound/core/timer.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
--
>> sound/core/compress_offload.c:949:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   sound/core/compress_offload.c:949:26: sparse:     expected int *__pu_addr
>> sound/core/compress_offload.c:949:26: sparse:     got int [noderef] __user *
   sound/core/compress_offload.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   sound/core/compress_offload.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   sound/core/compress_offload.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   sound/core/compress_offload.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   sound/core/compress_offload.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   sound/core/compress_offload.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   sound/core/compress_offload.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   sound/core/compress_offload.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   sound/core/compress_offload.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   sound/core/compress_offload.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   sound/core/compress_offload.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   sound/core/compress_offload.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from

vim +2084 sound/core/timer.c

15790a6be14852 Takashi Iwai   2005-05-15  2036  
07094ae6f95272 Baolin Wang    2018-04-24  2037  static int snd_timer_user_tread(void __user *argp, struct snd_timer_user *tu,
07094ae6f95272 Baolin Wang    2018-04-24  2038  				unsigned int cmd, bool compat)
07094ae6f95272 Baolin Wang    2018-04-24  2039  {
07094ae6f95272 Baolin Wang    2018-04-24  2040  	int __user *p = argp;
07094ae6f95272 Baolin Wang    2018-04-24  2041  	int xarg, old_tread;
07094ae6f95272 Baolin Wang    2018-04-24  2042  
07094ae6f95272 Baolin Wang    2018-04-24  2043  	if (tu->timeri)	/* too late */
07094ae6f95272 Baolin Wang    2018-04-24  2044  		return -EBUSY;
07094ae6f95272 Baolin Wang    2018-04-24 @2045  	if (get_user(xarg, p))
07094ae6f95272 Baolin Wang    2018-04-24  2046  		return -EFAULT;
07094ae6f95272 Baolin Wang    2018-04-24  2047  
07094ae6f95272 Baolin Wang    2018-04-24  2048  	old_tread = tu->tread;
07094ae6f95272 Baolin Wang    2018-04-24  2049  
07094ae6f95272 Baolin Wang    2018-04-24  2050  	if (!xarg)
07094ae6f95272 Baolin Wang    2018-04-24  2051  		tu->tread = TREAD_FORMAT_NONE;
07094ae6f95272 Baolin Wang    2018-04-24  2052  	else if (cmd == SNDRV_TIMER_IOCTL_TREAD64 ||
07094ae6f95272 Baolin Wang    2018-04-24  2053  		 (IS_ENABLED(CONFIG_64BIT) && !compat))
07094ae6f95272 Baolin Wang    2018-04-24  2054  		tu->tread = TREAD_FORMAT_TIME64;
07094ae6f95272 Baolin Wang    2018-04-24  2055  	else
07094ae6f95272 Baolin Wang    2018-04-24  2056  		tu->tread = TREAD_FORMAT_TIME32;
07094ae6f95272 Baolin Wang    2018-04-24  2057  
07094ae6f95272 Baolin Wang    2018-04-24  2058  	if (tu->tread != old_tread &&
07094ae6f95272 Baolin Wang    2018-04-24  2059  	    realloc_user_queue(tu, tu->queue_size) < 0) {
07094ae6f95272 Baolin Wang    2018-04-24  2060  		tu->tread = old_tread;
07094ae6f95272 Baolin Wang    2018-04-24  2061  		return -ENOMEM;
07094ae6f95272 Baolin Wang    2018-04-24  2062  	}
07094ae6f95272 Baolin Wang    2018-04-24  2063  
07094ae6f95272 Baolin Wang    2018-04-24  2064  	return 0;
07094ae6f95272 Baolin Wang    2018-04-24  2065  }
07094ae6f95272 Baolin Wang    2018-04-24  2066  
8c50b37c04a026 Takashi Iwai   2005-05-15  2067  enum {
8c50b37c04a026 Takashi Iwai   2005-05-15  2068  	SNDRV_TIMER_IOCTL_START_OLD = _IO('T', 0x20),
8c50b37c04a026 Takashi Iwai   2005-05-15  2069  	SNDRV_TIMER_IOCTL_STOP_OLD = _IO('T', 0x21),
8c50b37c04a026 Takashi Iwai   2005-05-15  2070  	SNDRV_TIMER_IOCTL_CONTINUE_OLD = _IO('T', 0x22),
8c50b37c04a026 Takashi Iwai   2005-05-15  2071  	SNDRV_TIMER_IOCTL_PAUSE_OLD = _IO('T', 0x23),
8c50b37c04a026 Takashi Iwai   2005-05-15  2072  };
8c50b37c04a026 Takashi Iwai   2005-05-15  2073  
af368027a49a75 Takashi Iwai   2016-01-13  2074  static long __snd_timer_user_ioctl(struct file *file, unsigned int cmd,
07094ae6f95272 Baolin Wang    2018-04-24  2075  				 unsigned long arg, bool compat)
^1da177e4c3f41 Linus Torvalds 2005-04-16  2076  {
53d2f744afc1fc Takashi Iwai   2005-11-17  2077  	struct snd_timer_user *tu;
^1da177e4c3f41 Linus Torvalds 2005-04-16  2078  	void __user *argp = (void __user *)arg;
^1da177e4c3f41 Linus Torvalds 2005-04-16  2079  	int __user *p = argp;
^1da177e4c3f41 Linus Torvalds 2005-04-16  2080  
^1da177e4c3f41 Linus Torvalds 2005-04-16  2081  	tu = file->private_data;
^1da177e4c3f41 Linus Torvalds 2005-04-16  2082  	switch (cmd) {
^1da177e4c3f41 Linus Torvalds 2005-04-16  2083  	case SNDRV_TIMER_IOCTL_PVERSION:
^1da177e4c3f41 Linus Torvalds 2005-04-16 @2084  		return put_user(SNDRV_TIMER_VERSION, p) ? -EFAULT : 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  2085  	case SNDRV_TIMER_IOCTL_NEXT_DEVICE:
^1da177e4c3f41 Linus Torvalds 2005-04-16  2086  		return snd_timer_user_next_device(argp);
07094ae6f95272 Baolin Wang    2018-04-24  2087  	case SNDRV_TIMER_IOCTL_TREAD_OLD:
07094ae6f95272 Baolin Wang    2018-04-24  2088  	case SNDRV_TIMER_IOCTL_TREAD64:
07094ae6f95272 Baolin Wang    2018-04-24  2089  		return snd_timer_user_tread(argp, tu, cmd, compat);
^1da177e4c3f41 Linus Torvalds 2005-04-16  2090  	case SNDRV_TIMER_IOCTL_GINFO:
^1da177e4c3f41 Linus Torvalds 2005-04-16  2091  		return snd_timer_user_ginfo(file, argp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  2092  	case SNDRV_TIMER_IOCTL_GPARAMS:
^1da177e4c3f41 Linus Torvalds 2005-04-16  2093  		return snd_timer_user_gparams(file, argp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  2094  	case SNDRV_TIMER_IOCTL_GSTATUS:
^1da177e4c3f41 Linus Torvalds 2005-04-16  2095  		return snd_timer_user_gstatus(file, argp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  2096  	case SNDRV_TIMER_IOCTL_SELECT:
^1da177e4c3f41 Linus Torvalds 2005-04-16  2097  		return snd_timer_user_tselect(file, argp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  2098  	case SNDRV_TIMER_IOCTL_INFO:
^1da177e4c3f41 Linus Torvalds 2005-04-16  2099  		return snd_timer_user_info(file, argp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  2100  	case SNDRV_TIMER_IOCTL_PARAMS:
^1da177e4c3f41 Linus Torvalds 2005-04-16  2101  		return snd_timer_user_params(file, argp);
a07804cc7472d8 Baolin Wang    2018-04-24  2102  	case SNDRV_TIMER_IOCTL_STATUS32:
a07804cc7472d8 Baolin Wang    2018-04-24  2103  		return snd_timer_user_status32(file, argp);
a07804cc7472d8 Baolin Wang    2018-04-24  2104  	case SNDRV_TIMER_IOCTL_STATUS64:
a07804cc7472d8 Baolin Wang    2018-04-24  2105  		return snd_timer_user_status64(file, argp);
^1da177e4c3f41 Linus Torvalds 2005-04-16  2106  	case SNDRV_TIMER_IOCTL_START:
8c50b37c04a026 Takashi Iwai   2005-05-15  2107  	case SNDRV_TIMER_IOCTL_START_OLD:
^1da177e4c3f41 Linus Torvalds 2005-04-16  2108  		return snd_timer_user_start(file);
^1da177e4c3f41 Linus Torvalds 2005-04-16  2109  	case SNDRV_TIMER_IOCTL_STOP:
8c50b37c04a026 Takashi Iwai   2005-05-15  2110  	case SNDRV_TIMER_IOCTL_STOP_OLD:
^1da177e4c3f41 Linus Torvalds 2005-04-16  2111  		return snd_timer_user_stop(file);
^1da177e4c3f41 Linus Torvalds 2005-04-16  2112  	case SNDRV_TIMER_IOCTL_CONTINUE:
8c50b37c04a026 Takashi Iwai   2005-05-15  2113  	case SNDRV_TIMER_IOCTL_CONTINUE_OLD:
^1da177e4c3f41 Linus Torvalds 2005-04-16  2114  		return snd_timer_user_continue(file);
15790a6be14852 Takashi Iwai   2005-05-15  2115  	case SNDRV_TIMER_IOCTL_PAUSE:
8c50b37c04a026 Takashi Iwai   2005-05-15  2116  	case SNDRV_TIMER_IOCTL_PAUSE_OLD:
15790a6be14852 Takashi Iwai   2005-05-15  2117  		return snd_timer_user_pause(file);
^1da177e4c3f41 Linus Torvalds 2005-04-16  2118  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  2119  	return -ENOTTY;
^1da177e4c3f41 Linus Torvalds 2005-04-16  2120  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  2121  

:::::: The code at line 2084 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--X1bOJ3K7DJ5YkBrT
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--X1bOJ3K7DJ5YkBrT--
