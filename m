Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0492CC433EA
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 08:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC826206EB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 08:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgGYIs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 04:48:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:36997 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgGYIs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 04:48:27 -0400
IronPort-SDR: WWTfzsvTa8t2RTVLjcdp5WI/xTp4tCue12IN5TWMQ8UzKVDrIKDjbmBdCOme8Udaaa13Tu5wF5
 lTYLQYukbLqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="130378990"
X-IronPort-AV: E=Sophos;i="5.75,394,1589266800"; 
   d="gz'50?scan'50,208,50";a="130378990"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2020 01:48:15 -0700
IronPort-SDR: gPZSD6QIwuUakVHBmUL93vvHWq1M9xBylXizwHmZcefs5iUhbtNMwgP7m2m7Di8QOT0yo08Hu6
 uhlfBwNoDdtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,394,1589266800"; 
   d="gz'50?scan'50,208,50";a="488985313"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2020 01:48:13 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jzFqm-0000qN-Hx; Sat, 25 Jul 2020 08:48:12 +0000
Date:   Sat, 25 Jul 2020 16:47:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/tty/vt/vt_ioctl.c:411:23: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202007251634.UcUQ0OG1%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AqsLC8rIMeq19msA"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   23ee3e4e5bd27bdbc0f1785eef7209ce872794c7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   5 weeks ago
config: openrisc-randconfig-s032-20200725 (attached as .config)
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

