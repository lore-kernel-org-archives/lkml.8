Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B48C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13C332074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VUbnjfJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgEOLJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725986AbgEOLJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:09:35 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3498C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:09:34 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f13so1879585wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 04:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hU4RTTVJqYFao+vNIgki4XYZLADMVoRbbsBZOtdWM70=;
        b=VUbnjfJ8GAd9sHHSjFTEpwUWvltDSv9Ji39Er89ZZS021bjeWYgqwdc8Q9NxVkdvRg
         wjdBvHMnumSOZn1KFFpOrXYe784b8RTVWtSz+xMTN4hOarBNFj0XNurckn/wLFE80a2i
         g0x+5FXlrsuJCEAQ62mnb5k1YPBij3RWHPZPCSQJFccj7KF2FLk+vaFrRPimI0O9dj2H
         nqWnehgNPPNojFn6NbJLdrzNSUhwRB7ec5qrWD3LYPa+6FzyVXPO/f8SDRA6g2tjSjnA
         DJ1w+C81a5/k8wSf0s9XRSYoE6wjtGjsgIjLyH05U9M1y+UPAaj+Cht8SS2GnuRlAGdt
         8l0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hU4RTTVJqYFao+vNIgki4XYZLADMVoRbbsBZOtdWM70=;
        b=eVr/Pm7N+D9MAcM6MRDUBkeKSKo2cN9DM6pDa85SJ00cF6BH72RTZgRhMqB7SnDo3s
         56iOM6erEIhWiK4toAjbL2VA8sm5iFoAyRTwloJ5TTwaJpJsHqU+X3H2AyQyuGOoaOD/
         +4TojNe8VabERdSVKlY9R5sU8748wcBTrSlaWB/MLggAD/oPZd8mDhsHJibTBLslAAOq
         TK5724NK+ujCaZ/R/6ZC7nUURZwiJ+rd5ZmMpqBnpAuFI1d4xP67url3gXXs2K+I3oyV
         4YnAxNC9Q0hAHZvIpfAF/niA4bWwk/vIArDcRXUV1mvk6nMChNb/A2ze1JCpwICKUmmK
         rGTg==
X-Gm-Message-State: AOAM531hIzHWilAgR5GZkjG1Ivxzn5uU+0ERaFIKCy6jeMcQvaRBs5kC
        T78tib49u2SkLH2E7M3iRMCZlA==
X-Google-Smtp-Source: ABdhPJwV6O7TSTyFAmue40BZYsnpyRRhiv+5XIq1bFkQ93GuH3W4+gPVB5p+LK4H+2skc3x4orVUhw==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr3526236wmj.100.1589540973078;
        Fri, 15 May 2020 04:09:33 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h27sm3610046wrc.46.2020.05.15.04.09.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 May 2020 04:09:32 -0700 (PDT)
Subject: Re: [RFC v1 2/3] drivers: nvmem: Add driver for QTI qfprom-efuse
 support
To:     "Ravi Kumar Bokka (Temp)" <rbokka@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        rnayak@codeaurora.org, saiprakash.ranjan@codeaurora.org,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org, dianders@chromium.org
References: <1589307480-27508-1-git-send-email-rbokka@codeaurora.org>
 <1589307480-27508-3-git-send-email-rbokka@codeaurora.org>
 <ffaccce7-95c0-2f95-ad3b-55f1da42eaee@linaro.org>
 <14e1fa51-066c-6e1b-01a4-2103612de9e9@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d5902226-21b3-7941-6405-688d7a115142@linaro.org>
