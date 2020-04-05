Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7283BC2BA1B
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A5620659
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 11:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=megous.com header.i=@megous.com header.b="nlhymB+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgDELbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 07:31:48 -0400
Received: from vps.xff.cz ([195.181.215.36]:37570 "EHLO vps.xff.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgDELbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 07:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=megous.com; s=mail;
        t=1586086306; bh=dke9xyVpu/4Upjr6OYucKLOKfLnfaYRXQxjsbKJJ/Y0=;
        h=Date:From:To:Cc:Subject:References:X-My-GPG-KeyId:From;
        b=nlhymB+726DMdDbsKypIt3tV2pdi3zOxHtzdqT9K3s3gHvWHTueLD8bJWy8AURh9x
         bgCX4z+Mjd8xB5zNKPK54rPO5DNS+PDikjItt0GMU+ABuEQSS9f1dS4a7Bu1v9wRbx
         uEOsHaVh1uEOpy2CuPgD/aEiZNsekaZRhim3F+gk=
Date:   Sun, 5 Apr 2020 13:31:46 +0200
From:   =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
Subject: Re: [linux-sunxi] [PATCH 7/7] arm64: dts: allwinner: h6: Enable CPU
 and GPU opp tables for Beelink GS1
Message-ID: <20200405113146.be2etxxjdkgtrmac@core.my.home>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20200405104913.22806-1-peron.clem@gmail.com>
 <20200405104913.22806-8-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200405104913.22806-8-peron.clem@gmail.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Apr 05, 2020 at 12:49:13PM +0200, Clément Péron wrote:
> Enable CPU and GPU opp tables for Beelink GS1.
> 
> This needs also to change the CPU regulator min/max voltage to fit
> the OPP table.
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---
>  .../arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> index df6d872c34e2..8e65d56a7c85 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
> @@ -4,6 +4,8 @@
>  /dts-v1/;
>  
>  #include "sun50i-h6.dtsi"
> +#include "sun50i-h6-cpu-opp.dtsi"
> +#include "sun50i-h6-gpu-opp.dtsi"
>  
>  #include <dt-bindings/gpio/gpio.h>
>  
> @@ -70,6 +72,10 @@
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&reg_dcdca>;
> +};
> +
>  &de {
>  	status = "okay";
>  };
> @@ -226,8 +232,8 @@
>  
>  			reg_dcdca: dcdca {
>  				regulator-always-on;
> -				regulator-min-microvolt = <810000>;
> -				regulator-max-microvolt = <1080000>;
> +				regulator-min-microvolt = <820000>;
> +				regulator-max-microvolt = <1160000>;

The H6 datasheet says:

- VDD-CPU Power Supply for CPU  0.81 - 1.08 V (recommended)
- VDD-CPU Power Supply for CPU -0.30 - 1.30 V (abs max)

So I guess there's no need to increase the lower limit, because it matches
the datasheet already.

regards,
	o.

>  				regulator-name = "vdd-cpu";
>  			};
>  
> -- 
> 2.20.1
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe@googlegroups.com.
> To view this discussion on the web, visit https://groups.google.com/d/msgid/linux-sunxi/20200405104913.22806-8-peron.clem%40gmail.com.
