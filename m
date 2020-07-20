Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6A6C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C21F22BEF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 22:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQYNvdV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgGTWRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 18:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgGTWR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 18:17:29 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D1CC061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 15:17:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id o1so9360853plk.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 15:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S9yHQrc+Grjytl2ICfVV8IIWajh+DoRcGnz0O824df8=;
        b=mQYNvdV6P0yyUaue9TirPG5rWE2zJKJtvx3J6+47w9Xe4UzBCDZc7vHnqwGn87WAwz
         8i8ikl7TVjBzPTz38xI6U6boUgPjLarRjJYb/Vy/+lvagJrffAUQuVJk9d98PXzDWsNG
         UBguiocp4QBKFFH8k88siQQl01wqn/jIMqPr5QLS2l1+MC2FUqC/CUGb4IQJ/YecKamc
         qztJLLQnFK5K1mQejqeEu75TSFmREUB6lMui81b+xuce+KTcqpgVNLymfo1zao2cep2d
         VnVEbU52G7TPSYit4Jr+Do6z+tBV45BX0zJDl2eGnW+9zWIdrOPzyZgdEdOI8BdSsqnm
         6qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S9yHQrc+Grjytl2ICfVV8IIWajh+DoRcGnz0O824df8=;
        b=FKNW1UDBYyZ7Q4BboE/EqGuzyldgwGoKi7z1aelyfGPwt3hFjz0fKtcd1csKPC9z0B
         q8MuTItGNnDFuhVV6v4SHJe2ZzTP404RSu5TbI2Smukhz7D5aGxrv+so6ww8MDnemM2W
         nk55sNg4v3gRr+sjpfTTEVToGnz2wh66GVmlayRaMsFP1v5w7Alyg5Hc8T+Y6RoHz/ML
         G2uMlh/dhplVsObbb9oa+ddhUQjW/XrtdVgpUHz82lfjiugrS08UC8oAWHGYfvAnSuBi
         93RQqUGNmzRNxWOqm5KUmyjduu9fB3gTdj8H5ykWecYhhOiFaAmjQtKP37p/Ln5Fhpkw
         OZwA==
X-Gm-Message-State: AOAM5305BF7IVEo8Le4UU3CDIYfrcFeEEhnRS+wtjPz/GJ9yuwjn6vKx
        PqmAYXzDbM9qVG41B3V0pErfsQ==
X-Google-Smtp-Source: ABdhPJxb1kIflxXR1Ew1LgJ1gLmAb+uzKaI3ucWpHPNcfZI7sMYxwBzIfJRfrevhw7Ig8WSDhh9pAg==
X-Received: by 2002:a17:902:b706:: with SMTP id d6mr19735403pls.244.1595283448766;
        Mon, 20 Jul 2020 15:17:28 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id q14sm15681971pgk.86.2020.07.20.15.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 15:17:28 -0700 (PDT)
Date:   Mon, 20 Jul 2020 16:17:26 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] remoteproc: Add a remoteproc driver for the MT8183's
 APU
Message-ID: <20200720221726.GD1113627@xps15>
References: <20200713132927.24925-1-abailon@baylibre.com>
 <20200713132927.24925-3-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713132927.24925-3-abailon@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 03:29:23PM +0200, Alexandre Bailon wrote:
> This adds a driver to control the APU present in the MT8183.
> This loads the firmware and start the DSP.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
> ---
>  drivers/remoteproc/Kconfig         |  10 +
>  drivers/remoteproc/Makefile        |   1 +
>  drivers/remoteproc/mtk_apu_rproc.c | 308 +++++++++++++++++++++++++++++

I would name the file mtk_apu.c to be consistent with the existing mtk_scp.c

