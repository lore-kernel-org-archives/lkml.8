Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACACC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 152562076D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 07:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgGNHJd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 03:09:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:19186 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgGNHJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 03:09:33 -0400
IronPort-SDR: 0ApeLZ+SqeOXzJHEQkFkINfMsHL7GVFVazUH5zCWnZ+G+R7nqHxCHyxRdQ8hN/vQqXyvFXC3R/
 sT5JuT0KKpvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="128912450"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="gz'50?scan'50,208,50";a="128912450"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 23:42:29 -0700
IronPort-SDR: YyswWvCVIgaMckVBQ4f0pgoA07VmLmaLlBa40kUqkvMqzmFHnFsAWfBTydAWgbEIHEegjxr9AP
 K0CuQIonlVbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="gz'50?scan'50,208,50";a="269930589"
Received: from lkp-server02.sh.intel.com (HELO fb03a464a2e3) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jul 2020 23:42:27 -0700
Received: from kbuild by fb03a464a2e3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jvEe2-00018B-HK; Tue, 14 Jul 2020 06:42:26 +0000
Date:   Tue, 14 Jul 2020 14:42:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/hamradio/mkiss.c:825:23: sparse: sparse: incorrect type
 in initializer (different address spaces)
Message-ID: <202007141459.h9cVq5cN%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0dc589da873b58b70f4caf4b070fb0cf70fdd1dc
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   4 weeks ago
config: openrisc-randconfig-s032-20200714 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-41-g14e84ffc-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/hamradio/mkiss.c:825:23: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/net/hamradio/mkiss.c:825:23: sparse:     expected int *__pu_addr
   drivers/net/hamradio/mkiss.c:825:23: sparse:     got int [noderef] __user *
   drivers/net/hamradio/mkiss.c:829:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/net/hamradio/mkiss.c:829:21: sparse:     expected int const *__gu_addr
   drivers/net/hamradio/mkiss.c:829:21: sparse:     got int [noderef] __user *
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
--
>> drivers/hid/usbhid/hiddev.c:569:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/hid/usbhid/hiddev.c:569:13: sparse:     expected int const *__gu_addr
>> drivers/hid/usbhid/hiddev.c:569:13: sparse:     got int [noderef] __user *
>> drivers/hid/usbhid/hiddev.c:617:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/hid/usbhid/hiddev.c:617:21: sparse:     expected int *__pu_addr
   drivers/hid/usbhid/hiddev.c:617:21: sparse:     got int [noderef] __user *
   drivers/hid/usbhid/hiddev.c:656:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/hid/usbhid/hiddev.c:656:21: sparse:     expected int *__pu_addr
   drivers/hid/usbhid/hiddev.c:656:21: sparse:     got int [noderef] __user *
   drivers/hid/usbhid/hiddev.c:664:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   drivers/hid/usbhid/hiddev.c:664:29: sparse:     expected int const *__gu_addr
   drivers/hid/usbhid/hiddev.c:664:29: sparse:     got int [noderef] __user *
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
--
>> drivers/usb/atm/usbatm.c:893:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/usb/atm/usbatm.c:893:24: sparse:     expected int *__pu_addr
>> drivers/usb/atm/usbatm.c:893:24: sparse:     got int [noderef] __user *
--
>> fs/ubifs/ioctl.c:153:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   fs/ubifs/ioctl.c:153:24: sparse:     expected int *__pu_addr
   fs/ubifs/ioctl.c:153:24: sparse:     got int [noderef] __user *
   fs/ubifs/ioctl.c:162:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user * @@
   fs/ubifs/ioctl.c:162:21: sparse:     expected int const *__gu_addr
   fs/ubifs/ioctl.c:162:21: sparse:     got int [noderef] __user *
--
   net/netrom/af_netrom.c:309:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] __user * @@
   net/netrom/af_netrom.c:309:13: sparse:     expected unsigned int const *__gu_addr
   net/netrom/af_netrom.c:309:13: sparse:     got unsigned int [noderef] __user *
   net/netrom/af_netrom.c:359:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const *__gu_addr @@     got int [noderef] __user *optlen @@
   net/netrom/af_netrom.c:359:13: sparse:     expected int const *__gu_addr
   net/netrom/af_netrom.c:359:13: sparse:     got int [noderef] __user *optlen
