Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B111EC3524B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 03:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85D112080D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 03:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g2nWaVqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbgBDDKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 22:10:31 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51697 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726924AbgBDDKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 22:10:30 -0500
Received: by mail-wm1-f68.google.com with SMTP id t23so1602628wmi.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 19:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yT0IgHPsW5g8ur4OimAHbgZfgffCfBRYN8ASv6hPxKg=;
        b=g2nWaVqPAYAcEdiBTzCax9T9uYw7qE1Y+YmU7HqWncxCDCQUNJPEuqVFK6+3CTf1x4
         2M6YVLcFf4wi1RQAtNMuWibYXZvMixLAIF41b75U1gcQDnQW8XjrsmFONWiKNTVhaOyP
         cKHQL+3qfreVMQR2JepT5byEmSH5+RULtDOga7kNnxAmYmqPO0Wvl//bJVzd8tDfhrqo
         AO5z6C/ObQ62bIVb+FVWeCH2tcVxbM9PTJ/25cPTGKbONCUmhaX+UarTmem7MNUFLP4P
         Ci18lLLTRIsyHDFaw5meXPfsbuAooy6MbU/WlFiWrrd0ssmzLPP8J8swNENJgzRuJhbt
         IiTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yT0IgHPsW5g8ur4OimAHbgZfgffCfBRYN8ASv6hPxKg=;
        b=ORDrbZ17YlYuQlQFRi+8yLXgPqUe87NqA/1JL164vQ+mqtpmVQJWonp0+ZpQ2dSWxD
         lgnSloaAe6/p2Qdhgc/6jrwLkMzfnWnuVGMTQMeU0sTOt40OjxOQmr8HUF6qE+VhYEtc
         Db25au9kmutz+3DXoecN24Ed6E5GNqD3YY0bvI2U3uzVEfwlwcKOH5pUojx06nFUa9vg
         q0eCaUlNL6dkVKVv31yid27zXnVC7OfUad3ZU/msXP+rzSk4QNR+gEr2YnIs/0LYEb1p
         GXKS9v2klnklh5cnXls1tu2J4fnsp/9b+Bv4Ol9SLyzrBK2E+OwEqt/m4J+SVyaOLwJY
         3tvw==
X-Gm-Message-State: APjAAAXnRq6B5sn4YN4wslrhwDH+qoV9V2waAnt9l4BapH3+HLUUj0Je
        3n5wbSlj7KcH+3KLOakkJvcgwg==
X-Google-Smtp-Source: APXvYqwy3uFhqzHsHZsT0Oi406B8+nMO5cCRUWUlW0U7SYrZreocKAM0+mv9L6fc4kzkRSsZNNI4ag==
X-Received: by 2002:a7b:ce84:: with SMTP id q4mr2428082wmj.57.1580785827826;
        Mon, 03 Feb 2020 19:10:27 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id z3sm11018098wrs.32.2020.02.03.19.10.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Feb 2020 19:10:27 -0800 (PST)
Subject: Re: [PATCH v4 2/2] Embedded USB Debugger (EUD) driver
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Avaneesh Kumar Dwivedi <akdwived@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ckadabi@codeaurora.org, tsoni@codeaurora.org,
        bryanh@codeaurora.org, psodagud@codeaurora.org,
        rnayak@codeaurora.org, satyap@codeaurora.org,
        pheragu@codeaurora.org
References: <1580445811-15948-1-git-send-email-akdwived@codeaurora.org>
 <1580445811-15948-3-git-send-email-akdwived@codeaurora.org>
 <20200203193533.GL3948@builder>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <5008a446-a90c-b68a-aaa4-3e7cd90418fa@linaro.org>
Date:   Tue, 4 Feb 2020 03:10:30 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200203193533.GL3948@builder>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/2020 19:35, Bjorn Andersson wrote:
> On Thu 30 Jan 20:43 PST 2020, Avaneesh Kumar Dwivedi wrote:

Hi Avaneesh.

> Please aim for keeping the sort order in this file (ignore QCOM_APR
> which obviously is in the wrong place)
> 
>> +       tristate "QTI Embedded USB Debugger (EUD)"
>> +       depends on ARCH_QCOM

