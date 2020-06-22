Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130A8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5735206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 12:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592828369;
	bh=k3rXEplySMMeVAnP4t/Y1+QV1CCc3J629pWXJH8mggo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ii81/9CtpnUM0PQk58I7OKV4VAoYmtkaa8Cuc1ka3r7LPq7KFKGpUpGxgr7quyuZ0
	 5N85MfexyUk+8RXXa1BLSWqTobYubYc2KekoT6sDpQ1WLZbheXoUpYFAOjdJkf7302
	 DXYhsSOzyHZ5LVqLxZfilU8PSBzVdl4S9NSmqGKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgFVMT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 08:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:35518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbgFVMT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 08:19:27 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE86E206FA;
        Mon, 22 Jun 2020 12:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592828366;
        bh=k3rXEplySMMeVAnP4t/Y1+QV1CCc3J629pWXJH8mggo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xSJtdwv9eAvTUT95oJigMtBjsFtfi2waSbGaDwIVd8LdfXBzDB2glSzPYAbxYDNuE
         B2EcDDe2jlQI/JF0wreZdZaU9MabBD6PtUJ0naEts9Tfx2fFivyv/ink0WOmPyq8OF
         LQisnrxMXf7OEQ/SpNMYfeBHbSFSM7vTz3Vmlnhc=
Received: by pali.im (Postfix)
        id 6B1A27CD; Mon, 22 Jun 2020 14:19:24 +0200 (CEST)
Date:   Mon, 22 Jun 2020 14:19:24 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: drivers/pci/controller/pci-aardvark.c:350:2: error: implicit
 declaration of function 'gpiod_set_value_cansleep'
Message-ID: <20200622121924.7u3t6b5ffzlryqhm@pali>
References: <202006211118.LxtENQfl%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006211118.LxtENQfl%lkp@intel.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 June 2020 11:05:22 kernel test robot wrote:
> >> drivers/pci/controller/pci-aardvark.c:350:2: error: implicit declaration of function 'gpiod_set_value_cansleep' [-Werror,-Wimplicit-function-declaration]
>            gpiod_set_value_cansleep(pcie->reset_gpio, 1);
>            ^
>    drivers/pci/controller/pci-aardvark.c:350:2: note: did you mean 'gpio_set_value_cansleep'?
>    include/linux/gpio.h:188:20: note: 'gpio_set_value_cansleep' declared here
>    static inline void gpio_set_value_cansleep(unsigned gpio, int value)
>                       ^
> >> drivers/pci/controller/pci-aardvark.c:1074:21: error: implicit declaration of function 'devm_gpiod_get_from_of_node' [-Werror,-Wimplicit-function-declaration]
>            pcie->reset_gpio = devm_gpiod_get_from_of_node(dev, dev->of_node,
>                               ^
> >> drivers/pci/controller/pci-aardvark.c:1076:14: error: use of undeclared identifier 'GPIOD_OUT_LOW'
>                                                           GPIOD_OUT_LOW,
>                                                           ^
>    20 warnings and 3 errors generated.
> 
> vim +/gpiod_set_value_cansleep +350 drivers/pci/controller/pci-aardvark.c
> 
>    335	
>    336	static void advk_pcie_issue_perst(struct advk_pcie *pcie)
>    337	{
>    338		u32 reg;
>    339	
>    340		if (!pcie->reset_gpio)
>    341			return;
>    342	
>    343		/* PERST does not work for some cards when link training is enabled */
>    344		reg = advk_readl(pcie, PCIE_CORE_CTRL0_REG);
>    345		reg &= ~LINK_TRAINING_EN;
>    346		advk_writel(pcie, reg, PCIE_CORE_CTRL0_REG);
>    347	
>    348		/* 10ms delay is needed for some cards */
>    349		dev_info(&pcie->pdev->dev, "issuing PERST via reset GPIO for 10ms\n");
>  > 350		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
>    351		usleep_range(10000, 11000);
>    352		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
>    353	}
>    354	

Hello!

Could you try to test following patch if it fixes above problems?

diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
index 90ff291c24f0..01f1fcbb8770 100644
--- a/drivers/pci/controller/pci-aardvark.c
+++ b/drivers/pci/controller/pci-aardvark.c
@@ -10,6 +10,7 @@
 
 #include <linux/delay.h>
 #include <linux/gpio.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>

Both GPIOD_OUT_LOW and gpiod_set_value_cansleep() are defined in
linux/gpio/consumer.h header file.

I do not have s390 box nor s390 cross compiler to do verification.
