Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE11C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:42:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67FD120714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgG0FmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:42:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:26206 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgG0FmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:42:05 -0400
IronPort-SDR: aaxysnu126Uq//JadXOWRmm1Itzfxf9E4qLrpBHIIwoAvrc8xvI9MEIlLFc1CBFROhNId23FUR
 ryD5j/FpGQWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="150939266"
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="gz'50?scan'50,208,50";a="150939266"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2020 22:40:47 -0700
IronPort-SDR: 9wt2MsVhS7Ex9v7i3uccvjgyWK0apnc1aEIdSLTv5QOfzuWc/1Z1B7odwLkpHfgUb0p0O0uAF9
 SQwmcE0gdWLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,401,1589266800"; 
   d="gz'50?scan'50,208,50";a="289662688"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2020 22:40:44 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jzvsR-0001oN-Qt; Mon, 27 Jul 2020 05:40:43 +0000
Date:   Mon, 27 Jul 2020 13:40:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ppp/pppox.c:84:21: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202007271313.jlpiAH1N%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SLDf9lqlvOQaIe6s"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92ed301919932f777713b9172e525674157e983d
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   6 weeks ago
config: openrisc-randconfig-s032-20200727 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-94-geb6779f6-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/ppp/pppox.c:84:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/net/ppp/pppox.c:84:21: sparse:     expected int *__pu_addr
>> drivers/net/ppp/pppox.c:84:21: sparse:     got int [noderef] __user *
--
>> drivers/net/ppp/pppoe.c:751:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/net/ppp/pppoe.c:751:21: sparse:     expected int *__pu_addr
>> drivers/net/ppp/pppoe.c:751:21: sparse:     got int [noderef] __user *
>> drivers/net/ppp/pppoe.c:765:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/ppp/pppoe.c:765:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/pppoe.c:765:21: sparse:     got int [noderef] __user *
   drivers/net/ppp/pppoe.c:778:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/ppp/pppoe.c:778:21: sparse:     expected int const *__gu_addr
   drivers/net/ppp/pppoe.c:778:21: sparse:     got int [noderef] __user *
