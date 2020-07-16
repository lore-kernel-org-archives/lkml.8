Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AA3C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D975206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 06:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgGPG4x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 02:56:53 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:42107 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbgGPG4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 02:56:53 -0400
X-IronPort-AV: E=Sophos;i="5.75,358,1589234400"; 
   d="gz'50?scan'50,208,50";a="459950725"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 08:56:40 +0200
Date:   Thu, 16 Jul 2020 08:56:40 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     YueHaibing <yuehaibing@huawei.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-kernel@vger.kernel.org, kbuild-all@lists.01.org
Subject: drivers/pci/controller/pci-v3-semi.c:808:2-9: line 808 is redundant
 because platform_get_irq() already prints an error (fwd)
Message-ID: <alpine.DEB.2.22.394.2007160855390.2384@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=BOKacYhQ+x31HxR3
Content-ID: <alpine.DEB.2.22.394.2007160855391.2384@hadrien>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=US-ASCII
Content-ID: <alpine.DEB.2.22.394.2007160855392.2384@hadrien>
Content-Disposition: inline

Unneeded warning message on failure of platform_get_irq.

julia

---------- Forwarded message ----------
Date: Thu, 16 Jul 2020 08:05:55 +0800
From: kernel test robot <lkp@intel.com>
To: kbuild@lists.01.org
Cc: lkp@intel.com, Julia Lawall <julia.lawall@lip6.fr>
Subject: drivers/pci/controller/pci-v3-semi.c:808:2-9: line 808 is redundant
    because platform_get_irq() already prints an error

CC: kbuild-all@lists.01.org
CC: linux-kernel@vger.kernel.org
TO: YueHaibing <yuehaibing@huawei.com>
CC: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: Stephen Boyd <swboyd@chromium.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e9919e11e219eaa5e8041b7b1a196839143e9125
commit: ca7ce5a2710ad2a57bf7d0c4c712590bb69a5e1c coccinelle: platform_get_irq: Fix parse error
date:   10 months ago
:::::: branch date: 2 days ago
:::::: commit date: 10 months ago
config: arm-randconfig-c021-20200715 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@lip6.fr>


coccinelle warnings: (new ones prefixed by >>)

>> drivers/pci/controller/pci-v3-semi.c:808:2-9: line 808 is redundant because platform_get_irq() already prints an error

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ca7ce5a2710ad2a57bf7d0c4c712590bb69a5e1c
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git remote update linus
git checkout ca7ce5a2710ad2a57bf7d0c4c712590bb69a5e1c
vim +808 drivers/pci/controller/pci-v3-semi.c

