Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E3DAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB39F2074B
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 06:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXxFH89D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgFDGB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 02:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgFDGB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 02:01:58 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA87C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 23:01:57 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id j198so6028631wmj.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 23:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SMhseo1b443WDSU1XE2kxhJhUCJMigSWXu4SVLTvqlY=;
        b=PXxFH89DVFSsUNN1fEOetRSg7GRMpjCVxX96Y1u5C0VA3Bv1NxkUvT7oi9pMJCGCjn
         dzHuNSxmqr2RVp5YWd/UzBL9pA0rpx/dcawdVHwCbnGfJSWuYd827mKoBnoHPk9LUCQZ
         tWYfvF9F5YMfaBnKWL+3VCQYRk/K8nBFfrQFGbQfnu3KRTmnJ3KUwotiYEb33+XqUGhN
         pqTxxgbuNkixEx9dkBLeXW3lKJHmDFWBOCT71IECl4yHdVMLl8GTJWtKX6Z6/et/h1jd
         rcoxQIf4XhUVkOETEvTJxWT5cW4J4yaHRhZCpdgzUScct1AVc+Rp7GbCGvpddGRUjjvm
         RdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SMhseo1b443WDSU1XE2kxhJhUCJMigSWXu4SVLTvqlY=;
        b=a2448rZtxD0tPK2BDAKOCqlfvkpOFAgkNqFKBJqL/gtNU949ignlFFizQxZnJXd1Jj
         NWb4dxFjoI+kWbPGZjIxXSoYHZymO1jiSFNu8DVavl9tjwgzJ5L0kXxUmb+s+F2/sHrl
         osDXe/Ps6TZ34gK54yjR+UXs1oHNkpOjXyQTahgSWc7xS2SoXcV40KwnO3kxg9Ysmrqy
         Wh15xKsOHmrGYrH64/J0c2aN+vf8ni/+JUD6isPR7Wxp8iNeW0J+Nj4P2CrV0ggx9FFp
         TsMdaJRczSS5SHbRt8wHMjGrp5RY8eg9oleI+1bDUp7+sfGHa/o1hv+6zLRCdRSfli4y
         ZPIQ==
X-Gm-Message-State: AOAM532rV20ZpnKFMQj46aypNfxpM2I9Z0oiVh36KHaqL/2lumlDmOF4
        b/vBPqNKXZXhJmurYibhlTCeMw==
X-Google-Smtp-Source: ABdhPJwVVSic2nN1rgwIh3JmxkI8Mi+xVz+aL50zD7C/VLCspOapS1Nm7Uo7dmbOMvkaxgkTr1GyAA==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr2318890wmj.5.1591250515746;
        Wed, 03 Jun 2020 23:01:55 -0700 (PDT)
Received: from dell ([95.147.198.92])
        by smtp.gmail.com with ESMTPSA id e15sm6004933wme.9.2020.06.03.23.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 23:01:55 -0700 (PDT)
Date:   Thu, 4 Jun 2020 07:01:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Keerthy <j-keerthy@ti.com>, Axel Lin <axel.lin@ingics.com>
Subject: Re: [RFC 3/4] regulator: lp87565: dt: add LP87524-Q1 variant
Message-ID: <20200604060142.GQ3714@dell>
References: <20200603200319.16184-1-luca@lucaceresoli.net>
 <20200603200319.16184-4-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200603200319.16184-4-luca@lucaceresoli.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jun 2020, Luca Ceresoli wrote:

> Add the LP87524-Q1 to the lp87565 bindings document along with an example.

Keep the way to describe model numbers consistent.

I suggest LP87565 here (even though the filename is in lower case).

> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  .../devicetree/bindings/mfd/lp87565.txt       | 47 ++++++++++++++++++-

This is an MFD patch.

Please change the patch subject to reflect that.

>  1 file changed, 46 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/lp87565.txt b/Documentation/devicetree/bindings/mfd/lp87565.txt
> index b75ae23a1ef3..839eac6b75c2 100644
> --- a/Documentation/devicetree/bindings/mfd/lp87565.txt
> +++ b/Documentation/devicetree/bindings/mfd/lp87565.txt
> @@ -1,7 +1,8 @@
>  TI LP87565 PMIC MFD driver
>  
>  Required properties:
> -  - compatible:		one of "ti,lp87565", "ti,lp87565-q1", "ti,lp87561-q1"
> +  - compatible:		one of "ti,lp87565", "ti,lp87565-q1", "ti,lp87561-q1",
> +			"ti,lp87524-q1"

Maybe have 2 per line.  It would really help with my OCD!

>    - reg:		I2C slave address.
>    - gpio-controller:	Marks the device node as a GPIO Controller.
>    - #gpio-cells:	Should be two.  The first cell is the pin number and
> @@ -64,3 +65,47 @@ lp87561_pmic: pmic@62 {
>  		};
>  	};
>  };
> +
> +Example for the TI LP87524-Q1 PMIC (four 1-phase output configuration):
> +
> +lp87524_pmic: pmic@60 {
> +	compatible = "ti,lp87524-q1";
> +	reg = <0x60>;
> +	gpio-controller;
> +	#gpio-cells = <2>;
> +
> +	buck0-in-supply = <&vdd_5v0>;
> +	buck1-in-supply = <&vdd_5v0>;
> +	buck2-in-supply = <&vdd_5v0>;
> +	buck3-in-supply = <&vdd_5v0>;
> +
> +	regulators {
> +		buck0_reg: buck0 {
> +			regulator-name = "buck0";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +
> +		buck1_reg: buck1 {
> +			regulator-name = "buck1";
> +			regulator-min-microvolt = <1350000>;
> +			regulator-max-microvolt = <1350000>;
> +			regulator-always-on;
> +		};
> +
> +		buck2_reg: buck2 {
> +			regulator-name = "buck2";
> +			regulator-min-microvolt = <950000>;
> +			regulator-max-microvolt = <950000>;
> +			regulator-always-on;
> +		};
> +
> +		buck3_reg: buck3 {
> +			regulator-name = "buck3";
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <1800000>;
> +			regulator-always-on;
> +		};
> +	};
> +};

Patch looks okay, but Rob or Mark must review too.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
