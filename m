Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04C50C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B205620748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XE8sjrpl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgGJMOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgGJMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:14:37 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EC5C08C5CE;
        Fri, 10 Jul 2020 05:14:36 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g10so8343928wmc.1;
        Fri, 10 Jul 2020 05:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yHdcEkVL7TN/EmNUDvqH7kpR0EGF5YyOiCHWG+Ja1vk=;
        b=XE8sjrpljsfwMPki/OKgpmaVG5H7BI7hAE/N0aeDHWmay/bz89R0oqA7wwJaowdjDs
         vI5k2lx3MNscikGSOoX88yyLZSfte8qNgFwwQtpBmoQ5O9GsyLE6iDKmkLo66Ht1F/6B
         HwsmekvtEJdxR+KqohW+jcmxnObrx2nhFNFkQzrSnfAktjyqw1+mV9oL1ShIKThIQn9A
         dJTxSBuJm7BbEJn55/lb0sIVQo7ZLvuqcXxJihehHxF01zBIxkToCiY0gJFVMhkABqVf
         fHbyJOF3XQlGNrJA3NvJGpSdyNe1SLpobAG3Fv12JzeXv1SkXmmCXocZ61W6oaby+3i0
         2TNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yHdcEkVL7TN/EmNUDvqH7kpR0EGF5YyOiCHWG+Ja1vk=;
        b=qhWBZWFhOTIvAV9I9/dJUF3YaPVs7PTk7QOQMRwwValbLB7yKJuJT81c8RoOxHO/B+
         qm1T4FVGGBfdGbYkO2EMZl+PpzdKSVxWSTN2Qh82m6s6b2PWP4em/kKFSbsM611c7bxN
         qSYzZgHDhH38Fw6wtAAjxv7/1w5BabtINY9wGQnWORQPxTU2tPg6JMNA3c78OyNOSIqq
         +tOT93/shx/MBcJ/DY1T+q5k3mQAMFFAe1kdKYaPCjQhb53GGD214iQTFuIybyFe3hE9
         y1iSE1lzjP3Kw/jVfkWXTO9AMnQOqeeLR7NRI5+QmnxyfotMLNvzo5a6AkA7jnj68OG3
         yDug==
X-Gm-Message-State: AOAM530i9PJQh42BeptY49Z1IECWNv+Tlcu0f3ukKhFWQM+2iAqZGmuy
        5XdASMBXrPiC9jZQVyLj9F8=
X-Google-Smtp-Source: ABdhPJxb96P5PGRzPp0E3mEuSMOcueclVsoHlW0tBbk+jbE0SbdEa08aHasswuR/h1pq7DWP8WPIvA==
X-Received: by 2002:a1c:668b:: with SMTP id a133mr4874179wmc.10.1594383275071;
        Fri, 10 Jul 2020 05:14:35 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
        by smtp.gmail.com with ESMTPSA id 26sm8785428wmj.25.2020.07.10.05.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 05:14:34 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] soc: mediatek: add mtk-devapc driver
To:     Neal Liu <neal.liu@mediatek.com>, Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>, wsd_upstream@mediatek.com
References: <1594285927-1840-1-git-send-email-neal.liu@mediatek.com>
 <1594285927-1840-3-git-send-email-neal.liu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <f93663d4-86f1-971f-ed2c-67cd65d5049d@gmail.com>
Date:   Fri, 10 Jul 2020 14:14:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594285927-1840-3-git-send-email-neal.liu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/07/2020 11:12, Neal Liu wrote:
> MediaTek bus fabric provides TrustZone security support and data
> protection to prevent slaves from being accessed by unexpected
> masters.
> The security violation is logged and sent to the processor for
> further analysis or countermeasures.
> 
> Any occurrence of security violation would raise an interrupt, and
> it will be handled by mtk-devapc driver. The violation
> information is printed in order to find the murderer.
> 
> Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> ---
>   drivers/soc/mediatek/Kconfig      |    9 +
>   drivers/soc/mediatek/Makefile     |    1 +
>   drivers/soc/mediatek/mtk-devapc.c |  466 ++++++++++++++++++++++++++
>   drivers/soc/mediatek/mtk-devapc.h |  670 +++++++++++++++++++++++++++++++++++++
>   4 files changed, 1146 insertions(+)
>   create mode 100644 drivers/soc/mediatek/mtk-devapc.c
>   create mode 100644 drivers/soc/mediatek/mtk-devapc.h
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 59a56cd..1177c98 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -17,6 +17,15 @@ config MTK_CMDQ
>   	  time limitation, such as updating display configuration during the
>   	  vblank.
>   
> +config MTK_DEVAPC
> +	tristate "Mediatek Device APC Support"
> +	help
> +	  Say yes here to enable support for Mediatek Device APC driver.
> +	  This driver is mainly used to handle the violation which catches
> +	  unexpected transaction.
> +	  The violation information is logged for further analysis or
> +	  countermeasures.
> +
>   config MTK_INFRACFG
>   	bool "MediaTek INFRACFG Support"
>   	select REGMAP
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 01f9f87..abfd4ba 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,5 +1,6 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
> +obj-$(CONFIG_MTK_DEVAPC) += mtk-devapc.o
>   obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
>   obj-$(CONFIG_MTK_PMIC_WRAP) += mtk-pmic-wrap.o
>   obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
> diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
> new file mode 100644
> index 0000000..11fa366
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-devapc.c
> @@ -0,0 +1,466 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 MediaTek Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_irq.h>
> +#include <linux/of_address.h>
> +#include "mtk-devapc.h"
> +
> +/*
> + * mtk_devapc_pd_get - get devapc pd_types of register address.
> + *
> + * Returns the value of reg addr
> + */
> +static void __iomem *mtk_devapc_pd_get(struct mtk_devapc_context *devapc_ctx,
> +				       int slave_type,
> +				       enum DEVAPC_PD_REG_TYPE pd_reg_type,
> +				       u32 reg_idx)
> +{
> +	void __iomem *reg;
> +
> +	reg = devapc_ctx->devapc_pd_base[slave_type] +
> +		devapc_ctx->pds_offset[pd_reg_type];
> +
> +	if (pd_reg_type == VIO_MASK || pd_reg_type == VIO_STA)
> +		reg += 0x4 * reg_idx;
> +
> +	return reg;
> +}
> +
> +static int get_vio_slave_num(int slave_type)

