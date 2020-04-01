Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE291C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833BA2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lebedev-lt.20150623.gappssmtp.com header.i=@lebedev-lt.20150623.gappssmtp.com header.b="ejfPSZul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732238AbgDAK7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:59:32 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33957 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgDAK7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:59:31 -0400
Received: by mail-lf1-f67.google.com with SMTP id e7so20088409lfq.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 03:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lebedev-lt.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Kz/wvvEw8riqfKsZFfaKvWpn4ePkjlhRkXHpb0+VV70=;
        b=ejfPSZulqW6tvHwp6O4/dUlM1nKpSZnaSH3gKz3lf/dZFBlKJTgeOxGPwCrbLlOp5x
         sjDvP0MNzNkWS1cmTGAw2bUyaoM4GyZINostLPnrriP2E5Le6XjvyFdo8cTnJWJLUFsf
         NNdTsdv/zRM7lI439J0JVL64Duxzrg0wGx3L7+65cWU4+UI5a5u8G8W/ZjOcKpXXQQMX
         cny7dzHBYyLYidmycoljgSzUG0AwqJq+iUOJH638eKjvzJp/LnB9gjzWrM8EJqBx9b66
         YWD9C9gfcr0zB+8BMDaRU73I7HNWAnk2YtNgyfcCbsXpRSAiS6a9GIeK4x7fOiknpV0s
         HRIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Kz/wvvEw8riqfKsZFfaKvWpn4ePkjlhRkXHpb0+VV70=;
        b=MnaG+2xUZp4+EBH3sOHVpYvHGaPaRg8o8Ej00jRi4Wu7P9Z1INccGrECgUfyaZrjoh
         2ik/VmYpbzXlwddabmABjyhLvseeTXFOoGKnvNG4FXZeRAkT2rcsQcjeFqJ5Ho2CpaV/
         pT/OMkPbgr+U4F1RTr6qcocjOUN7U5pb9/ZMwC/71/KgJDzqyqomFrs4gxHEa6ngiPtk
         LYFpl44aVgu6Q9vxmn/WGCQRA6n+WWb2KIumoeU0RwP1ks7+0qTSeoaqZtzRC4ZUFMuq
         TR+wTPQrNhKpbh5CCrKlEUf3RCx4JIDPKhqA+lGkiK8QjhB4trGFSNWALo++o7hmAYeg
         GCbw==
X-Gm-Message-State: AGi0PubuIolJaNzCBLc4jAItJ95A7tH54lY0t6ZkYCXdWkQNSGscUgwx
        rejEc0PuM6omFupTauDPcJFR9A==
X-Google-Smtp-Source: APiQypL0dcEPevylSoyk56qeZt4wBG2S/JxfVQwOwqYclDb2rWm8vIGL5nT0j4NY6Uk65RKVtRpV6Q==
X-Received: by 2002:a19:f606:: with SMTP id x6mr14154741lfe.44.1585738768950;
        Wed, 01 Apr 2020 03:59:28 -0700 (PDT)
Received: from [192.168.1.108] ([5.20.204.163])
        by smtp.gmail.com with ESMTPSA id r2sm1312764lfn.35.2020.04.01.03.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 03:59:28 -0700 (PDT)
Subject: Re: [PATCH 5/5] drm/sun4i: tcon: Support LVDS output on Allwinner A20
To:     Maxime Ripard <maxime@cerno.tech>,
        Andrey Lebedev <andrey.lebedev@gmail.com>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200210195633.GA21832@kedthinkpad>
 <20200219180858.4806-1-andrey.lebedev@gmail.com>
 <20200219180858.4806-6-andrey.lebedev@gmail.com>
 <20200220172512.dmjtqgyay73x3ubx@gilmour.lan>
From:   Andrey Lebedev <andrey@lebedev.lt>
Message-ID: <fa780b70-f1cc-ee4c-e779-089c7e9159ab@lebedev.lt>
Date:   Wed, 1 Apr 2020 13:59:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200220172512.dmjtqgyay73x3ubx@gilmour.lan>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maxime,

