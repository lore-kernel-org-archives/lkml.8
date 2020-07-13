Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD44C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AB312073A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594618823;
	bh=QE0+tCvXG/DbPag8Yxyltf2+lXMLMFN6PqBZgdkgMnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YwcnvN21YaCRJAZTotrS34zeoCJ6bu5b+t6LMiC4ymIKzITNLSoM1uvICosiarBHS
	 iwwfLA2S/JA/HKpyo0wOn8hED2OSPZiwVqB/IYS5JA6CK4vJyPhv8SXAtQZP4sk5Ze
	 cAXdg4GxXqTCCGciH8Yb8I2wlRfGRUlh+c5/9yaQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbgGMFkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:40:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:32774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbgGMFkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:40:22 -0400
Received: from localhost (unknown [122.182.251.219])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C969B20674;
        Mon, 13 Jul 2020 05:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594618821;
        bh=QE0+tCvXG/DbPag8Yxyltf2+lXMLMFN6PqBZgdkgMnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wGmMP2FixEp04NhpngYlTDdN+v/dyDUf8eNc237u4IuBAkbeIazkCjcCOAtjxGQo5
         HpgZZ/sKy/VvVmj/UgsVe/OugaUGTwXaN6hbgSaaCEdImMicrtTB8AKbBAirEs8jZc
         kPYxg9Jy8mmKtDn1bMu+mAaF8GWwNyX98Tya/ldo=
Date:   Mon, 13 Jul 2020 11:10:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, andriy.shevchenko@intel.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        sureshkumar.mp@intel.com, lakshmi.bai.raja.subramanian@intel.com
Subject: Re: [PATCH v6 2/2] phy: intel: Add Keem Bay eMMC PHY support
Message-ID: <20200713054015.GZ34333@vkoul-mobl>
References: <20200702000934.3258-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200702000934.3258-3-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702000934.3258-3-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02-07-20, 08:09, Wan Ahmad Zainie wrote:
> Add support for eMMC PHY on Intel Keem Bay SoC.
> 
> Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
> ---
>  drivers/phy/intel/Kconfig            |  12 +
>  drivers/phy/intel/Makefile           |   1 +
>  drivers/phy/intel/phy-keembay-emmc.c | 314 +++++++++++++++++++++++++++
>  3 files changed, 327 insertions(+)
>  create mode 100644 drivers/phy/intel/phy-keembay-emmc.c
> 
> diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig
> index 7b47682a4e0e..8ddda4fb95d2 100644
> --- a/drivers/phy/intel/Kconfig
> +++ b/drivers/phy/intel/Kconfig
> @@ -22,3 +22,15 @@ config PHY_INTEL_EMMC
>  	select GENERIC_PHY
>  	help
>  	  Enable this to support the Intel EMMC PHY
> +
> +config PHY_KEEMBAY_EMMC

Pls keep this in alphabetical sort

> +	tristate "Intel Keem Bay EMMC PHY driver"
> +	depends on ARM64 || COMPILE_TEST

Intel and ARM64, aha, fun times!

> +	depends on OF && HAS_IOMEM
> +	select GENERIC_PHY
> +	select REGMAP_MMIO
> +	help
> +	  Choose this option if you have an Intel Keem Bay SoC.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called phy-keembay-emmc.

phy-keembay-emmc.ko ?

> diff --git a/drivers/phy/intel/Makefile b/drivers/phy/intel/Makefile
> index 233d530dadde..6566334e7b77 100644
> --- a/drivers/phy/intel/Makefile
> +++ b/drivers/phy/intel/Makefile
> @@ -1,3 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PHY_INTEL_COMBO)		+= phy-intel-combo.o
>  obj-$(CONFIG_PHY_INTEL_EMMC)            += phy-intel-emmc.o
> +obj-$(CONFIG_PHY_KEEMBAY_EMMC)		+= phy-keembay-emmc.o

here as well

> +/* eMMC/SD/SDIO core/phy configuration registers */
> +#define PHY_CFG_0		0x24
> +#define  SEL_DLY_TXCLK_MASK	BIT(29)
> +#define  SEL_DLY_TXCLK(x)	(((x) << 29) & SEL_DLY_TXCLK_MASK)
> +#define  OTAP_DLY_ENA_MASK	BIT(27)
> +#define  OTAP_DLY_ENA(x)	(((x) << 27) & OTAP_DLY_ENA_MASK)
> +#define  OTAP_DLY_SEL_MASK	GENMASK(26, 23)
> +#define  OTAP_DLY_SEL(x)	(((x) << 23) & OTAP_DLY_SEL_MASK)

why not a generic helper to do (x) << ffs(reg - 1) & reg ?
You can skip defining for each register that way!

-- 
~Vinod
