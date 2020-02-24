Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214C8C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7B8720838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P607In2F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgBXRG0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:06:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53374 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727727AbgBXRGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:06:25 -0500
Received: by mail-wm1-f65.google.com with SMTP id s10so66727wmh.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 09:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FV1+URIh0vJGkDR+Y3sgl5GcK5Z91KqhxIrgPs2m0DY=;
        b=P607In2Fd4CMWizhD2Dp+XgvX5J21OTVO3M/zrdlEnePBi1j+EdqlODhZk9VNI2RxS
         yV9vgn07rxiOxdi1oeTea2Vsanjsmsg3bW82s/rvoJoG6SgI8ZEbs8lCrjcUghuJGmxZ
         V68cEH3CyvgKFafmHF+ZfQH6hLLT/74AzJbQfCkCb6pjLtkw/aw7kdY6TzdqAShE7X+c
         0JrDF8xysaCATUr3QbFX4Sgjw7bkZ0Pdd+7KA1v4/2qi8+lO84pEeNlt1IqAkMjbthoy
         3tVV1RoKkOBtY8pQkss4G2RXfEakw1sJIPbvcIrOm544+8ebLT7GRCln9WOoLR+60HOO
         l8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FV1+URIh0vJGkDR+Y3sgl5GcK5Z91KqhxIrgPs2m0DY=;
        b=FnqlzIamc074OSebidkSOfsNqv2yyJNPlE2CdluBBwRn08AV9H6mqloCTbUlLJinOf
         Cxb0T32uh72tcKmHrzfyvR52AHoEOyFEaacMZWn/lo0xRACNOYiwruBCyCHaMwnissyP
         elOhIsgCj8ELE87l3EZYeunTo4jVF92WzEZODXBX+2i/yXeRqDfi/djVBgmxvyjAc4kR
         /EA+SUCTJcbsYT6rsZGiC3wm+HvoP8dPKhFWHejgMpPyuz1RCP9QHVInYQrJD/gbtqNr
         SI1fylPtRM2gzGXyWFTque8ueCr9A7mRlXsEPa/aEX++CBIY9av61zfQ9O2pKjJ6gDcS
         isrg==
X-Gm-Message-State: APjAAAXpMeNcXFzIMBFCeqW2OD32qG8A6kVJMpk0llTyOA7x6wCAnbuP
        9ztZtjVbaX2Mrdgt5jOgdzcoY/ZebMQ=
X-Google-Smtp-Source: APXvYqyvdVU6XrIfybjn/aVZi9uPZ1QB0thGmlars9DoePVBy4bV+vuFggKy8v0x+56p9oi82M1+1g==
X-Received: by 2002:a1c:610a:: with SMTP id v10mr50621wmb.44.1582563982624;
        Mon, 24 Feb 2020 09:06:22 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:545a:2a71:2add:41f7? ([2a01:e34:ed2f:f020:545a:2a71:2add:41f7])
        by smtp.googlemail.com with ESMTPSA id c77sm44829wmd.12.2020.02.24.09.06.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2020 09:06:21 -0800 (PST)
Subject: Re: [PATCH v2] ARM: dts: sun8i-a83t: Add thermal trip points/cooling
 maps
To:     Ondrej Jirman <megous@megous.com>, linux-sunxi@googlegroups.com
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200224165417.334617-1-megous@megous.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Autocrypt: addr=daniel.lezcano@linaro.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2e4213a6-2aaf-641c-f741-9503f3ffd5fe@linaro.org>
Date:   Mon, 24 Feb 2020 18:06:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200224165417.334617-1-megous@megous.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2020 17:54, Ondrej Jirman wrote:
> This enables passive cooling by down-regulating CPU voltage
> and frequency.
> 
> For the trip points, I used values from the BSP code directly.
> 
> The critical trip point value is 30°C above the maximum recommended
> ambient temperature (70°C) for the SoC from the datasheet, so there's
> some headroom even at such a high ambient temperature.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  arch/arm/boot/dts/sun8i-a83t.dtsi | 60 +++++++++++++++++++++++++++----
>  1 file changed, 54 insertions(+), 6 deletions(-)
> 
> v2:
> - added more detail to the commit description
> 
> diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
> index 74ac7ee9383cf..53c2b6a836f27 100644
> --- a/arch/arm/boot/dts/sun8i-a83t.dtsi
> +++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
> @@ -72,7 +72,7 @@ cpu0: cpu@0 {
>  			#cooling-cells = <2>;
>  		};
>  
> -		cpu@1 {
> +		cpu1: cpu@1 {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			clocks = <&ccu CLK_C0CPUX>;
> @@ -83,7 +83,7 @@ cpu@1 {
>  			#cooling-cells = <2>;
>  		};
>  
> -		cpu@2 {
> +		cpu2: cpu@2 {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			clocks = <&ccu CLK_C0CPUX>;
> @@ -94,7 +94,7 @@ cpu@2 {
>  			#cooling-cells = <2>;
>  		};
>  
> -		cpu@3 {
> +		cpu3: cpu@3 {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			clocks = <&ccu CLK_C0CPUX>;
> @@ -116,7 +116,7 @@ cpu100: cpu@100 {
>  			#cooling-cells = <2>;
>  		};
>  
> -		cpu@101 {
> +		cpu101: cpu@101 {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			clocks = <&ccu CLK_C1CPUX>;
> @@ -127,7 +127,7 @@ cpu@101 {
>  			#cooling-cells = <2>;
>  		};
>  
> -		cpu@102 {
> +		cpu102: cpu@102 {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			clocks = <&ccu CLK_C1CPUX>;
> @@ -138,7 +138,7 @@ cpu@102 {
>  			#cooling-cells = <2>;
>  		};
>  
> -		cpu@103 {
> +		cpu103: cpu@103 {
>  			compatible = "arm,cortex-a7";
>  			device_type = "cpu";
>  			clocks = <&ccu CLK_C1CPUX>;
> @@ -1188,12 +1188,60 @@ cpu0_thermal: cpu0-thermal {
>  			polling-delay-passive = <0>;
>  			polling-delay = <0>;
>  			thermal-sensors = <&ths 0>;
> +
> +			trips {
> +				cpu0_hot: cpu-hot {
> +					temperature = <80000>;
> +					hysteresis = <2000>;
> +					type = "passive";
> +				};
> +
> +				cpu0_very_hot: cpu-very-hot {
> +					temperature = <100000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				cpu-hot-limit {
> +					trip = <&cpu0_hot>;
> +					cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		cpu1_thermal: cpu1-thermal {
>  			polling-delay-passive = <0>;

No polling to mitigate?

>  			polling-delay = <0>;
>  			thermal-sensors = <&ths 1>;
> +
> +			trips {
> +				cpu1_hot: cpu-hot {
> +					temperature = <80000>;
> +					hysteresis = <2000>;
> +					type = "passive";

I'm curious, can you really reach this temperature with a cortex-a7
running at 1.2GHz max?

> +				};
> +
> +				cpu1_very_hot: cpu-very-hot {
> +					temperature = <100000>;
> +					hysteresis = <0>;
> +					type = "critical";
> +				};
> +			};
> +
> +			cooling-maps {
> +				cpu-hot-limit {
> +					trip = <&cpu1_hot>;
> +					cooling-device = <&cpu100 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu101 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu102 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
> +							 <&cpu103 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> +				};
> +			};
>  		};
>  
>  		gpu_thermal: gpu-thermal {
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

