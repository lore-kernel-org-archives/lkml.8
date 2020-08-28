Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83861C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5857B20776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 17:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="FlaMflUy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgH1RIr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 13:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgH1RIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 13:08:40 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3357C06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 10:08:39 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id u128so950947pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 10:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PkU2nF0bf0ig0+Ovi1RNPm0NnQeO/Bze0oV8LgroTYE=;
        b=FlaMflUyvCPl7nmKSmqVyx6Fp4LG7GtqSIvahsbYOE8tnFPGVTgvfwBrW9oS3+OIQ8
         +mUlu2HlXSoD4Gv/h7u6zvSrBKleUilbVdAykpjKAQOJIYnqVfC8z3G4T3gh+40DH41v
         lbNyOqzy52GH/fPrAfaahdIdru8wmCcLcBHw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PkU2nF0bf0ig0+Ovi1RNPm0NnQeO/Bze0oV8LgroTYE=;
        b=NQHexCK0sA5L2pguy7igrd9nUw3SLNjUfqBJqNjWuhhIBY8ZYdh3jYWgX8ll7jKfdf
         YJ4HkRqSYYL1a1EiU4mtgZJ3pcVb6S1GNQA564BiXkJrtaOxdZ9m81jQyhU6iPYkgQlK
         FlUq+K4B8x3bPrva5u2F6k1O0DXrWi0D7SAqqr1ybH6fQG0HqtgvzK9BmH5JBtT1V+U8
         RybkiHwDmOhhAkRmz6ZKVNAvucnFVSVRHy2m9R/eWL/tPgn63TcWzcPyyJAs9rwI8eEF
         khphPUAsQpzZ1wPZSv6iDO1ZMFw1M335gxdDdOznIFvcwvZRqoOxnAkZAEpzsKYD3Cq7
         gHLQ==
X-Gm-Message-State: AOAM530ZSUDD7RAke7yWQ/rO8WuN9pBXSqE2BoTTpkyMqKVkZNV/QgSh
        xu6gm81htA0gxrKIAZCAdvVBUQ==
X-Google-Smtp-Source: ABdhPJyC9MVX3M9/sT/W2e4w4F0egFyUIln5HdPBydtLKWawLwvZBjobhwHOOpnVbO9xgGI90ctb1g==
X-Received: by 2002:a62:1706:: with SMTP id 6mr25921pfx.26.1598634518989;
        Fri, 28 Aug 2020 10:08:38 -0700 (PDT)
Received: from [10.136.8.253] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id p17sm2251665pfn.147.2020.08.28.10.08.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Aug 2020 10:08:38 -0700 (PDT)
Subject: Re: [PATCH 03/10] arm64: dts: broadcom: Fix SP805 clock-names
To:     Andre Przywara <andre.przywara@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Viresh Kumar <vireshk@kernel.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20200828130602.42203-1-andre.przywara@arm.com>
 <20200828130602.42203-4-andre.przywara@arm.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <078843e4-37af-4178-72c8-5ace4d85727e@broadcom.com>
Date:   Fri, 28 Aug 2020 10:08:36 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200828130602.42203-4-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/2020 6:05 AM, Andre Przywara wrote:
> The SP805 binding sets the name for the actual watchdog clock to
> "wdog_clk" (with an underscore).
> 
> Change the name in the DTs for Broadcom platforms to match that. The
> Linux and U-Boot driver use the *first* clock for this purpose anyway,
> so it does not break anything.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi    | 2 +-
>  arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
> index 15f7b0ed3836..6a5fc55f0a4e 100644
> --- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
> @@ -576,7 +576,7 @@
>  			reg = <0x66090000 0x1000>;
>  			interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&iprocslow>, <&iprocslow>;
> -			clock-names = "wdogclk", "apb_pclk";
> +			clock-names = "wdog_clk", "apb_pclk";
>  		};
>  
>  		gpio_g: gpio@660a0000 {
> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
> index 0098dfdef96c..b425b12c3ed2 100644
> --- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
> @@ -438,7 +438,7 @@
>  			reg = <0x000c0000 0x1000>;
>  			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
>  			clocks = <&hsls_25m_div2_clk>, <&hsls_div4_clk>;
> -			clock-names = "wdogclk", "apb_pclk";
> +			clock-names = "wdog_clk", "apb_pclk";
>  			timeout-sec = <60>;
>  		};
>  
> 

Although not currently used in the driver, this indeed should be fixed
to match DT documentation and be ready for future clock support in the
driver (i.e., getting clock by name).

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
