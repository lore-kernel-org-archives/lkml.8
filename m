Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFCFC2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6EFC2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:16:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIv96XOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732599AbgDMRQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732565AbgDMRQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:16:07 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB1FC0A3BDC;
        Mon, 13 Apr 2020 10:16:05 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r26so10754353wmh.0;
        Mon, 13 Apr 2020 10:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K90EHEULDxs2VEjg7AxO3HdR5ULq8xDzhwmC5AQdzoA=;
        b=FIv96XOtDOVL3yxhhBo0iaFIggbSwiDjXFvUGOvQBz2aUnOyvK3vbEfx0wdcIzKHSy
         ODdcqnPdvIQWo8CMDPGDKMrshKr5F7PhcDLYLM+xGaAKT6KpvauxG/596qyyFlXUcs4e
         1+VRzwuh/LIvOnFiuWz5bvCwR1CWV5GqrlXSZCjX0wtvamMiqqhnxcANQBebuy6iOV91
         F+IBXeF8jycMeyuADjCr9ALJkwabS0ZxbApyjdDVLw2I18bvl2sLsNlrKN8drnWOfycF
         IORAHq0JUDpdGVeeC38YCbPptFjrAsmmE6KJKoM7rljgHBO/bGdEhDByYrygHV5JsA/d
         I5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K90EHEULDxs2VEjg7AxO3HdR5ULq8xDzhwmC5AQdzoA=;
        b=oXdIxdTCSVD3WBrSumDdsLi0DklBhV8JI3GJBYrHkaDYuGFsSexwlprTGNsE9hVwr1
         2N8TqlJTqk1rtPHUXdQibdgy7KRViwDWapqAErKzVHlL7spGjheN4VlW+kx+PjCR5qCG
         gqnYlJGgLNU3bqJhH0ZUiQglHSYk8MSPgZpISzrvLzoK/Y9hXf8IQ7Y0nJGFW20ybEKW
         qnapOMZMeVSNg7nGHIuziIwPhVDsDwAQwF5PHW+rvY7wXTWr/eB6rH88vccmx391lg+/
         qgC74Ss3w3YGO5I0GVEcVx4hz+QPY0KmaCDG11sN6rwJ4GjS7d6GqyoMvjJm3pBKDutv
         tiLA==
X-Gm-Message-State: AGi0PuZ/++UmDKzrloHvJTozc/3og2+sww0TMw5ySJUjGxPAlhsx+Ckn
        DSasnAuKBuOZjWyy6jwzUuA=
X-Google-Smtp-Source: APiQypIJffc6SWC4pzcb/hTyBG9xOkx7TovB6dE5SIrjdJ2tWqJRsfMj0cfEpbsZ5V5k98lzA88szw==
X-Received: by 2002:a1c:5502:: with SMTP id j2mr18984380wmb.71.1586798164385;
        Mon, 13 Apr 2020 10:16:04 -0700 (PDT)
Received: from linux-gy6r.site ([213.195.113.243])
        by smtp.gmail.com with ESMTPSA id q8sm14975550wmg.22.2020.04.13.10.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 10:16:03 -0700 (PDT)
Subject: Re: [PATCH v7 3/5] arm64: dts: mt8173: fix unit name warnings
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Kurtz <djkurtz@chromium.org>
References: <20200210063523.133333-1-hsinyi@chromium.org>
 <20200210063523.133333-4-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
X-Pep-Version: 2.0
Message-ID: <f4e23893-4b8c-deaa-5d5f-6f16f08cf8f4@gmail.com>
Date:   Mon, 13 Apr 2020 19:16:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200210063523.133333-4-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/20 7:35 AM, Hsin-Yi Wang wrote:
> Fixing several unit name warnings:
>=20
> Warning (unit_address_vs_reg): /oscillator@0: node has a unit name, but=
 no reg property
> Warning (unit_address_vs_reg): /oscillator@1: node has a unit name, but=
 no reg property
> Warning (unit_address_vs_reg): /oscillator@2: node has a unit name, but=
 no reg property
> Warning (unit_address_vs_reg): /thermal-zones/cpu_thermal/trips/trip-po=
int@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /thermal-zones/cpu_thermal/trips/trip-po=
int@1: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /thermal-zones/cpu_thermal/trips/cpu_cri=
t@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /thermal-zones/cpu_thermal/cooling-maps/=
map@0: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /thermal-zones/cpu_thermal/cooling-maps/=
map@1: node has a unit name, but no reg property
> Warning (unit_address_vs_reg): /reserved-memory/vpu_dma_mem_region: nod=
e has a reg or ranges property, but no unit name
> Warning (simple_bus_reg): /soc/pinctrl@10005000: simple-bus unit addres=
s format error, expected "1000b000"
> Warning (simple_bus_reg): /soc/interrupt-controller@10220000: simple-bu=
s unit address format error, expected "10221000"
> Warning (alias_paths): /aliases: aliases property name must include onl=
y lowercase and '-'
>=20
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 38 ++++++++++++------------=

