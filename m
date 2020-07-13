Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C3EDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E67206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKU0aMGQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729594AbgGMLQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgGMLQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:16:41 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA9EC061755;
        Mon, 13 Jul 2020 04:16:41 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id s10so15898824wrw.12;
        Mon, 13 Jul 2020 04:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WptQDLf6TPTHkTg0uhwm20rPGqGU5JZmGo8OTH6gM5o=;
        b=LKU0aMGQCKiWI7MN7Ln62lh8Fpd0e4ZTZijiySzzeyz+rOcMngV2Q+6njaDw2XQU0h
         FdVRTkgW54lPdxfU9p5Ah8mJC/z3bOBVld5Mp40FNi4ITBuuE4aqJdIt9e4uNvjGYjse
         NPOAEMc+/LUaggsoP9jc3eVvE3ew1qzt5J6NJDor0OwECv536HxcT7zYtbbWGc2rwqoL
         8gycYLMJPdUGbDp+oD6bHktAHrm4LMGcaxA2hTwRaLqGAvYMsRQ6Nzxop8F5o0MYG8E2
         UIRG1KEBg1VTfc5uxh73hzn7k/tebto+xCMPUrs2j+X1LUxKDgWsNbUjFYuhYVXzBOzc
         bXQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WptQDLf6TPTHkTg0uhwm20rPGqGU5JZmGo8OTH6gM5o=;
        b=X7oIK4TmLCxZjwoQjQr4a5hVR2rnXJq7500lljJgnXVLmOj5khDFvOpnvKYgEqIn+U
         bDDuO55MFrpUwsEGp61TKdRMKTFtw5213NVoJkhGlDvqNYqTtzdi/AqauOcy/ZTjbuN5
         H/hPaqOmhRInbI5OdOZHLPSIfcU/QvBtFuo6jnrUYIDx/QjTK0wQtxUmTmcKuPchNyf+
         BJQ3viihxYoNQuoL40BdCnCYkphCcCS+O3AIFIPgIu6gEh+1VKmErpxvVxDc7j4PQ37X
         dkpgsAMT3A1+hqo8UwSm2JcLNv4M2BsxrSOFJ2Hgx/qfPAL/cNjNtFALdXglrOVUmnte
         3TfQ==
X-Gm-Message-State: AOAM5331Mdv1n5yd8dSDrAapoqcK4yxwe9plrZpt6PAf/ZnRGk2B2/J+
        elhar0Bp4/FQnQGFisV2DC0=
X-Google-Smtp-Source: ABdhPJw5TDv9fwSmhkrJEJZeHFyxE2t+aInsWS+F1rjTzkmsyBIzlWqCxJn3D59d0CrIf8/Rvkb7OQ==
X-Received: by 2002:adf:f14e:: with SMTP id y14mr79121349wro.151.1594638999665;
        Mon, 13 Jul 2020 04:16:39 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.245])
        by smtp.gmail.com with ESMTPSA id w14sm23513950wrt.55.2020.07.13.04.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 04:16:38 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] soc: mediatek: add mtk-devapc driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>, wsd_upstream@mediatek.com
References: <1594285927-1840-1-git-send-email-neal.liu@mediatek.com>
 <1594285927-1840-3-git-send-email-neal.liu@mediatek.com>
 <f93663d4-86f1-971f-ed2c-67cd65d5049d@gmail.com>
 <1594626336.22730.36.camel@mtkswgap22>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <22002c0e-ec4e-187a-69ce-d2dac9b554bb@gmail.com>
