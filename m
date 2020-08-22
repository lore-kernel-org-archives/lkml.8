Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F27C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 06:50:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D35C206BE
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 06:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgHVGrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 02:47:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:42530 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725863AbgHVGrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 02:47:03 -0400
IronPort-SDR: 4b68gZ0yDcDSO1RJayMX8khCYwphrHa6SfnnFtgAEWCWXpiZtXz5bEV4coVhndSpLVNQNuIMB3
 NtHv99G85RWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="240506267"
X-IronPort-AV: E=Sophos;i="5.76,339,1592895600"; 
   d="gz'50?scan'50,208,50";a="240506267"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 23:40:56 -0700
IronPort-SDR: nX7JtWRH1XC1fVb/wGersk5agysDKHP/MHmSYKjW7WlEGM/T6A8VkLJfJM1hu8yFb8okKneEO7
 swOXiUu4c0Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,339,1592895600"; 
   d="gz'50?scan'50,208,50";a="327956937"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Aug 2020 23:40:54 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k9NCw-0001Yp-0W; Sat, 22 Aug 2020 06:40:54 +0000
Date:   Sat, 22 Aug 2020 14:40:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/gpio/gpio-mpc8xxx.c:430:27: sparse: sparse: incorrect type
 in argument 1 (different address spaces)
Message-ID: <202008221459.YfyuDkeu%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f873db9acd3c92d4741bc3676c9eb511b2f9a6f6
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   9 weeks ago
config: openrisc-randconfig-s031-20200821 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/gpio/gpio-mpc8xxx.c:430:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *regs @@
   drivers/gpio/gpio-mpc8xxx.c:430:27: sparse:     expected void *addr
>> drivers/gpio/gpio-mpc8xxx.c:430:27: sparse:     got void [noderef] __iomem *regs
   drivers/gpio/gpio-mpc8xxx.c:444:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *regs @@
   drivers/gpio/gpio-mpc8xxx.c:444:27: sparse:     expected void *addr
   drivers/gpio/gpio-mpc8xxx.c:444:27: sparse:     got void [noderef] __iomem *regs
--
   drivers/video/fbdev/pvr2fb.c:336:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:336:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:338:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:345:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:347:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:349:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:540:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:541:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:560:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:569:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:573:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:574:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:579:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:581:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:584:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:585:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:591:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:595:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:595:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:596:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:600:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:612:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:614:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:616:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:788:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/pvr2fb.c:788:26: sparse:     expected void *s
   drivers/video/fbdev/pvr2fb.c:788:26: sparse:     got char [noderef] __iomem *screen_base
   drivers/video/fbdev/pvr2fb.c:820:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/pvr2fb.c:847:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/pvr2fb.c:847:32: sparse:     expected void *addr
   drivers/video/fbdev/pvr2fb.c:847:32: sparse:     got char [noderef] __iomem *screen_base
>> drivers/video/fbdev/pvr2fb.c:849:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *mmio_base @@
   drivers/video/fbdev/pvr2fb.c:849:28: sparse:     expected void *addr
>> drivers/video/fbdev/pvr2fb.c:849:28: sparse:     got void [noderef] __iomem *mmio_base
   drivers/video/fbdev/pvr2fb.c:1057:11: sparse: sparse: Using plain integer as NULL pointer
   drivers/video/fbdev/pvr2fb.c:233:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:233:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:240:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/pvr2fb.c:240:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/clocksource/timer-fttmr010.c:424:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *base @@
   drivers/clocksource/timer-fttmr010.c:424:25: sparse:     expected void *addr