68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  730
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  731  static int v3_pci_probe(struct platform_device *pdev)
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  732  {
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  733  	struct device *dev = &pdev->dev;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  734  	struct device_node *np = dev->of_node;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  735  	resource_size_t io_base;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  736  	struct resource *regs;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  737  	struct resource_entry *win;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  738  	struct v3_pci *v3;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  739  	struct pci_host_bridge *host;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  740  	struct clk *clk;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  741  	u16 val;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  742  	int irq;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  743  	int ret;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  744  	LIST_HEAD(res);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  745
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  746  	host = pci_alloc_host_bridge(sizeof(*v3));
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  747  	if (!host)
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  748  		return -ENOMEM;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  749
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  750  	host->dev.parent = dev;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  751  	host->ops = &v3_pci_ops;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  752  	host->busnr = 0;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  753  	host->msi = NULL;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  754  	host->map_irq = of_irq_parse_and_map_pci;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  755  	host->swizzle_irq = pci_common_swizzle;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  756  	v3 = pci_host_bridge_priv(host);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  757  	host->sysdata = v3;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  758  	v3->dev = dev;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  759
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  760  	/* Get and enable host clock */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  761  	clk = devm_clk_get(dev, NULL);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  762  	if (IS_ERR(clk)) {
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  763  		dev_err(dev, "clock not found\n");
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  764  		return PTR_ERR(clk);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  765  	}
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  766  	ret = clk_prepare_enable(clk);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  767  	if (ret) {
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  768  		dev_err(dev, "unable to enable clock\n");
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  769  		return ret;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  770  	}
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  771
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  772  	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  773  	v3->base = devm_ioremap_resource(dev, regs);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  774  	if (IS_ERR(v3->base))
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  775  		return PTR_ERR(v3->base);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  776  	/*
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  777  	 * The hardware has a register with the physical base address
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  778  	 * of the V3 controller itself, verify that this is the same
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  779  	 * as the physical memory we've remapped it from.
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  780  	 */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  781  	if (readl(v3->base + V3_LB_IO_BASE) != (regs->start >> 16))
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  782  		dev_err(dev, "V3_LB_IO_BASE = %08x but device is @%pR\n",
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  783  			readl(v3->base + V3_LB_IO_BASE), regs);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  784
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  785  	/* Configuration space is 16MB directly mapped */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  786  	regs = platform_get_resource(pdev, IORESOURCE_MEM, 1);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  787  	if (resource_size(regs) != SZ_16M) {
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  788  		dev_err(dev, "config mem is not 16MB!\n");
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  789  		return -EINVAL;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  790  	}
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  791  	v3->config_mem = regs->start;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  792  	v3->config_base = devm_ioremap_resource(dev, regs);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  793  	if (IS_ERR(v3->config_base))
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  794  		return PTR_ERR(v3->config_base);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  795
5bd51b35c7cbbc9 drivers/pci/host/pci-v3-semi.c Jan Kiszka    2018-05-15  796  	ret = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, &res,
055f87a2a336409 drivers/pci/host/pci-v3-semi.c Jan Kiszka    2018-05-15  797  						    &io_base);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  798  	if (ret)
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  799  		return ret;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  800
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  801  	ret = devm_request_pci_bus_resources(dev, &res);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  802  	if (ret)
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  803  		return ret;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  804
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  805  	/* Get and request error IRQ resource */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  806  	irq = platform_get_irq(pdev, 0);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  807  	if (irq <= 0) {
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26 @808  		dev_err(dev, "unable to obtain PCIv3 error IRQ\n");
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  809  		return -ENODEV;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  810  	}
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  811  	ret = devm_request_irq(dev, irq, v3_irq, 0,
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  812  			"PCIv3 error", v3);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  813  	if (ret < 0) {
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  814  		dev_err(dev,
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  815  			"unable to request PCIv3 error IRQ %d (%d)\n",
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  816  			irq, ret);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  817  		return ret;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  818  	}
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  819
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  820  	/*
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  821  	 * Unlock V3 registers, but only if they were previously locked.
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  822  	 */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  823  	if (readw(v3->base + V3_SYSTEM) & V3_SYSTEM_M_LOCK)
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  824  		writew(V3_SYSTEM_UNLOCK, v3->base + V3_SYSTEM);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  825
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  826  	/* Disable all slave access while we set up the windows */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  827  	val = readw(v3->base + V3_PCI_CMD);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  828  	val &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  829  	writew(val, v3->base + V3_PCI_CMD);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  830
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  831  	/* Put the PCI bus into reset */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  832  	val = readw(v3->base + V3_SYSTEM);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  833  	val &= ~V3_SYSTEM_M_RST_OUT;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  834  	writew(val, v3->base + V3_SYSTEM);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  835
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  836  	/* Retry until we're ready */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  837  	val = readw(v3->base + V3_PCI_CFG);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  838  	val |= V3_PCI_CFG_M_RETRY_EN;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  839  	writew(val, v3->base + V3_PCI_CFG);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  840
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  841  	/* Set up the local bus protocol */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  842  	val = readw(v3->base + V3_LB_CFG);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  843  	val |= V3_LB_CFG_LB_BE_IMODE; /* Byte enable input */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  844  	val |= V3_LB_CFG_LB_BE_OMODE; /* Byte enable output */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  845  	val &= ~V3_LB_CFG_LB_ENDIAN; /* Little endian */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  846  	val &= ~V3_LB_CFG_LB_PPC_RDY; /* TODO: when using on PPC403Gx, set to 1 */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  847  	writew(val, v3->base + V3_LB_CFG);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  848
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  849  	/* Enable the PCI bus master */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  850  	val = readw(v3->base + V3_PCI_CMD);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  851  	val |= PCI_COMMAND_MASTER;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  852  	writew(val, v3->base + V3_PCI_CMD);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  853
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  854  	/* Get the I/O and memory ranges from DT */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  855  	resource_list_for_each_entry(win, &res) {
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  856  		ret = v3_pci_setup_resource(v3, io_base, host, win);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  857  		if (ret) {
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  858  			dev_err(dev, "error setting up resources\n");
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  859  			return ret;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  860  		}
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  861  	}
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  862  	ret = v3_pci_parse_map_dma_ranges(v3, np);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  863  	if (ret)
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  864  		return ret;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  865
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  866  	/*
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  867  	 * Disable PCI to host IO cycles, enable I/O buffers @3.3V,
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  868  	 * set AD_LOW0 to 1 if one of the LB_MAP registers choose
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  869  	 * to use this (should be unused).
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  870  	 */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  871  	writel(0x00000000, v3->base + V3_PCI_IO_BASE);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  872  	val = V3_PCI_CFG_M_IO_REG_DIS | V3_PCI_CFG_M_IO_DIS |
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  873  		V3_PCI_CFG_M_EN3V | V3_PCI_CFG_M_AD_LOW0;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  874  	/*
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  875  	 * DMA read and write from PCI bus commands types
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  876  	 */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  877  	val |=  V3_PCI_CFG_TYPE_DEFAULT << V3_PCI_CFG_M_RTYPE_SHIFT;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  878  	val |=  V3_PCI_CFG_TYPE_DEFAULT << V3_PCI_CFG_M_WTYPE_SHIFT;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  879  	writew(val, v3->base + V3_PCI_CFG);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  880
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  881  	/*
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  882  	 * Set the V3 FIFO such that writes have higher priority than
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  883  	 * reads, and local bus write causes local bus read fifo flush
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  884  	 * on aperture 1. Same for PCI.
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  885  	 */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  886  	writew(V3_FIFO_PRIO_LB_RD1_FLUSH_AP1 |
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  887  	       V3_FIFO_PRIO_LB_RD0_FLUSH_AP1 |
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  888  	       V3_FIFO_PRIO_PCI_RD1_FLUSH_AP1 |
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  889  	       V3_FIFO_PRIO_PCI_RD0_FLUSH_AP1,
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  890  	       v3->base + V3_FIFO_PRIORITY);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  891
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  892
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  893  	/*
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  894  	 * Clear any error interrupts, and enable parity and write error
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  895  	 * interrupts
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  896  	 */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  897  	writeb(0, v3->base + V3_LB_ISTAT);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  898  	val = readw(v3->base + V3_LB_CFG);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  899  	val |= V3_LB_CFG_LB_LB_INT;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  900  	writew(val, v3->base + V3_LB_CFG);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  901  	writeb(V3_LB_ISTAT_PCI_WR | V3_LB_ISTAT_PCI_PERR,
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  902  	       v3->base + V3_LB_IMASK);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  903
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  904  	/* Special Integrator initialization */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  905  	if (of_device_is_compatible(np, "arm,integrator-ap-pci")) {
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  906  		ret = v3_integrator_init(v3);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  907  		if (ret)
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  908  			return ret;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  909  	}
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  910
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  911  	/* Post-init: enable PCI memory and invalidate (master already on) */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  912  	val = readw(v3->base + V3_PCI_CMD);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  913  	val |= PCI_COMMAND_MEMORY | PCI_COMMAND_INVALIDATE;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  914  	writew(val, v3->base + V3_PCI_CMD);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  915
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  916  	/* Clear pending interrupts */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  917  	writeb(0, v3->base + V3_LB_ISTAT);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  918  	/* Read or write errors and parity errors cause interrupts */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  919  	writeb(V3_LB_ISTAT_PCI_RD | V3_LB_ISTAT_PCI_WR | V3_LB_ISTAT_PCI_PERR,
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  920  	       v3->base + V3_LB_IMASK);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  921
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  922  	/* Take the PCI bus out of reset so devices can initialize */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  923  	val = readw(v3->base + V3_SYSTEM);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  924  	val |= V3_SYSTEM_M_RST_OUT;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  925  	writew(val, v3->base + V3_SYSTEM);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  926
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  927  	/*
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  928  	 * Re-lock the system register.
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  929  	 */
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  930  	val = readw(v3->base + V3_SYSTEM);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  931  	val |= V3_SYSTEM_M_LOCK;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  932  	writew(val, v3->base + V3_SYSTEM);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  933
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  934  	list_splice_init(&res, &host->windows);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  935  	ret = pci_scan_root_bus_bridge(host);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  936  	if (ret) {
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  937  		dev_err(dev, "failed to register host: %d\n", ret);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  938  		return ret;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  939  	}
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  940  	v3->bus = host->bus;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  941
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  942  	pci_bus_assign_resources(v3->bus);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  943  	pci_bus_add_devices(v3->bus);
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  944
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  945  	return 0;
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  946  }
68a15eb7bd0cf18 drivers/pci/host/pci-v3-semi.c Linus Walleij 2017-09-26  947

:::::: The code at line 808 was first introduced by commit
:::::: 68a15eb7bd0cf180eb214c79aa4e1662c5eeb97c PCI: v3-semi: Add V3 Semiconductor PCI host driver

:::::: TO: Linus Walleij <linus.walleij@linaro.org>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
--BOKacYhQ+x31HxR3
Content-Type: application/gzip; CHARSET=US-ASCII
Content-Transfer-Encoding: BASE64
Content-ID: <alpine.DEB.2.22.394.2007160855393.2384@hadrien>
Content-Description: 
Content-Disposition: attachment; filename=.config.gz

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
10SLOwnF9RXs/v8BXpZVHtDbAQA=

--BOKacYhQ+x31HxR3--