Date:   Fri, 15 May 2020 12:09:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <14e1fa51-066c-6e1b-01a4-2103612de9e9@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/05/2020 13:26, Ravi Kumar Bokka (Temp) wrote:
> Hi Srinivas,
> Thanks for your feedback by giving review comments. Please find my 
> inline comments.
> 
> 
> Regards,
> Ravi Kumar.B
> 
> On 5/13/2020 6:50 PM, Srinivas Kandagatla wrote:
>>
>>
>> On 12/05/2020 19:17, Ravi Kumar Bokka wrote:
>>> This patch adds new driver for QTI qfprom-efuse controller. This 
>>> driver can
>>> access the raw qfprom regions for fuse blowing.
>>
>> QTI?
> 
> guidance I have received from internal Legal/LOST team is that the QCOM 
> prefix needs to be changed to QTI everywhere it is used
> 

I dont mind this in comments or patch subject line but the valid vendor 
prefix for Qualcomm is "qcom".


>>
>>>
>>> The current existed qfprom driver is only supports for cpufreq, 
>>> thermal sensors
>>> drivers by read out calibration data, speed bins..etc which is stored
>>> by qfprom efuses.
>>
>> Can you explain bit more about this QFPROM instance, Is this QFPROM 
>> part of secure controller address space?
>> Is this closely tied to SoC or Secure controller version?
>>
>> Any reason why this can not be integrated into qfprom driver with 
>> specific compatible.
>>
> 
> QFPROM driver communicates with sec_controller address space however 
> scope and functionalities of this driver is different and not limited as 
> existing qfprom fuse Read-Only driver for specific “fuse buckets’ like 
> cpufreq, thermal sensors etc. QFPROM fuse write driver in this patch 
> requires specific sequence to write/blow fuses unlike other driver. 
> Scope/functionalities are different and this is separate driver.
> 

This is another variant of qfprom, so please add this support in the 
existing qfprom driver, you could deal with the differences using 
specific compatible within the driver.

Doug already covered most of the comments, consider them as mandatory 
requirements for upstreaming!

--srini