>> net/netrom/af_netrom.c:392:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user *optlen @@
   net/netrom/af_netrom.c:392:13: sparse:     expected int *__pu_addr
   net/netrom/af_netrom.c:392:13: sparse:     got int [noderef] __user *optlen
>> net/netrom/af_netrom.c:1211:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   net/netrom/af_netrom.c:1211:24: sparse:     expected int *__pu_addr
>> net/netrom/af_netrom.c:1211:24: sparse:     got int [noderef] __user *
   net/netrom/af_netrom.c:1223:24: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   net/netrom/af_netrom.c:1223:24: sparse:     expected int *__pu_addr
   net/netrom/af_netrom.c:1223:24: sparse:     got int [noderef] __user *
   include/linux/uaccess.h:131:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *to @@     got void [noderef] __user *to @@
   include/linux/uaccess.h:131:38: sparse:     expected void *to
   include/linux/uaccess.h:131:38: sparse:     got void [noderef] __user *to
   include/linux/uaccess.h:131:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *from @@     got void const *from @@
   include/linux/uaccess.h:131:42: sparse:     expected void const [noderef] __user *from
   include/linux/uaccess.h:131:42: sparse:     got void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *from @@     got void const [noderef] __user *from @@
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     expected void const *from
   arch/openrisc/include/asm/uaccess.h:246:55: sparse:     got void const [noderef] __user *from
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int

vim +825 drivers/net/hamradio/mkiss.c

