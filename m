Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB72C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 15:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B4320882
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 15:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/IQWl2W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgASPqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 10:46:16 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:44829 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbgASPqQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 10:46:16 -0500
Received: by mail-yb1-f193.google.com with SMTP id f136so8556200ybg.11;
        Sun, 19 Jan 2020 07:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qZjhidcUrCzkr/hOAkl6ASo84yToDWDqBzrR+InXMlE=;
        b=M/IQWl2We+98aLc7kR+F/xXWsfCnuBD4EaKQk4j9zV7dYXMsfk2+T7TRCjnt8jsx05
         IlujGG/tGclM3mrdDpoDt5uhFeMSecO/Kbh4yjEOBHqp5N6Z70B2xr4bglsJ3pW/aMjS
         x1VL5LElrqw2MKmYuBC1YZbq4sOWr0cGb1GeDLk2EBdFWa6hnon9pNxpEZN7PJEdYjt1
         5eSBypyfhUMnWby2PzRlBBjCme6ITVNoExO7m9Byrde+1yk7+bsELKwBaRpDv7srGJc6
         PiSaCmJNNzhVTRuuRBrxZwLIB/KKVfDwLMcqKL3vVJtB0lp2VQ1FRDFoTn3GpfdQHlTU
         LDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qZjhidcUrCzkr/hOAkl6ASo84yToDWDqBzrR+InXMlE=;
        b=fttNSKJqb4N4giBP1m2q16QXwlNSMO6uiE3VRuYP/W+M9mWimJRYTs5rqXMim7wkX+
         RIq1B2bf44snHenAnDbdgU+87nVztkiO5V2Tf5/9J++kAZ62azDAbRBPomilBKNkhV32
         jb2rC2Nyqzl95fgK/C3FlnSZqeAt7V3CATNhLsRodcg2V9LSlxDjYSP6iUWWLdkfhVl5
         yYKLBzrPFqILRO6zD6mRsVyL0/gpX1pijX2kpkzLynjHBHvqNMJGXLCmXwkiyAil6bsh
         R1zbokhKTcKroesH5kcDpOdHGe4kwK/lFViyYUlMGm8LAdp8JePyH495VDT0XOko7oey
         Q6Fw==
X-Gm-Message-State: APjAAAUIFu/lF1+f70fcId9GmVgMxWhCFJsTzjm10wFVPiM+rwDN1eWW
        OcOcF6Q5/DSGsr3sKUSBVhoSqGGr
X-Google-Smtp-Source: APXvYqyRlDVgbFDUE1lGMfroDSkSwYNrGJJ6/Ve4FYqGQgsQuxldE/frkTYP1+6Szbq5sZug7xZOnA==
X-Received: by 2002:a25:cc83:: with SMTP id l125mr29799513ybf.107.1579448774747;
        Sun, 19 Jan 2020 07:46:14 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s68sm14248388ywg.69.2020.01.19.07.46.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2020 07:46:13 -0800 (PST)
Subject: Re: [PATCH v2 0/5] hwmon: k10temp driver improvements
To:     Jonathan McDowell <noodles@earth.li>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ken Moffat <zarniwhoop73@googlemail.com>
References: <20200119101855.GA15446@earth.li>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <f9bb13a7-60ba-37f1-9e22-3237e35cf4e5@roeck-us.net>
Date:   Sun, 19 Jan 2020 07:46:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200119101855.GA15446@earth.li>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/20 2:18 AM, Jonathan McDowell wrote:
> 
> In article <20200118172615.26329-1-linux@roeck-us.net> (earth.lists.linux-kernel) you wrote:
>> This patch series implements various improvements for the k10temp driver.
> ...
>> The voltage and current information is limited to Ryzen CPUs. Voltage
>> and current reporting on Threadripper and EPYC CPUs is different, and the
>> reported information is either incomplete or wrong. Exclude it for the time
>> being; it can always be added if/when more information becomes available.
> 
>> Tested with the following Ryzen CPUs:
> 
> Tested-By: Jonathan McDowell <noodles@earth.li>
> 
Thanks!

> Tested on a Ryzen 7 2700 (patched on top of 5.4.13):
> 
> | k10temp-pci-00c3
> | Adapter: PCI adapter
> | Vcore:        +0.80 V
> | Vsoc:         +0.81 V
> | Tdie:         +37.0°C
> | Tctl:         +37.0°C
> | Icore:        +8.31 A
> | Isoc:         +6.86 A
> 
> Like the 1300X case I see a discrepancy compared to what the nct6779
> driver says Vcore is:
> 
> | nct6779-isa-0290
> | Adapter: ISA adapter
> | Vcore:                  +0.33 V  (min =  +0.00 V, max =  +1.74 V)

I see that on all of my boards as well (3900X, different boards and board vendors),
with temperatures reported by the Super-IO chip sometimes as low as 0.18V (!).
Yet, there is a clear correlation of that voltage with CPU load.
I suspect the measurement by the Super-IO chip is a different voltage.

I don't think there is anything we can do about that without access to more
information.

> | in1:                    +0.32 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> | AVCC:                   +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> | +3.3V:                  +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> | in4:                    +1.88 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> | in5:                    +0.82 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> | in6:                    +0.30 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> | 3VSB:                   +3.42 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> | Vbat:                   +3.25 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> | in9:                    +0.00 V  (min =  +0.00 V, max =  +0.00 V)
> | in10:                   +0.22 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> | in11:                   +1.06 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> | in12:                   +1.70 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> | in13:                   +1.04 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> | in14:                   +1.79 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
> | fan1:                     0 RPM  (min =    0 RPM)
> | fan2:                  1708 RPM  (min =    0 RPM)
> | fan3:                     0 RPM  (min =    0 RPM)
> | fan4:                     0 RPM  (min =    0 RPM)
> | fan5:                     0 RPM  (min =    0 RPM)
> | SYSTIN:                 +33.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM
> | sensor = thermistor
> | CPUTIN:                 -62.5°C  (high = +80.0°C, hyst = +75.0°C)
> | sensor = thermistor
> | AUXTIN0:                +79.0°C    sensor = thermistor
> | AUXTIN1:                +96.0°C    sensor = thermistor
> | AUXTIN2:                +23.0°C    sensor = thermistor
> | AUXTIN3:                -22.0°C    sensor = thermistor
> | SMBUSMASTER 0:          +39.0°C
> | PCH_CHIP_CPU_MAX_TEMP:   +0.0°C
> | PCH_CHIP_TEMP:           +0.0°C
> | PCH_CPU_TEMP:            +0.0°C
> | intrusion0:            ALARM
> | intrusion1:            ALARM
> | beep_enable:           disabled
> 
> I suspect the nct6779 is not reporting correctly (or needs some
> configuration) here, as I see that's what Ken is using with his 1300X as
> well.
> 
Initially I thought the voltage reported by the Super-IO chip would help
us understand what is going on, but that is not really the case.

The problem with Ken's board is that idle current and voltage are very high.
The idle voltage claims to be higher than the voltage under load, which
doesn't really make sense. This is only reflected in the voltage and current
reported by the CPU, but not by the voltage reported by the Super-IO chip.

Thanks,
Guenter
