Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DACC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 00:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B63BB20723
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 00:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=domanski-co.20150623.gappssmtp.com header.i=@domanski-co.20150623.gappssmtp.com header.b="CkaYHqJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgGDAhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 20:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbgGDAhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 20:37:36 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C17C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 17:37:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id rk21so36016673ejb.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 17:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=domanski-co.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HVFK90VwTKZzePURoVYTgdkNMrFLRnd5P1mDG7K0iJw=;
        b=CkaYHqJRwosjcVfLnWi2xub/oYqQp6IbU5t5v4r3VlmDlTfWCghTNiK7HJnANA5ixb
         K8IQb5/uBWGwmZx/gdU7LBmsBOD4XmDwmzOytPHMV/agRpvMFf7jNgQ4WIC+2F/v+Iss
         DHMIMMq6czERlDTPRtl5tXXXQymKJSwSWXmjIfJAfoOMnZFYra96AeN/HcpxgXgb2yKt
         PG0N+hQOA9dWSWXtu7bSjul6tMFwKoUMCCZ56D+O4bOt4Y8ja8eEdHkl9SkwJyJw00/y
         YnEvo5WwcgIAqQvdOLW/nT7DuLiUr02jDHpe0AdTV7C6VJgJA8ZR7DQRJydqOzhlDlvh
         rMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HVFK90VwTKZzePURoVYTgdkNMrFLRnd5P1mDG7K0iJw=;
        b=ghxlJxl6QVu5aPm8dFICrw6b1JjYlFqPYV28dI5bXtqh2Vp2thvGgyNlw/WgilWWeN
         l3L76Cq9l7yAf8BRKjjsNVHviyYhLWKBrC9rqUU52pcwvdst2O76F0lpRUlmT6Pg+wJE
         SEr/hpvNZ6cmf5yj2DYUOnyrHHxdn3kzlFXaF7mgcBDnKNEzE77XwaenBN8eOpqC0k4t
         WovuwKwm7MpA5mYkX8fRTgv/nzxM4pEft0LxsyYfTrRXflXSyeadF9Q+p7twxg83Z0rL
         Ch6OxHyS6nmM7SHwZpzuixEKk/9oerHKPtHlgSLTt/B/4uE3AQjAeabQoTuihMA+A14c
         /ORg==
X-Gm-Message-State: AOAM533c1666YMsAnDHEc+OlN9/MkbwBAWIqgf+Arl5BRrVWEHrflsi5
        3w0mP6smBxTxCB1DBcXGreRdZg==
X-Google-Smtp-Source: ABdhPJwcGZ5za4eaLuQj0vRqI5sS1pNCrV9N2ZFsQ9z399MBqB5zYMK0ZSkBqlDT0Ef1Ja4A2uxQPg==
X-Received: by 2002:a17:906:700f:: with SMTP id n15mr23640147ejj.390.1593823054934;
        Fri, 03 Jul 2020 17:37:34 -0700 (PDT)
Received: from ?IPv6:2a04:4540:6b00:6900:489f:a320:1bb1:801e? ([2a04:4540:6b00:6900:489f:a320:1bb1:801e])
        by smtp.googlemail.com with ESMTPSA id n2sm14227223edq.73.2020.07.03.17.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jul 2020 17:37:34 -0700 (PDT)
Subject: Re: [PATCH v2] HID: logitech-hidpp: add support for Logitech G533
 headset
To:     =?UTF-8?Q?Filipe_La=c3=adns?= <lains@archlinux.org>,
        linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
References: <023148f582cc20bef7079508ce417c8ebeb0febb.camel@domanski.co>
 <137acb00c6ec098d7506901df05067e8d7207aa9.camel@archlinux.org>
From:   =?UTF-8?Q?Kamil_Doma=c5=84ski?= <kamil@domanski.co>
Message-ID: <52609283-6d37-9e0e-be24-7df378e4fead@domanski.co>
Date:   Sat, 4 Jul 2020 02:37:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <137acb00c6ec098d7506901df05067e8d7207aa9.camel@archlinux.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Filipe,

>> +	bool isConnected;
>> +	bool isCharging;
>> +	bool chargingComplete;
>> +	bool chargingFault;
> 
> From my initial comments:
> 
>> We use snake case.

Will be fixed in v3.

>> +
>> +	long flags = (long) data[2];
> 
>> Use u8 instead. Why are we even using a variable for this?
> 
> My main point here is that long means different things in different
> architectures, and we only want one byte so I would go for u8.

I used long, because the test_bit macro accepts long and the similar
function for voltage reading already used long too.
That will be changed in v3 - see next paragraph.

>> +
>> +	*voltage = get_unaligned_be16(data);
>> +	isConnected = test_bit(0, &flags);
>> +	isCharging = test_bit(1, &flags);
>> +	chargingComplete = test_bit(2, &flags);
>> +	chargingFault = test_bit(3, &flags);
> 
>> I don't think this is needed, just do it in the ifs directly.
>>
>> Here I would add a #define for each bit:
>>
>> #define FLAG_ADC_MAP_STATUS_CONNECTED 0
>> ...
>> if (data[2] & FLAG_ADC_MAP_STATUS_CONNECTED)

Yeah, I it will do exactly that for v3, which allows to drop the flag
variables and avoid using a long.

 
> Same thing here. We should see if the device supports the DJ protocol
> and add it in hid-logitech-dj instead.

It doesn't seem to be a DJ device. The DJ driver just detects the extra interfaces
and skips directly to hid_hw_start.

Regards,
Kamil

