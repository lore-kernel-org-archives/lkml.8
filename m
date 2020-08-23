Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68652C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 23:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ACEF20720
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 23:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgHWXVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 19:21:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:18629 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbgHWXVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 19:21:39 -0400
IronPort-SDR: QMYoaYu29KMcFvO7FB7DGfNnnMmq6WRrkmzcPFE3rN7S/E8vnXrt3ZKgR5JnYhjbSI9WZ6Sm0g
 Xn2JmJ5fSUOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9722"; a="155076005"
X-IronPort-AV: E=Sophos;i="5.76,346,1592895600"; 
   d="gz'50?scan'50,208,50";a="155076005"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2020 15:30:28 -0700
IronPort-SDR: gZJpBS637nDZyZO/JqiegZVsQMgWaPvAoPeEksTqx3BW/L/uqoTnDV92YoazHbP7kCw4eqsknH
 Orh9gQdQWgvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,346,1592895600"; 
   d="gz'50?scan'50,208,50";a="279428700"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Aug 2020 15:30:26 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k9yVN-0002HU-Sz; Sun, 23 Aug 2020 22:30:25 +0000
Date:   Mon, 24 Aug 2020 06:29:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/powerpc/platforms/4xx/gpio.c:63:28: sparse: sparse: incorrect
 type in argument 1 (different base types)
Message-ID: <202008240635.QmkdvoDJ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d012a7190fc1fd72ed48911e77ca97ba4521bccd
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   9 weeks ago
config: powerpc64-randconfig-s032-20200824 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> arch/powerpc/platforms/4xx/gpio.c:63:28: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> arch/powerpc/platforms/4xx/gpio.c:63:28: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/platforms/4xx/gpio.c:63:28: sparse:     got restricted __be32 [noderef] __iomem *
>> arch/powerpc/platforms/4xx/gpio.c:103:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> arch/powerpc/platforms/4xx/gpio.c:103:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:103:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:103:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:103:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:103:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:106:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:106:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:106:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:106:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:106:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:106:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:110:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:110:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:110:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:110:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:110:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:110:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:111:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:111:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:111:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:111:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:111:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:111:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:113:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:113:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:113:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:113:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:113:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:113:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:114:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:114:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:114:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:114:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:114:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:114:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:136:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:136:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:136:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:136:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:136:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:136:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:139:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:139:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:139:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:139:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:139:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:139:9: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:143:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:143:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:143:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:143:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:143:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:143:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:144:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:144:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:144:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:144:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:144:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:144:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:146:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:146:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:146:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:146:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:146:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:146:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:147:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:147:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:147:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:147:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:147:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:147:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:73:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/4xx/gpio.c:75:17: sparse:     got restricted __be32 [noderef] __iomem *

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=670d0a4b10704667765f7d18f7592993d02783aa
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 670d0a4b10704667765f7d18f7592993d02783aa
vim +63 arch/powerpc/platforms/4xx/gpio.c

