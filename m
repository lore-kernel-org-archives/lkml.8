Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4F7C33CB6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 00:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4C6D24696
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 00:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDUFm+06"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgASAtU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 19:49:20 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33831 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgASAtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 19:49:20 -0500
Received: by mail-yw1-f67.google.com with SMTP id b186so16249133ywc.1;
        Sat, 18 Jan 2020 16:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Lq1OgM6L5ducZ2XvE8DFyGIevp5KpuzolsUWcBVa68=;
        b=BDUFm+06XdeGhDTf3jr+46o1qGoe2VGz3qlRM6w3itGozubBo6tmtMvTU+lLG4lks+
         tr8UvxOtPkb73tdscZCDpcCrtMfz93NROBZRE2LlxWFXMct/rQMpeR/vjlhVyMdrD9Db
         OVL7gMyfPBF2dw2GW8i4oHcEaf5MtJmI2B4jxieApiNjCMwdyC0f+CJVfy3MRoWQaXWd
         7wxhBsd8YPPlr2Wl7C68yofLRKDTbYSWD56kA1FxmcqKAQyAJlFyTTpHIQ9Rofd7oWFM
         VOeOK1iNBlF4F4Qcvy2m3Z58HmWSOaaM+crpSf6NRaeSCnY853m0dzx+8qv0N7X2Flbe
         tSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Lq1OgM6L5ducZ2XvE8DFyGIevp5KpuzolsUWcBVa68=;
        b=iE8xHGNT+qAzyW+VT6HqOZlwwH+QOXsiXLvoB5MJiFnxvUu02pNHzw8b2GVwbta9O0
         jgwmSDkX0V6YTrpmpZ65BmT6o4DNcyyP/5YcB8+KWaAWR8jG5qXzUhJj9F78o703ZiqP
         YBJ1X53dfw5ckEpmbWDylPEcLrur1x8akoeyvtfQku5UwdmyzJeoBTs+qQjm1RANaVkC
         ZMw7ep8Ds2y3JebCyBbng2v34Q/JkHJCcdel9OU7lyzw8Jmj8nn+Rgltq7MfGZQpKgTb
         kSEMJTkMdRiJ9vZ9JeteCiDNWw9U3ZbE3yYX2u7PW6Y2JEFBqpkR4+iD6+3kRe3UtqUC
         e5pA==
X-Gm-Message-State: APjAAAXxrJaxOpGqx7kGqVm0eY1k43crnl17KJtcgfzWjdXDOVV5G9nd
        1CHM4yC5AT7kx8wn7Ls2Jc4=
X-Google-Smtp-Source: APXvYqxSJiDsrbk752upcClBbr2lo7FXZtj+hS8ChXx5iSCPs8K78gXG44OHO6gTpYSkOO30X1sTbA==
X-Received: by 2002:a81:6d91:: with SMTP id i139mr37703307ywc.401.1579394958844;
        Sat, 18 Jan 2020 16:49:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o205sm13464210ywb.58.2020.01.18.16.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jan 2020 16:49:18 -0800 (PST)
Subject: Re: [PATCH v2 0/5] hwmon: k10temp driver improvements
To:     Ken Moffat <zarniwhoop73@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Darren Salt <devspam@moreofthesa.me.uk>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        =?UTF-8?Q?Ondrej_=c4=8cerman?= <ocerman@sda1.eu>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Brad Campbell <lists2009@fnarfbargle.com>
References: <20200118172615.26329-1-linux@roeck-us.net>
 <CANVEwpbgi5sUdBTyo330oCZ1T-cD+DoBJWrE9JbXw-DvYTiBvw@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <7345a801-6e9d-b85f-1a8a-72ee89cc0330@roeck-us.net>
Date:   Sat, 18 Jan 2020 16:48:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CANVEwpbgi5sUdBTyo330oCZ1T-cD+DoBJWrE9JbXw-DvYTiBvw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/20 4:33 PM, Ken Moffat wrote:
> On Sat, 18 Jan 2020 at 17:26, Guenter Roeck <linux@roeck-us.net> wrote:
>>
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
> 
> As the owner of that machine, very much agreed.
>  >>      1600
>>      1800X
>>      2200G
>>      2400G
>>      3800X
>>      3900X
>>      3950X
>>
> 
> I also had sensible results for v1 on 2500U and 3400G
> 
Sorry, I somehow missed that.

>> v2: Added tested-by: tags as received.
>>      Don't display voltage and current information for Threadripper and EPYC.
>>      Stop displaying the fixed (and wrong) maximum temperature of 70 degrees C
>>      for Tdie on model 17h/18h CPUs.
> 
> For v2 on my 2500U, system idle and then under load -
> 
> --- k10temp-idle 2020-01-19 00:16:18.812002121 +0000
> +++ k10temp-load 2020-01-19 00:22:05.595470877 +0000
> @@ -1,15 +1,15 @@
>   k10temp-pci-00c3
>   Adapter: PCI adapter
> -Vcore:        +0.98 V
> +Vcore:        +1.15 V
>   Vsoc:         +0.93 V
> -Tdie:         +38.2°C
> -Tctl:         +38.2°C
> -Icore:       +10.39 A
> -Isoc:         +6.49 A
> +Tdie:         +76.2°C
> +Tctl:         +76.2°C
> +Icore:       +51.96 A
> +Isoc:         +7.58 A
> 
>   amdgpu-pci-0300
>   Adapter: PCI adapter
>   vddgfx:           N/A
>   vddnb:            N/A
> -edge:         +38.0°C  (crit = +80.0°C, hyst =  +0.0°C)
> +edge:         +76.0°C  (crit = +80.0°C, hyst =  +0.0°C)
> 
> I'll ony test v2 on the 3400G if you think the results would add something.
> 

Thanks a lot for the additional testing! I don't think we need another
test on 3400G; after all, the actual measurement code didn't change.

Everyone: I'll be happy to add Tested-by: tags with your name and e-mail
address to the series, but you'll have to send it to me. I appreciate
all your testing and would like to acknowledge it, but I can not add
Tested-by: tags (or any other tags, for that matter) on my own.

Thanks,
Guenter
