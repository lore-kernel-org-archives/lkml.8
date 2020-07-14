Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD05C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6F0F22453
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 14:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtbkHI2E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgGNODk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 10:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgGNODj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 10:03:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D85C061755;
        Tue, 14 Jul 2020 07:03:39 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w2so7624079pgg.10;
        Tue, 14 Jul 2020 07:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2/fXNlBHkKY8U2n+OvWiDOz5lWmmKQIFHvJBN1p+UYE=;
        b=VtbkHI2EUSu7LFWZ/cwjpzQXHnYi+YUhpqfQ1dxYgUTJEx/32Nter3aKjxfvbZRCG6
         4KKQDwzdXe90ebYoIuFNRXDMJFapGi+0GKjR2wnhrEdyLELNffG8UITeb6P7BYEFo9bO
         YEu5LsGM2jbg4aO3H0zGEEQG5A00s8RLX9MJw8O3k7PLB+0klC3nDb3+wD0VSrWXYyLC
         fbRUsAAeLfsSGI5Y3XOlnbw7LeDhe9poOvwucovp+glJUQMEVHcJVOrOJSiclTy1hCme
         AWbRF5zH7va2iSEH2AaumCgQ9cHPKxJgFNgXqBp6LW0CUkZTfXQVRSPa1TdxL/XX/+6s
         xmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=2/fXNlBHkKY8U2n+OvWiDOz5lWmmKQIFHvJBN1p+UYE=;
        b=S5COk8/c5Gv+C95phZdGqUkZJsGAyQ0F6D0qm4q9/7G2UwqNTQoiehFChAY19dTkv+
         npv/yUACSmcs+P7ox2uOjEHc55aswjQeHv2pT4yNVyi2k0ON33LV/h03cm9RVlAhvZoW
         B9twMu8vAOKRVQZaiJSqD8d8jlwa2r5cT5GIRuyWVYjqcEgdcP9YbbVyxoKNnev3idJ1
         A9FMkHy0UAkfyQHbOJ1V0+ivpeAOsvNcz3xPEC3Bocx84hndd+I56nfe8nnoyWxGeQuF
         JpyhskC/l3MbjSZ9LH9lf9rbga276RhdAFaeDjqqKHv4BjVb3facJxZ8La5n0RgPmIbZ
         mb/g==
X-Gm-Message-State: AOAM533RYzntfvUtPsosEX1N5VdUsUBVstYDweYU+HzVqEQv6rvWM6MY
        jqZ1G2jQ0FI+OYqzS2gXZi0=
X-Google-Smtp-Source: ABdhPJz3APXGp5Dkk7NshBwh09omSj0BrLLhSR2GMtMZXp3PdfoEYWISeqosMSIEgQQ69W/VvYVjIw==
X-Received: by 2002:a63:9353:: with SMTP id w19mr3479764pgm.13.1594735418862;
        Tue, 14 Jul 2020 07:03:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g30sm18483045pfq.189.2020.07.14.07.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 07:03:38 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: hwmon: adm1272: add adm1272-adm1275-temp1-en
 binding
To:     Chu Lin <linchuyuan@google.com>, robh+dt@kernel.org
Cc:     Kais Belgaied <belgaied@google.com>,
        Jason Ling <jasonling@google.com>, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zhongqi Li <zhongqil@google.com>
References: <20200710004258.296017-1-linchuyuan@google.com>
 <CAKCA56A8b+8NA8Si7g+whkYSRqr7=JLV+726nyFiDjWQ70BTgA@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <f45a85ec-3e5c-9029-8c28-0a1a34398bb8@roeck-us.net>
Date:   Tue, 14 Jul 2020 07:03:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAKCA56A8b+8NA8Si7g+whkYSRqr7=JLV+726nyFiDjWQ70BTgA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/20 12:24 PM, Chu Lin wrote:
> Adding Rob to the review list.
> 

Rob is running a robot on DT bindings patches. Adding him like this
very likely won't trigger the robot.

Guenter

> On Thu, Jul 9, 2020 at 5:43 PM Chu Lin <linchuyuan@google.com> wrote:
>>
>> Problem:
>>         adm1272 and adm1278 supports temperature sampling. The
>> current way of enabling it requires the user manually unbind the device
>> from the driver, flip the temperature sampling control bit and then bind
>> the device back to the driver. It would be nice if we can control this in a
>> better way by reading the dt.
>>
>> Solution:
>>         Introducing device tree binding adm1272-adm1278-temp1-en. If the
>> flag is set, flip the temp1_en control bit on probing.
>>
>> Testing:
>> make dt_binding_check
>>
>> Signed-off-by: Chu Lin <linchuyuan@google.com>
>> ---
>>  Documentation/devicetree/bindings/hwmon/adm1275.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/adm1275.txt b/Documentation/devicetree/bindings/hwmon/adm1275.txt
>> index 1ecd03f3da4d..4403fe30f005 100644
>> --- a/Documentation/devicetree/bindings/hwmon/adm1275.txt
>> +++ b/Documentation/devicetree/bindings/hwmon/adm1275.txt
>> @@ -15,6 +15,8 @@ Optional properties:
>>
>>  - shunt-resistor-micro-ohms
>>         Shunt resistor value in micro-Ohm
>> +- adm1272-adm1278-temp1-en
>> +       Enable temperature sampling. This is supported on adm1272 and adm1278
>>
>>  Example:
>>
>> @@ -22,4 +24,5 @@ adm1272@10 {
>>         compatible = "adi,adm1272";
>>         reg = <0x10>;
>>         shunt-resistor-micro-ohms = <500>;
>> +       adm1272-adm1278-temp1-en;
>>  };
>> --
>> 2.27.0.383.g050319c2ae-goog
>>

