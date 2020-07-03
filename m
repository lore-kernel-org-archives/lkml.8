Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BF8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4413E20870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 06:08:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NgvbY5Jv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgGCGIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 02:08:32 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50604 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgGCGIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 02:08:30 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06368PtQ096953;
        Fri, 3 Jul 2020 01:08:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593756505;
        bh=yJknALxc+j+e8f3El12joS3SbOktHW6T8I/XDCqr6gw=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=NgvbY5JvazRfUIJbBb5KZiis3fA7ffVRoC/szW/31fgH2tXDa/hX/p5KJttIlXK6N
         xujUhI8y6MlooGHqiy37xgqtRgB5JoIyQsjyL/YGNDFFkVZs1HfNv2M5pH03n9Tq+Y
         P55v71MeKPN5RtwOVhZ07c0cF7AMXUiYxSp9V2dU=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06368PdN092611
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Jul 2020 01:08:25 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 3 Jul
 2020 01:08:24 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 3 Jul 2020 01:08:24 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06368MMx017740;
        Fri, 3 Jul 2020 01:08:23 -0500
Subject: Re: [PATCH 2/2] arm64: dts: ti: j721e-common-proc-board: Analog audio
 support
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <t-kristo@ti.com>, <nm@ti.com>
CC:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>
References: <20200702131424.21241-1-peter.ujfalusi@ti.com>
 <20200702131424.21241-3-peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <e8ea3796-93d6-da20-893e-a74161ebd2b7@ti.com>
Date:   Fri, 3 Jul 2020 09:09:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702131424.21241-3-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/07/2020 16.14, Peter Ujfalusi wrote:
> The codec is wired in multi DIN/DOUT setup (DIN1/2/3/4/DOUT1/2/3 is
> connected to McASP serializer).
>=20
> To support wide range of audio features a generic sound card can not be=

> used since we need to use different reference clock source for 44.1 and=

> 48 KHz family of sampling rates.
> Depending on the sample size we also need to use different slot width t=
o
> be able to support 16 and 24 bits.
>=20
> There are couple of notable difference compared to DIN1/DOUT1 mode:
> the channel mapping is 'random' for first look compared to the single
> serializer setup:
>         _      _      _
>        |o|c1  |o|p1  |o|p3
>  _     | |    | |    | |
> |o|c3  |o|c2  |o|p4  |o|p2
> ------------------------
>=20
> c1/2/3 - capture jacks (3rd is line)
> p1/2/3/4 - playback jacks (4th is line)
>=20
> 2 channel audio (stereo):
> 0 (left):  p1/c1 left
> 1 (right): p1/c1 right
>=20
> 4 channel audio:
> 0: p1/c1 left
> 1: p2/c2 left
> 2: p1/c1 right
> 3: p2/c2 right
>=20
> 6 channel audio
> 0: p1/c1 left
> 1: p2/c2 left
> 2: p3/c3 left
> 3: p1/c1 right
> 4: p2/c2 right
> 5: p3/c3 right
>=20
> 8 channel audio
> 0: p1/c1 left
> 1: p2/c2 left
> 2: p3/c3 left
> 3: p4 left
> 4: p1/c1 right
> 5: p2/c2 right
> 6: p3/c3 right
> 7: p4 right
>=20
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  .../dts/ti/k3-j721e-common-proc-board.dts     | 137 ++++++++++++++++++=

>  1 file changed, 137 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts b/ar=
ch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> index 1f1fee85acca..6c0f1ce6f4a6 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/net/ti-dp83867.h>
> +#include <dt-bindings/sound/ti-mcasp.h>

This include is not needed, I'll send v2 shortly.