^1da177e4c3f41 Linus Torvalds 2005-04-16  804  
815f62bf742718 Ralf Baechle   2005-08-24  805  /* Perform I/O control on an active ax25 channel. */
815f62bf742718 Ralf Baechle   2005-08-24  806  static int mkiss_ioctl(struct tty_struct *tty, struct file *file,
815f62bf742718 Ralf Baechle   2005-08-24  807  	unsigned int cmd, unsigned long arg)
^1da177e4c3f41 Linus Torvalds 2005-04-16  808  {
815f62bf742718 Ralf Baechle   2005-08-24  809  	struct mkiss *ax = mkiss_get(tty);
f40e0638237a2d Julia Lawall   2008-12-16  810  	struct net_device *dev;
815f62bf742718 Ralf Baechle   2005-08-24  811  	unsigned int tmp, err;
^1da177e4c3f41 Linus Torvalds 2005-04-16  812  
815f62bf742718 Ralf Baechle   2005-08-24  813  	/* First make sure we're connected. */
815f62bf742718 Ralf Baechle   2005-08-24  814  	if (ax == NULL)
815f62bf742718 Ralf Baechle   2005-08-24  815  		return -ENXIO;
f40e0638237a2d Julia Lawall   2008-12-16  816  	dev = ax->dev;
^1da177e4c3f41 Linus Torvalds 2005-04-16  817  
815f62bf742718 Ralf Baechle   2005-08-24  818  	switch (cmd) {
815f62bf742718 Ralf Baechle   2005-08-24  819   	case SIOCGIFNAME:
815f62bf742718 Ralf Baechle   2005-08-24  820  		err = copy_to_user((void __user *) arg, ax->dev->name,
815f62bf742718 Ralf Baechle   2005-08-24  821  		                   strlen(ax->dev->name) + 1) ? -EFAULT : 0;
^1da177e4c3f41 Linus Torvalds 2005-04-16  822  		break;
815f62bf742718 Ralf Baechle   2005-08-24  823  
815f62bf742718 Ralf Baechle   2005-08-24  824  	case SIOCGIFENCAP:
815f62bf742718 Ralf Baechle   2005-08-24 @825  		err = put_user(4, (int __user *) arg);
^1da177e4c3f41 Linus Torvalds 2005-04-16  826  		break;
815f62bf742718 Ralf Baechle   2005-08-24  827  
815f62bf742718 Ralf Baechle   2005-08-24  828  	case SIOCSIFENCAP:
815f62bf742718 Ralf Baechle   2005-08-24  829  		if (get_user(tmp, (int __user *) arg)) {
815f62bf742718 Ralf Baechle   2005-08-24  830  			err = -EFAULT;
^1da177e4c3f41 Linus Torvalds 2005-04-16  831  			break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  832  		}
^1da177e4c3f41 Linus Torvalds 2005-04-16  833  
815f62bf742718 Ralf Baechle   2005-08-24  834  		ax->mode = tmp;
815f62bf742718 Ralf Baechle   2005-08-24  835  		dev->addr_len        = AX25_ADDR_LEN;
815f62bf742718 Ralf Baechle   2005-08-24  836  		dev->hard_header_len = AX25_KISS_HEADER_LEN +
815f62bf742718 Ralf Baechle   2005-08-24  837  		                       AX25_MAX_HEADER_LEN + 3;
815f62bf742718 Ralf Baechle   2005-08-24  838  		dev->type            = ARPHRD_AX25;
^1da177e4c3f41 Linus Torvalds 2005-04-16  839  
815f62bf742718 Ralf Baechle   2005-08-24  840  		err = 0;
815f62bf742718 Ralf Baechle   2005-08-24  841  		break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  842  
815f62bf742718 Ralf Baechle   2005-08-24  843  	case SIOCSIFHWADDR: {
815f62bf742718 Ralf Baechle   2005-08-24  844  		char addr[AX25_ADDR_LEN];
^1da177e4c3f41 Linus Torvalds 2005-04-16  845  
815f62bf742718 Ralf Baechle   2005-08-24  846  		if (copy_from_user(&addr,
815f62bf742718 Ralf Baechle   2005-08-24  847  		                   (void __user *) arg, AX25_ADDR_LEN)) {
815f62bf742718 Ralf Baechle   2005-08-24  848  			err = -EFAULT;
^1da177e4c3f41 Linus Torvalds 2005-04-16  849  			break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  850  		}
^1da177e4c3f41 Linus Torvalds 2005-04-16  851  
932ff279a43ab7 Herbert Xu     2006-06-09  852  		netif_tx_lock_bh(dev);
815f62bf742718 Ralf Baechle   2005-08-24  853  		memcpy(dev->dev_addr, addr, AX25_ADDR_LEN);
932ff279a43ab7 Herbert Xu     2006-06-09  854  		netif_tx_unlock_bh(dev);
^1da177e4c3f41 Linus Torvalds 2005-04-16  855  
815f62bf742718 Ralf Baechle   2005-08-24  856  		err = 0;
815f62bf742718 Ralf Baechle   2005-08-24  857  		break;
^1da177e4c3f41 Linus Torvalds 2005-04-16  858  	}
815f62bf742718 Ralf Baechle   2005-08-24  859  	default:
815f62bf742718 Ralf Baechle   2005-08-24  860  		err = -ENOIOCTLCMD;
^1da177e4c3f41 Linus Torvalds 2005-04-16  861  	}
^1da177e4c3f41 Linus Torvalds 2005-04-16  862  
815f62bf742718 Ralf Baechle   2005-08-24  863  	mkiss_put(ax);
^1da177e4c3f41 Linus Torvalds 2005-04-16  864  
815f62bf742718 Ralf Baechle   2005-08-24  865  	return err;
^1da177e4c3f41 Linus Torvalds 2005-04-16  866  }
^1da177e4c3f41 Linus Torvalds 2005-04-16  867  

:::::: The code at line 825 was first introduced by commit
:::::: 815f62bf742718458ba822a7e1f51f285eb997f2 [PATCH] SMP rewrite of mkiss

:::::: TO: Ralf Baechle <ralf@linux-mips.org>
:::::: CC: Jeff Garzik <jgarzik@pobox.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--45Z9DzgjV8m4Oswq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
XljQpm6cAQA=

--45Z9DzgjV8m4Oswq--