>> drivers/clocksource/timer-fttmr010.c:424:25: sparse:     got void [noderef] __iomem *base
   drivers/clocksource/timer-fttmr010.c: note: in included file (through arch/openrisc/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
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
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
--
>> drivers/clocksource/sh_mtu2.c:442:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *mapbase @@
   drivers/clocksource/sh_mtu2.c:442:20: sparse:     expected void *addr
>> drivers/clocksource/sh_mtu2.c:442:20: sparse:     got void [noderef] __iomem *mapbase
--
>> drivers/usb/musb/musb_dsps.c:910:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *usbss_base @@
   drivers/usb/musb/musb_dsps.c:910:21: sparse:     expected void *addr
>> drivers/usb/musb/musb_dsps.c:910:21: sparse:     got void [noderef] __iomem *usbss_base
   drivers/usb/musb/musb_dsps.c:921:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *usbss_base @@
   drivers/usb/musb/musb_dsps.c:921:21: sparse:     expected void *addr
   drivers/usb/musb/musb_dsps.c:921:21: sparse:     got void [noderef] __iomem *usbss_base

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=670d0a4b10704667765f7d18f7592993d02783aa
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 670d0a4b10704667765f7d18f7592993d02783aa
vim +430 drivers/gpio/gpio-mpc8xxx.c

e39d5ef678045d arch/powerpc/sysdev/mpc8xxx_gpio.c Anatolij Gustschin       2010-08-09  327  
98686d9a52eeea drivers/gpio/gpio-mpc8xxx.c        Ricardo Ribalda          2015-01-18  328  static int mpc8xxx_probe(struct platform_device *pdev)
1e16dfc1baa745 arch/powerpc/sysdev/mpc8xxx_gpio.c Peter Korsgaard          2008-09-23  329  {
98686d9a52eeea drivers/gpio/gpio-mpc8xxx.c        Ricardo Ribalda          2015-01-18  330  	struct device_node *np = pdev->dev.of_node;
1e16dfc1baa745 arch/powerpc/sysdev/mpc8xxx_gpio.c Peter Korsgaard          2008-09-23  331  	struct mpc8xxx_gpio_chip *mpc8xxx_gc;
1e16dfc1baa745 arch/powerpc/sysdev/mpc8xxx_gpio.c Peter Korsgaard          2008-09-23  332  	struct gpio_chip	*gc;
82e39b0d8566fa drivers/gpio/gpio-mpc8xxx.c        Uwe Kleine-König         2015-07-16  333  	const struct mpc8xxx_gpio_devtype *devtype =
82e39b0d8566fa drivers/gpio/gpio-mpc8xxx.c        Uwe Kleine-König         2015-07-16  334  		of_device_get_match_data(&pdev->dev);
1e16dfc1baa745 arch/powerpc/sysdev/mpc8xxx_gpio.c Peter Korsgaard          2008-09-23  335  	int ret;
1e16dfc1baa745 arch/powerpc/sysdev/mpc8xxx_gpio.c Peter Korsgaard          2008-09-23  336  
98686d9a52eeea drivers/gpio/gpio-mpc8xxx.c        Ricardo Ribalda          2015-01-18  337  	mpc8xxx_gc = devm_kzalloc(&pdev->dev, sizeof(*mpc8xxx_gc), GFP_KERNEL);
98686d9a52eeea drivers/gpio/gpio-mpc8xxx.c        Ricardo Ribalda          2015-01-18  338  	if (!mpc8xxx_gc)
98686d9a52eeea drivers/gpio/gpio-mpc8xxx.c        Ricardo Ribalda          2015-01-18  339  		return -ENOMEM;
1e16dfc1baa745 arch/powerpc/sysdev/mpc8xxx_gpio.c Peter Korsgaard          2008-09-23  340  
257e10752c13f2 drivers/gpio/gpio-mpc8xxx.c        Ricardo Ribalda          2015-01-18  341  	platform_set_drvdata(pdev, mpc8xxx_gc);
257e10752c13f2 drivers/gpio/gpio-mpc8xxx.c        Ricardo Ribalda          2015-01-18  342  
505936131ea71e drivers/gpio/gpio-mpc8xxx.c        Alexander Stein          2015-07-21  343  	raw_spin_lock_init(&mpc8xxx_gc->lock);
1e16dfc1baa745 arch/powerpc/sysdev/mpc8xxx_gpio.c Peter Korsgaard          2008-09-23  344  
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  345  	mpc8xxx_gc->regs = of_iomap(np, 0);
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  346  	if (!mpc8xxx_gc->regs)
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  347  		return -ENOMEM;
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  348  
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  349  	gc = &mpc8xxx_gc->gc;
322f6a3182d42d drivers/gpio/gpio-mpc8xxx.c        Johnson CH Chen (陳昭勳  2019-11-26  350) 	gc->parent = &pdev->dev;
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  351  
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  352  	if (of_property_read_bool(np, "little-endian")) {
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  353  		ret = bgpio_init(gc, &pdev->dev, 4,
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  354  				 mpc8xxx_gc->regs + GPIO_DAT,
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  355  				 NULL, NULL,
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  356  				 mpc8xxx_gc->regs + GPIO_DIR, NULL,
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  357  				 BGPIOF_BIG_ENDIAN);
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  358  		if (ret)
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  359  			goto err;
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  360  		dev_dbg(&pdev->dev, "GPIO registers are LITTLE endian\n");
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  361  	} else {
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  362  		ret = bgpio_init(gc, &pdev->dev, 4,
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  363  				 mpc8xxx_gc->regs + GPIO_DAT,
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  364  				 NULL, NULL,
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  365  				 mpc8xxx_gc->regs + GPIO_DIR, NULL,
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  366  				 BGPIOF_BIG_ENDIAN
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  367  				 | BGPIOF_BIG_ENDIAN_BYTE_ORDER);
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  368  		if (ret)
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  369  			goto err;
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  370  		dev_dbg(&pdev->dev, "GPIO registers are BIG endian\n");
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  371  	}
1e16dfc1baa745 arch/powerpc/sysdev/mpc8xxx_gpio.c Peter Korsgaard          2008-09-23  372  
fa4007ca06e4c8 drivers/gpio/gpio-mpc8xxx.c        Axel Lin                 2016-02-22  373  	mpc8xxx_gc->direction_output = gc->direction_output;
82e39b0d8566fa drivers/gpio/gpio-mpc8xxx.c        Uwe Kleine-König         2015-07-16  374  
82e39b0d8566fa drivers/gpio/gpio-mpc8xxx.c        Uwe Kleine-König         2015-07-16  375  	if (!devtype)
82e39b0d8566fa drivers/gpio/gpio-mpc8xxx.c        Uwe Kleine-König         2015-07-16  376  		devtype = &mpc8xxx_gpio_devtype_default;
82e39b0d8566fa drivers/gpio/gpio-mpc8xxx.c        Uwe Kleine-König         2015-07-16  377  
82e39b0d8566fa drivers/gpio/gpio-mpc8xxx.c        Uwe Kleine-König         2015-07-16  378  	/*
82e39b0d8566fa drivers/gpio/gpio-mpc8xxx.c        Uwe Kleine-König         2015-07-16  379  	 * It's assumed that only a single type of gpio controller is available
82e39b0d8566fa drivers/gpio/gpio-mpc8xxx.c        Uwe Kleine-König         2015-07-16  380  	 * on the current machine, so overwriting global data is fine.
82e39b0d8566fa drivers/gpio/gpio-mpc8xxx.c        Uwe Kleine-König         2015-07-16  381  	 */
4e50573f39229d drivers/gpio/gpio-mpc8xxx.c        Vladimir Oltean          2019-11-15  382  	if (devtype->irq_set_type)
82e39b0d8566fa drivers/gpio/gpio-mpc8xxx.c        Uwe Kleine-König         2015-07-16  383  		mpc8xxx_irq_chip.irq_set_type = devtype->irq_set_type;
82e39b0d8566fa drivers/gpio/gpio-mpc8xxx.c        Uwe Kleine-König         2015-07-16  384  
adf32eaa053234 drivers/gpio/gpio-mpc8xxx.c        Axel Lin                 2016-02-22  385  	if (devtype->gpio_dir_out)
adf32eaa053234 drivers/gpio/gpio-mpc8xxx.c        Axel Lin                 2016-02-22  386  		gc->direction_output = devtype->gpio_dir_out;
adf32eaa053234 drivers/gpio/gpio-mpc8xxx.c        Axel Lin                 2016-02-22  387  	if (devtype->gpio_get)
adf32eaa053234 drivers/gpio/gpio-mpc8xxx.c        Axel Lin                 2016-02-22  388  		gc->get = devtype->gpio_get;
adf32eaa053234 drivers/gpio/gpio-mpc8xxx.c        Axel Lin                 2016-02-22  389  
345e5c8a1cc30e arch/powerpc/sysdev/mpc8xxx_gpio.c Peter Korsgaard          2010-01-07  390  	gc->to_irq = mpc8xxx_gpio_to_irq;
1e16dfc1baa745 arch/powerpc/sysdev/mpc8xxx_gpio.c Peter Korsgaard          2008-09-23  391  
787b64a43f7aca drivers/gpio/gpio-mpc8xxx.c        Russell King             2019-11-19  392  	if (of_device_is_compatible(np, "fsl,qoriq-gpio"))
787b64a43f7aca drivers/gpio/gpio-mpc8xxx.c        Russell King             2019-11-19  393  		gc->write_reg(mpc8xxx_gc->regs + GPIO_IBE, 0xffffffff);
787b64a43f7aca drivers/gpio/gpio-mpc8xxx.c        Russell King             2019-11-19  394  
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  395  	ret = gpiochip_add_data(gc, mpc8xxx_gc);
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  396  	if (ret) {
7eb6ce2f272336 drivers/gpio/gpio-mpc8xxx.c        Rob Herring              2017-07-18  397  		pr_err("%pOF: GPIO chip registration failed with status %d\n",
7eb6ce2f272336 drivers/gpio/gpio-mpc8xxx.c        Rob Herring              2017-07-18  398  		       np, ret);
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  399  		goto err;
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  400  	}
1e16dfc1baa745 arch/powerpc/sysdev/mpc8xxx_gpio.c Peter Korsgaard          2008-09-23  401  
257e10752c13f2 drivers/gpio/gpio-mpc8xxx.c        Ricardo Ribalda          2015-01-18  402  	mpc8xxx_gc->irqn = irq_of_parse_and_map(np, 0);
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  403  	if (!mpc8xxx_gc->irqn)
98686d9a52eeea drivers/gpio/gpio-mpc8xxx.c        Ricardo Ribalda          2015-01-18  404  		return 0;
345e5c8a1cc30e arch/powerpc/sysdev/mpc8xxx_gpio.c Peter Korsgaard          2010-01-07  405  
a8db8cf0d894df drivers/gpio/gpio-mpc8xxx.c        Grant Likely             2012-02-14  406  	mpc8xxx_gc->irq = irq_domain_add_linear(np, MPC8XXX_GPIO_PINS,
a8db8cf0d894df drivers/gpio/gpio-mpc8xxx.c        Grant Likely             2012-02-14  407  					&mpc8xxx_gpio_irq_ops, mpc8xxx_gc);
345e5c8a1cc30e arch/powerpc/sysdev/mpc8xxx_gpio.c Peter Korsgaard          2010-01-07  408  	if (!mpc8xxx_gc->irq)
98686d9a52eeea drivers/gpio/gpio-mpc8xxx.c        Ricardo Ribalda          2015-01-18  409  		return 0;
345e5c8a1cc30e arch/powerpc/sysdev/mpc8xxx_gpio.c Peter Korsgaard          2010-01-07  410  
345e5c8a1cc30e arch/powerpc/sysdev/mpc8xxx_gpio.c Peter Korsgaard          2010-01-07  411  	/* ack and mask all irqs */
cd0d3f58a0ca05 drivers/gpio/gpio-mpc8xxx.c        Axel Lin                 2016-02-22  412  	gc->write_reg(mpc8xxx_gc->regs + GPIO_IER, 0xffffffff);
cd0d3f58a0ca05 drivers/gpio/gpio-mpc8xxx.c        Axel Lin                 2016-02-22  413  	gc->write_reg(mpc8xxx_gc->regs + GPIO_IMR, 0);
bd4bd337039df9 drivers/gpio/gpio-mpc8xxx.c        Song Hui                 2019-07-18  414  	/* enable input buffer  */
bd4bd337039df9 drivers/gpio/gpio-mpc8xxx.c        Song Hui                 2019-07-18  415  	if (devtype->gpio_dir_in_init)
bd4bd337039df9 drivers/gpio/gpio-mpc8xxx.c        Song Hui                 2019-07-18  416  		devtype->gpio_dir_in_init(gc);
345e5c8a1cc30e arch/powerpc/sysdev/mpc8xxx_gpio.c Peter Korsgaard          2010-01-07  417  
698b8eeaed7287 drivers/gpio/gpio-mpc8xxx.c        Song Hui                 2019-10-11  418  	ret = devm_request_irq(&pdev->dev, mpc8xxx_gc->irqn,
698b8eeaed7287 drivers/gpio/gpio-mpc8xxx.c        Song Hui                 2019-10-11  419  			       mpc8xxx_gpio_irq_cascade,
698b8eeaed7287 drivers/gpio/gpio-mpc8xxx.c        Song Hui                 2019-10-11  420  			       IRQF_NO_THREAD | IRQF_SHARED, "gpio-cascade",
698b8eeaed7287 drivers/gpio/gpio-mpc8xxx.c        Song Hui                 2019-10-11  421  			       mpc8xxx_gc);
698b8eeaed7287 drivers/gpio/gpio-mpc8xxx.c        Song Hui                 2019-10-11  422  	if (ret) {
698b8eeaed7287 drivers/gpio/gpio-mpc8xxx.c        Song Hui                 2019-10-11  423  		dev_err(&pdev->dev, "%s: failed to devm_request_irq(%d), ret = %d\n",
698b8eeaed7287 drivers/gpio/gpio-mpc8xxx.c        Song Hui                 2019-10-11  424  			np->full_name, mpc8xxx_gc->irqn, ret);
698b8eeaed7287 drivers/gpio/gpio-mpc8xxx.c        Song Hui                 2019-10-11  425  		goto err;
698b8eeaed7287 drivers/gpio/gpio-mpc8xxx.c        Song Hui                 2019-10-11  426  	}
698b8eeaed7287 drivers/gpio/gpio-mpc8xxx.c        Song Hui                 2019-10-11  427  
257e10752c13f2 drivers/gpio/gpio-mpc8xxx.c        Ricardo Ribalda          2015-01-18  428  	return 0;
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  429  err:
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03 @430  	iounmap(mpc8xxx_gc->regs);
42178e2a1e42b4 drivers/gpio/gpio-mpc8xxx.c        Liu Gang                 2016-02-03  431  	return ret;
257e10752c13f2 drivers/gpio/gpio-mpc8xxx.c        Ricardo Ribalda          2015-01-18  432  }
257e10752c13f2 drivers/gpio/gpio-mpc8xxx.c        Ricardo Ribalda          2015-01-18  433  

:::::: The code at line 430 was first introduced by commit
:::::: 42178e2a1e42b480ada954750f248b53d3fb5940 drivers/gpio: Switch gpio-mpc8xxx to use gpio-generic

:::::: TO: Liu Gang <Gang.Liu@nxp.com>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--oyUTqETQ0mS9luUI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--oyUTqETQ0mS9luUI--
