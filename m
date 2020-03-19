Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D00AC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:03:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3284C2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zUNj5uWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgCSSDo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:03:44 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37285 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727189AbgCSSDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:03:42 -0400
Received: by mail-ed1-f66.google.com with SMTP id b23so3894618edx.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 11:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XfNpIrjpsRE5Z/i+mEEnL1CN6uH1onpiPIQdClkvN9k=;
        b=zUNj5uWPN3ed1s0ovn/PizQ3gonRKIsiPyOqsCTbOf9n1TWl0o60Agb+4fTV2eoYi0
         zv4fUftei3+7uGNBFN3oHKBi1wCkcIv24/sM5sVKPymgnZxQBtgGeUf86U/4/e8ymNNY
         fo4BiOFuCNG+GbvYzWb8NivNs1ZfLDropeV1j2djud6WRCAQe6wpHXvGlVCSXouAhwH8
         nHeKziNAmqcvtJhC9sQZ3rU8+4Kh1q1RcgHbddGpl6DeuuaDnRcpv5TYYJhYdYPgJqhf
         KifXIkXGlezdB2uknSnll53X9ffy8g8Us1tJCxPRWVta7rqlc9Utvyhbv1zEDaNfodSN
         xSXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XfNpIrjpsRE5Z/i+mEEnL1CN6uH1onpiPIQdClkvN9k=;
        b=N8islhjmI2wVKfwVN9tbM1Q8BUIHIfdahruOZWJ7zq74VcX+X/KN69nbvAqWG5cll7
         TWMaeDYEai9Wl5djZvzM8nses89E0BBxdDBh85jtbohMmgEHrLdWt1yPX2mZVy4h4iW6
         WOqIyE9nunOeUR2Z7JWDx13BsCdwdgi6HMML+WC4SRlgXiY9jhKCOvHNQNJqhLaQXP4R
         t+R/XPtg2pPG74CGGXeqccB2rDb01ETXx8jNlcMEY3AUChro9KXhjRjPMqQSov80ldkp
         b8w6mH/JFSFB1uPyXO2l80rD+uczLHhPpFhuGGmchEbPXs11j/jXvyIsqWMjwCos4WK4
         /tgg==
X-Gm-Message-State: ANhLgQ1sQszlpPeGyM2KxAmnHC/jc2plh1ca/RWr7VgbOD3PzQiuuHP+
        J/49C8yXe/tUphxYUtFV6dmiPA==
X-Google-Smtp-Source: ADFU+vscWLKaOryISlWMAo7HeQrnyWVtnZCYLNMamJ7iFeEAu+BEipdUTnLwPnEstiRldF4p+RNPhA==
X-Received: by 2002:a05:6402:2cd:: with SMTP id b13mr4017272edx.68.1584641019890;
        Thu, 19 Mar 2020 11:03:39 -0700 (PDT)
Received: from [192.168.0.38] ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id ny24sm184082ejb.50.2020.03.19.11.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 11:03:38 -0700 (PDT)
Subject: Re: [PATCH 2/7] dt-bindings: usb: dwc3: Add a gpio-usb-connector
 example
To:     Stephen Boyd <swboyd@chromium.org>, balbi@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, jackp@codeaurora.org, robh@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
References: <20200311191501.8165-1-bryan.odonoghue@linaro.org>
 <20200311191501.8165-3-bryan.odonoghue@linaro.org>
 <158458013177.152100.17920784952083533825@swboyd.mtv.corp.google.com>
 <aa6aa234-e2d1-bdcd-0f0e-64b2a7e497d3@linaro.org>
 <158463604559.152100.9219030962819234620@swboyd.mtv.corp.google.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Message-ID: <f6e948cb-7d3f-72b6-b153-58afb1304c49@linaro.org>
Date:   Thu, 19 Mar 2020 18:03:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <158463604559.152100.9219030962819234620@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/2020 16:40, Stephen Boyd wrote:
> Quoting Bryan O'Donoghue (2020-03-19 08:22:14)
>> On 19/03/2020 01:08, Stephen Boyd wrote:
>>>
>>> Maybe it should be a virtual node at the root of the DT if it's GPIO
>>> controlled? And then the phy can be connected to the usb connector
>>> through the graph binding.
>>
>> Graph binding can probably work.
>>
>> Re: the PHY.
>>
>> For myself the hardware model is
>>
>> Connector -> PHY -> Host controller -> Host controller wrapper
>>
>> Only
>>
>> Connector -> Host controller -> Host controller wrapper
>>
>> care about the USB role though.
>>
>> If your PHY did care about the role, you'd really need to write a
>> connector/phy type-c type driver, to detect the state and toggle your
>> PHY bits before doing usb_role_switch_set_role() back to DWC3.
>>
> 
> Yes some PHYs do care about the role. Sometimes they have to toggle some
> bit to switch between host and gadget mode for example. I haven't fully
> read this patch series but maybe the PHY can be the one that controls
> the gpio for the connector?

Previous version of the PHY from 2019 had extcon toggling vbus.

Since extcon is going away, we moved go usb-gpio

https://lwn.net/ml/devicetree/20190905175802.GA19599@jackp-linux.qualcomm.com/

https://lwn.net/ml/devicetree/5d71edf5.1c69fb81.1f307.fdd6@mx.google.com/

usb-gpio-conn handle VBUS and notifies via the USB role switch API.

Which if the connector is a child of the controller "just works" but, 
maybe with a little bit of work DT <port> references could do the same 
thing and the connector wouldn't need to be declared as a child.

> We (ChromeOS) need to integrate the type-c connector class, etc. on
> sc7180 with the dwc3 driver and the current thinking has the type-c
> connectors underneath the cros_ec node because the EC is the type-c
> manager. The EC will have a type-c driver associated with it.

right and you don't want, doesn't work or doesn't make sense, to declare 
cros_ec as a child of DWC3, fair enough.

I guess a DT remote-endpoint{} will do the job.

Something like:
arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi

---
bod