Date:   Mon, 13 Jul 2020 13:16:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594626336.22730.36.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/07/2020 09:45, Neal Liu wrote:
> On Fri, 2020-07-10 at 14:14 +0200, Matthias Brugger wrote:
>>
> [snip]
>>> +
>>> +static int get_vio_slave_num(int slave_type)
>>
>> I have a hard time to understand the usefullness of this, can you please explain.
>>
> 
> The basic idea is to get total numbers of slaves. And we can use it to
> scan all slaves which has been triggered violation.
> I think I can pass it through DT data instead of using mtk_device_info
> array. I'll send another patches to change it.
> 
>>> +{
>>> +	if (slave_type == 0)
>>> +		return ARRAY_SIZE(mtk_devices_infra);
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static u32 get_shift_group(struct mtk_devapc_context *devapc_ctx,
>>> +			   int slave_type, int vio_idx)
>>> +{
>>> +	u32 vio_shift_sta;
>>> +	void __iomem *reg;
>>> +	int bit;
>>> +
>>> +	reg = mtk_devapc_pd_get(devapc_ctx, slave_type, VIO_SHIFT_STA, 0);
>>> +	vio_shift_sta = readl(reg);
>>> +
>>> +	for (bit = 0; bit < 32; bit++) {
>>> +		if ((vio_shift_sta >> bit) & 0x1) > +			break;
>>> +	}
>>> +
>>> +	return bit;
>>
>> We return the first position (from the right) of the rigster with the bit set to
>> one. Correct?
>> Can't we use __ffs() for this?
> 
> Yes, thanks for your reminds to use __ffs().
> I'll revise it in next patches.
> 
>>
>>> +}
>>> +
>>> +static int check_vio_mask_sta(struct mtk_devapc_context *devapc_ctx,
>>> +			      int slave_type, u32 module, int pd_reg_type)
>>> +{
>>> +	u32 reg_index, reg_offset;
>>> +	void __iomem *reg;
>>> +	u32 value;
>>> +
>>> +	VIO_MASK_STA_REG_GET(module);
>>> +
>>> +	reg = mtk_devapc_pd_get(devapc_ctx, slave_type, pd_reg_type, reg_index);
>>
>> reg = mtk_devapc_pd_get(devapc_ctx, slave_type, pd_reg_type,
>> VIO_MOD_TO_REG_IND(module));
> 
> Okay, I'll revise it in next patches.
> 
>>
>>> +	value = readl(reg);
>>> +
>>> +	return ((value >> reg_offset) & 0x1);
>>
>> return ((value >> VIO_MOD_TO_REG_OFF(module)) & 0x1);
> 
> Okay, I'll revise it in next patches.
> 
>>
>>> +}
>>> +
>>> +static int check_vio_mask(struct mtk_devapc_context *devapc_ctx, int slave_type,
>>> +			  u32 module)
>>> +{
>>> +	return check_vio_mask_sta(devapc_ctx, slave_type, module, VIO_MASK);
>>> +}
>>> +
>>> +static int check_vio_status(struct mtk_devapc_context *devapc_ctx,
>>> +			    int slave_type, u32 module)
>>> +{
>>> +	return check_vio_mask_sta(devapc_ctx, slave_type, module, VIO_STA);
>>> +}
>>> +
>>> +static void clear_vio_status(struct mtk_devapc_context *devapc_ctx,
>>> +			     int slave_type, u32 module)
>>> +{
>>> +	u32 reg_index, reg_offset;
>>> +	void __iomem *reg;
>>> +
>>> +	VIO_MASK_STA_REG_GET(module);
>>> +
>>> +	reg = mtk_devapc_pd_get(devapc_ctx, slave_type, VIO_STA, reg_index);
>>> +	writel(0x1 << reg_offset, reg);
>>> +
>>> +	if (check_vio_status(devapc_ctx, slave_type, module))
>>> +		pr_err(PFX "%s: Clear failed, slave_type:0x%x, module_index:0x%x\n",
>>> +		       __func__, slave_type, module);
>>> +}
>>> +
>>> +static void mask_module_irq(struct mtk_devapc_context *devapc_ctx,
>>> +			    int slave_type, u32 module, bool mask)
>>> +{
>>> +	u32 reg_index, reg_offset;
>>> +	void __iomem *reg;
>>> +	u32 value;
>>> +
>>> +	VIO_MASK_STA_REG_GET(module);
>>> +
>>> +	reg = mtk_devapc_pd_get(devapc_ctx, slave_type, VIO_MASK, reg_index);
>>> +
>>> +	value = readl(reg);
>>> +	if (mask)
>>> +		value |= (0x1 << reg_offset);
>>> +	else
>>> +		value &= ~(0x1 << reg_offset);
>>> +
>>> +	writel(value, reg);
>>> +}
>>> +
>>> +#define TIMEOUT_MS		10000
>>> +
>>> +static int read_poll_timeout(void __iomem *addr, u32 mask)
>>
>> That function is defined in include/linux/iopoll.h
>>
>>> +{
>>> +	unsigned long timeout = jiffies + msecs_to_jiffies(TIMEOUT_MS);
>>> +
>>> +	do {
>>> +		if (readl_relaxed(addr) & mask)
>>
>> Please use a variable where you write your value to and then check for the mask.
>> That maks the code easier to read and I think is part of the coding style.
>>
> 
> Okay, I'll use the function in iopoll.h instead.
> Thanks for your reminds.
> 
>>> +			return 0;
>>> +
>>> +	} while (!time_after(jiffies, timeout));
>>> +
>>> +	return (readl_relaxed(addr) & mask) ? 0 : -ETIMEDOUT;
>>> +}
>>> +
>>> +/*
>>> + * sync_vio_dbg - start to get violation information by selecting violation
>>> + *		  group and enable violation shift.
>>> + *
>>> + * Returns sync done or not
>>> + */
>>> +static u32 sync_vio_dbg(struct mtk_devapc_context *devapc_ctx, int slave_type,
>>> +			u32 shift_bit)
>>> +{
>>> +	void __iomem *pd_vio_shift_sta_reg;
>>> +	void __iomem *pd_vio_shift_sel_reg;
>>> +	void __iomem *pd_vio_shift_con_reg;
>>> +	u32 sync_done = 0;
>>> +
>>> +	pd_vio_shift_sta_reg = mtk_devapc_pd_get(devapc_ctx, slave_type,
>>> +						 VIO_SHIFT_STA, 0);
>>> +	pd_vio_shift_sel_reg = mtk_devapc_pd_get(devapc_ctx, slave_type,
>>> +						 VIO_SHIFT_SEL, 0);
>>> +	pd_vio_shift_con_reg = mtk_devapc_pd_get(devapc_ctx, slave_type,
>>> +						 VIO_SHIFT_CON, 0);
>>> +
>>> +	writel(0x1 << shift_bit, pd_vio_shift_sel_reg);
>>> +	writel(0x1, pd_vio_shift_con_reg);
>>> +
>>> +	if (!read_poll_timeout(pd_vio_shift_con_reg, 0x2))
>>> +		sync_done = 1;
>>> +	else
>>> +		pr_err(PFX "%s: Shift violation info failed\n", __func__);
>>> +
>>> +	/* Disable shift mechanism */
>>
>> Please add a comment explaining what the shift mechanism is about.
> 
> Okay, I'll add a comment to explain it at the beginning of this
> function.
> 
>>
>>> +	writel(0x0, pd_vio_shift_con_reg);
>>> +	writel(0x0, pd_vio_shift_sel_reg);
>>> +	writel(0x1 << shift_bit, pd_vio_shift_sta_reg);
>>> +
>>> +	return sync_done;
>>> +}
>>> +
>>> +static void devapc_vio_info_print(struct mtk_devapc_context *devapc_ctx)
>>> +{
>>> +	struct mtk_devapc_vio_info *vio_info = devapc_ctx->vio_info;
>>> +
>>> +	/* Print violation information */
>>> +	if (vio_info->write)
>>> +		pr_info(PFX "Write Violation\n");
>>> +	else if (vio_info->read)
>>> +		pr_info(PFX "Read Violation\n");
>>> +
>>> +	pr_info(PFX "%s%x, %s%x, %s%x, %s%x\n",
>>> +		"Vio Addr:0x", vio_info->vio_addr,
>>> +		"High:0x", vio_info->vio_addr_high,
>>> +		"Bus ID:0x", vio_info->master_id,
>>> +		"Dom ID:0x", vio_info->domain_id);
>>> +}
>>> +
>>> +static void devapc_extract_vio_dbg(struct mtk_devapc_context *devapc_ctx,
>>> +				   int slave_type)
>>> +{
>>> +	void __iomem *vio_dbg0_reg, *vio_dbg1_reg;
>>> +	struct mtk_devapc_vio_dbgs_desc *vio_dbgs;
>>> +	struct mtk_devapc_vio_info *vio_info;
>>> +	u32 dbg0;
>>> +
>>> +	vio_dbg0_reg = mtk_devapc_pd_get(devapc_ctx, slave_type, VIO_DBG0, 0);
>>> +	vio_dbg1_reg = mtk_devapc_pd_get(devapc_ctx, slave_type, VIO_DBG1, 0);
>>> +
>>> +	vio_dbgs = devapc_ctx->vio_dbgs_desc;
>>> +	vio_info = devapc_ctx->vio_info;
>>> +
>>> +	/* Extract violation information */
>>> +	dbg0 = readl(vio_dbg0_reg);
>>> +	vio_info->vio_addr = readl(vio_dbg1_reg);
>>> +
>>> +	vio_info->master_id = (dbg0 & vio_dbgs[MSTID].mask) >>
>>> +			      vio_dbgs[MSTID].start_bit;
>>> +	vio_info->domain_id = (dbg0 & vio_dbgs[DMNID].mask) >>
>>> +			      vio_dbgs[DMNID].start_bit;
>>> +	vio_info->write = ((dbg0 & vio_dbgs[VIO_W].mask) >>
>>> +			   vio_dbgs[VIO_W].start_bit) == 1;
>>> +	vio_info->read = ((dbg0 & vio_dbgs[VIO_R].mask) >>
>>> +			  vio_dbgs[VIO_R].start_bit) == 1;
>>> +	vio_info->vio_addr_high = (dbg0 & vio_dbgs[ADDR_H].mask) >>
>>> +				  vio_dbgs[ADDR_H].start_bit;
>>> +
>>> +	devapc_vio_info_print(devapc_ctx);
>>> +}
>>> +
>>> +/*
>>> + * mtk_devapc_dump_vio_dbg - shift & dump the violation debug information.
>>> + */
>>> +static bool mtk_devapc_dump_vio_dbg(struct mtk_devapc_context *devapc_ctx,
>>> +				    int slave_type, int *vio_idx)
>>> +{
>>> +	const struct mtk_device_info **device_info;
>>> +	u32 shift_bit;
>>> +	int i;
>>> +
>>> +	device_info = devapc_ctx->device_info;
>>> +
>>> +	for (i = 0; i < get_vio_slave_num(slave_type); i++) {
>>> +		*vio_idx = device_info[slave_type][i].vio_index;
>>> +
>>> +		if (check_vio_mask(devapc_ctx, slave_type, *vio_idx))
>>> +			continue;
>>> +
>>> +		if (!check_vio_status(devapc_ctx, slave_type, *vio_idx))
>>> +			continue;
>>> +
>>> +		shift_bit = get_shift_group(devapc_ctx, slave_type, *vio_idx);
>>> +
>>> +		if (!sync_vio_dbg(devapc_ctx, slave_type, shift_bit))
>>> +			continue;
>>> +
>>> +		devapc_extract_vio_dbg(devapc_ctx, slave_type);
>>> +
>>> +		return true;
>>> +	}
>>> +
>>> +	return false;
>>> +}
>>> +
>>> +/*
>>> + * devapc_violation_irq - the devapc Interrupt Service Routine (ISR) will dump
>>> + *			  violation information including which master violates
>>> + *			  access slave.
>>> + */
>>> +static irqreturn_t devapc_violation_irq(int irq_number,
>>> +					struct mtk_devapc_context *devapc_ctx)
>>> +{
>>> +	const struct mtk_device_info **device_info;
>>> +	int slave_type_num;
>>> +	int vio_idx = -1;
>>> +	int slave_type;
>>> +
>>> +	slave_type_num = devapc_ctx->slave_type_num;
>>> +	device_info = devapc_ctx->device_info;
>>> +
>>> +	for (slave_type = 0; slave_type < slave_type_num; slave_type++) {
>>> +		if (!mtk_devapc_dump_vio_dbg(devapc_ctx, slave_type, &vio_idx))
>>> +			continue;
>>> +
>>> +		/* Ensure that violation info are written before
>>> +		 * further operations
>>> +		 */
>>> +		smp_mb();
>>> +
>>> +		mask_module_irq(devapc_ctx, slave_type, vio_idx, true);
>>> +
>>> +		clear_vio_status(devapc_ctx, slave_type, vio_idx);
>>> +
>>> +		mask_module_irq(devapc_ctx, slave_type, vio_idx, false);
>>> +	}
>>> +
>>> +	return IRQ_HANDLED;
>>> +}
>>> +
>>> +/*
>>> + * start_devapc - initialize devapc status and start receiving interrupt
>>> + *		  while devapc violation is triggered.
>>> + */
>>> +static void start_devapc(struct mtk_devapc_context *devapc_ctx)
>>> +{
>>> +	const struct mtk_device_info **device_info;
>>> +	void __iomem *pd_vio_shift_sta_reg;
>>> +	void __iomem *pd_apc_con_reg;
>>> +	u32 vio_shift_sta;
>>> +	int slave_type, slave_type_num;
>>> +	int i, vio_idx;
>>> +
>>> +	device_info = devapc_ctx->device_info;
>>> +	slave_type_num = devapc_ctx->slave_type_num;
>>> +
>>> +	for (slave_type = 0; slave_type < slave_type_num; slave_type++) {
>>> +		pd_apc_con_reg = mtk_devapc_pd_get(devapc_ctx, slave_type,
>>> +						   APC_CON, 0);
>>> +		pd_vio_shift_sta_reg = mtk_devapc_pd_get(devapc_ctx, slave_type,
>>> +							 VIO_SHIFT_STA, 0);
>>> +		if (!pd_apc_con_reg || !pd_vio_shift_sta_reg)
>>> +			return;
>>> +
>>> +		/* Clear devapc violation status */
>>> +		writel(BIT(31), pd_apc_con_reg);
>>> +
>>> +		/* Clear violation shift status */
>>> +		vio_shift_sta = readl(pd_vio_shift_sta_reg);
>>> +		if (vio_shift_sta)
>>> +			writel(vio_shift_sta, pd_vio_shift_sta_reg);
>>> +
>>> +		/* Clear slave violation status */
>>> +		for (i = 0; i < get_vio_slave_num(slave_type); i++) {
>>> +			vio_idx = device_info[slave_type][i].vio_index;
>>> +
>>> +			clear_vio_status(devapc_ctx, slave_type, vio_idx);
>>> +
>>> +			mask_module_irq(devapc_ctx, slave_type, vio_idx, false);
>>> +		}
>>> +	}
>>> +}
>>> +
>>> +static int mtk_devapc_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device_node *node = pdev->dev.of_node;
>>> +	struct mtk_devapc_context *devapc_ctx;
>>> +	struct clk *devapc_infra_clk;
>>> +	u32 vio_dbgs_num, pds_num;
>>> +	u8 slave_type_num;
>>> +	u32 devapc_irq;
>>> +	size_t size;
>>> +	int i, ret;
>>> +
>>> +	if (IS_ERR(node))
>>> +		return -ENODEV;
>>> +
>>> +	devapc_ctx = devm_kzalloc(&pdev->dev, sizeof(struct mtk_devapc_context),
>>> +				  GFP_KERNEL);
>>> +	if (!devapc_ctx)
>>> +		return -ENOMEM;
>>> +
>>> +	if (of_property_read_u8(node, "mediatek-slv_type_num", &slave_type_num))
>>> +		return -ENXIO;
>>> +
>>> +	devapc_ctx->slave_type_num = slave_type_num;
>>> +
>>> +	size = slave_type_num * sizeof(void *);
>>> +	devapc_ctx->devapc_pd_base = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
>>> +	if (!devapc_ctx->devapc_pd_base)
>>> +		return -ENOMEM;
>>> +
>>> +	size = slave_type_num * sizeof(struct mtk_device_info *);
>>> +	devapc_ctx->device_info = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
>>> +	if (!devapc_ctx->device_info)
>>> +		return -ENOMEM;
>>> +
>>> +	for (i = 0; i < slave_type_num; i++) {
>>> +		devapc_ctx->devapc_pd_base[i] = of_iomap(node, i);
>>> +		if (!devapc_ctx->devapc_pd_base[i])
>>> +			return -EINVAL;
>>> +
>>> +		if (i == 0)
>>> +			devapc_ctx->device_info[i] = mtk_devices_infra;
>>> +	}
>>> +
>>> +	size = sizeof(struct mtk_devapc_vio_info);
>>> +	devapc_ctx->vio_info = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
>>> +	if (!devapc_ctx->vio_info)
>>> +		return -ENOMEM;
>>> +
>>> +	vio_dbgs_num = of_property_count_u32_elems(node, "mediatek-vio_dbgs");
>>> +	if (vio_dbgs_num <= 0)
>>> +		return -ENXIO;
>>> +
>>> +	size = (vio_dbgs_num / 2) * sizeof(struct mtk_devapc_vio_dbgs_desc);
>>> +	devapc_ctx->vio_dbgs_desc = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
>>> +	if (!devapc_ctx->vio_dbgs_desc)
>>> +		return -ENOMEM;
>>> +
>>> +	for (i = 0; i < vio_dbgs_num / 2; i++) {
>>> +		if (of_property_read_u32_index(node, "mediatek-vio_dbgs",
>>> +					       i * 2,
>>> +					       &devapc_ctx->vio_dbgs_desc[i].mask))
>>> +			return -ENXIO;
>>> +
>>> +		if (of_property_read_u32_index(node, "mediatek-vio_dbgs",
>>> +					       (i * 2) + 1,
>>> +					       &devapc_ctx->vio_dbgs_desc[i].start_bit))
>>> +			return -ENXIO;
>>> +	}
>>> +
>>> +	pds_num = of_property_count_u32_elems(node, "mediatek-pds_offset");
>>> +	if (pds_num <= 0)
>>> +		return -ENXIO;
>>> +
>>> +	size = pds_num * sizeof(u32);
>>> +	devapc_ctx->pds_offset = devm_kzalloc(&pdev->dev, size, GFP_KERNEL);
>>> +	if (!devapc_ctx->pds_offset)
>>> +		return -ENOMEM;
>>> +
>>> +	for (i = 0; i < pds_num; i++) {
>>> +		if (of_property_read_u32_index(node, "mediatek-pds_offset", i,
>>> +					       &devapc_ctx->pds_offset[i]))
>>> +			return -ENXIO;
>>> +	}
>>> +
>>> +	devapc_irq = irq_of_parse_and_map(node, 0);
>>> +	if (!devapc_irq)
>>> +		return -EINVAL;
>>> +
>>> +	devapc_infra_clk = devm_clk_get(&pdev->dev, "devapc-infra-clock");
>>> +	if (IS_ERR(devapc_infra_clk))
>>> +		return -EINVAL;
>>> +
>>> +	if (clk_prepare_enable(devapc_infra_clk))
>>> +		return -EINVAL;
>>> +
>>> +	start_devapc(devapc_ctx);
>>> +
>>> +	ret = devm_request_irq(&pdev->dev, devapc_irq,
>>> +			       (irq_handler_t)devapc_violation_irq,
>>> +			       IRQF_TRIGGER_NONE, "devapc", devapc_ctx);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int mtk_devapc_remove(struct platform_device *dev)
>>> +{
>>> +	return 0;
>>> +}
>>> +
>>> +static const struct of_device_id mtk_devapc_dt_match[] = {
>>> +	{ .compatible = "mediatek,mt6779-devapc" },
>>> +	{},
>>> +};
>>> +
>>> +static struct platform_driver mtk_devapc_driver = {
>>> +	.probe = mtk_devapc_probe,
>>> +	.remove = mtk_devapc_remove,
>>> +	.driver = {
>>> +		.name = KBUILD_MODNAME,
>>> +		.of_match_table = mtk_devapc_dt_match,
>>> +	},
>>> +};
>>> +
>>> +module_platform_driver(mtk_devapc_driver);
>>> +
>>> +MODULE_DESCRIPTION("Mediatek Device APC Driver");
>>> +MODULE_AUTHOR("Neal Liu <neal.liu@mediatek.com>");
>>> +MODULE_LICENSE("GPL");
>>> diff --git a/drivers/soc/mediatek/mtk-devapc.h b/drivers/soc/mediatek/mtk-devapc.h
>>> new file mode 100644
>>> index 0000000..ab2cb14
>>> --- /dev/null
>>> +++ b/drivers/soc/mediatek/mtk-devapc.h
>>> @@ -0,0 +1,670 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * Copyright (C) 2020 MediaTek Inc.
>>> + */
>>> +
>>> +#ifndef __MTK_DEVAPC_H__
>>> +#define __MTK_DEVAPC_H__
>>> +
>>> +#define PFX			"[DEVAPC]: "
>>
>> use dev_err() and friends instead.
> 
> Okay, I'll remove it.
> 
>>
>>> +
>>> +#define VIO_MASK_STA_REG_GET(m) \
>>> +({ \
>>> +	typeof(m) (_m) = (m); \
>>> +	reg_index = _m / 32; \
>>> +	reg_offset = _m % 32; \
>>> +})
>>
>> don't do that. no explicit variable assingment in a macro, the macro should
>> return the value.
> 
> Okay, I'll revise it in next patches.
> 
>>
>>> +
>>> +enum DEVAPC_PD_REG_TYPE {
>>> +	VIO_MASK = 0,
>>> +	VIO_STA,
>>> +	VIO_DBG0,
>>> +	VIO_DBG1,
>>> +	APC_CON,
>>> +	VIO_SHIFT_STA,
>>> +	VIO_SHIFT_SEL,
>>> +	VIO_SHIFT_CON,
>>> +	PD_REG_TYPE_NUM,
>>> +};
>>> +
>>> +enum DEVAPC_VIO_DBGS_TYPE {
>>> +	MSTID = 0,
>>> +	DMNID,
>>> +	VIO_W,
>>> +	VIO_R,
>>> +	ADDR_H,
>>> +};
>>> +
>>> +struct mtk_device_info {
>>> +	int sys_index;
>>> +	int ctrl_index;
>>> +	int vio_index;
>>> +};
>>> +
>>> +static struct mtk_device_info mtk_devices_infra[] = {
>>
>> That's for mt6779, correct? Should be stated in the name.
> 
> Okay. I have another way to reach the goal without using this struct
> array. I'll send another patches.
> 

[...]

>>> +
>>> +struct mtk_devapc_vio_info {
>>> +	bool read;
>>> +	bool write;
>>> +	u32 vio_addr;
>>> +	u32 vio_addr_high;
>>> +	u32 master_id;
>>> +	u32 domain_id;
>>> +};
>>> +
>>> +struct mtk_devapc_vio_dbgs_desc {
>>> +	u32 mask;
>>> +	u32 start_bit;
>>> +};
>>> +
>>> +struct mtk_devapc_context {
>>> +	u8 slave_type_num;
>>> +	void __iomem **devapc_pd_base;
>>> +	const struct mtk_device_info **device_info;
>>> +	struct mtk_devapc_vio_info *vio_info;
>>> +	struct mtk_devapc_vio_dbgs_desc *vio_dbgs_desc;
>>> +	u32 *pds_offset;
>>> +};
>>> +
>>
>> Not sure if I get this right:
>>
>> struct mtk_devapc_offset {
>> 	u32 vio_mask;
>> 	u32 vio_sta;
>> 	u32 vio_dbg0;
>> 	u32 vio_dbg1;
>> 	...
>> }
>>
>> struct mtk_devapc_context {
>> 	u8 pd_base_num;
>> 	void __iomem **devapc_pd_base;
>> 	struct mtk_devapc_offset *offset;
>> 	const struct mtk_device_info **device_info;
>> 	struct mtk_devapc_vio_info *vio_info;
>> 	struct mtk_devapc_vio_dbgs_desc *vio_dbgs_desc;
>> };
>>
>> With this I think we can get rid of mtk_devapc_pd_get().
>>
> 
> mtk_devapc_pd_get() is used to calculate the vaddr of devapc pd
> register. It's based on different slave_type, pd_reg_type and reg_idx.
> I don't think it can be replaced with such simple data structures.
> 

How I understand the code:
Every slave_type has a base memory represented by the **devapc_pd_base array.
Inside each base memory chunk you have an offset depending on the pd_reg_type, 
but the offset is the same for all base memory chunks. This offset is 
represented by struct mtk_devapc_offset.
If pd_reg_type is VIO_MASK or VIO_STA we have to further read the value based on 
an index represented by reg_idx. So if we  add 0x4 for each reg_idx. So we have 
for example for:
int check_vio_mask(struct mtk_devapc_context *ctx, inst slave_type, u32 module)
{
	reg = ctx->devapc_pd_base[slave_type] + ctx->offset.vio_mask;
	reg += 0x4 * VIO_MOD_TO_REG_IND(module);

	value = readl(reg);
	return ((value >> VIO_TO_REG_OFF(module)) & 0x1);
}

similarly:
u32 get_shift_group(struct mtk_devapc_context *ctx, int slave_type, int vio_idx)
{
	reg = ctx->devapc_pd_base[slave_type] + ctx->offset.vio_shift_sta;

	value = readl(reg);
	bit = __ffs(...);
}

What does us buy that? When looking on the function we understand how the 
register layout in HW looks like. We have a base value with an offset and in 
case of VIO_MASK and VIO_STA we have to shift the value.

By the way, right now in mtk_devapc_pd_get you are doing pointer arithmetic with 
a void pointer. That's not a good approach, please define the pointer to point 
to the value you want to read. I understand that's a 32 bit register.

Regards
Matthias

> 
>> Sorry I'm not able to review the whole driver right now. Please also have a look
>> on my comments from v1.
>>
>> We will have to go little by little to get this into a good state. In case it
>> makes sense to have this in the kernel at all.
>>
>> Regards,
>> Matthias
> 
> I'm appreciated for your review. It helps me to write better code and
> get closer to the kernel.
> 
> 