I have a hard time to understand the usefullness of this, can you please explain.

> +{
> +	if (slave_type == 0)
> +		return ARRAY_SIZE(mtk_devices_infra);
> +
> +	return 0;
> +}
> +
> +static u32 get_shift_group(struct mtk_devapc_context *devapc_ctx,
> +			   int slave_type, int vio_idx)
> +{
> +	u32 vio_shift_sta;
> +	void __iomem *reg;
> +	int bit;
> +
> +	reg = mtk_devapc_pd_get(devapc_ctx, slave_type, VIO_SHIFT_STA, 0);
> +	vio_shift_sta = readl(reg);
> +
> +	for (bit = 0; bit < 32; bit++) {
> +		if ((vio_shift_sta >> bit) & 0x1) > +			break;
> +	}
> +
> +	return bit;

We return the first position (from the right) of the rigster with the bit set to 
one. Correct?
Can't we use __ffs() for this?

> +}
> +
> +static int check_vio_mask_sta(struct mtk_devapc_context *devapc_ctx,
> +			      int slave_type, u32 module, int pd_reg_type)
> +{
> +	u32 reg_index, reg_offset;
> +	void __iomem *reg;
> +	u32 value;
> +
> +	VIO_MASK_STA_REG_GET(module);
> +
> +	reg = mtk_devapc_pd_get(devapc_ctx, slave_type, pd_reg_type, reg_index);

reg = mtk_devapc_pd_get(devapc_ctx, slave_type, pd_reg_type, 
VIO_MOD_TO_REG_IND(module));

> +	value = readl(reg);
> +
> +	return ((value >> reg_offset) & 0x1);

return ((value >> VIO_MOD_TO_REG_OFF(module)) & 0x1);

> +}
> +
> +static int check_vio_mask(struct mtk_devapc_context *devapc_ctx, int slave_type,
> +			  u32 module)
> +{
> +	return check_vio_mask_sta(devapc_ctx, slave_type, module, VIO_MASK);
> +}
> +
> +static int check_vio_status(struct mtk_devapc_context *devapc_ctx,
> +			    int slave_type, u32 module)
> +{
> +	return check_vio_mask_sta(devapc_ctx, slave_type, module, VIO_STA);
> +}
> +
> +static void clear_vio_status(struct mtk_devapc_context *devapc_ctx,
> +			     int slave_type, u32 module)
> +{
> +	u32 reg_index, reg_offset;
> +	void __iomem *reg;
> +
> +	VIO_MASK_STA_REG_GET(module);
> +
> +	reg = mtk_devapc_pd_get(devapc_ctx, slave_type, VIO_STA, reg_index);
> +	writel(0x1 << reg_offset, reg);
> +
> +	if (check_vio_status(devapc_ctx, slave_type, module))
> +		pr_err(PFX "%s: Clear failed, slave_type:0x%x, module_index:0x%x\n",
> +		       __func__, slave_type, module);
> +}
> +
> +static void mask_module_irq(struct mtk_devapc_context *devapc_ctx,
> +			    int slave_type, u32 module, bool mask)
> +{
> +	u32 reg_index, reg_offset;
> +	void __iomem *reg;
> +	u32 value;
> +
> +	VIO_MASK_STA_REG_GET(module);
> +
> +	reg = mtk_devapc_pd_get(devapc_ctx, slave_type, VIO_MASK, reg_index);
> +
> +	value = readl(reg);
> +	if (mask)
> +		value |= (0x1 << reg_offset);
> +	else
> +		value &= ~(0x1 << reg_offset);
> +
> +	writel(value, reg);
> +}
> +
> +#define TIMEOUT_MS		10000
> +
> +static int read_poll_timeout(void __iomem *addr, u32 mask)

That function is defined in include/linux/iopoll.h

