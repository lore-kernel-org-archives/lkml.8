Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F4EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D686923119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ygfsba48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729933AbgHFRXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbgHFRFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:05:03 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7750BC03461E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 06:25:40 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z18so40432281wrm.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 06:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=57HL3Mhek2tPr4EHNczJ9yRHMOPu9jYI3Mibt+cFat8=;
        b=Ygfsba48/5RguXx55Fy4DT6mPC2nit0tDjqGKYxagikf0yZ3StU3ryTf6RPDTM1Hq8
         CUEa2GWqoHcIj89f5mBjDgLLSYHbJHSK6o0dffWzl2CBwN60qv3ZVD1JrgF3aTx2/Z/a
         WaZJ+kF30wHbGLXbouRXiimf4C/xvYmtcXqejy5J1i5X3m1voxsIDC0v7BVByUh2q6NC
         ZLOZaPCKNi5dXm72yQKqgqS4DBjQcdDklqp2TyRsljH2U2YK6M5RqljImEZuq0wJxcj9
         ItkesKOAxa0KgImYv7gJOOoRy6M56PczFU5tqsc+qq3DtQlHgr6pO7XqvVd025q3jprx
         QWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=57HL3Mhek2tPr4EHNczJ9yRHMOPu9jYI3Mibt+cFat8=;
        b=Ut39TJDiUfQh52GL5XGrzCKTlOgAcBzIMVb6lQOzIyWbYgleerBTijq3SYMq7y5ZJu
         fYP+7rDyPbuBnnhxfj2w1d60P35PNV6DXhLC3zvv/VrezVP5iwUsMxi4SDwWVsVUt7co
         ODuSn4KAaAf3dejEVng2B4+B0gf/4hx0zZBzFuxUllBKR/gJef9cqUR+NGdRPhCpexAL
         80IDxC7CFez/RP4/I4S8D63QwnLVGX45SiWxtd+WDy5/ei63uf2QBuXiFjWCzdl+L6Gi
         Gwgvvst0/V0XtVmeTkAKCgcN4Wx9+DHZZNH39PJgbhvVK8Pf0o8i6DXjiQV9gl99P5BO
         H9dw==
X-Gm-Message-State: AOAM5303Irr+5MWw+6oru6O4gdsefB2ZS2Unwo+Q2tG06L01BatPHpgT
        xIicyxixfoniJWpK5xupctd6fSvKQ9uD2A==
X-Google-Smtp-Source: ABdhPJyRXZkGjLDuIuKYo610OUx0FT6uueCMypc6l+mPGszPnxiow1UwkKF7kmNpjRP9XliwnJOwqQ==
X-Received: by 2002:adf:ee51:: with SMTP id w17mr7779745wro.239.1596720338502;
        Thu, 06 Aug 2020 06:25:38 -0700 (PDT)
