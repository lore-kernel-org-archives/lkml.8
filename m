Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D820C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C96182465D
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 20:27:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoinvabN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgBLU1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 15:27:11 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:40283 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727548AbgBLU1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 15:27:10 -0500
Received: by mail-pf1-f174.google.com with SMTP id q8so1788584pfh.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 12:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d6zAFWJmLZIeyGgr3JKHdlnBZ2cvifSzgzb7Lz0cYqs=;
        b=XoinvabNWbH3VjxvV4YjOP8wh5Qx2WJTM3R2bashw4q0l7pvkMYOCtzqoKOyd3yF4V
         bZAMtHmPrplZWiV9j93ZgM7f3rXvYoh25NYQR+koQI8VIMa6AUAFMYCx2X5/1txWt96m
         tMjlBHtBc0RsXpf8WnkvIcc1DW9kuuIjJ1KHPeQKIiMdiNjtt2AoBd9YJUMWjVDIr3JT
         Dqdu/nyqojJ+ALYGOHHFtzxxmEdc0qA5x2atG8sI67VlNznmphzbWkwG64XXeJSJ7/BY
         F0aHfIDCfMPaQy8NGwTKHrTFJgStZtBTAGOxx/u+llG64d0EAkGCHttxdDpBR0weAJyQ
         NjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=d6zAFWJmLZIeyGgr3JKHdlnBZ2cvifSzgzb7Lz0cYqs=;
        b=VwKpJSVA/nrdLTsKoOto5td8YRoB8DGAXVP9mTighwH4fDktKYsZJTs27mpxYLLjaZ
         93B3BCD2q//5EjhBHtNY1XB3kS8AfyuzyiG89tCdpwuwnDAspjZud/hK1dy0zYpcAXc0
         VNEkTVrURcXpCbtwGBcEQH4eFWad6wetqolQ2htBTCWpnnYoQS+NngQ2s2kjx8oyzGHn
         4Vxk6zNPwoGA7BwLmeC28z4++q0qO5CMeIIHENSqThs+NTuewmtQZJxgqs50MUHlQCBB
         d5737GU6BA2Ktm5f9dzKvJMnG67AL0wohmQTZPYt+UvdvemPo4ryAsYh/l4BDUDWuRtV
         32zA==
X-Gm-Message-State: APjAAAXddTtO7FdGJNr3NyRASGRbkXsYG2GG7UsjP48pROG7+xaqdooB
        bLzUiTNW7bdAy4XUm2LPFMkPyqik
X-Google-Smtp-Source: APXvYqyNqLuChvAiwOOKow/av8vLMh55craBstUbVqcQrieKw7L5mkm1McS6F7dtCJR7mC7XyQzTMw==
X-Received: by 2002:a63:cb11:: with SMTP id p17mr14444001pgg.42.1581539228517;
        Wed, 12 Feb 2020 12:27:08 -0800 (PST)
Received: from [10.67.50.49] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id d22sm87337pfo.187.2020.02.12.12.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 12:27:07 -0800 (PST)
Subject: Re: [RFC] ARM: add multi_v7_lpae_defconfig
To:     Arnd Bergmann <arnd@arndb.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Russell King <linux@armlinux.org.uk>,
        Phil Elwell <phil@raspberrypi.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Wahren <wahrenst@gmx.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>
References: <20200110173425.21895-1-nsaenzjulienne@suse.de>
 <CAK8P3a1tLrkymeJfXvDk_kxPvW_PQy6zNmrmO++dOPCWm71vOA@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 G10n8gCguORqNGMsVRxrlLs7/himep7MrCc=
Message-ID: <e061bc24-9832-cfb1-ab64-1cf164fe599e@gmail.com>
Date:   Wed, 12 Feb 2020 12:27:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1tLrkymeJfXvDk_kxPvW_PQy6zNmrmO++dOPCWm71vOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/12/20 12:19 PM, Arnd Bergmann wrote:
> On Fri, Jan 10, 2020 at 6:35 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
>>
>> The only missing configuration option preventing us from using
>> multi_v7_defconfig with the RPi4 is ARM_LPAE. It's needed as the PCIe
>> controller found on the SoC depends on 64bit addressing, yet can't be
>> included as not all v7 boards support LPAE.
>>
>> Introduce multi_v7_lpae_defconfig, built off multi_v7_defconfig, which will
>> avoid us having to duplicate and maintain multiple similar configurations.
>>
>> Note that merge_into_defconfig was taken from arch/powerpc/Makefile.
>>
>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> 
> I like the idea, but I would note that a lot of platforms enabled in
> multi_v7_defconfig do not support LPAE. In particular, the first ARMv7
> cores (Cortex-A8, -A9, -A5, and PJ4) don't, but the later ones (Cortex-A7,
> -A15, -A17, and PJ4C-MP) do.
> 
> Here is a list from the defconfig file
> 

[snip]

> CONFIG_ARCH_BCM=y
> CONFIG_ARCH_BCM_CYGNUS=y
> CONFIG_ARCH_BCM_HR2=y
> CONFIG_ARCH_BCM_NSP=y
> CONFIG_ARCH_BCM_5301X=y
> CONFIG_ARCH_BCM_281XX=y
> CONFIG_ARCH_BCM_21664=y
> CONFIG_ARCH_BCM_63XX=y
> CONFIG_ARCH_BRCMSTB=y
> 
> I think most of the above are A9, but not sure

63138 is Cortex-A9, 63148 and BRCMSTB are using a Brahma-B15 CPU which
is LPAE capable. 23550 is A7 and every others are Cortex-A9.
-- 
Florian