> =20
>  / {
>  	chosen {
> @@ -34,6 +35,55 @@ sw11: sw11 {
>  			gpios =3D <&wkup_gpio0 7 GPIO_ACTIVE_LOW>;
>  		};
>  	};
> +
> +	evm_12v0: fixedregulator-evm12v0 {
> +		/* main supply */
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "evm_12v0";
> +		regulator-min-microvolt =3D <12000000>;
> +		regulator-max-microvolt =3D <12000000>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vsys_3v3: fixedregulator-vsys3v3 {
> +		/* Output of LMS140 */
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vsys_3v3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		vin-supply =3D <&evm_12v0>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	vsys_5v0: fixedregulator-vsys5v0 {
> +		/* Output of LM5140 */
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "vsys_5v0";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		vin-supply =3D <&evm_12v0>;
> +		regulator-always-on;
> +		regulator-boot-on;
> +	};
> +
> +	sound0: sound@0 {
> +		compatible =3D "ti,j721e-cpb-audio";
> +		model =3D "j721e-cpb";
> +
> +		ti,cpb-mcasp =3D <&mcasp10>;
> +		ti,cpb-codec =3D <&pcm3168a_1>;
> +
> +		clocks =3D <&k3_clks 184 1>,
> +			 <&k3_clks 184 2>, <&k3_clks 184 4>,
> +			 <&k3_clks 157 371>,
> +			 <&k3_clks 157 400>, <&k3_clks 157 401>;
> +		clock-names =3D "cpb-mcasp-auxclk",
> +			      "cpb-mcasp-auxclk-48000", "cpb-mcasp-auxclk-44100",
> +			      "cpb-codec-scki",
> +			      "cpb-codec-scki-48000", "cpb-codec-scki-44100";
> +	};
>  };
> =20
>  &main_pmx0 {
> @@ -102,6 +152,26 @@ J721E_IOPAD(0x1d0, PIN_INPUT_PULLUP, 2) /* (AA3) S=
PI0_D1.I2C6_SCL */
>  			J721E_IOPAD(0x1e4, PIN_INPUT_PULLUP, 2) /* (Y2) SPI1_D1.I2C6_SDA */=

>  		>;
>  	};
> +
> +	mcasp10_pins_default: mcasp10_pins_default {
> +		pinctrl-single,pins =3D <
> +			J721E_IOPAD(0x158, PIN_OUTPUT_PULLDOWN, 12) /* (U23) RGMII5_TX_CTL.=
MCASP10_ACLKX */
> +			J721E_IOPAD(0x15c, PIN_OUTPUT_PULLDOWN, 12) /* (U26) RGMII5_RX_CTL.=
MCASP10_AFSX */
> +			J721E_IOPAD(0x160, PIN_OUTPUT_PULLDOWN, 12) /* (V28) RGMII5_TD3.MCA=
SP10_AXR0 */
> +			J721E_IOPAD(0x164, PIN_OUTPUT_PULLDOWN, 12) /* (V29) RGMII5_TD2.MCA=
SP10_AXR1 */
> +			J721E_IOPAD(0x170, PIN_OUTPUT_PULLDOWN, 12) /* (U29) RGMII5_TXC.MCA=
SP10_AXR2 */
> +			J721E_IOPAD(0x174, PIN_OUTPUT_PULLDOWN, 12) /* (U25) RGMII5_RXC.MCA=
SP10_AXR3 */
> +			J721E_IOPAD(0x198, PIN_INPUT_PULLDOWN, 12) /* (V25) RGMII6_TD1.MCAS=
P10_AXR4 */
> +			J721E_IOPAD(0x19c, PIN_INPUT_PULLDOWN, 12) /* (W27) RGMII6_TD0.MCAS=
P10_AXR5 */
> +			J721E_IOPAD(0x1a0, PIN_INPUT_PULLDOWN, 12) /* (W29) RGMII6_TXC.MCAS=
P10_AXR6 */
> +		>;
> +	};
> +
> +	audi_ext_refclk2_pins_default: audi_ext_refclk2_pins_default {
> +		pinctrl-single,pins =3D <
> +			J721E_IOPAD(0x1a4, PIN_OUTPUT, 3) /* (W26) RGMII6_RXC.AUDIO_EXT_REF=
CLK2 */
> +		>;
> +	};
>  };
> =20
>  &wkup_pmx0 {
> @@ -401,6 +471,22 @@ exp2: gpio@22 {
>  		reg =3D <0x22>;
>  		gpio-controller;
>  		#gpio-cells =3D <2>;
> +
> +		p09 {
> +			/* P11 - MCASP/TRACE_MUX_S0 */
> +			gpio-hog;
> +			gpios =3D <9 GPIO_ACTIVE_HIGH>;
> +			output-low;
> +			line-name =3D "MCASP/TRACE_MUX_S0";
> +		};
> +
> +		p10 {
> +			/* P12 - MCASP/TRACE_MUX_S1 */
> +			gpio-hog;
> +			gpios =3D <10 GPIO_ACTIVE_HIGH>;
> +			output-high;
> +			line-name =3D "MCASP/TRACE_MUX_S1";
> +		};
>  	};
>  };
> =20
> @@ -423,6 +509,12 @@ exp4: gpio@20 {
>  	};
>  };
> =20
> +&k3_clks {
> +	/* Confiure AUDIO_EXT_REFCLK2 pin as output */
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&audi_ext_refclk2_pins_default>;
> +};
> +
>  &main_i2c3 {
>  	pinctrl-names =3D "default";
>  	pinctrl-0 =3D <&main_i2c3_pins_default>;
> @@ -434,6 +526,31 @@ exp3: gpio@20 {
>  		gpio-controller;
>  		#gpio-cells =3D <2>;
>  	};
> +
> +	pcm3168a_1: audio-codec@44 {
> +		compatible =3D "ti,pcm3168a";
> +		reg =3D <0x44>;
> +
> +		#sound-dai-cells =3D <1>;
> +
> +		reset-gpios =3D <&exp3 0 GPIO_ACTIVE_LOW>;
> +
> +		/* C_AUDIO_REFCLK2 -> RGMII6_RXC (W26) */
> +		clocks =3D <&k3_clks 157 371>;
> +		clock-names =3D "scki";
> +
> +		/* HSDIV3_16FFT_MAIN_4_HSDIVOUT2_CLK -> REFCLK2 */
> +		assigned-clocks =3D <&k3_clks 157 371>;
> +		assigned-clock-parents =3D <&k3_clks 157 400>;
> +		assigned-clock-rates =3D <24576000>; /* for 48KHz */
> +
> +		VDD1-supply =3D <&vsys_3v3>;
> +		VDD2-supply =3D <&vsys_3v3>;
> +		VCCAD1-supply =3D <&vsys_5v0>;
> +		VCCAD2-supply =3D <&vsys_5v0>;
> +		VCCDA1-supply =3D <&vsys_5v0>;
> +		VCCDA2-supply =3D <&vsys_5v0>;
> +	};
>  };
> =20
>  &main_i2c6 {
> @@ -486,3 +603,23 @@ &dss {
>  				 <&k3_clks 152 11>,	/* PLL18_HSDIV0 */
>  				 <&k3_clks 152 18>;	/* PLL23_HSDIV0 */
>  };
> +
> +&mcasp10 {
> +	#sound-dai-cells =3D <0>;
> +
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&mcasp10_pins_default>;
> +
> +	op-mode =3D <0>;          /* MCASP_IIS_MODE */
> +	tdm-slots =3D <2>;
> +	auxclk-fs-ratio =3D <256>;
> +
> +	serial-dir =3D <	/* 0: INACTIVE, 1: TX, 2: RX */
> +		1 1 1 1
> +		2 2 2 0
> +	>;
> +	tx-num-evt =3D <0>;
> +	rx-num-evt =3D <0>;
> +
> +	status =3D "okay";
> +};
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