Received: from linux.local (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id v29sm6558153wrv.51.2020.08.06.06.25.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 06:25:37 -0700 (PDT)
Subject: Re: [PATCH 2/6] remoteproc: Add a remoteproc driver for the MT8183's
 APU
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        matthias.bgg@gmail.com, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200713132927.24925-1-abailon@baylibre.com>
 <20200713132927.24925-3-abailon@baylibre.com>
 <20200720221726.GD1113627@xps15>
From:   Alexandre Bailon <abailon@baylibre.com>
Message-ID: <0a3ce3bb-87aa-c1a7-6791-b4482117e3e2@baylibre.com>
Date:   Thu, 6 Aug 2020 15:25:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200720221726.GD1113627@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 7/21/20 12:17 AM, Mathieu Poirier wrote:
> On Mon, Jul 13, 2020 at 03:29:23PM +0200, Alexandre Bailon wrote:
>> This adds a driver to control the APU present in the MT8183.
>> This loads the firmware and start the DSP.
>>
>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>> ---
>>   drivers/remoteproc/Kconfig         |  10 +
>>   drivers/remoteproc/Makefile        |   1 +
>>   drivers/remoteproc/mtk_apu_rproc.c | 308 +++++++++++++++++++++++++++++
> I would name the file mtk_apu.c to be consistent with the existing mtk_scp.c
I will rename it
>
>>   3 files changed, 319 insertions(+)
>>   create mode 100644 drivers/remoteproc/mtk_apu_rproc.c
>>
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index c4d1731295eb..e116d4a12ac3 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -42,6 +42,16 @@ config MTK_SCP
>>   
>>   	  It's safe to say N here.
>>   
>> +config MTK_APU
>> +	tristate "Mediatek APU remoteproc support"
>> +	depends on ARCH_MEDIATEK
>> +	depends on MTK_IOMMU
>> +	help
>> +	  Say y to support the Mediatek's Accelerated Processing Unit (APU) via
>> +	  the remote processor framework.
>> +
>> +	  It's safe to say N here.
>> +
>>   config OMAP_REMOTEPROC
>>   	tristate "OMAP remoteproc support"
>>   	depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX
>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>> index e8b886e511f0..2ea231b75fa6 100644
>> --- a/drivers/remoteproc/Makefile
>> +++ b/drivers/remoteproc/Makefile
>> @@ -12,6 +12,7 @@ remoteproc-y				+= remoteproc_elf_loader.o
>>   obj-$(CONFIG_IMX_REMOTEPROC)		+= imx_rproc.o
>>   obj-$(CONFIG_INGENIC_VPU_RPROC)		+= ingenic_rproc.o
>>   obj-$(CONFIG_MTK_SCP)			+= mtk_scp.o mtk_scp_ipi.o
>> +obj-$(CONFIG_MTK_APU)			+= mtk_apu_rproc.o
>>   obj-$(CONFIG_OMAP_REMOTEPROC)		+= omap_remoteproc.o
>>   obj-$(CONFIG_WKUP_M3_RPROC)		+= wkup_m3_rproc.o
>>   obj-$(CONFIG_DA8XX_REMOTEPROC)		+= da8xx_remoteproc.o
>> diff --git a/drivers/remoteproc/mtk_apu_rproc.c b/drivers/remoteproc/mtk_apu_rproc.c
>> new file mode 100644
>> index 000000000000..fb416a817ef3
>> --- /dev/null
>> +++ b/drivers/remoteproc/mtk_apu_rproc.c
>> @@ -0,0 +1,308 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2020 BayLibre SAS
>> + */
>> +
>> +#include <linux/bitops.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/iommu.h>
>> +#include <linux/irq.h>
>> +#include <linux/kernel.h>
>> +#include <linux/highmem.h>
> Move this below "delay.h"
>
>> +#include <linux/module.h>
>> +#include <linux/of_reserved_mem.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/remoteproc.h>
>> +
>> +#include "remoteproc_internal.h"
>> +
>> +/* From MT8183 4.5 Vision Processor Unit (VPU).pdf datasheet */
>> +#define SW_RST					(0x0000000C)
>> +#define  SW_RST_OCD_HALT_ON_RST			BIT(12)
>> +#define  SW_RST_IPU_D_RST			BIT(8)
>> +#define  SW_RST_IPU_B_RST			BIT(4)
> Please don't indent defines.
>
>> +#define CORE_CTRL				(0x00000110)
>> +#define  CORE_CTRL_PDEBUG_ENABLE		BIT(31)
>> +#define	 CORE_CTRL_SRAM_64K_iMEM		(0x00 << 27)
>> +#define	 CORE_CTRL_SRAM_96K_iMEM		(0x01 << 27)
>> +#define	 CORE_CTRL_SRAM_128K_iMEM		(0x02 << 27)
>> +#define	 CORE_CTRL_SRAM_192K_iMEM		(0x03 << 27)
>> +#define	 CORE_CTRL_SRAM_256K_iMEM		(0x04 << 27)
>> +#define  CORE_CTRL_PBCLK_ENABLE			BIT(26)
>> +#define  CORE_CTRL_RUN_STALL			BIT(23)
>> +#define  CORE_CTRL_STATE_VECTOR_SELECT		BIT(19)
>> +#define  CORE_CTRL_PIF_GATED			BIT(17)
>> +#define  CORE_CTRL_NMI				BIT(0)
>> +#define CORE_XTENSA_INT				(0x00000114)
>> +#define CORE_CTL_XTENSA_INT			(0x00000118)
>> +#define CORE_DEFAULT0				(0x0000013C)
>> +#define  CORE_DEFAULT0_QOS_SWAP_0		(0x00 << 28)
>> +#define  CORE_DEFAULT0_QOS_SWAP_1		(0x01 << 28)
>> +#define  CORE_DEFAULT0_QOS_SWAP_2		(0x02 << 28)
>> +#define  CORE_DEFAULT0_QOS_SWAP_3		(0x03 << 28)
>> +#define  CORE_DEFAULT0_ARUSER_USE_IOMMU		(0x10 << 23)
>> +#define  CORE_DEFAULT0_AWUSER_USE_IOMMU		(0x10 << 18)
>> +#define CORE_DEFAULT1				(0x00000140)
>> +#define  CORE_DEFAULT0_ARUSER_IDMA_USE_IOMMU	(0x10 << 0)
>> +#define  CORE_DEFAULT0_AWUSER_IDMA_USE_IOMMU	(0x10 << 5)
>> +#define CORE_XTENSA_ALTRESETVEC			(0x000001F8)
>> +
>> +struct mtk_vpu_rproc {
>> +	struct device *dev;
>> +	struct rproc *rproc;
>> +
>> +	void __iomem *base;
>> +	int irq;
>> +	struct clk *axi;
>> +	struct clk *ipu;
>> +	struct clk *jtag;
>> +};
>> +
>> +static u32 vpu_read32(struct mtk_vpu_rproc *vpu_rproc, u32 off)
>> +{
>> +	return readl(vpu_rproc->base + off);
>> +}
>> +
>> +static void vpu_write32(struct mtk_vpu_rproc *vpu_rproc, u32 off, u32 value)
>> +{
>> +	writel(value, vpu_rproc->base + off);
>> +}
> Not sure that much is gained by adding the above two functions.  Just using
> readl/writel would suit me just fine.
I though this was more convenient to use but using readl/writel is also 
fine for me.
>> +
>> +static int mtk_vpu_rproc_start(struct rproc *rproc)
>> +{
>> +	struct mtk_vpu_rproc *vpu_rproc = rproc->priv;
>> +	u32 core_ctrl;
>> +
>> +	vpu_write32(vpu_rproc, CORE_XTENSA_ALTRESETVEC, rproc->bootaddr);
>> +
>> +	core_ctrl = vpu_read32(vpu_rproc, CORE_CTRL);
>> +	core_ctrl |= CORE_CTRL_PDEBUG_ENABLE | CORE_CTRL_PBCLK_ENABLE |
>> +		     CORE_CTRL_STATE_VECTOR_SELECT | CORE_CTRL_RUN_STALL |
>> +		     CORE_CTRL_PIF_GATED;
>> +	vpu_write32(vpu_rproc, CORE_CTRL, core_ctrl);
>> +
>> +	vpu_write32(vpu_rproc, SW_RST, SW_RST_OCD_HALT_ON_RST |
>> +				       SW_RST_IPU_B_RST | SW_RST_IPU_D_RST);
>> +	ndelay(27);
> What is this for?  The state of the VPU can't be polled?

TBH, I don't know. I got the programming model from Mediatek's kernel.

I assumed that was the minimum time required to maintain reset asserted 
to make it effective.

>
>> +	vpu_write32(vpu_rproc, SW_RST, 0);
>> +
>> +	core_ctrl &= ~CORE_CTRL_PIF_GATED;
>> +	vpu_write32(vpu_rproc, CORE_CTRL, core_ctrl);
>> +
>> +	vpu_write32(vpu_rproc, CORE_DEFAULT0, CORE_DEFAULT0_AWUSER_USE_IOMMU |
>> +					      CORE_DEFAULT0_ARUSER_USE_IOMMU |
>> +					      CORE_DEFAULT0_QOS_SWAP_1);
>> +	vpu_write32(vpu_rproc, CORE_DEFAULT1,
>> +		    CORE_DEFAULT0_AWUSER_IDMA_USE_IOMMU |
>> +		    CORE_DEFAULT0_ARUSER_IDMA_USE_IOMMU);
>> +
>> +	core_ctrl &= ~CORE_CTRL_RUN_STALL;
>> +	vpu_write32(vpu_rproc, CORE_CTRL, core_ctrl);
> I would certainly appreciate more comments that describe that is going on in
> this function.
I will try to comment a little more but again, this come from Mediatek's 
kernel.
Even if I have access to the datasheet, there are no much details.
>
>> +
>> +	return 0;
>> +}
>> +
>> +static int mtk_vpu_rproc_stop(struct rproc *rproc)
>> +{
>> +	struct mtk_vpu_rproc *vpu_rproc = rproc->priv;
>> +	u32 core_ctrl;
>> +
>> +	core_ctrl = vpu_read32(vpu_rproc, CORE_CTRL);
>> +	vpu_write32(vpu_rproc, CORE_CTRL, core_ctrl | CORE_CTRL_RUN_STALL);
>> +
>> +	return 0;
>> +}
>> +
>> +static void mtk_vpu_rproc_kick(struct rproc *rproc, int vqid)
>> +{
>> +	struct mtk_vpu_rproc *vpu_rproc = rproc->priv;
>> +
>> +	vpu_write32(vpu_rproc, CORE_CTL_XTENSA_INT, 1 << vqid);
>> +}
>> +
>> +static const struct rproc_ops mtk_vpu_rproc_ops = {
>> +	.start		= mtk_vpu_rproc_start,
>> +	.stop		= mtk_vpu_rproc_stop,
>> +	.kick		= mtk_vpu_rproc_kick,
>> +};
>> +
>> +static irqreturn_t mtk_vpu_rproc_callback(int irq, void *data)
>> +{
>> +	struct rproc *rproc = (struct rproc *)data;
> There is no need to cast when working with a void pointer.  The same comment
> applies throughout.
>
>> +	struct mtk_vpu_rproc *vpu_rproc = (struct mtk_vpu_rproc *)rproc->priv;
>> +
>> +	vpu_write32(vpu_rproc, CORE_XTENSA_INT, 1);
>> +
>> +	return IRQ_WAKE_THREAD;
>> +}
>> +
>> +static irqreturn_t handle_event(int irq, void *data)
>> +{
>> +	struct rproc *rproc = (struct rproc *)data;
>> +
>> +	rproc_vq_interrupt(rproc, 0);
>> +	rproc_vq_interrupt(rproc, 1);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int mtk_vpu_rproc_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct mtk_vpu_rproc *vpu_rproc;
>> +	struct rproc *rproc;
>> +	struct resource *res;
>> +	int ret;
>> +
>> +	rproc = rproc_alloc(dev, "apu", &mtk_vpu_rproc_ops, NULL,
>> +			    sizeof(*vpu_rproc));
> The problem with hard coding the name of the remote process is that it work on
> only when there is a single processor.  Based on the DTS extention sent with
> this serie, there seems to be a possibility of having more the one.  As such
> both remote processor will be called "apu", mandating you to look at the
> platform resources to know which is which.  Consider using dev_name() or
> dev->of_node->name.
>
>> +	if (!rproc)
>> +		return -ENOMEM;
>> +
>> +	rproc->recovery_disabled = true;
>> +	rproc->has_iommu = false;
>> +
>> +	vpu_rproc = rproc->priv;
>> +	vpu_rproc->rproc = rproc;
>> +	vpu_rproc->dev = dev;
>> +
>> +	platform_set_drvdata(pdev, rproc);
>> +
>> +	rproc->domain = iommu_get_domain_for_dev(dev);
>> +	if (!rproc->domain) {
>> +		dev_err(dev, "Failed to get the IOMMU domain\n");
>> +		ret = -EINVAL;
>> +		goto free_rproc;
>> +	}
>> +
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	vpu_rproc->base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(vpu_rproc->base)) {
>> +		dev_err(&pdev->dev, "Failed to map mmio\n");
> Above dev_err() is used with @dev while here @pdev->dev is.  Please pick one you
> like and stick with it.
>
>> +		ret = PTR_ERR(vpu_rproc->base);
>> +		goto free_rproc;
>> +	}
>> +
>> +	vpu_rproc->irq = platform_get_irq(pdev, 0);
>> +	if (vpu_rproc->irq < 0) {
>> +		ret = vpu_rproc->irq;
>> +		goto free_rproc;
>> +	}
>> +
>> +	ret = devm_request_threaded_irq(dev, vpu_rproc->irq,
>> +					mtk_vpu_rproc_callback, handle_event,
>> +					IRQF_SHARED | IRQF_ONESHOT,
>> +					"mtk_vpu-remoteproc", rproc);
> Same problem as above, i.e hard coding the name of the interrupt will be
> confusing when probing sysfs.  Here rproc->index holds the value that
> corresponds to 'X' in /sys/dev/class/remoteproc/remoteprocX.  Simply build a
> string using that and feed it to devm_request_threaded_ifq().
>
>
>> +	if (ret) {
>> +		dev_err(dev, "devm_request_threaded_irq error: %d\n", ret);
>> +		goto free_rproc;
>> +	}
>> +
>> +	vpu_rproc->ipu = devm_clk_get(dev, "ipu");
>> +	if (IS_ERR(vpu_rproc->ipu)) {
>> +		dev_err(dev, "Failed to get ipu clock\n");
>> +		ret = PTR_ERR(vpu_rproc->ipu);
>> +		goto free_rproc;
>> +	}
>> +
>> +	ret = clk_prepare_enable(vpu_rproc->ipu);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable ipu clock\n");
>> +		goto free_rproc;
>> +	}
>> +
>> +	vpu_rproc->axi = devm_clk_get(dev, "axi");
>> +	if (IS_ERR(vpu_rproc->axi)) {
>> +		dev_err(dev, "Failed to get axi clock\n");
>> +		ret = PTR_ERR(vpu_rproc->axi);
>> +		goto clk_disable_ipu;
>> +	}
>> +
>> +	ret = clk_prepare_enable(vpu_rproc->axi);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable axi clock\n");
>> +		goto clk_disable_ipu;
>> +	}a
> Please look at how Paul use the clock bulk API to deal with multiple clocs in
> ingenic_rproc.c and see if it is possible to use the same scheme.
I did not knew the bulk API. I think it should work.
>
>> +
>> +	vpu_rproc->jtag = devm_clk_get_optional(dev, "jtag");
> Why is the jtag clock optional when the binding document says that it "seems to
> be required to run the DSP, even when JTAG is not in use"?

