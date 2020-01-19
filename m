Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B94C33CB6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 15:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C1A2051A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 15:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4172jHn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgASPtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 10:49:35 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39514 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgASPtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 10:49:35 -0500
Received: by mail-yw1-f68.google.com with SMTP id h126so16782490ywc.6;
        Sun, 19 Jan 2020 07:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fKT+j7khrvX6J/9z5tATTssyUkU2MSgx2oas0SvaXds=;
        b=Q4172jHnRyrK9vKojMwQ/LeuJoIQ9CvnznrnTfT035RnkEvuiuDRbfBJSSvsnAr5H4
         njPv7rQnKSbZWBolXSX25OaMVggq5nro/036GFWVQFsMShdeZwk8XXHly3Vn4OdraPbH
         uoo6UIULbhRpY2NJ6CY+6MeRvQ22g+XwFjMt7lDwH713+ZIV+43gYPQ1AQCo4UscsPcb
         SIG0bGvK9RSyF8I+FF6yVpfVlbiSjUKWzbaLikQKmYt6wAE/u/tMvC5mEY7I3iJiF0aV
         cySw7+Qo28xEg2rZ3VZJy3cJkM75qK3HYpxBYvGTqDxHyFU5slEi+ZZeMLtXRicyO/V0
         r3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fKT+j7khrvX6J/9z5tATTssyUkU2MSgx2oas0SvaXds=;
        b=HpBgMQPnV47b2L1oH5FXMvqnF8R7fg0syxS+oCearBRBWmAUUpKYuk772G6fU597c9
         +Dpw+mWrSaSAaJxVIM/Vwsc/uicYfznQsHKAkW2yQA96gaBURUmRA45dT1LaqCQbjPhz
         fn/MrQSfcwAw7Vwqw8HgYDUgw82+HNBGFpAu0ZHvQye4uiNHBS88i2614nfA+tW5iKv8
         4AxYkIQMRx1RrRWZWsggqXArqsRG55nCIG9lMPpaPC3rcWmpAUsPlfni4eZDeAejj90u
         N+2Z8yXQ8GlCb5WuQ/ePrKQq5v1MAoOrGHQhRs9krqCiMNW1CFO7wpY1pi2jvrwT2B5B
         /dPg==
X-Gm-Message-State: APjAAAWmkZQSUWgCUxFJf0cf/9nesvRa2aF/BTmZSQdCDxtSWll9NxJO
        ElDLW8sk0Kkms/Ep5+YC3W8=
X-Google-Smtp-Source: APXvYqxwbSudl44lCyWhgmtTBoPay81vIeCeABTzKDxXXkVDi5X7mU4zyBEFwGIIgbTBL5XyFg4ahw==
X-Received: by 2002:a81:52d8:: with SMTP id g207mr33589882ywb.458.1579448974194;
        Sun, 19 Jan 2020 07:49:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m16sm14066748ywa.90.2020.01.19.07.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jan 2020 07:49:33 -0800 (PST)
Subject: Re: [PATCH v2 0/5] hwmon: k10temp driver improvements
To:     Holger Kiehl <Holger.Kiehl@dwd.de>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Darren Salt <devspam@moreofthesa.me.uk>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        =?UTF-8?Q?Ondrej_=c4=8cerman?= <ocerman@sda1.eu>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Brad Campbell <lists2009@fnarfbargle.com>
References: <20200118172615.26329-1-linux@roeck-us.net>
 <alpine.LRH.2.21.2001191054490.328@diagnostix.dwd.de>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c0dc8e86-0063-b1ef-fb05-b4b62dd278ef@roeck-us.net>
