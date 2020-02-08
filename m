Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE01AC35250
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 07:09:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B709921741
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 07:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DWGOOefk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgBHHJu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 02:09:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40584 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgBHHJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 02:09:50 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so1422628wru.7
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 23:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a/tqcE7qrwqqGwyg45dZ2gXZamw2QOoIGn4BuGk3MlY=;
        b=DWGOOefkl9BtPfOOHuNZqk5CTEMWpqTEn4YYXyoWXSU3fiouK9xby55SPyDOQ30Kc+
         P0MtUc39K0N8bxmOoCtNuEN0z78RgpAjdNHx7inNHXUBqjCnpvNNiLtLVVvyIZMJ1OSm
         pNOxW/8cTac6V7+6wyYsvMUjvHJsxL5sLJaNblvwLd0xLBzkFy4pNzG/aEZnJZyJXxIZ
         ylW9RpEJWlhkkmvSRg/yVlAx2aVZVRRvmF41ya2uy2WhR9lKxfMmrXtObdxgoSkKrWn3
         bhGMC+GYi8asZaxIVVFIFr3lffzL1FOdeqGO3j0Vj3kDkc+DlUZdo4lwnyX5T00A8iqX
         GI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=a/tqcE7qrwqqGwyg45dZ2gXZamw2QOoIGn4BuGk3MlY=;
        b=MkgLGcHAdM2/52wSyQMZluwk9fDZ9AXgTdt9n0qLmIGU0+XZOfTkEVR1mbNJ8367BN
         B70Xr+7vIsRyCasRZf351qLutILFivsgPfnD31sydmX68/YcA4q50AcdnFBpljYrSEqf
         weYYtYkNmAfB65K4fKHiWOETT74asuu6QtEY00AJPc8ezilovFCtjSx0c5aZpMABRcSd
         PL2cxp9R/axQhqMP21/bqdKFFgaKgky+pmtfkO6Ce97RCxm9ZQkrbtg9eCnanSZ5hfp9
         ZcU9bvGgYI2D0JJQvanh7MeOpbI4UODEaHaccn+G/rXPJOuYIB/JGyjGxtr7GEDM/D8t
         6oQA==
X-Gm-Message-State: APjAAAUrI2aGTalvOnpMn8SVD3AfpHbsPyM4cEaFO6jBB/q/ipylP2Rh
        HvV/nGBHQBJSQIHvq5LIU05EJA==
X-Google-Smtp-Source: APXvYqwpz/b0nEqYsUSoR0ESBXv9M5voL4QRjGT7B2ZuHIKlvkWg0lhxZezDaYzho0KATius9w9+Bg==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr3758476wrv.79.1581145787244;
        Fri, 07 Feb 2020 23:09:47 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:4088:68ae:8f59:9587? ([2a01:e34:ed2f:f020:4088:68ae:8f59:9587])
        by smtp.googlemail.com with ESMTPSA id c74sm6556696wmd.26.2020.02.07.23.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2020 23:09:46 -0800 (PST)
Subject: Re: [PATCH v3] clocksource: Add driver for the Ingenic JZ47xx OST
To:     Paul Cercueil <paul@crapouillou.net>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Maarten ter Huurne <maarten@treewalker.org>, od@zcrc.me,
        linux-kernel@vger.kernel.org, Mathieu Malaterre <malat@debian.org>,
        Artur Rojek <contact@artur-rojek.eu>
References: <1579110897.3.0@crapouillou.net>
 <87y2u8xzq0.fsf@nanos.tec.linutronix.de> <1579121936.3.1@crapouillou.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <eef21d5f-334c-81b4-19b1-6498df4fca30@linaro.org>
Date:   Sat, 8 Feb 2020 08:09:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1579121936.3.1@crapouillou.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 15/01/2020 21:58, Paul Cercueil wrote:
> 
> 
> Le mer., janv. 15, 2020 at 20:54, Thomas Gleixner <tglx@linutronix.de> a
> écrit :
>> Paul Cercueil <paul@crapouillou.net> writes:
>>>  Le mer., janv. 15, 2020 at 18:48, Maarten ter Huurne
>>>  <maarten@treewalker.org> a écrit :
>>>>  On Wednesday, 15 January 2020 14:57:01 CET Paul Cercueil wrote:
>>>>>   Le mer., janv. 15, 2020 at 14:44, Daniel Lezcano
>>>>>   <daniel.lezcano@linaro.org> a écrit :
>>>>>   > Is the JZ47xx OST really a mfd needing a regmap? (Note regmap_read
>>>>>   > will take a lock).
>>>>>
>>>>>   Yes, the TCU_REG_OST_TCSR register is shared with the clocks driver.
>>>>
>>>>  The TCU_REG_OST_TCSR register is only used in the probe though.
>>>>
>>>>  To get the counter value from TCU_REG_OST_CNTL/TCU_REG_OST_CNTH you
>>>>  could technically do it by reading the register directly, if
>>>>  performance
>>>>  concerns make it necessary to bypass the usual kernel infrastructure
>>>>  for
>>>>  dealing with shared registers.
>>>
>>>  In theory yes, in practice there's no easy way to do that (the
>>>  underlying mmio pointer is not obtainable from the regmap), and
>>>  besides, the lock is just a spinlock and not a mutex.
>>
>> That lock still a massive contention point as clock readouts can be
>> pretty
>> frequent depending on workloads. Just think about tracing ...
>>
>> So I really would avoid both the lock and that ugly 64bit readout thing.
> 
> The 64bit readout thing is gone in V3.
> 
> The lock cannot go away unless we have a way to retrieve the underlying
> mmio pointer from the regmap, which the regmap maintainers will never
> accept. So I can't really change that now. Besides,
> drivers/clocksource/ingenic-timer.c also registers a clocksource that's
> read with the regmap, and nobody complained.

Is there any progress on this? Having a lock in this code path is very
impacting.


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