I forget to change it to devm_clk_get when I figured out this was 
actually not optional.

Thanks,
Alexandre

>
>> +	if (IS_ERR(vpu_rproc->jtag)) {
>> +		dev_err(dev, "Failed to enable jtag clock\n");
>> +		ret = PTR_ERR(vpu_rproc->jtag);
>> +		goto clk_disable_axi;
>> +	}
>> +
>> +	ret = clk_prepare_enable(vpu_rproc->jtag);
>> +	if (ret) {
>> +		dev_err(dev, "Failed to enable jtag clock\n");
>> +		goto clk_disable_axi;
>> +	}
>> +
>> +	ret = of_reserved_mem_device_init(dev);
>> +	if (ret) {
>> +		dev_err(dev, "device does not have specific CMA pool\n");
>> +		goto clk_disable_jtag;
>> +	}
>> +
>> +	ret = rproc_add(rproc);
>> +	if (ret) {
>> +		dev_err(dev, "rproc_add failed: %d\n", ret);
>> +		goto free_mem;
>> +	}
>> +
>> +	return 0;
>> +
>> +free_mem:
>> +	of_reserved_mem_device_release(dev);
>> +clk_disable_jtag:
>> +	clk_disable_unprepare(vpu_rproc->jtag);
>> +clk_disable_axi:
>> +	clk_disable_unprepare(vpu_rproc->axi);
>> +clk_disable_ipu:
>> +	clk_disable_unprepare(vpu_rproc->ipu);
>> +free_rproc:
>> +	rproc_free(rproc);
>> +
>> +	return ret;
>> +}
>> +
>> +static int mtk_vpu_rproc_remove(struct platform_device *pdev)
>> +{
>> +	struct rproc *rproc = platform_get_drvdata(pdev);
>> +	struct mtk_vpu_rproc *vpu_rproc = (struct mtk_vpu_rproc *)rproc->priv;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	disable_irq(vpu_rproc->irq);
>> +
>> +	rproc_del(rproc);
>> +	of_reserved_mem_device_release(dev);
>> +	clk_disable_unprepare(vpu_rproc->jtag);
>> +	clk_disable_unprepare(vpu_rproc->axi);
>> +	clk_disable_unprepare(vpu_rproc->ipu);
>> +	rproc_free(rproc);
>> +
>> +	return 0;
>> +}
>> +
>> +static const struct of_device_id mtk_vpu_rproc_of_match[] __maybe_unused = {
> Why is "__maybe_unused" needed?
>
> Thanks,
> Mathieu
>
>
>> +	{ .compatible = "mediatek,mt8183-apu", },
>> +	{ /* sentinel */ },
>> +};
>> +MODULE_DEVICE_TABLE(of, mtk_vpu_rproc_of_match);
>> +
>> +static struct platform_driver mtk_vpu_rproc_driver = {
>> +	.probe = mtk_vpu_rproc_probe,
>> +	.remove = mtk_vpu_rproc_remove,
>> +	.driver = {
>> +		.name = "mtk_vpu-rproc",
>> +		.of_match_table = of_match_ptr(mtk_vpu_rproc_of_match),
>> +	},
>> +};
>> +module_platform_driver(mtk_vpu_rproc_driver);
>> +
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_AUTHOR("Alexandre Bailon");
>> +MODULE_DESCRIPTION("Mt8183 VPU Remote Processor control driver");
>> -- 
>> 2.26.2
>>