>  3 files changed, 319 insertions(+)
>  create mode 100644 drivers/remoteproc/mtk_apu_rproc.c
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index c4d1731295eb..e116d4a12ac3 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig
> @@ -42,6 +42,16 @@ config MTK_SCP
>  
>  	  It's safe to say N here.
>  
> +config MTK_APU
> +	tristate "Mediatek APU remoteproc support"
> +	depends on ARCH_MEDIATEK
> +	depends on MTK_IOMMU
> +	help
> +	  Say y to support the Mediatek's Accelerated Processing Unit (APU) via
> +	  the remote processor framework.
> +
> +	  It's safe to say N here.
> +
>  config OMAP_REMOTEPROC
>  	tristate "OMAP remoteproc support"
>  	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX
> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
> index e8b886e511f0..2ea231b75fa6 100644
> --- a/drivers/remoteproc/Makefile
> +++ b/drivers/remoteproc/Makefile
> @@ -12,6 +12,7 @@ remoteproc-y				+= remoteproc_elf_loader.o
>  obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
>  obj-$(CONFIG_INGENIC_VPU_RPROC)		+= ingenic_rproc.o
>  obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o mtk_scp_ipi.o
> +obj-$(CONFIG_MTK_APU)			+= mtk_apu_rproc.o
>  obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
>  obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
>  obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
> diff --git a/drivers/remoteproc/mtk_apu_rproc.c b/drivers/remoteproc/mtk_apu_rproc.c
> new file mode 100644
> index 000000000000..fb416a817ef3
> --- /dev/null
> +++ b/drivers/remoteproc/mtk_apu_rproc.c
> @@ -0,0 +1,308 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 BayLibre SAS
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/iommu.h>
> +#include <linux/irq.h>
> +#include <linux/kernel.h>
> +#include <linux/highmem.h>

Move this below "delay.h"

> +#include <linux/module.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/platform_device.h>
> +#include <linux/remoteproc.h>
> +
> +#include "remoteproc_internal.h"
> +
> +/* From MT8183 4.5 Vision Processor Unit (VPU).pdf datasheet */
> +#define SW_RST					(0x0000000C)
> +#define  SW_RST_OCD_HALT_ON_RST			BIT(12)
> +#define  SW_RST_IPU_D_RST			BIT(8)
> +#define  SW_RST_IPU_B_RST			BIT(4)

Please don't indent defines.

> +#define CORE_CTRL				(0x00000110)
> +#define  CORE_CTRL_PDEBUG_ENABLE		BIT(31)
> +#define	 CORE_CTRL_SRAM_64K_iMEM		(0x00 << 27)
> +#define	 CORE_CTRL_SRAM_96K_iMEM		(0x01 << 27)
> +#define	 CORE_CTRL_SRAM_128K_iMEM		(0x02 << 27)
> +#define	 CORE_CTRL_SRAM_192K_iMEM		(0x03 << 27)
> +#define	 CORE_CTRL_SRAM_256K_iMEM		(0x04 << 27)
> +#define  CORE_CTRL_PBCLK_ENABLE			BIT(26)
> +#define  CORE_CTRL_RUN_STALL			BIT(23)
> +#define  CORE_CTRL_STATE_VECTOR_SELECT		BIT(19)
> +#define  CORE_CTRL_PIF_GATED			BIT(17)
> +#define  CORE_CTRL_NMI				BIT(0)
> +#define CORE_XTENSA_INT				(0x00000114)
> +#define CORE_CTL_XTENSA_INT			(0x00000118)
> +#define CORE_DEFAULT0				(0x0000013C)
> +#define  CORE_DEFAULT0_QOS_SWAP_0		(0x00 << 28)
> +#define  CORE_DEFAULT0_QOS_SWAP_1		(0x01 << 28)
> +#define  CORE_DEFAULT0_QOS_SWAP_2		(0x02 << 28)
> +#define  CORE_DEFAULT0_QOS_SWAP_3		(0x03 << 28)
> +#define  CORE_DEFAULT0_ARUSER_USE_IOMMU		(0x10 << 23)
> +#define  CORE_DEFAULT0_AWUSER_USE_IOMMU		(0x10 << 18)
> +#define CORE_DEFAULT1				(0x00000140)
> +#define  CORE_DEFAULT0_ARUSER_IDMA_USE_IOMMU	(0x10 << 0)
> +#define  CORE_DEFAULT0_AWUSER_IDMA_USE_IOMMU	(0x10 << 5)
> +#define CORE_XTENSA_ALTRESETVEC			(0x000001F8)
> +
> +struct mtk_vpu_rproc {
> +	struct device *dev;
> +	struct rproc *rproc;
> +
> +	void __iomem *base;
> +	int irq;
> +	struct clk *axi;
> +	struct clk *ipu;
> +	struct clk *jtag;
> +};
> +
> +static u32 vpu_read32(struct mtk_vpu_rproc *vpu_rproc, u32 off)
> +{
> +	return readl(vpu_rproc->base + off);
> +}
> +
> +static void vpu_write32(struct mtk_vpu_rproc *vpu_rproc, u32 off, u32 value)
> +{
> +	writel(value, vpu_rproc->base + off);
> +}

