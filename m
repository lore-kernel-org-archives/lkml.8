Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56942C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0886D2076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbgGJGGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 02:06:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:10401 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726004AbgGJGGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 02:06:21 -0400
IronPort-SDR: p4BHHGwo47HhVUTggucPSrU3KGTFlbyzb/DgsC3rDd//CaksncTX8jU4ERbqUata+d75KZK77u
 zmsssBZr4Okw==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="213044570"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="gz'50?scan'50,208,50";a="213044570"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 23:04:59 -0700
IronPort-SDR: dccY+k33MgF07dM8G9Kff76gCMU0QqVg20S+VJ8/cXMyauxd6BcomERfItk2QbmbbsVDzteI5h
 4uVgW355HUaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="gz'50?scan'50,208,50";a="389387644"
Received: from lkp-server02.sh.intel.com (HELO 0fc60ea15964) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 09 Jul 2020 23:04:57 -0700
Received: from kbuild by 0fc60ea15964 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jtm9Y-00002v-FI; Fri, 10 Jul 2020 06:04:56 +0000
Date:   Fri, 10 Jul 2020 14:04:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/usb/class/usbtmc.c:498:22: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202007101458.W0AEMevq%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bddd227f3dc55975e2b8dfa7fc6f959b062a2c7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: openrisc-randconfig-s031-20200710 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-37-gc9676a3b-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/usb/class/usbtmc.c:498:22: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__pu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/usb/class/usbtmc.c:498:22: sparse:     expected unsigned char *__pu_addr
>> drivers/usb/class/usbtmc.c:498:22: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/usb/class/usbtmc.c:556:14: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__pu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/usb/class/usbtmc.c:556:14: sparse:     expected unsigned char *__pu_addr
   drivers/usb/class/usbtmc.c:556:14: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/usb/class/usbtmc.c:584:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user *arg @@
   drivers/usb/class/usbtmc.c:584:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/class/usbtmc.c:584:13: sparse:     got unsigned int [noderef] [usertype] __user *arg
>> drivers/usb/class/usbtmc.c:1033:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/class/usbtmc.c:1033:13: sparse:     expected unsigned int *__pu_addr
>> drivers/usb/class/usbtmc.c:1033:13: sparse:     got unsigned int [noderef] __user *
   drivers/usb/class/usbtmc.c:1244:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] __user * @@
   drivers/usb/class/usbtmc.c:1244:13: sparse:     expected unsigned int *__pu_addr
   drivers/usb/class/usbtmc.c:1244:13: sparse:     got unsigned int [noderef] __user *
>> drivers/usb/class/usbtmc.c:1265:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/usb/class/usbtmc.c:1265:13: sparse:     expected unsigned int *__pu_addr
   drivers/usb/class/usbtmc.c:1265:13: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/usb/class/usbtmc.c:1952:16: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/usb/class/usbtmc.c:1952:16: sparse:     expected unsigned int *__pu_addr
   drivers/usb/class/usbtmc.c:1952:16: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/usb/class/usbtmc.c:1963:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int const *__gu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/usb/class/usbtmc.c:1963:13: sparse:     expected unsigned int const *__gu_addr
   drivers/usb/class/usbtmc.c:1963:13: sparse:     got unsigned int [noderef] [usertype] __user *
   drivers/usb/class/usbtmc.c:2099:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int *__pu_addr @@     got unsigned int [noderef] [usertype] __user * @@
   drivers/usb/class/usbtmc.c:2099:26: sparse:     expected unsigned int *__pu_addr
   drivers/usb/class/usbtmc.c:2099:26: sparse:     got unsigned int [noderef] [usertype] __user *
>> drivers/usb/class/usbtmc.c:2104:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__pu_addr @@     got unsigned char [noderef] __user * @@
   drivers/usb/class/usbtmc.c:2104:26: sparse:     expected unsigned char *__pu_addr
   drivers/usb/class/usbtmc.c:2104:26: sparse:     got unsigned char [noderef] __user *
   drivers/usb/class/usbtmc.c:2138:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char *__pu_addr @@     got unsigned char [noderef] [usertype] __user * @@
   drivers/usb/class/usbtmc.c:2138:26: sparse:     expected unsigned char *__pu_addr
   drivers/usb/class/usbtmc.c:2138:26: sparse:     got unsigned char [noderef] [usertype] __user *
   drivers/usb/class/usbtmc.c:2143:26: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned char const *__gu_addr @@     got unsigned char [noderef] __user * @@
   drivers/usb/class/usbtmc.c:2143:26: sparse:     expected unsigned char const *__gu_addr
   drivers/usb/class/usbtmc.c:2143:26: sparse:     got unsigned char [noderef] __user *
   arch/openrisc/include/asm/cmpxchg.h:101:29: sparse: sparse: shift too big (32) for type int
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
--
>> drivers/hid/hid-roccat.c:393:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int *__pu_addr @@     got int [noderef] __user * @@
   drivers/hid/hid-roccat.c:393:21: sparse:     expected int *__pu_addr
>> drivers/hid/hid-roccat.c:393:21: sparse:     got int [noderef] __user *
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
>> drivers/clk/clk-hsdk-pll.c:415:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *spec_regs @@
   drivers/clk/clk-hsdk-pll.c:415:24: sparse:     expected void *addr
>> drivers/clk/clk-hsdk-pll.c:415:24: sparse:     got void [noderef] __iomem *spec_regs
>> drivers/clk/clk-hsdk-pll.c:417:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *regs @@
   drivers/clk/clk-hsdk-pll.c:417:24: sparse:     expected void *addr
>> drivers/clk/clk-hsdk-pll.c:417:24: sparse:     got void [noderef] __iomem *regs
--
>> drivers/tty/serial/altera_uart.c:628:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got unsigned char [noderef] __iomem *membase @@
   drivers/tty/serial/altera_uart.c:628:29: sparse:     expected void *addr
>> drivers/tty/serial/altera_uart.c:628:29: sparse:     got unsigned char [noderef] __iomem *membase
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
--
>> drivers/tty/serial/xilinx_uartps.c:988:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got unsigned char [noderef] __iomem *membase @@
   drivers/tty/serial/xilinx_uartps.c:988:21: sparse:     expected void *addr
>> drivers/tty/serial/xilinx_uartps.c:988:21: sparse:     got unsigned char [noderef] __iomem *membase
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   drivers/tty/serial/xilinx_uartps.c:553:33: sparse: sparse: context imbalance in 'cdns_uart_clk_notifier_cb' - different lock contexts for basic block
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32

vim +498 drivers/usb/class/usbtmc.c