>> drivers/tty/vt/vt_ioctl.c:411:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__pu_addr @@     got char [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:411:23: sparse:     expected char *__pu_addr
>> drivers/tty/vt/vt_ioctl.c:411:23: sparse:     got char [noderef] __user *
>> drivers/tty/vt/vt_ioctl.c:527:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:527:23: sparse:     expected int *__pu_addr
>> drivers/tty/vt/vt_ioctl.c:527:23: sparse:     got int [noderef] __user *
   drivers/tty/vt/vt_ioctl.c:540:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:540:23: sparse:     expected int *__pu_addr
   drivers/tty/vt/vt_ioctl.c:540:23: sparse:     got int [noderef] __user *
>> drivers/tty/vt/vt_ioctl.c:652:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__pu_addr @@     got unsigned short [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:652:21: sparse:     expected unsigned short *__pu_addr
>> drivers/tty/vt/vt_ioctl.c:652:21: sparse:     got unsigned short [noderef] __user *
   drivers/tty/vt/vt_ioctl.c:662:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__pu_addr @@     got unsigned short [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:662:31: sparse:     expected unsigned short *__pu_addr
   drivers/tty/vt/vt_ioctl.c:662:31: sparse:     got unsigned short [noderef] __user *
>> drivers/tty/vt/vt_ioctl.c:839:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:839:21: sparse:     expected unsigned short const *__gu_addr
   drivers/tty/vt/vt_ioctl.c:839:21: sparse:     got unsigned short [noderef] __user *
   drivers/tty/vt/vt_ioctl.c:840:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short const *__gu_addr @@     got unsigned short [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:840:21: sparse:     expected unsigned short const *__gu_addr
   drivers/tty/vt/vt_ioctl.c:840:21: sparse:     got unsigned short [noderef] __user *
   drivers/tty/vt/vt_ioctl.c:1032:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__pu_addr @@     got unsigned short [noderef] __user * @@
   drivers/tty/vt/vt_ioctl.c:1032:23: sparse:     expected unsigned short *__pu_addr
   drivers/tty/vt/vt_ioctl.c:1032:23: sparse:     got unsigned short [noderef] __user *
   drivers/tty/vt/vt_ioctl.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/tty/vt/vt_ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   drivers/tty/vt/vt_ioctl.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/tty/vt/vt_ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   drivers/tty/vt/vt_ioctl.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/tty/vt/vt_ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   drivers/tty/vt/vt_ioctl.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/tty/vt/vt_ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   drivers/tty/vt/vt_ioctl.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/tty/vt/vt_ioctl.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
>> drivers/tty/vt/keyboard.c:1684:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tty/vt/keyboard.c:1684:21: sparse:     expected unsigned int *__pu_addr
>> drivers/tty/vt/keyboard.c:1684:21: sparse:     got unsigned int [noderef] __user *
   drivers/tty/vt/keyboard.c:1711:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tty/vt/keyboard.c:1711:21: sparse:     expected unsigned int *__pu_addr
   drivers/tty/vt/keyboard.c:1711:21: sparse:     got unsigned int [noderef] __user *
>> drivers/tty/vt/keyboard.c:1729:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tty/vt/keyboard.c:1729:21: sparse:     expected unsigned int const *__gu_addr
   drivers/tty/vt/keyboard.c:1729:21: sparse:     got unsigned int [noderef] __user *
   drivers/tty/vt/keyboard.c:1767:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tty/vt/keyboard.c:1767:21: sparse:     expected unsigned int const *__gu_addr
   drivers/tty/vt/keyboard.c:1767:21: sparse:     got unsigned int [noderef] __user *
   drivers/tty/vt/keyboard.c:1873:30: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   drivers/tty/vt/keyboard.c:1873:30: sparse:     expected unsigned int *__pu_addr
   drivers/tty/vt/keyboard.c:1873:30: sparse:     got unsigned int [noderef] __user *
>> drivers/tty/vt/keyboard.c:1914:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__pu_addr @@     got unsigned short [noderef] __user * @@
   drivers/tty/vt/keyboard.c:1914:24: sparse:     expected unsigned short *__pu_addr
>> drivers/tty/vt/keyboard.c:1914:24: sparse:     got unsigned short [noderef] __user *
>> drivers/tty/vt/keyboard.c:2032:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__pu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/tty/vt/keyboard.c:2032:37: sparse:     expected unsigned char *__pu_addr
>> drivers/tty/vt/keyboard.c:2032:37: sparse:     got unsigned char [noderef] [usertype] __user *
>> drivers/tty/vt/keyboard.c:2036:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__pu_addr @@     got unsigned char [noderef] [usertype] __user *[assigned] up @@
   drivers/tty/vt/keyboard.c:2036:21: sparse:     expected unsigned char *__pu_addr
>> drivers/tty/vt/keyboard.c:2036:21: sparse:     got unsigned char [noderef] [usertype] __user *[assigned] up
>> drivers/tty/vt/keyboard.c:2139:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__pu_addr @@     got char [noderef] __user * @@
   drivers/tty/vt/keyboard.c:2139:24: sparse:     expected char *__pu_addr
>> drivers/tty/vt/keyboard.c:2139:24: sparse:     got char [noderef] __user *
   drivers/tty/vt/keyboard.c:2157:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__pu_addr @@     got char [noderef] __user * @@
   drivers/tty/vt/keyboard.c:2157:24: sparse:     expected char *__pu_addr
   drivers/tty/vt/keyboard.c:2157:24: sparse:     got char [noderef] __user *
   drivers/tty/vt/keyboard.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/tty/vt/keyboard.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   drivers/tty/vt/keyboard.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/tty/vt/keyboard.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
>> drivers/tty/vt/consolemap.c:777:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned short *__pu_addr @@     got unsigned short [noderef] [usertype] __user *uct @@
   drivers/tty/vt/consolemap.c:777:9: sparse:     expected unsigned short *__pu_addr
>> drivers/tty/vt/consolemap.c:777:9: sparse:     got unsigned short [noderef] [usertype] __user *uct
   drivers/tty/vt/consolemap.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/tty/vt/consolemap.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   drivers/tty/vt/consolemap.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/tty/vt/consolemap.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   drivers/tty/vt/consolemap.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/tty/vt/consolemap.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
>> drivers/tty/vt/vt.c:4210:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char [noderef] __user * @@
   drivers/tty/vt/vt.c:4210:13: sparse:     expected char const *__gu_addr
>> drivers/tty/vt/vt.c:4210:13: sparse:     got char [noderef] __user *
   drivers/tty/vt/vt.c:233:5: sparse: sparse: symbol 'console_blank_hook' was not declared. Should it be static?
   drivers/tty/vt/vt.c:2901:19: sparse: sparse: symbol 'console_driver' was not declared. Should it be static?
>> drivers/tty/vt/vt.c:3057:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char [noderef] __user *p @@
   drivers/tty/vt/vt.c:3057:13: sparse:     expected char const *__gu_addr
>> drivers/tty/vt/vt.c:3057:13: sparse:     got char [noderef] __user *p
>> drivers/tty/vt/vt.c:3089:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__pu_addr @@     got char [noderef] __user *p @@
   drivers/tty/vt/vt.c:3089:31: sparse:     expected char *__pu_addr
   drivers/tty/vt/vt.c:3089:31: sparse:     got char [noderef] __user *p
   drivers/tty/vt/vt.c:3095:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__pu_addr @@     got char [noderef] __user *p @@
   drivers/tty/vt/vt.c:3095:31: sparse:     expected char *__pu_addr
   drivers/tty/vt/vt.c:3095:31: sparse:     got char [noderef] __user *p
   drivers/tty/vt/vt.c:3104:31: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char *__pu_addr @@     got char [noderef] __user *p @@
   drivers/tty/vt/vt.c:3104:31: sparse:     expected char *__pu_addr
   drivers/tty/vt/vt.c:3104:31: sparse:     got char [noderef] __user *p
   drivers/tty/vt/vt.c:3110:37: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const *__gu_addr @@     got char [noderef] __user * @@
   drivers/tty/vt/vt.c:3110:37: sparse:     expected char const *__gu_addr
   drivers/tty/vt/vt.c:3110:37: sparse:     got char [noderef] __user *
>> drivers/tty/vt/vt.c:3123:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected signed int const *__gu_addr @@     got signed int [noderef] [usertype] __user * @@
   drivers/tty/vt/vt.c:3123:29: sparse:     expected signed int const *__gu_addr
>> drivers/tty/vt/vt.c:3123:29: sparse:     got signed int [noderef] [usertype] __user *
   drivers/tty/vt/vt.c: note: in included file (through include/asm-generic/atomic.h, arch/openrisc/include/asm/atomic.h, include/linux/atomic.h, ...):
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   arch/openrisc/include/asm/cmpxchg.h:69:29: sparse: sparse: shift too big (32) for type int
   drivers/tty/vt/vt.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/tty/vt/vt.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   drivers/tty/vt/vt.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/tty/vt/vt.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from

vim +411 drivers/tty/vt/vt_ioctl.c

8b92e87d39bfd0 drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  344  
8b92e87d39bfd0 drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  345  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  346  /*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  347   * We handle the console-specific ioctl's here.  We allow the
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  348   * capability to modify any console, not just the fg_console. 
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  349   */
6caa76b7786891 drivers/tty/vt/vt_ioctl.c Alan Cox            2011-02-14  350  int vt_ioctl(struct tty_struct *tty,
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  351  	     unsigned int cmd, unsigned long arg)
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  352  {
c9f19e96a2f33c drivers/char/vt_ioctl.c   Alan Cox            2009-01-02  353  	struct vc_data *vc = tty->driver_data;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  354  	struct console_font_op op;	/* used in multiple places here */
1aa6e058dd6cd0 drivers/tty/vt/vt_ioctl.c Eric Biggers        2020-02-24  355  	unsigned int console = vc->vc_num;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  356  	unsigned char ucval;
1e0ad2881d50be drivers/char/vt_ioctl.c   Graham Gower        2010-10-27  357  	unsigned int uival;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  358  	void __user *up = (void __user *)arg;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  359  	int i, perm;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  360  	int ret = 0;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  361  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  362  	/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  363  	 * To have permissions to do most of the vt ioctls, we either have
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  364  	 * to be the owner of the tty, or have CAP_SYS_TTY_CONFIG.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  365  	 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  366  	perm = 0;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  367  	if (current->signal->tty == tty || capable(CAP_SYS_TTY_CONFIG))
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  368  		perm = 1;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  369   
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  370  	switch (cmd) {
e6885107736a4d drivers/char/vt_ioctl.c   Alan Cox            2008-10-13  371  	case TIOCLINUX:
a115902f67ef51 drivers/char/vt_ioctl.c   Jiri Slaby          2009-06-22  372  		ret = tioclinux(tty, arg);
a115902f67ef51 drivers/char/vt_ioctl.c   Jiri Slaby          2009-06-22  373  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  374  	case KIOCSOUND:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  375  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  376  			return -EPERM;
2c4e9671edfef5 drivers/char/vt_ioctl.c   Arnd Bergmann       2010-08-28  377  		/*
2c4e9671edfef5 drivers/char/vt_ioctl.c   Arnd Bergmann       2010-08-28  378  		 * The use of PIT_TICK_RATE is historic, it used to be
2c4e9671edfef5 drivers/char/vt_ioctl.c   Arnd Bergmann       2010-08-28  379  		 * the platform-dependent CLOCK_TICK_RATE between 2.6.12
2c4e9671edfef5 drivers/char/vt_ioctl.c   Arnd Bergmann       2010-08-28  380  		 * and 2.6.36, which was a minor but unfortunate ABI
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  381  		 * change. kd_mksound is locked by the input layer.
2c4e9671edfef5 drivers/char/vt_ioctl.c   Arnd Bergmann       2010-08-28  382  		 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  383  		if (arg)
2c4e9671edfef5 drivers/char/vt_ioctl.c   Arnd Bergmann       2010-08-28  384  			arg = PIT_TICK_RATE / arg;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  385  		kd_mksound(arg, 0);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  386  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  387  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  388  	case KDMKTONE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  389  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  390  			return -EPERM;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  391  	{
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  392  		unsigned int ticks, count;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  393  		
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  394  		/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  395  		 * Generate the tone for the appropriate number of ticks.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  396  		 * If the time is zero, turn off sound ourselves.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  397  		 */
4c0d9b17d1c060 drivers/tty/vt/vt_ioctl.c Nicholas Mc Guire   2015-02-09  398  		ticks = msecs_to_jiffies((arg >> 16) & 0xffff);
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  399  		count = ticks ? (arg & 0xffff) : 0;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  400  		if (count)
2c4e9671edfef5 drivers/char/vt_ioctl.c   Arnd Bergmann       2010-08-28  401  			count = PIT_TICK_RATE / count;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  402  		kd_mksound(count, ticks);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  403  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  404  	}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  405  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  406  	case KDGKBTYPE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  407  		/*
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  408  		 * this is naïve.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  409  		 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  410  		ucval = KB_101;
079c9534a96da9 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-02-28 @411  		ret = put_user(ucval, (char __user *)arg);
079c9534a96da9 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-02-28  412  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  413  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  414  		/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  415  		 * These cannot be implemented on any machine that implements
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  416  		 * ioperm() in user level (such as Alpha PCs) or not at all.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  417  		 *
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  418  		 * XXX: you should never use these, just call ioperm directly..
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  419  		 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  420  #ifdef CONFIG_X86
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  421  	case KDADDIO:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  422  	case KDDELIO:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  423  		/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  424  		 * KDADDIO and KDDELIO may be able to add ports beyond what
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  425  		 * we reject here, but to be safe...
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  426  		 *
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  427  		 * These are locked internally via sys_ioperm
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  428  		 */
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  429  		if (arg < GPFIRST || arg > GPLAST) {
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  430  			ret = -EINVAL;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  431  			break;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  432  		}
66f4e88cc69da7 drivers/tty/vt/vt_ioctl.c Dominik Brodowski   2018-03-11  433  		ret = ksys_ioperm(arg, 1, (cmd == KDADDIO)) ? -ENXIO : 0;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  434  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  435  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  436  	case KDENABIO:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  437  	case KDDISABIO:
66f4e88cc69da7 drivers/tty/vt/vt_ioctl.c Dominik Brodowski   2018-03-11  438  		ret = ksys_ioperm(GPFIRST, GPNUM,
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  439  				  (cmd == KDENABIO)) ? -ENXIO : 0;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  440  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  441  #endif
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  442  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  443  	/* Linux m68k/i386 interface for setting the keyboard delay/repeat rate */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  444  		
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  445  	case KDKBDREP:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  446  	{
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  447  		struct kbd_repeat kbrep;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  448  		
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  449  		if (!capable(CAP_SYS_TTY_CONFIG))
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  450  			return -EPERM;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  451  
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  452  		if (copy_from_user(&kbrep, up, sizeof(struct kbd_repeat))) {
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  453  			ret =  -EFAULT;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  454  			break;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  455  		}
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  456  		ret = kbd_rate(&kbrep);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  457  		if (ret)
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  458  			break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  459  		if (copy_to_user(up, &kbrep, sizeof(struct kbd_repeat)))
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  460  			ret = -EFAULT;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  461  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  462  	}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  463  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  464  	case KDSETMODE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  465  		/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  466  		 * currently, setting the mode from KD_TEXT to KD_GRAPHICS
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  467  		 * doesn't do a whole lot. i'm not sure if it should do any
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  468  		 * restoration of modes or what...
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  469  		 *
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  470  		 * XXX It should at least call into the driver, fbdev's definitely
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  471  		 * need to restore their engine state. --BenH
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  472  		 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  473  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  474  			return -EPERM;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  475  		switch (arg) {
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  476  		case KD_GRAPHICS:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  477  			break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  478  		case KD_TEXT0:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  479  		case KD_TEXT1:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  480  			arg = KD_TEXT;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  481  		case KD_TEXT:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  482  			break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  483  		default:
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  484  			ret = -EINVAL;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  485  			goto out;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  486  		}
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  487  		/* FIXME: this needs the console lock extending */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  488  		if (vc->vc_mode == (unsigned char) arg)
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  489  			break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  490  		vc->vc_mode = (unsigned char) arg;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  491  		if (console != fg_console)
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  492  			break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  493  		/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  494  		 * explicitly blank/unblank the screen if switching modes
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  495  		 */
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn         2011-01-25  496  		console_lock();
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  497  		if (arg == KD_TEXT)
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  498  			do_unblank_screen(1);
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  499  		else
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  500  			do_blank_screen(1);
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn         2011-01-25  501  		console_unlock();
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  502  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  503  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  504  	case KDGETMODE:
1e0ad2881d50be drivers/char/vt_ioctl.c   Graham Gower        2010-10-27  505  		uival = vc->vc_mode;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  506  		goto setint;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  507  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  508  	case KDMAPDISP:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  509  	case KDUNMAPDISP:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  510  		/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  511  		 * these work like a combination of mmap and KDENABIO.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  512  		 * this could be easily finished.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  513  		 */
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  514  		ret = -EINVAL;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  515  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  516  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  517  	case KDSKBMODE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  518  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  519  			return -EPERM;
079c9534a96da9 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-02-28  520  		ret = vt_do_kdskbmode(console, arg);
079c9534a96da9 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-02-28  521  		if (ret == 0)
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  522  			tty_ldisc_flush(tty);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  523  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  524  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  525  	case KDGKBMODE:
079c9534a96da9 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-02-28  526  		uival = vt_do_kdgkbmode(console);
079c9534a96da9 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-02-28 @527  		ret = put_user(uival, (int __user *)arg);
6da9e95f7381fa drivers/tty/vt/vt_ioctl.c Andrew Morton       2011-04-07  528  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  529  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  530  	/* this could be folded into KDSKBMODE, but for compatibility
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  531  	   reasons it is not so easy to fold KDGKBMETA into KDGKBMODE */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  532  	case KDSKBMETA:
079c9534a96da9 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-02-28  533  		ret = vt_do_kdskbmeta(console, arg);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  534  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  535  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  536  	case KDGKBMETA:
079c9534a96da9 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-02-28  537  		/* FIXME: should review whether this is worth locking */
079c9534a96da9 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-02-28  538  		uival = vt_do_kdgkbmeta(console);
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  539  	setint:
1e0ad2881d50be drivers/char/vt_ioctl.c   Graham Gower        2010-10-27  540  		ret = put_user(uival, (int __user *)arg);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  541  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  542  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  543  	case KDGETKEYCODE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  544  	case KDSETKEYCODE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  545  		if(!capable(CAP_SYS_TTY_CONFIG))
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  546  			perm = 0;
079c9534a96da9 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-02-28  547  		ret = vt_do_kbkeycode_ioctl(cmd, up, perm);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  548  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  549  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  550  	case KDGKBENT:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  551  	case KDSKBENT:
079c9534a96da9 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-02-28  552  		ret = vt_do_kdsk_ioctl(cmd, up, perm, console);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  553  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  554  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  555  	case KDGKBSENT:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  556  	case KDSKBSENT:
079c9534a96da9 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-02-28  557  		ret = vt_do_kdgkb_ioctl(cmd, up, perm);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  558  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  559  
247ff8e610cb63 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-02-24  560  	/* Diacritical processing. Handled in keyboard.c as it has
247ff8e610cb63 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-02-24  561  	   to operate on the keyboard locks and structures */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  562  	case KDGKBDIACR:
04c71976500352 drivers/char/vt_ioctl.c   Samuel Thibault     2007-10-16  563  	case KDGKBDIACRUC:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  564  	case KDSKBDIACR:
04c71976500352 drivers/char/vt_ioctl.c   Samuel Thibault     2007-10-16  565  	case KDSKBDIACRUC:
247ff8e610cb63 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-02-24  566  		ret = vt_do_diacrit(cmd, up, perm);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  567  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  568  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  569  	/* the ioctls below read/set the flags usually shown in the leds */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  570  	/* don't use them - they will go away without warning */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  571  	case KDGKBLED:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  572  	case KDSKBLED:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  573  	case KDGETLED:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  574  	case KDSETLED:
079c9534a96da9 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-02-28  575  		ret = vt_do_kdskled(console, cmd, arg, perm);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  576  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  577  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  578  	/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  579  	 * A process can indicate its willingness to accept signals
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  580  	 * generated by pressing an appropriate key combination.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  581  	 * Thus, one can have a daemon that e.g. spawns a new console
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  582  	 * upon a keypress and then changes to it.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  583  	 * See also the kbrequest field of inittab(5).
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  584  	 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  585  	case KDSIGACCEPT:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  586  	{
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  587  		if (!perm || !capable(CAP_KILL))
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  588  			return -EPERM;
7ed20e1ad521b5 drivers/char/vt_ioctl.c   Jesper Juhl         2005-05-01  589  		if (!valid_signal(arg) || arg < 1 || arg == SIGKILL)
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  590  			ret = -EINVAL;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  591  		else {
81af8d67d4fc35 drivers/char/vt_ioctl.c   Eric W. Biederman   2006-10-02  592  			spin_lock_irq(&vt_spawn_con.lock);
81af8d67d4fc35 drivers/char/vt_ioctl.c   Eric W. Biederman   2006-10-02  593  			put_pid(vt_spawn_con.pid);
81af8d67d4fc35 drivers/char/vt_ioctl.c   Eric W. Biederman   2006-10-02  594  			vt_spawn_con.pid = get_pid(task_pid(current));
81af8d67d4fc35 drivers/char/vt_ioctl.c   Eric W. Biederman   2006-10-02  595  			vt_spawn_con.sig = arg;
81af8d67d4fc35 drivers/char/vt_ioctl.c   Eric W. Biederman   2006-10-02  596  			spin_unlock_irq(&vt_spawn_con.lock);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  597  		}
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  598  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  599  	}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  600  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  601  	case VT_SETMODE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  602  	{
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  603  		struct vt_mode tmp;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  604  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  605  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  606  			return -EPERM;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  607  		if (copy_from_user(&tmp, up, sizeof(struct vt_mode))) {
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  608  			ret = -EFAULT;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  609  			goto out;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  610  		}
87a6aca504d65f drivers/char/vt_ioctl.c   Greg Kroah-Hartman  2010-03-15  611  		if (tmp.mode != VT_AUTO && tmp.mode != VT_PROCESS) {
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  612  			ret = -EINVAL;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  613  			goto out;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  614  		}
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn         2011-01-25  615  		console_lock();
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  616  		vc->vt_mode = tmp;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  617  		/* the frsig is ignored, so we set it to 0 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  618  		vc->vt_mode.frsig = 0;
8b6312f4dcc1ef drivers/char/vt_ioctl.c   Eric W. Biederman   2007-02-10  619  		put_pid(vc->vt_pid);
8b6312f4dcc1ef drivers/char/vt_ioctl.c   Eric W. Biederman   2007-02-10  620  		vc->vt_pid = get_pid(task_pid(current));
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  621  		/* no switch is required -- saw@shade.msu.ru */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  622  		vc->vt_newvt = -1;
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn         2011-01-25  623  		console_unlock();
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  624  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  625  	}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  626  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  627  	case VT_GETMODE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  628  	{
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  629  		struct vt_mode tmp;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  630  		int rc;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  631  
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn         2011-01-25  632  		console_lock();
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  633  		memcpy(&tmp, &vc->vt_mode, sizeof(struct vt_mode));
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn         2011-01-25  634  		console_unlock();
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  635  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  636  		rc = copy_to_user(up, &tmp, sizeof(struct vt_mode));
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  637  		if (rc)
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  638  			ret = -EFAULT;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  639  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  640  	}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  641  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  642  	/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  643  	 * Returns global vt state. Note that VT 0 is always open, since
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  644  	 * it's an alias for the current VT, and people can't use it here.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  645  	 * We cannot return state for more than 16 VTs, since v_state is short.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  646  	 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  647  	case VT_GETSTATE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  648  	{
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  649  		struct vt_stat __user *vtstat = up;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  650  		unsigned short state, mask;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  651  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  652  		if (put_user(fg_console + 1, &vtstat->v_active))
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  653  			ret = -EFAULT;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  654  		else {
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  655  			state = 1;	/* /dev/tty0 is always open */
7cf64b18b0b96e drivers/tty/vt/vt_ioctl.c Eric Biggers        2020-03-21  656  			console_lock(); /* required by vt_in_use() */
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  657  			for (i = 0, mask = 2; i < MAX_NR_CONSOLES && mask;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  658  							++i, mask <<= 1)
e587e8f17433dd drivers/tty/vt/vt_ioctl.c Jiri Slaby          2020-02-19  659  				if (vt_in_use(i))
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  660  					state |= mask;
7cf64b18b0b96e drivers/tty/vt/vt_ioctl.c Eric Biggers        2020-03-21  661  			console_unlock();
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  662  			ret = put_user(state, &vtstat->v_state);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  663  		}
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  664  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  665  	}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  666  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  667  	/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  668  	 * Returns the first available (non-opened) console.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  669  	 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  670  	case VT_OPENQRY:
7cf64b18b0b96e drivers/tty/vt/vt_ioctl.c Eric Biggers        2020-03-21  671  		console_lock(); /* required by vt_in_use() */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  672  		for (i = 0; i < MAX_NR_CONSOLES; ++i)
e587e8f17433dd drivers/tty/vt/vt_ioctl.c Jiri Slaby          2020-02-19  673  			if (!vt_in_use(i))
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  674  				break;
7cf64b18b0b96e drivers/tty/vt/vt_ioctl.c Eric Biggers        2020-03-21  675  		console_unlock();
1e0ad2881d50be drivers/char/vt_ioctl.c   Graham Gower        2010-10-27  676  		uival = i < MAX_NR_CONSOLES ? (i+1) : -1;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  677  		goto setint;		 
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  678  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  679  	/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  680  	 * ioctl(fd, VT_ACTIVATE, num) will cause us to switch to vt # num,
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  681  	 * with num >= 1 (switches to vt 0, our console, are not allowed, just
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  682  	 * to preserve sanity).
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  683  	 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  684  	case VT_ACTIVATE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  685  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  686  			return -EPERM;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  687  		if (arg == 0 || arg > MAX_NR_CONSOLES)
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  688  			ret =  -ENXIO;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  689  		else {
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  690  			arg--;
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn         2011-01-25  691  			console_lock();
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  692  			ret = vc_allocate(arg);
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn         2011-01-25  693  			console_unlock();
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  694  			if (ret)
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  695  				break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  696  			set_console(arg);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  697  		}
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  698  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  699  
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  700  	case VT_SETACTIVATE:
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  701  	{
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  702  		struct vt_setactivate vsa;
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  703  
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  704  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  705  			return -EPERM;
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  706  
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  707  		if (copy_from_user(&vsa, (struct vt_setactivate __user *)arg,
a09efb07b5025f drivers/char/vt_ioctl.c   Jiri Slaby          2009-10-01  708  					sizeof(struct vt_setactivate))) {
a09efb07b5025f drivers/char/vt_ioctl.c   Jiri Slaby          2009-10-01  709  			ret = -EFAULT;
a09efb07b5025f drivers/char/vt_ioctl.c   Jiri Slaby          2009-10-01  710  			goto out;
a09efb07b5025f drivers/char/vt_ioctl.c   Jiri Slaby          2009-10-01  711  		}
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  712  		if (vsa.console == 0 || vsa.console > MAX_NR_CONSOLES)
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  713  			ret = -ENXIO;
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  714  		else {
e97267cb4d1ee0 drivers/tty/vt/vt_ioctl.c Gustavo A. R. Silva 2018-08-16  715  			vsa.console = array_index_nospec(vsa.console,
e97267cb4d1ee0 drivers/tty/vt/vt_ioctl.c Gustavo A. R. Silva 2018-08-16  716  							 MAX_NR_CONSOLES + 1);
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  717  			vsa.console--;
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn         2011-01-25  718  			console_lock();
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  719  			ret = vc_allocate(vsa.console);
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  720  			if (ret == 0) {
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  721  				struct vc_data *nvc;
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  722  				/* This is safe providing we don't drop the
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  723  				   console sem between vc_allocate and
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  724  				   finishing referencing nvc */
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  725  				nvc = vc_cons[vsa.console].d;
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  726  				nvc->vt_mode = vsa.mode;
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  727  				nvc->vt_mode.frsig = 0;
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  728  				put_pid(nvc->vt_pid);
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  729  				nvc->vt_pid = get_pid(task_pid(current));
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  730  			}
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn         2011-01-25  731  			console_unlock();
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  732  			if (ret)
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  733  				break;
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  734  			/* Commence switch and lock */
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  735  			/* Review set_console locks */
d637837583163a drivers/tty/vt/vt_ioctl.c Jiri Olsa           2011-02-11  736  			set_console(vsa.console);
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  737  		}
d637837583163a drivers/tty/vt/vt_ioctl.c Jiri Olsa           2011-02-11  738  		break;
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  739  	}
d3b5cffcf84a8b drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  740  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  741  	/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  742  	 * wait until the specified VT has been activated
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  743  	 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  744  	case VT_WAITACTIVE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  745  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  746  			return -EPERM;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  747  		if (arg == 0 || arg > MAX_NR_CONSOLES)
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  748  			ret = -ENXIO;
99cceb4e50cb67 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  749  		else
8b92e87d39bfd0 drivers/char/vt_ioctl.c   Alan Cox            2009-09-19  750  			ret = vt_waitactive(arg);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  751  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  752  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  753  	/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  754  	 * If a vt is under process control, the kernel will not switch to it
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  755  	 * immediately, but postpone the operation until the process calls this
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  756  	 * ioctl, allowing the switch to complete.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  757  	 *
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  758  	 * According to the X sources this is the behavior:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  759  	 *	0:	pending switch-from not OK
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  760  	 *	1:	pending switch-from OK
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  761  	 *	2:	completed switch-to OK
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  762  	 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  763  	case VT_RELDISP:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  764  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  765  			return -EPERM;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  766  
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  767  		console_lock();
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  768  		if (vc->vt_mode.mode != VT_PROCESS) {
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  769  			console_unlock();
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  770  			ret = -EINVAL;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  771  			break;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  772  		}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  773  		/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  774  		 * Switching-from response
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  775  		 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  776  		if (vc->vt_newvt >= 0) {
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  777  			if (arg == 0)
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  778  				/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  779  				 * Switch disallowed, so forget we were trying
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  780  				 * to do it.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  781  				 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  782  				vc->vt_newvt = -1;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  783  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  784  			else {
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  785  				/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  786  				 * The current vt has been released, so
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  787  				 * complete the switch.
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  788  				 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  789  				int newvt;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  790  				newvt = vc->vt_newvt;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  791  				vc->vt_newvt = -1;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  792  				ret = vc_allocate(newvt);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  793  				if (ret) {
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn         2011-01-25  794  					console_unlock();
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  795  					break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  796  				}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  797  				/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  798  				 * When we actually do the console switch,
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  799  				 * make sure we are atomic with respect to
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  800  				 * other console switches..
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  801  				 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  802  				complete_change_console(vc_cons[newvt].d);
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  803  			}
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  804  		} else {
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  805  			/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  806  			 * Switched-to response
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  807  			 */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  808  			/*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  809  			 * If it's just an ACK, ignore it
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  810  			 */
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  811  			if (arg != VT_ACKACQ)
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  812  				ret = -EINVAL;
8792f961ba8057 drivers/char/vt_ioctl.c   Samuel Ortiz        2007-10-01  813  		}
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn         2011-01-25  814  		console_unlock();
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  815  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  816  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  817  	 /*
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  818  	  * Disallocate memory associated to VT (but leave VT1)
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  819  	  */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  820  	 case VT_DISALLOCATE:
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  821  		if (arg > MAX_NR_CONSOLES) {
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  822  			ret = -ENXIO;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  823  			break;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  824  		}
421b40a6286ee3 drivers/tty/vt/vt_ioctl.c Peter Hurley        2013-05-17  825  		if (arg == 0)
421b40a6286ee3 drivers/tty/vt/vt_ioctl.c Peter Hurley        2013-05-17  826  			vt_disallocate_all();
421b40a6286ee3 drivers/tty/vt/vt_ioctl.c Peter Hurley        2013-05-17  827  		else
421b40a6286ee3 drivers/tty/vt/vt_ioctl.c Peter Hurley        2013-05-17  828  			ret = vt_disallocate(--arg);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  829  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  830  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  831  	case VT_RESIZE:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  832  	{
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  833  		struct vt_sizes __user *vtsizes = up;
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas  2007-10-16  834  		struct vc_data *vc;
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas  2007-10-16  835  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  836  		ushort ll,cc;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  837  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  838  			return -EPERM;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  839  		if (get_user(ll, &vtsizes->v_rows) ||
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  840  		    get_user(cc, &vtsizes->v_cols))
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  841  			ret = -EFAULT;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  842  		else {
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn         2011-01-25  843  			console_lock();
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas  2007-10-16  844  			for (i = 0; i < MAX_NR_CONSOLES; i++) {
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas  2007-10-16  845  				vc = vc_cons[i].d;
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas  2007-10-16  846  
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas  2007-10-16  847  				if (vc) {
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas  2007-10-16  848  					vc->vc_resize_user = 1;
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  849  					/* FIXME: review v tty lock */
8c9a9dd0fa3a26 drivers/char/vt_ioctl.c   Alan Cox            2008-08-15  850  					vc_resize(vc_cons[i].d, cc, ll);
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas  2007-10-16  851  				}
e400b6ec4ede4d drivers/char/vt_ioctl.c   Antonino A. Daplas  2007-10-16  852  			}
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn         2011-01-25  853  			console_unlock();
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  854  		}
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  855  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  856  	}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  857  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  858  	case VT_RESIZEX:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  859  	{
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  860  		struct vt_consize v;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  861  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  862  			return -EPERM;
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  863  		if (copy_from_user(&v, up, sizeof(struct vt_consize)))
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  864  			return -EFAULT;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  865  		/* FIXME: Should check the copies properly */
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  866  		if (!v.v_vlin)
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  867  			v.v_vlin = vc->vc_scan_lines;
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  868  		if (v.v_clin) {
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  869  			int rows = v.v_vlin/v.v_clin;
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  870  			if (v.v_rows != rows) {
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  871  				if (v.v_rows) /* Parameters don't add up */
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  872  					return -EINVAL;
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  873  				v.v_rows = rows;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  874  			}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  875  		}
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  876  		if (v.v_vcol && v.v_ccol) {
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  877  			int cols = v.v_vcol/v.v_ccol;
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  878  			if (v.v_cols != cols) {
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  879  				if (v.v_cols)
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  880  					return -EINVAL;
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  881  				v.v_cols = cols;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  882  			}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  883  		}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  884  
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  885  		if (v.v_clin > 32)
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  886  			return -EINVAL;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  887  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  888  		for (i = 0; i < MAX_NR_CONSOLES; i++) {
6cd1ed50efd882 drivers/tty/vt/vt_ioctl.c Eric Dumazet        2020-02-10  889  			struct vc_data *vcp;
6cd1ed50efd882 drivers/tty/vt/vt_ioctl.c Eric Dumazet        2020-02-10  890  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  891  			if (!vc_cons[i].d)
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  892  				continue;
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn         2011-01-25  893  			console_lock();
6cd1ed50efd882 drivers/tty/vt/vt_ioctl.c Eric Dumazet        2020-02-10  894  			vcp = vc_cons[i].d;
6cd1ed50efd882 drivers/tty/vt/vt_ioctl.c Eric Dumazet        2020-02-10  895  			if (vcp) {
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  896  				if (v.v_vlin)
6cd1ed50efd882 drivers/tty/vt/vt_ioctl.c Eric Dumazet        2020-02-10  897  					vcp->vc_scan_lines = v.v_vlin;
1b3bce4d6bf839 drivers/tty/vt/vt_ioctl.c Al Viro             2017-09-29  898  				if (v.v_clin)
6cd1ed50efd882 drivers/tty/vt/vt_ioctl.c Eric Dumazet        2020-02-10  899  					vcp->vc_font.height = v.v_clin;
6cd1ed50efd882 drivers/tty/vt/vt_ioctl.c Eric Dumazet        2020-02-10  900  				vcp->vc_resize_user = 1;
6cd1ed50efd882 drivers/tty/vt/vt_ioctl.c Eric Dumazet        2020-02-10  901  				vc_resize(vcp, v.v_cols, v.v_rows);
6cd1ed50efd882 drivers/tty/vt/vt_ioctl.c Eric Dumazet        2020-02-10  902  			}
ac751efa6a0d70 drivers/tty/vt/vt_ioctl.c Torben Hohn         2011-01-25  903  			console_unlock();
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  904  		}
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  905  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  906  	}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  907  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  908  	case PIO_FONT: {
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  909  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  910  			return -EPERM;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  911  		op.op = KD_FONT_OP_SET;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  912  		op.flags = KD_FONT_FLAG_OLD | KD_FONT_FLAG_DONT_RECALC;	/* Compatibility */
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  913  		op.width = 8;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  914  		op.height = 0;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  915  		op.charcount = 256;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  916  		op.data = up;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  917  		ret = con_font_op(vc_cons[fg_console].d, &op);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  918  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  919  	}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  920  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  921  	case GIO_FONT: {
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  922  		op.op = KD_FONT_OP_GET;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  923  		op.flags = KD_FONT_FLAG_OLD;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  924  		op.width = 8;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  925  		op.height = 32;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  926  		op.charcount = 256;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  927  		op.data = up;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  928  		ret = con_font_op(vc_cons[fg_console].d, &op);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  929  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  930  	}
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  931  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  932  	case PIO_CMAP:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  933                  if (!perm)
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  934  			ret = -EPERM;
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  935  		else
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  936  	                ret = con_set_cmap(up);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  937  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  938  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  939  	case GIO_CMAP:
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  940                  ret = con_get_cmap(up);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  941  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  942  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  943  	case PIO_FONTX:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  944  	case GIO_FONTX:
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  945  		ret = do_fontx_ioctl(cmd, up, perm, &op);
9cc3c22bf017f3 drivers/char/vt_ioctl.c   Alan Cox            2008-04-30  946  		break;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  947  
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  948  	case PIO_FONTRESET:
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  949  	{
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  950  		if (!perm)
4001d7b7fc2710 drivers/tty/vt/vt_ioctl.c Alan Cox            2012-03-02  951  			return -EPERM;
^1da177e4c3f41 drivers/char/vt_ioctl.c   Linus Torvalds      2005-04-16  952  

:::::: The code at line 411 was first introduced by commit
:::::: 079c9534a96da9a85a2a2f9715851050fbfbf749 vt:tackle kbd_table

:::::: TO: Alan Cox <alan@linux.intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--AqsLC8rIMeq19msA
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICHrCG18AAy5jb25maWcAlDxbc9u20u/9FZx05kz7kFaSYyf+vvEDCIIiIpJgAFCS/cJR
ZCXV1LE8ktw2//4sAF4AElR6+tBYu4vb7mJvWOnnn34O0Ov58G1z3m83T0/fg6+7591xc949
Bl/2T7v/DyIW5EwGJKLyNyBO98+v//x+eNk9H/enbXD924ffJm+P22mw2B2fd08BPjx/2X99
hRn2h+effv4Jszym8wrjakm4oCyvJFnLuzeH4/TPt09qsrdft9vglznGvwa3v139NnljjaGi
AsTd9wY07+a5u51cTSYNIo1a+Ozq3UT/186TonzeoifW9AkSFRJZNWeSdYtYCJqnNCcdivJP
1YrxBUDgbD8Hc82sp+C0O7++dKelOZUVyZcV4rA1mlF5dzUD8mYBlhU0JcAJIYP9KXg+nNUM
7VkYRmmz3TdvfOAKlfaOw5ICAwRKpUUfkRiVqdSb8YATJmSOMnL35pfnw/Pu1zfd/sQKFZ59
iXuxpIUljRqg/sUyBXg7Q8EEXVfZp5KUxDPTCkmcVBprj8KcCVFlJGP8vkJSIpx4BpeCpDS0
x6ESlNOm1LIBWQWn18+n76fz7lsnmznJCadYi7LgLLSka6NEwlZ+DE5o4WpExDJE8w6WoDwC
8RqworBYViAuSA37Odg9PwaHL72t+hbNQGS0npgP94VBORZkSXIpLiKrkDMUYSRko8Fy/213
PPkYlTxUBYxnEcU2s3OmMBT2YXPcRXsxCZ0nFSeikjQDLXZpakYMdmOpFCckKyQskPtXbgiW
LC1zifi9R3dqmo5HzSDMYMwArC5gzSdclL/LzenP4AxbDDaw3dN5cz4Fm+328Pp83j9/7Tgn
KV5UMKBCWM9L87mlATghUSUTwjOUqoWEKLmlhKGIlF5igKvx0uZ9H1ctrzyHlEgshES2KigQ
3PwU3Q/m1Ki1gvr4JajFFEFb6xFRgcKURLYW/wsWtSYWmEMFS5HNYo7LQAz1UIIsKsANheYA
4UNF1qCxlhiFQ6En6oEUq/TQ+rJ4UO4SwNg0VRY8Y7mLyQnIVZA5DlMqpIuLUc5K7QQGwCol
KL6b3nQSUbiQMdc3ONic4VDx0EtgNi45wpptcOVQVGWh9765LG9t2sL8YVm5Rct65lgDukhg
+t51bh2W8kwxmFIay7vZxIYrBcjQ2sJPZ514aS4X4M5i0ptjemU0RWz/2D2+Pu2OwZfd5vx6
3J00uD6UB9vq3ZyzsrAuRoHmxFx+26yCC8Lz3sdqAf84lzFd1PN5xWBQ5rp7mFOjCxpZu6mB
PMqQ4xcNOAb9fSDcv1oBblH6pFAPjsiSYjJYCsb1DUI7ICznviiA4UVLgyTqplTRBPg3sE4d
rASfkwtHYyBgyIX3EHAE3sM1YqJRb5qcSD8p8BsvCgYqpJyNZNwJMYz1VdHTuOQgnIkFnB/M
DEbSlV53DZUx9SyvtAJ4raMuHlk3SH1GGUwsWMlBEl1ExqNq/mDHFAAIATCzNw6w9CFD/r1E
1drvc/UoNo5650WB8VEeUf3tYzCuGLjGjD6QKmZcBQnwT4Zy7AZzPTIBf/iDShM7trHTklQl
jaY3lkssYntmY+V9kaE7TMdMSqeciFVJANYEK96BYxNYWWZBx68mULH9jjJMdthtGQmSxsAz
x5MjiPTi0lmohOyn9xGU25qlYDa9oPMcpbGlR3pPNkAHdjZAJMZQNcExtRIFyqqSO+EIipYU
tlmzxDosTBIizqnNvoUiuc+ci9jAKvjXI5MWrbmhbo2kS0dRQLrN8v5on+uQI44cHchCEkXu
3dQ+oE5Di93xy+H4bfO83QXkr90zhCEIvANWgQhEmLa7+Jcjmg0tM8PyxmtYLBNpGRq76VwE
yPaQhMh74bc2KQp99wLmsmdGIUiEg7OqIzDHqCms8g4q8Kg46DLLRtfqCBPEI4h6fN5JJGUc
Qwqj3SMIBlJPsKS9kyofDumMpCi17wiLaWpUrGWxmyY3pKwgOafCirnUjKGSbh5RZIVXWWZF
YU1ak6wIZBRWoAWpB2UF4xIiC8uamkgIkqg4RXO4/GWhaDxpkiitawNxHl6YoYMRKp8C92Ah
tD4Vx8N2dzodjsH5+4sJgK3wpDk0ny6q6WwysQUIGRn4pWrFqSQyAcc09yW+Db90ug9JRRXJ
ULkRk588bU6ngNKAPp/Ox9etKr/YyzZjtX2lOYg/jqf2HnwU6dSrRh5SsLX/ljSiS28s6j9B
K1yuY5y7NkoUWWFvH3LS6WTiTzwfqtn1KOrKHeVMN7H80sOdAnhOBmonCvBvvIrE+pLYNAtE
giK2quaFbThwFuk6UyPMaPf59etXSJiCw0sjyHbhj2VWVGXB8qrMjd+KwCViotPVy0IgsMmW
VLkvEy15xeHZQ4O6pOhOWWxz3P6xP++2CvX2cfcC48GwWodqzs+RSHreU3MLcZyYC5wwthje
WVACXYqAfFqlOZZbUwNVFQ9CaUjKJPBK37ExEgxZGB8jupqFVFYsjivp2KRqjlQerzQAjO7c
jq5NCVEbEbCIkmAwn7p0YU3AojIlQnk4HTwo32jZ0blUCTZkh0uSWmqv2YJZcV8fuZK20659
jdmwChXaQiVmy7efN6fdY/Cn8Xcvx8OX/ZOpW3SG+hJZ35r/QLptNKusA8Q5dlqggwGRqSBs
0uOHfakNSIWPWKWCyB+K11RlfomiLpz6E496BsFxW19N/fasoXQj4z5aiUEVdi7RKK+6qjIq
BDjLLneqaKZ8ykiClIOyRBAtZSFL/SSS06yhW6jAy5ujgAOzhAEpi8CCggZ+KoldumiSmVDM
vUBThx1kPpLMwZPdX0BVcuo4wIbggfnjEZ1rGyNZ6Qoq749ehb6MQB8NOMEKO0ZRUFPZh0gD
8/um0HcJXcUgsBDhtvRfbI7nvdL0QIIRdCy0Dor0IIiuVV7kO1ImIiY6Uiugj6kD7sxub0V7
v9mnaklhDGu2R1lXB3E2B5SUmTQ4AvuhjunbXUe1uA/tHKABh7FbwnbW68orbokAiXxqFQfy
ms2ioLm+v7ZaatOrjKN+J4g0kaKwzMg4pj+Yr/xDO7jmEflnt309bz4/7fTrV6AzgrPlqUKa
x5lU9trJ/FzXpT5VkXLTTblU2fe6UGbpmZlLYE7tknQNztzIGKZUM9osH9usPkm2+3Y4fg+y
zfPm6+6b1+tCPCydVFEBwElFRCV/bhAtihQ8SiFTZkrb4u5dL8PBo+GHTiI4UWYNTJ0vRxTW
JhqWZbA+MEHdoYjfvZvc3rS8AF9tHLWTZrnFkRr6UDDmvEw9hKXfRzxcxSz1XdQH7afcsmcD
a900bLboHW5IrIryngV0AKOZpCKdhZOexxwcQ7XU8YO9gYJwlSzpMr9nynlZVCEYryRD+rGy
1ZlxtWgDbWKnVES9H86VL7N0YRFCFClJrh1qc3Xy3fnvw/FPN2htNQAv7GnNZ8gE0NyxBmv3
E1yNrAeph3TubsQNrmOe6dqB/5EKFl8QX/mOmuNb1UpTRlJPZt6pgKAx8hUkbtJdsSMqcvvR
UH+uogQXvcUUWJXf/JXJmoAj7sdrcRX0EnKuTBPJSl+mYigqWeY5cS6NuM/hkrMFJX5um4FL
SUexMfM/VtS4bln/AkosFUrGcRA8jSNpoSzUiLS749pAVzUNHS4G6qcRZWQQ4xvgaPUDCoUF
uQjJ2b0/roPV4c/5pZCipcFlaD9lNSa1wd+92b5+3m/fuLNn0bXwFnxBsjeumi5val1XT3Hx
iKoCkSkAC7g+VTQSmqvT31wS7c1F2d54hOvuIaPFzTiWpv6Sukb2FNpGCSoHLAFYdcN9gtHo
PDLVgojI+4IMRhs1vHAOZYYKleoqhzNyTTShFs04XpD5TZWufrSeJgP/gcdJeJF6J2piyEJi
y+jpjwNlMlC1zlg7DEhZtdzAhnDtzSzbUchC9fdAEhXfOxg9pEjudRYMbjIrHL8KFDFNnUe/
FtReMSfH4DQCD90SDQrP+HDcKScIodh5dxzrg+oW6dyqbQxrJPwFgfGi6j/LXyAd9NpcoE2Z
3xQNKZnwX+9cPXbkuQ5YxgjU2y3MA3ndGMUFVe62svZRNTXDS0x3/KYgo/57KQbCpMX/XZCl
fQT1HGq8n/8tTZ2y4Gx9f5EkKouLeMXKUadv0JeGc/IRIshxEmACUEEWcsm0KBLYwwVpXOJa
zda/bv53xvrNt8PYUZKasaP4jjOjJDVzx5zIzTjrWrZcOrUp+BL8vDtfYk3ryrF++Y6rOUdh
maImL2iqtj+YyDJoxdCQ2dKOMB4NQgUeCVB5NFKVAi/tMe2Qf9r2Dz6CMae+SE2hUpSTPnlW
ML8DV8iQz24++DU+nUlvi6O0HRa3Phj73/9c0Tlk+SJnzHUvNXYJW64Mm5sXMZcg475d6Bqv
jgoF6vkHBfKM0At9mMymn2z6DlrNl96VLIpsaR/X6JnzRmU0bzTHSVMnQ4aPM68cUbpwp11W
kDunRCE8A9aza+vhDRVO42eRsHzErt+kbFWg3DMjJYSoI1+/swL8Flblaf2HbjOA4CGXdu3Q
ojQWyglmEDa40VxnrB0owlYlNcqF6l1hqtvXrpnLDOmSog/W/DmCtJ8WLHiEpBeeYy84qztH
OzW2pur3C/mIdP/F6BvVUqyo9Pb8Lg2vrSJEAxmkZC0ihUsZ9sKThkaXSn2zuohBn18TFvUX
zYrUV4YxTUqJ804pxksS5vij8RJQpFegY0JFRWNUn7gcXyDHwpfRcLsjjse6t9TOiNeFE6bW
zV86/OaUeSa0KExwHjksrLhq/BP3ldvsEn5KXbJYvZCY9nm3yBScd6dz83RlZwMLOSe51wkP
RvYQdt3KkhbKOIr8Z7QbFOCDSvJdQGhXrxRg3iP4OL29um2OBoAg2v213+6C6Lj/q1e1V+RL
7LVnGrU223HoRTo+ANSnT45RiquQSpWyj1QyFVmckvX4vHM+4AseskqDqgKiF9U51sPh9+8n
HlBFBfKB/bPQmKp/7b4oBc6Ge8ku7MXgJPzv3fp6PeDvR6RaAkY4IVhcN3634hUF3D7VTfRl
s7V7QhR5Qq+m03VveVzMrqdrO77zTONuSpvhuttzJGcaKpplq/3eFEGkvOaFvxYAyAXOPGxY
UU7SXo6L47lykU5jiWFQg3je7R5PwfkQfN7BltXzxqN62ghq5zrt+NZAVBlcvbcnuqVYNRre
WY0aKwpQn9WLF9Q2P+ZzlZJIDIA0L0o5gM4Lu7dOGaDbov+5e5ZzLNXteIMtRjS29YDGbU+Z
DTOZdQ9YCic+wqRIwID6+svy2HLx8AFc2pw6kY4C5pg6OzegSmugb0qNLZHdLKWgyXAakUQp
HihBvtscg3i/e1KNd9++vT7vtzpvCX6BMb8Gj1ptrZujZpI8fn/7foIGK1B/E5zCxZEvGlaY
Ir++unJ3r0EVneEheOY5bMaX6RAyQjicVsia6wPYGK0Sx0BK60KhRg4pruIVz697kxlgvYrL
Snl7ncQjfvVfSax9+REIYiXi3hIaW4CmoDiE1H3ATZAMh28eAWsQRB2g8k4Xa4xoypwwmshE
MpY2oVxjnweut9kwxog7lcACZ5iigeoW+O12c3wMPh/3j1+1jnatUPttPXHA+k9jpWkmTUha
2Lt0wFWBZOJ8hW8psyK2jtlAqsz9HhMYxjxCKXMT54Kb2WPKsxXixHx/cHCieH/89vfmuAue
DpvH3dF6OF7pZhx7vy1IP2RG6jsbFsvXkqN2Nesg3Sjd+t8yod2pl6BtxfBodzeg6cGxvWf/
RG1WqntxVCrqvLO3zNUuldPlSLWk9bl8pHhmCFR9u54G0rsM1NJfK1FkSNznuCHWX1P0vfI2
natF2Xh8y0eRufOCbz67NqSGCbsDvYatpgNQltnurpnP/nZjMx92slnVgZeA4LVWxLbWKFRM
cmxevoktqpF7oxUzfD0NXUHG1rKXjSdUpRles2VP0XpQBlZm8NDOGTYN337RznPhy/wy6dgM
+KjlOqw0d009L5vjyTE9ahDi73UzkN2YD2CrF0qK/kIsNnDvfhUBiEJ/xcNDNWg1analN1vC
n0F2UE0+pjteHjfPpydj8NPN98H2w3QBitnbfK/9LHa/OpzDZ+9TbY+Ox1HVI+3eq0Uc+eqN
IuuvpvnFihERdn1YoLwm8W78BUfZ75xlv8dPm9MfwfaP/Uvw2PcdWlIxdU//kUQE9754rOBw
mdvvIzvbgxl07YTpPrSxnap7F6J8AeFuJJNq6k7ew84uYt/1dA3Wp1MPbOaB5RIi/rUcYlAG
DjsawsFDoSG0lDR1ocDvPmP4yLcc9L0JBVxZr25fkJzpnNq8vKhqQA3UuYem2mxV13NPvEyF
M+um/6en6UVyLxwjbAHrXl0/DrgC0eLknw/uLxnYJCmxfsvARihJakF2TcM2msX+JVXnKwK2
D/SvIZiTjOb+Dg+HDJIi3bM1Tgm5NgjBK5wfMd98/XP39OXt9vB83uyfITmEOWtb7r+CqgUx
TpGuw/nA5nsXigHOI7JLw2RPjBlOitnVYnZ902eYEHJ27X0QV8jUo8lF0uOHvY6MzIgOBp8r
ySBZM7mu3RtXYwnXDdYKO519cBfT5nemmNb3RdH+9Odb9vwWK4aP16I0YxieX3kl+GPh2KfL
IT5tGv9do5wThRthih5GMGQmK1Wjy5zHlxECsP64b1NWmrC/tj04dOvRxvZv/v4d/OLm6Wn3
FOhdfjG2BE59PDw9DTRQTxjBgVLq2aZBVJH07iNbU58ra/F1EWI4sClpjd5Dw3sIliEAu7QC
AmVC7bf0s/1p6zmd+h9k3L7jUbFgufurGR6kcX5278W/oI10hD/5Man68YnLU4ah1HbApYLQ
uFERffq0UJbtP+bfGSR9WfDNtFR6TY8mc2f8BJEMszx9fW1+PPFgW26gaoF14/M73TED0exY
xFCGPWUEQLVK9fdKRMLSqG9YNEFIwrokP5u4iytsDDFShvxvww3NPC1J6KtMtEu48aECJ/eQ
90Esb6UO0rrMzPl+MMS/ZU7lSDsRYFWfs/oxCHuCiiCe3vtRCxZ+dADRfY4y6mygVUYb5iRH
LHZ7a5nqPoCsdqliS/enBQClihb+b5hDTOp+HbEGVGj94cP7W8cdNShwAu/GpwKdgWTAfvIz
X8cYAKq8TFP1wSo7RhBL2Us++F1ZM4N6lRvOq6C62dv8DsuHPl5/C4PVY7tidY2NeDj2pRG9
6TDyjRqEIPaJ1FMSjpa+aSEk0NJRlaTuJPXLYei+brdrhUNvmy8zEojXl5fD8WxVNAE6cIga
aBoAkfS9j2qCZOW+VSpYjEJOsehDcQ8A4ebcTZ4tsJaOv5RqEcX+xwGbRPY7Spoaos2J1skM
U3wI6QXYM7A/4ipdTmaOWFF0PbteV1HB/E8YUZll9+pG+ptasLi9mol3k6mHu+AgU6Z+padS
19Uts6AiErcfJjOUur9yIdLZ7WTi+3keg5o5339qTiYBd33te1JqKMJk6ryPNXC9j9uJ9YKU
ZPjm6tpK0qL/cnYlTY7byPqv1NGOmH7mIi46+ACRlEQXtyIoidUXRbm7nrvD1Ut0ld94/v1D
AiCJJUHNzKEX5ZcEQABMZAKZCerHqfIbRB17GabpdKFM96CUa6ipIwR1j1ea7wtMHenOHWlU
iZgFamh0UXRgrb2as13Q2ScVbNTKFnKEDYdAq+JAMkVfl+SajHGaRBZ9G2ZjjFSyDcdxE7ur
YZbUNd0eu4KOyNNF4XveBp3VxjuLbFvPfz+9ygDnLzzHwOunpx9MTX6DjRTgu3thavPdRzb/
P3+H/6qK9wDmMlrXf1GuPfngs3Ic7WgsxgEBAfcmAiZrV1lCrvz6xnRktlYy1ebH8wvPK2jN
gjMT/trifm61QKe1QpQRyY4t2jmaMBEGJPhBSKvEag0PhaxbRQPtSZlDPjot10Ompsbiz4is
PSplOWNYOhvofFNxb28G8nbJBonY6p/YiP35j7u3p+/P/7jL8ndsRv2sRKPJ5YWqx9zHXtCQ
OE7aI3wHhJYdjTeZRaD1Luz/cMrg2G7kLFV7OOCRXxymcG7NN7wnccH7YZim7qsxNqDlIqPB
ViCUXPK/MYRClkcHvSp37B/rbcUjuMvhzACpFSE03fnCfTfXu9jNxjtbfXjhoeCuMnNzxPLj
tc9JZr0Box87Ztm6C7oWNfoYqU4E/cCwz0nRlpSGge4EvaPJD0Zj6tSuhTj4vm8x50Lg4VHg
RlkdP6mR/vez8X33z89vn1gRX9/R/f7u69MbM6AWjwlVovJCyDEr161lzpEVZ4erKaAPbV8+
OFrOWjHPbNagD2ZLP/z1+vbty10OEYxKK5USdrUQLqIMmIBoQZxN+Vrg0fySGZ3GKFdm3hny
akIMX4OZfp4AcWxxsw2CrWzfffv68i+T1Twd/d+nl5ffnz78effL3cvzH08fVHN6MSDxCCKp
XILOjLvgWUdjjWTXNPW2yV1uT1x1RBHwcDmcSI+3rHg4kap0pWzjMWWFwwipSQa+ubiu2jmh
8+hC4KzQceC4I31xynEN/+Bw9Gbto4VD4y8GWBNaR4LQ4YQ3kNGvZz4yPAus4+lzMeChYtL+
crkDN1XdYj5r4CYuTlmpLpPqlVEH1LJlpiWU++uIErEN1rcfn3//CxQYyr6WD5/uiJJEQ5v0
k0P/v/nIrLVCRhIrhvdcNHnbMwlOMtjjyjSXVKnADdTx/cxP1+S94Qw7Q2ymN0NJcLDPcPqJ
CXvNbUdQmMGepqhfnfKwSGSrbz3sNo58dlkN0x+fGfSRDgXPubFeodwo1bbcSIa6VqkPnUs1
q5QK8XB47fXFCcs8hLgsMgC74OK93Gtd5BCnXJuOsiY3hFUD3h9mj9glHdr2YPrqSOh4Ipei
RKEyZXb4iENwPIgiNemZcqMfzZ5r3PNWfYw9Q5pWs8zqaqQXazlQ4T2m/KilllmvB0Df0zTd
BGh5AEV4niwBsRoxrc2or7UGrcmC9LcYz1vFwDHYMPTGV8JLpmxaoZ3ekMGNFUPfNm2ND3+j
O5yV1xGCWf6TuZWGW20HhE36FttYUB7pmBEKue3QFsFSC976apkPGUk8zzNtWgsH1zwHA5j4
rhjYvr75lj3rCGFGIBjEGPQoRElNT3rAEB0Pu+Ja4Lt/ypNF8YAX2Vak31ekxweUthl4OYz4
ukEHPpG09gw1xOzebtBj03ZMxqrPgjo5VgejX+1nz6UmHtlPhlSspQO2L648eCnfG9FLgnK9
RK4kcTMDng9OKVzshCF7Y2Qs3ZNF8lQV0/lcPCDvpCMXinfHR8OZd3mUiyyQONtt5EgT21WO
zBBd50iEazzA9ZLjt9e3d6+fPz7fnehu3qwArufnj9JVG5Ap4IJ8fPoOcYjWPsulUl3x4des
GOT1UNw7sEHXXYaj05Faf6xWVx4VUjQJBM1KmrU4ZKxmJtTTUltDwO5F71VQH1zWQQws8pI4
e6Yncq8JwwpQ8lygupOlAuoWkkofHPzvH3NV1qkQ1w+LppmN2IJ79t9dPoNz/k92EM7PEAHw
+vx89/Zp4kJMwsuNCD9Mt+eRRdItGLevaI6V2pxVRe5cXzvjsGei2RNSboV+/+vNuetoRBjw
n0YsgqDt93BaWGlHjQKBaCojrkcA4tKJ+xqdfYKlJkNfjvfCWWn29XuB1I5YxIp8qIU0c+o5
oU4Hb+/T6EQpE1lFcx1/9b1gs87z+GsSpzrLb+0jUnVxRnugOLtHxOX5LZ68Lx53reEBPtGY
oOqiKE1x5U9n2iJdv7AM9zu8hofB9xy5SzWe5CZP4Dt0yZknl6GNfZxG65zV/f0O3/KYWcAt
5TYHn7OODOsz45CReOPj8fcqU7rxbwyFmOU33q1OwyC8zRPe4GESKwmj7Q2mDN82Xxi63g8c
1sXE0xSXwZF6beaB8FowiW5UJxXPGwPXVvm+pMc1t+ilxKG9kAvBN1IWrlNzc0aVDzQObgxe
ywQYvgewTJQ6uA7tKTsaCcBsznG42aaMdL4/3mjULsP3+BRR55TLTMpB+iRl5Z4oV2ZtVe0B
A0JNliz0HDeDZoas3fW46jizHPYBnu9l4ejRBA4aftUDLBbsVDJxUDtO8Gc2rl0RR2acmYuW
eXEpmxzNVjBzDXWeIX1YGqcNBnANwgB9gwukzEePMGaWmhnJlab7Lk2GDLBtv0OL5uAOz5K/
MEHMqWpVLi96KXP2A0HeH4vmeCJopfkOl2DLkJG6yNCt1aXmU79rDz3Zj/i0pJHn4yJu5oHF
/uTI8jUzjR3B/HVmvKPAYUbLITDTsdZr6sYet+Bmjj0tSYxtDorPmmeLMa5hAgoEcF7ZMGeO
bGkqV9kxjf4W15E0TEfGBbrCdr8bCG5YKkxdcSD0hLkTSiZa9CWp2DfArKmNrYRxqSsUOrce
KrKeGk+SPPE3WAyvhMG4A1nMa7Af39XER51qpHIYjt51dxoGdXN7UovHJIm3IevHblDdW2Y4
3QbRtW2YsEfBbbI8agr+zA+TNLx2l15UvrZI1Ey7WXkFrkvtikKLIVSgnH2juQM7lzt9F37q
1JJHqQ0Fvu85q8dMLjWS09m++3H4bWvX0bUXuAbNla2O8zwW3K5d4chq38OllMDhiI4nSpJD
4WxlXwynZTiQCdzROAr8FB8yvffGLvBG9sncm31+Qi29LttHXhyy2aBedTFjaZRsLPKldgw5
II5R7e9TL4L2u9KfztOib+EOPdhpxmZOTrasufjEvzDt2B+vWA+SfKzClS+Z6XhBvEXandUk
xHMtyPb05yBmHS5GmNoFcIY4mhjWC4oTpSC9//gdDt3aLKFDV5eZL/oGqaevy411/MyJZYDN
TQ4Zi5ag1dgCw6G9p8SwTxQun1uDHuTSucvk932LEpiU0LMatQ9x/VuAEeaFLKFo2nk4Pv34
yKN0y1/aO9MBSL7CskcJBPjbcYIn8I70wsLWqFW562hgl9YT1DuGY/KwFH2OEcFJ1/1sn8kH
dXK3Q6jCPNarOXEIKR+0MONWG0m5NjSKUoReiRVaHjNjfb643yEbV2IX7tPTj6cPsLtr+eoO
av7/s9KwTPgGQMRvQ8UFkKrn3zAxLLTjxaYxvoUMKdNzLQQIckVvmZweHpWyhcOokyh9z4NI
uYqx4jlb4bo4824JGYj24/PTix36IRUhHlKQqVqFBNIg8lCicuvcFO9pTrOJ04+jyCPXM2Gk
Bk0CrnLvwWa6x+u0OldrkH4VoQrVBaSoQS+vUrianp+vQcJ4BO3hetS6mFnQiniy8Ry/qEph
I7SDKzjPeqYN7WUu2o0VOoTT+yFI09HCIMZ6SRkk/Pm/fX0Hj7Dm8VnBz0Vs71LxPFMOQ9/z
kK4VCL6lIFngBasSVbckh34fgUJUBtsslZb78rxSJs2yZuysUgV5rdzMj0uajNiqL1mkUP1t
IAc5eGYhBsdU3VovyUfMw12dqdyP8Rhj4yAP7Dp6owTh3WJVzkQ90kabiX0e/L6XX30D3NPq
WnWO7ljA27Vw3rKBvF1rpS0ct4vM4KiYSR2eNChjsrFHSrWZ/p1RA6Hy3g/xDehpRnWmw90c
e6rJY/Oby4a+suIlJdgIN+acoAm85y1PbVlTqTJ+zJKlzfVANacEHkI1oCfY8s5enmFzKUFe
Qqed7R3PU3IQ63vkV/OcsGWDB1JBF7DaHdoSv+FSLbRCv+yuM9IPTquycMKzOqFkGrF9eTmn
ghSd7pFdFGmOQECJ2GPGjTtgEqflYkdwT9A4Vs6nHnEKAlWzbHESv5U+bw92S8BMbfVNoQXf
WY3QVBdxHaNa5kwUl3mWbV1gEXML25xCzEIyNp6q3sNaYoQSMso9Xj6/lMCYQ5A/jdMhaYem
CQ0Z+9PhG9lMVFaPrkwrto64NEB0Qn+iA7/0Yk4qJE7nmDVkH5Oq6WvYjyvfYoeQWm3Ugkym
V8CGDEB+9+VZL6rmZ5Ui/uyvl7fP31+e/2bNhnbwiPilMVpFpN8JZZ0VWlVFc0AnoSjfSBm3
UGvtnFSSqyHbhF5sA11GttHGdwF/I0DZwKdvdhJAfYFe+hBk4p4Q5VHjwboas67SroBf7Te9
apnLCXRrR/XMvj1RdTaQlz++/fj89unLqzYh2Ep/aHfloLcQiF22x4hEbbJR8FzZbBFBqqBl
6Jepye9Mv/sdEgnJZBU/ffn2+vbyr7vnL78/fwRfmF8k1zumGkIWi5/NuZOxN7SOSrURgBuA
eY4uXaUzQGZInd2ondwSGIq6OAfmhHAe2wJ4X9QdekUSgC0/XtSrYF3tqLy/D0ezblrWAxpc
CODsdSXv6WIC5Stb6hn0C5snbBCepJ+RZYzxhswx01qNA2kpW2E0qcbLb98+iRksC1dGWXXO
ds4T48WGE3oUAJAcOJ0fiDLC0DkYIqeY0811YYE5f4PFJbtVETy3OlSjPCFVNaMsyZGmZeeC
ko1tLDhrcd4zzzDkcRkqL8zvrryrn15llnsZW2I7cvB4MW4M6CWBvx78y0R2qV7MCTQmTnZE
XVk58TTACl89mu/gTqIh3nD6Eq13v1xz9NoyCeoZ13h2B2ZqgZ6upWwDwFJrGa2qE+9aVQ7n
PjjnopXTORbwln0iZYOpqoCCA6ue1gOozNxLSxp7gUHm1qXZQkdyE4BG6c2rkiYZoNDePzYP
dXc9PFg9QupcmyjK0oSs5Lw1+q1Y86Pdj29v3z58e5GTzZha7I/hc8T7XmYft2610biGqoiD
EffL4WWDJEA7SHXbPlL9h6YUiS1VWmLhV5z88hkChtW+gCJAQ8IMBD0VOPvp/ICboZPsIhSs
o1NdWP9DSVlVgvP4PVeL0T5RuPjWHN7CiQWR+gpqLnVzK//g99u+ffthrfvd0LF3+PbhT1sx
hYuI/ChNWentckmo9HKUjrvgTee6mkh1d3z6+JEn32PrG6/t9X9c9UB0ehp0asZamyGrVX3H
fof5SVPRm/JLSuDKs7orSzyja3qrwg/64f7UZMb2LpTE/odXIQDFcoGlSdaNDbRsFaFhEgR6
HZwOR3DaoeOEQF7tkHrpSqFwKa9h807I6Ecetpc1Mwz1frSbI46S9bQPE8ZP5fAJLznarKha
zJqBWaxtakoCT8UD2UJktp7In7PBtXvDDJkeKfsHMwpFDIJTK+R2j3WpgwrKAdYrE85x3mJu
iUxHX56+f2daM6/NUuP4c8lmHI1VUeSbM5Z3YY/NEVsqNb+IS0RU2n6Afzz9TmK1+Wh4sMbX
mwswJx+rC+7IwdGqPZTZGRNiopN2aUyT0Sq0Lpr3fpC4HqOkJlEesKnT7k7Gi9KyHU3SI83U
IwpONFda0cl1ft1L/wr9OlFs4GZDiVOf//7OpJ89oNKD1qxJUPX8SRJR79EUXX+5TlaoPcWw
E+MFDpDOFXQzUYzKwo3s0OwdSZVt1gsVJ/iY0ODw0JVZkMrZp6jeRs+JT2Wf3+jRvnzfNua3
sMu3UeLXl7PVNtuoMyZplyahs+mKVNPfSHhKWLVxYOs7h2V4qMc0NkoTDgXavLN7YdbWVnuH
CRA/3tjSKPS3vjmiYgb5JjULwzQ1X7graUt763XHnvgbNAuQKGvJWTztYNsvYBRJDoe+OIA7
i3vMarbyn9BQE+VtLv5VfPi85/x3//wsjdhFy51LZbzTvTM02KTYzU4qi3/R9iAXyLHVsTDQ
Q6l2B9IqtbX05en/ns2GCusZYmjROykmBqpdfT2T4f28yAWkTgBCbHJ5PzzG4YeuR2MHEIRG
H86QoSxgD4eeo9TQdwHO6hh0zXpsmdK5HJ0TqUmpVCBJHY1MUt/56oWZbQll8hOdSZ9OctrM
Ghps71+JmqaaB35mnbL1IJggYZ9uTyxkqYhimqHCpGteJgL/HYxDOpWnGrJgG+EOeSqfLOZG
W8yl38bmo4+FqS947vC6zdUtE8GtY8uRFxxKqKCzXfTUdfr2ikpfuWNMY+OJ8LA6ciIY1Qom
H04OYHNceLPBp31SVA9Jtorj2futsmYYzOoDv2K2i7wY93reEdhmerySbEi3mwjbH5pYskvg
+ZFa/4TAZ+QI+FFZUmwl1hgUeaHRA6xWusMMgemlGboUJqLFJ6JV0u4hSEZHZMXcDrLF/Xon
Bja2fuJtPKwCiWHfq8YSaLcyyTeZ3DVthE8nDwFAjwoStSUT4lgUlxJ5RyElDmEc+TY9Lwae
+JW3fxPrCaqVdnLP5tWKwYE5xZ5mo7PxI0wr1Di2nt06AIII7QiAEsfRv8ITsQ5em2X1Ltwk
dsVc9fT0rAMaFpirhjEdDuR0KIQI3mBpImc+6RaAVdQP7IvGVu+J4ZRR31M3T+cXz7fbrXpn
pZHuk/+8ntWr9gRJHhQIw154KomMWEg87ZxNMk9CH/PVVBg2vubjryHY1srCUPte4OPPAoR1
j84Rux/GHcE1nhAbPJXDT5TpowDbYINl3syHZPQdQOijeT4B2viOfV+NZ72tjCMO8Jo3aJZQ
DkRok5j2cqNBNGOm3mqDRkgBDVl8m6FvK7wacNJbK2MYO99uOfdUgEQ9WKE5ZSboSpmQ+TRA
Ct0nPtOl91iRAKXBHj2ZmlmiMImoXeyBZjZxCvcgeYbWNzD75zSQocBdOWXJVeSnuj+RAgUe
xUyemYMpBARpbRIHaIF8Z8yRTmxiOpbH2A/X5025qwnqgaIwdMWItaEcUlwmTwy/ZY60PBMD
U8V6P1idHXCTDjkUds8IUR+5AERISEB3UzFB/aRKBbeosAA3ED9a++6AI/DRz5pDqFWicTje
chPEiBQRACrBQeXwV4UWcMRejNTHEX/rAOIUB7bIMPANHXEogLWQYTemLCQRXhd1nCPEGxvH
G1fVceyI5td4ttjmrv4CW2Rc6qwLHSvrkMVo7MWyMGTjiIx0HYcYFVtbGDVEZ2CdrK3oDMY+
pDpJ8cJQi0WB0fam+LdR35AuVY1qmgqMjjOjY3q1AkdBiCpPHNrgZqHOs9alXZYmIfbhArAJ
kO5uhkzsmJV0aHsEzwb2ASJdC0CSIB8zA5hxiXYPQFtvbTY2XVYn2HzkG+lbZSXvai1x9MyH
k0G5C3D1Z1dU126P+zzPq9Q12+87pNyyod2pv5Yd7ShWeNmHUeBI46DwpF681itl39Fo46Hf
d0mrOGUKxuq0C5jNiqrOfPFJ1pR2xhGmvktoezE6m4Xc9tbfmzEFniGPUZbIteAwaZiufQ7A
stls0LUVbNw4XXvzbizYqoRn6+/oxtsE6woIY4rCOFm3S05ZvsXDG1WOwAwYEdCYd4W/usS/
r2IRbGK+26UGDc8G6HHABpuR8eWFAeHfKw1geIYp9XXBlmJEHhVMW954iLxhQOA7gBg2w9DW
1TTbJPXacj6x4AJdoLtwdV2m2TGKxxEcj+sW61PAMeHLgTBGgGGgSYT0G63rOMatuDzzgzRP
b1jgNEkDdH3lULJq47GOTjFjqmyI8LdA6JgsZ/QwcGkryZogHI51FuFfZN353tqXwBmQ6cPp
aI8wZHNDhAHLDenOWCJ/TSk4D37gI716ScMkCQ84kPo51mSAtv6akc05ghwvdYuqcRxZE7OM
oWKCeEDWRwHFRkbLBWSfxRGLrtBZiuMeKXo6G5Z0rsUQbetBkuCGiqGkjujviamoi/5QNBAS
Ko8+rnlRkcdrrdwzNjEbW3ATWb1icaLB3WKQJeM69KWuJEwcebEnp2q4Hlq4vKHorpcSTQyE
8e9J2YtLdm+VzO9R5qlkVoq2ikTwuYlYjcAA/rP8L/TDUDlX2wSXGy+DOhG5b5tFXgbxJCKL
sbaB+xDapMmXYeLEDoOWECGDYkX0z0DTXshje8KdQGcuER3Fw2CuRQMzBft+Z3bI58X9B1nB
y7ycYe6SNW33/j9lV9bcNpKk/wqfJnpid6NxHw/9AAIgCROXAZCC/MLgynRbsZLoleSZ9vz6
ySxcdWRRuw+ypfwSWXdVZh2Zd+f3h+9fr3+u6tfL++Pz5frzfbW9/uPy+nLl70fMH9dNOkrG
1iGKKjLAUMz/eP6IqZRid+n4anz1davkHD/fr0f5YoF1rv3aatORz70EgEuKyNDoAUPtEcOV
ldtkfPq5gxUw6+JI8nqdll8ML5w59SeSVP7HR6vUxzPPlyxjXixupDB5uVBLMd6pI5DkjiA2
pdt5ZkAguM9h93Qp5oF4K4voq0UVOznfUJHhntPpLuFD7sIgiixTJLbo6qhq22wtvIlvBa9c
yDRGZ9cc363jIiLkIJkXxNiGgDGk/2uGTymhx+W4KEVpfD5khA/ZwS7Af/v58sCidWsD5m4S
6akRUqajaKGVkN7aPrnbN4HiHhy2zXC5j9yQZR9FnRX4hhoTFjHm5wmfP8QVGS535tnlMe/W
DQGoEDc0eEWUUbl7cbwU5r6HosnRrxAp8NmixucylhinCps+ysbPEXYt7UMMjkVyEKOy0Gen
E+xRmvEM2mJxh8N1kbaNuhRvr0tHHKwOYhOGc08SxR1vHhD2yRlQW54VirRd5oF6zapyAcCg
hLWizWJBWUUqyKRfqaGswYmkKH+YGeRGDYK6oKNQLKhLfuRpvDcMXaU3Hden7MgRVi6JL3Ty
rsMC8/cmF6qozc/0wKGskREOQsNXZOEtGYIYUpzirQFG7sDEpbe+JzikN2MZnJYby1wXdPdP
v7CXr5pINTihySiH4UIiloC73LGM48k/FxjY1M2iCVaiMWMKnWtovMUyOHY7N9C1Bj4NCMT8
jYuqSGzTmJi328zxvZ4CClfcK5mJ+sv+jGV/H0AHpre8Bhnkq5xo3buGIWUkWqMPFJo4xFsX
RYMRTQaqRky6yoa0Dt+A2bbbn7o2lo5dEc9rO9SOAryuEwSKwJy5ZxPE1FFeRKRJWbeeabjC
weZwCYW8/zxA4n1/liqjB1SIygUOpZl6utCiFoBd51bSGADXowx8Tp4yrBk98KibQDMcmsp8
NtJvr2gzEx2TcmSBOdoWenJ3lzuGbeifxgKDZzgqAyf3Ljct3yaVkLyw3RujuYttNwi19TFd
bxdFVvGujLbkgzumechX+jkipY9M0C2NIm4dP7eoXTZW/sI1xcObiUp23QFU1wJGCxSaYxgK
TdjEWWhU8UbkVumQxTVu9i6WN135m2pXgG7om0GvjJUJA4WMdjcuCrCondhhOmOmijQvj4/H
xKzGSUh7TZwMtbmj8n4YdLr+YkKNfjE5e212lSmFAVyATdajk60q74Q7EwsDeis5DP5/2kOR
ktJxx4dt+NzkAm1qC3MLXx0LiCZJ4NEKr8iluUPLMSWuzXdTDhmsEU0O2Ep1W7L0NpFDJguD
EDyZKjdFE72TB0ez5qaIWe0nJABmkWNdYjHJPhKVru26Li1aq2BwjlqZyn8z9YHl6Nqa1sna
PLQ1ryoFLs/yzdv9A6Z8j3/vxSGgQvhkFTDEorPGrgLTNoLIRL67Ellcl05d1F44ZFigNBkD
0PMpTWPhQQvG5U0NAVKsFwENPIeKgyHx8DcXREgwSyTIIiuCQS45Ahnka7r/aNp8mFnJ0pHr
gtTaZKZQnwcf71B8LCKw6PYYrWzF2azA4ZO2h8gThHQVxrUJyieN1a5jeppk6yDQhMYQmUjF
kmf57IcW3V3AoKQnJ8q849DN4UuqCxLGsR2DwPBuz4+MJyBzx6BQM1DqO9rry8LBniehD4gP
+Jjx+BHPYE3eLAlqM1QxWquoI4OsZYRaugFatwh8jxzJbb7FCG1knSn6EgeBUWp4EV2dAAYW
rT3NPHhJw/RssiNTZpyIWvYHPWGw0SxbJ340+zRYSFYHw0x9lkfrT5NltOU+zjJUm1a8ZNUJ
KLPJboo/ip4mFoB760thDq1wyXsfDboeEjYQ8ox8wdjEk2983nUVhr+MCaf5DW7WaOgeSf90
pOW0VXlPA1F5T/nrH85iaxIpQI/erxMOm4sNaF/MXxEVAAzZ8EqE+raJi4L6eGmcePR+SL77
UvakkFJWXbbJBK+DGNeOYaIv1YWOD/toj5UDz4irH48AWC3oIYI210bGddIcmTu6Ns1TMbjM
6KTi6+N5sqXef/3gvV2POY0K9Di7ZEZAh3g9p+6oY0A/qR0YTnqOJsIIkRqwTRodNHmv0OHs
0SJfh7N7B6XIXFU8XF+JQHbHLElZFEulfSv2KERwAZoc16rtqgpniR4fv16uTv748vOvKUig
nOrRybn5cKGJ5wwcHVs9hVbnzycGOEqOsw08d5UBGizgIitZ0MVyqwmqxRLY5FG7wzh+pxh+
owbJwHZXTm9mx1qgSivU/ezvTKkLubqxlvWNAfPr5wO2/1AJg5+jp8v57YI5ZQ3//fzO/BJd
mDejr2oWmsv//ry8va+iYUsm7eu0yTAQcJTz7vK0WR+Do//5+H5+WnVHrkhzbWJPKegIhggJ
Ec8Zb9RDG0Y1xuH8w/R4KLkvIzyWYy0oBqZFlDm9bFPmuuiUs1j05Ak0Mh/ylOslc8h2pSD8
BCKfuA6Des7rL5GOO/j8SeTgKFGkLZy8l4Fl0EvAJMIUVWAmpEsj1/c0IRyGZKLI9w2PCvs7
idiA3WPJ2Ru2VKVhtj5sLGmJWOjEaGb0Ii0q/hb2giTF0LOzLSmviPK8oieCrhYHupMv9TfG
ENUNcsyPhQ/cCT6uq8jilmzgxK1HMQU2P6vIkP2sUIuUDe9ApYmLkXE9paYhjgPHDvMA7Dmq
CCgrXRMjjrqCtOsqria8f6CBdH55eHx6Or/+Iq4jDEtn10ViYKchNVRexC1eJjX6+fXxCsvW
wxUdqPzn6sfr9eHy9oYO3dAF2/PjX0Iag6zuGB0S8fBuBJLId2z6xGvmCEEzvcWRYghLV1/x
jEHcORmAoq1tWukd8Li1bfHi6kR3bfKRyALnthXJPafLj7ZlRFls2WtV6CGJTFvz4G7gABXd
J5/7LDD/aGrsNLXlt0Xdy3SmJK+7zWnA5o70f2tf1hWapJ0Z5RaHmcwbfE/NkgX2RevgRUgF
Bj0BH5HeqJKBg9pjWXAnUAqPZM9wNGQcxRQUiC/PBODmyF93gak0DBBF7wEz2aPDsQ74vjUk
/2Ryp84DD4rh3eLBdYY+beJxpdrY9iaMV2Icj8jNauiOtWs6qlQk87dhZrIvPNYfyXdWoLZc
dxcKjiE4qkdRTSW5Y93bFpskuK6JPf4sDAiin/umr5Qp7i03cASnY1Jn51K5vNyQLbq14ADy
WQ43KnyliAPZpci2o1QeI4cEObSDcK2Q90Egbi2Mlb1rA0ve8RNqZC49VyOPzzDt/OPyfHl5
X6Fvb2JuONSJ5xg2ebrAcwS22giq+GVp+31gebgCD8x7eMQ35UCZ4HzX2rXK5KmVMHhRS5rV
+88XUNAlsaip4GMsc3xDNzktk/iHpf3x7eECq/rL5frzbfX98vRDlTfXv28bxIgtXMsPb02t
uvPdsfgYTrLOEsOi1RF9BoemPD9fXs/wzQusLGqAq7FP1V1WooGdK4tXkUV1TSG7zKVm1ayA
iqU1b46B3jVfGFx6v3dhIF/WLHCoDEmg2urSgFTxgG+gV0fLc/SzNsJuSH92cxVlDPRp3szg
39TBqqPrfcxwOwlgoM6EJhhfd8sVhR+p8xyjktXneuQrmwn2Lf5B2Ez1LWJiA/rttvDJnPm+
Qyii1TEAZeCGsNBzCGEhWSWmHfBB6cblrfU8yyGmgS4sDIPaT+ZwW1mFkWyaJimvlvanVY7O
0Dz6WjhMkzqam/GjYSotxchkVo+myt02hm3Usa1UYFlVpWFOkDJrFlVO7jQxuPnkOiVRK627
9yL9SsVgZaUFqpPGW1Vzd/fuOtrQc6KadtoF6Z46j5ikxb5dCIskPTmzeTsHmmpITpqBG1BW
VrT37RtmS3IX+ibRM4EeGP7pKAd4HzMp5ITlbfN0fvuuXUsSPE0l1kG8ckaeMM2w53h87YjJ
zJ5Rby3C29b0Rj8wnCtSdVUcLHbEoiHgBicp7hMrCIwhekFzVDd1hc+kLehDuYT+iX++vV+f
H/91wT00plkoWwKMH0OG1PzrCh4Dq9wUAy1KaCAsdgrIa8yqXP7Wh4SGQeBrQLa7pvuSgZov
izYzDM2HRWcZ0jU1CdVdvJbZyMuwIpPledpcmOJFTB793Jn0rVeeqY8tQ3yWLKIu/UReZHKE
42Mhh30OEniHTSrqE2dIIx47ThuQvnwFNlSPxbfZauchz155tk1sCKuHglk3MPuDxMlXIBxb
OlYhKWMTg4r5USsUQdC0HkhRT5qGjByiUNud28wyXc0wyLrQtLVdvYG5nX5mKTW0bZgN9d5Y
6LGFmZhQnY6mqhm+hjIKcXSpmYuf0t4uq+S4Xm1ery/v8MkciYNd2Hx7B2P+/Pp19dvb+R1M
k8f3y99X3zhW4aCi7dZGEFL3qUbUkwKMDuSjERp/kZU04xrHdCPumeZtAR7tAIqdysAg4x8J
MVoQJK09vMqn6uKBhdD4jxUsGmCrvmOER7FWOFlJ0+9F6dNsHVtJIiLYz3g3VCwvZRA4vkUR
5+wB6b9abRNx38W95Zj8Ls5M5G+CsBQ627TkpvqSQ/vZlMa9oKFUJHdnOpaUIjapxV8GnLqH
MFHOnKEsc2hxlTOUP8dV0whstf4Ng78vOLFa/EKIxGPamn0ofz+O+8RUsjtAQy2rqYL8XuaP
RDcoSyN5FNGXW2RoO2rym/qT3Le7FlY0KUXo7EpRMNRDJN6WWypPdMcx98Fu9Zt2SIhDsgaF
RJtrBHul+Javzh0Dmd79n3ufTa0u49CUBmAOxnRgUt3FkTJU9p3aW2HQuNJIxUFhu1JfSLI1
VnixpsmxXEwAfAS05RwZdEfRAIdqXx3KJY3CaBMactdNY6WP4mizPaI7grptGfStlpnBMTX3
XpCj6XIrIH0vLagyMbGJk9JgWBMkJqyueIpeJXKvYtYBP43G4+yunUJxSgjkATTUpUX2HHlm
HaY0f0o06lpIs7y+vn9fRWBBPj6cX37fX18v55dVtwym32O25iTdUZsz6JKWIV7gR3LVuOjH
RVM5iApX9pC4jsG8M5XRlm+TzrbJSEMcLK1fI9WLZDK0mNypcLQa0mQfHQLXsijaCSqDpB+d
nBDMlNchBEyb3J6r+E9DuVVhMAWGOhWx+dIyWmViZKmJq/PfPs6COOnG+NZaP80xdcARr+YL
F1i4ZFbXl6dfox74e53nclpA0rTvsLhB8WH+J9c9BoXzcGrTeLpZMxn+q2/X10FbUZQkO+zv
P0l9pFzvLLk7IS1UaLXcSowmdRt8WeHI/ZMR5a8Hoi23MdrnlLU1dOg22OZK5wdirwzJqFuD
iqlx+DnOHJ7nUu7LWO56yzVcqe8zA8ciOibO6JrXgQjvqubQ2tQuG/u4javOSsWkdmmesuiU
Q9+5Pj9fX1YZdN3Xb+eHy+q3tHQNyzL/zt+rUna/pvnXCEM5x21NH4/oDBaWje56fXrDkHXQ
1S5P1x+rl8s/9SMqORTF/WmTkunoroAwIdvX84/vjw9v6jXDhI8oC3+wo55Tss4oaitEHUV6
UsP81U9xoOn2QjbmO73Q6AIzQ5vmGznOI8e0L9ox3LGYOaRv1gskSN6wm4mzJyNtDjBo9gns
0uS0yZoCo4xqcgFFFi4NIG2bFifmgESTOx2G37U7vPQ0o3O8r/GwdAWTD73hiAKGINygRnmi
4OFuWi7EaJroGPsUt9dC/rKEArpKGC1dhgaNoCnU/VhW/AqsfSFSNM/Kcx63qdQXj1B3IqWJ
owZd5OySQumLDMuPCXlzrJnCv5+29UGUWUdlms/q1OPbj6fzr1V9frk8SUVhjKcIRaVNC91J
jGzIsbSH9vTFMLpTV7i1eypBxXZD0gSdv1lX6WmX4Vsoyw8TIoeMozuahnl3KE5l7tFpyxVA
sAy7vTdzk+ZZEp32ie12Jh+eY+HYpFmflac95OeUFdY64u9vCGz36MBscw/rr+UkmeVFtkGW
L8uzLt3Df6FtkbJmhiwMAjOmy5+VZZVjuHXDD7/EtDeZhftTkp3yDrJWpIa8LUqw77Nym2Rt
jY7s9okR+okmjBLXHmmUYK7zbg8p7GzT8e5uVj33AeRol4DiHlK10UZFe4CazZNQCs3CyQJ4
DabcZ/L1m8i3dVzxFd8C4yuOMg/A7trlJn2cxzFXxwjzzzq9bguM4gYbjr4NtXBXeVak/SmP
E/y1PEAPpHxGcR80WYthXHanqkM3NGFEVWXVJvgDXbmz3MA/uXbXUnzwb9RWZRafjsfeNDaG
7ZSCkTlzNlFbr9OmucfgxNUh3rVxk6YlXb1NdJ9kMKabwvPN8KP65bjV6zYqdxXvWfk/7QzX
L1HVJc1U7oNyXZ2aNYyJxNZ0q6nrtV5ieslHWVi4U3sXaQwCituzPxm9odEC6Q+K/0dmgiAy
TvCn41rphjwXpz+LIl21pNm+Ojn23XFjkjfdF072Bin/DD2uMdue38JXmFrD9o9+cvcBk2N3
Zp6Kzmj4Kb+Dhs16MOR9X3Mir+EOQur1O8eMt0ujuHcsJ9rXmuRHHtdzoz3lcmxh7Wq8CGxY
QQfdlizyyOHYRZdGeo56a5qahuqaQ34/rsr+6e5zv/1onThmLSiPVY+jLrTo04KZGWalOoXO
0te14bqx5QvnwZKGwX++brKEdwbBrf0TIigpi/myfn38+qcYwhE/jpMSo7ZQbl8YvINm7kA8
qpDyMj+tc0AqWRwsuS5R0zgp19R5oyHdRhgvCT0wJ3WPT6i36WkduMbRPm3uxOTKu5y3MngE
VNK6K23HU6baJkrSU90GnqowzJC6NoJiDD9ZQAe7GTiy0LAk9RiJQ7wBgYi6FNly3S4rMYBm
7NlQVaZhSZ92VbvL1tF4oVZ0/U7g1IUpgi2QEoH1Z1M7pqGQ29Jzoa4DRY/ET+rEtFrDpG9x
IdPwCg+miKjsPVtz3Utm9APSGcdke+A1VNeURjQHqHaXxhIYyfINZWUIquNHlJN2ZXTMdNNf
1MT1VrIlir5VCBvhBUCXlfcI7PrAdn3Kv97EgXquZbnUxwjZZPA0nsPhj4smoMhgbrU/d5TY
Jq2jmnzeOnHAguCKPYZDfNvVbJHjbIGTwf1Hyhq+dWMPxj4fsmY/u97dvJ6fL6v//vntG1id
iWxmgu0fFwmGH1qKCzT2QPaeJ/H5nqx8ZvMT2UKh8LPJ8ryB6U+QjEBc1ffweaQAYMNt0zWY
KgLS3re0LARIWQjwspacQ66qJs225SktkyyiQnROKQoPvDb4Km8DWmmanHgfp0DHsJx5tt2J
ecMYo+POhCgGTV/MFjT+lmyj7+fXr/88vxKOUeHrwzFtI6lE6IgZH7BRxjsWxkwkv5hIlJ3v
Ye2vi9O27xxXoxkDyxRXkE5pdLskiS1S1IiqgvaEhnlRbGoBbfE4hw6mS/ZtVqPr88P/PD3+
+f199bcVmDzTA+JlD29OAg0i9jB2fEVOFG1uYYFxqc8F36Zl2vA+QheoFgNSL8DoOoYs/8LF
/G3cSS65Cb7BecHNQkQJujUxqEwySHQ2xZVg9FpyW7jqrmoBmRcjg44mK/CEVObyOnBFHxgC
5pMxVBYWyiMF13I6j1BcGkfXMvyc9vG5sK0TzzQojYOrpCbu47KkCjm6UyPLnya8MvxBF5++
Z3cr6dloXP/HXf2Xt+sTTDrj+j5MPsSmN9tIhz/air/1KJDh//xQlO0fgUHjTXXX/mG589TR
REW6Pmw2eJdClkyAY3jZU93AJN8IsZop7qbq9PvXtPhxpu+ifVod5cPr6XTido1xM0y1rUgJ
ytHCVOa2OpRiWI1SGPesxXaw9irNsxOCr2bJEha5a8Cu6oQXrIA3EbWjdlDELBPbcNT34/KA
Z4uYByKGK34RObh3QtY5g+PmQE1TDKtrcXuYEQ+wylNHlayUab7PSvmTeIfbSNosgH0Ff1F6
FUOrwzZqZJFFhN7yb8hk9/N0Iu9rWKX/zdizNbXR8/xXmF4978zTryQEChe92FMSlz1h7yaB
mx0KKc0UApOEedv313+SvQcf5LQ3pZHk49qyJMuSMGcWPsGsyLnKYtHLdR2s0fOeI3mCFzY2
LE3gdLC7mtxdJ77BzZIsZDy2i8ymnLIwSFQKImZRW52HFqSJzoLeOl9vGaRVQbmrIHLBkqW0
DTr9ueX+nYsEDJMBeGplVWJ262sQ8sBuolqyfE7KgWp8uQA5rTKyHAM8jbqs6zowiW1AXiwK
CwYKHW4MGoo/zNcJPWY6JWcB8bzOwhT0j3hsUWk0s6vJqbFwELicJ0nqrieQnFmUwcdObHiK
opwNvJURRkwocE+5hp39wyJeYIoL7yfN0KzCvSs3q9OKdWvOKJhXdCwyxBW8Sq49NYIChdlW
YH0b+0ED07MqyyZVkN7mK7svJXAWPJN9/SnTIJd2woi+cJI0eLr5WKQI8D7HbrY1tXqrlImP
QdnzTYWokiAzPySAYIkA70+srQ8NlanND3jGTMAMTfeBYJp+1oOcdSfgNK++FrdmvTrUKVKx
ReFsadDc6ATPEjuHDW0NsprzWlRZAIPV9rQOVQ0bzdR4eDaloORhyfIYy4rK4YQrlmfUxQvi
7hJemIPvIET7d7cxHKJHmKPKT9XM69B3zqal8S6XOtX7O3VT3OgbQhvTnFkrXbv5Nop1CB3Y
yxwCNNl5xBrUjUEIU/r5MBOIJ2JsIRhjG1Wc0eseCeq0ZE1Y03sNCeC/uS+LCuJlrpx5IJp5
FFutO3IZwnBkmmDUw8sfv/ebB5ji9P634STT15gXpWxxFSWMdgpBrMzks/CNqArmi8LuWz/5
R/phNRLEs4Rm1NVtadsHtYIchWixZJVH/ssyyuydgWhTschgah1MObk4U52tX153v8Vh8/CT
itvSlq1zEUxBDUgwyvOwoDJR8qIJMY2XDuwhTgvz1/0Bpf7OxcnJ6ZQnS1yL2vbFX8poQMGa
7uAcTnPEhRzVvRwkxWa+RP+gfJa44j+aApwxy/Kggo+Md2UKmp+djs/1S1wFFmcXVlYdBcdM
lvT9oepklF2ckYHFB7T+vlaNmp+eomPmxIIn6QhUa9MnXSJkpPtTp3MSTF3Ld1gr+3UPvhpT
B2qPPjVjM0h4GQVX557YO5LAwzZUpZjfwR4tAs+J/mFOIvp6ccAf+SKIvzjSTzSfkFe1HdYI
19wBDUPRMCHnKxpqpYDqUUbwagntQuiDbl4LZzLgaBuNJ+LU895e1esJUiuRfcjOI0s4Hl96
3hKo0Vdn56T7p8S2cYudnldRgMFU/dVWaXR+NVrRwbdV1W1MZm/TdtKbflOc/7KA11U8vtAj
J0soE2ejaXo2unKXe4sar1zn4oHjSLfeb8+b7c9/Rv+RBwqfhSetcfJ9i55uhCxx8s8gf/3H
4lkhSqWZ0xuVU8U7D+kKPrM1Nozr79aD5/9tRamK6pvItCpD3lyCc1AWvR47/mxvci1kr9GR
WXY2mvQu0zhl1W7z9ORycRRoZoa5TgfLxIvcgyvg7JgXlbs0W3zMxPWR9dlSZRUlQhsk8wRE
8zAJKk9HiKsRAx+VtbeTQQSyPasoPdCgIxhOP842OaP8pHK+N28HfFaxPzmoSR/Wa74+fN88
H9Az83X7ffN08g9+m8P97ml9sBdr/w14kAu8d/MNTwZj9SDLINcvCgxcnlRG9FKrIFr0cg/W
iSAXRFGCGQDRA5C2WzH4N2dhkNP6Kq8ib+TQGPPOydi7mvGqh7nRSzXcghbpgMK9pcSgikk+
M24pEdbn+QAZKQc11cTqOXADjL0bgHg3izPdj23ZBCuG1IbtaSrSJsGe0NOFbh8M0J4glfKq
Zo4ETTbLKI/sgcLoSiyTK1qR8ls4UYuYNqWqop+56Hmz3h4MhSIQt3nUVKvGNx6A247jXX1h
PXVju8r6ppYDb91SexoAVJMVi6S9WD5G1jmyezxxFREwntIi6PwTzF73379etU45+vXHZPJZ
D47PMpyuiDG8FNToqtHFte7iUwZcRnQuW+/nHqwcHSVyyIjbgnkh5+zcBCvpHnQVIYxcNmXr
tlxUPe7Dh2Ea8NEAXlyGmOmZMk7pBMaBpiGk9kGUtYbVltA0cZ3hwg9YhXyBNwSM35iIGN3z
KUTJa2EIfbiTj0QvVf7ndgGoKEvymlwoi7gkI8nIPKesqFI9NpsEcmYmB1dQu4E2sNjD7nX/
+v1wMv/9tt59XJw8yeDDun2kD/F1nFSzit2GpiAMojGwPMobsruG16k7WFMyMkXdHC8Wo1TT
deEHvu9Ii+K61i4cO0LMPQyLWQ+dLsWjtpJhRfVQ4vJ5oAL0XMSU5VGrwM0iaSKvJpfnJK7L
UUj1SrBz2uHHojkf+SsYUSHLTJLJxF+cfPuskURxlHw+pYeNOCO1jI6TL8BAjiKxTgIMDafc
EVz4IqJbGnI9ubg2Gnlm7tD5EqTuHI0pzv6Jnl8ffp6I1/edkf93MPvgLQG6P8Jiri4mtB2L
rKS34wQsDQtDvenjG2fzmvganYSgSpnVyOjH2jkBQ681Y6R6J7be4mPeE4k8Ke9BbpQveIXL
E/5EqsLGrl9eD2uMK0vNEE/QtgyHCu2lRxRWlb697J+I+N8lCEbD+ORPyfdtmBRcZqir+TEI
sLEa/+56aPREY3p49b1k5hMydecMY/1H/N4f1i8nxfYk+rF5+8/JHtXM7zCXsWlsDV6eX58A
LF4jY/q6d1QEWpWDCteP3mIuVnkb7V7vHx9eX3zlSLwkyFflp+luvd4/3MMCuHndsRtfJX8i
VQrO/2UrXwUOTiJv3u+foWvevpP4XhYsQLTsfUhWm+fN9pdTUUvbJoZfRDW5ZKnC/cXEX316
bavjq8jFlCc3xEZPVlU0aITJrwMofK3K4Zp0FTEoBAEcPYYhssV4rH8tFo6sszM9P9oAd7Ju
DShP2q+WoKxyMxBwC+cV5hILHLjIzo38WC24u0awzO2Fx2GCkcM0ThH4gQabqSHEINDR9Ays
li7dNulpVKiSTavMrlom0yY9yhArLY9SYlDXWPxGvrt03WYAg8eNoTdDe4xSu4qs1BX3go+u
m7L1XeguvuyG+nbKILpuQuN6M+EM2mJlEVWm7yRPRFJpaTIcjljOb+HM+LaXG2MYTOur0wB6
aEYDtm8FDHQY4XPTPMBlMW5LDhMNZdDRIo+Spio4T3JKqdWp4iM1iCBd0K52SIXfmWWry+zG
vsDSiDIQOFJqGIgsV0EzvsxBwRb6dzJQOEq7f1lQlvMiB2Uszi4uyKdeSFZESQpaGXy2ODFu
T82v0RdBP5Eo0AS0LDKcqeFnk5b0ZRoP3PASwfZx97p5HD53kMe8MHMttKAmZHmMoYvs6rvj
rK2qN0EEmuiTLzL9TbH82W9vE1hmrBGx7jnQJYVNUETJuv03X54cdvcPm+2TuwOFubfhJ6rM
VdGEgSC34UCB3tqadIYI6W5ogkCw4G2y18K0XWjY3qBJNKjsPqYHXQdrZhV91dkTiD8RZIKS
Snt0WTF9sRFT2RWZljPtEGjF2hJXgZ3m3EZJEXnAY0VNNuM9obSjE/j2ZKeRLEompy1uMLB1
2CyI5qvCl19bktnvg9rewOme3Gmvh2w5o+Qya1hdpuSrDFk1T2ZM92cqpjRcAuNp6kKaYGqY
sKfkgzHptAQdWQ1hCmSEubfn9S8qVgam/wni2eersXEx24LFaHJKRm+s7es3hPRqmZ6X2Wq4
Z1ZZU5QaqxJMV4bwF55dViMiZZltuQCQ0ggwx55nWfNIvY4zteY69yZJK0RFsjFLdlMvKjYg
IytWbEbFD/B1fpXAh0JLnaDXhkAVT+fZIDONG1OwaUHNKqgqqhLAn7lFzmTDhcBHXVFKjrOj
EklUc/oCBEgmjc6IW8BQs9Xs5G8qtPJtfw1j44zE364oN0xZFkawmY183AzmFzB6T3sgkOqO
Fz0cdVq8kjAEU60qd8KHHkoCErXyo2ZTMfbhiugIMqy4v9acpW7RbrLG3aQMfANBeBd+tIQa
u1Puj0uqo6JWgEkkv8qxPsgLNZZ/VcnJNIbYNgGbXjo5k8j0rqA6n97RFykd/k6QV5Fardx4
MSBMScbaF/2SR+uNuYkURHkANeb7L5YmDYItI3EGohZ6GdwaFPQGAemX35bWtOlgONpm5qoQ
GC6F3rJTYT/Si20AUwDnSnwauNcwLeqmLipNepA/8TpSGnYk154GkXHclhzALeEy4Dk9fIW3
OIwCVnCQa7BpVjWLkQ0YW6WiSvuUmDFzKkyOqGAGaFqjP70xwRGAvNcNFi0+BMFH3VNXJo/u
H34YryqFxQpbgNzhwgXPmaiKGdcl6A5lTVkHLkLcgU3KdLukROE6FBTMvY3VcH0PaFOrGp8a
a/wRRPpP8SKWh+xwxnaLThRXoD5Zk/e1SFlCSdV3QK9/pDqedkW7xukG1R1lIT5Ng+pTssJ/
QS01uzRsUwGUPla9mDpsVzs7jyDziuD/nVByrGdKe9+v3x9fT75TkygPQX1aJODalN8lDD1k
9L0ggWWAd4pFzlToAR0VzVka80RjQdcJz/WmLB2vykrzU0rAHw4cReMTjUBpnMZNxEHPMm6X
8M9wMnZqtTtN+kWBUHfR0OkqyahjC5jXsuDXOpWmwFosAn/rvEb+Nqx0CmIPXEdOvrxY5JOG
duvjeL2b+xaX7Jrcol48MjT1OByYPzn4lgi/MeiRQGSOLWYiCOHcquOScq4GEurgBT4BujIm
WNUDrOLZZ//E2TAa7D2susVW57yM7N/NTAh9Fluo344YJeWclloiNjWqwt+KDVP+oxKLKTqX
cNhJaambYINvItUyCfAWDb3Cac1eUtUlvhfz431bRCJdht1DabfFAY8WkBKfZ9GLSxH+Rf+O
rcCoiAMfawz8kvFVSX+pXPffgR+d+9aXD5v96+Xl+dXHkeYBgQQYQEWyuskZ7W9pEH3+KyIy
BYtBcqnb3i2MoTBZuL+o+LOv4otTf8UX1NW2RTL2VnzmxUy8mHMv5sKLufIO4IoMMG+SnPvH
f+XxzTaJJnTSMrOTZF4yJAEZBRdgc+kZ3mh8pIOApNk/Ukl3Iy+2a9dfvqOgmJmOtz5zB57Y
ve4QvsXa4S/o+j7T4CsaPPL0ajTxwM/t7l4X7LKh+GePrO0i6GMH8mRAv5vqKKIkrUiz80AA
ylDNC6r6iBdBRQcX6UluOUtT88Vrh5sFSXq0bXxBd21OEYIZdDow3433qLxmlPRtTIh6buWU
rWp+TYf8QIq6mhp+N3FK3eDVuUzKrIn5CtDkBc+ClN2pyDWd75+mwhbN8kYXBw3DnvILWD+8
7zaH366nIh5/et/wd59r3n+uYZAEUIfgA2MJdAvz6AZKcU9i/zkLiCaeY4QW9ZDZTyU1cha5
VJ0I1Jpu0KdOyLvBijPTeHrEvtehdFlX+nnJ4MM5DAFtBBhLR0o/UWAoDg7REVQzhQrQ71uT
6TD8QiQpMA6FHcyXRKOX8/zLh0/7b5vtp/f9evfy+rj+qGLnfugNHq1/9zA3ge5RLbIvH9BH
6PH1v9t/f9+/3P/7/Hr/+LbZ/ru//76G2dk8/rvZHtZPuHr+/fb2/YNaUNfr3Xb9LOPwrLd4
wzIsLO1N2Mlmuzls7p83/7tHrKYAg9qFg4qu4aPqHssSIa08MMOmc7pFgXcbJoEWq5psvEP7
+977UtjbpRc5cTEX3f1EtPv9dsD0rLv1ELV4GKQiRoNVoN/6GOCxC0+CmAS6pOI6YuVcXycW
wi0yN16ha0CXlOczCkYS9nKo03FvTwJf56/LkqBGm6kLBo4M4oNbRws3RM0WVdP3GWbBXumT
XtZO9bPpaHyZ1amDyOuUBrpdL+VfooPyD/3MoJuMupoDYz1G4glz3mL7dwLKyPL+7Xnz8PHn
+vfJg1zRTxhz5bezkLkZVauFxh7Nrm0p+hOex4L2ue+mo+aLZHx+bqbUVdf874cf6+1h83B/
WD+eJFvZe0yS/N8NJg7Z718fNhIV3x/uneFEUeZ+WAIWzeEUDManZZHejlQqD+eDJDMmRuRL
z25HJjds4VSdQMXAzxbdlwiluyay8b3b3TByuzYNXVjlboeIWMNJ5JZN+dKBFUQbJdWZFdEI
nNpLrl8Sdltirs2mNZf4pL2qM2Ka8cpk4ayCOSbR9MxZFrj9nFPAlRqR3eLCelXSJRBZ7w9u
Yzw6GxPfCMFE1auVbRUx8WEaXCdjd+4V3J1qaKcancZs6i5qkul7P0AWTwgYQcdg9UoXI3fQ
PItH40sSrL+VHcBjM9X2gDgjg6h2u2quB+gdgKo2B3w+oj4EIOgXwx0+ox6Zdki8mQmLGVFv
NeOjK48NSlEsy3Mzy6OSKjZvP8x8rR2TcT86wJqKEY0HeR0yj12rpeAR6a/frbJi2b6eoBGO
lbJbhkGWgNIWEAhUKHyFREXxVYRTho/u6EkEUWgq//pLXc+DO0LEEkEqgrG7ODv27xZIEqKW
hJfGY8d+EbmbqkrcWaqWBTntLXyYwC7NzNtuvd8r2do5mZNpGpDveTt2f1c4DV1OXFElvZsQ
8wzQ+VEZxL6SVt7199vH15eT/P3l23qnvPwt3aBfwYI1UUlJoTEPZ/LREY2ZWy8VDdxRnitJ
qAMUEQ7wK8NHpgm6nurqniZnNpTg3yFoWbzHeoX7noLnFNvp0agz+IeKjXcuJLoy87z5tsP8
PrvX98NmS5ypKQtJViThwFO+vBCI9tByY3+6NCRObcKjxRUJjepFyOM19GQkOvYMujtIQT5m
d8mX0TGSoXlnN2lkxzbVMNRBIj2yw4Hacx7Ol9QeSRatr3kSHd3bAyFWfzo5KsIjsXIX+BMV
BqFZRYnnsmWgizDdxbGDAXqXYfS2qJmtdC8IcZthrF2Ao0EJQ/SQyLIO05ZG1KFJtjo/vWqi
hLe2qKT1kRsIyutIXKLPB6YekXVQFJ+7R6sDVu3D9e6ATzZAcVGp4fabp+394X23Pnn4sX74
udk+6e+M8bIWEw6I1sbWvtD04gW+kTWxyarigT4ip7xD0cilPjm9ujBMa0UeB/zW7g5la1P1
wpbH4Aei8vZ8oJAMS/pyyEe+nePDX8yWiiLh5WsY2DvgDcdHxuazjMDnqBQyEPvwGa42Vd3j
AZAI8whtfLzIOq8igiRNcg82T6qmrph+0xcVPDb89DnLkiavs9AIfqHsp0Hq1llGzHbX7FAW
GNQI2F1wshmg0YVJ4WoaUFFVN2aps7H1Uzdea9taYmC/JeEtrUJrBBOiaMCXlpxjUYSkYR9w
F3Z1tEgc6XFkWOhqepGm6yjFTv8qeVxk5uBbFAhbvTOgCUW3bBt+h9wcjuzU2KIgxBF1IJSq
A4Q2knpCUq/uEGz/blb64+MWJt9wlC4tC/RL0hYY6FkBB1g1r/X0vy1CAH906w2jrw7MnNxh
QM3sjpUkIgTE2N0ThH0fzpu4EUVaGPqLDsV69X0S6gFMAyGKiMH+XCQwUm6EWAikK7X+kARB
ZuCLDB0DozTg+DpjLqVOrfIu8p4MO4G004IPEdiHeyfAoGToc1AWs1QNXVvaZQ1auM4g4hud
v6SF8VAHfx9Ls5inrXOuPeFVkbFIXylRetdUgVE54zcoIlFORVnJYHMYm3QaazNUyHCrMzg9
uJ6xocgryqUH4aR3L9Jf/rq0arj8pX92ge+ZCm2OBHAfYwbxViqfmbywPc6cU8q8bOlOfwl9
2222h58noE+dPL6s90/u3Z50O72WYZCMc02B0amFNoW3Ib5BfkrhlEt74/5nL8VNzZLqy6T/
HK1k49TQU8S3eQBf3HbdNMBOmBeQz8IC5bKEc6CjE5V6p6XXmDfP64+HzUsrIewl6YOC79xJ
VF1pNSUHhkF86ygxLpQ1bMdoPCkJNEpRpoyOI6kRxcuAT2k/8FkMGy/irPQEhUlyeZ+R1WiF
QQd2an1jnHfpoPzlcnQ11tdrCRwMn7ZlhoTEQcWU1QKSbHUOBCCioKNYFdBJlNvMrNJVHn0V
s6DSGaeNkd1rijy9tfjfMoCtqEZQFtILW3ci1uHutwJ2GSWtt5oKuUW7+P7t4jGCHbS7N15/
e396wutGtt0fdu8vbRCibstgPGmUevUwMBqwv+pUH/LL6a8RRaVeytI1tK9oBV7u55EZLKed
B4rr1aEwYsziTwzrZbwEVtAQAxN465CeqHoh5H4KRU73X02guY6UD6e9Udt29YvpvjKNWyLH
Ak0Hw5mb8YBULYiXpyPtEIGli2XueZgl0bD+MIS7J/i0akU5rZPeDWkddkRG9yRCumseqVdd
ttfIlkkqAUwhbqmSPHZ5hFXfgkyzp6ZbvpD//8qupUdtGAj/FY49VEjbew8hhCYKiUMeG3pa
ITZarVYFtEDVn995JMSPsavekD04fozH34xnxnRRL8wi7y+MJJYGSQ4XWo8xoGCzVb3bkFEt
nWIxQaI8Qs5zzD5cTG18f3I8B2bucL6aYty6cyOE9At1vly/Lrbn48f9woIhPZzeDB/7ChPa
ofeCUuLwjXoMxOsSI0lWFtNprjrMnTWvndq06ErcVeOrH56MnuOTICm+NNlGnvyG/Q5EKQja
tZIgIm1Z/paOW8ITwC5IIDBf75QT2N17zH0WGOBCO8yNSgVun1w3hM/Yi4hTmCdJJSv3I58C
tC+qR+YaHJQmgb5cL+8nvKyF8f6634Y/A/wYbsflcqknQlRTVuYfBPhcpFnVmPBNiIh6UFAb
ONzAXqxbONfbZJ8EBYCQaMgi+Xcjfc9EIHNUj+5HoV71jRVtYBHQ0ByJapCwXgBfg9VyRcA4
b2wuD6bEo0/BtmjRWd3WTWbWf4xO0GBmjP4frDBDKBA0bW2FhRGUgQnA7NugSAKzs60gMGc5
nw8eCfTBJ+Xr4XZY4BF5REOYg2XHgChbMGNxiH9CpxZ75sl56fjAellHbYSIvu6m8D5Leng6
b38qBsQN2i8gGTfGrI47Q7rMQDXu8OTZ+NceKXwMopHg0UVQ9iGHvz3p9c4aY2Gya6S4jCnL
k9FpZ8ftRnRaC7jUoOSITAAwqPnLg0TLURn/lF+Zoa6D3m3kesdCj+za0B9kMBHha3XyVmSf
TOwj4ARnBc+X4fT5fj0ay6grwe1wveG2w9MlPv8ePg9vg77SeVd69KiJR1F7VPUcnysSWzG8
fnwBMCJWz+Pk6favuiuRRYiZcAbH+0oT/JJlu4GJFTtBJEVWUipPP4X3/6tJ6JBAC/D+Cr0Y
AvW6lctLRboVQJaXcGOwDXETefbYZAgSLcU02jTZY9xOYDrYvDK+5Baka+JKjvMmghwoWiWn
aiQCMqTI+Vypng0/wXpgyK1sG2DlqLOfDdFr92RJ9NdL6NikqNFU3aJC6afxBm9RbbaWr/6Y
vXP5LJtGr+wEtXr9c+HXtnhyGnqPLrSEqyq0PHi3lPJjdvIzIpusxARBQApiMy2iWrKaUFvT
c68Ou3LsaWAQ62QbWsPR89vrPc+cWqgAm4CcjSPgVl/fCZzY2tr0z6wU706gxrZdBgW043vN
psy/5X+rAdiEAQA=

--AqsLC8rIMeq19msA--