>>>
>>> Signed-off-by: Ravi Kumar Bokka <rbokka@codeaurora.org>
>>> ---
>>>   drivers/nvmem/Kconfig        |  10 +
>>>   drivers/nvmem/Makefile       |   2 +
>>>   drivers/nvmem/qfprom-efuse.c | 476 
>>> +++++++++++++++++++++++++++++++++++++++++++
>>>   3 files changed, 488 insertions(+)
>>>   create mode 100644 drivers/nvmem/qfprom-efuse.c
>>>
>> ...
>>
>>> diff --git a/drivers/nvmem/qfprom-efuse.c b/drivers/nvmem/qfprom-efuse.c
>>> new file mode 100644
>>> index 0000000..2e3c275
>>> --- /dev/null
>>> +++ b/drivers/nvmem/qfprom-efuse.c
>>> @@ -0,0 +1,476 @@
>>> +// SPDX-License-Identifier: GPL-2.0-only
>>> +/*
>>> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/device.h>
>>> +#include <linux/io.h>
>>> +#include <linux/iopoll.h>
>>> +#include <linux/kernel.h>
>>> +#include <linux/module.h>
>>> +#include <linux/mod_devicetable.h>
>>> +#include <linux/nvmem-provider.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/regulator/consumer.h>
>>> +
>>> +#define QFPROM_BLOW_STATUS_BUSY 0x1
>>> +#define QFPROM_BLOW_STATUS_READY 0x0
>>> +
>>> +/* Blow timer clock frequency in Mhz for 10nm LPe technology */
>>> +#define QFPROM_BLOW_TIMER_OFFSET 0x03c
>>> +#define QFPROM_BLOW_TIMER_RESET_VALUE 0x0
>>> +
>>> +/* Amount of time required to hold charge to blow fuse in 
>>> micro-seconds */
>>> +#define QFPROM_FUSE_BLOW_POLL_PERIOD 100
>>> +#define QFPROM_BLOW_STATUS_OFFSET 0x048
>>> +
>>> +#define QFPROM_ACCEL_OFFSET 0x044
>>> +
>>> +/**
>>> + * struct qfprom_efuse_platform_data - structure holding qfprom-efuse
>>> + * platform data
>>> + *
>>> + * @name: qfprom-efuse compatible name
>>
>> ??
> 
> Thanks for your feedback. I will address this change
> 
>>> + * @fuse_blow_time_in_us: Should contain the wait time when doing 
>>> the fuse blow
>>> + * @accel_value: Should contain qfprom accel value
>>> + * @accel_reset_value: The reset value of qfprom accel value
>>> + * @qfprom_blow_timer_value: The timer value of qfprom when doing 
>>> efuse blow
>>> + * @qfprom_blow_reset_freq: The frequency required to set when fuse 
>>> blowing
>>> + * is done
>>> + * @qfprom_blow_set_freq: The frequency required to set when we 
>>> start the
>>> + * fuse blowing
>>> + * @qfprom_max_vol: max voltage required to set fuse blow
>>> + * @qfprom_min_vol: min voltage required to set fuse blow
>>
>> How specific are these values per SoC?
>>
> 
> This voltage level may change based on SoC and/or fuse-hardware 
> technology, it would change for SoC with different technology, hence we 
> have kept it in SOC specific settings.
> 
>>
>>> + */
>>> +struct qfprom_efuse_platform_data {
>>> +    const char *name;
>>> +    u8 fuse_blow_time_in_us;
>>> +    u32 accel_value;
>>> +    u32 accel_reset_value;
>>> +    u32 qfprom_blow_timer_value;
>>> +    u32 qfprom_blow_reset_freq;
>>> +    u32 qfprom_blow_set_freq;
>>> +    u32 qfprom_max_vol;
>>> +    u32 qfprom_min_vol;
>>> +};
>>> +
>>> +/**
>>> + * struct qfprom_efuse_priv - structure holding qfprom-efuse attributes
>>> + *
>>> + * @qfpbase: iomapped memory space for qfprom base
>>> + * @qfpraw: iomapped memory space for qfprom raw fuse region
>>> + * @qfpmap: iomapped memory space for qfprom fuse blow timer
>>> +
>>> + * @dev: qfprom device structure
>>> + * @secclk: clock supply
>>> + * @vcc: regulator supply
>>> +
>>> + * @qfpraw_start: qfprom raw fuse start region
>>> + * @qfpraw_end: qfprom raw fuse end region
>>> + * @qfprom_efuse_platform_data: qfprom platform data
>>> + */
>>> +struct qfprom_efuse_priv {
>>> +    void __iomem *qfpbase;
>>> +    void __iomem *qfpraw;
>>> +    void __iomem *qfpmap;
>>
>> Why are these memory regions split? Can't you just have complete 
>> qfprom area and add fixed offset for qfpraw within the driver?
>>
> 
> Thanks for your feedback. I will address this change.
> I have separated this memory regions because to identify raw fuse 
> regions separately and compare these raw fuse regions from the user 
> given input.
> 
>>> +    struct device *dev;
>>> +    struct clk *secclk;
>>> +    struct regulator *vcc;
>>> +    resource_size_t qfpraw_start;
>>> +    resource_size_t qfpraw_end;
>> Why do we need to check this range? as long as we set the nvmem_config 
>> with correct range then you should not need this check.
>>
> 
> There is no harm in this explicit check in QFPROM-fuse driver and based 
> on internal review with our security team, this check is important to 
> avoid dependency on other upper layer.
> 
> 
>>
>>> +    struct qfprom_efuse_platform_data efuse;
>> A pointer here should be good enough?
>>> +};
>>> +
>>
> 
> Thanks for your feedback. I will address this change
> 
>> ...
>>
>>> +/*
>>> + * sets the value of the blow timer, accel register and the clock
>>> + * and voltage settings
>>> + */
>>> +static int qfprom_enable_fuse_blowing(const struct qfprom_efuse_priv 
>>> *priv)
>>> +{
>>> +    int ret;
>>> +
>>> +    ret = qfprom_disable_fuse_blowing(priv);
>>> +    if (ret) {
>>> +        dev_err(priv->dev, "qfprom_disable_fuse_blowing()\n");
>>> +        return ret;
>>> +    }
>>
>> Why do we need to qfprom_disable_fuse_blowing() for every call to 
>> enable it?
>>
>> Or are we missing some error handling in the caller?
>>
> 
> We must disable/vote-off this QFPROM fuse power rail after blowing fuse, 
> it is the safe and right approach as per hardware programming guide for 
> fuse blowing process. Caller here is user space, can’t control 
> fuse-power-rail or can’t be relied to follow the required process. There 
> could also be unnecessary risk of leaving the vote/power-rail configured 
> at specific level after blowing the fuse. As per hardware requirement, 
> right after fuse blowing, we need to disable power rail.
> 
>>> +
>>> +    writel(priv->efuse.qfprom_blow_timer_value, priv->qfpmap +
>>> +           QFPROM_BLOW_TIMER_OFFSET);
>>> +    writel(priv->efuse.accel_value, priv->qfpmap + 
>>> QFPROM_ACCEL_OFFSET);
>>> +
>>> +    ret = qfprom_set_clock_settings(priv);
>>> +    if (ret) {
>>> +        dev_err(priv->dev, "qpfrom_set_clock_settings()\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    ret = qfprom_set_voltage_settings(priv, priv->efuse.qfprom_min_vol,
>>> +                      priv->efuse.qfprom_max_vol);
>>> +    if (ret) {
>>> +        dev_err(priv->dev, "qfprom_set_voltage_settings()\n");
>>> +        return ret;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>
>> <<
>>> +/*
>>> + * verifying to make sure address being written or read is from qfprom
>>> + * raw address range
>>> + */
>>> +bool addr_in_qfprom_range(const struct qfprom_efuse_priv *priv, u32 
>>> reg,
>>> +              size_t bytes)
>>> +{
>>> +    if (((reg + bytes) > reg) && (reg >= priv->qfpraw_start) &&
>>> +        ((reg + bytes) <= priv->qfpraw_end)) {
>>> +        return 1;
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>  >>
>> Above function is totally redundant, nvmem core already has checks for 
>> this.
>>
> 
> There is no harm in this explicit check in QFPROM-fuse driver and based 
> on internal review with our security team, this check is important to 
> avoid dependency on other upper layer.
> 
>>
>>
>>> +
>>> +/*
>>> + * API for reading from raw qfprom region
>>> + */
>>> +static int qfprom_efuse_reg_read(void *context, unsigned int reg, 
>>> void *_val,
>>> +                 size_t bytes)
>>> +{
>>> +    struct qfprom_efuse_priv *priv = context;
>>> +    u32 *value = _val;
>>> +    u32 align_check;
>>> +    int i = 0, words = bytes / 4;
>>> +
>>> +    dev_info(priv->dev,
>>> +         "reading raw qfprom region offset: 0x%08x of size: %zd\n",
>>> +         reg, bytes);
>>
>> In general there is lot of debug info across the code, do you really 
>> need all this? Consider removing these!
>>
> 
> Thanks for your feedback. I will address this change.
> 
>>> +
>>> +    if (bytes % 4 != 0x00) {
>>> +        dev_err(priv->dev,
>>> +            "Bytes: %zd to read should be word align\n",
>>> +            bytes);
>>> +        return -EINVAL;
>>> +    }
>>
>> This word align check is also redundant once you set nvmem_config with 
>> correct word_size.
>>
> 
> I understand that there may be different approach to handle this. We 
> have used this approach and tested this driver thoroughly. Unless there 
> is technical limitation, changing this word_size would end up requiring 
> re-writing write/read APIs and going through testing again, there is not 
> much difference in either approach, we would like to keep this approach 
> unless there is technical concern.
> 
>>
>>> +
>>> +    if (!addr_in_qfprom_range(priv, reg, bytes)) {
>>> +        dev_err(priv->dev,
>>> +            "Invalid qfprom raw region offset 0x%08x & bytes %zd\n",
>>> +            reg, bytes);
>>> +        return -EINVAL;
>>> +    }
>>> +
>>> +    align_check = (reg & 0xF);
>>> +
>>> +    if (((align_check & ~3) == align_check) && value != NULL)
>>> +        while (words--)
>>> +            *value++ = readl(priv->qfpbase + reg + (i++ * 4));
>>> +
>>> +    else
>>> +        dev_err(priv->dev,
>>> +            "Invalid input parameter 0x%08x fuse blow address\n",
>>> +            reg);
>>> +
>>> +    return 0;
>>> +}
>> ...
>>
>>> +
>>> +static int qfprom_efuse_probe(struct platform_device *pdev)
>>> +{
>>> +    struct device *dev = &pdev->dev;
>>> +    struct resource *qfpbase, *qfpraw, *qfpmap;
>>> +    struct nvmem_device *nvmem;
>>> +    struct nvmem_config *econfig;
>>> +    struct qfprom_efuse_priv *priv;
>>> +    const struct qfprom_efuse_platform_data *drvdata;
>>> +    int ret;
>>> +
>>> +    dev_info(&pdev->dev, "[%s]: Invoked\n", __func__);
>>> +
>>
>> too much debug!
>>
> 
> Thanks for your feedback. I will address this change.
> 
>>> +    drvdata = of_device_get_match_data(&pdev->dev);
>>> +    if (!drvdata)
>>> +        return -EINVAL;
>> Unnecessary check as this driver will not be probed unless there is a 
>> compatible match.
>>
> 
> Thanks for your feedback. I will address this change.
> 
>>
>>> +
>>> +    priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>>> +    if (!priv)
>>> +        return -ENOMEM;
>>> +
>>> +    priv->efuse.fuse_blow_time_in_us = drvdata->fuse_blow_time_in_us;
>>> +    priv->efuse.accel_value = drvdata->accel_value;
>>> +    priv->efuse.accel_reset_value = drvdata->accel_reset_value;
>>> +    priv->efuse.qfprom_blow_timer_value = 
>>> drvdata->qfprom_blow_timer_value;
>>> +    priv->efuse.qfprom_blow_reset_freq = 
>>> drvdata->qfprom_blow_reset_freq;
>>> +    priv->efuse.qfprom_blow_set_freq = drvdata->qfprom_blow_set_freq;
>>> +    priv->efuse.qfprom_max_vol = drvdata->qfprom_max_vol;
>>> +    priv->efuse.qfprom_min_vol = drvdata->qfprom_min_vol;
>>> +    priv->dev = dev;
>>> +
>>> +    qfpbase = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +
>>> +    priv->qfpbase = devm_ioremap_resource(dev, qfpbase);
>>> +    if (IS_ERR(priv->qfpbase)) {
>>> +        ret = PTR_ERR(priv->qfpbase);
>>> +        goto err;
>>> +    }
>>> +
>>> +    qfpraw = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>> +
>>> +    priv->qfpraw = devm_ioremap_resource(dev, qfpraw);
>>> +    if (IS_ERR(priv->qfpraw)) {
>>> +        ret = PTR_ERR(priv->qfpraw);
>>> +        goto err;
>>> +    }
>>> +
>>> +    priv->qfpraw_start = qfpraw->start - qfpbase->start;
>>> +    priv->qfpraw_end = qfpraw->end - qfpbase->start;
>>> +
>>> +    qfpmap = platform_get_resource(pdev, IORESOURCE_MEM, 2);
>>> +
>>> +    priv->qfpmap = devm_ioremap_resource(dev, qfpmap);
>>> +    if (IS_ERR(priv->qfpmap)) {
>>> +        ret = PTR_ERR(priv->qfpmap);
>>> +        goto err;
>>> +    }
>>> +
>>> +    priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
>>
>> I see no reference to this regulator in dt bindings.
> 
> This perameter kept in board specific file i.e., sc7180-idp.dts file
> 
>>> +    if (IS_ERR(priv->vcc)) {
>>> +        ret = PTR_ERR(priv->vcc);
>>> +        if (ret == -ENODEV)
>>> +            ret = -EPROBE_DEFER;
>> Can you explain what is going on here?
>>
> 
> As i took other drivers reference, i have kept this check.
> 
>>> +
>>> +        goto err;
>>> +    }
>>> +
>>> +    priv->secclk = devm_clk_get(dev, "secclk");
>>> +    if (IS_ERR(priv->secclk)) {
>>> +        ret = PTR_ERR(priv->secclk);
>>> +        if (ret != -EPROBE_DEFER)
>>> +            dev_err(dev, "secclk error getting : %d\n", ret);
>>> +        goto err;
>>> +    }
>>> +
>>> +    ret = clk_prepare_enable(priv->secclk);
>>> +    if (ret) {
>>> +        dev_err(dev, "clk_prepare_enable() failed\n");
>>> +        goto err;
>>> +    }
>>> +
>>> +    econfig = devm_kzalloc(dev, sizeof(*econfig), GFP_KERNEL);
>>> +    if (!econfig)
>> Why not disabling the clk here?
>>> +        return -ENOMEM;
>>
> 
> Thanks for your feedback. I will address this change.
> 
>>> +
>>> +    econfig->dev = dev;
>>> +    econfig->name = "qfprom-efuse";
>>> +    econfig->stride = 1;
>>> +    econfig->word_size = 1;
>>> +    econfig->reg_read = qfprom_efuse_reg_read;
>>> +    econfig->reg_write = qfprom_efuse_reg_write;
>>> +    econfig->size = resource_size(qfpraw);
>>> +    econfig->priv = priv;
>>> +
>>> +    nvmem = devm_nvmem_register(dev, econfig);
>>> +
>>> +    return PTR_ERR_OR_ZERO(nvmem);
>> probably you should check the nvmem here before returning to disable 
>> the clk properly.
>>
> 
> Thanks for your feedback. I will address this change.
> 
>>> +
>>> +err:
>>> +    clk_disable_unprepare(priv->secclk);
>>> +    return ret;
>>> +}
>>> +
>>> +static const struct qfprom_efuse_platform_data sc7180_qfp_efuse_data 
>>> = {
>>> +    .name = "sc7180-qfprom-efuse",
>> Redundant.
>>
> 
> Thanks for your feedback. I will address this change.
> 
>>> +    .fuse_blow_time_in_us = 10,
>>> +    .accel_value = 0xD10,
>>> +    .accel_reset_value = 0x800,
>>> +    .qfprom_blow_timer_value = 25,
>>> +    .qfprom_blow_reset_freq = 19200000,
>>> +    .qfprom_blow_set_freq = 4800000,
>>> +    .qfprom_max_vol = 1904000,
>>> +    .qfprom_min_vol = 1800000,
>>> +};
>>> +
>>> +static const struct of_device_id qfprom_efuse_of_match[] = {
>>> +    {
>>> +        .compatible = "qcom,sc7180-qfprom-efuse",
>>> +        .data = &sc7180_qfp_efuse_data
>>> +    },
>>> +    {/* sentinel */},
>>> +};
>>> +
>>> +MODULE_DEVICE_TABLE(of, qfprom_efuse_of_match);
>>> +
>>> +static struct platform_driver qfprom_efuse_driver = {
>>> +    .probe = qfprom_efuse_probe,
>>> +    .driver = {
>>> +        .name = "sc7180-qfprom-efuse",
>>> +        .of_match_table = qfprom_efuse_of_match,
>>> +    },
>>> +};
>>> +
>>> +module_platform_driver(qfprom_efuse_driver);
>>> +MODULE_DESCRIPTION("QTI QFPROM Efuse driver");
>>> +MODULE_LICENSE("GPL v2");
>>>
> 