878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   51  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   52  /*
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   53   * GPIO LIB API implementation for GPIOs
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   54   *
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   55   * There are a maximum of 32 gpios in each gpio controller.
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   56   */
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   57  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   58  static int ppc4xx_gpio_get(struct gpio_chip *gc, unsigned int gpio)
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   59  {
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   60  	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   61  	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   62  
eecdf59ad2fb90 arch/powerpc/sysdev/ppc4xx_gpio.c Linus Walleij   2015-12-21  @63  	return !!(in_be32(&regs->ir) & GPIO_MASK(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   64  }
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   65  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   66  static inline void
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   67  __ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   68  {
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   69  	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   70  	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   71  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   72  	if (val)
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   73  		setbits32(&regs->or, GPIO_MASK(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   74  	else
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   75  		clrbits32(&regs->or, GPIO_MASK(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   76  }
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   77  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   78  static void
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   79  ppc4xx_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   80  {
0d36fe65f58391 arch/powerpc/sysdev/ppc4xx_gpio.c Linus Walleij   2015-12-08   81  	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   82  	unsigned long flags;
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   83  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   84  	spin_lock_irqsave(&chip->lock, flags);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   85  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   86  	__ppc4xx_gpio_set(gc, gpio, val);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   87  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   88  	spin_unlock_irqrestore(&chip->lock, flags);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   89  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   90  	pr_debug("%s: gpio: %d val: %d\n", __func__, gpio, val);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   91  }
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   92  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   93  static int ppc4xx_gpio_dir_in(struct gpio_chip *gc, unsigned int gpio)
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   94  {
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   95  	struct of_mm_gpio_chip *mm_gc = to_of_mm_gpio_chip(gc);
0d36fe65f58391 arch/powerpc/sysdev/ppc4xx_gpio.c Linus Walleij   2015-12-08   96  	struct ppc4xx_gpio_chip *chip = gpiochip_get_data(gc);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   97  	struct ppc4xx_gpio __iomem *regs = mm_gc->regs;
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   98  	unsigned long flags;
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13   99  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  100  	spin_lock_irqsave(&chip->lock, flags);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  101  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  102  	/* Disable open-drain function */
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13 @103  	clrbits32(&regs->odr, GPIO_MASK(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  104  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  105  	/* Float the pin */
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  106  	clrbits32(&regs->tcr, GPIO_MASK(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  107  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  108  	/* Bits 0-15 use TSRL/OSRL, bits 16-31 use TSRH/OSRH */
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  109  	if (gpio < 16) {
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  110  		clrbits32(&regs->osrl, GPIO_MASK2(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  111  		clrbits32(&regs->tsrl, GPIO_MASK2(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  112  	} else {
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  113  		clrbits32(&regs->osrh, GPIO_MASK2(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  114  		clrbits32(&regs->tsrh, GPIO_MASK2(gpio));
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  115  	}
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  116  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  117  	spin_unlock_irqrestore(&chip->lock, flags);
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  118  
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  119  	return 0;
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  120  }
878e7556bfe7b1 arch/powerpc/sysdev/ppc4xx_gpio.c Steven A. Falco 2008-10-13  121  

:::::: The code at line 63 was first introduced by commit
:::::: eecdf59ad2fb90d8238a42e2ec41f165964349bb powerpc: ppc4cc/gpio: Be sure to clamp return value

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Linus Walleij <linus.walleij@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ZGiS0Q5IWpPtfppv
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICJLrQl8AAy5jb25maWcAjFzLd9y2zt/3r5iTbu5dpNevTJPzHS8oiprhHUmURWoe3vA4
9iT1qWPnjidt8t9/APUiJWjSLtIMAL5B4AcQyq+//Dpj344vX+6Oj/d3T08/Zp/3z/vD3XH/
MPv0+LT/v1msZrkyMxFL8xsIp4/P377/5+vL3/vD1/vZu9/e/3b29nB/PlvtD8/7pxl/ef70
+PkbdPD48vzLr79wlSdyYTm3a1FqqXJrxNZcv2k6ePuE3b39fH8/+9eC83/PPvx2+dvZG6+Z
1BYY1z9a0qLv6vrD2eXZWctI445+cXl15v7r+klZvujYZ173S6Yt05ldKKP6QTyGzFOZi54l
yxu7UeWqp0SVTGMjM2ENi1JhtSpNzzXLUrAYukkU/AEiGpvCzvw6W7idfpq97o/fvvZ7FZVq
JXILW6Wzwhs4l8aKfG1ZCYuVmTTXlxfdhFVWSBjbCO2NnSrO0nbVb94EE7aapcYjLtla2JUo
c5Haxa30BvY56W3GaM72dqoF7uuvs4bljTB7fJ09vxxx+b+E3GaUYaPtrd9kyIWBiB5jkbAq
NW73vNW25KXSJmeZuH7zr+eX5/2/3/Td6g2jpqh3ei0LTyEbAv6fm9SfdqG03NrsphKVIHra
MMOX1nE9zSuV1jYTmSp3lhnD+LJnVlqkMvKHYBVcS6JvdwKshP6dBM6NpWmreKDDs9dvH19/
vB73X3rFW4hclJI7FddLtfEu3YBjU7EWKc3nS195kBKrjMk8pGmZUUJ2KUWJ896NO8+0RMlJ
BjmO46ksq0Jyokou4uZyynzhHWfBSi2agbp99hcYi6haJDrUxf3zw+zl02BnhxN1RmLdH8aA
zeG+rmBjc6MJZqa0rYqYGdEeo3n8sj+8UidpJF+BARFwVp45yJVd3qKpyFTuLw6IBYyhYskJ
VapbyTgVg56CLuRiaUuh3RJLem9G0217K0ohssJAr87Q9venoa9VWuWGlTvy+jdSxMzb9lxB
83bTeFH9x9y9/jk7wnRmdzC11+Pd8XV2d3//8u35+Pj8ebCN0MAy7vqoFaUbeS1LM2DbnBm5
FuREUXecBvTixKQjHcPEFRdgBkDQ+AMOeXZ9SY6ETkYbZjS9YVqS5/MPdqazUrBoqVUKi3Wq
5Ha25NVMU7qY7yzweu2BH1ZsQeU83dSBhGvTkMJVWVMyLlwXzq9mEbmWcC7dzV/Vf/FswarT
FcX9weRqCd0PVLlzq+hDE7CEMjHXF2e9vsncrMCxJmIgc35Zb5G+/2P/8O1pf5h92t8dvx32
r47cTJrgdhu+KFVVaH+G4CP4gjzgKF01DUh2zbKaL0V8SqCQMa1ADb+MM3aKn8D1uxXlKZFY
rCWnb0sjAZqGmn5KJCqS02OAuSYF0PGDuYfrRBwy7A5fFQpOFO2aUWVgmtzmgW81anqfwc4n
GoYHM8TBatN7XYqU7SgzAGcIu+NwSxmHKLBkGXSsVQU+zMM0ZTwAbkCIgHARUEIEBwQfuDm+
Gvy+CkyQUmhQ8e/UpnGrCrBx8lagi0W3Av/LWM6D3RuKafjLFIgBpBrjRecqFha8H7MCwW/e
mp6u05OCNJCr8VrwGwwTF4VxgQpaGg/mF0n/Y2i+MgCTEuBZ6fW3ECYDk2V7fz9QjYZBzC1Z
sjxwuDWUrJ2rR3UGx49EAv8UMQAySUWPUEEc1rd0P+HGeysslI9RtFzkLE1i30bDZByhG9Bh
lySmNnsJ5ioArpJC61LZqgzgGIvXElbRbNXQAEasLGVoYtqgAKV3mbdZLcUG2Kujus3C24j+
Ozh16gDxqF0EQa7WAW8MIPspWuwhYnwVLAGQ5g3RHlqJOBbeZrurgLfJdviw9+f8/OzK78X5
lCYeL/aHTy+HL3fP9/uZ+Gv/DP6cgbfh6NEBjdWQqOmn7570qf+wx3bK66zurIZfgd5itMoM
BLqr4FKkLKINaVpFlE6lKvIUFFrDfpcL0QZ3Qd/LKkkgPi4Y8OEkIDAGk05bBSOy2n5A5CwT
yUeWBrBCIlMavjmj4dxGfUbN3oWhfnd/C355EfRc8Pn4KIvDy/3+9fXlANj569eXwzE4NQg9
wSivLrWdf/9OAz5P5Ox8UuT9uxPt30/wrs6+E7twdfU9sAsXZ2eEVBfaFB70w8ESn3D1/bt3
HWEZvlk0ws6vIulZ4mK50yMa9AkhIAQYcCmXU3Q7OAtgODtN62RWkJdkfFbdfYi1uvR8MWLo
CDcnjyXzotbLi2DuQejqDEuWMQBfOTh3COxtxrbX57+fEoCQ+PycFmgv4s86CuSC/vIS4xp9
/e68y0VB5MFXNUzXVVGE2TBHhhZJyhZ6zMcIGBDTmNHqynIjINQMz9ZzWqxMdyO3WLC8Cb5V
BVj8fQfYaxSnMmkArAIYtO7i+k683ga2awwwqGbMQ/2p4mhhz+fv3p15rTDn4tqOF1D76IbY
pqEqmYFhGgy7lJEoa/iC/l/LKB2K6EoXoD8EG6cW87KJR0f0UT9uu3UNlp2VdEZySqwCExgJ
HXYLrrppX4rFJE8yrq+vaF6MvIsJ3voEj3FbstzfwWJRJ2NdoipsCAYFTlIihgNkH04UeZmW
AxOhJao+XIY21C2e7o7oBD2D3KmUytoMUdjL1e++HWMZmLIArKUVhhk5BYRFpPJd4M5YdnV1
Jsj8pLiplPQgvmFSL30Ds2KwFBnAEAZhxUSktmElHd6gRoiJAJHlO5WngGGpyGqRMi7dJfOi
oHijFAWl4LaHojulBVxYapuk1rWz6CdSAfgyFV9RCFgXgb1nK9xmEpVylYdacvUdE5jF4MKh
8iwK6cVP7pAGP7fB70XIXoRcXey93/MzH7LDT+3//H2eFEGUVVOsKMurObWqqNYhJ+D5pRUA
t0UVvCOIghUQzLGSYcrL802FDJIm+Btuy6IcQRhwdrPksP/ft/3z/Y/Z6/3dU5BoQ1+YlMLL
7bYUu1BrzINDkCjMBHuc0ezYmAWj4tSW3xpg7GYqWCVl1QYQLZvI9JFNMGRw2YZ/3kTlsYD5
TGRpqBbAg2HWoyQktW3hekmJdpXkfkwuihJslzJ5hP28vUzt7NNQZ2YPh8e/6sCl76fehlA9
GpotIKKLxbrn3ahS3rQSPkandbSdinx42jeDA6mbIJJ9OO4yoxC6T2VYmwYexe+4naNKbGmC
qwXwAUk05hx6Iz8AfPmKL7FBoIfJeohMSa1a3trzEKz7rIt3k6xLEuLX3XnQaHl7jQTPZjCz
hIC3SqfyNA55iNx58+ZdbKlMkfo4ipYp4W8+9lmJrfAgDQT7GAayADfxEiOBuPJfXl3vAFgN
dN2M4iXk0lQsWNpCR7tm4MivvQVqE0cyr4xMKWfokMHKIa4wqAf6+bxhTEZl86ufSVy8ozrx
BFxE3GSpO5TUPFp3yesWrmJUPJR1T2kYPdhbQC+qjMFfQ3zQ34gsxhd0DN2oRFTD9vKYYgtR
AsAWCOUhiO7pDdj1Qv4G/TaJ5jFDrySEErvch+yZ1anwnTJQMI/bUr34D7DPCnVkRe5dFnTh
IN+gOQBUNK7xOAU9mMy4dexGN3wZq4mGPF0FE2jji/oRNNClzU1tya1IEgnQKzetz6C7HnRF
bNhQQnmpUS04hou+ZR2Yoh6vMRtnzDKXd3QWKvr26lmsQejUyIewWkL4XApuENKP0Bj3TwkJ
2o9pEp3aNOL+TP3xuxAXfBPACJhAXWnQzpU9/IVJsIdh/UZ37MrlkYOjSNUGjQgmvKcuhCdy
ffb98qypZOlVY5ezDHGWyGBaJf004m61ShIATVPjeCIwzv1onKaswo0x1Ycv43fSDrHcaclZ
L3A2EDAuP95uhh+zNPRwZs0hDTa+S7AANq1YKm+DV8k283Z3uP/j8bi/x3e1tw/7r9DX/vk4
VrbaAfD6vcd3HAOaSwioOhUY4KNVHRsTu/Vf8Co2ZZEI3wJa3drBTRNpgiU8U48h/QWucljp
IsdHKM6DKNZ5K8BlrszHyNxGWMkymLiEtWByB+ZqBqzVMLavqaUwNKOmYrlSMngxcfykyrlL
YUCYoUq4rv8VvDkfX8zN2rVfKuVZtvbua9g6xFWNaxqmSphGP2RksmvfxUIBl1RDbbfD5WKN
V6bipkpquDrMZFiGrgSTWs1eNwYrkNN+8NJn68NMSE9H3Nz0GWKNfjMCbWnBUlbZBQAmaFyn
N9D1kWx8IP+JSO358ZINNxOmkGeyfsjmWbHlyyHW2gi2QgAl8NWE8ZtKlsNuNgzUVDqEgQU1
bRkasdLGY1i4SUHybYruWrrNQ/UFdVIesyndC9ltaUl/5cK2/mX0m2lTKjLN76ZA1H8Mr9m4
5GMgAarXbEIhOL42eEel4iqFm4V3GeyCe5wi+hdb1Oy8rqrC6RN3wzUHNVZZcNz9EQQp42H6
M+D1qV/Xmqti18JFkw513bXP1yXLwFT6D0CpQkQIk92wMvYYCgsT5WIE9Ro6G5iOJi9d327c
6MHUaw8MDqhxVOVmS+wOnLIEAEHJnGB1zd2Lg1EhNEHY6L9/6c4fcbV++/HuFdzXnzUs+np4
+fTY5EP6eA/EmmFPPTA6scYJ2faNsn1zOjFScEpYUovx1AA2emQy7PyHnrULt4zN8JXZ9yDu
0VVnOPHzgdoHeSVHaiKNVDE6IdJIVfkpidbOn+pBl7wtVh48z48kJV1Z0rBRPTHFfEoG8+wb
m0mt6/KxpiTFysyl2smmVQ42AS7ELotUSouA3mat3AofuAktag0MBMq4rWpVeY4oQg32fwIg
41qCFboJk4NtpUqkFySxrlgd0DFWXpTS7E6wrDk/G7MxyIxDchthOkcTmHPkbiIKTtXd4eOB
n6f3qdRI2qF6lobUukTcipyXu2L4WEwK2KSpBhi/9d4djo94cWbmx9e9h0thcUa6tm18ESSv
AZzmvQydsJdbWqK1sTrp+UHnGVjen3UOCF+e7D5jPOi+JetYaXpcLHeMpV45EETfIZnDonQV
nRoY6xRLqe32/Zwep4JOwA+JnwyWxtlPNkEvTm8BRNylfwh+xiKnyCtWZoyetEgmxvKLjNbz
9ycn5N0cb4Q2rThQRV/ls5sw3m5oiIj89w8kuxC8LjtXfYmjp9nQTqr6KRYLuMLPLTzmaheF
t7tlRMkN6aDC8TrfqfPzvn84+/py6gJCJfQdIwDVvXoyozDwLrPN9RgFAMK0CtxGyooCLTmL
YzT91llzL+fQ5arclojv+/tvx7uPT3v3tc3MVdYcvc2JZJ5kBgFc3wf8CGPRRkjzUhZmRAbf
EqSSsS0GHeSeTU3IzTbbf3k5/Jhld893n/dfyPC5SZN6CwYCbE7sErM2G0WiCdPGLqphunWF
aTEsnwoPRBcpIL3COHgF0Nt7SnZYkI9qdTDIKQUeIF2wA7atZOGtc4AOz8+aYSWJg/yA9aLK
ryzT3nrb1xiHmsE+uY6ur84+zLt8kgCdLbAkDEKHVVAVxyGgyjkDraaffMKC24Z6WwS5k9uo
8rzW7WUC2Nkf49bhLUWV+rfBdl1G0eQIvFR33FZQYaC+CoKZun5iPQjGYJW4SFeL7sX0WLQL
znCZsZKKVrCqx4VDLMCz09rX72xX5p/vj3+/HP7EFyPiBQQUZSUoWICuIDAO4F14cESOFktG
Az8zAce2SZm5oJ8uRBYYYtCfN2zjArOWMF0Kwsl6yb1JLOpSVM40nRgEgS4/WSrA41QRHAgV
uX/w7reNl7wYDIZkLAmmSwQagXKqhADXLQt5irlAtyyyaktMs5awpsrzQUptl4M5UCs58TBS
N1wbOclNVHWK1w9LD4DHYtlymgcgf5opC7RlE6fdL9cnokIOSIYXLTnsvoqLaQV2EiXb/EQC
uXAumB+h1RZHh7/22XCqVrKV4VXkJz5aE9ryr9/cf/v4eP8m7D2L32myCB1Odh6q6Xre6Dp+
EkR/LOCE6qJ0jenYeCKExNXPTx3t/OTZzonDDeeQyWI+zR3orM/S0oxWDTQ7L6m9d+wcAC93
ztnswtoRx6417cRU0dIUafPd68RNcIJu96f5WizmNt38bDwnBk6DT4uURXq6IziDE+FEAYo1
1Qw/+sWUJDqtkzIAH1wuCrxeVgxAhy9cpzVJblScYILtifnEPPG9k09Y43Licx44Q3pHAcnR
gdDFxAhRKePF5Jcczm7o4MPehkR2tk5Zbt+fXZzfkOxY8FzQPi5N+cVUkJrSZ7e9eEd3xQq6
Jr1Yqqnh56naFIyOyaQQAtf07mpKK058lxVzqgw+zjV+oaTwQ+/rL95hYJmfyxaQnalC5Gu9
kYbTtmxNgI7gFsl8Ne0ksmLCM+IKc00PudTT8KieaSzoxaBEegnRhUYjPyV1U5rpAXI+/Cyy
Bd31Z2QoU5ThVyuUDE+Z1pIyuc6zbjF02Nnw45roJoAv+M3Jf8PPun1MOzvuX4+DdLGb3coA
gJ9cYFwqcJoql4MPHzp8Pep+wPCxtHdoLCtZPLUvE9cgom8OS2CDyilrlNgVz4h93Uh8iNJB
xpgnC7xm56M97BjP+/3D6+z4Mvu4h3ViwPuAwe4M3IsT8PITDQXDGOs+FMBil/p1uh9xI4FK
291kJclvsPBUPngwu/7dJ1GC4/tw6ktGzuTEN5CiWNpU0jYsT+idLjTD2tZp6JzQPMrxtkYK
gnwX13pRYKlgeoNvuhImU8yiEF0IszQQ6La2Z5BG4M2laeO/eP/X4/1+Fg+rBZs6fi91Vb8q
hNUjgx9eUY1HHH3HD0SXaAiSA02tmmuBAqE4CzNaDal5JSc2AQWs4CUftdIFdTecfJGJobiN
J25Z3WDC8TtmtKHHGdTN1wTy32VAHr4YrwafscnpQincblNFYR9BUsFV9HOWhZQakbj6wuFY
Uq0nRgIzH/ZSMLDo5JH6nfonzeEPCgd5Inrpvlyps/4gff/yfDy8POHn36MaV7daVkIoFX4y
5w5ki9+ibW2+oUEttk0M/HlOVmgiGx9c2KjfkjPaXXZc98+nTPSJrL4ye8hoMk0Ta5lcxxbb
TXLXlxa/DZjmYzGzkSmFUN3oDDE3C29oQxxrt1uHWVZ5jHGlyE5wR3oJ2wfoKvyXUgKyaz/a
nUwA4DKC+pqhvpolz7SJhpqeKgiidfgA0BjJ18fPz5u7w95pIH+Bv+jhFy21udgMJhpv2ikO
qFhvTVPHDazY7nI1uMQy285HK9eFYOX55ZZKA7klsh0cLmfF0NLZpdTUTXS93oB+jobCJ5eY
2fd0oNCImELw+Qn1F+4ZM7WLzaj/lSwljYocG+cLto5C+s6mAtLPB/vrru/5h6sJMq1LVS6L
5dRHP43ikzDxlNLUrwQvH8F8PT4he39KqTIVybWQAw/akSkF63iNmvXJ4elBa9x397DHL5Yd
uze1r+MvuNw4nMUi+C7Cp1ITa1mE+vus/izaDwB+Oq/uOY72EZ3/EM8PX18en49BnhvvWB67
2nTyMIOGXVevfz8e7//4qUfSmyYsMyIooj3dRd8DeJDY36uMSzb87co9LJchuoeGALJG9qzg
b+/vDg+zj4fHh8/7IOO/E7mhHk+KeP77xQcvdfr+4uzDhT8LHKyvAe45JStk7D92NgRrtPz9
4nxMd8m29ivUSy90aAWaDxggRjRbO6r+GPaWMWiwkOE/mdRxJ4BUP1SVYfVN6IJb7v9zdmXN
jeNI+q/oaaM7YmpLog5LD/MA8ZBQJkiaoCSqXhietnvbMe6qCtsdM/PvFwnwAMBMsXYf6lBm
EgBBHIk8PoBnBnMXd3wdmtKEJq3GYP88/nh5An+r+ezDcBmVrXpnfYct433lhWzqGu3W9WY7
poO8UgsC7EXKWvOW6Ngn2jxEDb/81p4fZrnv5jyZ0K5jnBZ2ZKJDVmpjdXQw586VKBJnJHc0
tbCdMmwvUaMui1g6RsbSFSW8FDpyQUP6jeZD8vL2579goX79rpaZN8tLe9Hzym66ybroCoRm
D4eyTtqErZq3Q/eNQRILfRqEuqNg/y38lvZne6aTFc6909ruBRM6ZXMJS6HOES45fq5s2fG5
jL1PA3SIxm6fbUw+EW5DBTEGqSadsA6LRqqzQA903omWsxzceeg6l8v44Dhhze+GB+GIJlMu
kGchtAGhiTHxshiRhHCWuLZyG4Wvoy1tD46APCE1jiIAwUrcQy4wE70j6nhvdG4S86/PEXnS
x3trQiqtrY0cA2CPJnX0un21aDxDrs2pnWOcyOuKsOyCbpZCNnCTFpj/HPTJJt5zZy0yicKQ
NeNtWcOskWkjQpItjnzMs/JVur6w9sc8y7QnHht/mZ0sIConNkD91EMZ2Vr7YKAfj2/vbvxO
BSHMdzqIyC262Ydio5T2nuVUZAcfoeGJSiZPsGJNoF+jQRMq18NpsasSP0iCCAzOQnX7rbrV
6NVoV0gDOpZJPYJ0QxOn8mlBFqAzNnTCoR1UOBaDSOo8S6+OQjXqfP1NTuq/SvGF+CaDwVO9
PX57f9XQu7P08T+jr7RP79U6538jN8ImsTGxssRFNIXfTXlBu5UDkzCARg3FkzKJsKkkhdsS
PRjyYjSI+sg1tdQY8/9o6JZMfC5z8Tl5fXxXGukfLz/G6qwejwl36/sSR3Horc9Ah1zcjuyO
6IRrVIo28YsYV7Ba7ll231x4VB2bhVu4xw1uclcuF+rnC4QWIDQ4nwIU84jDRCSraExXqggb
UyGx1RvPTPgdo7qf6Ay2l3HmnIhufC5zvHz88cNKBNdGey31+Bsg73jfNIfFt4Z+A1esv44c
r9Jsru6YMuQ2u4BoeCekUx/Rx1FzEyp5iCGQdaIiQJYwwWRefTJcB/MwwpUfEMjiSsuQApVc
r4mkb90C1JZpOO2ZzZPXJzemDk1XpdcSu1oVtTaSM6TnYFuVLksdmrsB1R31JwaAQdp8fv39
E5w+H1++PT/NVFHtPonP/UKE67U3cwwNAHsSOyjMYnVpuxYHUqST1KBMOe/aM5pLyavYgIth
yI+ucF6NhqcIj0WwvA/WGKqHHhCyCtbpaJikqh/JMVbaFkpdSxX5NEjjqfIK8jnB+WXHNLbc
uNQJHcBdBNvRLhMYdcPYHl/e//kp//YphC838ta4XZeHB/wIN/2V7TZkTENZld5yrvaOzCBT
OLW25PZDma9GaSmt6GDVRpiSCXnKDjjTfGaEEdSw1RxGn0cz4zAEI8yRKS3dLxkRUJtq6C/V
lyZzUDn8R/caw6o94//rs9I/Hl9fn19nIDP73SzRg9XKnVS6nCiGTFW/cy3WjeXFlooqpJGq
SxU/rUZLkOlUtWwGt4rOoiREn1SH7gOGBNQLtPoj+nDICP/o0OxKoF7SXkCw8hynePEyDeH4
sQxQY/hQxCCGdBx4CogPn9cZkwgdTik8CRHOOdks5uBNRniixntYAqJGWN3shYideRbiY6eq
6536fALTHa0m+wPe1H3Kao7Q4Xi3nq/Q+uBod7O7q3v0OVHzm00cud6GVlZiGTTqDW8OYc8f
0NNbHKpxsbChAuzPrUJH1u9h5KoFnvW59eLl/Td/sTYTC6C/OO5E7oXUSpkfb35/Lu/zzPWS
IUyji9tpUT8hq5Mz7PgNWhjgcn6umc1+X+l9wm2DLHi3yureSgtV/ey/zL/BTKlLsz9NbDuq
m2gxt8QHfZ3IcAZpt8Ppgj2VABpGql6nvTdJFKG5pDrbVx4hq8DTALTAPt63t5MEXu8CF7I9
BHqvRidxSE/xfjTndcmgQpBD6ngt4tIzk7TsqLJWAVdfzxNwhFU+5oLNV6d2VcIeK1hxIb2l
cjLsFdHkT6Cs+3z/xSG0cB4OrRueNs2xuanfmQ2HBnhRMQBowSnYdkUbBsQGOjSTqHR1GyJY
H3mtJmZcmnNZK2AywQF6s4fCVEdvF6OTIjSF6+hvqaq93Pcxjh5sEp7gsWWWjDzp+yumxMy5
BHMCtTKs3m7vdhussUqdXd14Msvbt2zpbbaqY4RsE1izkxpQeyIOtRNK8AhQVR2PcOWiexJc
jlLChsQLX0cYCZ8oGLBOIM1zItS3FYjKPd7U/nUn+LLe3uR7h5bBxhmVuYCYxzA64zUAWBUM
dIgcQwXawBl5lRQqnwnFm/xaU31QSvc7mGjOs4jHjnGgemeUvifPNr6BFjQR+OBmso10wDle
BJrxqZkJ26vNV3qFubqwJnnh8A5L43N5RRiiHjU4x9YRXXr7jFe/4Y6i8rvAVLsLe43Ecg4M
YyFaB+u6iYocs+dEJyGu7gpbHFlWudEhxlohuNKh0CyMiiei+3SDYwiId3WNw26rj7BbBnJF
oHLrc4I6zuOhekpFS3N5KmNYSc8cv8biWDQ8tTw42kUR5kqvju3QRU2Gzbl012pWRHK3nQcM
Ba/jMg128/lyKMdQAitvX8aZzEvZVIrjgCR3jP1xcXeH0HXVu7l1ejmKcLNcO86VSC42W0xB
LtR2VRxPTiwU7Meqm9TRtljSd1hIz35px1A0pKLQrSVREhOBlecCYKiRCsOg3TVNRnBcgLUU
QXo3HDUoAmwnGrjrocdaIiAUhtcRWbB6s71b2y/bcnbLsMasSz27rlebUXk8qprt7ljEGpfW
LzOOF/P5Cp3H3jv3HbO/U+dKf0YZKhXgYHEbJuVJ9Bhs5sqs538/vs/4t/ePt7/+1HcXvP/x
+Pb8NPsA1wnUPnt9+fY8e1LryMsP+K/9BSowgqNv8P8o1/KBtCM+5XIJOjnuKLGFeIANpDZS
UVasGK56+/bx/DpTCqY6Frw9v+p7HUchT+e8cJ3O59zB77tVSD8GwqO1zEDOuWpPCHfAeCd4
4JSVrAm7z5HtWcYaZp094AYg55zjrPLDgwCIFNnQnFGPJVu8Pj++P6t6nmfR99/0J9Juss8v
T8/w57/f3j+0IfmP59cfn1++/f599v3bDHQtfXKyTmSK1tSJ0ipE7tUFsT2ujwGISgspPKAE
jXKiWJJVzBU+OFZIQ4ES8M2jZxdYR1o1hY7bzGZgeSoWvzIBlfY7AjIfz52bc4AO92cZKBUz
7FTPgU1eFduNlM//+Ot/fn/5t7sv91orbZWwmqPDCpLk71bUtFUREstnPevE9JvfMALVsG8M
ZunoE+VJss9NiNqova2l96bWB17ATbCYfqURkgbwWBxuHNtdz0j5Yl0vEYaI7lbYE6GINiuE
XpU8SeMae79Qrj2HESKwROB5jkW13GywIr+o9aNEddL+KBAugjlSZsE50npebRd3AUoPFkj3
aDr6spnc3q0W6xstK6IwmKuv0XhYCiN+FuPO8f4VzxcUTbbnc+8miJ6RboNwMV9jnHA3jzcb
7PsKpYxh7T1zpoqrUQty/3S43YTz+QJduwzWmfG0QeJc63VBrkOQHFbKoZCS8UgDulvrJEi5
v1wwNU3xVhhdbVvf7OM/P55nv6jN9Z9/m308/nj+2yyMPimV4tfxUiBtCPJjaWgV1kkSM4z1
jzhRJz2VSKbULxDqGNIMjTfRAml+OLh3kQJVhpDF2aIYD69edYrFu9fbYNTr+tdtQBIaBt1E
rv8eCTnFw73I48+n6SnfS4YxdDaEc5uxYZWF1dTOp+e9ndfENL/oOz2o9kVHfyQdmzJi4Ziq
jkbyMuqkCNDI0YiUlsvSExu11xv/jhECM3ZG41klXA+kuV1QbcF4IpjiQ/AUsw3DkZ5c8xFl
MaaMhVbrjVd/b1zAba5Ro22F6OWFQ3ynQyG19pbdnmflGA+7FTARlmV84OqkynBMq94yJToE
3HFfR84JLxJkw3QhietK6cSNQVqdojK1Ypca8RGHGIJCOJjrueOrATgxgBmUlUbkdpTBCMD7
AHyycHHeFF1jyOG1yIwV7pW/ilgduQ5XOnNANPSusIXyfLihgaV9GaNvGUGMI2pn1wEATuVh
6gCvKorggAPslQe3pd66SkKJwBh1Cvoal7lbMmYMs+nNA5qaaku4O4HDOhInfz0cvEs8HeYJ
TRKKhLmT3K3OBJDj4knK7uOr9wBEJ6BzEIaDTs5Aulp/V+IL2siM9nMaDRGzehkTnWuyrEJV
kBdYCDSAKXUnE1ALSeXeAxfGBQ7nACZDAFFs24AfkvSyfUNA7guE3TKTk/TwxAyFPKV3bIYG
vhumzh4/mAgZ/8FWBRgZiwE3YrZY7lazX5KXt+eL+vPrWNtKeBlfHCTmjtLkRyfnuSOrt3fs
aT2DArcYBHLpDfnOWHCrqdb+wUI11HK4bEMHzGMdphphbgi2TdXDYBt2hzyLKKAVbdtFOfAa
hxMrcdt9/KCx5G8gdhHZ8xp7KSa8FuqtAdcEH6oFyTrXFAcOokROwp6V8YkICzwQCC6qfZIw
YKr3Ag02J+IZS04ColQnvO2K3pz19yxzqbRHwgdDuW9a5wxVa5YKCqu09KFjuoi0j7eXf/wF
1q02J4hZ0MZOUlOXC/mTj/RGMgBedzy38PpqyY/yslmOslF1GOUyXN/haDGDwHaH91BeVjHu
AayuxTHHPURDi1jEii63r+s7Q9I3OsBaMFGAUoycmRpXi+WCwnLrHkpZqBUPZ+uSkHiB5hM5
j1axh10bxp7VfWAZc2klp15CsK+23uawXBReEW0XiwXpcCxg3C3xzaz9mJkIqamuSm/qw57G
5aCz43tuc8acJfYbqWUvq9yYXvZAwMfaz7mQFOqnOkYRSF3A6DPdJ4qFCZM7R1lWpRS6U0q5
0dIF3i/AoQbH1Cg9KTXW7SZNabL9dosiLVgP78ucRd5036/wWb4PBXw5fJHbZzXeGSE16it+
yP2ESKswIl7goNGbESPtMD/1xcngyaLKxhQst08g7szpkgw7PFvPDIFq9g5GoN3ARqM+axwx
NRe8sYkVfeYngc56dR5KpavGtqSmwkdgz8Y7vmfjI2Bgn5OJRit112mXv/ghj2hkXGcgm3SE
frPC21QDqgVxIspQZdqqNHI3FQNrmU4tBlGL+zNUlAZ4YIY8ZREEA94uD1BhPPN3HEy2Pf7a
RiQOnawpTVbI1hgg4EDvz9lxSQkr1XbqHLSSSg1M6gK+pDqMuUixZRwDMpEzLSi3NET1JoLY
cYBZPDSCgvcCvp5KtMiBsywhcGTgceglumWa25xxbKtBwK8d6ZPTF17JE6JeJeL8ZbGdWOwP
eX5w+/OA3q9pPdLnitpPHXm9PkZB4y8/lgDYacmdUw2z+YpUL46ZBDRFvLeASW4jirmceJ0T
u8QcXQ75NljbbiebtXcjaPZipBUgD0GcjTO/8CEftzdLOnJzAmb0gG8Kik6MLl5Tj5A6mOZQ
xa2olikG9QwRlZaIxRxf9/gBHzdfxMRoxRIOzpsV5O5So02cyUkv4FSHO63FuSgIBbhmi82W
rE7eH/DekPfXCZ1WqDdjWe6s9CKt1UTClz3FW2sbA8WVl5vsBENIs9vDw9Id4fdyu13h3QKs
Na5VGJaqEQ+ivZdfValUnIXXnny0qWVhsP2ywXcixayDleLibNXbd2rs/EStgNeFrhziWrph
I+r3Yk4MgSRmaTZRXcaqtrJB7TAkXFuU2+UW9YDbZcYVxB07S7wMiElxrlFoXLe4Ms9yF60v
Sya0osx9Jw2S9n/TQ7ZL10vc5W/W1HbRxkkTanZw7w85v+TCt78gb3XmkXsK1TiNEbU8pEX4
E2+a33P3RY8NtZiritA7EqzSzC0CLQqPc0Y9MrXLHfE+uMYAW5LwiQN1EWcSbmxDZ8dDmh9c
6J6HlC1rItr7ISVPg6rMOs4aiv2AmvzthpwgyEs4u/xDyO7URkzayA1KBqXilGLyK5aRi1q0
ma8mJmoZg7HHOTtsF8sdAaINrCrHZ3G5XWx2U5Wp0cBc9/uR3NdKdsaASezyAIi5RMfBkFM6
VAVKiF8b8mRsX1hpM+C2pET9cVYhSRi7FR3usgqnzENKF2buMhnugvkSC45ynnJ7kcsdseMo
1mI3MQikkCGyzEkR7haqNfgqUHDyOAbl7RYLfM5p5mpqA5F5CGbz2nEDSrWGM8KmDzxI548n
liZZ6e3VKbYScFKbHhkn98jCiuIqYiJRB0YfkUISAg52Ruyu/DTRiGuWF/LqAjJdwqZOpy03
VXw8Vc46bygTT7lP8C77lF6pLBlSE64AClapi3AngCRuHWhlcF6KArFZ7T67u6T62ZRHTtiB
gXuGK81xn7FV7IV/zdyrZQyluayp+dALLKcsFCZY3i68DZ+Hvk45cVVEK8PqG9+klUlT9c0n
B0rNS9zlAoygIMCaoggf00p/JjY8YRD5ztR5Tg0OCqLbHBVA09/t1gI/UhUpcYNOUeB06T2g
PVrH7+8fn95fnp5nJ7nvA+tA6vn5qcVGB06HEs+eHn98PL+NndAXb6Xv4NmbS4R5b0B88DcJ
s0tjPDeuAyIyaDx0xV2PtFC0UGFfpWOzLBM9wu0MrQirM18QrFJy5+gHoXGM+H4ll8K9KQIp
dDi6Y8wWMRjnlsxFUnd4vcqEMe14TZth46La9IqQ/3qN7IBBm6UdUXGWMWSCluwajjHKYg3j
P7u8ABL/L+NbC34FuH9IAfj4o5NCgCovlA9ewHkIN+CbQAUq410HCyDA9oPZRkZErp5ztDuL
pvBSEdscjx9/fZAhuDwrTtZX0T+bNI6cvdVQkwSyh1PqxlojBFdXUDdsGAmpAdjuBTGsjZBg
cBemL9Tjmr0+fnuavXxTK8zvj14uX/t8Dnfb3mzHl/x6WyA+T/G9BcbqbuqCAfPkfXwd5Q50
NLXM4ZuXJVCs11s8L9YTws4ig0h1v8eb8FAt5mt8G3dk7iZlggVhI+plwrSQd5Se3EtF7YUy
5WaLX8XTS6b390S+bS8SF7slcRjuZQAhY1pCD3fiPp5esArZZrXA7SG20Ha1mPioZlZMvL/Y
LgN8HXJklhMyav27W67xyJFBKMTXgkGgKBcBYZ/sZGR2lk1xKak7DnvBLL5URNBOLwMXF4H1
daJdhVKdtpRFZGiZOUBPjIM8jRIOZ3gIzpyoV1b5hV2IcFBLCv4vqftxBrlTNjnY5dGUdVuK
P8gN4d0fulatxrgL2hrFS7XoTJRTiaCp8lN4nPzgdTX5emAlbgjv5SDECrXCTDRrH+L78zCW
q3s9bpA11dp0rNB5+NkUMkBIDUsLidH31wgjg0VP/VsUGFMdh1lROSn7CLORLvzvIBJeCxdQ
ZGDpq1x1crNjbu/5cQpqGJHXYjUiBrWXMCNatelRwdGMhl4oyUPQPcMj+rbtO3qF3wATMQKs
KNJYV39DSI2Q9Y6ItjMS4ZUVhGdL86G7/PRcT+Qs1bLEbhVCbk3tu/Yf/HZFgxwc3G7qSXDn
JeFS1CL6hkciwtoIQM9KdVglfGrt/OHEMlUKvhr51My59PHtSSOD88/5zM93Au/LMEgQjBpP
Qv9s+Ha+Cnyi+tsFrzFkpcoaHcqlhtyZ9YaqDvEItWQXn9RaKepCNsgDbVyi4QyHdlOxDCAj
AZk+7bNliBZZ7NHicnCbsEJiLqa2W07ZimNFGuXILfQkSRieAxPxODisDaPFvvGQe44cbsxx
4I/Ht8ffwAYxQgOv3PSFM3XV827bFNXVWhcNUgJJVEP0pBbKYN3DXqX6VgdI1QLg+793GXrP
by+Pr2M4L7NKGXyo0I4pbRnbwEXI6IlNFKsVXINHd+jCuNxis17PWXNmipS5mNu2WAKmCOwe
IVsoNOHeRIOcBE2L4WQz24y4ZiXVHkLLtEVEnCltFPOV2FJZ2Zw0XvcK45bq63ER9yJoRXFd
xVlE6Py2IJMFXOV+htImmhVd1OKAd0viwki6T022oayC7ZZwQVhiap4vtoR+ZMvdvBXIFuTZ
gYgtdKuVxDgVPMIZI0DElglI8Ej8qYFS+v7tEzysKHreadMlgqDSFjWC3/QFbp5YW5lbJ4dW
RB2wlqTzyBa5WREXN9kw+EiTedfWYyMJj3wrcZQ3MEW7XnFSvCyitVD45X6RRLSwYWtXMAyk
m63nCafcYUYCVFSOXxPclRGGWU1YwzuJxYbLu9tzRC0e+7iMGJGq0kq1tx7cEmn3+C8VO/ir
ByE6JcaTelMTpphWBMIdpooRtVS72YRQq78o9WWyOFDZJ9+wJJzLhl0SAWMtG8JA02KqDi3F
M8C7mBINwSOr753hBx6qff3maqjvfbnZfti4vi6WuFWrK6Ug0tD6WgSRN9JVco73p8mezok7
IruejvBTSVcHT/exUnUayFVEFTlP7/HWChFWZTpCpm2Z/0vZt3XHbStr/hU9nZOsmT3hneyH
PLBJdjct3kywuym9cCm2kmht2/KS5T3O/PpBASCJS4HyeUisrq+IOwoFoFDFI2w1ue09XgcG
Pl3a9dPpQvfQsD20PYmbj2uGAT99aKajRSw17X1rMwgDt422FFkgGyqoGnwPdbpk0znfby4W
8CzdFgGGZguXQc2ARn7s2bWS3KRVN4tkjL/THFOKd3TIF+vuratLuqdq8goNocTgW7rP3Mv+
loV6BHTGoIBNl9VU2FpQ8el+QDBK2YvbVH6hdkhlV8WnK91xNbl8cbeQWPQ1ukNRXKSuqBl4
ecXoKjz1jcW8dmUz5qnBoTlsloDhFiPrITJXBJoQLywcBw6txQZgZcvofEQdFsBZScnvPoWj
JeY49QOy4VqH8V2TsSP8DLvlhSB6EI0+0Ey2VzpqwkWy3gsUQ4Gym++TUQFkLemaAh06mtfT
FbhVRkZzUdzug7N8/lZZOpdKR06HsDqwLZSzsT6GGjL6Hxqvma6s1Z1yiDdTtODRC1n4M57D
SW5UfJ4D/ZmuWRBxiIdqM7RpOFQybxHleGP0x8ROTMENtUrmMVOUHgPqiTIXWLxlQOvzOI+0
+vun16evnx5/0BpAOVh0CKwwVGnY8zMImnZVFY3sNEkkaiw1K53+Hxd0gqMassB3MBeIM0eX
pbswcM1MOfADAcoGFkAT6IujSswLld8oXl2NWVfl6BTYbEI1KRGnEE4vLDWdT1uXgZF++uv5
5en178/ftO6oju2+NDoeyF2GvVpbUcWbjpbHku9yRAQRz9YBIcTTDS0npf/9/O0Vj1qqFap0
Qx/z97WgkW/WhLlds31U53EYqb0oXgPrCYk3QNbhVyYOZhbJIKK+iQYaOEfDD6wBbZjVNLYi
MZQZWdPpcFZLTkoShrvQIEa+o2cPNpkRtmkEULNNE6Sub3GZ88+318fPN39ASDsR2ueXz7RH
P/1z8/j5j8ePYIX0m+D6F93xg9u/X82+hd2StT24YmGHh52t7dNxlKPTMhGY1V7ih3oV9+D8
BLyVWVIC/LZt9MTM2N1McoKM1+8DZFGxxMhQ5Acpjw0LDKq7ytBgUqXoQzaNbT55sWbTGUWY
904quThQ/UgjHT1n0Eh1cdG5mBpktPVGy0DYhiptFNeObBLtafeoxvOMXGOaEEfoetDxBVD9
pO1s23yA390HcYJvyAGuuszD9Hkm41UlkZE6bQGuh0h5dsdpceTpa9IlCsZxNJaREfXoDFKB
q+b6B61x6S6DWhg1Rrti7paYzMpSy5DqajoLOo3WaLXsxtQg8JGskrmva31kLmdOKrlHxkR/
iz5iYnLPz7xAdqPGiCcWoLzSykHKmnvRUGj9Qc9OPwSQIW2GsH3GITBSYOTYOubIcMaNcxl4
bqJy6ryr1jJUs39/pnusXs+NHdVO+67Gro+AYT5NVtObqZPRANsR84DjWmMn7YCYNsWMWlks
7hjW7dDzTtb1Gbus4HaFP6hC/eXhE6xSv3FN40FYv1o0DBEWwpr1kIJNw8U8yW5f/+Zqm8hH
WgxVfUtogMZywY0lwLVOg/pIBKYDKXWVC1WvjLGDXb4wyJx7jCRcf5vrD3jPs76gXFlAP3yD
xRYYV97ELOWSQxRneUOAIqKGrkB+RclKEGXwsakF/wMS8o0Ix8JvBbvypn74BuMmW5VUJOgd
c+FpKDIy2O982aMv9/l5infKwRpjrNM8nfzYdg3BPrRehzB0505nYrniAoaR+xxdgtFL2Koh
mcT0POql3Tw4X/HpRKxe0jnX9J6gPrEZXA77tNF6bn8e4CSputOLJDyMWNKaL4r0kTHrRXpq
dGzlFit+AeM26wJUg3GzRmeGjiptnt4KCc7I7W0COJXxOR/kyqfMIwE887ps9UwzdhOcrW/1
i0VXA4gqX/TfgzbDqOKlEt5pV1CUVNWxM1VVpxe76pIkcKfe4lxirvRWeQHP7W3GdDT4K8v0
GS8ANaAKg5jOZktQU9447RYidOnpgIo2HdBHVAvcIZ3JL8r0iCISQ0uXjrK5UwvB4igGozFd
h3JrnsFXk+s4t1pi4sG0RKJN6Ht64ow4kfe25LsuC3780BIaU0+fDZymWSVQ+ux/SqMaYh5R
F4FM9b8o0PMimZvQXbJjVAYUQ1K22DkIh7V0wNuoXhB+DWqkbL04EuCU5rYmZNqilgkLOvje
zHyAQRNoRLANMkiRTpLUR3lkj6UxPZhC6brYi5cF9hwqjfQAuwpaadcwMk/bZVV5OMBVqFoc
iCepUkzlFaij/tqZEZnuaclzNIUTGJiQlP5z6I721eCeNpwxwQyOupuOG7OQe6hb1Q/pcBAz
kICOUY9Gl0+7l+fX5w/Pn4QKYygs9D/bawomehZnrQXqD5d1QlVE3ugYY9xySEG6WpNwNS0+
qZkNLxwQYxcx8ssl+kM5x+YGh6TUQtqu5E9PENtFrjkkAafb6EWbYn5Ff5ov1vj5ZUfmpM2z
bviMjlnw5HDLrq/0NAXIDNHwUswsZny+FRNH5Ut5/nr88vjy8Pr8Yp62Dh0t7fOHf2MDiIKT
GyYJOH7OzJdK4oWWePAIT3yaYri2/S17IAvVI0NaQ6R2+anWw8ePT/CAi+7AWMbf/o89S5jZ
+M2QUeylFfRzeRHcYwamY9+eZVtuSudXFiY/HM4fzvQz1UIPUqJ/4VkoAN/VIEf/c2FS4sce
GvFqZhg7z9mpeTM6VeRpJwcIIrujn4n72k0SBytBniZg5nfusMOKmUkYnJnp1lnn+cRJ1Bsl
A1VWIB01kf4+dbGyUrrF29DC0GAnvjNM6FBUDZsWZHRDB5P5C8NQH7D6p2NM9TzHRIRJHVqN
28TB7UdmjjYrqhY/cFhY0PO4dVzByTgyOPhV/BEbNwIK7VCEDCzY/rnY0DB2i0vLsNgf+m3e
jGZ3x+ZM9HXLYGuws8sV7Ob0DcQTF5RIip2eq16joq/k+APyJEbnFv9g2h+DbLszxSHtRt7K
KalE9EKk6YEeY6OV1Ejpu/eJE2EDAoAEAcrufeC4iFAqbUkxIMaByHETrPFoYZMowo43ZY5d
hMy9Oq93kRvaUh1jTCdVUnUj28e7GH8ZqPDs3sxgh8wlDqCN8T4jgR5uz2ABixVQmiyPnlRG
sueMqDTMYjfZanmS1xHW8JSeBMiUpxVzQ3SKUMQLN7MyneLMEL9F2mwUdrC/ObHWrZ/58Wnq
DlstyRksooaCoDtYUPhOuxiToT5JYz9FJswMxgHS/CvoYfVZYezi2+TazB7p5RWMNwuHL+4r
vt9aw1e2bCuTGFErVhCRXQu4Q8fpCv9U4XYb/Rrv/C0w2M7e8s4bYcSf8ZqMFjNjhPGnU9zW
blZGy4N0k9Fy82oyom6jEDbL8CWn2HN8Ww8AGm1L4YUNf4mtsfnpW8WlTLFnHZEM3do+LExb
dYq9n6pT7G+tajNTGG/llGB2OgYTsjZybESrwQ7GSLZL3hjJ4prV2+4awfVGB4q72WBbGRBc
P5PWSZPKOFfduWG80YRDOZUtC2BkNqF0BGYkvtziVvn2WFgYqRL/k5ykynE/CVia25Jj5RzJ
1rCXqhPt36ivuyXQJT5skyeXx58PXOrHj08Pw+O/b74+ffnw+oI8HCwg+LRiIbyogBbihCkK
QK9b5RJFhrq0LwkGebGDrsDsymJLNWAMyNpZD4mL7fSA7sV4EVy0QlEcoelEdK3A6LQ8qKoD
OcfbVUncBFmHKT10Md18iPwdF22zZaatm/VPi/fnsir3vRKAALRC5RGhILCw7SxCWVXW5fB7
6HozR3vQdMn5k7J/r/v75QdPljs6ZmhL7siBqGnN51galXkWcVaj3sfPzy//3Hx++Pr18eMN
ywKxm2BfQgBbds2JTmrGsmHhx3HDxM9EJ2K2y3KBLtN6yk/35P0d3LWOnYZKlnxqGQAYj8Rq
BsiZFos/mbqGtFCo60WzmlN+TTv8bT+Di9JqVsTx2kgRnuna2A8D/OO4jvHVcqBpD+TM+Xqk
5U/VNTdSLFvMrIhBzPvtRR91xpHjTPU9g1rvk4jEZnPWRXNPBZAt47pjPmXMz9jVrfWr0Zgg
IzHSYJcWb/WXcqjDR2gmxwDlpFxnolviNMw9KmDa/dnI2XxgqaKt3noEQl1kitk6p3e92Y9U
OE2j5hBHEyuZfCPMiPMrYIPmyqoeJ5MgkaNGMyKmuTDgMiYhplEy8Jrlql0No/LASUSfqIvB
mUKsdBlxr7NAGKeDsONeFgargFysoxn18cfXhy8fFc2Ap8kdhuk5cSpIewNpOnMKXyftTYEp
0/V2ZlQPmRCcDllbhzK8k/DNTwV9+9NDEiKzd+jKzEtcXKefB4vhQliyGNMama9eh/yNxu/L
e8Wcm0v3PHZCT+8SSnUThLoLY7e+Xowa5enOsY/XqvN3gf+7LvCSGGnW+d7B3jacAz1aE5Im
HMJEz044hNKpHaEpmXMVyEmEcu9k/Y6T39djEpm9fK10j98qwznbu4HF4I3P8zrBo9AtqDh6
nOenOQTEw5PyjaGxPAFRunswl6m6ogveSSMqVgqCQrdr4E7W1ZsWnodxyAt+19cDugQK3WF5
J2eUfLnoN2pkqGhuhO3r50HkuztEUeHyAz8P4gyZ7yfoGTKvX0laoq90I10QAnH6Mj9BNmug
dsnxSBeudGj1tOo2uz1L0vvqzvqr+6//+yRMY1fbh4VLWH0y133ySrkiOfGCxMMQRTOQP3Cv
NQaoutNKJ0fFohcpsFwR8unhP49qHbi5LgT8UvPldKI8i1zIUC9HuTNRIXwPr/C42I5LTSWy
5Oz5OJBsFMm3eK5WeDA9TuWw5EwBqhVlNjCxFSu0OACReWJ0Zqgcri2DpHCwCauyuDEyhMRQ
WTao7RXeC14U7ZU/s+hQExjG3xdEdSUukTfsGSQm2CqpT6Z0VHs6JcMinB0jtQc81JLCj++B
dRb4c0h7a8X4jTz/8UZy7A3fUkC8ktWQebvQw0E4a9AObCVUFPSNQsyPxm2pcD39jUQ40xtV
6fVHMjJ4r5qZ8vT6At4rUxGdox4N5AJknvZ2qYHn3j+VAjl3XXWnF4tTF3N/rW0Eerragg13
ecpZ8ZVPbJvTPJv2Kdig4w4m6OqZ7LzQTGmeykyjmcDATlnDOJl9pVLBgkdQl0zAMs+aAxi5
HWHy002FE0kqjSj2lGZDsgtC5TBkxjKq1GO7+QW/eo4bmmmCWIscLEWrSFQYXOunmMSZGari
2E7FxTfLQ/aK5JvbhJKR5HgMpl58pKW0fw/jdMTKJyDduaOF65S/RytJNw6W1W7pSTAUs8R7
nfvUzsKhjaENDHTzeTgX1XRMz2jwqzkfOrzd2AnQnhbYVocxFk9+hjHXke4U6WiVF+wZYUMS
60w21RxML5k5YIclH1LLdHkTPtNVrW3Nhw0PrAjV4EchpoZIZXSDMEbKkBdDkQ2tYInkN+nS
x2yfZ0N2SGuxRtkhdeOmIfV+b0J0hAZuiHQKA9RLcxny0PsqmSOWrw4kgG5E0VRp+fwAfxU5
s7AtqOfiTPM4Y8OYr8QB1j0Ln/BAZE77fggdbDT2AxWdIVZ29qLvTPaoteVSQbrq+YqwW6ed
WBI3a3/OiOs42BRbWnc5zjD7LN/tdmiYCrYqrpVlP6eL7PmPk8SDQH4jwT36Pbw+/ecRc6DZ
kLYndBWi9ZWfI6z0wEpPMHrtOsqjGwVQekSFMN8gKsfOkqpvyc6V57ME7DzZcmcFhnh0LYBv
AwL16F6FsCGtcESeJdXYll0cIoBu/LgCmeUYfeEYy+mQNuCrim62KzwRq4eHhWUYu61c9oM7
dZfBLLkAprRK+5pguefEdsS2criRxV/+wmIc+hksZXg7pTXuDJVzHOLQj0NiVuJIMpNYZ64f
Jz7oocgXVegmsiGoBHgOClCtLUXJyAjiN0tpYyKn8hS5PjK2Srg0EsLFaJt3GaoszDDVWHrX
85BUq7Ip0mOBAEziI0OZA8i0FYBq5K6D+gM9GUatkiQOurIiYgQAz8ULGnge0vgMCFA5xyDU
nFblQMoByody7ikDkRMhJWSIu8MKwqAIP02SeXaY3iAx+FRJRJqAIz4qkigWbYskxuHbyh1F
m2ORcYT2nH+iRjv866zzne1yV2NfHPF5N2RRiCyiddEcPHdfZ/rCvor8THslOg+UOsIU6hXG
FhBK9VEqPlrreKuxKJzgn1kMBSWG7aInluIk28XB+43St8YLhdEm2YWeH1jSC71ge7nhPNgl
08zRDBk/Gy6Jcm6+4NlAN+PI1EJcySwQSX00PObM0GbZ1CW4BGXYju6sEWHdZsgH7MZwJwmk
Tg2VsfDhZFDPPEyX2RdgaIiUArwMZYdDhyRWNqQ791PZkQ7VIcreD73NuUs51FcTK9CRMHAQ
wVuSKkroGo+NHo9ukSMEgHUoRpRmAYDfunMlblKw1cNP3G0tRqwG6HtfRfar1mcS5jmxvzWI
OAu2VHLpiU9ewIIA90i5siRRgoqUbizoSrYtVeh2M3AC9NxbYgn9KEZXlnOW7xzUkY/M4TmI
VB3zrnCxZfC+ooVGhVJ3rWGd2MhNNpOyrA3kNLhoY1Ngc7BT3P+Bppch3bq6rjMyKqiSG6AH
OxKH56rG3BIUwSHlVkFrkgVx7e6QxiXDQNBhSOo6wtQhupS6XpIn+KaVxIoRgQLE6FxJafmT
baHSpMq7UZmOi3CK+NuCashidFkaTnVmeZawsNSdi55IKAzIasjoSONQOioZgY6dAFB66CLp
X8o0SiJkd3MZEs9HG/+a+HHsY/7lZI7Ezc1EAdi5uS3Vnbe91WU8W0OeMaDThSMw8cEm9a1c
KipKB+wUXOWJFMc7M8RuKdAysJsKNG+mj1giPl3TITvlLdrgZE93gISUeyWwiWzdxViyEgKz
yqxr4VbclgHzQvxGAjOLJQ2Sl62eAgLr6XIHxbY7zH1Wp0iCQFZ/TTzrrLRwL7ic/woQ1OqV
4aKA2KcCqktL6GWZCcKAT1mN37kpjJ3FmJgzoQ4ZmJeMP79/+QBeB+bYQ8ZZZH3ItZgYQMGu
wYDOAykdO1vwT/Yt8WP0FG4GNdN15uYCjPxQRZp9lA5eEjtYORe/XnpJmT8w5s0pa3E3+SvX
qco26sPCqTnoY0oGS2ZvcsrsZgmjqZsB1v7C353m0h6gGpxbYw7UWLOx+7FR/4advHlWr1AS
C345tzCEWMoR7opggfHXPAJ2LXIQYP6sdaq6lKAXkZTlmA4FONrQzv9YQ2WuP44jSlT9MMiA
0RV15/GnHmovjLRcvTboFdwLp4Hwc0fly1MZ0XXZ9jRZcIThOL9JFgBVCyfaDmWmqHFApSXG
7VshCFopm9oBgSjhBw9zAE29lO/S5p7KoTa3ReyjPLdFjWcMYJJ0daLq3SsZ3z4teIQ6oOCD
X78gFFTN98RKDY0icHqCXXSs8M5HP0vQB8MCTnaOWTAwb0CSSnboGdiKJlpKQ+RHegXnlzgy
bT7LWsnFPXPe3mkSxiT1xXBWKdI18yqdBU0P96zD6u2wsF1FBDbtb2OWLo/3tQIuBp8yUbt6
ZDTdpJcRbxNHa9W+CYdIdbrAsi8yuxtPxlAGcTS+wVOHFrNQht7eJXQk2yUn7LosA4RffGrt
k+7HcG3f1VphD6G63igp3RJgVgxieQfnuX1Waz2kvW4A2gBuuXyfiq6BZMqNC6C6UTenCcsC
pTwDuD88W4vbpVWdYusB3HW7TqjIMm6wbTm14GBsEzaSsbdaPkZHbzIW2HNjo3FMC3YJCC1P
xaUUk60MufW5+dnO3SynYp0uU82FcEGMtZMiVNSre8ThWgWOb468FQZjd0QeXCvXi30EqGo/
9A2xjIcukxl0Q35GnE3wJRp7QqMnX7XZqUmP6NMxpsAtjyRULZKTN9SpmUO7LGOimQRxZXmJ
zlqoDvEjhBl0jTXvWusLjgnbhhcFA0dbesyt7UrdqLRgMAbQ8jTBoE2af/qltNjhKhdm1yAx
1oj2VPM3KvpKMyPqmxb1Gx3hziSrbnZbZ0AMIHqxyQAS27YN0txqsXouz7bUICi2Hdz8rXx+
rZN0984rcChHCPrZVoNyV7wyQBipM48jR85KzVceiJRLOggatsVFlbyjJq8UEBRHpJlWHtiM
JvLxogqJfaqJ5aEvK1YS0tB/OhThO028rKaRN8ZkGBsaLIgVkgLCGHwrATG20QTEfnQzCU0h
lEaMsaVUMfQdl8LiyWY7GuKiYzFtQj8M0Q4WeiVSGL5v2ixMSaqd76Dpwk2SF7spnjZoLzE2
dzUWD0uaGVaONsTWtkwrwJUClSnBTQgkJr4Gbpee8kRxhBVS2nQhiQMaJrj3D4XLeKZnYQrR
wcIupoKdFYosU1Tsy97KV2zTcChEe9XYp+kVUfeQGpqglnYSkziP0BV6lSNGL/FVnmSHFz/r
XNrWONaFgYuPhS5JQrwXKGKT6XX3Pt5ZDMgkLrqfdfEtk8qEuuZQWRJ8EGk75hXp9mVKUMAi
FU0LbAk7nO8L10GL0F2SxLENVgZaDDc0LnT7sfIw++W+q09YGRYHeRi47p2RrNke+o3iiU31
ZvFAubLkwLbzb2TB7YLfYqqOVE9+Q5PgCtu+bdUIFzrDpS8O+/PBztBde7w+Qh+dLnWNacUS
413iOhGqt1Ao8QJ0AYHbdDdS3cwrKNsRb2YMTJ5yuKRiVEago3zePduzhs3zm1mHro/KIHMb
rWPBVtYJGr1NY+K7XzwJtqPdTML0pC4py3C5iAHmzknFLMfhCpPtEXhvHlsJJBMnWsqepIAg
eYDAY68WfUjHeQQu7U5kMt05VMrkmdF93l9YEEZSVEUGn69eoea9y+s/X9V4q6JUaQ3Bwd8q
GFXbq/Y4DRdbESFc2wABzmUOLa8+hdflSFYaH8n7Nws0u4mx58Yeo6GZyd6U1OaZ87iUedGK
OyG1uVpmN14p8X4u+7nLWftenj4+PgfV05fvP26ev8L+Ubrz4ylfgkqaiitNPQuS6NDHBe1j
9QyDM6T5xbyG1Hj4nrMuGxD8aXNE47Bx1uHcyLVj2b/riqMI9qkhdVF78DxSaSuGsBgLU0Wz
zehfREevTZsXWl2p4IcHjQg1r+mwOMobdKyVpVEvBfFc+0Af+0tnQh9ujBEkMZZa/vTX0+vD
p5vhYnY0jIq6llUaoDTFoBIg/m+ap90A5xiuHP6Xgvldk8JdI+s3/EqbsbFor6RgTuOnqiUE
HBxZ2c9VgY0XUWOkTrIwWe6weQOIMJt/Pn16fXx5/Hjz8I2m9unxwyv8/Xrz3wcG3HyWP/7v
tZGGASwEliBf6gzPSmlyy1378PX1+8vjbw9fHj49/wUFReII8LF8KsbyXIsH3NYRL7i0wDIc
q8e9OePywXfVDaO1eL/9/c8fL08f1VIqiWWjFyaea+YigCmtCHYLzZlImsauH+jFFmT2rZny
jGqj3uSJjISzdp9W+gqzDhlwC5Ly0HbaXEgvsXZculKnluBWSMCyP+fHYrBfrDAeL/OEwUFn
iYAFbF1F10hPnYDd4OoEX5uz8MZaL3ie7/syP9qLRGf6uQPNZauRy+7sT1nZGovBcNEnxSwK
Pe3AfqUjiwqjU/HcymbEKwJSFYRgeUTTq9OqavX1aPmQ6B/xIRNEFvJ0USwsaGnXRZyb2qBr
EmVb1hjOZQ5J2V2ZaNiabgTyFqV3shs+MctB4gzFLVvorOClO5tzaUHrHHugridBC1sYS/y6
iJYNXQiqNNM7ePZJPpGwm45ejs3plQFqsTGxV8ZajTA2izxvKmDp6rsNjWJORpiOHAluxSOY
h3La5yWxtxBwnC5GfwkyX68OBKn2AOHyqsEuIXs6e0lKpkPeuXryM/YO69nlw2yrHWauC0Gf
BAomESts6o9GFWkFLl1hZs/p5kqtMLEDhkvRnLGmOTdJKY8pe+Mzzr4d6BhFi5fXWLGJMZAp
MZOpXOiqk1yXpFkCmkt3KMz1tM5+AzPFGxChD+uqstor1oTZMdKkL8bXh6eXxyu4oPmlLIri
xvV3wa/y2qQU4lD2RT5ctvYJsj89Tnr48uHp06eHl38Q0z6+axqGlFkBsY/S7x+fnul+48Mz
OJX63zdfX54/PH77BhGSIJDR56cfShLzQpCec9m+Q5DzNA58c9nI010iP/YV5CKNAjc0uwvo
nsFek85XLiKFnCW+L9t1zNTQl182rtTK9xDdY6guvuekZeb5uNtRznbOU6qhYHevHKeb8zg2
sgWqv9Opl86LSd2NhnBpm7tpPxwmji0d/nMdxfq0z8nCqHcdXfeiUBhdiJQV9nWzKCdhbu4s
gTFk3DfbGYAgwY5mVjxyDP1OkOG0AoOSwBhzgox9sR8S1+gNSgwNHYESI4N4SxzFl7MYnVUS
0TJGBsD0DNcYtpxsdD67qYkDpOVmBGpk3yVfutANzFSBrFrCLUCsOUjQOa5egnrZmuHdzsFK
C3Ts8G+FXaQ8l270PfWiQBqPMMwflFlgjkzWrqhJj7R9CRQ3iNpglzJ8/GKdQzEfA1juCX5p
J80MS7QHmQO7VF1xX7akksg7lBy6hoohyPiE2vnJbm+Qb5MEGa8nkngO0pxL00nN+fSZyqz/
PH5+/PJ68+Hvp69Gu567PAoc30UENIcSH10LbcmvC9xvnOXDM+WhQhOsJ9ASgHSMQ+9EDMlr
TYE7mMz7m9fvXx5flmRXz40axJfqp28fHukq/eXx+fu3m78fP32VPtVbOPYdo1/r0ONvpNWN
hHlQRwZ4eVDmInrrrD3Y818cZm6V6kjcKFJSNL6QVBLAMB0nG3MvSRweB7rf0nOUFFR1Zj4Z
5Al///b6/Pnp/z3Ctp+1uqH+MP6JlHUnv/6QMaqvuBCMyYom3m4LlCOOmenGrhXdJUlsAYs0
jCPlOMaELQZeEl9NSgd97KcwDZ6j2pLoqCW8iMFmsfxX2bwINcVWmVzf0mrvB9dxLZ0xZp6j
GG8pWOg41u8CK1aPFf0wJNbmYXhsvyIQbFkQkERdORU8HT03whYBc0BpBswSfshob7/V3YzJ
20wCNXo3y+HhTVaI1rSkT9dj1ERVbo0k6UlEUzEueET+53TnOJYRQkrPDS3Tqhx2rm+ZrT1d
2Cz50U72Hbc/WIZk7eYubbbA0h4M39PaBLL8xCSXLNK+PbIN5+Hl+csr/WQ57GYmgd9eqW70
8PLx5pdvD69Urj+9Pv5686fEKm0qybB3kp2kAAtipFgscOLF2Tk/EKJrckZUyTVZI8VdCrta
oBNEtsJktCTJic+fvWKV+sDC6/6vGyr96dr7+vL08Mlavbwfb9XUZ7GbeXmuFbCESaaVpUmS
IFbmw0r2Dc2UYv8i1mZXjxRGL3BRc+wF9bRD3nrwXaMo9xXtKR+3uFpxzNyL1Tk8ucrueu5U
T/bxN48JBxsTnjl6WPfrBeXjx1ZhWCoddY8495aDGw7MXym+eYB4KYg77rS2m2d47mriZwV5
j2DSbc1qND9NYapsdaNsO7USYz0l3uW2lGBwjmbuhK5ptk/oJDI6DEKCpGoUz7WZVZPGZUAP
N7/8zFQjXZLE+vgA2mhU34vNPuBkfPO5jFTfjtOZjr0+A6iKAu4l1ahxoJWtGYcIGR904oXY
Mc88v/xQG215uYe2r/d6SjOAH0QLjhg43mLAjqkFvDO6XdRWm9LpYee4WsmLDBX8vnyUwbuL
Kuueo5sYADVwdcuDfqi8xHcwonbTxWSwVsz73KXrK9wgtzmSHTPuWwZrJtYH6zAF6ZB4pghg
LYT6eZBg32wZj5kQ8r3lQGj2zfPL69836efHl6cPD19+u31+eXz4cjOsM+i3jC1g+XCxFpKO
Q7qP1gZn24eupy+gQHT1VtxntR/qq3J1zAff1xMV1FBvD0GPsDsLjtOOMmU8TFLHttik5yT0
tKJy2kQbA6VfgkprcsjBXaIWlCT/eQG1U2+wxWxJHIsB1SIvPYcYgpFlrC71//U/Ks2QwRNr
rTWYXhH4S1Cx2dBBSvDm+cunf4RK+FtXVWqqlICte7SaVLxb1j0G7sxjNlJks1WJsED6dvPn
8wtXcnR1hopffzfevbMNl2Z/8jTditF2Bq0ze4lRbQIYTPUDR0ubET0XIxo6Bmzgbat+dSTJ
sUJmByWjT/5ZgsOe6rC6vKMiJIrCH3pS5eiFToi9xhC6cE/XeF0kg+T2NWF0avsz8VONkWTt
4BUaZ1FxawHeic+fPz9/uSnpIH358+HD480vRRM6nuf+KtsUGbdHs/x1djtDCnTaMq1uasy9
i3q6Y15ZsXIeXx6+/v304RtmSZMe0VvbYzqlvXx2yQnMoOnYnZkxk4Dg0r3szhffsIzM1Thv
XNJTmpgS8uGeTOb3ey8Pnx9v/vj+55+0CXPpA5H2ATO7qOtugntoZZMsaJI9mOXLLm2Kahq6
9nQ5pvKWEi0LK8z+4cO/Pz399fcrFWFVls/mhoYtEMW4nRxY0pXy/T8gVXCgK2TgDfLxJANq
Qhf640Geo4w+XPzQeX9RqWVV7jz5fcxM9OVtChCHvPWCWqVdjkePaolyiHAgz/e7cpMCPa2J
H+0OR/RyQpQ9dNzbg3o2A8hpTHzUhzeALZiBe/K7MwhaUJXH02BpwRVfo00u+a0gf/aKLlcr
E3+j9QaTeOaCVGDlYTf316rIsXIutssGkubw+sOxQjEKmW8opM+Wd3dYi0TydeqKmDbjUiMr
/gik1C6h58RyfLsV2+d0p4emlvbZmDUNmmCRy5Pwjak2f3/KayXWkSH7ZkbSnhvZoRb8nMC4
UjXAUulT1xd0FJayT2MllSaftOesQOoy9YPpdM2LTiWR4r0xtIHep9e6zEuV+I62kkmZyqY7
D6qxLuGlL+pzpRLrcqQaTCub7oqiCuJqh7GSwcbuWDa4serMxxoAmR2AqzavWono2pKlfU5+
9z011dlCvq1yMJK2pA3BVKeDluil6PctKRh4MKq1omUz3NrKrD71XUjz11hbjf25sRr3AFM2
VNMlrco8HRS7VFYqHrbLGB9niPza69mxgXOuayyCpvKh2dnwKQyuqbgUzYBjti+MAQXQpezN
b+ruHNBd6DnttSzarvInJWaxoAYolfFCNji/iVxGM50028XTbKantKPdShHQK5hd64kReBpQ
13r/kX0y5USf33s3MqklSbXy5WaRczcJEr246f1At5GoW16Oer58fMbGXF0mvuIYciZq3q0b
5jzBQ9/tLGCkf1IQN0qw92oC1B5Ws0bJItseEuDjmbA1v8QPfQRLMQ59UWP2b4KBChZdWN7f
u0b5YYiRFD8n4/hAFaxR9Iclu5mJt58+Uinma2Wpy741mmVv8WYuxpFtpu/Ta6GPOkoyZwYh
WdpprNf0Uhz6VpcD3BOfNhyTnUariHrVx4hDWY6dMW4ZlUXawqJAM5Zzkrh6YpTmGaMUqLiD
XwCvnprGflCOVBfS1NKJn1UtW1PVWZA6roPfEIi5g5ujs94e76hCKoSGOpAYsjG31MBUghpZ
grRwOAyt7cDAcDY0VL8bxgPuy45JxLSvUtwJN0ws5hFWbc4qvatSs5t4Qqgf5zmhAEso0BOi
ohYP7c5nEnbkxoRPdmp9bQkvm7w8Gg3CqahzzBXO39k+w8415O8MAVg0xPUtZkwrbpPDhzpx
jKFyylFD7BmqjbJnhRtbOwfMi6tkdPTG41RNrb1t+6Or3F+zvmwrbZGrxiiIgkLX/8rRUBGa
2gsjXSCNJ0MJ6ksqW3P8vQbD68JHvQVzbKflwUihVo9LmSa6q+OVvCnRmM+XlrRagqOneuwE
4l190GQKO2k45f9i5lNSrCPWoVrLUgLvHJM87zm0wZJOdEvDCNbG44nC1mJfFLi1/MzWgWtd
2uPgXNM6CFOugNGM02oobs2icpi/SsVKzHFSHuuUVnWzQJz1YhUNK8+yc0TRrOz7s005lNja
phjTZthIiC4pNu/vBqN1zEpszCTC1oak9J0wMNH1qETvQB62koV9LQ7puRp+d9bd9DIKzdz6
AkkMepiuq7QY98XvUWCIEFCIJ07UJnln6OfEuvED8/5rqRdgpmIrcF6i7yX44ny46jo6nEcg
iYO/VE2dKPatkdlSEHhF7aAujBS2IaXamSGmF7huh/NGEodUP0HgvqR10dNRdafQdb2caQnZ
wWh71GEzQ+6a4QS7QUmxYnssHiiDy64yN49ET6XyzIn+XMNoUn2+OQ4ndJJQxj69otAZMjKL
CUmv451f0Hx9/AA3QvDBej6vFCYNBqo22IpA69ifcX2MoV1X4YsRQ88wL6zwvqhuS9xzNcDZ
CSIpbMAl/bWBt2fNDZ8C12lGp6z9865v8xJiAdszYALJDt9RqUDsn9PePbZNXxJ7+xU1mSyB
mhlcFTbP1Ay+p8W3osei3pc9/l6V4YfenvSxglfGZ3vlaM5De94YVrd39mpf6WrZ4ssvwJey
uJK2seyVWfHuenbaZGUos9SiQzF0sGPv0n1v7/PhWjan1J7vLVVzSzrjN4pWZfZQsgy3BPXj
WNNecP/LDG6P5eZcr9NjmdW0X+31r2nf9BvFr9M75jHBytAXfODbUyjBmXl7wF1rMI4WngJu
jO2arubl9vhrBnw7CFjbU2XNLhio1kMlE50B9o7oiiGt7hq73Oyo7ILDfStepXCJRwe5fY51
fVmn9ixIWm5VQzx8teMQPrIqm40UhiK1iwiKFhWha1FhrwEtQFdtSJG+tnfSsS+KJiUbApjU
dJf1rr3bzGIoNyYMlULEFkST4Sc6me1NMJyoJj3wM24r0xlW+akj+I0dE4dlSVUh+5Qcy6a2
1+G+6NvNFri/y+kavzEheRCS6XTGHzqyhb7SQ1XMjzwQ/YMbx3iZpi4tCVJo0hScJT39M57W
l9fHTzclFTq2FJkKThns6eJJLNsBOctZCSP7qT1lJVW7h6EqpqKh2oB0QA54Afie/uDgVNeK
j3OEIy/kh8fAgXgGAjJ4pBl6y2YWGM5VV4JyamWgfza2ACmApz3d4Z5SMp2yXMvd8gU/QmUt
D0zQXLqrFaB3f//z7ekDHRXVwz+K3ciSRdN2LMExK8qLtQIsYOrFVsUhPV1avbDK90Nx7One
7YQvJHMbouC7+yCOHfNbMV42aqlVIQWvIHj577oCV3Hgw76lQ45cy0Fd4wRHLfvz7649XFkV
nLikIsj8XROaD/1g2sNpMb6JhxfrcNdl/RZcVxnnO/w1PH8Qf3r+9nqTrRZEuTkSIB3b9SJg
JD/J5/YLaaKFS7OMKuDK9euKa4F3AKD7pvY01RbLW+nTajhYAsJQnrqgyulUj4zZUmqJRxYI
ALV12k0nrcjXPclVSlplsr9m1tzloZ5IrtdqDsJua8DOaD7eDplWhoHKLt3LOm8SoyGBBh7/
wcHKZmOWTDT3TVoZrBKj6TcPqNk+Vt5x1ez0i6aqDH42fq76b96FBnVfnYtDWVRGG1KMOwix
lJDip9KPd0l28bSnSxy9tbxsE6VB71ZYG7HxWB7Uop6h6SIqArT6Z++NyXAi77VubMmp3Kfq
dReb6VntJX6oEuvhVq9Ne8V39DXdrQ5lhhkXNMUV1itpQMEv3aHaSuNO1zRk38PpVENn9HS6
0t0/uH/L5+UGdkWG/SH7LE0HV3l9yamN73jhLtXJVF2tdBrxI8U/OKdCEETV4osVMqsj38Mv
NVeGELtU5dVX3cdyWu84YNAcaPSickPPUR9wMIBZgKFEDyP6JjEKPKNqQN552KHeAjuysRej
cu+7Rlq0lrsQPfNlsGp6xZOHaCCBWShKtgRFEXgYWqLMrzg+NxfcEq5K4EmIvo+d0Vh+JDUT
Fcu3tUHUSCQy3aamLTyRr7f8HDphSIezPsmW8AlqZqZRoIpmrhcQJwm11JDwAXyo517iIONo
8MPdRpPb3VQzeMhS8CJrJDtUWbhzLVfHPGHhLdyWsuSEW58jqk02I7fw/MKalBlVidFvh9yL
dvosLInvHirf3el9KABv1AER0WdfDctJ7yoBmQX+H5+evvz7F/dXpor2x/2NODf6/uUj5UC2
ZTe/rDvaXzUZuodzgNpoAh7TxzosIW5XYnzE463bPoJ4EHpdYRtzNxRmj7OwP8IwyTpc1hg/
SqLH2ncDR2684eXpr7/M9QP2WEfFXZtM1o0gFayli9WpHSxoPeRmlQR2KqhevS9S7FW4wrhY
kVqTyjrsEkVhSbOhvJTDnaWgegAFBRR3Z5PaA6xRn76+wiumbzevvGXX4dc8vnJXm/B84M+n
v25+gQ54fXj56/FVH3tLQ/dpQ0rFek+tJ/MAbC1nl9oOjBW2phjyAt9xasnBDY591M0tq9ui
8C1JuS8r2t5oNiX9f0MVtAa74SmoEJ6oqAXLUpL1Z8mAjkHIWQHQkZT6IdPvC4HE1C+EPYco
kmCzK82DlaZbjkrIZYb4Y6U6ld44zG1C7hqql45T0aR7uqsF1Q4eKPDdrZIqZTmWTaHSljgz
/Du1hFMr6c5wC093/DU5ck9wa7fUWQZXsUHgkK6AMPfYNXo6lmybsiZI90nwPlIOTg15wumA
HFDg/1P2JNuN6zr+ipfvLW4/DZZsLXohSx50I9mMKLtUtfFJJ75VOS+JqzOcc+t9fROkZAEU
6FQvajAADuIAAiAI6DiTqe+3NgySpeF+KF2gb4SbfZGEiuuTKHYrWaoppl+zKaSug6miqJSg
nme0js48pmA4UGoH3Qk9HAP8JqSlq2w16kFVlIp77RvwNeDVup6g7QYUqRjiKPjOA6qhbR+O
7Y74yECeTav0YFVaiFU3vEztItscrc8QZeuszITx56u64MhtsYFWVhtS1Lm7kTALpmbKuVHU
BqzAO6ZiQefEIHyvn7rBqFRUC0eney1b95BMyQXTOvX5Fu6dnZ/xbTSM/Ww1N0pDpVOqQNkt
Aek3JhtYn8dqXTUcAu2rL3q0LEtFBx2TETUY1HxrwDoQ0HGOFBu5txeNXLnWbx9jk/RX6lW3
VCe5XI6ghD1nae1aCH3NYBm0Z0+JSUu+P5o9ktjeTWGC6dY7KRfpJUgSFM+eHk8v78Q2d2Hc
zurBAsgx8GOdFjmqfbFfjUOP69pXBcn4/UVDyeLsirPtQ8z1andYHre7plh9JRNrsHJZrqCX
jkMPSJQwJiRTVMNBCG6WljWwj0FOP+xyjOxbeKdXpkjg2uTT7si4tAJhAx25U4CLpzIriqN1
h9jzrbTWz0gEPPQbGtE/e+R/exa43umxjhD70whjaQGTpUzXbK6ITVrDi7ZFqQ5b4lGDMfz9
EqIYXRvjXqAj15QYAHsqYe3BSlnwThOAE5BkQnGror7lmCBEYYUYxobCrjhlQykCRukt2U6G
pFs69vvIAQ0QSsxsKUSf4+UiU9I2fkM1QumikY9dNnVL9R6b0gBUrWLqV3xYOXIzgwB1LXa1
QtMxNhDQcjnd4pALwhCLVXbg9udhs5ONEjCaEr+/1cBaaaGkQQ212+sC492/nt/Of71PNr9+
nl7/OEy+f5ze3sk14CWG3XXSob11vfzquleSTapYGKfB9pb24Wt6yFEUwspO2mVsxwu73lXL
yztUNJtj0i7bO4ne1wNrUUkyeD2C9yvssWr/NzuuGGw4SyeyKLQCao4LC3NYZFyVXRjsK1Wa
O+fNfsF+yFfpLqyOQJEP/L4f8WVZpttdi5/59ihtkDgqRR3e/I3gdOXvICV6u+PDbW7AmTQr
kZ+v+gH5Tsrd7maPjtmeEPxGFTtGK8MYM6xKLrDhQa05hp/O9//GRh94XF6f/jq9nl4gzefp
7fE7TRhSZJIzKUDVUsx9EpbzN2vHdShRjlwXoJ5fSaJOqZIpNjAiXJ+Om6vdmckR0ciMuj0T
FL81EEURhVOf7RegIt9VcxH53IsDSjKdumrGD5oRZlH58zmPyvJsOfNiJ47kLcQ4HUPimAnH
l8ApJNNPhslkKGHrT7VDEf+dQSUkjloDwC7hM1+XUuLUvyTHDsBvd3VBzmwAltL3gjmkWirz
gmPbqOLWzpGBcLt2y2YRRySHLHIt/0oExhp0vQYmLyueA5P+qOJrgYHRuXMkHZXdFzVzEb4l
ukCtIFsXOB+ETbeg3yosikYev9RqSBVwG8w3IqO1L9LiBtJo+Xb1i8Y/ZtkeZsPRQk+RF4dR
YXNFyUuSBn+MQzboCkYf1yk1J/fIG+vV1XgGCnhezRXNvq637LOJnmBTB9YQgTCHn8kOwIBr
QXLvTDRjVFtrAa7SwsXfNoXiUHF2CPlptQgTdy2xI5CrRTX7vBnurpwy9MCR/FUuG23h4hmj
khP1K+XOMez76eXxfiLP2dv4eriAjDiFEnDW/SUCkVoRFux5U643NlEQLa7V4Xj/ZpOx4U0x
UeuTS1+KIlGFelSjNpQRKpDLGzM47GSAF7waVU73a4ruFqirnZdLdNCe5vRvaGsYf8weu8Qy
Lu7ZBDOPv8W1qHz+rpZQxbPYwUIo1Sz5HaqEC/BCaGYxjuE1Qh2XzUaNofPTNc2mWEnHU4Qx
sTpnfpf4Nz5x7rs4LqWacVe2Fs08dAwEoMz5aIbCSZOl1ScURbW+NpyGRuy1gfATPmVRu4Q8
RJbm7LHmqHK7vV5jtVpnq09Elp60+vSjD/kys9aFm3a5za5WGPnWa3GX1kD2PlvbrfWIBR9t
xq5Jz8hltTxYZ2n9LR1JGvUMovk5zivAz9NZmE6v4nmuP2DtbmhgyAEjDjjzOCjzKRq+cHDA
C0F2/WNnM87taMAmbLPJJ5Umn/QqcXDkC/6TGUjc4p7Bu0SSgYDzz0HoiP9ux2E9EDjybg8E
bMpthB43nKRevPZYxyitKG3UirXXDFwLqEM+UKrbmkeFHYq2Bci9XKhy4OILhvDrmxAqOVZS
1lYjBNsIHquEeV4l7Z6hDLguEVtaV/GUNYf0BOqQk0ZzpYKbvjPzPVSWu6HTRAHbgMZB3hzO
FqPV8lVxWHKw42ofTb2jqKlvsb7i47tDpkQNROsIUgEY0IquM28ljaW5ie9JKu4v8Jwtl+sK
pEfOpvVFimJrhwwZoPoC6Wo5zd+R7WtAyAJHxMcINWA8Aq5QSUfksjru5xFVbJAUKs8fr2Ct
soV/7bdDnAMMROl3Czq3ss6sdxudGmr7/vQapA3P00OxzYoRuFjDI7DdyIcInADE4gK9fOuq
aaraUyvbFXesaAVcFo8Kam/z2FkMNP5RmTpP3fHN9tvp6HMUMCrUfFhg88bCAh4amDEbuhVZ
NUP976cgzSGq17FpsnE3U1klQewekm7+8kULDaqNWe3p5hASsmo5y6dNmcoZM6StdJbR7/KC
0depRQxv3u2awM1CDRFkak/FuE68TeFLRCEhGZ/jJkdxzcOs0neSvCd22lRw11cQFyEDlPxD
jq7dPk+m+MLJamAcXDWV/c3aZHashWQGsLm58rGaY346Fn+aSIUFZ9KWm25DZxWNUdHDq2bP
HbP9gbVTrIYt11R7tk/L7ushlad7IYqWeuooZV0t3qrmJLMLkkbw6sCC74bpA4SqhfcXWXNl
U8jmWGK7Xdpkaix9tDFHFgr3lPQUO8cy0q96de5Q1UY85dOUsywb1ZEW5YINPVSoM3Cv/saZ
Vw0sxc9bDMjKxr0+vUAc9olGTsTd95N2W5xIO5BD38hRrBtwVLPrHTBmH8pPCS7eB9gu81l/
0JjrWpnLtBGF8dEUqZTNpt7t19w9+25lyO1eW+4tsNVFWrGROdQR4BWXWpBElihxLPtiMKw0
loAT07gkcIlRIZOx8vR8fj9BSsvx2V4v4b1sZ6m11udBKd71xYjb57McV2Ya+fn89p2p375h
1QB9UcpxFI1El+h9o6Tyy1BAGNYuxouJ4HH+eHnQCWAHx0mD2GWTf8hfb++n58nuZZL9ePz5
z8kbOHb/pVZPbncaTnlRHXMlrxVbCQG+BWHVBN03nj4/nb8bGyGXHBYesWXp9oA19A6qjXqp
3NNA2Qa5biHOSrFd8YfYhWjozxW65fL36CpHo31cbuZLzRCoIT098COgKhzda5nfwFmB+5Ys
Qm53OzHCiCDtiwzdGreOz+3E132wHzXbeLmqRxto8Xq+e7g/P1tfdincC7mjaBTo2xdKnpLN
AneYrVbXu23Fv1avp9Pb/Z3iZrfn1+LW1fbtvsiyzlWM/bJcpCkob1u5s9+udv34rDXjof5f
VevqAxyha5Edgs+Wl56Aqp3zPmCjJszFhJLU//6bX1SdFH9brdH27IDbLsN2b8IfVzMkUexs
bty3aR/LKr/ltwvw3O2qTnnTI6AF+J9/qVNh82qZCZflGdDaSMkOE9tj3eXbj7sntZ7sddqv
FPAABQ04hWBXyI9II4DlH2ncYgOXC05G07iyzLJRAcXDuSNT42S1rEYFZJVDIXYkOgLJCdIG
Z/iU9TFfsq2UA4PAqFTU7KiyY4c38GBfHZbzV5n11k1u2w/o0FGMN9ghAvZ6EOFTHE52AC98
R4MOu+dAMePSzQxo/DoUQR3NOQyaiIANMTmgI0e98fVhSWJ2WCz7JUK4om0OFOxFI8InnqPq
hHN/qsFxL8NuYKYEA6p2C+LXq+SxG60crGviQHqB/wYPZgLaIGzvKn/YlU26XkJ0MFFaMcZ7
snBE5myU1fX22thgDuZekmofnx5fHBy/Lcpi2x4P2R4zd6YE/qBvDRq/b22QxDMqwA0xWH5L
UBy+C2pZHlb1knOQXbZNNlywL/9+vz+/dJIpF77BkB/TPNOB+3nN2dCsZJpMHTb1jsR+BWvj
q7T1p9GMT2s70IRhxPOogUQ/BHV+/lE02y4/OoUb9q2OR6Xv4jguHbpu5skM59/p4LKKIi8Y
gfsYJ3iRDqis94fkDmmlAdXE3R28asoAovE7zDfFihx7xg/huF1WbEDEzhpEI4p0lnlZs/d5
BTahqh/HxX61wirIADtmCxZMXy0RuP0wDGEhWoCSFPeV3djNqlhpKgruHu8piZzrofkvzr6A
yoxIdavyKPQDRkMSYBL5ZZQLowOzNQ5d6xMZGB3l/v70dHo9P5/shNlpXkg/Dtgn6j0OhThP
87YM8V1lB6Cexj1QUocjDZ4Ftp/xCA8xnMa9WVSpj10a1e8goL+n3uh317FhmVeZ2pf6mSW3
0PM0IO/y0pAky6vSOseukwZAk1cByHGrrOe881HWPTiWy3Wacfkq9CQ3HVWYtoW1ni44CIZ1
DQ+voy38TSvzxPppz5UB8jNx02Z/3vgk7WOVhQF2K1LytpLzohGArpMeaIWYSWdxTOuaTyOa
T7qCqAf8xbLBsQmmdRpu3Kk2i4OIikdZGnqsF5xsbuYhieitAIs0Ij7R1kYzm+/l7un8ffJ+
njx0qfjUkajOwXdyxqe5CeOstruSLPBemnmJX0d0I818Nk45IHD0APU7iGP6O/Gt3xZ9Mie/
pzNaPvZiqysKog6HNFvCy6G0LNmNRejIfCvMzOrjLJ4faS/Ja1n4bX3FDEdlUL9N2nvcy8QR
xQNQU078BwQOuJDmyRRnMFXcUfsZK9FlZKmhMG1lSas0ygML04rAa8ew+ZzC4OJQO5ZScAZ5
Vj3fAkKAGApabg/LcicgjnWzzEgcjv6uPCdMEo77qg0igHP3DsV8GpIFuWlnPr8be7MqX1NR
tTNrtExIFLtHpcjA7dlRjcJCDIxRoSYLpmzKAI2ZRyPihM3hpjE437uSIr3AAvgk562BzCkg
wA8EABDGIQEoDQ5TZCIMcK5VAEyxqyAAElKkc5MEx0Ml5sJLQjK41XJ7/Obby8vYP6XavHT8
KhHEQeIY8226n82xTAq3s7ReLeweQLQfe89qnKjUnLbHdmc1YVlCQFwu+F4MBIdx0xquwIjj
G4+Xr/XOXiv1Nmpif25/LDoXdEAVJ1osVcVOrF7jkBfBxMFhTxd4+23GisRv7+E2KF/JvGKJ
DYYU0X4fmTf3GRj1l+ihU8knMjZ4P/DDuV2V783hJcUIHMylF43BsS/jILbAqgI/smGzBGtS
BjYP8ZuYDhbP56NvkSYmkeNTKqXqjfiGQjRlNo2m3AAcVrF+No9GslPP276aXha4du5jyUBn
MZ0sTXpfIizWSyWPOAzY48LdjczPJ6W3j8T8eRhzzG1TZdMgIt0eKjA1/Dg96zCV8vTydiYi
C/g+HMWme4yHTzxALL/tRphFtYypEA+/qVTYwYiQkGVy7hN7W5HewuLnthLE0K4LYGlrgYVS
KST+efg2T1r85aMvJboaeXhoJ0dkKK4ijyUExd2uy8s13ubxoWt3oui7jLr4cSpPgNuo5KV6
M6DmGlCKvhyqFKsKUgzPKdmlNq7CUjVoszyOzKeF6waT5qs+T+7MEufF5cjDwUjU7zD26G/6
XF5BpixLA8SUCKDqN9F5oygJaisAQwe1WoiSkLcFAs7jRfYoDqb1WFeO4nl8RVWO4iS29TOM
njlMWBrFsUNAxL7Vh1nMe98CauaxDlEKYwnnIc18q3jRnLU35GIHiWdxEA45neKEWL0YmKe2
oOe7Xh6B9BazDrNVHIQ44KESwCKfSnXRPKACGbzgoYAkICqhPoDT8Wk9CjgCkTRSddAGNGCe
AUfRzLdhM2KK6GCxT05vczjldgyWPtzEtZ1lrh0VY3n4eH7u02aPWIWOBTxOsjlcONoVdCms
T//7cXq5/zWRv17ef5zeHv8DAeXyXHbZ55E/pvZuuXs/v/4rf4Rs9f/zAcEx8MZPoi5gJHEK
cpTTNYsfd2+nP0pFdnqYlOfzz8k/VLv/nPx16dcb6hduazUNI8JVFGDm49b/v3UPqbSvjglh
hd9/vZ7f7s8/T2qw7TNY2+g8qh4DyA8t7meAnAzQ2fliq0Bby2nEb6pFtfbZ26hVm8pAaUL4
HBhg9HxAcGoAEvvQw6PeAWxTXneGaGleW7g4BbNZh/0jQmsXjAfVnMOnu6f3H0jY6aGv75P6
7v00qc4vj+90DlbL6RRnLDcAElsDbhU8nzUsdagAd5JtDyFxF00HP54fHx7ff6EVMkxlFYQ+
dyGXbxoqVG1AimfzMm0aGWBeaH7TCe1g1km2afbssSuLGTHGwe+AzNTom7o3m4pjQWzK59Pd
28fr6fmk5N8PNUaMXXvKDniHi0d7ZjqLRiAqrRZ+PPptS68aRlb0qt3J+QzbB3qIvaYvcD4W
x03V4kveYnuAzRHrzUFuTzDC2jUIxTfS7atSVnEukfmBwllZr8dxst6lXEi0pCvTiSuA2aBp
hzF0uIgx0Tp1dnSGV/6ZHyU5RtN8D7YcvBJK2IyEE5ZKTPDYeH8il0mI51VDErJGNv4ssn6T
yAxKPPBpmlMA8U98lLpKgyVnEFTZ8QBKoeKI23lYHzEZ5kW9QxO9FkEqPKzJG4gaBM8j1+/F
rdLhfUh669DDtFIgyyDxfJq3meAc8bA10g/4z/tTppBgk/WnrL0o8LnmTDhr1sZXRx5aF+VB
LYIpiXCfttMusy9m6gDjrMfbXapOYGJh3IlGrRVuQoT6FB2om3a68H22s4DAd3CyuQlDkia4
Oe4PhQwiBkT37QAmW7bJZDjF8cQ1YBZwY9qoWYpirp8ag1/0AmA2CwhgGuHk0HsZ+fMAeUse
sm1pD7uBhdyJdlhWZewRLV9D8EPKQxn7VDX8pqYmCOwH5B2DoszEuM/dfX85vZtLHobN3MyT
GTn8NcShjt14SeJzi6K7qazSNQpigoD2sTMgqDSVrhXHs1MOhFHAxyswvFpXw98q9k1fQzN3
jv1q2VRZNLc8wyjKceloU5GP7JF1FRIzPIVbS5/ieqml9zfkpthM/sfT++PPp9Pftj8oWGDs
TIh9bbhMJ8XcPz2+jJYQOhYZvCbow1BP/pi8vd+9PChF7uWEvENVNzZ19xSFcxHQCTXqvWgQ
2pKpQWMtBanDuVaA9kprDZwv5W4neLSO1EU60n0//5Xd6f6ipGOlwj6oP98/ntT/f57fHkHd
46RffUZNj2LHO5b+Tm1EGft5flciyuPgS3ERJaIA87ZcKi5D73eiqW1vmM59G4AtEJmYeuQW
SQH80DJJRDbA9/Bh0IjS1i4cn8J+phr9dxzyvBKJ7/EaFS1iNO/X0xtIdaxashBe7FWcQ96i
EgEVvOG3zfE0bCRq9pLNIq2RRJyXG3UMkIDquVCyIMcEN4IarIpM+C7dTZQ+vrAwv22Zu4O6
jHkKrVg0d5xVMqJXgvr3qHoDdVav0CEXhKRj2ToL6YiRaygr5BuMpeU1kTqR2bEMvJj09ptI
lXTLB4cYLZdBnH95fPnOriIZJnb8EXxyk3Ldmjz//fgMeiVs+odH4C/3jGlFi59UKizytIZ0
bssjDjBRLfwAb2xhBaesVzkEimC9peuVh5NSt0lIz2oFsd4uDyhVljPkgngUEp3mUEZh6bWX
dXMZ7asD0T2jejs/QaiOT91XApkQhTqQvmV5+aQuc7qdnn+CHc/BMzQz91J1di0rPgEs2HsT
NjuIYq9FdYTUnNXOuO2iKSzbxIuxxGsg1uVopdQizoKmEcTjpFEnGyvrawSWcMH848+jmJx+
zChcNIuGhJBSP9UO5/R4wBQ5Cq8MABMzv8HBQgEMS1bscJgFgDa7XWm3JZY1HztXF4AcDPB2
kluW1RKnwlY/J4vXx4fvp/FTNCDN0sTPWhxABaCN0n2mRJME6Cq9IReBQwPnu9cHrv4Ciik9
PMLdcXspW4+ajQRX307ufzz+HCf0VhjwSac2hOOq4O9q/tSPlNPiWthuJbNlUK2aJsJYerRq
8EppCH6jaegCnc5BJK75Rz44LpiLpq9/Mzc95Nyhv22FPK5xeGNV2xAwPi3yJXl+Da+qFAUk
h2VlTkBvGxM23/YrhpqzXbUotg6HfCWHbtfg6wKh/AU74oSkkkQnGM34pVcizW66xT3YyHcp
vFEXWRH8X2VP0tzGzexfUfn0XpWTiBS1HXwAZ0AS1myahaR0mZJlxlbFllSS/CX5fv3rxjKD
pTH2OyQyu3uwo9EN9BJj4LwWsDBEVSYto4zmVCw7+NHWZZbZsrPCsHZzfhkA983MthpS0CWv
M3/xSLjy0IvMr0WhbRGirfRDuyooGnhFP1EJJNY7v62Y2lhcB1D19ueDpfESCVThwnpWL310
oUJoe22djpygaJQ3VUmmQLEoKts8RMF1dFkXJp/TAijqVHk1Oz0PMGWyqtYsAGPwl7A/Q+i9
if5QgV9Ign6ddUFLb28Ka5p0nBkTgPHkzH1Q8tB++EYlmm1ujpofn16lL8rIUHWIdMymat1J
jsA+F5UAeX7jeDQgwjwYy1y8LaVqIFUQ1RWBKogJnctW489EvGZAX/7kc/SFB4IT/1O5ei+W
MvgSOXcDUb/eZwFZSDSbM0lFVjSgT2I5LEZStl9LIkvWdXByNJBAh4F16VQIVKIAFb0U22Cp
dyZYjgxB5cy8+aRoTK8sRNHMVZYLO0KQ/KLGWphtWz2AnZqtFoVNHYLNlHXt5JqykdR6MLgG
NlNNZ0FxyFgWyTuOVNIfB12KrydWWC72wF6jC1RtwWj+Y0WCm3iiio3AkwHPXLKCBtO3FuX0
Qlbcvt/W+zlG4PGWIEVag0wSWfSszlnKTs5PpQNU1mFm9Z5omzoO5XKIdE1TqJXh7potX3Y9
VALN7dqcEr1tsos9DhDRhmrP+vlFkcPRGRENHarJQUSqiZWQVydkTzDGjpei2kN3tiOTAe4b
aoFLw/Op5ZSzqtqUBccEQrCuqPsUJCsTnpVoG1an3KtcCjxUT+SpK6rrxfHscmIg1OEMS8xj
GhJ+nVcUNGQxEi4zr6Nwu+J5Wzr3AQ7NppHTFyuh8XtSM8ylODmOY9g+5NqRrg6esXIHblI3
tn1IMXGKuIRpIyh2MnriTu3ggSqevBzJtECfVv0WFIQ4H9R0ksf9EuXECWdcFqmDsjmttpgt
a2KQBkGJ+t5G0m4oDtVUK1tlaz47geZAvwnBY6BYaIpoUWKzOD4PDz91qY95MjY3iYuS7s+z
y0VfzTu/4pRpSSvawTS/mJ1Nk7D87HSh936k3R/P5zPe78Tt2DSZE13rST67BzEYk6vEh12p
IXiIUVHzRwqe5+71mSOsWmViQJSEDHqY236r8CNIMg8gEFkpadwNwgBD6BhmanPyzy9PD5+d
29EirUs/+stgQK7ILf1YLIttKnI6LEXKKMOgYqvCW9g/1bOOD5S6u3AUrxFRJmVLX+hpR2O+
6hqar6hCjKTPMa4T3QGX0KvPocHofbJFzuTAyRe0QuPUUbHCqsP+ST+UJmWU0/PAEGXJloJl
4F4jVIkongYj5tYp9zAmDLKTRRkGYyrzilXmo7GChzBJka+bYovJq9cV6d+i/GeCT2Ugv2BU
lUnb7ujt5e5e3t9buZrMhy3pQy53artxrpQ0DDfbxCf9OvIZHAtTn1Wt/QBloCar6WjMFvbG
fOTq9Pirz9d1qO37mJ7NHMMlmbu0qkEO8myNA5TMckQUbAiD5x2fItlSK2SgwouBWLe0t0ys
ApHwRcwybSDKWbLZl3PPyg6xy1qk67Drq5rzWz5ih3p1aypMVEzE8rCLrvla2FdN5YqGS2C6
ykJIz1YdAfUOAWcU80r+ptrUuF+BslVwGS2gL8qUYlJIkjOpEumoESFiY6cMtuB+FDNENU7c
XglZcgyZ4AJLN15Sy6m25V3WChj9/WjFZxlNELHlOnTbWp9fzu3UoArYzBbHFy7U7S9CdMRe
ykQjCKdSAbetLOWgEba5HP7Cy1+vkiYTuXcljCAdkaqtM/KMGkmKdRonk0Yc8O+CJ5GorGWH
JNRIl244Se/VQxnsP3w7HCnBxnkH2TJ8Am05zCs6ezf0ZmkwJKOdNZTv23lvCwQa0O9Z2zr2
JwZRlY2AuUzo3huqhidd7eXJHklO/CpPnJJDlCnOwSz8UhbxUhYTpXgZsD8u07n7y6eAovJl
AozOuXYVMOaAsds0AIE08e7gNUb6jvuhDcMyw/mwkdNzYlNS8zLKc5KGRO0DlEasV41eQAMt
HIESRlmPtP4QGYgzb+NLjcHKAdQBl2PNH4jrDu+PCqDrg/ywHrWc2Qk8a2DoqDfTsTK+6re8
dlIWFiILh2U1jw/vbVnwOBbbSUr4seWO77zu3lCQfqnivlcWDjPH9ggW9hszBuVDf+gbH283
ihdJfVNh2rJYs3FgSCawaoi0vgpESnQSA7qV/dK2Yn6qSAORAVYaGbsnF02j86oNFV13ZUvf
80oM5mmVNz2SlWNYDEqtQMqktYOEdm25alympGAOCAVqB5A42oXOz+rtKBjHjN1460Ox/7v7
rwfr9F01hjFZ8yBBmP00shcMBV4al+uaVIcMzSg+e4hy+RGOPNBU6TyVSINryU1MM0AndqJF
RDZwdDdTY6HGJf0NVKw/0m0qj8zxxDRLqikv8QbdHeiPZSY4fWzfwhckT+vSlSnFtIOuWxnx
lc0fK9b+wff4/6KlWwc4Z43kDXznQLY+Cf420aITkDIrBuL04uScwosSAx43vP3w7uH16eLi
9PK32TtrRi3Srl3RLgCyAzSXL1qz5i0TlElmK9H1jpzVyRFTb5Ovhx+fn47+pEZSnq9uWyTo
KuKiLpHbXGtp7jcKrKN+oaslpWlJSnzdtXmDBOKMgIwH55Ltdy9RyUZkaW3nxLzidWFPr3dv
0+ZV8JM6CxTCCA9mNXGVxZgzOxCh+jPOnLlLCwd3KEc0Ksu7SqTusqwaU4/HzzSWxiQKtgpW
D5fnDE2+8fgr/K6yzi9hOdGUZawl3Cv642o41T2I5orHAXwH5x8fXKAsScvgMRu9Eh+IBiiy
pstzVt8QtXrzOsBJWWrATsjmigYfxdCSFAM1lFXrH5+K6DYT9F2xQme39I2/wkor+Cl8txRF
vH058DdQpV3LABtX1aKcEHNHwkbcTrVDEa3Ytuxqr0eG+y+Ft0oMBJb4lhUJT9V4EgRQIgG9
Vb5044XygGhaOli4omA4piZDwkRLQ1ViwEysjLFXXbvhRSsS1jp3Kwmcyu6eUxAlc8aykEuK
vHWsv5vrjjWbyGbdRjURTF+89wWnPEa9qQIuc13sFzFywJ1586xBnm5Y6yodVU3Cliy5wsCU
N2pEaFXNo8zdGY+VV7YbvwWwdZc69ZMPV8Ntjh8QqOwLSfUbj/8MbxMMKwgIYO1OIReTyE1i
o8dDVhFcLEYWRD8NKTrcDyShSzZRk99LI/VM1Wp3nKKPj4ShJhrijsnPiw2KfPftv4t3QbEJ
FWXfJcEMF/F6YH8SrV3Sedlumq3LCIONoCDqUKR4jLWdxrO/LmObEvS0XVlfeSKIQXrbFX/b
pgDyt2PgpSD+NYqNXHz47pEvejq4Xl2WLVLQ0q5smlRronjUElUIUtCLyc5rIhQUeYZEbt9S
0ch0NV1aWWlz7Doo1gK6FUaLBIGktJiE5ODeTxwNp8IhkpxZD11R2zmK1O9+DTvRGkUNndD+
eLWhpz+BE8kuCn8rJZf00JZnZJaVO9Dr5UFnBtg5s5Bqx9lVX+36DRxDdJuQqqsSltE3bhIv
j9lYQ4JlPkIjSTcHvFQ8ZGLnCcJfaN/UCgQFkkUl97gkfVlFNmpmL87MYluW+mmhjf7ag/7q
LFobd056Trkk56fRzy9OKSsnj2Q+8TnlFeaRnLu9HjGu/a2Ho3xTPJJ5tOCTKGYRxZxGMWdR
zGW0A5cnZzRXc4h+PvqXJ/HRp+PCuk089zosmhKXWn8R6dNsfhqfFUDGpoU1iRB0VTO/PIOg
GJSNP4l9SMUps/GndEPOYuXR8fZtCjrNuNNLytDNIYjMxCzYnVeluOgppjkgO/+TnCUo2jL6
DtpQJDwDleUnJEXLu5pS8gaSugSthxVUG5KbWmTZT+pYM+6R+AQ151dU8QJ6wApa/xtoio5M
qOgMU6T5bVdfiYbKlIMUeAvoXNVn1BVxVwjcMJYEqACgqtc5y8StVBntzHmaTpT97tq+dHJe
OVWsxMP9jxd0iHx6Rgdw64YPT0K7bfi7r/l1B1X08SMOZJxGgMxYtPhFLYp15HZIF0ndD6n3
D1DCdBvGFvTppi+hCmZuTyyUfKPQ+rMTh0Ep332a80b6cbS1SNqQIISsqGK0dOxo1gZXsZaa
6hUIifh80pRdnbjGQCBWiUQ+wOCViEpBRz+TmzqaPJY1ZCBpy7y8oe+JBhpWVQzqJC2XDE1W
stRzwPNxMFnQO/IpZyC9YXaSirEjbIWeMSKNlA/CcLkrMIpS1CAgeLQ0+0jfso9zbwcohBJB
sXu6/+vz09+P7/+9+373/tvT3efnh8f3r3d/HqCch8/vHx7fDl9wZ7z/9PznO7VZrg4vj4dv
R1/vXj4fpJf1uGl0krHvTy//Hj08PmB8p4f/3rmB/EQh0NcJPef8SzaJQpcSEKSTofkldVdn
SNHAx6K0t3mkHQYd78YQ/tTnCqbyfVmr+w/7Ma65KfxYjwqW8zypbnzo3gmcK0HVtQ+pmUjP
YLMm5da+CwO2gHd76inq5d/nt6ej+6eXw9HTy9HXw7dnGb/RIYYRXTsJTx3wPIRzlpLAkLS5
SkS1cfIyu4jwE9R8SGBIWtvPxiOMJLRuQLyGR1vCYo2/qqqQ+sq2BTIl4GVJSApHIVsT5Wq4
I3tqVEdb1bgfDoq3ND0Iil+vZvOLvMsCRNFlNJBqifxD6e+mz/KSNiG+xFbFvxtS8ah3tR+f
vj3c//bX4d+je7mGv7zcPX/9N1i6dcOClqfh+uFJQsBIwjoligQWueXz09PZpWkg+/H2FeOa
3N+9HT4f8UfZSgwP8/fD29cj9vr6dP8gUend213Q7CTJw+khYMkGhAg2P67K7EZHDvO33Vo0
MK3hBuPXYktMAofygD06V+Iqs6cMmPr96bP9pG+asQyHL1ktQ1gbLuqEWIk8Cb/N6h3R3HJF
ee1oZEW1a0/UB6KPzjvprfFNfGBTkFbbLpwSfJzamlWwuXv9GhuznIWN21DAPdWNraI00XcO
r29hDXVyMicmBsFhJXuSsS4zdsXn4WwoeDiSUHg7O07FKly+ZPnR8c3TBQGj6E77qqLYSS5g
KUtfRlrxMRwiT2dzKiKKhfd8kgfE/JS+TxgpTubUZYLZgxs2IwpGMPZp8sP56Vm4pzfsdEYc
sht2EgJzAtaCPLQsw0OzXddOhiAN3lWqOiVKPDx/dYxtBw7UEH0EKJ3l0OCLbinID+uEDi4+
LMxyt6K1RbNEWc5BGyaYOEOtzLsqtnDh4kNoOA0p2eOV/Btv1tWG3RJyU8OyhtlheTzOTzB2
TpTC68pxPB5WQbjLWh4ODahrOKgx+Dhqaik8fX/GmEyO5D4MjnzXCtn7bUkM2gWZLXb4JGy8
fK0iCvIfqFWYorvHz0/fj4of3z8dXkws8Ac318GwHhvRJ1VNZgI1XauXMllOF64IxJC8XWEo
zigx1IGJiAD4UbQtR9/yuqxuiP6jfAj6qph4OPAIjQT+S8TeuETpUAuIDyC2rdc5im315NvD
p5c7UMZenn68PTwSZykG82U8PI0kHBjGh+8EQh9hJiQE+XHsmEOc2oGTnysSGjVIjNMl2IJl
iE4jnTbHKsi/4pZ/mE2RTFUfPZ7H3k0In0gUOao2lDCHXiigve9EUUxpM0gGx+Ni74Tz2exA
4S1SdNWWuJ98L5Jyn/AsizRDe/5O73ega06r6RL8/Ub0uIXzyFKLohTEXI/YlloKI7ohluGI
FYSYOGJ5QnFUp+z58YLyNrJIr5OQ52u4fQtA1YIkvJCKq/dqOEn766VCB35earPDoGt9xosP
IPVEisSk7j9bMiJftzwxTJ8qR7twMdKZ2aIzidsixSh77Z+sX7biuA/IuUkSkAcjhcs4HQ2Z
JtheIHlWrkWCEWdiS2ikCF/aNTlrbvKc45WzvKTGKABjey1k1S0zTdN0S5dsf3p82Se81vfb
XHsijQTVVdJcoHXeFrFYBkVxjg6tDT67Ddjx2l7i8RYDP6evjsW64GlfceW7IK0r9XV7IJ0k
GOL+T3mB8Hr059PL0evDl0cV3e/+6+H+r4fHL+NBqGxM+rbG4CWpeTYY2x7imw/vLKscjef7
Fv00x2GKXYCXRcrqG78+mloVDUdpcoUW+DSxsU//hU6bPi1FgW2AKSva1Ychin9MVlDXofY1
qYH0S+C8IJ7VlklaJgpMzidNhW1DMeZ5oywFKE0wj7ajhAkyBfpUkVQ3/aqWgTvstWSTAEuJ
YAuMpdUK20QhKetUOPwY+p/zvujyJbSCMsmTy4tlYfFVIganO2tvJrDxQZwkd3Yyc87ypA+1
/aQXbdc7ukZy4t0UAmB4a4sIjpIEtjNf3tBW/g4J9fisCVi9UwqH9+WSfJAE3JmjViTur3N7
iSzDK5bEumrz71SUfGJ1fUShZS2Kvq5udKtkPA9K2zciFL2RQzhl8BhYOlrUVCmOQaMHpuj3
twi2B11B+v0FFQpVI2UQDNswS8MFO1sQZbGaeuodke0GNkVQWAOcO6ximXwkaohcSY897te3
wro3tBBLQMxJTHZrv+VZiP1thL6MwK2lafa0fP1ijhtHjcmFmzIrczfm4QjF5+KLCAoqnEDZ
7GCZWGudNU2ZgHQitiC11TWznrA2TPr62jEmFAgNAXvHBxjhqT1ahaxfJkxHUWxtWxfDtG4k
gqVp3bf92QK2uDVyMk12kjFpfbrhOhLbaDiAX2LYs4gU0qwzNbpWkdc2V81Kxzgef5NMznQl
c10khhlsy1y4TCi77VvmFI5RS0HvoqThvBJOyhv4sbID+pYildEH4Oix3+sxqkZmj1eDQWnK
zBtfnJEKA3c4L4IDCjA1V3F18oq1MGDCzkQx0HXaDXKVdc3G81eWz7spr0q7MTCV3kGFb+8R
05py+ZGtyTlsUfKw+a8V99sTHNznaiNvSejzy8Pj218qAPb3w+uX0PJDCiVXMseBd1YjGK0f
aQ1XWUX3IBNnIFVkw6vkeZTiuhO8/bAYZl+Lp0EJA0V6UzBYYL53gAPufSczELKXJQrXvK6B
jrJVUB/CfyANLUsdsEUPbnTAhvvCh2+H394evmsx71WS3iv4izW8o+21Ut3yDu9s0QObshmp
oaX9jtXFh9nxfGGbjNQC9KsGYw7ltG1NzVmqVM6GOmQ2gOaYiqiA1Wq/jqpRAAlZ2hPloslZ
a/NFHyOb15dFduOXIW1CtMEvr/uk6uwR/eUxk4Mm7zYf7s1yTg+ffnz5gmYL4vH17eUHps+y
w2Qw1MhAbq8tYdkCDiYTahI+HP8zo6hUpGK6BB3FuEFbqCLhqIu4nbfd5pg8Q2CsrtapwwXx
N6UvDlxm2TDtby9u5e3BWKrE2YUpYtB/KNdJhVyWXZE2XhnS1zAsSHK+HM4YcnlJLVESkmrQ
L82XO2LK2N5fRLpttmnNUJjFrZBjgO6HOZDdjOuqFMTLo49yx8Bvy13h6cJSRS5FUxYxvXAs
GgMVRBlKXaasZb0rLiuUcutuImBCynbxK3W7QeJkcpomHAmDR/O1iV4ZMgw6uvHuvCOksMdh
i0+EYHHJNf8z3H3mbBa9IuAwzoB9hL0wmIlmKRurDs8S6hwFlptqGl6kQxARfwOqsrZ5X61b
ySqCpmwp7kp8FilZ1G3HMqJYhZjoIAwBxpBAUzCKv4/DKHuJYQ5WWbkLGD2NtFgWU2yGRuAz
vitSJvJmUGODq3kFlpXClPvGauPODmZz44XjV3YDSH9UPj2/vj/CXLQ/ntUZsrl7/GLLMgxj
+qPDrROdwwFjkJ/OemhA+7augtpbWK22MtKUqzZEjiatZdmCYMdym1DWRExSnFg359geB6ys
32CwzpY19NLfXcNxDIdyWtIsS3JtVQ/JtqcHVBkLw1n9+Qce0AQfVtsqcMCRYCJEhrE0JIp0
VylysyvOdYoZdU+G1jzjufI/r88Pj2jhAy3//uPt8M8B/nF4u//999//18rjhCFaZJFrKUYP
vluDeAtbgYrIohA126kiChhHQd6TSzR21d9oqBl2Ld/zgN030C3XnVRvcJp8t1OYvoEdi8bG
QU27xvHWU1DZMG+vKu/hKuQ+GhHlbErFgxZwXlEV4eDKN1h9gjVunRhHvEUnsUGHMet36Bt5
t2Y0nf/H1JtqW+l8B0xklbG1bdKNrEgiR5iUaGGo+q5AYwRY0eriiziH1Gk2waU1BUgIcF4R
4R7VjvtLiUmf797ujlA+uscLY4uD6ZEVoSxQaaDPL6m1qVDKRF4JB4YP4blc9FJOAcUJ0+QJ
15p4spl+5UkNg1a0wkuQqkwWko4U4NT+Sjpi04EIEgl8E1tG+Alm7AmuvxwK++s4Ue3FKHKw
/JqMvGIyPzl99UcJeLXSkGqpG02sIRVZCsRbfHCim4oXrEVy05ZkbFSZhxD6UXvn+KorlDI3
jV2DSrGhaYzSvfK2kCpAbbpcioTSjtvOTiBJMJgL7jRJCeJ20fp6U6I/VKWMSFV24vnhI+MZ
QoIYTXuLjihI7zx8wJ8Wx1Tlhgq6V4FwncM+AF2PbFxQngZQDsGr+CpqGCZDIWO1jJKiihes
XWyldZS6xXn6+/DyfO/sp3HzoOevNpfe8bomvTyQSCHtjkNHtWgMZwCcL2cLm57nHa62VLkD
2+OJwUFQ+vBuqDT+I7rWZmzJs37Fmdx5Uup2459EiCacmGFw+5XYg+Q0+SCTN6JXd3BTd5rY
QZxylMcwCOiVf8u0z139cq/ukeOhDRQBTEQDp/Iyo59V7VJAYexzOpSpklxcRXWZCr2EI93h
rM5u/G54iH6x+MfhvB4anThK0lWeKAiDh6Ns8uH4H8xhfDw/Pv4Z9UasN/IWZpxVJjK8ZM9p
xogFVa0fJmq8rgt2hn0Z2h5e31BwQMk2efrP4eXuy8HeOlcdrVOZk7OXOwY0r4/qLswZuZwm
o695V5K5xQunXRJ5q8Ld/uSDYSRlWDKrsfYQy+sLTyyUiJxdcePq56Fkgtucl53L5BC1Qunt
542wL8ncAvI8MbX+QjGj9Ib2CK3Nvwf2eeW6Dyn1FLRQAOtDxLW+Rnr6wIfzB1+qWyX8S0tJ
mtXwPCq7Ti7BwDlL2wuM8jFKpjLsIjr8lEmH93POtvw/qVH3nbFdAgA=

--ZGiS0Q5IWpPtfppv--