Since Linus' merge window is now open, do I have to do anything to get 
this merged into the mainline kernel?

On 2/20/20 7:25 PM, Maxime Ripard wrote:
> On Wed, Feb 19, 2020 at 08:08:58PM +0200, Andrey Lebedev wrote:
>> From: Andrey Lebedev <andrey@lebedev.lt>
>>
>> A20 SoC (found in Cubieboard 2 among others) requires different LVDS set
>> up procedure than A33. Timing controller (tcon) driver only implements
>> sun6i-style procedure, that doesn't work on A20 (sun7i).
>>
>> Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
>> ---
>>   drivers/gpu/drm/sun4i/sun4i_tcon.c | 37 +++++++++++++++++++++++++++++-
>>   drivers/gpu/drm/sun4i/sun4i_tcon.h | 11 +++++++++
>>   2 files changed, 47 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> index b7234eef3c7b..09ee6e8c6914 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> @@ -114,6 +114,30 @@ static void sun4i_tcon_channel_set_status(struct sun4i_tcon *tcon, int channel,
>>   	}
>>   }
>>
>> +static void sun4i_tcon_setup_lvds_phy(struct sun4i_tcon *tcon,
>> +				      const struct drm_encoder *encoder)
>> +{
>> +	regmap_write(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
>> +		     SUN4I_TCON0_LVDS_ANA0_CK_EN |
>> +		     SUN4I_TCON0_LVDS_ANA0_REG_V |
>> +		     SUN4I_TCON0_LVDS_ANA0_REG_C |
>> +		     SUN4I_TCON0_LVDS_ANA0_EN_MB |
>> +		     SUN4I_TCON0_LVDS_ANA0_PD |
>> +		     SUN4I_TCON0_LVDS_ANA0_DCHS);
>> +
>> +	udelay(2); /* delay at least 1200 ns */
>> +	regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA1_REG,
>> +			   SUN4I_TCON0_LVDS_ANA1_INIT,
>> +			   SUN4I_TCON0_LVDS_ANA1_INIT);
>> +	udelay(1); /* delay at least 120 ns */
>> +	regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA1_REG,
>> +			   SUN4I_TCON0_LVDS_ANA1_UPDATE,
>> +			   SUN4I_TCON0_LVDS_ANA1_UPDATE);
>> +	regmap_update_bits(tcon->regs, SUN4I_TCON0_LVDS_ANA0_REG,
>> +			   SUN4I_TCON0_LVDS_ANA0_EN_MB,
>> +			   SUN4I_TCON0_LVDS_ANA0_EN_MB);
>> +}
>> +
>>   static void sun6i_tcon_setup_lvds_phy(struct sun4i_tcon *tcon,
>>   				      const struct drm_encoder *encoder)
>>   {
>> @@ -1455,7 +1479,18 @@ static const struct sun4i_tcon_quirks sun6i_a31s_quirks = {
>>   	.dclk_min_div		= 1,
>>   };
>>
>> +static const struct sun4i_tcon_quirks sun7i_a20_tcon0_quirks = {
>> +	.supports_lvds		= true,
>> +	.has_channel_0		= true,
>> +	.has_channel_1		= true,
>> +	.dclk_min_div		= 4,
>> +	/* Same display pipeline structure as A10 */
>> +	.set_mux		= sun4i_a10_tcon_set_mux,
>> +	.setup_lvds_phy		= sun4i_tcon_setup_lvds_phy,
>> +};
>> +
>>   static const struct sun4i_tcon_quirks sun7i_a20_quirks = {
>> +	.supports_lvds		= false,
> 
> False is already the default here.
> 
> I've removed it while applying
> 
> Maxime
> 

-- 
Andrey Lebedev aka -.- . -.. -.. . .-.
Software engineer
Homepage: http://lebedev.lt/