> +{
> +	unsigned long timeout = jiffies + msecs_to_jiffies(TIMEOUT_MS);
> +
> +	do {
> +		if (readl_relaxed(addr) & mask)

Please use a variable where you write your value to and then check for the mask. 
That maks the code easier to read and I think is part of the coding style.

> +			return 0;
> +
> +	} while (!time_after(jiffies, timeout));
> +
> +	return (readl_relaxed(addr) & mask) ? 0 : -ETIMEDOUT;
> +}
> +
> +/*
> + * sync_vio_dbg - start to get violation information by selecting violation
> + *		  group and enable violation shift.
> + *
> + * Returns sync done or not
> + */
> +static u32 sync_vio_dbg(struct mtk_devapc_context *devapc_ctx, int slave_type,
> +			u32 shift_bit)
> +{
> +	void __iomem *pd_vio_shift_sta_reg;
> +	void __iomem *pd_vio_shift_sel_reg;
> +	void __iomem *pd_vio_shift_con_reg;
> +	u32 sync_done = 0;
> +
> +	pd_vio_shift_sta_reg = mtk_devapc_pd_get(devapc_ctx, slave_type,
> +						 VIO_SHIFT_STA, 0);
> +	pd_vio_shift_sel_reg = mtk_devapc_pd_get(devapc_ctx, slave_type,
> +						 VIO_SHIFT_SEL, 0);
> +	pd_vio_shift_con_reg = mtk_devapc_pd_get(devapc_ctx, slave_type,
> +						 VIO_SHIFT_CON, 0);
> +
> +	writel(0x1 << shift_bit, pd_vio_shift_sel_reg);
> +	writel(0x1, pd_vio_shift_con_reg);
> +
> +	if (!read_poll_timeout(pd_vio_shift_con_reg, 0x2))
> +		sync_done = 1;
> +	else
> +		pr_err(PFX "%s: Shift violation info failed\n", __func__);
> +
> +	/* Disable shift mechanism */

Please add a comment explaining what the shift mechanism is about.

> +	writel(0x0, pd_vio_shift_con_reg);
> +	writel(0x0, pd_vio_shift_sel_reg);
> +	writel(0x1 << shift_bit, pd_vio_shift_sta_reg);
> +
> +	return sync_done;
> +}
> +
> +static void devapc_vio_info_print(struct mtk_devapc_context *devapc_ctx)
> +{
> +	struct mtk_devapc_vio_info *vio_info = devapc_ctx->vio_info;
> +
> +	/* Print violation information */
> +	if (vio_info->write)
> +		pr_info(PFX "Write Violation\n");
> +	else if (vio_info->read)
> +		pr_info(PFX "Read Violation\n");
> +
> +	pr_info(PFX "%s%x, %s%x, %s%x, %s%x\n",
> +		"Vio Addr:0x", vio_info->vio_addr,
> +		"High:0x", vio_info->vio_addr_high,
> +		"Bus ID:0x", vio_info->master_id,
> +		"Dom ID:0x", vio_info->domain_id);
> +}
> +
> +static void devapc_extract_vio_dbg(struct mtk_devapc_context *devapc_ctx,
> +				   int slave_type)
> +{
> +	void __iomem *vio_dbg0_reg, *vio_dbg1_reg;
> +	struct mtk_devapc_vio_dbgs_desc *vio_dbgs;
> +	struct mtk_devapc_vio_info *vio_info;
> +	u32 dbg0;
> +
> +	vio_dbg0_reg = mtk_devapc_pd_get(devapc_ctx, slave_type, VIO_DBG0, 0);
> +	vio_dbg1_reg = mtk_devapc_pd_get(devapc_ctx, slave_type, VIO_DBG1, 0);
> +
> +	vio_dbgs = devapc_ctx->vio_dbgs_desc;
> +	vio_info = devapc_ctx->vio_info;
> +
> +	/* Extract violation information */
> +	dbg0 = readl(vio_dbg0_reg);
> +	vio_info->vio_addr = readl(vio_dbg1_reg);
> +
> +	vio_info->master_id = (dbg0 & vio_dbgs[MSTID].mask) >>
> +			      vio_dbgs[MSTID].start_bit;
> +	vio_info->domain_id = (dbg0 & vio_dbgs[DMNID].mask) >>
> +			      vio_dbgs[DMNID].start_bit;
> +	vio_info->write = ((dbg0 & vio_dbgs[VIO_W].mask) >>
> +			   vio_dbgs[VIO_W].start_bit) == 1;
> +	vio_info->read = ((dbg0 & vio_dbgs[VIO_R].mask) >>
> +			  vio_dbgs[VIO_R].start_bit) == 1;
> +	vio_info->vio_addr_high = (dbg0 & vio_dbgs[ADDR_H].mask) >>
> +				  vio_dbgs[ADDR_H].start_bit;
> +
> +	devapc_vio_info_print(devapc_ctx);
> +}
> +
> +/*
> + * mtk_devapc_dump_vio_dbg - shift & dump the violation debug information.
> + */
> +static bool mtk_devapc_dump_vio_dbg(struct mtk_devapc_context *devapc_ctx,
> +				    int slave_type, int *vio_idx)
> +{
> +	const struct mtk_device_info **device_info;
> +	u32 shift_bit;
> +	int i;
> +
> +	device_info = devapc_ctx->device_info;
> +
> +	for (i = 0; i < get_vio_slave_num(slave_type); i++) {
> +		*vio_idx = device_info[slave_type][i].vio_index;
> +
> +		if (check_vio_mask(devapc_ctx, slave_type, *vio_idx))
> +			continue;
> +
> +		if (!check_vio_status(devapc_ctx, slave_type, *vio_idx))
> +			continue;
> +
> +		shift_bit = get_shift_group(devapc_ctx, slave_type, *vio_idx);
> +
> +		if (!sync_vio_dbg(devapc_ctx, slave_type, shift_bit))
> +			continue;
> +
> +		devapc_extract_vio_dbg(devapc_ctx, slave_type);
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +/*
> + * devapc_violation_irq - the devapc Interrupt Service Routine (ISR) will dump
> + *			  violation information including which master violates
> + *			  access slave.
> + */
> +static irqreturn_t devapc_violation_irq(int irq_number,
> +					struct mtk_devapc_context *devapc_ctx)
> +{
> +	const struct mtk_device_info **device_info;
> +	int slave_type_num;
> +	int vio_idx = -1;
> +	int slave_type;
> +
> +	slave_type_num = devapc_ctx->slave_type_num;
> +	device_info = devapc_ctx->device_info;
> +
> +	for (slave_type = 0; slave_type < slave_type_num; slave_type++) {
> +		if (!mtk_devapc_dump_vio_dbg(devapc_ctx, slave_type, &vio_idx))
> +			continue;
> +
> +		/* Ensure that violation info are written before
> +		 * further operations
> +		 */
> +		smp_mb();
> +
> +		mask_module_irq(devapc_ctx, slave_type, vio_idx, true);
> +
> +		clear_vio_status(devapc_ctx, slave_type, vio_idx);
> +
> +		mask_module_irq(devapc_ctx, slave_type, vio_idx, false);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +/*
> + * start_devapc - initialize devapc status and start receiving interrupt
> + *		  while devapc violation is triggered.
> + */
> +static void start_devapc(struct mtk_devapc_context *devapc_ctx)
> +{
> +	const struct mtk_device_info **device_info;
> +	void __iomem *pd_vio_shift_sta_reg;
> +	void __iomem *pd_apc_con_reg;
> +	u32 vio_shift_sta;
> +	int slave_type, slave_type_num;
> +	int i, vio_idx;
> +
> +	device_info = devapc_ctx->device_info;
> +	slave_type_num = devapc_ctx->slave_type_num;
> +
> +	for (slave_type = 0; slave_type < slave_type_num; slave_type++) {
> +		pd_apc_con_reg = mtk_devapc_pd_get(devapc_ctx, slave_type,
> +						   APC_CON, 0);
> +		pd_vio_shift_sta_reg = mtk_devapc_pd_get(devapc_ctx, slave_type,
> +							 VIO_SHIFT_STA, 0);
> +		if (!pd_apc_con_reg || !pd_vio_shift_sta_reg)
> +			return;
> +
> +		/* Clear devapc violation status */
> +		writel(BIT(31), pd_apc_con_reg);
> +
> +		/* Clear violation shift status */
> +		vio_shift_sta = readl(pd_vio_shift_sta_reg);
> +		if (vio_shift_sta)
> +			writel(vio_shift_sta, pd_vio_shift_sta_reg);
> +
> +		/* Clear slave violation status */
> +		for (i = 0; i < get_vio_slave_num(slave_type); i++) {
> +			vio_idx = device_info[slave_type][i].vio_index;
> +
> +			clear_vio_status(devapc_ctx, slave_type, vio_idx);
> +
> +			mask_module_irq(devapc_ctx, slave_type, vio_idx, false);
> +		}
> +	}
> +}
> +
> +static int mtk_devapc_probe(struct platform_device *pdev)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct mtk_devapc_context *devapc_ctx;
> +	struct clk *devapc_infra_clk;
> +	u32 vio_dbgs_num, pds_num;
> +	u8 slave_type_num;
> +	u32 devapc_irq;
> +	size_t size;
> +	int i, ret;
> +
> +	if (IS_ERR(node))
> +		return -ENODEV;
> +
> +	devapc_ctx = devm_kzalloc(&pdev->dev, sizeof(struct mtk_devapc_context),
> +				  GFP_KERNEL);
> +	if (!devapc_ctx)
> +		return -ENOMEM;
> +
> +	if (of_property_read_u8(node, "mediatek-slv_type_num", &slave_type_num))
> +		return -ENXIO;
> +
> +	devapc_ctx->slave_type_num = slave_type_num;
> +
> +	size = slave_type_num * sizeof(void *);
> +	devapc_ctx->devapc_pd_base = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> +	if (!devapc_ctx->devapc_pd_base)
> +		return -ENOMEM;
> +
> +	size = slave_type_num * sizeof(struct mtk_device_info *);
> +	devapc_ctx->device_info = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> +	if (!devapc_ctx->device_info)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < slave_type_num; i++) {
> +		devapc_ctx->devapc_pd_base[i] = of_iomap(node, i);
> +		if (!devapc_ctx->devapc_pd_base[i])
> +			return -EINVAL;
> +
> +		if (i == 0)
> +			devapc_ctx->device_info[i] = mtk_devices_infra;
> +	}
> +
> +	size = sizeof(struct mtk_devapc_vio_info);
> +	devapc_ctx->vio_info = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> +	if (!devapc_ctx->vio_info)
> +		return -ENOMEM;
> +
> +	vio_dbgs_num = of_property_count_u32_elems(node, "mediatek-vio_dbgs");
> +	if (vio_dbgs_num <= 0)
> +		return -ENXIO;
> +
> +	size = (vio_dbgs_num / 2) * sizeof(struct mtk_devapc_vio_dbgs_desc);
> +	devapc_ctx->vio_dbgs_desc = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> +	if (!devapc_ctx->vio_dbgs_desc)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < vio_dbgs_num / 2; i++) {
> +		if (of_property_read_u32_index(node, "mediatek-vio_dbgs",
> +					       i * 2,
> +					       &devapc_ctx->vio_dbgs_desc[i].mask))
> +			return -ENXIO;
> +
> +		if (of_property_read_u32_index(node, "mediatek-vio_dbgs",
> +					       (i * 2) + 1,
> +					       &devapc_ctx->vio_dbgs_desc[i].start_bit))
> +			return -ENXIO;
> +	}
> +
> +	pds_num = of_property_count_u32_elems(node, "mediatek-pds_offset");
> +	if (pds_num <= 0)
> +		return -ENXIO;
> +
> +	size = pds_num * sizeof(u32);
> +	devapc_ctx->pds_offset = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
> +	if (!devapc_ctx->pds_offset)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < pds_num; i++) {
> +		if (of_property_read_u32_index(node, "mediatek-pds_offset", i,
> +					       &devapc_ctx->pds_offset[i]))
> +			return -ENXIO;
> +	}
> +
> +	devapc_irq = irq_of_parse_and_map(node, 0);
> +	if (!devapc_irq)
> +		return -EINVAL;
> +
> +	devapc_infra_clk = devm_clk_get(&pdev->dev, "devapc-infra-clock");
> +	if (IS_ERR(devapc_infra_clk))
> +		return -EINVAL;
> +
> +	if (clk_prepare_enable(devapc_infra_clk))
> +		return -EINVAL;
> +
> +	start_devapc(devapc_ctx);
> +
> +	ret = devm_request_irq(&pdev->dev, devapc_irq,
> +			       (irq_handler_t)devapc_violation_irq,
> +			       IRQF_TRIGGER_NONE, "devapc", devapc_ctx);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static int mtk_devapc_remove(struct platform_device *dev)
> +{
> +	return 0;
> +}
> +
> +static const struct of_device_id mtk_devapc_dt_match[] = {
> +	{ .compatible = "mediatek,mt6779-devapc" },
> +	{},
> +};
> +
> +static struct platform_driver mtk_devapc_driver = {
> +	.probe = mtk_devapc_probe,
> +	.remove = mtk_devapc_remove,
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +		.of_match_table = mtk_devapc_dt_match,
> +	},
> +};
> +
> +module_platform_driver(mtk_devapc_driver);
> +
> +MODULE_DESCRIPTION("Mediatek Device APC Driver");
> +MODULE_AUTHOR("Neal Liu <neal.liu@mediatek.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/soc/mediatek/mtk-devapc.h b/drivers/soc/mediatek/mtk-devapc.h
> new file mode 100644
> index 0000000..ab2cb14
> --- /dev/null
> +++ b/drivers/soc/mediatek/mtk-devapc.h
> @@ -0,0 +1,670 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020 MediaTek Inc.
> + */
> +
> +#ifndef __MTK_DEVAPC_H__
> +#define __MTK_DEVAPC_H__
> +
> +#define PFX			"[DEVAPC]: "

use dev_err() and friends instead.

> +
> +#define VIO_MASK_STA_REG_GET(m) \
> +({ \
> +	typeof(m) (_m) = (m); \
> +	reg_index = _m / 32; \
> +	reg_offset = _m % 32; \
> +})

don't do that. no explicit variable assingment in a macro, the macro should 
return the value.

> +
> +enum DEVAPC_PD_REG_TYPE {
> +	VIO_MASK = 0,
> +	VIO_STA,
> +	VIO_DBG0,
> +	VIO_DBG1,
> +	APC_CON,
> +	VIO_SHIFT_STA,
> +	VIO_SHIFT_SEL,
> +	VIO_SHIFT_CON,
> +	PD_REG_TYPE_NUM,
> +};
> +
> +enum DEVAPC_VIO_DBGS_TYPE {
> +	MSTID = 0,
> +	DMNID,
> +	VIO_W,
> +	VIO_R,
> +	ADDR_H,
> +};
> +
> +struct mtk_device_info {
> +	int sys_index;
> +	int ctrl_index;
> +	int vio_index;
> +};
> +
> +static struct mtk_device_info mtk_devices_infra[] = {

That's for mt6779, correct? Should be stated in the name.

> +	/* sys_idx, ctrl_idx, vio_idx */
> +	/* 0 */
> +	{0, 0, 0},
> +	{0, 1, 1},
> +	{0, 2, 2},
> +	{0, 3, 3},
> +	{0, 4, 4},
> +	{0, 5, 5},
> +	{0, 6, 6},
> +	{0, 7, 7},
> +	{0, 8, 8},
> +	{0, 9, 9},
> +
> +	/* 10 */
> +	{0, 10, 10},
> +	{0, 11, 11},
> +	{0, 12, 12},
> +	{0, 13, 13},
> +	{0, 14, 14},
> +	{0, 15, 15},
> +	{0, 16, 16},
> +	{0, 17, 17},
> +	{0, 18, 18},
> +	{0, 19, 19},
> +
> +	/* 20 */
> +	{0, 20, 20},
> +	{0, 21, 21},
> +	{0, 22, 22},
> +	{0, 23, 23},
> +	{0, 24, 24},
> +	{0, 25, 25},
> +	{0, 26, 26},
> +	{0, 27, 27},
> +	{0, 28, 28},
> +	{0, 29, 29},
> +
> +	/* 30 */
> +	{0, 30, 30},
> +	{0, 31, 31},
> +	{0, 32, 32},
> +	{0, 33, 77},
> +	{0, 34, 78},
> +	{0, 35, 79},
> +	{0, 35, 80},
> +	{0, 37, 37},
> +	{0, 38, 38},
> +	{0, 39, 39},
> +
> +	/* 40 */
> +	{0, 40, 40},
> +	{0, 41, 41},
> +	{0, 42, 42},
> +	{0, 43, 43},
> +	{0, 44, 44},
> +	{0, 45, 45},
> +	{0, 46, 46},
> +	{0, 47, 47},
> +	{0, 48, 48},
> +	{0, 49, 49},
> +
> +	/* 50 */
> +	{0, 50, 50},
> +	{0, 51, 51},
> +	{0, 52, 52},
> +	{0, 53, 53},
> +	{0, 54, 54},
> +	{0, 55, 55},
> +	{0, 56, 56},
> +	{0, 57, 57},
> +	{0, 58, 58},
> +	{0, 59, 59},
> +
> +	/* 60 */
> +	{0, 60, 60},
> +	{0, 61, 61},
> +	{0, 62, 62},
> +	{0, 63, 63},
> +	{0, 64, 64},
> +	{0, 65, 70},
> +	{0, 66, 71},
> +	{0, 67, 72},
> +	{0, 68, 73},
> +	{0, 70, 81},
> +
> +	/* 70 */
> +	{0, 71, 82},
> +	{0, 72, 83},
> +	{0, 73, 84},
> +	{0, 74, 85},
> +	{0, 75, 86},
> +	{0, 76, 87},
> +	{0, 77, 88},
> +	{0, 78, 89},
> +	{0, 79, 90},
> +	{0, 80, 91},
> +
> +	/* 80 */
> +	{0, 81, 92},
> +	{0, 82, 93},
> +	{0, 83, 94},
> +	{0, 84, 95},
> +	{0, 85, 96},
> +	{0, 86, 97},
> +	{0, 87, 98},
> +	{0, 88, 99},
> +	{0, 89, 100},
> +	{0, 90, 101},
> +
> +	/* 90 */
> +	{0, 91, 102},
> +	{0, 92, 103},
> +	{0, 93, 104},
> +	{0, 94, 105},
> +	{0, 95, 106},
> +	{0, 96, 107},
> +	{0, 97, 108},
> +	{0, 98, 109},
> +	{0, 110, 110},
> +	{0, 111, 111},
> +
> +	/* 100 */
> +	{0, 112, 112},
> +	{0, 113, 113},
> +	{0, 114, 114},
> +	{0, 115, 115},
> +	{0, 116, 116},
> +	{0, 117, 117},
> +	{0, 118, 118},
> +	{0, 119, 119},
> +	{0, 120, 120},
> +	{0, 121, 121},
> +
> +	/* 110 */
> +	{0, 122, 122},
> +	{0, 123, 123},
> +	{0, 124, 124},
> +	{0, 125, 125},
> +	{0, 126, 126},
> +	{0, 127, 127},
> +	{0, 128, 128},
> +	{0, 129, 129},
> +	{0, 130, 130},
> +	{0, 131, 131},
> +
> +	/* 120 */
> +	{0, 132, 132},
> +	{0, 133, 133},
> +	{0, 134, 134},
> +	{0, 135, 135},
> +	{0, 136, 136},
> +	{0, 137, 137},
> +	{0, 138, 138},
> +	{0, 139, 139},
> +	{0, 140, 140},
> +	{0, 141, 141},
> +
> +	/* 130 */
> +	{0, 142, 142},
> +	{0, 143, 143},
> +	{0, 144, 144},
> +	{0, 145, 145},
> +	{0, 146, 146},
> +	{0, 147, 147},
> +	{0, 148, 148},
> +	{0, 149, 149},
> +	{0, 150, 150},
> +	{0, 151, 151},
> +
> +	/* 140 */
> +	{0, 152, 152},
> +	{0, 153, 153},
> +	{0, 154, 154},
> +	{0, 155, 155},
> +	{0, 156, 156},
> +	{0, 157, 157},
> +	{0, 158, 158},
> +	{0, 159, 159},
> +	{0, 160, 160},
> +	{0, 161, 161},
> +
> +	/* 150 */
> +	{0, 162, 162},
> +	{0, 163, 163},
> +	{0, 164, 164},
> +	{0, 165, 165},
> +	{0, 166, 166},
> +	{0, 167, 167},
> +	{0, 168, 168},
> +	{0, 169, 169},
> +	{0, 170, 170},
> +	{0, 171, 171},
> +
> +	/* 160 */
> +	{0, 172, 172},
> +	{0, 173, 173},
> +	{0, 174, 174},
> +	{0, 175, 175},
> +	{0, 176, 176},
> +	{0, 177, 177},
> +	{0, 178, 178},
> +	{0, 179, 179},
> +	{0, 180, 180},
> +	{0, 181, 181},
> +
> +	/* 170 */
> +	{0, 182, 182},
> +	{0, 183, 183},
> +	{0, 184, 184},
> +	{0, 185, 185},
> +	{0, 186, 186},
> +	{0, 187, 187},
> +	{0, 188, 188},
> +	{0, 189, 189},
> +	{0, 190, 190},
> +	{0, 191, 191},
> +
> +	/* 180 */
> +	{0, 192, 192},
> +	{0, 193, 193},
> +	{0, 194, 194},
> +	{0, 195, 195},
> +	{0, 196, 196},
> +	{0, 197, 197},
> +	{0, 198, 198},
> +	{0, 199, 199},
> +	{0, 200, 200},
> +	{0, 201, 201},
> +
> +	/* 190 */
> +	{0, 202, 202},
> +	{0, 203, 203},
> +	{0, 204, 204},
> +	{0, 205, 205},
> +	{0, 206, 206},
> +	{0, 207, 207},
> +	{0, 208, 208},
> +	{0, 209, 209},
> +	{0, 210, 210},
> +	{0, 211, 211},
> +
> +	/* 200 */
> +	{0, 212, 212},
> +	{0, 213, 213},
> +	{0, 214, 214},
> +	{0, 215, 215},
> +	{0, 216, 216},
> +	{0, 217, 217},
> +	{0, 218, 218},
> +	{0, 219, 219},
> +	{0, 220, 220},
> +	{0, 221, 221},
> +
> +	/* 210 */
> +	{0, 222, 222},
> +	{0, 223, 223},
> +	{0, 224, 224},
> +	{0, 225, 225},
> +	{0, 226, 226},
> +	{0, 227, 227},
> +	{0, 228, 228},
> +	{0, 229, 229},
> +	{0, 230, 230},
> +	{0, 231, 231},
> +
> +	/* 220 */
> +	{1, 0, 232},
> +	{1, 1, 233},
> +	{1, 2, 234},
> +	{1, 3, 235},
> +	{1, 4, 236},
> +	{1, 5, 237},
> +	{1, 6, 238},
> +	{1, 7, 239},
> +	{1, 8, 240},
> +	{1, 9, 241},
> +
> +	/* 230 */
> +	{1, 10, 242},
> +	{1, 11, 243},
> +	{1, 12, 244},
> +	{1, 13, 245},
> +	{1, 14, 246},
> +	{1, 15, 247},
> +	{1, 16, 248},
> +	{1, 17, 249},
> +	{1, 18, 250},
> +	{1, 19, 251},
> +
> +	/* 240 */
> +	{1, 20, 252},
> +	{1, 21, 253},
> +	{1, 22, 254},
> +	{1, 23, 255},
> +	{1, 24, 256},
> +	{1, 25, 257},
> +	{1, 26, 258},
> +	{1, 27, 259},
> +	{1, 28, 260},
> +	{1, 29, 261},
> +
> +	/* 250 */
> +	{1, 30, 262},
> +	{1, 31, 263},
> +	{1, 32, 264},
> +	{1, 33, 265},
> +	{1, 34, 266},
> +	{1, 35, 267},
> +	{1, 36, 268},
> +	{1, 37, 269},
> +	{1, 38, 270},
> +	{1, 39, 271},
> +
> +	/* 260 */
> +	{1, 40, 272},
> +	{1, 41, 273},
> +	{1, 42, 274},
> +	{1, 43, 275},
> +	{1, 44, 276},
> +	{1, 45, 277},
> +	{1, 46, 278},
> +	{1, 47, 279},
> +	{1, 48, 280},
> +	{1, 49, 281},
> +
> +	/* 270 */
> +	{1, 50, 282},
> +	{1, 51, 283},
> +	{1, 52, 284},
> +	{1, 53, 285},
> +	{1, 54, 286},
> +	{1, 55, 287},
> +	{1, 56, 288},
> +	{1, 57, 289},
> +	{1, 58, 290},
> +	{1, 59, 291},
> +
> +	/* 280 */
> +	{1, 60, 292},
> +	{1, 61, 293},
> +	{1, 62, 294},
> +	{1, 63, 295},
> +	{1, 64, 296},
> +	{1, 65, 297},
> +	{1, 66, 298},
> +	{1, 67, 299},
> +	{1, 68, 300},
> +	{1, 69, 301},
> +
> +	/* 290 */
> +	{1, 70, 302},
> +	{1, 71, 303},
> +	{1, 72, 304},
> +	{1, 73, 305},
> +	{1, 74, 306},
> +	{1, 75, 307},
> +	{1, 76, 308},
> +	{1, 77, 309},
> +	{1, 78, 310},
> +	{1, 79, 311},
> +
> +	/* 300 */
> +	{1, 80, 312},
> +	{1, 81, 313},
> +	{1, 82, 314},
> +	{1, 83, 315},
> +	{1, 84, 316},
> +	{1, 85, 317},
> +	{1, 86, 318},
> +	{1, 87, 319},
> +	{1, 88, 320},
> +	{1, 89, 321},
> +
> +	/* 310 */
> +	{1, 90, 322},
> +	{1, 91, 323},
> +	{1, 92, 324},
> +	{1, 93, 325},
> +	{1, 94, 326},
> +	{1, 95, 327},
> +	{1, 96, 328},
> +	{1, 97, 329},
> +	{1, 98, 330},
> +	{1, 99, 331},
> +
> +	/* 320 */
> +	{1, 100, 332},
> +	{1, 101, 333},
> +	{1, 102, 334},
> +	{1, 103, 335},
> +	{1, 104, 336},
> +	{1, 105, 337},
> +	{1, 106, 338},
> +	{1, 107, 339},
> +	{1, 108, 340},
> +	{1, 109, 341},
> +
> +	/* 330 */
> +	{1, 110, 342},
> +	{1, 111, 343},
> +	{1, 112, 344},
> +	{1, 113, 345},
> +	{1, 114, 346},
> +	{1, 115, 347},
> +	{1, 116, 348},
> +	{1, 117, 349},
> +	{1, 118, 350},
> +	{1, 119, 351},
> +
> +	/* 340 */
> +	{1, 120, 352},
> +	{1, 121, 353},
> +	{1, 122, 354},
> +	{1, 123, 355},
> +	{1, 124, 356},
> +	{1, 125, 357},
> +	{1, 126, 358},
> +	{1, 127, 359},
> +	{1, 128, 360},
> +	{1, 129, 361},
> +
> +	/* 350 */
> +	{1, 130, 362},
> +	{1, 131, 363},
> +	{1, 132, 364},
> +	{1, 133, 365},
> +	{1, 134, 366},
> +	{1, 135, 367},
> +	{1, 136, 368},
> +	{1, 137, 369},
> +	{1, 138, 370},
> +	{1, 139, 371},
> +
> +	/* 360 */
> +	{1, 140, 372},
> +	{1, 141, 373},
> +	{1, 142, 374},
> +	{1, 143, 375},
> +	{1, 144, 376},
> +	{1, 145, 377},
> +	{1, 146, 378},
> +	{1, 147, 379},
> +	{1, 148, 380},
> +	{1, 149, 381},
> +
> +	/* 370 */
> +	{1, 150, 382},
> +	{1, 151, 383},
> +	{1, 152, 384},
> +	{1, 153, 385},
> +	{1, 154, 386},
> +	{1, 155, 387},
> +	{1, 156, 388},
> +	{1, 157, 389},
> +	{1, 158, 390},
> +	{1, 159, 391},
> +
> +	/* 380 */
> +	{1, 160, 392},
> +	{1, 161, 393},
> +	{1, 162, 394},
> +	{1, 163, 395},
> +	{1, 164, 396},
> +	{1, 165, 397},
> +	{1, 166, 398},
> +	{1, 167, 399},
> +	{1, 168, 400},
> +	{1, 169, 401},
> +
> +	/* 390 */
> +	{1, 170, 402},
> +	{1, 171, 403},
> +	{1, 172, 404},
> +	{1, 173, 405},
> +	{1, 174, 406},
> +	{1, 175, 407},
> +	{1, 176, 408},
> +	{1, 177, 409},
> +	{1, 178, 410},
> +	{1, 179, 411},
> +
> +	/* 400 */
> +	{1, 180, 412},
> +	{1, 181, 413},
> +	{1, 182, 414},
> +	{1, 183, 415},
> +	{1, 184, 416},
> +	{1, 185, 417},
> +	{1, 186, 418},
> +	{1, 187, 419},
> +	{1, 188, 420},
> +	{1, 189, 421},
> +
> +	/* 410 */
> +	{1, 190, 422},
> +	{1, 191, 423},
> +	{1, 192, 424},
> +	{1, 193, 425},
> +	{1, 194, 426},
> +	{1, 195, 427},
> +	{1, 196, 428},
> +	{1, 197, 429},
> +	{1, 198, 430},
> +	{1, 199, 431},
> +
> +	/* 420 */
> +	{1, 200, 432},
> +	{1, 201, 433},
> +	{1, 202, 434},
> +	{1, 203, 435},
> +	{1, 204, 436},
> +	{1, 205, 437},
> +	{1, 206, 438},
> +	{1, 207, 439},
> +	{1, 208, 440},
> +	{1, 209, 441},
> +
> +	/* 430 */
> +	{1, 210, 442},
> +	{1, 211, 443},
> +	{1, 212, 444},
> +	{1, 213, 445},
> +	{1, 214, 446},
> +	{1, 215, 447},
> +	{1, 216, 448},
> +	{1, 217, 449},
> +	{1, 218, 450},
> +	{1, 219, 451},
> +
> +	/* 440 */
> +	{1, 220, 452},
> +	{1, 221, 453},
> +	{1, 222, 454},
> +	{1, 223, 455},
> +	{1, 224, 456},
> +	{1, 225, 457},
> +	{1, 226, 458},
> +	{1, 227, 459},
> +	{1, 228, 460},
> +	{1, 229, 461},
> +
> +	/* 450 */
> +	{1, 230, 462},
> +	{1, 231, 463},
> +	{1, 232, 464},
> +	{1, 233, 465},
> +	{1, 234, 466},
> +	{1, 235, 467},
> +	{1, 236, 468},
> +	{1, 237, 469},
> +	{1, 238, 470},
> +	{1, 239, 471},
> +
> +	/* 460 */
> +	{1, 240, 472},
> +	{1, 241, 473},
> +	{1, 242, 474},
> +	{1, 243, 475},
> +	{1, 244, 476},
> +	{1, 245, 477},
> +	{1, 246, 478},
> +	{-1, -1, 479},
> +	{-1, -1, 480},
> +	{-1, -1, 481},
> +
> +	/* 470 */
> +	{-1, -1, 482},
> +	{-1, -1, 483},
> +	{-1, -1, 484},
> +	{-1, -1, 485},
> +	{-1, -1, 486},
> +	{-1, -1, 487},
> +	{-1, -1, 488},
> +	{-1, -1, 489},
> +	{-1, -1, 490},
> +	{-1, -1, 491},
> +
> +	/* 480 */
> +	{-1, -1, 492},
> +	{-1, -1, 493},
> +	{-1, -1, 494},
> +	{-1, -1, 495},
> +	{-1, -1, 496},
> +	{-1, -1, 497},
> +	{-1, -1, 498},
> +	{-1, -1, 499},
> +	{-1, -1, 500},
> +	{-1, -1, 501},
> +
> +	/* 490 */
> +	{-1, -1, 502},
> +	{-1, -1, 503},
> +	{-1, -1, 504},
> +	{-1, -1, 505},
> +	{-1, -1, 506},
> +	{-1, -1, 507},
> +	{-1, -1, 508},
> +	{-1, -1, 509},
> +	{-1, -1, 510},
> +
> +};
> +
> +struct mtk_devapc_vio_info {
> +	bool read;
> +	bool write;
> +	u32 vio_addr;
> +	u32 vio_addr_high;
> +	u32 master_id;
> +	u32 domain_id;
> +};
> +
> +struct mtk_devapc_vio_dbgs_desc {
> +	u32 mask;
> +	u32 start_bit;
> +};
> +
> +struct mtk_devapc_context {
> +	u8 slave_type_num;
> +	void __iomem **devapc_pd_base;
> +	const struct mtk_device_info **device_info;
> +	struct mtk_devapc_vio_info *vio_info;
> +	struct mtk_devapc_vio_dbgs_desc *vio_dbgs_desc;
> +	u32 *pds_offset;
> +};
> +

Not sure if I get this right:

struct mtk_devapc_offset {
	u32 vio_mask;
	u32 vio_sta;
	u32 vio_dbg0;
	u32 vio_dbg1;
	...
}

struct mtk_devapc_context {
	u8 pd_base_num;
	void __iomem **devapc_pd_base;
	struct mtk_devapc_offset *offset;
	const struct mtk_device_info **device_info;
	struct mtk_devapc_vio_info *vio_info;
	struct mtk_devapc_vio_dbgs_desc *vio_dbgs_desc;
};

With this I think we can get rid of mtk_devapc_pd_get().

Sorry I'm not able to review the whole driver right now. Please also have a look 
on my comments from v1.

We will have to go little by little to get this into a good state. In case it 
makes sense to have this in the kernel at all.

Regards,
Matthias