Not sure that much is gained by adding the above two functions.  Just using
readl/writel would suit me just fine.

> +
> +static int mtk_vpu_rproc_start(struct rproc *rproc)
> +{
> +	struct mtk_vpu_rproc *vpu_rproc = rproc->priv;
> +	u32 core_ctrl;
> +
> +	vpu_write32(vpu_rproc, CORE_XTENSA_ALTRESETVEC, rproc->bootaddr);
> +
> +	core_ctrl = vpu_read32(vpu_rproc, CORE_CTRL);
> +	core_ctrl |= CORE_CTRL_PDEBUG_ENABLE | CORE_CTRL_PBCLK_ENABLE |
> +		     CORE_CTRL_STATE_VECTOR_SELECT | CORE_CTRL_RUN_STALL |
> +		     CORE_CTRL_PIF_GATED;
> +	vpu_write32(vpu_rproc, CORE_CTRL, core_ctrl);
> +
> +	vpu_write32(vpu_rproc, SW_RST, SW_RST_OCD_HALT_ON_RST |
> +				       SW_RST_IPU_B_RST | SW_RST_IPU_D_RST);
> +	ndelay(27);

What is this for?  The state of the VPU can't be polled?

> +	vpu_write32(vpu_rproc, SW_RST, 0);
> +
> +	core_ctrl &= ~CORE_CTRL_PIF_GATED;
> +	vpu_write32(vpu_rproc, CORE_CTRL, core_ctrl);
> +
> +	vpu_write32(vpu_rproc, CORE_DEFAULT0, CORE_DEFAULT0_AWUSER_USE_IOMMU |
> +					      CORE_DEFAULT0_ARUSER_USE_IOMMU |
> +					      CORE_DEFAULT0_QOS_SWAP_1);
> +	vpu_write32(vpu_rproc, CORE_DEFAULT1,
> +		    CORE_DEFAULT0_AWUSER_IDMA_USE_IOMMU |
> +		    CORE_DEFAULT0_ARUSER_IDMA_USE_IOMMU);
> +
> +	core_ctrl &= ~CORE_CTRL_RUN_STALL;
> +	vpu_write32(vpu_rproc, CORE_CTRL, core_ctrl);

I would certainly appreciate more comments that describe that is going on in
this function.

> +
> +	return 0;
> +}
> +
> +static int mtk_vpu_rproc_stop(struct rproc *rproc)
> +{
> +	struct mtk_vpu_rproc *vpu_rproc = rproc->priv;
> +	u32 core_ctrl;
> +
> +	core_ctrl = vpu_read32(vpu_rproc, CORE_CTRL);
> +	vpu_write32(vpu_rproc, CORE_CTRL, core_ctrl | CORE_CTRL_RUN_STALL);
> +
> +	return 0;
> +}
> +
> +static void mtk_vpu_rproc_kick(struct rproc *rproc, int vqid)
> +{
> +	struct mtk_vpu_rproc *vpu_rproc = rproc->priv;
> +
> +	vpu_write32(vpu_rproc, CORE_CTL_XTENSA_INT, 1 << vqid);
> +}
> +
> +static const struct rproc_ops mtk_vpu_rproc_ops = {
> +	.start		= mtk_vpu_rproc_start,
> +	.stop		= mtk_vpu_rproc_stop,
> +	.kick		= mtk_vpu_rproc_kick,
> +};
> +
> +static irqreturn_t mtk_vpu_rproc_callback(int irq, void *data)
> +{
> +	struct rproc *rproc = (struct rproc *)data;

There is no need to cast when working with a void pointer.  The same comment
applies throughout.

> +	struct mtk_vpu_rproc *vpu_rproc = (struct mtk_vpu_rproc *)rproc->priv;
> +
> +	vpu_write32(vpu_rproc, CORE_XTENSA_INT, 1);
> +
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static irqreturn_t handle_event(int irq, void *data)
> +{
> +	struct rproc *rproc = (struct rproc *)data;
> +
> +	rproc_vq_interrupt(rproc, 0);
> +	rproc_vq_interrupt(rproc, 1);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int mtk_vpu_rproc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct mtk_vpu_rproc *vpu_rproc;
> +	struct rproc *rproc;
> +	struct resource *res;
> +	int ret;
> +
> +	rproc = rproc_alloc(dev, "apu", &mtk_vpu_rproc_ops, NULL,
> +			    sizeof(*vpu_rproc));

The problem with hard coding the name of the remote process is that it work on
only when there is a single processor.  Based on the DTS extention sent with
this serie, there seems to be a possibility of having more the one.  As such
both remote processor will be called "apu", mandating you to look at the
platform resources to know which is which.  Consider using dev_name() or
dev->of_node->name. 

> +	if (!rproc)
> +		return -ENOMEM;
> +
> +	rproc->recovery_disabled = true;
> +	rproc->has_iommu = false;
> +
> +	vpu_rproc = rproc->priv;
> +	vpu_rproc->rproc = rproc;
> +	vpu_rproc->dev = dev;
> +
> +	platform_set_drvdata(pdev, rproc);
> +
> +	rproc->domain = iommu_get_domain_for_dev(dev);
> +	if (!rproc->domain) {
> +		dev_err(dev, "Failed to get the IOMMU domain\n");
> +		ret = -EINVAL;
> +		goto free_rproc;
> +	}
> +
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	vpu_rproc->base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(vpu_rproc->base)) {
> +		dev_err(&pdev->dev, "Failed to map mmio\n");

Above dev_err() is used with @dev while here @pdev->dev is.  Please pick one you
like and stick with it. 

> +		ret = PTR_ERR(vpu_rproc->base);
> +		goto free_rproc;
> +	}
> +
> +	vpu_rproc->irq = platform_get_irq(pdev, 0);
> +	if (vpu_rproc->irq < 0) {
> +		ret = vpu_rproc->irq;
> +		goto free_rproc;
> +	}
> +
> +	ret = devm_request_threaded_irq(dev, vpu_rproc->irq,
> +					mtk_vpu_rproc_callback, handle_event,
> +					IRQF_SHARED | IRQF_ONESHOT,
> +					"mtk_vpu-remoteproc", rproc);

Same problem as above, i.e hard coding the name of the interrupt will be
confusing when probing sysfs.  Here rproc->index holds the value that
corresponds to 'X' in /sys/dev/class/remoteproc/remoteprocX.  Simply build a
string using that and feed it to devm_request_threaded_ifq().


> +	if (ret) {
> +		dev_err(dev, "devm_request_threaded_irq error: %d\n", ret);
> +		goto free_rproc;
> +	}
> +
> +	vpu_rproc->ipu = devm_clk_get(dev, "ipu");
> +	if (IS_ERR(vpu_rproc->ipu)) {
> +		dev_err(dev, "Failed to get ipu clock\n");
> +		ret = PTR_ERR(vpu_rproc->ipu);
> +		goto free_rproc;
> +	}
> +
> +	ret = clk_prepare_enable(vpu_rproc->ipu);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable ipu clock\n");
> +		goto free_rproc;
> +	}
> +
> +	vpu_rproc->axi = devm_clk_get(dev, "axi");
> +	if (IS_ERR(vpu_rproc->axi)) {
> +		dev_err(dev, "Failed to get axi clock\n");
> +		ret = PTR_ERR(vpu_rproc->axi);
> +		goto clk_disable_ipu;
> +	}
> +
> +	ret = clk_prepare_enable(vpu_rproc->axi);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable axi clock\n");
> +		goto clk_disable_ipu;
> +	}a

