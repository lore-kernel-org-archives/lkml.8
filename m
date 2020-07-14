Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44332C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE3B2240B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbgGNTEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:04:44 -0400
Received: from gloria.sntech.de ([185.11.138.130]:34614 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730335AbgGNTEm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:04:42 -0400
Received: from x2f7fa33.dyn.telefonica.de ([2.247.250.51] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jvQEI-0000LX-HB; Tue, 14 Jul 2020 21:04:38 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Suniel Mahesh <sunil@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-amarula <linux-amarula@amarulasolutions.com>
Subject: Re: [PATCH v5 1/4] arm64: dts: rockchip: Trivial cleanups for RockPI N10
Date:   Tue, 14 Jul 2020 21:04:37 +0200
Message-ID: <21801049.BKhHgEE1TG@phil>
In-Reply-To: <20200709100756.42384-2-jagan@amarulasolutions.com>
References: <20200709100756.42384-1-jagan@amarulasolutions.com> <20200709100756.42384-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 9. Juli 2020, 12:07:53 CEST schrieb Jagan Teki:
> Radxa dalang carrier boards are used to mount vmarc SoM's
> of rk3399pro and rk3288 to make complete SBC.
> 
> So, this patch adds trivial changes to properties.
> - move common properties into radxa dalang carrier dtsi.
> - maintain ascending order for nodes, properties.
> - change the order of dtsi include so-that common properties
>   will reflect in main dts.
> - drop unnecessary header includes.

can you please split this patch into bits at these marks?
(1) moving common
(2) sorting
...

It's hard to follow and especially verify.



> diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> index 0a516334f15f..9ed5b27d715c 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399pro-vmarc-som.dtsi
> @@ -7,35 +7,12 @@
>  
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/pinctrl/rockchip.h>
> -#include <dt-bindings/pwm/pwm.h>
>  
>  / {
>  	compatible = "vamrs,rk3399pro-vmarc-som", "rockchip,rk3399pro";
>  
> -	clkin_gmac: external-gmac-clock {
> -		compatible = "fixed-clock";
> -		clock-frequency = <125000000>;
> -		clock-output-names = "clkin_gmac";
> -		#clock-cells = <0>;
> -	};
> -
> -	vcc12v_dcin: vcc12v-dcin-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc12v_dcin";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <12000000>;
> -		regulator-max-microvolt = <12000000>;
> -	};
> -
> -	vcc5v0_sys: vcc5v0-sys-regulator {
> -		compatible = "regulator-fixed";
> -		regulator-name = "vcc5v0_sys";
> -		regulator-always-on;
> -		regulator-boot-on;
> -		regulator-min-microvolt = <5000000>;
> -		regulator-max-microvolt = <5000000>;
> -		vin-supply = <&vcc12v_dcin>;
> +	chosen {
> +		stdout-path = "serial2:1500000n8";

isn't chosen more a property of the individual board combination?
So to me this should live in the  rk3399pro-rock-pi-n10.dts .
As other board even using the rk3399pro variant may want to use
a different uart for serial output.

Heiko