0e59088e7ff7ae Guido Kiener 2018-09-12  477  
4f3c8d6eddc272 Guido Kiener 2018-07-18  478  static int usbtmc488_ioctl_read_stb(struct usbtmc_file_data *file_data,
dbf3e7f654c0f0 Dave Penkler 2016-01-27  479  				void __user *arg)
dbf3e7f654c0f0 Dave Penkler 2016-01-27  480  {
4f3c8d6eddc272 Guido Kiener 2018-07-18  481  	struct usbtmc_device_data *data = file_data->data;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  482  	struct device *dev = &data->intf->dev;
4f3c8d6eddc272 Guido Kiener 2018-07-18  483  	int srq_asserted = 0;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  484  	u8 *buffer;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  485  	u8 tag;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  486  	__u8 stb;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  487  	int rv;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  488  
dbf3e7f654c0f0 Dave Penkler 2016-01-27  489  	dev_dbg(dev, "Enter ioctl_read_stb iin_ep_present: %d\n",
dbf3e7f654c0f0 Dave Penkler 2016-01-27  490  		data->iin_ep_present);
dbf3e7f654c0f0 Dave Penkler 2016-01-27  491  
4f3c8d6eddc272 Guido Kiener 2018-07-18  492  	spin_lock_irq(&data->dev_lock);
4f3c8d6eddc272 Guido Kiener 2018-07-18  493  	srq_asserted = atomic_xchg(&file_data->srq_asserted, srq_asserted);
4f3c8d6eddc272 Guido Kiener 2018-07-18  494  	if (srq_asserted) {
4f3c8d6eddc272 Guido Kiener 2018-07-18  495  		/* a STB with SRQ is already received */
4f3c8d6eddc272 Guido Kiener 2018-07-18  496  		stb = file_data->srq_byte;
4f3c8d6eddc272 Guido Kiener 2018-07-18  497  		spin_unlock_irq(&data->dev_lock);
4f3c8d6eddc272 Guido Kiener 2018-07-18 @498  		rv = put_user(stb, (__u8 __user *)arg);
4f3c8d6eddc272 Guido Kiener 2018-07-18  499  		dev_dbg(dev, "stb:0x%02x with srq received %d\n",
4f3c8d6eddc272 Guido Kiener 2018-07-18  500  			(unsigned int)stb, rv);
4f3c8d6eddc272 Guido Kiener 2018-07-18  501  		return rv;
4f3c8d6eddc272 Guido Kiener 2018-07-18  502  	}
4f3c8d6eddc272 Guido Kiener 2018-07-18  503  	spin_unlock_irq(&data->dev_lock);
4f3c8d6eddc272 Guido Kiener 2018-07-18  504  
dbf3e7f654c0f0 Dave Penkler 2016-01-27  505  	buffer = kmalloc(8, GFP_KERNEL);
dbf3e7f654c0f0 Dave Penkler 2016-01-27  506  	if (!buffer)
dbf3e7f654c0f0 Dave Penkler 2016-01-27  507  		return -ENOMEM;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  508  
dbf3e7f654c0f0 Dave Penkler 2016-01-27  509  	atomic_set(&data->iin_data_valid, 0);
dbf3e7f654c0f0 Dave Penkler 2016-01-27  510  
dbf3e7f654c0f0 Dave Penkler 2016-01-27  511  	rv = usb_control_msg(data->usb_dev,
dbf3e7f654c0f0 Dave Penkler 2016-01-27  512  			usb_rcvctrlpipe(data->usb_dev, 0),
dbf3e7f654c0f0 Dave Penkler 2016-01-27  513  			USBTMC488_REQUEST_READ_STATUS_BYTE,
dbf3e7f654c0f0 Dave Penkler 2016-01-27  514  			USB_DIR_IN | USB_TYPE_CLASS | USB_RECIP_INTERFACE,
dbf3e7f654c0f0 Dave Penkler 2016-01-27  515  			data->iin_bTag,
dbf3e7f654c0f0 Dave Penkler 2016-01-27  516  			data->ifnum,
63c97bbad5ae5e Guido Kiener 2018-09-12  517  			buffer, 0x03, USB_CTRL_GET_TIMEOUT);
dbf3e7f654c0f0 Dave Penkler 2016-01-27  518  	if (rv < 0) {
dbf3e7f654c0f0 Dave Penkler 2016-01-27  519  		dev_err(dev, "stb usb_control_msg returned %d\n", rv);
dbf3e7f654c0f0 Dave Penkler 2016-01-27  520  		goto exit;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  521  	}
dbf3e7f654c0f0 Dave Penkler 2016-01-27  522  
dbf3e7f654c0f0 Dave Penkler 2016-01-27  523  	if (buffer[0] != USBTMC_STATUS_SUCCESS) {
dbf3e7f654c0f0 Dave Penkler 2016-01-27  524  		dev_err(dev, "control status returned %x\n", buffer[0]);
dbf3e7f654c0f0 Dave Penkler 2016-01-27  525  		rv = -EIO;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  526  		goto exit;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  527  	}
dbf3e7f654c0f0 Dave Penkler 2016-01-27  528  
dbf3e7f654c0f0 Dave Penkler 2016-01-27  529  	if (data->iin_ep_present) {
dbf3e7f654c0f0 Dave Penkler 2016-01-27  530  		rv = wait_event_interruptible_timeout(
dbf3e7f654c0f0 Dave Penkler 2016-01-27  531  			data->waitq,
dbf3e7f654c0f0 Dave Penkler 2016-01-27  532  			atomic_read(&data->iin_data_valid) != 0,
048c6d88a02147 Guido Kiener 2018-07-18  533  			file_data->timeout);
dbf3e7f654c0f0 Dave Penkler 2016-01-27  534  		if (rv < 0) {
dbf3e7f654c0f0 Dave Penkler 2016-01-27  535  			dev_dbg(dev, "wait interrupted %d\n", rv);
dbf3e7f654c0f0 Dave Penkler 2016-01-27  536  			goto exit;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  537  		}
dbf3e7f654c0f0 Dave Penkler 2016-01-27  538  
dbf3e7f654c0f0 Dave Penkler 2016-01-27  539  		if (rv == 0) {
dbf3e7f654c0f0 Dave Penkler 2016-01-27  540  			dev_dbg(dev, "wait timed out\n");
19e6c57e96169c Guido Kiener 2018-07-18  541  			rv = -ETIMEDOUT;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  542  			goto exit;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  543  		}
dbf3e7f654c0f0 Dave Penkler 2016-01-27  544  
dbf3e7f654c0f0 Dave Penkler 2016-01-27  545  		tag = data->bNotify1 & 0x7f;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  546  		if (tag != data->iin_bTag) {
dbf3e7f654c0f0 Dave Penkler 2016-01-27  547  			dev_err(dev, "expected bTag %x got %x\n",
dbf3e7f654c0f0 Dave Penkler 2016-01-27  548  				data->iin_bTag, tag);
dbf3e7f654c0f0 Dave Penkler 2016-01-27  549  		}
dbf3e7f654c0f0 Dave Penkler 2016-01-27  550  
dbf3e7f654c0f0 Dave Penkler 2016-01-27  551  		stb = data->bNotify2;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  552  	} else {
dbf3e7f654c0f0 Dave Penkler 2016-01-27  553  		stb = buffer[2];
dbf3e7f654c0f0 Dave Penkler 2016-01-27  554  	}
dbf3e7f654c0f0 Dave Penkler 2016-01-27  555  
4f3c8d6eddc272 Guido Kiener 2018-07-18  556  	rv = put_user(stb, (__u8 __user *)arg);
4f3c8d6eddc272 Guido Kiener 2018-07-18  557  	dev_dbg(dev, "stb:0x%02x received %d\n", (unsigned int)stb, rv);
dbf3e7f654c0f0 Dave Penkler 2016-01-27  558  
dbf3e7f654c0f0 Dave Penkler 2016-01-27  559   exit:
dbf3e7f654c0f0 Dave Penkler 2016-01-27  560  	/* bump interrupt bTag */
dbf3e7f654c0f0 Dave Penkler 2016-01-27  561  	data->iin_bTag += 1;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  562  	if (data->iin_bTag > 127)
dbf3e7f654c0f0 Dave Penkler 2016-01-27  563  		/* 1 is for SRQ see USBTMC-USB488 subclass spec section 4.3.1 */
dbf3e7f654c0f0 Dave Penkler 2016-01-27  564  		data->iin_bTag = 2;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  565  
dbf3e7f654c0f0 Dave Penkler 2016-01-27  566  	kfree(buffer);
dbf3e7f654c0f0 Dave Penkler 2016-01-27  567  	return rv;
dbf3e7f654c0f0 Dave Penkler 2016-01-27  568  }
dbf3e7f654c0f0 Dave Penkler 2016-01-27  569  
739240a9f6ac4d Guido Kiener 2018-09-12  570  static int usbtmc488_ioctl_wait_srq(struct usbtmc_file_data *file_data,
739240a9f6ac4d Guido Kiener 2018-09-12  571  				    __u32 __user *arg)
739240a9f6ac4d Guido Kiener 2018-09-12  572  {
739240a9f6ac4d Guido Kiener 2018-09-12  573  	struct usbtmc_device_data *data = file_data->data;
739240a9f6ac4d Guido Kiener 2018-09-12  574  	struct device *dev = &data->intf->dev;
739240a9f6ac4d Guido Kiener 2018-09-12  575  	int rv;
739240a9f6ac4d Guido Kiener 2018-09-12  576  	u32 timeout;
739240a9f6ac4d Guido Kiener 2018-09-12  577  	unsigned long expire;
739240a9f6ac4d Guido Kiener 2018-09-12  578  
739240a9f6ac4d Guido Kiener 2018-09-12  579  	if (!data->iin_ep_present) {
739240a9f6ac4d Guido Kiener 2018-09-12  580  		dev_dbg(dev, "no interrupt endpoint present\n");
739240a9f6ac4d Guido Kiener 2018-09-12  581  		return -EFAULT;
739240a9f6ac4d Guido Kiener 2018-09-12  582  	}
739240a9f6ac4d Guido Kiener 2018-09-12  583  
739240a9f6ac4d Guido Kiener 2018-09-12 @584  	if (get_user(timeout, arg))
739240a9f6ac4d Guido Kiener 2018-09-12  585  		return -EFAULT;
739240a9f6ac4d Guido Kiener 2018-09-12  586  
739240a9f6ac4d Guido Kiener 2018-09-12  587  	expire = msecs_to_jiffies(timeout);
739240a9f6ac4d Guido Kiener 2018-09-12  588  
739240a9f6ac4d Guido Kiener 2018-09-12  589  	mutex_unlock(&data->io_mutex);
739240a9f6ac4d Guido Kiener 2018-09-12  590  
739240a9f6ac4d Guido Kiener 2018-09-12  591  	rv = wait_event_interruptible_timeout(
739240a9f6ac4d Guido Kiener 2018-09-12  592  			data->waitq,
739240a9f6ac4d Guido Kiener 2018-09-12  593  			atomic_read(&file_data->srq_asserted) != 0 ||
739240a9f6ac4d Guido Kiener 2018-09-12  594  			atomic_read(&file_data->closing),
739240a9f6ac4d Guido Kiener 2018-09-12  595  			expire);
739240a9f6ac4d Guido Kiener 2018-09-12  596  
739240a9f6ac4d Guido Kiener 2018-09-12  597  	mutex_lock(&data->io_mutex);
739240a9f6ac4d Guido Kiener 2018-09-12  598  
739240a9f6ac4d Guido Kiener 2018-09-12  599  	/* Note! disconnect or close could be called in the meantime */
739240a9f6ac4d Guido Kiener 2018-09-12  600  	if (atomic_read(&file_data->closing) || data->zombie)
739240a9f6ac4d Guido Kiener 2018-09-12  601  		rv = -ENODEV;
739240a9f6ac4d Guido Kiener 2018-09-12  602  
739240a9f6ac4d Guido Kiener 2018-09-12  603  	if (rv < 0) {
739240a9f6ac4d Guido Kiener 2018-09-12  604  		/* dev can be invalid now! */
739240a9f6ac4d Guido Kiener 2018-09-12  605  		pr_debug("%s - wait interrupted %d\n", __func__, rv);
739240a9f6ac4d Guido Kiener 2018-09-12  606  		return rv;
739240a9f6ac4d Guido Kiener 2018-09-12  607  	}
739240a9f6ac4d Guido Kiener 2018-09-12  608  
739240a9f6ac4d Guido Kiener 2018-09-12  609  	if (rv == 0) {
739240a9f6ac4d Guido Kiener 2018-09-12  610  		dev_dbg(dev, "%s - wait timed out\n", __func__);
739240a9f6ac4d Guido Kiener 2018-09-12  611  		return -ETIMEDOUT;
739240a9f6ac4d Guido Kiener 2018-09-12  612  	}
739240a9f6ac4d Guido Kiener 2018-09-12  613  
739240a9f6ac4d Guido Kiener 2018-09-12  614  	dev_dbg(dev, "%s - srq asserted\n", __func__);
739240a9f6ac4d Guido Kiener 2018-09-12  615  	return 0;
739240a9f6ac4d Guido Kiener 2018-09-12  616  }
739240a9f6ac4d Guido Kiener 2018-09-12  617  

:::::: The code at line 498 was first introduced by commit
:::::: 4f3c8d6eddc272b386464524235440a418ed2029 usb: usbtmc: Support Read Status Byte with SRQ per file

