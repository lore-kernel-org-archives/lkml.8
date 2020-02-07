Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74678C352A3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BF852082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xxefUEoJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgBGKgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:36:25 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44979 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgBGKgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:36:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id m16so1997882wrx.11
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 02:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sn5h5DpGbd8+ZmTL8RoxDdNLMcTt2Q/GmoXxRFRhYZ4=;
        b=xxefUEoJ55N2q6kJa5HQBj15P61j2yMGG17XMWMMEmgTH1f/4klD4aNsN1sBXI82lF
         qDuqPNIC2EzNseh100O8cRxpiXhcmJDpDh+JAYjhH8Zswb4vSgNj40x5gw67rOGpB4Zk
         jCDZ/e/9dBvCkOI87A4DSSRSOHpktR+qIZNKmvegzplgJDrp1XhX+uFIZ9Qobt0uxjJp
         SlhBztEWSyDgCekgExzQkrYdXaL/OQ76oZZmThPqacnX8p9P/adh0somG3Rpi4J5uho5
         ZPdcvd2Hxo3+KRtpRAkoKOVQHCavj2iCjNQ7iiScADUDAz+MW+dv/cr9UzvRuHQNxSOo
         tTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sn5h5DpGbd8+ZmTL8RoxDdNLMcTt2Q/GmoXxRFRhYZ4=;
        b=sKOls4E2Q/jlRGmiDX2cgIUtnFeFtr9XvnZ79kwQG1o8qwaXAgK+DVWtDoyiA8tcZO
         stLwZY8/FQyWmwuFOTyT26wsLbWPivfwLNci/wfPGp5D5mOXRjfUNwl6tn8E2O5Zwb3B
         fSRn8oi72y7RAG0MVacfEcjK2x+DZEIgGe3FY2DvSlpuZhtsX03PGFYlPmpM7q3qevVr
         aYER1ORGWefNO5+JNj2d009/TMnQaOrfqBp6mIT6DCXDd+IHUjTYF9Qd5i/iI9+4RiqI
         53+Z8m6Fce9dAdvR5mLDsrpmLX8sYqXyWHtZ5Ab7Xw1al8KHs9aFXZXGGRm3Qj8dDSG+
         iaVg==
X-Gm-Message-State: APjAAAUCqyWIuDbcf242ecow3Ps3TfP3KfXH4KuRXBVrSWCG1TVQLYIg
        fnmL7ZfIfyq085jfdEnnjKLpiw==
X-Google-Smtp-Source: APXvYqwX0rfF4tDD9dKkruRXKTI/i+SuzeYV0gAc0ED0XkpRqN+W0PcRXINPtXXany8omDCEQEDm4Q==
X-Received: by 2002:a05:6000:50:: with SMTP id k16mr3835414wrx.145.1581071781853;
        Fri, 07 Feb 2020 02:36:21 -0800 (PST)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id i3sm3109938wrc.6.2020.02.07.02.36.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 02:36:21 -0800 (PST)
Subject: Re: [PATCH v4 09/18] usb: dwc3: qcom: Override VBUS when using
 gpio_usb_connector
To:     Jack Pham <jackp@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, balbi@kernel.org,
        bjorn.andersson@linaro.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Manu Gautam <mgautam@codeaurora.org>
References: <20200207015907.242991-1-bryan.odonoghue@linaro.org>
 <20200207015907.242991-10-bryan.odonoghue@linaro.org>
 <20200207080729.GA30341@jackp-linux.qualcomm.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <2bd67925-14cf-5851-14a2-c51a065fac6c@linaro.org>
Date:   Fri, 7 Feb 2020 10:36:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200207080729.GA30341@jackp-linux.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2020 08:07, Jack Pham wrote:
> Hi Bryan,
> 
> On Fri, Feb 07, 2020 at 01:58:58AM +0000, Bryan O'Donoghue wrote:
>> Using the gpio_usb_connector driver also means that we are not supplying
>> VBUS via the SoC but by an external PMIC directly.
>>
>> This patch searches for a gpio_usb_connector as a child node of the core
>> DWC3 block and if found switches on the VBUS over-ride, leaving it up to
>> the role-switching code in gpio-usb-connector to switch off and on VBUS.
>   
> <snip>
> 
>>   static int dwc3_qcom_probe(struct platform_device *pdev)
>>   {
>>   	struct device_node	*np = pdev->dev.of_node;
>> @@ -557,7 +572,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>>   	struct dwc3_qcom	*qcom;
>>   	struct resource		*res, *parent_res = NULL;
>>   	int			ret, i;
>> -	bool			ignore_pipe_clk;
>> +	bool			ignore_pipe_clk, gpio_usb_conn;
>>   
>>   	qcom = devm_kzalloc(&pdev->dev, sizeof(*qcom), GFP_KERNEL);
>>   	if (!qcom)
>> @@ -649,9 +664,10 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>>   	}
>>   
>>   	qcom->mode = usb_get_dr_mode(&qcom->dwc3->dev);
>> +	gpio_usb_conn = dwc3_qcom_find_gpio_usb_connector(qcom->dwc3);
>>   
>> -	/* enable vbus override for device mode */
>> -	if (qcom->mode == USB_DR_MODE_PERIPHERAL)
>> +	/* enable vbus override for device mode or GPIO USB connector mode */
>> +	if (qcom->mode == USB_DR_MODE_PERIPHERAL || gpio_usb_conn)
>>   		dwc3_qcom_vbus_overrride_enable(qcom, true);
> 
> This doesn't seem right. It looks like you are doing the vbus_override
> only once on probe() and keeping it that way regardless of the dynamic
> state of the connector, i.e. even after VBUS is physically removed
> and/or ID pin is low.
> 

Hmm, I don't see anything much in the documentation that flags why we 
want or need to toggle this.

>>   	/* register extcon to override sw_vbus on Vbus change later */
> 
> As suggested by this comment, if you look at the extcon handling, it
> intercepts the VBUS state toggling in dwc3_qcom_vbus_notifier() and
> calls vbus_override() accordingly. That way it should only be true when
> the role==USB_ROLE_DEVICE and disabled otherwise (USB_ROLE_HOST/NONE).
> 
> To me the gpio-b connector + usb-role-switch is attempting to be an
> alternative to extcon. But to correctly mimic the vbus_override()
> behavior I think we need a way to intercept when the connector child
> driver calls usb_role_switch_set_role() to the dwc3 device, but somehow
> be able to do it from up here in the parent/glue layer. Unfortunately I
> don't have a good idea of how to do that, short of shoehorning an
> "upcall" notification from drd.c to the glue, something I don't think
> Felipe would be a fan of.
> 
> Could the usb_role_switch class somehow be enhanced to support chaining
> multiple "consumers" to support this case? Such that when the gpio-b
> driver calls set_role() it could get handled both by drd.c and
> dwc3-qcom.c?

It is probably necessary eventually, but, per my reading of the 
documents and working with the hardware, I couldn't justify the 
additional work.

However if you think this patchset needs the toggle, I can look into 
getting the indicator to toggle here too.

We'd need to add some sort of linked list of notifiers to the role 
switching logic and toggle them in order.

Similar to what is done in extcon now for the various notifer hooks.

---
bod
