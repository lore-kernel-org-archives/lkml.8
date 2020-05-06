Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF831C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D702076D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 21:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgEFVAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 17:00:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:58136 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgEFVAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 17:00:49 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 576EC2A22DB
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH v14 04/11] soc: mediatek: Remove infracfg misc driver
 support
To:     Weiyi Lu <weiyi.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Cc:     James Liao <jamesjj.liao@mediatek.com>,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        Fan Chen <fan.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <1588752963-19934-1-git-send-email-weiyi.lu@mediatek.com>
 <1588752963-19934-5-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <321bcdff-06ea-b51d-d287-444bcdb20cba@collabora.com>
Date:   Wed, 6 May 2020 23:00:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588752963-19934-5-git-send-email-weiyi.lu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weiyi,

Thank you for your patch.

On 6/5/20 10:15, Weiyi Lu wrote:
> The functions provided by infracfg misc driver have no other user except
> the scpsys driver so move those into scpsys driver directly.
> And then, remove infracfg misc drvier which is no longer being used.

Typo: s/drvier/driver/

> BTW, in next patch, we're going to extend the bus protection functions
> with more customized arguments.
> 
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
>  drivers/soc/mediatek/Kconfig          | 10 -----
>  drivers/soc/mediatek/Makefile         |  1 -
>  drivers/soc/mediatek/mtk-infracfg.c   | 79 -----------------------------------
>  drivers/soc/mediatek/mtk-scpsys.c     | 66 +++++++++++++++++++++++++----
>  include/linux/soc/mediatek/infracfg.h | 39 -----------------
>  5 files changed, 57 insertions(+), 138 deletions(-)
>  delete mode 100644 drivers/soc/mediatek/mtk-infracfg.c
>  delete mode 100644 include/linux/soc/mediatek/infracfg.h
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 2114b56..f837b3c 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -10,21 +10,12 @@ config MTK_CMDQ
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
>  	select MAILBOX
>  	select MTK_CMDQ_MBOX
> -	select MTK_INFRACFG
>  	help
>  	  Say yes here to add support for the MediaTek Command Queue (CMDQ)
>  	  driver. The CMDQ is used to help read/write registers with critical
>  	  time limitation, such as updating display configuration during the
>  	  vblank.
>  
> -config MTK_INFRACFG
> -	bool "MediaTek INFRACFG Support"
> -	select REGMAP
> -	help
> -	  Say yes here to add support for the MediaTek INFRACFG controller. The
> -	  INFRACFG controller contains various infrastructure registers not
> -	  directly associated to any device.
> -
>  config MTK_PMIC_WRAP
>  	tristate "MediaTek PMIC Wrapper Support"
>  	depends on RESET_CONTROLLER
> @@ -38,7 +29,6 @@ config MTK_SCPSYS
>  	bool "MediaTek SCPSYS Support"
>  	default ARCH_MEDIATEK
>  	select REGMAP
> -	select MTK_INFRACFG
>  	select PM_GENERIC_DOMAINS if PM
>  	help
>  	  Say yes here to add support for the MediaTek SCPSYS power domain
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index b017330..2b2c2537 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
> -obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
>  obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/mtk-infracfg.c
> deleted file mode 100644
> index 341c7ac..0000000
> --- a/drivers/soc/mediatek/mtk-infracfg.c
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (c) 2015 Pengutronix, Sascha Hauer <kernel@pengutronix.de>
> - */
> -
> -#include <linux/export.h>
> -#include <linux/jiffies.h>
> -#include <linux/regmap.h>
> -#include <linux/soc/mediatek/infracfg.h>
> -#include <asm/processor.h>
> -
> -#define MTK_POLL_DELAY_US   10
> -#define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
> -
> -#define INFRA_TOPAXI_PROTECTEN		0x0220
> -#define INFRA_TOPAXI_PROTECTSTA1	0x0228
> -#define INFRA_TOPAXI_PROTECTEN_SET	0x0260
> -#define INFRA_TOPAXI_PROTECTEN_CLR	0x0264
> -
> -/**
> - * mtk_infracfg_set_bus_protection - enable bus protection
> - * @regmap: The infracfg regmap
> - * @mask: The mask containing the protection bits to be enabled.
> - * @reg_update: The boolean flag determines to set the protection bits
> - *              by regmap_update_bits with enable register(PROTECTEN) or
> - *              by regmap_write with set register(PROTECTEN_SET).
> - *
> - * This function enables the bus protection bits for disabled power
> - * domains so that the system does not hang when some unit accesses the
> - * bus while in power down.
> - */
> -int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> -		bool reg_update)
> -{
> -	u32 val;
> -	int ret;
> -
> -	if (reg_update)
> -		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask,
> -				mask);
> -	else
> -		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_SET, mask);
> -
> -	ret = regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTSTA1,
> -				       val, (val & mask) == mask,
> -				       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> -
> -	return ret;
> -}
> -
> -/**
> - * mtk_infracfg_clear_bus_protection - disable bus protection
> - * @regmap: The infracfg regmap
> - * @mask: The mask containing the protection bits to be disabled.
> - * @reg_update: The boolean flag determines to clear the protection bits
> - *              by regmap_update_bits with enable register(PROTECTEN) or
> - *              by regmap_write with clear register(PROTECTEN_CLR).
> - *
> - * This function disables the bus protection bits previously enabled with
> - * mtk_infracfg_set_bus_protection.
> - */
> -
> -int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> -		bool reg_update)
> -{
> -	int ret;
> -	u32 val;
> -
> -	if (reg_update)
> -		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
> -	else
> -		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_CLR, mask);
> -
> -	ret = regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTSTA1,
> -				       val, !(val & mask),
> -				       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> -
> -	return ret;
> -}
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index c9c3cf7..b603af7 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -10,8 +10,8 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> +#include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/soc/mediatek/infracfg.h>
>  
>  #include <dt-bindings/power/mt2701-power.h>
>  #include <dt-bindings/power/mt2712-power.h>
> @@ -78,6 +78,29 @@
>  #define PWR_STATUS_HIF1			BIT(26)	/* MT7622 */
>  #define PWR_STATUS_WB			BIT(27)	/* MT7622 */
>  
> +#define INFRA_TOPAXI_PROTECTEN		0x0220
> +#define INFRA_TOPAXI_PROTECTSTA1	0x0228
> +#define INFRA_TOPAXI_PROTECTEN_SET	0x0260
> +#define INFRA_TOPAXI_PROTECTEN_CLR	0x0264
> +
> +#define MT2701_TOP_AXI_PROT_EN_MM_M0		BIT(1)
> +#define MT2701_TOP_AXI_PROT_EN_CONN_M		BIT(2)
> +#define MT2701_TOP_AXI_PROT_EN_CONN_S		BIT(8)
> +
> +#define MT7622_TOP_AXI_PROT_EN_ETHSYS		(BIT(3) | BIT(17))
> +#define MT7622_TOP_AXI_PROT_EN_HIF0		(BIT(24) | BIT(25))
> +#define MT7622_TOP_AXI_PROT_EN_HIF1		(BIT(26) | BIT(27) | \
> +						 BIT(28))
> +#define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
> +						 BIT(7) | BIT(8))
> +
> +#define MT8173_TOP_AXI_PROT_EN_MM_M0		BIT(1)
> +#define MT8173_TOP_AXI_PROT_EN_MM_M1		BIT(2)
> +#define MT8173_TOP_AXI_PROT_EN_MFG_S		BIT(14)
> +#define MT8173_TOP_AXI_PROT_EN_MFG_M0		BIT(21)
> +#define MT8173_TOP_AXI_PROT_EN_MFG_M1		BIT(22)
> +#define MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT	BIT(23)
> +
>  #define MAX_CLKS	3
>  
>  /**
> @@ -251,25 +274,50 @@ static int scpsys_sram_disable(struct scp_domain *scpd, void __iomem *ctl_addr)
>  static int scpsys_bus_protect_enable(struct scp_domain *scpd)
>  {
>  	struct scp *scp = scpd->scp;
> +	struct regmap *infracfg = scp->infracfg;
> +	u32 mask = scpd->data->bus_prot_mask;
> +	bool reg_update = scp->bus_prot_reg_update;
> +	u32 val;
> +	int ret;
>  
> -	if (!scpd->data->bus_prot_mask)
> +	if (!mask)
>  		return 0;
>  
> -	return mtk_infracfg_set_bus_protection(scp->infracfg,
> -			scpd->data->bus_prot_mask,
> -			scp->bus_prot_reg_update);
> +	if (reg_update)
> +		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask,
> +				mask);
> +	else
> +		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_SET, mask);
> +
> +	ret = regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTSTA1,
> +				       val, (val & mask) == mask,
> +				       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +
> +	return ret;
>  }
>  
>  static int scpsys_bus_protect_disable(struct scp_domain *scpd)
>  {
>  	struct scp *scp = scpd->scp;
> +	struct regmap *infracfg = scp->infracfg;
> +	u32 mask = scpd->data->bus_prot_mask;
> +	bool reg_update = scp->bus_prot_reg_update;
> +	u32 val;
> +	int ret;
>  
> -	if (!scpd->data->bus_prot_mask)
> +	if (!mask)
>  		return 0;
>  
> -	return mtk_infracfg_clear_bus_protection(scp->infracfg,
> -			scpd->data->bus_prot_mask,
> -			scp->bus_prot_reg_update);
> +	if (reg_update)
> +		regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask, 0);
> +	else
> +		regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_CLR, mask);
> +
> +	ret = regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTSTA1,
> +				       val, !(val & mask),
> +				       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +
> +	return ret;
>  }
>  
>  static int scpsys_power_on(struct generic_pm_domain *genpd)
> diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> deleted file mode 100644
> index fd25f01..0000000
> --- a/include/linux/soc/mediatek/infracfg.h
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __SOC_MEDIATEK_INFRACFG_H
> -#define __SOC_MEDIATEK_INFRACFG_H
> -
> -#define MT8173_TOP_AXI_PROT_EN_MCI_M2		BIT(0)
> -#define MT8173_TOP_AXI_PROT_EN_MM_M0		BIT(1)
> -#define MT8173_TOP_AXI_PROT_EN_MM_M1		BIT(2)
> -#define MT8173_TOP_AXI_PROT_EN_MMAPB_S		BIT(6)
> -#define MT8173_TOP_AXI_PROT_EN_L2C_M2		BIT(9)
> -#define MT8173_TOP_AXI_PROT_EN_L2SS_SMI		BIT(11)
> -#define MT8173_TOP_AXI_PROT_EN_L2SS_ADD		BIT(12)
> -#define MT8173_TOP_AXI_PROT_EN_CCI_M2		BIT(13)
> -#define MT8173_TOP_AXI_PROT_EN_MFG_S		BIT(14)
> -#define MT8173_TOP_AXI_PROT_EN_PERI_M0		BIT(15)
> -#define MT8173_TOP_AXI_PROT_EN_PERI_M1		BIT(16)
> -#define MT8173_TOP_AXI_PROT_EN_DEBUGSYS		BIT(17)
> -#define MT8173_TOP_AXI_PROT_EN_CQ_DMA		BIT(18)
> -#define MT8173_TOP_AXI_PROT_EN_GCPU		BIT(19)
> -#define MT8173_TOP_AXI_PROT_EN_IOMMU		BIT(20)
> -#define MT8173_TOP_AXI_PROT_EN_MFG_M0		BIT(21)
> -#define MT8173_TOP_AXI_PROT_EN_MFG_M1		BIT(22)
> -#define MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT	BIT(23)
> -
> -#define MT2701_TOP_AXI_PROT_EN_MM_M0		BIT(1)
> -#define MT2701_TOP_AXI_PROT_EN_CONN_M		BIT(2)
> -#define MT2701_TOP_AXI_PROT_EN_CONN_S		BIT(8)
> -
> -#define MT7622_TOP_AXI_PROT_EN_ETHSYS		(BIT(3) | BIT(17))
> -#define MT7622_TOP_AXI_PROT_EN_HIF0		(BIT(24) | BIT(25))
> -#define MT7622_TOP_AXI_PROT_EN_HIF1		(BIT(26) | BIT(27) | \
> -						 BIT(28))
> -#define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
> -						 BIT(7) | BIT(8))
> -
> -int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> -		bool reg_update);
> -int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> -		bool reg_update);
> -#endif /* __SOC_MEDIATEK_INFRACFG_H */
> 