--
>> drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1828:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1828:9: sparse:     expected unsigned int const *__gu_addr
>> drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1828:9: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1830:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1830:9: sparse:     expected unsigned int *__pu_addr
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1830:9: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1833:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1833:9: sparse:     expected unsigned int const *__gu_addr
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1833:9: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1845:9: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1845:9: sparse:     expected unsigned int const *__gu_addr
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c:1845:9: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, drivers/staging/rtl8712/osdep_service.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, drivers/staging/rtl8712/osdep_service.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, drivers/staging/rtl8712/osdep_service.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, drivers/staging/rtl8712/osdep_service.h):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   drivers/staging/rtl8712/rtl871x_ioctl_linux.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
   net/bluetooth/sco.c:813:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/sco.c:813:21: sparse:     expected unsigned int const *__gu_addr
   net/bluetooth/sco.c:813:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/bluetooth/sco.c:868:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/sco.c:868:13: sparse:     expected int const *__gu_addr
   net/bluetooth/sco.c:868:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/sco.c:932:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/sco.c:932:13: sparse:     expected int const *__gu_addr
   net/bluetooth/sco.c:932:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/sco.c:945:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/sco.c:945:21: sparse:     expected unsigned int *__pu_addr
   net/bluetooth/sco.c:945:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/bluetooth/sco.c:968:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/sco.c:968:21: sparse:     expected unsigned int *__pu_addr
   net/bluetooth/sco.c:968:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/bluetooth/sco.c: note: in included file (through include/asm-generic/atomic.h, arch/openrisc/include/asm/atomic.h, include/linux/atomic.h, ...):
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
   net/bluetooth/sco.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   net/bluetooth/sco.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   net/bluetooth/sco.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   net/bluetooth/sco.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   net/bluetooth/sco.c: note: in included file (through include/linux/sched/task.h, include/linux/sched/signal.h, include/linux/rcuwait.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   net/bluetooth/sco.c: note: in included file (through include/linux/uaccess.h, include/linux/sched/task.h, include/linux/sched/signal.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
   net/bluetooth/rfcomm/sock.c:659:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/rfcomm/sock.c:659:21: sparse:     expected unsigned int const *__gu_addr
>> net/bluetooth/rfcomm/sock.c:659:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/bluetooth/rfcomm/sock.c:735:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/rfcomm/sock.c:735:21: sparse:     expected unsigned int const *__gu_addr
   net/bluetooth/rfcomm/sock.c:735:21: sparse:     got unsigned int [noderef] [usertype] __user *
>> net/bluetooth/rfcomm/sock.c:767:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/rfcomm/sock.c:767:13: sparse:     expected int const *__gu_addr
>> net/bluetooth/rfcomm/sock.c:767:13: sparse:     got int [noderef] __user *optlen
>> net/bluetooth/rfcomm/sock.c:797:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/rfcomm/sock.c:797:21: sparse:     expected unsigned int *__pu_addr
   net/bluetooth/rfcomm/sock.c:797:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/bluetooth/rfcomm/sock.c:845:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/bluetooth/rfcomm/sock.c:845:13: sparse:     expected int const *__gu_addr
   net/bluetooth/rfcomm/sock.c:845:13: sparse:     got int [noderef] __user *optlen
   net/bluetooth/rfcomm/sock.c:872:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   net/bluetooth/rfcomm/sock.c:872:21: sparse:     expected unsigned int *__pu_addr
   net/bluetooth/rfcomm/sock.c:872:21: sparse:     got unsigned int [noderef] [usertype] __user *
   net/bluetooth/rfcomm/sock.c: note: in included file (through include/linux/crypto.h, include/crypto/hash.h, include/linux/uio.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   net/bluetooth/rfcomm/sock.c: note: in included file (through include/linux/uaccess.h, include/linux/crypto.h, include/crypto/hash.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   net/bluetooth/rfcomm/sock.c: note: in included file (through include/linux/crypto.h, include/crypto/hash.h, include/linux/uio.h, ...):
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   net/bluetooth/rfcomm/sock.c: note: in included file (through include/linux/uaccess.h, include/linux/crypto.h, include/crypto/hash.h, ...):
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from

vim +84 drivers/net/ppp/pppox.c

^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  66  
17ba15fb6264f2 drivers/net/pppox.c David S. Miller  2005-12-27  67  int pppox_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  68  {
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  69  	struct sock *sk = sock->sk;
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  70  	struct pppox_sock *po = pppox_sk(sk);
86c1dcfc96a778 drivers/net/pppox.c Florian Zumbiehl 2007-07-30  71  	int rc;
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  72  
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  73  	lock_sock(sk);
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  74  
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  75  	switch (cmd) {
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  76  	case PPPIOCGCHAN: {
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  77  		int index;
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  78  		rc = -ENOTCONN;
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  79  		if (!(sk->sk_state & PPPOX_CONNECTED))
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  80  			break;
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  81  
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  82  		rc = -EINVAL;
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  83  		index = ppp_channel_index(&po->chan);
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16 @84  		if (put_user(index , (int __user *) arg))
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  85  			break;
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  86  
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  87  		rc = 0;
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  88  		sk->sk_state |= PPPOX_BOUND;
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  89  		break;
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  90  	}
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  91  	default:
86c1dcfc96a778 drivers/net/pppox.c Florian Zumbiehl 2007-07-30  92  		rc = pppox_protos[sk->sk_protocol]->ioctl ?
86c1dcfc96a778 drivers/net/pppox.c Florian Zumbiehl 2007-07-30  93  			pppox_protos[sk->sk_protocol]->ioctl(sock, cmd, arg) : -ENOTTY;
86c1dcfc96a778 drivers/net/pppox.c Florian Zumbiehl 2007-07-30  94  	}
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  95  
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  96  	release_sock(sk);
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  97  	return rc;
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  98  }
^1da177e4c3f41 drivers/net/pppox.c Linus Torvalds   2005-04-16  99  

:::::: The code at line 84 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--SLDf9lqlvOQaIe6s
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
umC+jXQBAA==

--SLDf9lqlvOQaIe6s--