If we persist with the model of EXTCON you should "select EXTCON" here.

>> +       help
>> +         The Embedded USB Debugger (EUD) driver is a driver for the
>> +         control peripheral which waits on events like USB attach/detach
>> +         and charger enable/disable. The control peripheral further helps
>> +         support the USB-based debug and trace capabilities.
>> +         This module enables support for Qualcomm Technologies, Inc.
>> +         Embedded USB Debugger (EUD).

Suggest.

This module enables support for Qualcomm Technologies, Inc.
Embedded USB Debugger (EUD).
The EUD is a control peripheral which reports VBUS attach/detach, 
charger enable/disable and USB-based debug and trace capabilities.


>> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.

2020

>> +
>> +static int enable_eud(struct eud_chip *priv)
>> +{
>> +	int ret;
>> +
>> +	/* write into CSR to enable EUD */
>> +	writel_relaxed(BIT(0), priv->eud_reg_base + EUD_REG_CSR_EUD_EN);
>> +	/* Enable vbus, chgr & safe mode warning interrupts */
>> +	writel_relaxed(EUD_INT_VBUS | EUD_INT_CHGR | EUD_INT_SAFE_MODE,
>> +			priv->eud_reg_base + EUD_REG_INT1_EN_MASK);
>> +
>> +	/* Ensure Register Writes Complete */

So... You are writing a register in an on-chip PMIC. The PMIC is 
responsible for detecting USB ID and supplying VBUS as appropriate.

You then get an interrupt to inform you of the state ?

>> +static ssize_t enable_store(struct device *dev,
>> +				struct device_attribute *attr,
>> +				const char *buf, size_t count)
>> +{
>> +	struct eud_chip *chip = dev_get_drvdata(dev);
>> +	int enable = 0;
> 
> You shouldn't need to initialize this as you're checking the return
> value of sscanf().
> 
>> +	int ret = 0;
>> +
>> +	if (sscanf(buf, "%du", &enable) != 1)
>> +		return -EINVAL;
>> +
>> +	if (enable == EUD_ENABLE_CMD)
>> +		ret = enable_eud(chip);
> 
> If ret is !0 you should probably return that, rather than count...
> 
>> +	else if (enable == EUD_DISABLE_CMD)
>> +		disable_eud(chip);
>> +	if (!ret)
> 
> ...and then you don't need this check, or initialize ret to 0 above.
> 
>> +		chip->enable = enable;
> 
> So if I write 42 to "enable" nothing will change in the hardware, but
> chip->enable will be 42...
> 
>> +	return count;
>> +}

I was just going to comment on usb_connector but, does the above code 
need a synchronization primitive to serialize with the worker and 
interrupt handler ?

>> +static int msm_eud_probe(struct platform_device *pdev)
>> +{
>> +	struct eud_chip *chip;
>> +	struct resource *res;
>> +	int ret;
>> +
>> +	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
>> +	if (!chip)
>> +		return -ENOMEM;
>> +
>> +	chip->dev = &pdev->dev;
>> +	platform_set_drvdata(pdev, chip);
>> +
>> +	chip->extcon = devm_extcon_dev_allocate(&pdev->dev, eud_extcon_cable);
> 
> Aren't we moving away from extcon in favor of the usb role switching
> thing?

Yes.

For the VBUS notification you could use

usb-role-switch and model the USB connector as a child-node of the 
dual-role controller.

See:
https://patchwork.kernel.org/cover/11346247/
https://patchwork.kernel.org/patch/11346295/
https://patchwork.kernel.org/patch/11346263/

Avaneesh do you have any kernel code that cares about the charger state ?

What we are suggesting here is dropping extcon and using role-switching 
but, if you have some other code that cares about EXTCON_CHG_USB_SDP 
you'd have to do additional work.

But, if I understood the implication of the code above where you write 
to the PMIC and let it handle VBUS/CHARGER on/off and you are just 
notified of the state change, you should be fine with usb-role-switching.

---
bod
