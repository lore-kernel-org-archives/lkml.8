Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C37FC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:22:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17ABB2071A
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgHVEW3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 00:22:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:42258 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbgHVEW2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:22:28 -0400
IronPort-SDR: tlyY1Ail0m5u5YzJv+2cLsI+YH0ga8i87swKTFq+bdQ8iF02Gmj4S+F6AgQBtWWiK/vpm2yM7/
 J4Pz1yOL/qmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="143456992"
X-IronPort-AV: E=Sophos;i="5.76,339,1592895600"; 
   d="gz'50?scan'50,208,50";a="143456992"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 21:20:09 -0700
IronPort-SDR: ZOeckuTjYwi2iuzc/dX/01gYiZACa+1ZKXXdRJqEuN0xKQdcHwOqVH0p3Kpswi5Cdi35o++RyU
 0GUMyb0Hr32w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,339,1592895600"; 
   d="gz'50?scan'50,208,50";a="330231768"
Received: from lkp-server01.sh.intel.com (HELO 91ed66e1ca04) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Aug 2020 21:20:07 -0700
Received: from kbuild by 91ed66e1ca04 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k9L0g-0001UT-NJ; Sat, 22 Aug 2020 04:20:06 +0000
Date:   Sat, 22 Aug 2020 12:19:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/can/cc770/cc770_isa.c:276:25: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202008221223.YksvlZAe%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f873db9acd3c92d4741bc3676c9eb511b2f9a6f6
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   9 weeks ago
config: openrisc-randconfig-s031-20200822 (attached as .config)
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

>> drivers/net/can/cc770/cc770_isa.c:276:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *[assigned] base @@
   drivers/net/can/cc770/cc770_isa.c:276:25: sparse:     expected void *addr
>> drivers/net/can/cc770/cc770_isa.c:276:25: sparse:     got void [noderef] __iomem *[assigned] base
>> drivers/net/can/cc770/cc770_isa.c:295:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *reg_base @@
   drivers/net/can/cc770/cc770_isa.c:295:29: sparse:     expected void *addr
>> drivers/net/can/cc770/cc770_isa.c:295:29: sparse:     got void [noderef] __iomem *reg_base
--
>> drivers/net/can/cc770/cc770_platform.c:226:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *[assigned] base @@
   drivers/net/can/cc770/cc770_platform.c:226:17: sparse:     expected void *addr
>> drivers/net/can/cc770/cc770_platform.c:226:17: sparse:     got void [noderef] __iomem *[assigned] base
>> drivers/net/can/cc770/cc770_platform.c:240:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *addr @@     got void [noderef] __iomem *reg_base @@
   drivers/net/can/cc770/cc770_platform.c:240:21: sparse:     expected void *addr
>> drivers/net/can/cc770/cc770_platform.c:240:21: sparse:     got void [noderef] __iomem *reg_base

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=670d0a4b10704667765f7d18f7592993d02783aa
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 670d0a4b10704667765f7d18f7592993d02783aa
vim +276 drivers/net/can/cc770/cc770_isa.c

edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  160  
3c8ac0f2ad53a96 Bill Pemberton      2012-12-03  161  static int cc770_isa_probe(struct platform_device *pdev)
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  162  {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  163  	struct net_device *dev;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  164  	struct cc770_priv *priv;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  165  	void __iomem *base = NULL;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  166  	int iosize = CC770_IOSIZE;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  167  	int idx = pdev->id;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  168  	int err;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  169  	u32 clktmp;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  170  
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  171  	dev_dbg(&pdev->dev, "probing idx=%d: port=%#lx, mem=%#lx, irq=%d\n",
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  172  		idx, port[idx], mem[idx], irq[idx]);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  173  	if (mem[idx]) {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  174  		if (!request_mem_region(mem[idx], iosize, KBUILD_MODNAME)) {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  175  			err = -EBUSY;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  176  			goto exit;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  177  		}
4bdc0d676a64314 Christoph Hellwig   2020-01-06  178  		base = ioremap(mem[idx], iosize);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  179  		if (!base) {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  180  			err = -ENOMEM;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  181  			goto exit_release;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  182  		}
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  183  	} else {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  184  		if (indirect[idx] > 0 ||
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  185  		    (indirect[idx] == -1 && indirect[0] > 0))
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  186  			iosize = CC770_IOSIZE_INDIRECT;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  187  		if (!request_region(port[idx], iosize, KBUILD_MODNAME)) {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  188  			err = -EBUSY;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  189  			goto exit;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  190  		}
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  191  	}
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  192  
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  193  	dev = alloc_cc770dev(0);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  194  	if (!dev) {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  195  		err = -ENOMEM;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  196  		goto exit_unmap;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  197  	}
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  198  	priv = netdev_priv(dev);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  199  
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  200  	dev->irq = irq[idx];
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  201  	priv->irq_flags = IRQF_SHARED;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  202  	if (mem[idx]) {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  203  		priv->reg_base = base;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  204  		dev->base_addr = mem[idx];
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  205  		priv->read_reg = cc770_isa_mem_read_reg;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  206  		priv->write_reg = cc770_isa_mem_write_reg;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  207  	} else {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  208  		priv->reg_base = (void __iomem *)port[idx];
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  209  		dev->base_addr = port[idx];
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  210  
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  211  		if (iosize == CC770_IOSIZE_INDIRECT) {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  212  			priv->read_reg = cc770_isa_port_read_reg_indirect;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  213  			priv->write_reg = cc770_isa_port_write_reg_indirect;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  214  		} else {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  215  			priv->read_reg = cc770_isa_port_read_reg;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  216  			priv->write_reg = cc770_isa_port_write_reg;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  217  		}
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  218  	}
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  219  
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  220  	if (clk[idx])
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  221  		clktmp = clk[idx];
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  222  	else if (clk[0])
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  223  		clktmp = clk[0];
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  224  	else
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  225  		clktmp = CLK_DEFAULT;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  226  	priv->can.clock.freq = clktmp;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  227  
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  228  	if (cir[idx] != 0xff) {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  229  		priv->cpu_interface = cir[idx];
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  230  	} else if (cir[0] != 0xff) {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  231  		priv->cpu_interface = cir[0];
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  232  	} else {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  233  		/* The system clock may not exceed 10 MHz */
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  234  		if (clktmp > 10000000) {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  235  			priv->cpu_interface |= CPUIF_DSC;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  236  			clktmp /= 2;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  237  		}
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  238  		/* The memory clock may not exceed 8 MHz */
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  239  		if (clktmp > 8000000)
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  240  			priv->cpu_interface |= CPUIF_DMC;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  241  	}
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  242  
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  243  	if (priv->cpu_interface & CPUIF_DSC)
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  244  		priv->can.clock.freq /= 2;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  245  
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  246  	if (bcr[idx] != 0xff)
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  247  		priv->bus_config = bcr[idx];
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  248  	else if (bcr[0] != 0xff)
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  249  		priv->bus_config = bcr[0];
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  250  	else
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  251  		priv->bus_config = BCR_DEFAULT;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  252  
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  253  	if (cor[idx] != 0xff)
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  254  		priv->clkout = cor[idx];
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  255  	else if (cor[0] != 0xff)
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  256  		priv->clkout = cor[0];
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  257  	else
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  258  		priv->clkout = COR_DEFAULT;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  259  
00e4bbc8cd7efac Jingoo Han          2013-05-23  260  	platform_set_drvdata(pdev, dev);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  261  	SET_NETDEV_DEV(dev, &pdev->dev);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  262  
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  263  	err = register_cc770dev(dev);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  264  	if (err) {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  265  		dev_err(&pdev->dev,
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  266  			"couldn't register device (err=%d)\n", err);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  267  		goto exit_unmap;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  268  	}
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  269  
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  270  	dev_info(&pdev->dev, "device registered (reg_base=0x%p, irq=%d)\n",
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  271  		 priv->reg_base, dev->irq);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  272  	return 0;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  273  
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  274   exit_unmap:
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  275  	if (mem[idx])
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30 @276  		iounmap(base);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  277   exit_release:
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  278  	if (mem[idx])
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  279  		release_mem_region(mem[idx], iosize);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  280  	else
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  281  		release_region(port[idx], iosize);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  282   exit:
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  283  	return err;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  284  }
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  285  
3c8ac0f2ad53a96 Bill Pemberton      2012-12-03  286  static int cc770_isa_remove(struct platform_device *pdev)
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  287  {
00e4bbc8cd7efac Jingoo Han          2013-05-23  288  	struct net_device *dev = platform_get_drvdata(pdev);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  289  	struct cc770_priv *priv = netdev_priv(dev);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  290  	int idx = pdev->id;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  291  
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  292  	unregister_cc770dev(dev);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  293  
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  294  	if (mem[idx]) {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30 @295  		iounmap(priv->reg_base);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  296  		release_mem_region(mem[idx], CC770_IOSIZE);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  297  	} else {
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  298  		if (priv->read_reg == cc770_isa_port_read_reg_indirect)
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  299  			release_region(port[idx], CC770_IOSIZE_INDIRECT);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  300  		else
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  301  			release_region(port[idx], CC770_IOSIZE);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  302  	}
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  303  	free_cc770dev(dev);
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  304  
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  305  	return 0;
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  306  }
edd2c26ffb7742b Wolfgang Grandegger 2011-11-30  307  

:::::: The code at line 276 was first introduced by commit
:::::: edd2c26ffb7742bf0d3bd324694d220281844a01 can: cc770: add legacy ISA bus driver for the CC770 and AN82527

:::::: TO: Wolfgang Grandegger <wg@grandegger.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--/04w6evG8XlLl3ft
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--/04w6evG8XlLl3ft--