Date:   Sun, 19 Jan 2020 07:49:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2001191054490.328@diagnostix.dwd.de>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/19/20 5:38 AM, Holger Kiehl wrote:
> On Sat, 18 Jan 2020, Guenter Roeck wrote:
> 
>> This patch series implements various improvements for the k10temp driver.
>>
>> Patch 1/5 introduces the use of bit operations.
>>
>> Patch 2/5 converts the driver to use the devm_hwmon_device_register_with_info
>> API. This not only simplifies the code and reduces its size, it also
>> makes the code easier to maintain and enhance.
>>
>> Patch 3/5 adds support for reporting Core Complex Die (CCD) temperatures
>> on Ryzen 3 (Zen2) CPUs.
>>
>> Patch 4/5 adds support for reporting core and SoC current and voltage
>> information on Ryzen CPUs.
>>
>> Patch 5/5 removes the maximum temperature from Tdie for Ryzen CPUs.
>> It is inaccurate, misleading, and it just doesn't make sense to report
>> wrong information.
>>
>> With all patches in place, output on Ryzen 3900X CPUs looks as follows
>> (with the system under load).
>>
>> k10temp-pci-00c3
>> Adapter: PCI adapter
>> Vcore:        +1.36 V
>> Vsoc:         +1.18 V
>> Tdie:         +86.8°C
>> Tctl:         +86.8°C
>> Tccd1:        +80.0°C
>> Tccd2:        +81.8°C
>> Icore:       +44.14 A
>> Isoc:        +13.83 A
>>
>> The voltage and current information is limited to Ryzen CPUs. Voltage
>> and current reporting on Threadripper and EPYC CPUs is different, and the
>> reported information is either incomplete or wrong. Exclude it for the time
>> being; it can always be added if/when more information becomes available.
>>
>> Tested with the following Ryzen CPUs:
>>      1300X A user with this CPU in the system reported somewhat unexpected
>>            values for Vcore; it isn't entirely if at all clear why that is
>>            the case. Overall this does not warrant holding up the series.
>>      1600
>>      1800X
>>      2200G
>>      2400G
>>      3800X
>>      3900X
>>      3950X
>>
>> v2: Added tested-by: tags as received.
>>      Don't display voltage and current information for Threadripper and EPYC.
>>      Stop displaying the fixed (and wrong) maximum temperature of 70 degrees C
>>      for Tdie on model 17h/18h CPUs.
>>
> Just tested this on a 2400G. Here idle values:
> 
>     k10temp-pci-00c3
>     Adapter: PCI adapter
>     Vcore:        +0.77 V
>     Vsoc:         +1.11 V
>     Tdie:         +45.0°C
>     Tctl:         +45.0°C
>     Icore:       +10.39 A
>     Isoc:         +2.89 A
> 
>     nvme-pci-0100
>     Adapter: PCI adapter
>     Composite:    +43.9°C  (low  = -273.1°C, high = +80.8°C)
>                            (crit = +80.8°C)
>     Sensor 1:     +43.9°C  (low  = -273.1°C, high = +65261.8°C)
>     Sensor 2:     +48.9°C  (low  = -273.1°C, high = +65261.8°C)
> 
>     nct6793-isa-0290
>     Adapter: ISA adapter
>     in0:                    +0.35 V  (min =  +0.00 V, max =  +1.74 V)
>     in1:                    +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in2:                    +3.41 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in3:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in4:                    +0.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in5:                    +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in6:                    +0.66 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in7:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in8:                    +3.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in9:                    +1.83 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in10:                   +0.19 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in11:                   +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in12:                   +1.84 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in13:                   +1.72 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in14:                   +0.21 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     fan1:                     0 RPM  (min =    0 RPM)
>     fan2:                   323 RPM  (min =    0 RPM)
>     fan3:                     0 RPM  (min =    0 RPM)
>     fan4:                     0 RPM  (min =    0 RPM)
>     fan5:                     0 RPM  (min =    0 RPM)
>     SYSTIN:                +112.0°C  (high =  +0.0°C, hyst =  +0.0°C)  sensor = thermistor
>     CPUTIN:                 +60.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
>     AUXTIN0:                +46.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor = thermistor
>     AUXTIN1:               +106.0°C    sensor = thermistor
>     AUXTIN2:               +105.0°C    sensor = thermistor
>     AUXTIN3:               +102.0°C    sensor = thermistor
>     SMBUSMASTER 0:          +45.0°C
>     PCH_CHIP_CPU_MAX_TEMP:   +0.0°C
>     PCH_CHIP_TEMP:           +0.0°C
>     PCH_CPU_TEMP:            +0.0°C
>     intrusion0:            OK
>     intrusion1:            ALARM
>     beep_enable:           disabled
> 
>     amdgpu-pci-0300
>     Adapter: PCI adapter
>     vddgfx:           N/A
>     vddnb:            N/A
>     edge:         +45.0°C  (crit = +80.0°C, hyst =  +0.0°C)
> 
> And here with some high load:
> 
>     k10temp-pci-00c3
>     Adapter: PCI adapter
>     Vcore:        +1.32 V
>     Vsoc:         +1.11 V
>     Tdie:         +77.1°C
>     Tctl:         +77.1°C
>     Icore:       +85.22 A
>     Isoc:         +3.61 A
> 
>     nvme-pci-0100
>     Adapter: PCI adapter
>     Composite:    +42.9°C  (low  = -273.1°C, high = +80.8°C)
>                            (crit = +80.8°C)
>     Sensor 1:     +42.9°C  (low  = -273.1°C, high = +65261.8°C)
>     Sensor 2:     +45.9°C  (low  = -273.1°C, high = +65261.8°C)
> 
>     nct6793-isa-0290
>     Adapter: ISA adapter
>     in0:                    +0.68 V  (min =  +0.00 V, max =  +1.74 V)
>     in1:                    +1.84 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in2:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in3:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in4:                    +0.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in5:                    +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in6:                    +0.66 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in7:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in8:                    +3.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in9:                    +1.83 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in10:                   +0.19 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in11:                   +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in12:                   +1.84 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in13:                   +1.72 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     in14:                   +0.20 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
>     fan1:                     0 RPM  (min =    0 RPM)
>     fan2:                  1931 RPM  (min =    0 RPM)
>     fan3:                     0 RPM  (min =    0 RPM)
>     fan4:                     0 RPM  (min =    0 RPM)
>     fan5:                     0 RPM  (min =    0 RPM)
>     SYSTIN:                +113.0°C  (high =  +0.0°C, hyst =  +0.0°C)  sensor = thermistor
>     CPUTIN:                 +64.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
>     AUXTIN0:                +45.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor = thermistor
>     AUXTIN1:               +107.0°C    sensor = thermistor
>     AUXTIN2:               +105.0°C    sensor = thermistor
>     AUXTIN3:               +102.0°C    sensor = thermistor
>     SMBUSMASTER 0:          +77.0°C
>     PCH_CHIP_CPU_MAX_TEMP:   +0.0°C
>     PCH_CHIP_TEMP:           +0.0°C
>     PCH_CPU_TEMP:            +0.0°C
>     intrusion0:            OK
>     intrusion1:            ALARM
>     beep_enable:           disabled
> 
>     amdgpu-pci-0300
>     Adapter: PCI adapter
>     vddgfx:           N/A
>     vddnb:            N/A
>     edge:         +77.0°C  (crit = +80.0°C, hyst =  +0.0°C)
> 
> Have also tried this on a EPYC 7302. Before the patch:
> 
>     k10temp-pci-00c3
>     Adapter: PCI adapter
>     Tdie:         +28.1°C  (high = +70.0°C)
>     Tctl:         +28.1°C
> 
> and after:
> 
>     k10temp-pci-00c3
>     Adapter: PCI adapter
>     Tdie:         +28.2°C
>     Tctl:         +28.2°C
> 
> No extra values shown, but I think this is expected.
> 
Unfortunately yes, but it helps to confirm that the detection works.

> Tested-by Holger Kiehl <holger.kiehl@dwd.de>
> 

Thanks again!

Guenter
