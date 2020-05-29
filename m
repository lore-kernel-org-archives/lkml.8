Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 840ACC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 624BC20776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:44:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQh51dns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgE2Pog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgE2Pof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:44:35 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2D9C03E969;
        Fri, 29 May 2020 08:44:34 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r15so4080239wmh.5;
        Fri, 29 May 2020 08:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dZl3sOoHlWuzucNXfMp2p0mgDBU/NJ3Y6nLUtAUeFPY=;
        b=iQh51dnsOVAsZ7p1i/vc+iLPLJedHjqmvk0WT6zqHKt35yhG+mF5N24hr44F71lnt3
         ziXY8P94diOdcINikFCpltde3xjphLzv2losCnWXGrBRUSkRbJDADPXxoKR1+z2HoXxn
         CucmmxO3c0lODdzbLNMlwetSvlgp2D2zZdsyoZMftqPCG9wYC5cX7A7ZdKhnlA6NJP2a
         +2XzsX0j4Zh/jbzuFX0kRcM8YT1N+YSx549FIg2+6cYBjLDJG/3xIacSOB+gVobk4aYz
         MOvVjaQaDb34rFNJmnfn9zR1VtLZBGJhokEjOlG+uSsMNq2r8djtb/Mk+7GWciVwBRaI
         Qt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dZl3sOoHlWuzucNXfMp2p0mgDBU/NJ3Y6nLUtAUeFPY=;
        b=E81VhYmBrd6p2pZmX/EO/EHo5SVTFfaEaIF6MQpTnsokqtfToa3mktVC60Ht3QfARH
         wwt3IT/PANoVvWGX30fOYzuTCYK25CDtxvIxoVVmDcsf078uvjEMVonMW0QPM2nKwvS0
         +tmEpo3e4GQsCcOAqoFn0DxntX1qMf8Q9M4nTSVUJa8flIrpgiUvwkCuqAl4tVolhejz
         RV01zBpuHpfVBh7z2TdbiFtoxPbY0h3SkKj0Qdpe4TEmBBQeJjwH4Vhnb0JcWjROJrmz
         rMS2to+8ddrNW7ILbzIGIyKO5oNeWpLWqdLSeVhZbnHaaR8TPOItsjKj+hnpsQmiGEgj
         K1bQ==
X-Gm-Message-State: AOAM532/Fi3qLVIN2dd4wno0h3hekHvgD1SkCHHd3aTto2JW4k/Fwwx6
        Twhwo2MYRQ7m0TrJG95cH1w=
X-Google-Smtp-Source: ABdhPJyZ8xu3odmGBzMNwbIAqQRzO79AqjDmSy79FzGlVroNcfOqyFP+z+tOoF/poA2GOlef/CwZiQ==
X-Received: by 2002:a7b:c096:: with SMTP id r22mr9080376wmh.92.1590767073359;
        Fri, 29 May 2020 08:44:33 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id h20sm11766789wma.6.2020.05.29.08.44.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 08:44:32 -0700 (PDT)
Subject: Re: [PATCH 3/4] pinctrl: bcm2835: Match BCM7211 compatible string
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." 
        <bcm-kernel-feedback-list@broadcom.com>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <20200528192112.26123-1-f.fainelli@gmail.com>
 <20200528192112.26123-4-f.fainelli@gmail.com>
 <291609c0-f1ec-2626-8bfa-cf25a9e45365@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <7a25489d-e496-d470-b99f-459630b1db44@gmail.com>
Date:   Fri, 29 May 2020 08:44:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <291609c0-f1ec-2626-8bfa-cf25a9e45365@i2se.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/29/2020 6:11 AM, Stefan Wahren wrote:
> Hi Florian,
> 
> Am 28.05.20 um 21:21 schrieb Florian Fainelli:
>> The BCM7211 SoC uses the same pinconf_ops as the ones defined for the
>> BCM2711 SoC, match the compatible string and use the correct set of
>> options.
>>
>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>> ---
>>  drivers/pinctrl/bcm/pinctrl-bcm2835.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
>> index 06bd2b70af3c..e8ad1824c6b3 100644
>> --- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
>> +++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
>> @@ -1137,6 +1137,10 @@ static const struct of_device_id bcm2835_pinctrl_match[] = {
>>  		.compatible = "brcm,bcm2711-gpio",
>>  		.data = &bcm2711_plat_data,
>>  	},
>> +	{
>> +		.compatible = "brcm,bcm7211-gpio",
>> +		.data = &bcm2711_pinconf_ops,
> 
> this doesn't look safe. Maybe bcm2711_plat_data?

Whoops you are right, I sent an incorrect version.

> 
> Looks like the original patch series based on a older version. Please
> double check this still applies since the introduction of 58 GPIO
> support for BCM2711.

We can use bcm2711_plat_data, thanks Stefan.
-- 
Florian