Please look at how Paul use the clock bulk API to deal with multiple clocs in
ingenic_rproc.c and see if it is possible to use the same scheme.

> +
> +	vpu_rproc->jtag = devm_clk_get_optional(dev, "jtag");

Why is the jtag clock optional when the binding document says that it "seems to
be required to run the DSP, even when JTAG is not in use"?

> +	if (IS_ERR(vpu_rproc->jtag)) {
> +		dev_err(dev, "Failed to enable jtag clock\n");
> +		ret = PTR_ERR(vpu_rproc->jtag);
> +		goto clk_disable_axi;
> +	}
> +
> +	ret = clk_prepare_enable(vpu_rproc->jtag);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable jtag clock\n");
> +		goto clk_disable_axi;
> +	}
> +
> +	ret = of_reserved_mem_device_init(dev);
> +	if (ret) {
> +		dev_err(dev, "device does not have specific CMA pool\n");
> +		goto clk_disable_jtag;
> +	}
> +
> +	ret = rproc_add(rproc);
> +	if (ret) {
> +		dev_err(dev, "rproc_add failed: %d\n", ret);
> +		goto free_mem;
> +	}
> +
> +	return 0;
> +
> +free_mem:
> +	of_reserved_mem_device_release(dev);
> +clk_disable_jtag:
> +	clk_disable_unprepare(vpu_rproc->jtag);
> +clk_disable_axi:
> +	clk_disable_unprepare(vpu_rproc->axi);
> +clk_disable_ipu:
> +	clk_disable_unprepare(vpu_rproc->ipu);
> +free_rproc:
> +	rproc_free(rproc);
> +
> +	return ret;
> +}
> +
> +static int mtk_vpu_rproc_remove(struct platform_device *pdev)
> +{
> +	struct rproc *rproc = platform_get_drvdata(pdev);
> +	struct mtk_vpu_rproc *vpu_rproc = (struct mtk_vpu_rproc *)rproc->priv;
> +	struct device *dev = &pdev->dev;
> +
> +	disable_irq(vpu_rproc->irq);
> +
> +	rproc_del(rproc);
> +	of_reserved_mem_device_release(dev);
> +	clk_disable_unprepare(vpu_rproc->jtag);
> +	clk_disable_unprepare(vpu_rproc->axi);
> +	clk_disable_unprepare(vpu_rproc->ipu);
> +	rproc_free(rproc);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id mtk_vpu_rproc_of_match[] __maybe_unused = {

Why is "__maybe_unused" needed?

Thanks,
Mathieu


> +	{ .compatible = "mediatek,mt8183-apu", },
> +	{ /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(of, mtk_vpu_rproc_of_match);
> +
> +static struct platform_driver mtk_vpu_rproc_driver = {
> +	.probe = mtk_vpu_rproc_probe,
> +	.remove = mtk_vpu_rproc_remove,
> +	.driver = {
> +		.name = "mtk_vpu-rproc",
> +		.of_match_table = of_match_ptr(mtk_vpu_rproc_of_match),
> +	},
> +};
> +module_platform_driver(mtk_vpu_rproc_driver);
> +
> +MODULE_LICENSE("GPL v2");
> +MODULE_AUTHOR("Alexandre Bailon");
> +MODULE_DESCRIPTION("Mt8183 VPU Remote Processor control driver");
> -- 
> 2.26.2
> 