:::::: TO: Guido Kiener <guido@kiener-muenchen.de>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--jRHKVT23PllUwdXP
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICLbvB18AAy5jb25maWcAlDtbb+O20u/9FcIW+NA+tMeXJJvgQx4oirJZS6KWpHzJi5BN
vNug2WRhO738+zOkJIuUh05PgWLjmeFlhsO5Uj/+8GNE3g6v3+4PTw/3z8//RF+3L9vd/WH7
GH15et7+f5SIqBA6YgnXvwJx9vTy9vd/Xr9vX3ZP+4fo8tfrX0e/7B7G0WK7e9k+R/T15cvT
1zeY4en15Ycff6CiSPmsprReMqm4KGrN1vr2w+tu/Mcvz2ayX74+PEQ/zSj9Obr5dfrr6IMz
hqsaELf/dKBZP8/tzWg6GnWILDnCJ9OLkf3vOE9GitkRPXKmnxNVE5XXM6FFv4iD4EXGC+ag
RKG0rKgWUvVQLj/VKyEXAAGOf4xmVoTP0X57ePveyyCWYsGKGkSg8tIZXXBds2JZEwl88Jzr
2+kEZjkumZc8YyA2paOnffTyejATHxkXlGQdbx8+YOCaVC57ccVBWopk2qFPWEqqTNvNIOC5
ULogObv98NPL68v25w/9/tRGLXlJ3a0dcaVQfF3nnypWMZRgRTSd12E8lUKpOme5kJuaaE3o
HKWrFMt4jKJIBZrrYuwRwZFF+7fP+3/2h+23/ohmrGCSU3uipRSxc/QuSs3FCsfQOS99xUhE
TnjhwxTPe8CcFAmcb0Nn0D1KlUQq1sKOHLnrJSyuZqnyOd++PEavXwY8YrvN4Wx5uwF5yhAF
LVqwJSu0Oos0mk0SSpTuboB++rbd7TEJa04XcAUYiFD3kxaint8ZVc9F4bIKwBJWEwmniO43
ozhsfjCTNwWfzWvJFKycw31AJXWyXUeFJWN5qWHeAlfRjmApsqrQRG6QjbY0/S67QVTAmBMw
t0KwgqRl9R99v/8jOsAWo3vY7v5wf9hH9w8Pr28vh6eXrwPRwoCaUDsvL2auIGKVGJ2mDG4U
UGiUG03UQmmiFc6r4qj8/sUuLTeSVpFCdALYrgF3Kp8GeFwfftZsDRqBWULlzWDnHIAMb3aO
VocR1AmoShgG15LQAcJMDKLLsl6PHUzBGBhdNqNxxu09OQrPF8rRTCyaPxzDsTgKR1AXPGck
Ac2+/dYbf2PlUzBTPNW3k1EvVV7oBZj+lA1oxtPmgNTD79vHt+ftLvqyvT+87bZ7C253imCP
jnEmRVUq97DAatMZbtUtca3onCXnCEqe4HrY4mWSk3P4FHTgjslzJAlbchrwPQ0F6HbwtrQk
cZmeXwNsNEpgXCrYeLiS+Pg5o4tSwKEZAwYxB75RK0fr5O16OM1GpQp2AheLEh0Qu2QZwcxX
nC2MoGxwIBM/cpEkh4mVqCRlTuAgk3p257pCAMQAmHjXOamzO/8Ie8z67oRU4JTZ3YVn54Qw
htX8jdBDcCfAwub8jtWpkMa9wD85KShzJxmSKfgDszkbRXXm+vIlqyuejK+ceKtM+x+N9ep/
D2itQ4ZgRrp7UTOmc7A6djWwL/g+zCk0+H66tHHtjl21AVnjCV1ra+yCGyE6ZicmEIGklTdt
BTH84CdcVofLUrj0is8KkqWO5tgduAAbSLgANQf74UqBcOz4uagr2Ti6ji5ZcthxK4uhRYqJ
lNw3CS1yYag3uSOWDlJ7Mj1CrWDMldF8ybzjPj0Ic6Q2kvZ4zmOWJCxxt1jS8ejiJFptc6ty
u/vyuvt2//Kwjdif2xfwsAQsMzU+FuIX11T/yxH9wsu8OYMmJBkESk4qQjREewtPPTOCR94q
q2JMVzMRO+cMo+Fg5Ix1yYY397xKUwiOSwJ4kChkNWAGA3GYSDlka9ilt97aGlLlel4/T+uI
RckKyZXjYk1MFZsDKxJOHL+e54777+Li+YpBxOnHtlyUQuo6J45BbCIIiMLTjMzg7laloUHi
bFU5yQIEGHTRDD0ZYQJysPAOwmpEuXt92O73r7vo8M/3JjpznHvHtBwv6vFkNHKlDyE9uJZ6
Jblmeg6+ZTZHhNvJyyaWEHTWiY6NJ2ji1+f7/T7iPOIv+8Pu7cFUBRpFHY62ppNDel2n6fjc
Mg5hNu65R/BgTV12EIqEL/GAFt22o5c57mYhHRmPRiHU5HKEMAaIqS/3Zhac9tYpehwZAhVT
JTgpWSdqHWZZzUkiVvWsxG93nthiR3d0yfbz29evELtHr99Pju23Ki/rqhRFXRWNk0nAt8El
M8nLudNjsMkjofE0TZTjXktk4Q51Tpe90sv97uH3p8P2waB+edx+h/Fg/RxOXIdNJJ0393Eu
xOL0CsJp2yyzhksAsbbja8xAUyuCQBSCew3CsFcmREIzRmSIaDqJua5FmtbaMzH1jOg5k+aQ
JSlmbjWqKVRZmwDmTzNTl7KZqjOBSKoMsl/wQDXLUuuwHM8/0yQGxjKw/eArJ55YqCg3Lcu1
zhzH2PqBZsPGlfumEjbK0pRTbtxJmirfQrluRh0rZlQsf/l8v98+Rn80nuv77vXL07OX3xqi
esFkwTLPip8bOzT17+jFMao0xgOiGuZs3vp7lRu/PhpIdyhuEzJSk2MRz7m3yKowCNRIAEVb
tMMzgnYGyGuPtT0/Hjyh5Hjm0aLNSUJqgZmDlsI43VWdc6XAtfYJS81z42MczqsCVAxS3E0e
i+xEIqpJyDO4X1XpRetGJ5DliSrG7uRNJRbMHC+sAOlicH2MgttCYmKJDIUKk8hVR2D1j/29
fXg73H9+3tqqd2SDpoNjJ2JepLk2N8iJ37KUQk7maEhDpKjkbrGnBedNTOEUdiVLqqEjafU1
tCG723z77XX3T5Tfv9x/3X5D7RoEFboJoB0A3MyEmSjYj0Ta8ipXwsSybuFClRnc8FLbewtX
W91eDAbFRj/8mp21DjTgB2wgJ5nRHS9qz/lMDhaHf7Q5ORP1OeG3cpjqytM58ANTwG1IEnl7
Mbq5OgZfpuwCKZc1TAtnqDHFjR12YDnxfjSZOwJybZoBErCR6vZjL4O7UggsT7uLK8fs31lr
Atx9G0KMTfcCYet+rPCMn1oMwtw+CGbSMHpSwessqClWsILOcyI9lxvWqF6Qx4Cy2B7+et39
EYgM4OwXDKvPwR1eezd6DTfFS/EsDEJsnDdwQSh8ncrcJlh4iQW88oJt8JEJBMumio0Kizcs
90dQNum5qXOj0wEBJJ+mkgD2RYD7wNJMICoLt0Vgf9fJnJaDxQzY1DLwSLMlkETieMM3L/k5
5EyanCuv1lhp3VLUuio6b9uZhE0BN1MseKBm1Qxcah7EpqI6h+uXxRcwx1ITvA1kceCgwkhe
GvMUOO2eXRdoFHIA0rTswP70VVKGFdhSSLJ6h8Jg4VyUlgJXW7M6/Dk7ahuW8XY0tIrdQndn
MTv87YeHt89PDx/82fPkUqHVMzjZK19Nl1etrpuaPV4GtURNNU3B9amTQPBjuL86d7RXZ8/2
Cjlcfw85L6/C2IHOuijF9QnXAKuvJCZ7iy6SJjFLmN6U7GR0o2lntmosTWlSDhOfB26CJbTS
D+MVm13V2eq99SwZuAW8j9scc5mdnygvQXdCV9v0x2EVajzPWZpyvrE5BfiwvAz5OSBOeaYD
Nj8uzyDBvCQ0sE9umhIBgysDvQgdan5DAIbCs0lghVjyZIZVmW02Zk2DIq4mtSB0smVGivp6
NBl/QtEJowXD3ViW0UmAIZLhZ7eeXOJTkRIvDZZzEVr+CvKNkhT4+TDGDE+XFyGtONNUSihW
jUwKZZorwjyWgDisPww4PmICyiU6malnLNWK68CDhCUSV7j7hGRmEfYDeRlwfobDQuFLzlU4
Amp2mjCcGUORTSEpUMaOh6g+SR1eoKDD1nAXHjc9MENTSr+Ej9HQjECmiVlV6zzXdVypTe23
F+JP2SA0jQ7bfdsb93ZZLvSM4apl75IU4PtEwU9qzG2YfDL9AOGGxM7BkFySJMR7QNVj/HaQ
FIQgQxYnrRc0R2S34pKBF/GaITSdmavklVobeXWIl+32cR8dXqPPW+DT5KKPJg+NwEtYgj7b
7CAm8TAlqTlA1rZndjvqV1xxgOK2NV1wtK9lTuXGiZab3/WSQ/oo3OvaIsKtVkp4oEnLynkd
ejxUpIGHTQqcU4a7XRtmpjgO85+dIVKg/X4+CtcCtjdoYqWEZ2KJ5hZMzzXknZ196S5Fsv3z
6WEbJbunP7suUccGpcQPYfoi6tNDOyISw+JC1ZTw5iwr3WdDHhjyQD33XpItdV6mHisdDO5c
VaBPOjQpEpI1BU2n09MslHKZryD1bl60nXCRPu2+/XW/20bPr/eP251TG1nZypy79SPI5tiJ
eRnh9mwh5z6u5vDUjzLpZy+P/qwwAjjBLIsJWvXqB3SVOTdLH3J0vN4EpGEa9F1Jyal72fId
jhtAnWMxZflE8mUghGoJ2FIGItOGwLxYbKcBF5uD0mIFobz+JFS9qMwrSDPC6ZCZ8QQSTtrN
0jzJO1ZLmkEdjg2GHxtoZdU+83CqNpLNvBpY87vmE3oCU25n+wjLeb+PFrgan9DlOReni7hP
/DrY1KkC2W7CHHTNKmLq65RBpgzSvqZjgfqpwAW21yJ+20eP1iI4NzoXa810v4N8zo2ntRa2
ndMd5xb7wJzRgb/sDqBQzqMk8wsSAMlJNgDm5k0ShlBcpj3muKbFVfG6ReERlMZiiEQ7xytS
r1OWmvKTDryyBawpoJoatjtBzYjMNjhqIeLfPECyKUjOvQ3YemVzyXuYpx7wuylD9b9hAJNL
0A2vvtsgTBjrwYynyMjGM59EmvLrib0sljmL1Nv376+7g/uUwIM39Wfz8vtEhxQrlJAKfKma
ZsvRxO1vJZeTy3WdlMLLox2wuXl4TOPQwE3EDrXK842VmqMjnKqb6URdjLBWMtyeTKgKPIeR
pDUMR8UjZaJuIJghmQPkKpvcjEZTpwxkIZORUytv2deAubwcuZvpUPF8/PEj3h3uSOzyNyOs
JDfP6dX00ntAlajx1TWerBmVBM5qRstp+DWUksTRobV5PwHXKkmZY41M36KWWq17ULmEDM1V
ZTpxXxwwBoY6j/aOLnWStxjIJCcX2LkcsZeO922AGZsRuum30IIhory6/nhKfjOl66sT6pvp
en1xdULME11f38xL5vLY4hgbj0YXrhcecNe8d97+fb9vHwt8s89s9r+Do36MDrv7l72hi56f
XrbRI9ycp+/mT1cqmtfDknL3MPl/nxe7jtaHfUMxnscjpmpCTNhVGovbvJR/OWyfIzBc0f9F
u+2z/TIEOdklpE7gMVAuzk1xFDedC0TnIHCKXS/kmZ7myarJPBuIs6+OVUCaDqR7ftgAJ784
CRVsWtr0+frsTBRJqDZl7RGKMWnYrBpE3P3d+FSRjIfeq9qyMyN4SQnyL1PvCdXuQqjlOoQx
sdMST2FiiEuqBK9gzQKVLdifYrh9B77gL3Bc+GqQLoXg9dKejP1CJDB6CRkRjrAJZB2qQRVZ
7ncvmzzqCa7h0+c3o77qr6fDw+8RcZ4TRI9OgtU9ZfmXQ5wMzrxv0L72QbaTCAm3k1DzFIvO
PSfa3FmtsOjaHZ2TO7e96qJA8wrNCY6UFIdXUkivHNlA6iK+vkYfLzmDmw9GhNf9iy/wql5M
c6OO+EmpjdIsH8YzpwtSSKoGT3xBKbGCoDdoyd3Hdy7KNrA99mcs5wU/HiFuGwq0NepMzO7a
T4h6u2AhdVFCpEwKSE9zk/wOJXI600yImfdlTI+aV2TFOIri1xBurXFUod3mmIPJCQSkmdcn
zJd5gr7YdYfBGFII78Vanq3Vytpb3JJk63T1zqycSr9nuVDX1xd4mGRQl+MzKFgxVJhy1hMn
h1bQyfVvV3iwB8j15AKw79wSO7MCtUKFXhAdxjEtRSFy/PgL7nUReL2esf9Nt66nN96LRVB6
gX6h1Q8pIeog8Be6I+P6zFcz7pyfKPk4Go2GUf8JHhwqftk+URO/hXpaMn+XSwmCUEShO5am
vi9RlCK5qvxvr9R6FrN64I2QkYx9wqcUGZGQZkr8QJWgXBTmu1oUq60iefvROcjlX2xoU4gS
bKyXdKxovc5mA7mejl1yzzzCT8BksFONfWPiDFzxu8HTiwZSry5Dj2uPBNP37lST47iTt1kP
WfOwsrQ0WQYxWIjG2Ltz3xOV802ozNyYLGNxbm4uA980lWXgy56MY+8ZIG5uexqmOuYdoEFR
onEuDHIB3iEQOBl0CamYGob6Dl7q7Hp8iR9Uj8ftscGDT/h4vcY7BQYP/4f8q0Hzco7r9Soj
ha9VTVekXiXY+x9Dfgx2klwz58Whh9N+PKbnp20IdFjuelMX5URHCJZCbiRw1MBDD1FScc8v
mq+6CaY87sDet2NIlnASlIwkbRsCwzETuIaQiuMIt77rwnWA/m6TuPbbRdmYlxU2hmuqFrbF
Fa2eTJfqp9OO3s+mFbbfbqPD7x3V42lLZRXIqJrMUnE8gbNvn5DGTp/FqeQ0IeEv398OwdyX
F2XliMv+hEQpcetaFpamppQ47A82ONNpHTSEPXzzhfrC1NIHs+ZES75uMXa71X67ezZP9p/M
x0df7h+2nuTaYcI8Iz6z4m9iA+ghX2yJAs3zzW+usE56Yd6ABdvEgkjv0XYHAxuAW0yHoLy8
nOB2zye6vv43RDeIDHoSvYjxfX7S41HA+no0gUqkQzMZBwLYI03SvmOQV9f4C5AjZbaA/Z4n
mZWBHrlHYVUy8MTjSKgpuboY44+9XKLri/E7R9Go8Tu85dfTyfR9muk7NGBSPk4vb94horjn
7QlKOZ4EUpqOpmArLXBDdaQxT1xMHvbOcm20+w6RFiuyInhZrKeqineVhH9SV5N3zkOA0cFr
Cc7ZT+GCvTOPzie1FhWdhx4QHynX+t2NU1KOx4Go5kgUU9w/9IerF3VpKqkh82jtp5dQG0Bd
KjzearDnGmmWgJRlxqwozhDB5i9vPmKF/QZPN6Qkp1tjximH2j8NyVKt12uCfSje4I1dcIrH
DU+bgpSaU2VL3EFkU18eehjzTtWJTTpIDTlyJmYYYpr00/TQhCNQKmJJEPgsnSwwsOSl203y
EHXgvWtPVHEwl7nAUt0jkQ0OCdUIY4onbMUL77XEEanzhCI75vbzJ/ekBygj9bP7aagm0wmy
6Mp8wi2w7eRkZitKGBvmoyUhY2S3FhV7n2v3OPOVit9/75lf8eS3wBPtI9HdnBXzCtPcXknU
5Wg8RjZmIp3B04wjbl0SrMF9xJfKULRvF06H92iI/s5zUK4lfjWPFKni5Ao7z+Y62RfM7rMO
+9umaiB4ShJXuV0kLyFBQKZ1aGaaisDwOSkgFg98StKTLWJNsL07JG2+e8JBYzVBHyFVu/Ca
zw3fxlwqSOwZ9iFUa60H34Q10OvrMr8erWtRhBxPQ0eSj+ML3KO0BCbHNJ4nbLobwjgnoYy9
DaWn61Ed/5eyp2luHNfxvr8ip62Z2pptUbK+DnOQJdnRRLLUkmyrc1H5dTKvU+uOU0nmve79
9UuQlMQP0Jk9dNIBIBIkQRIgAXDf27SGSecfwjDwHZNzhCz26BjBImxaDkMUx6ENmxIvjLyx
ObacH7Pnq4oqdmisNcczNXKd543q8ishszytMzx+ZyE6FMo6zjFpQ7tbYU4bkYL5QvW5a447
7TO6GO0EgbXyu6H/I9ZtnaY+5i1VVnMd8SXnVrjR0LQiDmZicCzcVJaQbGEahp86vt/bm9k3
XeC7JLrSEUPjUhFv8jvj22MZOCsH7949atU26cZ3Ao8KRbU3G0qxkY/qJQJ/rKzSADjGyBWp
b+8ix4eWXp+tTGbaGlKEwQ2ALl8adZbEju9+MJEYkc+JTN4BG3gfFHGkdgmBpcb8PsmG0lth
rigcX1Qd7Vukw6mO7gYxtulNkpd4juMYU4eDVX1NNKU9uAEVFy6LHdJWIAj8icDeY4wunAvS
pZqlSbgyf7setG8yd7lAtlWxGtVgYAZS/QkBonhicEi1ltvDYBsHNxU5kuDWnUDiij5Hetii
KFArjdON709HY7en1wfmeFp8qm/glElx+2plH0f2J/xkDkHfVXBZrKkhohO3yVH1lgKguNbW
7BaFhOIgTAr5tk2tBo+gaNbXCfhJg4Vkz2gQvrZJlWtZXARk3HW+HynXxROm1ExV4TqA9fni
UIMc/PGztG+n19PX98dX0z+v7xU3wIMtRjemq3avXvlw5ysGRjukZMFukIFMz2zAXXQeX59O
Z+m0VOpqqkAxJ8pUiTvniMj1HRQoJTJjgYX1rsPpSOD7TjIeEgqakv8gZBswgDBVUyZKuZuK
haEqsRVe5TuqtKCZkCSqXcsuMqUIexnbQjrHKp9J0Iryoc+poYafQ8iESddAWPzBenOqtOz4
IUnbu1GE66GCrN6MDdUmINOaIR27y/NvUAyFMDFhXm2mJxcviOqGHnFMqeDwQV1wKByaWBZ9
bkUsHU80CnU5l4CSJOjt7IpNYfGbmijSdDdgdy4zngRFFw4DXv+MtmPEpmNWPOFtF+qCUKy8
f/TJVhcQlBCIDG4kHIwNzxWii7ZMtE72WQvqKyG+u6Q4Qiht87DYDMEQOMZIi7vbpps41Rus
EkzlX+2iFjuAE8hNV45lY6lrQf6dehh1sduU+fDRXE3h/p/FgRTbIqXrMK5cTtOFrkn3xPOv
yGHTZrLjpbaG69Mv7duSH8Ppw7KDlNkQxqNeq+zG26y0uASO2w6LYtvt4f6d7WLTlsazsLL4
82XcRXo0bvQI2O1hCiIxGIQwGB7rsGyURkrEBcZzJf0+ZxgRroSTVMqaKVUVp+TKmELaVGvh
L8AP4DaUbfn72yMkfMpqrC/od1p+RAq5oyD8vCOl/xqsHCr75Ze1fLgxQSA+Qhp/U7GYlUXG
I+31fdezhBVzcBW/d3NT5G5S1ovpHyM73aaSrnipAILnmsINJUDf0u/w20KKrfbDdP1X/XV+
f3o5P/6gLQCW0m9PL5gfM3yWtGuuANLSyzLfoUHZonzt7HmB8ro1cNmnK88JFCkRqCZNYn+F
hSuoFD/MUqmtjpVYlUPalBmqXV7tDrUoEbUG2p2FOWrB7Dt5vJPzPy+vT+/fvr8pQ06X8W29
Lnp16AFITXQMmMgSqBU8VzYryhChtIzoInwssfLNPyB+ia9eN798v7y9n3/ePH7/x+PDw+PD
zSdB9RvVRb7SrvhVF4kUZoR+QSnhsxySnLJoRLZva8MhobsyQQPhNLJJXdJLyqv8gJlEgFPX
3wkyTpn9/2CBWvoEu8srQ0gkdG2/AgQ0HSNUs5NI2jtPmwldUfW5tgDMflkiHxddaZ7pfkNR
n6h40bE7PZxe2PJj+lywritquEfaW+6RGEm5w+05xmW9rvvN/v5+rDs1Ulgi6pO6G+nKqzan
L3ZfxD0S46p+/8ZnleBckjx1Omy6QhdwVJhVTrseTavKUCBb+gAzoAhnsfcNi9i0ut0uJDAx
PyCxhoFIO8HMtSdHEUEyBgoRmQikgMijDF42cPV2A24zbJ5XgEM+FzF03EqlanF1egMZSy/P
76+XM2Q6NzxF4Cuujqolgf8g/KbbhfJkCMDomrdOdsoiDWDhlG5hd1kMjEYexwxNmy2QLOpU
q0sXfgm1kb2tAEANlBF0Tn5WpRRjWQJ5MaCsSjdsE1ANPqLAms8ZFQgOterrGQClVktUdIHj
amBmZ6kFVIN8Sg2QQbgUyyC+zCgf3n/Zfa6acfvZYDSpsmlSM+mQNk3TQAUW9oMsTc3r5f3y
9XIWYqWsWawVTYHrLoAs67qBKHEe1ayw1Zd54A6OLha2nYUFK8tufx0WRtk0yrEq/dOcTDyf
cNPdfD0/8Wg0vRfgs7RkmT/vWJJvvUyBZCdG6DoiEenCNlcv3ii6vBobftM3lLnL1//BdDuK
HIkfRfztEqNk4QAo/HTBUc2ak0jyBDw9PDyBfyDdrFjFb/8tBwCZ/EjsFDswm7BzRNpwmEo/
NQDdyrseEiuId4J8MmdsrTfa9j99UrSf9eAEvkxb3a2Y0sAyyltYM9/PYFDmvuTMM0DkFPx+
enmhGharzdgF2XfhahimNUuGz6usyhmyaqoE2dGWdoirQz38cgh2FC63TlbBFHSrqvwMeFse
M607ypoa4ofU4L9aR0EXYtcqHJ3v7okbauV3SZX4mUtlpl7vjSK7oraWB7no5bNVBtSXQd7f
VTZu0lsl3NI+hrN+zaCPP17ohDHHVrg76jVlu0bv1SPt70wDcolyMDlzBxxqPJbEDvLBcvKs
XcQvCAclxwDA+6ZI3Yg4Vm1GazoX+01mdolaLuIoqqDb4r7eJVr71lno+G5kMEnhJHJxL0ZB
EPshqY54Vic+Y9hlo40ffsuoDQ3oExqIWxIasGy8eOUZXJdNFHr4kfGM9wPsfGoe7DBwMckA
/wONhzb1ez/yDLG45gQoBIBfY9vYYPgoGMySARHblxiBdzX++8/VEAU6kN+Ha23i97YIUKQe
mCawKY2zenJ14tJFmQQrcz56JCZme/lExQ4vODr1vChyzHlZdHWHpg5hi1SbkJXj6TxMqUqW
o0mzLdzfvFtjM1F8hWD1abrdtvlWf3BC5SWFdNYzgywDDKuE/PbvJ2HFIcrfkczJ1jp3FWNi
opJEkqTIGHJUDggWlEVPXwi6LdcJRW8g/Mrt6M6nfz3qTeCGJYS7ojnHJoJOyVMyg6FZjm9D
KFelGgpiRzJLAiWFlHj2UnDfcIVGdelGKCLH13p/+dizBKopNPg9vkqDOwKoNNgCJVP48s2Y
jAgjBx+BMCI4IsqdlQ1DQkSkhOjMBgL4KY3JQTpxZnGaaSNZ5pwIEt30KHBMOi90XRwn1OBF
zdZw7C0t/GJLJi371I3VdCsyuuoDm8+/TPb36pp1NLQMjuWgeoOdTbU5e/SqqjP54IF/puKW
Sxa4P5CRVhbhOZnyi97XHDpnSF8YzxJOge+qQrVOshQybNKFyJIpg3slwSS3PGgmKOxV8b3w
CgFLL2agBRLuFbYgqFRVcwJpLgiuxyTto3jlJyaGeQDK68KMOLoOwVSaiQDmXeCYJc4T1SiS
z9QPipQ3jwle5tt6zA/S5jphurWaJlJ0BAUj1fCgcYY1S1p/dsNhGDC+BUp3+7dQ3WafzdK5
zor1M8UQ1PtzHlTme4h9yjHIp5O7IoiLlCyKQqNo3Ozzctwm+21uskk1IxJy9c2oTeAwxVsh
cYlk7EyNmHwescEqugYKRsV+omFetg62xU0UoIPLhugEV83fpTwmCiai7L3AJ2YDslw8WANt
XAV+gLVk0ug/agrzJ/64vXF4pb2cIjJbQOVwRXxkDBgidnCE64fyoMuoEL15lyioWeJgH3fV
2ltda4OwWEJTEJl88l1thaxnbe87nme2ve3pKuebLdynHXHkY9mZ+9lONRBxHPuKo/ztsUJf
CWE6ZSIFZAgAe9iCJZHvTFzOXpHbgZ+a2CmpiJUJnUPd8mDPRFxvzALgnTP2GlLfFg1SwZQ7
f1sfKCN5Mx4LNdQKI9wkRcuTOeKbEPIJyxXKolKufmIvHSGU+UXQcDvBfmDNsfM0jXCzl4Zs
EVr2bIxAoE3J8sOmzT9fpVmGd8+fp7lKBceI6D7FzwtmNiUhZG7SLsYDorQg37M3zLMavXWC
6JG664q14q8kh5wBichgqp7fruFhGenjZfdI1bufxb3hz7+e2Ut1k2eocdxabTLNrQwgpirD
oFTFJsSEudKxD/hCT6dZMouMNundKHSMO0WZhIWnwE0TJDv4bqJuy5QFmCkFszBDZ8B2aYae
jrs01vmej8B0fznAVODBYsnDUbEnLOjWiXEwY31XrUv482tXlhIGV4VmAt8sLkCqCDy1H7ku
pMHg6E5jYpv0OVx1dOO2s/EBkTfDoPWhAKpZcmUE1ruNG7hY6Akgb4tg5RLWkZL7Vp+OTdIV
qaLuAJQWr7kvSGXxYGGVL/2UEmA84MrBgL7OPAMHDn5qyGWHqjN+iO3SAq0dXS5QfaQ4NAow
aOwhJUQrE0pViVCfQwzsYkrIjI1DpKQ40oDUCg70plBYbNaY7zYuWVf4pV9+z9ybML9YtmYx
k0obiEPR5C3zG7N8BSFKas9JOvM0X6fIoUSOZJ2hWmAxFKrpSQw2ny/LwLvIifReaHd+H6Dn
yYDt8tTwHmLwYhUGw7WVtKt8h6hMMZBxGMIwd18iKqGY2cE/lN++TdaD7zjarpGswQkbB9Z9
Y/DfV42Vc+16CmA93Lx7nj+MfZcqAwNY80aBQ6MwsnUsLbBUI8OYNCRllWBWLSjRxPEVC5Ep
1vilIUep90esVgaP8JPGhQA9/p3Rii4/tYVdnhh9Ju5MNHJxhYFA+cWFDo2Jg0JdHKq6cioY
xZ1CYOgq6xFFyTyWK8ezqglTMKCegBWKO5bEDb1r06KsPN/T5qW49NGA08WLKlN1ekuN2gQ7
IGL6g35RJwFFFJuqEgkUnseaLXTdKizdlVrisfKJY+zYANWvJhW0bu2aaPzSUKBXaCY1gfTI
oPPIjuOQzV5g7G0Wl1ZGcb5jKS6O8ZMNtsDWtxW/ErUqiBOJaqWqH7vaPifC/nRgtRkM/tIs
xoMmp9jCeYWXXXFtqvv88RSOK9e3xOja3N4Wik0xQMhPXfaJfEy1EIAf+54HEnR7zXFnoQI7
kD8AO9FdrZUqS1tYZpD6DJ1rQYFBEgWSxquimK2CfZb5nnx8I2HY1oRiNCtHxci2joSZjg8N
jCFVCkoVKxk1WSzId9NpsjnkmpGhYXzbN4FrESFmPaATSyFyLYuORoQdSkvSmOx8z/d9nBWr
Z5IUlM6shKt1cJKD76EDX3Rl7Kn3dwoycEOCG4ALGd1eAtQKlEioshISjAGGQcePnbui8qVv
/CrGt7TG7ksh0fBtES2aooIwwFBg6viyeaKguJljxalvJCjYKFhh5qFGEzi4+Aib58MCYnz6
MFToWRhnhpEVFVk5YnbcRyxpZp2GixzX2mMU635QvLDHtSh1BR9GeO0URc1FS9vShtCxxKwJ
iajxVwQXoSaKfFTuABOgwl41n8PYIlrU+MTXc35ha/sGH9TZXkS7vdns73OCqkkS0SGKnADl
laEiOyq2TJDmiPvxLxTsRh3cfq+yNpmtaCXMfL3+OdWWcJHgNvIHPHZu1SSoy5BK07HcSFgB
fhWFwfVp3pVbyBmM9vGi02GFUxPZCTAfe4UmcleohFJLxydU3rB6JesSxbkeLi7cWnQ9nOHJ
CL3KMSMinmUmT/bmx0Uo9qSOW1lb5ltUwdnutOPQlVqyJ011FlyrMYTuOKdiZEOknU9jFoCS
6LQsWsU+adMpcRAeMMXwEO+JHTqkuV4dQHZ1X2wKNQMZS7rLsJbMXAsBeGngbyNwGoFXDFUZ
MV55SHciXGftgUUHdnmZp+a7UtXjw9Npsmvef74o745xTpOKPTsjmPmpYnnOvbE/2Agg4rmn
loudgj2/aUN2WWtDTR7gNjxzIVlwktu00WSpK75eXh/RJ3SKLK/151fVjqp3fQvpTyVfqeyw
Nk1Ksx6l/jm66TI/7agLz1wTVIA6QFsLE4+l/PPp/XS+6Q9SJRLLyiMnAIAXQ5MsaSBN9e8k
kFHi5bSxKnZ126mfsQfs4eQUrgbHkj0GI2doBJp9mUuOSvPTLAaDsriaUYa8YyAhnH1WHVbl
IjRI6nU+xPa4L+D22vcgqzr+yuAovvocdHr++nQ+n15/IreDfLr1fcJemJE+gsObhMdfKl2S
DplLFRUeYNYernCilKBNov2OnTbwgv96e798f/rfRxiX97+eEQYZPcSQNqW0WMq4PksIyx1j
LGszPnLxY1edKhyuVSFbdho2jqLQgswTPwxsXzJkaOO86l3LzadGJKsQBs67UrwbWM6rVTLi
YZqbTAQppomFiyF1HeXwTcH5XGFDqx7SlYMfTMr8DSUtw++szWT40L4tCrJ0taIKhmfpyWRw
SeBfkTEqIPhVj0S2SR1HVXANrCVxr06GeXIhDLmW1kRR2wW0axFdQHy/T2IH1dfVaekS3yL4
RR8TzzKf2sh1egtrQ+k5pN3g2M8VyQht/8rSMIZfO/CGn5zNAllm5PXn7fEGtr3NK93d6Cdv
U3ghO6t9ez89P5xeH25+eTu9P57PT++Pv978KZEuriV0Oe/6tRPF2HGGwAbK0SQHHqjx9wMB
EpMyIAQhpVCiAkHoB+WOikGjKOs8ovoBYk39ymIj/+uGLuCvj/Co2emsNlrek9vhTq18Wi5T
N8s0Xgt9FjG2dlG0CnHJX/Am0xT3W2cdF1ljGtwVIY5eLwOjfv+s1t6T5w+A7ks6el6AAWO9
8M6/JSvL+wDTCLvoHeYkKQ4mKW4co0KByZRjDAu18j1zrBwnCkxSN9Bk6pB3ZIj178Vkz4jB
LkfxvjdrpeUPOn1izg7+eYABQwTo6h1BBc6cB31HdyT70NA54lieHmKCsY6CxPLcwNKlIUHl
tb/55e9Mqq6hGoXeFoAZbaHNdsMr3HI8dmA3S6nn6oXSOY0nCQFkGaxwN/Sl8SuDzd3QB/he
LuaabzABE8vzbdMzK9YwSmo6TRmBOTYJPLwkVqmdK6CNAY1NueZNjFRosokdXczzlDjGqgNz
0wvwy1o+YFTNdh3LY+wTwYqgl3GAb/vSjTyNaQ50zdkRaO24zwjdgMHSqjN9gjH9f1LeQZpT
sVVY5RjWjEiflLwDXYJCtS7ka144VZr0Ha1zR23cbzfJd3j2/PT86Y6avqfnm36ZV59StoFl
/eHKXk1F0nVQ/3/A1q1PXH1bBSDRe3GdVp6vr8DlNus9zxlQqI9Cg0QXlXJrfZRlnrwO/oII
E8l95LvuSHvh2uxnbeTx3V329xeoWB8/OlcixxR3tlq6Tmeshqw2dfv+z/8XC30Kd6LGssG0
hZV6U6ccUkhl31yezz+FSvipKUtdRBr0Ochlc6Ntpis9uu8xVDzPFngRV5yeTDnVbv68vHId
xlCovHj48ocmJLv1rasLDsBiA9boQ8NgmtTCredKl0QG1L/mQG1egk3tmfLaRdsSu3ucsYM2
I5J+TbVSfbWia0EQ+D/08ouB2vm+TZqZVeMiIghLs2fbR27rdt95xtRLurTuXdupzW1e5rt8
Psa4fP9+eWYPX7OHrm5+yXe+47rkV/nAzDiBmdZUJzaVx0bThlVLxjBY+LPkl8v5DZKVUPl6
PF9ebp4f/21f/djD1eMmR+uxnR6xQravp5dvT1+RfDCZnD6D/jFWBZwVrQsM2im+0QDPGrpk
DViWP5WMJTTp8nIDJ7LYCFGiu6oTuezUugG+WU+on/9hlEuZqDp4z6Gpy3r7ZWzzTafSbdaQ
RHKOUMCQ8LJbUpZ1+jtZspsu6DJPWJqZTguXBgrIpzhSkzYbN0VbiYRQaielcjo1gG3zCvKp
o62CBttwXXqbzzmPwCX98fnr5QEOd19vvj2eX+j/ID/emzLCIhMj1ZaUzIYTpitKEmDp9ycC
yDcFR2ZxNKhDoyDVxAbXeON6QVuZObBZ8+sqz5TMgjKpTHmgvagydKB9pzdxn6E7AsW0adJC
Pq7brNLknWHKQ2YUJrKJbpu9pcwm2bEnHqcXyV/Op583zen58azO54l0TKDUvO2oZFqSzUq0
3b4b7x2HCnvlN/64o0q4H1vsmvmrdZ2PtwU4QLhhjDljq6T9gTjkuK/GXRmovcJpsG7hGH7m
e7WCvCyyZLzLPL8nspv2QrHJi6HYjXeUibGo3HWielUohF8gLGrzhe7n7ior3CDxHIsRNH9V
QFLpu//j7LmW3FaWe/dX8Ml1TpVvmQAIkmvXeUAiOSKSMACDXlB7VtRqSxtUu6u6V/56dw/S
hB6uyw8K7O6JmNDd0wH+ufFcUsQyKdnNeu1EVF9ZnhcpRv6cr26+RAFF8ilmbVpDD7Nk7quC
yUizZ/k2ZrxEZ7h9PL9ZxfMFPWY4hmLsVFrvobad5yyWdPhvsgi0v4uBuSeVXdNX7BLGtWl8
o/nFSpUCOgRR7/PcogNSKLcLf0Ve5iNVjk+p6RpEtF2qcPATRXHARKbdknfIaZRIQLAj126R
siw5tWkU43/zBlZaQdJVjKP7664tarSCvCG/bcFj/AMrtXb99ar1vdqyM+DvgBc5i9rD4eTM
N3Nvkds0AGOhKuBlmFTVGUPKXU1WJJc5xwz2bpUtV86NQ/dGIgJJj5TwJ9oi2ouJ+LSb+6t8
rimpJLo8LNoqhJUee5ZVM6wsvoydZfzR8CfqxNsF1/eqRLv0Ps1Pc++jHgBddn3kEu16Hcxb
+Lnw3WQzJ9enTB0EtglI2L5oF97xsHEoc2CJEjiqsk0/w9qqHH6ytNkR8bm3Oqzi49zyuUey
hVc7aUK+EciHOKamZyeQ41crS7syyfrmYGm2yDEMw2nhLoI95TlkkvpLP9hnVJN1WQCXMXfX
NSxGslM9xcLL6iSwU5Rbhz496qpJz/2NumqPn09bcs8fGAcOsjjh5rlRVbsjDZwqZQJr4VSW
c9+P3JUrczMaUyAXDysWbzXusb+YB4zCV0zyS/j68PX+YrAYImJrTMaTFOgdfMcaU5ABc6hf
x8ONBKC8i0ysoJENaNGYRrsZM8xFsmMlcMp1XJ7QpHGbtOHanx+8dnNUifNjOskWKgbYyrLO
vcWS2EtVEGPKzPXSvXb9jFQL+1EDvC/8YVCT7TAA7M3cPemdQLDr2bjmjhMavppWtN6xHOMy
RUsPJtEB3sVSS13wHQuDziVmtTR4Ag1PGYYRZGt1omu4XDblwjGmGRA8X/rwZUjD2KFsGTsu
nzu+WmtnFARHRJCflt7iChZTyVuwcfmXIW4E8WHl6yyChDBFrYnBV2XSDoz0pEBt32Ny5Umd
BwdmnIA9+LpzPQ61isqtTZTITpoYC4BNqDe1zRy38SxvIxjGF4l2p7Xnr2jeeKBBRtd16TTR
Mo1HBsGXKRby49SAyBic3t7n2sRUSRkoUv+AgOvFp6rCa8fzK30muixIVy8a4OuSvBZKgPZz
w6o9H2Tpzevt02X2969v3zCotC6XbkKQyDGZtnQ4A0xY/51lkNynQRsgdANEt7BS+LNhaVrB
ATuNs0dERXmG4oGBYJhINQTxRMHwM6frQgRZFyLoujZFlbBt3iZ5zOR8rYAKi3o3wafBAgb+
6RDkGgIKaKaGY9Ek0kZRlFzpTpxsgA9O4lYOwIAtBtE+Zdud2nmMltUrT7hCjhI2DhWTxg5X
qfLdvw/R3QnzMih/PeM2dt6JhRG/ZWiqE7CA8KjZnBRYEyvRK/Bzh7DLT/XCJ1l1IOhdw9RJ
SJBHK7JEbZDjW9FKZkfIhS8GHt7e/Xh8uP/+Pvv3GUhMej4zaW5QnorSgPPefpbo5vipFMKp
cxN+CF6sBGQakJ3H6NX6y2NGVTvGozIwwhr/mCYxhdTNkSfMEFeDRq3XSztqRaIkbwZq3Etv
HlhRNySmXPs+2XcqDNHYw87ljpx+S9hKqckDTMkqLeniYbx0SMcfqfUqOkV5TnWsd9AkR5oo
yZA+WLlDeWHtSZ8WgmMYfwE7Uqi/WqE9gKMmV9z3JdRhq1kcmCRR2tSu8CYee25o6odivGhy
JUETz81Efju4ZwwVPwCnKYMfUyS5ugIppd5Jo2YxJnscfzdG2Wlzdm9kPy93+CiHDRuvJUgf
LFB5oNYRRFEj9Bk6uGoUNnsEtmRQRYEuSzWn0whk1Fu7wHI5l5SANHAxpnotYZLuGXVJdci6
KKFbRiG2DZPc3t9oh/ocvRSIS/CL4lwEtqh4wCqjUNHQnu+IzIIoSFOzIWF5Z2undB3ZfErA
YGZqhtsunPuqMlCgzyXchvR1iHhYTdsiR12alSTB1x3bdCWYLF5rE50YyJRbHbJQB5B80VLv
dos4CxkZlkRgN2pWHwFLgXMs9LwpEsGuSOkMlaJ0vVx7ldox6NawB5SK9mfq9kRME4mI9Wo1
xyCFlahXcmDJUagbbR06V91DmFIXQ7t3vSpGJrpGzKegy/+skNdHlu8sDGA37JwD91WTYeWQ
II20GI4CmMQ6IC8Ohd44zg8eN9ZNAdOXwVdM1MpAQENeSQeeN8CoaGcU8KBiSWu0LKoKXmxq
DYy6lUpOQyygTVoz4vjLa6aPJ68rtrVOZVHZVxxIOyh6wqqN5UolsH3TAZMLk5TXem/KpA7S
c04xtwKNWQ2j2CjVgYH5vF5O4uV/0zXAIrDvv4EoYrQVlqCB00QoLsn804Kiwmcy/ZNDmVhb
MlURRYExQ3BM2z9JryBW60HFp1yLUISqX0ZtARPDYrp4WyN1EmRaE3WSpJhKMdGuPehNmTZc
H0RFeqWKUwNfHwLOJC50BOFd+FupPQuq+lNx7psYxidBjSJw0RhbGg43nlhS5gr8Dk4T2t22
Q2PWwy6kuu1YRZanLbmnH6xKzDsBYiwrauOEPDHYL5bKvyRVoU/yALPvwC/nGPge/ZThcHRi
2IQmNNZdh4lgqOhXLH5ZpyRIS9vyz4AFcF1H5qQpBm8M3k+ym+iA1bGN2galP2JPrlmPKE2E
LwAdczUZbCbWsA8V3hhB4qAnNXsf1KuTKR56IgecMuyxUZGLUR+lnDpOLjZmEZcbkHpf7CKm
qkskrnxycVOBmE6r0Ajh1MR4qVsV2qSY9azh+qTBf3ObkId4kM527S7g7S6KlRr1ioI8hzsk
Sto8OVJOtZ0Lw8Pb3eXx8fb58vLrTcw34e+ItQ3RV1FGY5zONiroFEdEK1lRb9vjDs7q9Fpl
SBWm4lbiNW47y5zgvSSmWITd5WHvsCtPBjrfNnB253EX8vYv99+UlZoP8pRYcy9v71cz3IkP
tVyd5nPjM7QnXDc79Roe4XG41WL4mTQl/AGxMOFk5LWJzMi9hKhkaP23Aa0wjj1MYlvX+loR
+LrGpSLMm6wdFIQbTpnzyK2TuTnFFz01rjPflUhkqQMjczvLkzmIDSwHKNzPrfz1gpOHATEN
RGH5FAMcQ8taelEQI5F3r+O5Zg95unaIboxgGFuhT321RqvNm9WVGel7qlaKQOFc3actGBdv
p0CcRY+3b0RSTbEZokztt0jbLHP8CDzG2pjrLBrayeES/q+ZGFtdADuezL5efqLB5OzlecYj
zmZ//3qfhelepI7m8ezp9vfgIHb7+PYy+/sye75cvl6+/vcMs8TJNe0ujz+Fle8TOmc/PH97
GUri6NjT7f3D871ptyYWQhytVUtWgLLSFv9O7OI45552hiMIxEmune2ZmPa4irTVJ8AddZdg
7/H2Hfr/NNs+/rrM0tvfl9fROU58oCyAsX29SF674iOwoi1yOY2EOE+PkacvX4SJ+8MyJoG3
96g7zWacYhtE0WIz+Q7rDVNGIGLSdgxTNQbGddbDRX8+KNtmXFtyI4ZlJ70zI65XiFnPLBHq
X/UIGJcTzgC9SbrU53qjfUL0j5ocMsTbrPEkmoBVEYZU146MHlntPcWRS8J12jESFe28hWPp
urh1d0lg+xhDyne2ZagmTNJED38hN1TCgUzH+ZWpOh1Vm1GOexJdkpXJlhzQpo4xo2lh6caB
cTIDlUTCyuAzWbWq1pN7E28TPYbBNToQnj4i3awd17PtoInG94zFPqy7AGRDSm+jjPRID7Rp
SPg+OfMyyDEtzTU8jUs5s3R1X4Ro2BF9sM6yqG4bV/YOkpEo+NOYgq9Wrn7Uy9j1gnqqk4lO
jckn9rg8OGSWIZep68kO7xKqqNly7a8tnfocBQ2luZFJmiAVCXmp2nkZleuTT+OCDX2AIKIt
AxDuDOlsPKOSCsRvVsFO5zaGc6A9Z2FhOxNr23U0ngJhUn0CZp7s6AmOwYIe+PFo+RRFqWpQ
ZVSWszyhPy4WiyzlTii6txld8Mj4Lixyy0zzxjF4j/HD1h/s+qaMV+vNfCX79MinsQjNIkko
qtxGXmBJxuTw9z3I1S6TIG7qhjhuDjyhzCM7aWtb1EJDrIq5Ojc8HPvReRUttR0TnYVdjgpk
saYaFlw/Hv3iFUKXb/GNqbeQI3oq0G22YSIjcJdhRZtbBhJheNhqx15q7JS6CkCOPrCwsmQ6
FJ0vjkFVsUKbFZGaWpPFMGOZYN037FQ3sq9Kx66gCnajHeJnoDupoOSLmJ+TdnaihAf/ur5z
MnQCOw6iOfzH88m0RjLJYqlawIupYfm+hekWUVi4GccKV2b5/ffbw93tY8f40kuz3Elcbl6U
nVAbJaoVFwJFNrpD2JAxyIPdoUCqafwjSLCbbXge9Bb6FJforytr2a50XetRAPc9danV51K2
exM/2zoqpUU+wiKmA6vaWTnOTgdv8GOp7hcdYhd7nHsuaTPZNyPCwgl/ofHj1L9/Xv4RyVna
/zO+yDnb+T8f3u++U7q1rlKMJFUyT/TK92h/u/9PQ3oPg8f3y+vz7ftlloGkZK6irjfo+5bW
mfI20GHyAxORmkYs1TtLI/JKqQo4RPiR1SLe0zgZGekonyUZJl7ayzHQOsgYW0tK+83fH+5+
0FG0+kJNLq5vOESbLDE2m1zLhwqrsU58Z0cPDWXboIYQdWiSgQVq1ISZ0EQ1wdrhXW6yukBc
WOHJleOZvzuiR2K+TUwLCSA1v6coH+Sw1H3Z0aMDc2/ZxbNWmwswWSB1jHWdibKlJ0dQmqC+
DtUiSHewaj5HP++F0W6SOr4716NdyBTCRGquVSiArlGb1ZxqwC7luD0j8EYOfzxC544O1WO6
CmCX7FuvtodqSZYESk3y0TWHOSbMyUEwmTejx/q+CLCbdRpXvazvkxGrJ6w+EgQuiUkt1/6c
Th074NeWGAHTVPi0YDsS0IGtBXqI6F8HdaPvoDEDtQzUTeN6YOS4Cz5f+8YAtQC3MmqKg68t
/djVwiN3U1F7/o11/RkWdt2i6gMhq9A6CjC+qg5NI//GORnr0sjmI4Fv9KqNqNLj1vH/pQH3
dezC7tCgjHvOJvWcm5MxAT3KPZnBD6ajSigk/358eP7xh/OnuEOqbSjwUOYX5sam3ulmf0wP
pH8q1prigyA7Zf2MWXqqZG2IAGJuAWMAGFowPJNGIt0XEKldpk1nHCXEvC7d1UL/kEZQ3q71
beY5izFkA05J/fpwf28e7/0DjfLipbzc1IxOlqAQgfzFd0Wtd67H7pKgqsMksOFJEweFIiL9
ihWSIKrZgdVnax2W5zuFZnhQm16eHn6+YwCWt9l7N3/T0sov798ekFnB0AjfHu5nf+A0v9++
3l/e/6RnWQgtHE3ttaN8HKeIKGsspgFdBprtEk0GMjYdjVWrDM0dc0tPgiZWMzCh2hGT+qH7
L538mMHfOQuDnH6pquqoY1QoTwRMXCceQyXPjhFmZmuWcAcjh0jnCpYFprsCANsk3yruCggb
c4gAd5QnqdoJJecm8mkV6sS3gJG/U3xsgxNDeooJ3XBUSWZSyh0m/MtAuA6WUtocYXK9Q2ib
bbOaQkx7CJrE5rToyz10AvBNW3ZNjxMTPT5cnt+liQn4OQfh5NQqfYQfqqQ8zV9bBSyWqgyb
jRkvV1S6YWoaSH4UcErQ7erRvjNA2qw4JL1TCbm0erIhkAb9wt0TwWFU0rFntWFIS7852VUa
jcyEwQ+Y7OqAbxGs+qwIzoCKMXd5h6Jrasuq4YpVDC5NKmKuhJY70MdhyJK8mT5bDzzEZWBQ
hhjcQ2X7egzLy4bWsw+N0DlLtWbgFz65SBChBWBFnYY6sGKyIZiA6ST9yKa+CGhOCv8dTuuP
gKFdIu8NSHr/qFEOfLh7fXl7+fY+24FA+vqPw+z+1wUEOVn6HmLLfEA69XJbJWdaXwLc6LZz
u+kBEYb5UPT3HcSaK2lEd1eX2AjsS9Luw7/c+WJ9hQwYOJlybjSZMR5dWXw9FeOBFPNZxZVR
upK9EiWwuyAGKRCUe4CEV93oJ8TaoUQcGb+kOrKWkwKM4MzrOqjCg6xMYUZY4c7nOG4LQRm5
3rLH6x0dKZYeUth7DHtMezeXEVeGChKKKlKMcO4sM1oAm0jm6+vdErUY4wYo3VkkX5NC+USw
XMxds8YaJCOHqhEQzvVRIAXlPCzjfbJFZ2Vp0aXEygGfZZ6rmr32mE3qW+IgD6sBzlH447gt
9QwrETFWFS0x8UyYJrnzfWSgouUJH4wLol9ZGS1J9+qhxfiz44ZGjTlg6jZwldS8Kq6gERmz
I5xlTOHSICwjcpPB7gzMIgCNA4da+IChr6oJ3xD9Exbpnz0Dzn3X/A7CEqM/BM2FdbMmO5aL
ckubVmSqOiYfKRU8PqgQTXRIzrbZlT19yPbruawN6OFr1zfPQAD6REMIbjmdeqwn2Xf/poyy
7yJO2Gunq3XFUIiaXn1V0dQdxyEJKanWvQm1XjmuIoZ2lq+wst7ee/unUYPahfK6u7s8Xl5f
ni56AoIA+Eln6ZLvPT1uoYQN06rqqn++fXy5F2Hy+niQIIhC+++KlB/EK+Xig9/uWq37Wj1y
SwP674d/fH14vXSJH+k265WnNioAamrVAThkHFW781Fj3XTe/ry9A7JnzFfy4Twoxxb8Xi2W
csMfV9YHGcHejDE4+e/n9++Xtwft+96sSZsSgVBCulur62z6Lu//fHn9ISbl9/9cXv9jxp5+
Xr6KPkbyKKWm/Rs9iVXf1P+xsn7tvsNahpKX1/vfM7HscIWzSJ7RZLWWD4geoKeQHcBaKlVp
bduaEj2pLm8vj6jts31gqSGXO0aex76Vj6oZTdKJ/Tz4dN7++PUTC0FNl9nbz8vl7rssD1go
JNm3Y/Zbw92w32VfX18evspS+a4LqjipWIqcnsK+qNmUkWh8UhnVSbuNM2Bzqbtly9tNuQ3C
olDNzHLGz5yXpIdlp8xso3TfntIc/Xj3xy+VdFNjrIFNrf9uA4zVsVzsgV2S2+qxYbxceosV
xa30FBjFYzEPc6NigVgZHejCfngx0di1gCA9CUbycJbUyS0ReLJ6XoH7NHxhoV84JHyxtsGX
BryMYth+CwNeBev1yuwOX8ZzNzCrx+hkjkvAkxI4IqKeneOogTUHBI8dd00He5ZIvDkVflch
sNXukVleZAKfGIcZPUXCrG8ohWpPgAFY0shcZ3XK1+7cnPkmcpaO2QMAr1SRZ0CUMRRYza/s
gaPQ5ha1nIxEaDqKrCzyJK+5jogTxbAjI/QoKjJmGXWlCZyeNRxhDWnHX7KFSG3eBeC9fftx
eZfsxieHfxUzlD6xFPWsGNFlI8c8YUkah40InyE5z2X4fI2KFy6ceqaLqopOPUbOTfYkFyyr
YtNbq01qnCKNN4yTjrQYhAEOPEkDku5FhNyi2Del1KmeEBpI4BhNFJVJf3xSMCPiBsJ2PKaJ
h8ytCtsrIeGg8MmCIn8mWYozH08jqhCifMdWytEVPRJuYRFCJZKVki5XwkVxlKzmFmWRTHTj
6gLLiBVRttuICsMn92LM5ynNfX1MlxgIlJoQjLVCwQ+RbxmMPfe7RNQlQ0dhVnEGPgJnladF
tDdYiujx5e7HjL/8er2j7HXwaU953uggsPTDRFnIHFNIZrIFgvDtRmt/2ND1chHKwTrIVseC
AUvDQso+OuaFy3aSznp4aEHSJ61sZ783QhlMUCN5/nUnC7KTD3czgZyVt/cX8Y4nOVhMR80H
pDL7hS0JRezGdNurLk8v75efry93lAFRlaCTLEwtHVaNKNxV+vPp7Z6sr8x4/y60FSaAAKDl
VkHY6ezpppUmRsU0BlZBC+RhRuF7Pn89grQivat1CBjSH/z32/vlaVY8z6LvDz//RN737uEb
zGqsycRPINwBmL9E/8vasyw3juu6n69I9eouZu5IsuXHoheyJNvqSJYiyo6TjcqdeDqu6cS5
edSZPl9/CFIPgITSfaruIhUTACm+CYAgQFrVMrIMWucDZvp+MJuN1a6aXs6H+7vz41A+Fq8F
r33x5/LleHy9O8ipcHV+Sa6GCvkZqb5H/t9sP1SAhVPIq/fDd1m1wbqz+H70QrmY26Hbn76f
nv6xCurP1ERy67twy04PLnMn8fzS0HcrHTzT75ZlfNXdHOrkxeosCZ/OJKaARskzd9e6jcw3
UZwF1N0PJiviEjaSYCBGJaYES2khT+KhosCmQ0o5Py8oECLZdfET2vZYpn590+t4R+7/430V
qsfJqoD4nzcpPbbPBSN7sDS5FHXDGsz2meo1FEsRyEMeSRUNvDEkMwuE55ojn/dy2JMoM6Cf
0szGnHTUUyirIbsKRbXxXZ83AGtIygpC3HOazIZAZL7veEzhrd0ybyGal8j2OcHawgTuSLfL
JTas72F1uOBIa3JPT+GN/QGHBfvMfAN2pSXFXwK3C1QU3NhqSJagqSHB6p9LweahjWm/KmAJ
dSQeJhHXlmu6BtySD1RNT/fHAY1oe9o3+lDEYrWgOQbtU+IztQE00ocBNHSNEjglOvgGZKql
DCwpepEFLl5SMu15ND12rLRZRignuX7Fx0OH6Zs29TtW4M0GfPgGI5f1Z50FZeRgH/AKQMO2
AMjUorW8Zu9WQ9doxL2PvtyLCI2bStLx0CBDarzch18gvgEbEjQcefTiN8uC6dhXg8/LrA3e
Ujsi/GTCxmTNgtkYG35KwNz3XcPSpoGaABqlVgV+5RQZEjMxblJEGAwYMIvqckZiOAJgEfj/
b3cEtbohAi8MVYBXzdSZuyVZcVOXXtwDZM6ruqfeZGKQenNuViqEZ5FyV6ISMZ7S64yJY6Xr
ZCnPbuXrWkr26QDaWE1wIzAQRVihZvVA3acz416BBhhQEP6mZ0qiLcv0HBtTQ3o8p+n5Hqfn
4wnJnygjNMkcIOC+8Jy9DZvNGlgvjUKMP8cFMCeGgjm+mSUK5rA5rQo+T5RuPDNLvNnFaV5A
ZPNKuU/nlCmJZCHI0ljvp+x+lmwCb2+0Lq1Cb4xDXCvAzDcAczI3NYjzwSkZFtfxcGxgCXBJ
eE8NmVGAh1W3ABgZAayD/XzCNioLi5HnEKNoAI3ZwCyAmZuhmDf1rasHmMmxCbbTGba4UELk
DlhK0xxZYUSRJXVCuriH7wbgEow6XESKY83yyLSCrxSpQwLJtDD8GKKFjQUJt6jBrueOZhbQ
mQnXsYpwvZlwaIjOBjFxxYS1PVJ4WZbrW7nEdD7AsWr0bMRquBrkZGbWWui3BeZ3Msmb7weG
E5zNp+HYx9Ntt5y4jrnyGjlvbxTz398Dq2htFzEJYwhMXxnLEywlD7vsHI0W4Pm7FBGNQ2g2
oufFOgvHpuP1Tk/QFaClo4fjo3olKI5Pr0SODKo0kHztumFb0CaoEPFtbmEWWTyhbB6kTbZM
wQhTE4ZihrWESXDVcAxdk4pMTB322h8qkZTggF2sCsrpiEKM+Em2u53N92wHWR2iHeGe7huA
uufU4f6oZ9qGu9NiAd0NDHTP+Pduu9jy8RzJRFOEaPpTq5BE0ebr6tRr3UDOEEWTz3A41asi
rCKInFIZn+VxZDgNXDOUv5EAnOeLg57hPFvlOxNyP+6PJg5Nz8hIS8iYfWwFiDFhc2SasAa+
P/fgKQV+qt1ADcDIADgGP+dPvHE5KBb55FZBp01Zy5/MJ6ZQ5k8ps6sgPIfnTyeuSUoD8RHU
1OF4CMBYfNhowOJmZpgaRkUOntFZnkaMx5QDlqyDywsSwFRM8CmWTbwRSQd736WshT/D55s8
3cdTen0BoDnLClTa9nPmma/TNML3p7ydmUZPeYmxQU6w9KGPlyggdjsfronOVOr+/fGxjcJp
LXKt5lPxPNk1bhXwmw5VcPy/9+PT3Y/OeObf8MwrikQTCBddhShd/+Ht/PJndILAuV/fwa7I
MN3xPd5+5sMitE+nh8Pr8Y9Ukh3vL9Lz+fnif2QVIO5vW8VXVEW8UyzHI2qdJAFT8hj+vy27
D2TwYfeQ/ezbj5fz6935+Sgbbp6jSh/jmPsVAN0RN/lb3MTO4LGrJYj2pRj75OBduRMrbR7E
CkZ2oOU+EB6E4A45GM2P4IY8iI671U2Z86qOrNiOHFznBsAeM7oYuL/mUeAq8wM0vCk00dVq
5DkOtw7tsdQswPHw/e0B8Ukt9OXtotTP7p9Ob2fDsmoZj8f83qkwY7KFjRzD6UoD4z0TsJ9G
SFxbXdf3x9P96e0HmqN9RTNv5LJhm9cVFZLWICGwMdOJU9ksieBRIc5YCY89o9fVFm/dIpGc
nk/THhkpqyF6l5Tbyxu8WX08Hl7fX46PR8k6v8uOYSxIx6y2qMFRVkOBpr4Fooxu4tK4Yhpi
6tgo0lh6uZhN6fC3sIFiOjTVEGb7CealNztYWhO1tKhNO0GxX8AUHIuXimwSif0QnF3LLe6D
8upkRE7ID0YWFwADU6eJcbPQQvvbCP20V4XzYHbrL3ISj1yiUN+CIgNPihRWJUnLzYQ8WgmK
SMxH/CwD1Jxsz2t36htpPL3CbOS5M/qmQ4JYQ1mJ0C4SMOmE1aQCYuKTYleFFxQO+0hGo2Qz
HQdfp1xJ2d+VPYCdcrcCg0i9uYPVOxSD/VkoiIut4bDGPDVdjWt4UeZE2fNFBK7HPmYqi9Lx
PdLUti7DLiuqksRXSndy0McheWUoN2i5i7PD3KCQrLHJAzDOw/nzopKThNsUC9kU5ZeD7Iwu
CXIMaXytI6rL0YgG3gNzsl0iPG78q1CMxi46ghSAXva0vVTJ8fEn/BWmws24LgTMdIpVSSId
+yPUpK3w3ZmHLAB34SYdk7jGGjJC7dzFWTpxqKyvYVNuJHbphNw+3cpe9zzqMYluB/pB4+Hb
0/FN3wqwR+blbD4dkK4Axd8JB5fOfM4KDM2FVRascLSiHmje+mDU4F1NsJJ72U+vpKCMuMqz
uIrLAXYtC0e+h41tmy1bfZ7nvdpKf4TGrJk16dZZ6M/Go8GbKpOOF71bqjIbEeUzhdOzysC1
DG77fpWbGXrO9E6hDB1f1vila4vAhA37cvf99DQ83bASaROmyeaj4ULE+va5LvOqDdGCzlXm
k+qbrdOLiz/Apv/pXoqlT0dT7FyX2uyt0Wdx/IN6Di1rWW6Liui9EEEFHizSPC9+UpC4EUvB
Kc/4yjan/JPkkqVcfS//vr1/l7+fz68n9SbGOvvVWTaui1zQneHnRRBZ8Pn8JvmTE3NX73t4
L4zggad5s+GPTT9kGDdjbz0Uhry/BFWHPHj5giTOHfEKDcD5H+Bcx2VdtBWp4zpGUGK2M9iO
koNGefQ0K+auY8YzHyhZ59ZahJfjK/CHDFu3KJyJk63wxlp4lIWHtCkiKxjhVKN0Lc8ZdGBF
hRhhZpDwJzF2ObYu6HAnYQEdyjIPReril7Y6TWvXwEjtJGzk0uuWTPgDt2USMZpa27JRaQxl
+XmNIbWo/DF2KrsuPGeCMt4WgeRdJxaAFt8Cjb3XGuOem3+Cp0fcQS1G8xF/HWLnaybS+Z/T
I0iYsOzvT6/6cZu9YwDXSpnEJApKCLQR1zusr1y4xC1wQRw2lEt4U4ev3ES5xLoBsZ+TOSbT
PjnKJDm5+wKeaeQMBPHdpf4odfb2sdp18Yet/7XHZd2m54k5kafhqRlVvPykLH0gHR+fQXtI
V3e/lGDrdgLwRJrxASlApTxnmVS5fyaZjqych/m2SGN2MUPJaEDT/dyZUAt9DRvYv6tMylW8
kYRCTQdY6xvBigcK4ZGXWKAscmf+hB1Trv+6yYiN7mVCn7QUZHkSAmBQZXFar9MwCgd8uAEV
+PBZViR4BoCbIWObDXjlko8XOACtfNbNyKrWbFR5dXH3cHq2AwlJDNjdE99MsmYJp/jIS/cS
YoBh63yrZDT9iiC8rHlHJXJ7jCv8WgZ9X+MWZZiJatFcA/O26IpQ+z5aXX9AAkHWb0RInzvq
PW19cyHev74qo+O+Vxrn/9SLLQLWWSJZ9Eije9kjzOrLfBMo37xAxo29zAwRACFqT5WXJbHe
xciIfBtjtDtvtG1iXJDucpoNZlqS7WfZlfIISnBZspd91zcGz0aJLvZB7c02mfIYPNCYjgYa
bVRYGfloN6Sk3CwoinW+iessyiYT9qwHsjyM0xyuTMsoFmYZyjhEezPmlwOlGax/JfHwzBdP
ajorUJlg6G0E9+kYQdS1MiFXKvIUXAaiVbHZ73I3UZknxAy9AdWLZBNJUSIphkwszHe6UcCp
oDc7/fAXJ7vtrMvbgMHcRkQBt281oYHrGB6ewNalFejXF28vhzvFLpi7i6jQd2UClFMVuIkS
OMRmj4C45OSNHKCsGzyEE/m2lNNeQkSexvRbDa73F2i4S6uQK+YWUq9YqKiIK9wOnoktO/k6
goJ1md+h+wOkVeLbnYk038WKM1ZfigSPo0y28cDqTR7xQWGBSAfsG7JjRxRGMDyECVSoxIHc
Arz9GxUTixisz7kFBP5RJJux77XR2Jk050R5C0ZMq+nc48/LBi/csTMg9EkCs/UEaTp64RQV
1mOZIqvzAj3RFAl+nwYpOBMNf7siTbIFjWAIIL2DhVXJReNSOgT5exOHaG6HEFUUG9BLLgOi
TkRRjMWkvPHv0sqP9ImIvgk/gdcBtQeSft8FwM9LXn4pwCZWsLoJwOUikSMQpvh5Cryqw2xU
C6kX8ORQ9hzCgbO/GsDEpRm82QGrvxsTjyZaLQ/D8kbFjuDrtpMneYXO1w5k83Q9arFN5Bzd
gHXzJgCv/hxnsxTatSDyc2gCEg3Qrl77KgQdXfftq21ecUseYt0txbjG7zE0jICW8gsEEOrY
C/1Qat97S/4IzWW70+CmZl4nhoe7B+wLcymZtHAd021CgZSHZL6jNH6diCpflYGxV2ik5abO
osgXX+T8r+0gg50fFlVTze29Ht/vzxd/yYndz+t22ZZ5WNMTUYEuByKLKSRwlRWa3wpYBKsY
wg0mVV5axUlmO40k18eUeBmXG7w0DIFDCkS0egrQr7IhKUrS7IOq4hapPPCXTfhx8nIc/ump
hJkiu/PQbgm+/WA9ykpLmZAb701cXeflJaZCPEn7OZTeeUZ6RNgVBTEbjpFEDNWQmtfiqbCJ
m4FVADlhHWnHjnI1s41riGAM5dEuiWjdo0RABLB6GxXobTH+BneKylUB7w7k7pOjwCuw45lJ
aC35oBmlVGw3JeZIdbpeUf+gDXR41YVxsTb2gxaTLElRkNZrn72QBSw4C72Wu6GIQ7mZ9p4z
aRnXcQBP4CEg6pqvE1BtpayR8mtA4YeWgEJae34PHfC31+GBOy1UAK0PCH+hfs12xhPkUTC0
RwcqL4uaF/xIbbBLYpnoAqh8Or2eZzN//of7CaPl52O1p41HU5qxw0xH5AkmxU25a1ZCMvOd
gYJnvjdY8GzggalBxOuQKBFrQWaQuENVxCGYDAzS9xqY8SDGH8RMBjHzgRrMR5MhjE8uio1c
3JKlJOOhT86mRtMSkcOkqmcDGVzPdwbHWCL5LRuoAhEm/A0v/i6nKMR4j6/uiAcPNM7nwROz
YS1ieFK2FLxHI9IwTm9LCMa0yzu4UdvLPJnVJaVVsC2lA/fgUvDHUbJbcBhLzjjk4FIY2Za5
OdcUrsyDKgk2gw1VRDdlkqas9qYlWQVx2iglTUwZx9yj9hafhBB1LLJbmWy2STXQ+CTYcK2R
8sAl78wHKLbVcka8A6ScgmW7SUId6rcjbEBSki8zKXfdquvqzjc5JxXm9fUV5tuIGKffRxzv
3l/gJsPysQ7nGP46pOsyvtpCKLPhA6qJGC7HGnKA323+RGqksjgaPjAloo7WUg6MS9VU1ss1
8AtKVstioXS8VZmEhKFqST7ITVhtMAMIlUAGwaTWcVpg0YxFQ8iD9edPf75+PT39+f56fIGA
v388HL8/H1+687N1kN1XOUCrJBXZ509gBn5//tfT7z8Oj4ffv58P98+np99fD38dZaVP97+f
nt6O32C4fv/6/NcnPYKXx5en4/eLh8PL/VFd1PUj+VsfOOri9HQCC8HTvw+NXXo7R6RsAo2S
Avcm35D5plDgEkLyZiGKYMHqHzTpUq4yHOsCzb2BerTo4WZ073DMqdrxbTCR8lZTFL78eH47
X9xBOOnzy4UehL69mli2aRUUCRJ0MNiz4XEQsUCbVFyGSbHGU8ZA2FmAnWWBNmlJPLp3MJbQ
jobXVnywJsFQ5S+Lwqa+xLqttgTwC2eTys0yWDHlNnDC2TWoLa9Nohk7aUqFZ7CKXy1db5Zt
Uwux2aY8kKuJ+scJZW2bt9Va7mdWeY03Ka1veP/6/XT3x9/HHxd3aoZ+ezk8P/ywJmYpAqYG
EXeYNLg4DJkccfhxnjISgVVhuTHtYs/33Xl3RfH+9gBWJHeHt+P9Rfyk6g6WPf86vT1cBK+v
57uTQkWHt4PVmBCHnm+HJMy4Ll7LEyXwnCJPbwYcNHarbpUIF5vGtusrvkp21udiWazcnXbt
OCzUUxvYn4kis63Ggn2h3iCXC7vHqpJrDavl6mq0YLKk5fVwlpz5ciHrSoRsDd5/9Gl5ol6X
KvadmS2AgBXVluNE2mqDP6J2WqwPrw9dJxptzwJ7Jaw10Krsh/2905lak6jj65v9sTIcefbn
FJjrnL2pOaD4RRpcxt6CyakxH3St/GTlOlGytCd8s72bRf58qmfR2N4wI5+pXpbIaa6ub3lD
0HZzycBB6vAHAY/t7nuw50+Yz0rEiI1J2i7JdeBaLZBAKI0B+y5znK6DEdN5IuMknhZZSTZk
ka+YfNWqNJyKmBTXhRFZQW8Tp+cHYrfT7Ub2oSNh2kWatcg220UyoBxqKMqQ9VvZTsL8GryE
WgPUIqyH1e3kDLJYSk7Mhh9oT65GfEaE/WB6AnpifStiemSp/jNfuFwHt8EHJ6sIUiFPBbve
zXFhT5c4thk1yUgUxLiim0T2+qriwGpSdZ2z3d7A+w7UU+X8+Aw2eMbzz657lmlQDSj3mqPg
lr+GbNCzMatFbfOOrWpK2NreI29FFbVVLg9P9+fHi83749fjS/sOlYgJ3QwWSR0WJTbOaxtW
LlZGeCiMWXPHgsZw3K/C6MPVRljALwn4KI7Bgqi4YRYesJK1ZOw/UBwbhC2z/kvEsjt+iQ4E
huGhg7pBqDtTkvl++vpykJLTy/n97fTEnLjwdovbhxRcbijMulPPvX52pAGRXmitvRP7CU1i
zzpAdfwkKoGrS0/4cXW4zQXg7Vkq2efkNv7ssh/hDly2Mr/MiwJ1d5yZRa05hi4QN1kWg45C
qTcgfHXfIIQstou0oRHbBSXb+868DuOySpZJCJfv+uYdXT1ehmJWF2WyAyyUwVFM5WoVAjSr
HVZPO3hL+Jfi+F9VINTX07cnbRh593C8+1sK58iqR93e1VW5FY0upyQ39DZefP70ycDG+6oM
cIus/BaFikT2eezMJ0iXk2+ioLz5aWXkxIewoKL6BQq1KOEX1Lq/SP6FLmqLXCQbqJQcjU21
/Nw9rhxa02myiYOyLiGaNjYxDQzTh0UimRwICoQ6q7VKlPzPJixu6mWpbN7wwGOSNN4MYDdx
VW+rJCVh18oIG2rJ9mSxlJizBQlMpDV1QWqXWYQJuDkOChtlgCUrLSXHBHuclyB3QilsblsW
VG1rcsyDGECTnb6UrliFkSsuXtzwBkKEhOfRFEFQXusJbOSU48VnmpADOxwbWTnHYXLbsQWf
EF2qaDmnT8vZFOUZbXyDuoU9TJ46KVl2kmVQDv7pUwfFSPRwQh3FNhxYDKYYBUb0HWJ/C2DU
DJWu9zOyvTZQZYBZcOJjQ5DoAKhmvqDkhNweWa3lnGbyQWiSD762CL8wmQYU833j69VtgqY+
QiwkwmMx+1sWDKyftbSU7jbQ1ifdKSPyMJHrdBfL9pYBskaSswYWI7YQBZAZuxW+mgYl2Fqu
Y2q2LPtorfKoEK1Au+ye2JFLD4kBlmgo9qRYpbru6MNXeFdJ8wVN9XMb3dXATT/TKVUuBWUc
HjdMb+sqQCUm5RXwC+iLWQHxxdCkTxbLCLUcjHRL0E1V2OWv0qxHcZFXGAaHDt2Iuuc2xrlA
Vfzt4augzy+np7e/9ROUx+PrN/sKR505l8r3Pu77BgxGCLyGVVvQ1mm+SuURk3Z65OkgxdU2
iavP466vGsbCKmGMZsDNJpCjMDgDCF77yMKXOjfZIgcOKS5LSWfIU01v/qeyY9lt3Abe+xU5
tkC7yC56zUGWKEtri1L0iJJejDRrBEGbbBA7wH5+50FJQ2qkTU+JOcOHyOG8OOQsztBopz39
e/zj/PTsxPaJUB+4/G0+nzwUp6LPymD1ky42wSPiI3TYp0bPASQwm2qf69lSBFLSR3WqX67e
JrAZ4jqvVFegseQvLzq0/DMTizQfaQ0zeYCG7dXnyy9/SnqtgG1goHjhnQnWYNBQawBUh5IB
Ar7+nFvYCHstPIs/CZQ3Osws8qaI2liIrhBCwzuUdn8XMJ0+sq37gqqkeNgm/DJXPl8g4FGx
cdFF86Twk9r3UYr5RSaKcLs3Of79/kjJv/KX0/nt/dlPlF1E25yCCOtrwXOmwvFUjdfv6vLH
Zw0L1Llcal9zGPrJO7wgIvRwNwtiwrpNE1k5UVSAaeb122MM3mBqB93BxQgYG7gCjvb51hYg
UPQARjx5JkR1dT403/4Xc4jenB7CYcqD1LFdwWeR14GJgg8tykA7bgyhgygL+hlBw650i6zF
mGIfZW89K46MtzJvSuvZBn75waIfzXKM8yQEfJy/TK07naaBwm5PV1A4+FbjOG6L0xlzh3LB
Y+TAgxIHNDZhlrTSzY2mvblVo+f26Sxa6i83Ro4AA5nTfdmHq7QAjGPSZnYRkufMC8LFVJV8
Dv5R90QpQVdZXk+JKhDpovz+evr9Ap9ge39lnpLdvzxKUQ4LGOMJe+mFxXvFGI3fofPDA6L0
L7v26nJUXMp411XjK8mC1ZZpuwjEfH346nUh0aiHj+CMQxOriT0csg6Ir40aLTSnv8bkY3GW
lIK2iQlw01JxWp9GDnUBjv3tHdm0soWZDIfgT6/Ql/dURrGssnut7ZBycSF2xuDN5kUSBg3B
FNWYawi/RDCyX0+vTy94fgkf+fx+Pv44wj/H88OnT59+Ex4EvDxBzVGexinEeFT/gMy1uxIM
qKOem7Aw0/pYCYxzEG6iugW9ojW30nPhaN4lkgrLF9D7niFgcJc9BdeEPfWNFzTOpTSwwGyg
mGhTzZmvAyyuBVsJMAKzVBunl5zFTpPXJR8NCvYS3hJZMgin79WMgv9BBeM2oXBx4DNg2G/9
6KZ4R0D5SaRTwbwdOosHKED07DFY4cM75vczKckb8R+Wwd/uz/cXKHwf0Dc206TJrzYXiuH9
DZ+QtvMadFkmB4VPqUWiyR6SqI3QiMB3VnI/MGl1xH7nMaj4oJ3k0X68w1nHnaoS8F6KxWmI
JAHhmok7Si+kFHsVniUEFNQDKdQjd/8iWCvVrfUUQwgz1zLMfXhjwPuOcIaBFbOOXM+044HK
I1B/4ru2FN4MS0/WwECEHOHfeBf/MJChR7KxzyXIUg7T5FDmF8L31B74A1uoPTR9joZC2LNo
yl03aHrpdnS8Fy1/qkrWQuOPz+tvcCdon6hy3nS28VBi4hIOdZSJ5WlxgwOa2G73fpRefQ3S
NnWjUG8nuarBMFm6haVZv4/muG7VGhtVTSZ9GQFgMJ+Cqd0AO4EVocyXezMLNBzKI2vxESZM
O0QVzMJ17gEd6H8VsbmzbcbUorEGnlkmptx+9a5OThRw2ABdZ0VU7zzLVxDTiLDSB9hdRVTR
hSfZzDbGVF/ue9LZph3xGIR7HlhCNZMi6rB+iiwIPjF4uW8Rs4nw/eT51b/vr8eXt6fTg8cB
pcuqPZ7OKLNQFYsxFdv941GEGHeeqk4/hySIYbHPHrnM3NK4VBgxRz8mcBAT6DOiR8K+sm9B
LkiZgpmzhq9HqJuWr1j/pMKwmmTIq/2nUb5na4vUGJ0YECdFdWEB7LU+Gveap4+tGzBikA4d
p5FvFXSWuROrgsPx/qTa7JJWVxJYTccTtAZY4DJKkVt0EulOBcJYrL8ZNBlSmlb2xAbDgVbg
Bg3Qcl9iMtRFLPIc4TZebwz4H7K/RfjgelbD9v0Pz8wtXihbmRn2I3MIusrgHFYTV957HlS+
A0Bbam9EEHg8r5SFm7zlkzq/KSimPMkrXpsuX4He0jHEMnwwy5cxajzvatGFsjKfS7EfBM0T
/eUAJuSd5nUYvh0t8nB2b4rZ/vXmA0NC4lJZlk2lO1kYiOfSWUmOoht98+cW3wpp14UStpXm
dQF6v3jLicmFrzFPrxHQb5UJ8xG6BEyMQZ5iL+8GngsSPsvkS/ctKHAgnKvCFDEoK5oJN9RF
Iy1vtZpYrg4KYPMB+7cUdLE2u8rAxzX/AWibOkZSggEA

--jRHKVT23PllUwdXP--