>  1 file changed, 19 insertions(+), 19 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8173.dtsi
> index 790cd64aa447..2b7f566fb407 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -42,14 +42,14 @@ aliases {
>  		dpi0 =3D &dpi0;
>  		dsi0 =3D &dsi0;
>  		dsi1 =3D &dsi1;
> -		mdp_rdma0 =3D &mdp_rdma0;
> -		mdp_rdma1 =3D &mdp_rdma1;
> -		mdp_rsz0 =3D &mdp_rsz0;
> -		mdp_rsz1 =3D &mdp_rsz1;
> -		mdp_rsz2 =3D &mdp_rsz2;
> -		mdp_wdma0 =3D &mdp_wdma0;
> -		mdp_wrot0 =3D &mdp_wrot0;
> -		mdp_wrot1 =3D &mdp_wrot1;
> +		mdp-rdma0 =3D &mdp_rdma0;
> +		mdp-rdma1 =3D &mdp_rdma1;
> +		mdp-rsz0 =3D &mdp_rsz0;
> +		mdp-rsz1 =3D &mdp_rsz1;
> +		mdp-rsz2 =3D &mdp_rsz2;
> +		mdp-wdma0 =3D &mdp_wdma0;
> +		mdp-wrot0 =3D &mdp_wrot0;
> +		mdp-wrot1 =3D &mdp_wrot1;

As this needs to be fixed together with patch 5, and patch 5 is not yet
applied I dropped this part of the patch. Please resend this snipped and
patch 5 for.

The rest of it is applied to v5.7-next/dts64

Thanks!



>  		serial0 =3D &uart0;
>  		serial1 =3D &uart1;
>  		serial2 =3D &uart2;
> @@ -246,21 +246,21 @@ psci {
>  		cpu_on	      =3D <0x84000003>;
>  	};
> =20
> -	clk26m: oscillator@0 {
> +	clk26m: oscillator0 {
>  		compatible =3D "fixed-clock";
>  		#clock-cells =3D <0>;
>  		clock-frequency =3D <26000000>;
>  		clock-output-names =3D "clk26m";
>  	};
> =20
> -	clk32k: oscillator@1 {
> +	clk32k: oscillator1 {
>  		compatible =3D "fixed-clock";
>  		#clock-cells =3D <0>;
>  		clock-frequency =3D <32000>;
>  		clock-output-names =3D "clk32k";
>  	};
> =20
> -	cpum_ck: oscillator@2 {
> +	cpum_ck: oscillator2 {
>  		compatible =3D "fixed-clock";
>  		#clock-cells =3D <0>;
>  		clock-frequency =3D <0>;
> @@ -276,19 +276,19 @@ cpu_thermal: cpu_thermal {
>  			sustainable-power =3D <1500>; /* milliwatts */
> =20
>  			trips {
> -				threshold: trip-point@0 {
> +				threshold: trip-point0 {
>  					temperature =3D <68000>;
>  					hysteresis =3D <2000>;
>  					type =3D "passive";
>  				};
> =20
> -				target: trip-point@1 {
> +				target: trip-point1 {
>  					temperature =3D <85000>;
>  					hysteresis =3D <2000>;
>  					type =3D "passive";
>  				};
> =20
> -				cpu_crit: cpu_crit@0 {
> +				cpu_crit: cpu_crit0 {
>  					temperature =3D <115000>;
>  					hysteresis =3D <2000>;
>  					type =3D "critical";
> @@ -296,13 +296,13 @@ cpu_crit: cpu_crit@0 {
>  			};
> =20
>  			cooling-maps {
> -				map@0 {
> +				map0 {
>  					trip =3D <&target>;
>  					cooling-device =3D <&cpu0 0 0>,
>  							 <&cpu1 0 0>;
>  					contribution =3D <3072>;
>  				};
> -				map@1 {
> +				map1 {
>  					trip =3D <&target>;
>  					cooling-device =3D <&cpu2 0 0>,
>  							 <&cpu3 0 0>;
> @@ -316,7 +316,7 @@ reserved-memory {
>  		#address-cells =3D <2>;
>  		#size-cells =3D <2>;
>  		ranges;
> -		vpu_dma_reserved: vpu_dma_mem_region {
> +		vpu_dma_reserved: vpu_dma_mem_region@b7000000 {
>  			compatible =3D "shared-dma-pool";
>  			reg =3D <0 0xb7000000 0 0x500000>;
>  			alignment =3D <0x1000>;
> @@ -368,7 +368,7 @@ syscfg_pctl_a: syscfg_pctl_a@10005000 {
>  			reg =3D <0 0x10005000 0 0x1000>;
>  		};
> =20
> -		pio: pinctrl@10005000 {
> +		pio: pinctrl@1000b000 {
>  			compatible =3D "mediatek,mt8173-pinctrl";
>  			reg =3D <0 0x1000b000 0 0x1000>;
>  			mediatek,pctl-regmap =3D <&syscfg_pctl_a>;
> @@ -575,7 +575,7 @@ mipi_tx1: mipi-dphy@10216000 {
>  			status =3D "disabled";
>  		};
> =20
> -		gic: interrupt-controller@10220000 {
> +		gic: interrupt-controller@10221000 {
>  			compatible =3D "arm,gic-400";
>  			#interrupt-cells =3D <3>;
>  			interrupt-parent =3D <&gic>;
>=20

