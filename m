Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D340C35250
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53B4122522
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UnkFtEoP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBGVY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 16:24:56 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41840 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbgBGVY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:24:56 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so546329wrw.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 13:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z63nmHRlBmWLm42TGgaeYFUrGEwxVh8/NUBVm4zNBBY=;
        b=UnkFtEoPtv3cND7lEewEyQP0UM1oP9UfH5z42CIQeluCCqWuhqoqakKxsGPiFr4gzM
         T8TYI2CNT4uAJ5B7Pku3n5hY02jhoB1HFyMW1+w3uLN8NN2gI4KnpZDXPtk/p3nfNT+9
         3lenpitfS/UjIw0y6a3gaRxR8KysD/U2e9ESrz/wdKidkvtqQ0gfvgwx4tb9YccBjGPY
         FtaRRbanhmtQJl0KiqWfdiONHnYqJNCXJP0m1YKquzKhhHpoBJPuWj++cAHAvzTLmwqC
         qq5HNi6B65jj0fCY9WoADo6mWpCCGiGf5o6G3H0LnrNy0Fu6SF/FhRc6J+gzS35yhwmt
         n63g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z63nmHRlBmWLm42TGgaeYFUrGEwxVh8/NUBVm4zNBBY=;
        b=Q6wUzlE3HZ501/Nm+ajtRP4v5wyQHOi8peml4FMTc4C7zjXUrnOgCGYMQdKFcxjARB
         cJD6mNmsWdDYZq0jBN5G61aSI6b1E0/w/cKmXlsUW+vPDhDrhDxhklIOeOVlLKh5F/tz
         q0oOmLJDIrOnuJWxCmdbTDDnXu8o0beIX5wzYoLByJBdDqyGIw4AUbAKiHLPj0PzhPFF
         FfFt+orXMP4MsOcN9yw+sZhHWz12KbEusNttKY1xDGdvu91+d0aamT+D4bITrkvRL/OX
         CpvxUUoMe+GxHSBxmEkh7csuerw5L6QxzVfG2q0RCtLl1Pcav1jkgr1se9TUsvi/m5i+
         0oGg==
X-Gm-Message-State: APjAAAVOLuNfbxlQQKcnASE1hiEE8gpGwG5eUH/ouwzGx9TO5h+RBinL
        PVkuz/1bQVXUPOIK+GMSOE49gA==
X-Google-Smtp-Source: APXvYqxhjdrSLmr5eYFYl8KoH8+86JTXvqpPSIgO2DOaDze3FoHSCBDTDC4Y6agRQ/Te8jWRoF2QAQ==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr1019344wrn.29.1581110694446;
        Fri, 07 Feb 2020 13:24:54 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id e6sm4742647wme.3.2020.02.07.13.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 13:24:53 -0800 (PST)
Subject: Re: [PATCH v5 09/18] usb: dwc3: qcom: Add support for usb-conn-gpio
 connectors
To:     Jack Pham <jackp@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20200207201654.641525-1-bryan.odonoghue@linaro.org>
 <20200207201654.641525-10-bryan.odonoghue@linaro.org>
 <20200207204315.GA18464@jackp-linux.qualcomm.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <c1fab2e5-a11d-2f08-92a0-59c075153ed5@linaro.org>
Date:   Fri, 7 Feb 2020 21:24:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207204315.GA18464@jackp-linux.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2020 20:43, Jack Pham wrote:
> Hi Bryan,
> 
> On Fri, Feb 07, 2020 at 08:16:45PM +0000, Bryan O'Donoghue wrote:
>> This patch adds a routine to find a usb-conn-gpio in the main DWC3 code.
>> This will be useful in a subsequent patch where we will reuse the current
>> extcon VBUS notifier with usb-conn-gpio.
>>
>> ---
>>   drivers/usb/dwc3/dwc3-qcom.c | 15 +++++++++++++++
>>   1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
>> index 261af9e38ddd..fc66ca3316ef 100644
>> --- a/drivers/usb/dwc3/dwc3-qcom.c
>> +++ b/drivers/usb/dwc3/dwc3-qcom.c
>> @@ -550,6 +550,21 @@ static const struct dwc3_acpi_pdata sdm845_acpi_pdata = {
>>   	.ss_phy_irq_index = 2
>>   };
>>   
>> +static bool dwc3_qcom_find_gpio_usb_connector(struct platform_device *pdev)
> 
> Why not just squash this patch into "[PATCH v5 12/18] usb: dwc3: qcom:
> Enable gpio-usb-conn based role-switching" where it is actually used?

IMO its best practice to have smaller patches.

This one adds the routine.
12/18 uses the routine but also

- Triggers a notifer role-switch binding
- Adds an if/else for extcon

Believe it or not I had an internal debate about splitting #12 into two 
patches !

---
bod

