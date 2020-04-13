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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B978C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221D92072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIB/erdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732611AbgDMRQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732592AbgDMRQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:16:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEDEC0A3BDC;
        Mon, 13 Apr 2020 10:16:15 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d27so1713892wra.1;
        Mon, 13 Apr 2020 10:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PKuqst5fc3gMVYe7kT+wDBwlkpnKVmbjDeYv8izEq+Y=;
        b=IIB/erdxud0afAq98minKke5lm1bbPYfjGEkV3mynqrHDnLOz/bmy9ll0VdOgelrZ5
         GMBNkua1qxTJ4TJkNbVaJ2cEzxrJ+7xm0EFe3JBbkIOsfWs4ZiPLoBoXsDMsqH+OeCqP
         LN/5ZAc61IHfmMAmS89x4udGhs/C/QU0KepRmG9SxduxDbo+cRdazY9IIGL2EpbwWFfn
         R0if7NAIxmFnH4GDmmWaLE2FSz3Z9XlSHQtNHq4ZKXCLMT+KNhtkNhd65i9euDOdZCoS
         9YLXwLvGVqtZm4nti52CcwEtOLK3oOE3+WxOgwEgQfUNsrstw/gFPb4iYTY5yWID617j
         rdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PKuqst5fc3gMVYe7kT+wDBwlkpnKVmbjDeYv8izEq+Y=;
        b=EE0ECBfS/c+jgS+ufzgOwMWnEERJzzJKOepc22mqkThufbMQOMLWwJpi6r8A1k6Szh
         2k5S7SSeIzK4sWn5UPyn4FIOvX9+ee45DeBt/qq6u2fdOW8Tx8Q56HmZxZQTFbPUA4XY
         WFfTYZw/Ah6Z2q1Gs3IwXLNGpE+nRGTaK0vkmBOAa3eE6/h3p9r9XDe0OKygTxaj5TWP
         aIb1jVL8ykXj9nWVS6VunDbXAPHiDb0Q85eZUi1H8FTYPhxT5Cg7oJ1OrpFHDshvfZKS
         bFwWZPwNMmw5suo0IErEEjfXacnKi1bwpzqztSkkobTCaGTk8geLDzCQy4TscIH8rT+i
         cOpA==
X-Gm-Message-State: AGi0PuYNoraSjTwMenZKuHEp83APdXDE6gEY3dC9PR2OxJ0tLJNBxeSG
        jIFlBOhj/7XBrSeoyoO2kao=
X-Google-Smtp-Source: APiQypIN/7Rns/7d6ZVHNDsvCCAMg8S0lZ9XQQyWLCQugxUpI8Wnvv35wK7v32ddZ2Ee5bp3R90H9w==
X-Received: by 2002:a5d:5001:: with SMTP id e1mr17131219wrt.27.1586798174254;
        Mon, 13 Apr 2020 10:16:14 -0700 (PDT)
Received: from linux-gy6r.site ([213.195.113.243])
        by smtp.gmail.com with ESMTPSA id p6sm8188861wrt.3.2020.04.13.10.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 10:16:13 -0700 (PDT)
Subject: Re: [PATCH v7 4/5] arm64: dts: mediatek: add mt8173 elm and hana
 board
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
 <20200210063523.133333-5-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
X-Pep-Version: 2.0
Message-ID: <ee876788-0a05-94fd-d9ea-8648d78515ee@gmail.com>
Date:   Mon, 13 Apr 2020 19:16:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200210063523.133333-5-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/20 7:35 AM, Hsin-Yi Wang wrote:
> Elm is Acer Chromebook R13. Hana is Lenovo Chromebook. Both uses mt8173=

> SoC.
>=20
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied to v5.7-next/dts64

Thanks!

> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |    3 +
>  .../dts/mediatek/mt8173-elm-hana-rev7.dts     |   27 +
>  .../boot/dts/mediatek/mt8173-elm-hana.dts     |   14 +
>  .../boot/dts/mediatek/mt8173-elm-hana.dtsi    |   70 +
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dts   |   14 +
>  arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi  | 1173 +++++++++++++++++=

>  arch/arm64/boot/dts/mediatek/mt8173.dtsi      |    1 -
>  7 files changed, 1301 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.d=
ts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
>=20
> diff --git a/arch/arm64/boot/dts/mediatek/Makefile b/arch/arm64/boot/dt=
s/mediatek/Makefile
> index 458bbc422a94..b45a45a565a1 100644
> --- a/arch/arm64/boot/dts/mediatek/Makefile
> +++ b/arch/arm64/boot/dts/mediatek/Makefile
> @@ -6,5 +6,8 @@ dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6797-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt6797-x20-dev.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-rfb1.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt7622-bananapi-bpi-r64.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8173-elm.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8173-elm-hana.dtb
> +dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8173-elm-hana-rev7.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8173-evb.dtb
>  dtb-$(CONFIG_ARCH_MEDIATEK) +=3D mt8183-evb.dtb
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts b/ar=
ch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
> new file mode 100644
> index 000000000000..44f6149c1307
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana-rev7.dts
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2019 MediaTek Inc.
> + */
> +
> +/dts-v1/;
> +#include "mt8173-elm-hana.dtsi"
> +
> +/ {
> +	model =3D "Google Hanawl";
> +	compatible =3D "google,hana-rev7", "mediatek,mt8173";
> +};
> +
> +&cpu_thermal {
> +	trips {
> +		cpu_crit: cpu_crit0 {
> +			temperature =3D <100000>;
> +			type =3D "critical";
> +		};
> +	};
> +};
> +
> +&gpio_keys {
> +	/delete-node/tablet_mode;
> +	/delete-node/volume_down;
> +	/delete-node/volume_up;
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts b/arch/ar=
m64/boot/dts/mediatek/mt8173-elm-hana.dts
> new file mode 100644
> index 000000000000..c234296755e1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2016 MediaTek Inc.
> + */
> +
> +/dts-v1/;
> +#include "mt8173-elm-hana.dtsi"
> +
> +/ {
> +	model =3D "Google Hana";
> +	compatible =3D "google,hana-rev6", "google,hana-rev5",
> +		     "google,hana-rev4", "google,hana-rev3",
> +		     "google,hana", "mediatek,mt8173";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi b/arch/a=
rm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
> new file mode 100644
> index 000000000000..bdcd35cecad9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm-hana.dtsi
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2016 MediaTek Inc.
> + */
> +
> +#include "mt8173-elm.dtsi"
> +
> +&i2c0 {
> +	clock-frequency =3D <200000>;
> +};
> +
> +&i2c3 {
> +	touchscreen2: touchscreen@34 {
> +		compatible =3D "melfas,mip4_ts";
> +		reg =3D <0x34>;
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <88 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +
> +	/*
> +	 * Lenovo 100e Chromebook 2nd Gen (MTK) and Lenovo 300e Chromebook 2n=
d
> +	 * Gen (MTK) are using synaptics touchscreen (hid-over-i2c driver) as=
 a
> +	 * second source touchscreen.
> +	 */
> +	touchscreen3: touchscreen@20 {
> +		compatible =3D "hid-over-i2c";
> +		reg =3D <0x20>;
> +		hid-descr-addr =3D <0x0020>;
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <88 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&i2c4 {
> +	/*
> +	 * Lenovo 100e Chromebook 2nd Gen (MTK) and Lenovo 300e Chromebook 2n=
d
> +	 * Gen (MTK) are using synaptics trackpad (hid-over-i2c driver) as a
> +	 * second source trackpad.
> +	 */
> +	trackpad2: trackpad@2c {
> +		compatible =3D "hid-over-i2c";
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <117 IRQ_TYPE_LEVEL_LOW>;
> +		reg =3D <0x2c>;
> +		hid-descr-addr =3D <0x0020>;
> +		wakeup-source;
> +	};
> +};
> +
> +&mmc1 {
> +	wp-gpios =3D <&pio 42 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&pio {
> +	hdmi_mux_pins: hdmi_mux_pins {
> +		pins2 {
> +			pinmux =3D <MT8173_PIN_98_URTS1__FUNC_GPIO98>;
> +			bias-pull-up;
> +			output-high;
> +		};
> +	};
> +
> +	mmc1_pins_default: mmc1default {
> +		pins_wp {
> +			pinmux =3D <MT8173_PIN_42_DSI_TE__FUNC_GPIO42>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dts b/arch/arm64/b=
oot/dts/mediatek/mt8173-elm.dts
> new file mode 100644
> index 000000000000..e9e4ac0b74b2
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dts
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2016 MediaTek Inc.
> + */
> +
> +/dts-v1/;
> +#include "mt8173-elm.dtsi"
> +
> +/ {
> +	model =3D "Google Elm";
> +	compatible =3D "google,elm-rev8", "google,elm-rev7", "google,elm-rev6=
",
> +		     "google,elm-rev5", "google,elm-rev4", "google,elm-rev3",
> +		     "google,elm", "mediatek,mt8173";
> +};
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi b/arch/arm64/=
boot/dts/mediatek/mt8173-elm.dtsi
> new file mode 100644
> index 000000000000..a5a12b2599a4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-elm.dtsi
> @@ -0,0 +1,1173 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2016 MediaTek Inc.
> + */
> +
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/input/linux-event-codes.h>
> +#include <dt-bindings/gpio/gpio.h>
> +#include "mt8173.dtsi"
> +
> +/ {
> +	memory@40000000 {
> +		device_type =3D "memory";
> +		reg =3D <0 0x40000000 0 0x80000000>;
> +	};
> +
> +	backlight: backlight {
> +		compatible =3D "pwm-backlight";
> +		pwms =3D <&pwm0 0 1000000>;
> +		power-supply =3D <&bl_fixed_reg>;
> +		enable-gpios =3D <&pio 95 GPIO_ACTIVE_HIGH>;
> +
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&disp_pwm0_pins>;
> +		status =3D "okay";
> +	};
> +
> +	bl_fixed_reg: fixedregulator2 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "bl_fixed";
> +		regulator-min-microvolt =3D <1800000>;
> +		regulator-max-microvolt =3D <1800000>;
> +		startup-delay-us =3D <1000>;
> +		enable-active-high;
> +		gpio =3D <&pio 32 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&bl_fixed_pins>;
> +	};
> +
> +	chosen {
> +		stdout-path =3D "serial0:115200n8";
> +	};
> +
> +	gpio_keys: gpio-keys {
> +		compatible =3D "gpio-keys";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&gpio_keys_pins>;
> +
> +		lid {
> +			label =3D "Lid";
> +			gpios =3D <&pio 69 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <SW_LID>;
> +			linux,input-type =3D <EV_SW>;
> +			gpio-key,wakeup;
> +		};
> +
> +		power {
> +			label =3D "Power";
> +			gpios =3D <&pio 14 GPIO_ACTIVE_HIGH>;
> +			linux,code =3D <KEY_POWER>;
> +			debounce-interval =3D <30>;
> +			gpio-key,wakeup;
> +		};
> +
> +		tablet_mode {
> +			label =3D "Tablet_mode";
> +			gpios =3D <&pio 121 GPIO_ACTIVE_HIGH>;
> +			linux,code =3D <SW_TABLET_MODE>;
> +			linux,input-type =3D <EV_SW>;
> +			gpio-key,wakeup;
> +		};
> +
> +		volume_down {
> +			label =3D "Volume_down";
> +			gpios =3D <&pio 123 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_VOLUMEDOWN>;
> +		};
> +
> +		volume_up {
> +			label =3D "Volume_up";
> +			gpios =3D <&pio 124 GPIO_ACTIVE_LOW>;
> +			linux,code =3D <KEY_VOLUMEUP>;
> +		};
> +	};
> +
> +	panel: panel {
> +		compatible =3D "lg,lp120up1";
> +		power-supply =3D <&panel_fixed_3v3>;
> +		ddc-i2c-bus =3D <&i2c0>;
> +		backlight =3D <&backlight>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint =3D <&ps8640_out>;
> +			};
> +		};
> +	};
> +
> +	panel_fixed_3v3: regulator1 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "PANEL_3V3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		enable-active-high;
> +		gpio =3D <&pio 41 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&panel_fixed_pins>;
> +	};
> +
> +	ps8640_fixed_1v2: regulator2 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "PS8640_1V2";
> +		regulator-min-microvolt =3D <1200000>;
> +		regulator-max-microvolt =3D <1200000>;
> +		regulator-enable-ramp-delay =3D <2000>;
> +		enable-active-high;
> +		regulator-boot-on;
> +		gpio =3D <&pio 30 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&ps8640_fixed_pins>;
> +	};
> +
> +	sdio_fixed_3v3: fixedregulator0 {
> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "3V3";
> +		regulator-min-microvolt =3D <3300000>;
> +		regulator-max-microvolt =3D <3300000>;
> +		gpio =3D <&pio 85 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&sdio_fixed_3v3_pins>;
> +	};
> +
> +	sound: sound {
> +		compatible =3D "mediatek,mt8173-rt5650";
> +		mediatek,audio-codec =3D <&rt5650 &hdmi0>;
> +		mediatek,platform =3D <&afe>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&aud_i2s2>;
> +
> +		mediatek,mclk =3D <1>;
> +		codec-capture {
> +			sound-dai =3D <&rt5650 1>;
> +		};
> +	};
> +
> +	hdmicon: connector {
> +		compatible =3D "hdmi-connector";
> +		label =3D "hdmi";
> +		type =3D "a";
> +		ddc-i2c-bus =3D <&hdmiddc0>;
> +
> +		port {
> +			hdmi_connector_in: endpoint {
> +				remote-endpoint =3D <&hdmi0_out>;
> +			};
> +		};
> +	};
> +};
> +
> +&cec {
> +	status =3D "okay";
> +};
> +
> +&cpu0 {
> +	proc-supply =3D <&mt6397_vpca15_reg>;
> +};
> +
> +&cpu1 {
> +	proc-supply =3D <&mt6397_vpca15_reg>;
> +};
> +
> +&cpu2 {
> +	proc-supply =3D <&da9211_vcpu_reg>;
> +	sram-supply =3D <&mt6397_vsramca7_reg>;
> +};
> +
> +&cpu3 {
> +	proc-supply =3D <&da9211_vcpu_reg>;
> +	sram-supply =3D <&mt6397_vsramca7_reg>;
> +};
> +
> +&cpu_thermal {
> +	sustainable-power =3D <4500>; /* milliwatts */
> +	trips {
> +		threshold: trip-point0 {
> +			temperature =3D <60000>;
> +		};
> +
> +		target: trip-point1 {
> +			temperature =3D <65000>;
> +		};
> +	};
> +};
> +
> +&dsi0 {
> +	status =3D "okay";
> +	ports {
> +		port {
> +			dsi0_out: endpoint {
> +				remote-endpoint =3D <&ps8640_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&dpi0 {
> +	status =3D "okay";
> +};
> +
> +&hdmi0 {
> +	status =3D "okay";
> +	ports {
> +		port@1 {
> +			reg =3D <1>;
> +
> +			hdmi0_out: endpoint {
> +				remote-endpoint =3D <&hdmi_connector_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&hdmi_phy {
> +	status =3D "okay";
> +	mediatek,ibias =3D <0xc>;
> +};
> +
> +&i2c0 {
> +	status =3D "okay";
> +
> +	rt5650: audio-codec@1a {
> +		compatible =3D "realtek,rt5650";
> +		reg =3D <0x1a>;
> +		avdd-supply =3D <&mt6397_vgp1_reg>;
> +		cpvdd-supply =3D <&mt6397_vcama_reg>;
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <3 IRQ_TYPE_EDGE_BOTH>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&rt5650_irq>;
> +		#sound-dai-cells =3D <1>;
> +		realtek,dmic1-data-pin =3D <2>;
> +		realtek,jd-mode =3D <2>;
> +	};
> +
> +	ps8640: edp-bridge@8 {
> +		compatible =3D "parade,ps8640";
> +		reg =3D <0x8>;
> +		powerdown-gpios =3D <&pio 127 GPIO_ACTIVE_LOW>;
> +		reset-gpios =3D <&pio 115 GPIO_ACTIVE_LOW>;
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&ps8640_pins>;
> +		vdd12-supply =3D <&ps8640_fixed_1v2>;
> +		vdd33-supply =3D <&mt6397_vgp2_reg>;
> +
> +		ports {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			port@0 {
> +				reg =3D <0>;
> +
> +				ps8640_in: endpoint {
> +					remote-endpoint =3D <&dsi0_out>;
> +				};
> +			};
> +
> +			port@1 {
> +				reg =3D <1>;
> +
> +				ps8640_out: endpoint {
> +					remote-endpoint =3D <&panel_in>;
> +				};
> +			};
> +		};
> +	};
> +};
> +
> +&i2c1 {
> +	clock-frequency =3D <1500000>;
> +	status =3D "okay";
> +
> +	da9211: da9211@68 {
> +		compatible =3D "dlg,da9211";
> +		reg =3D <0x68>;
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <15 IRQ_TYPE_LEVEL_LOW>;
> +
> +		regulators {
> +			da9211_vcpu_reg: BUCKA {
> +				regulator-name =3D "VBUCKA";
> +				regulator-min-microvolt =3D < 700000>;
> +				regulator-max-microvolt =3D <1310000>;
> +				regulator-min-microamp  =3D <2000000>;
> +				regulator-max-microamp  =3D <4400000>;
> +				regulator-ramp-delay =3D <10000>;
> +				regulator-always-on;
> +				regulator-allowed-modes =3D <0 1>;
> +			};
> +
> +			da9211_vgpu_reg: BUCKB {
> +				regulator-name =3D "VBUCKB";
> +				regulator-min-microvolt =3D < 700000>;
> +				regulator-max-microvolt =3D <1310000>;
> +				regulator-min-microamp  =3D <2000000>;
> +				regulator-max-microamp  =3D <3000000>;
> +				regulator-ramp-delay =3D <10000>;
> +			};
> +		};
> +	};
> +};
> +
> +&i2c2 {
> +	status =3D "okay";
> +
> +	tpm: tpm@20 {
> +		compatible =3D "infineon,slb9645tt";
> +		reg =3D <0x20>;
> +		powered-while-suspended;
> +	};
> +};
> +
> +&i2c3 {
> +	clock-frequency =3D <400000>;
> +	status =3D "okay";
> +
> +	touchscreen: touchscreen@10 {
> +		compatible =3D "elan,ekth3500";
> +		reg =3D <0x10>;
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <88 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&i2c4 {
> +	clock-frequency =3D <400000>;
> +	status =3D "okay";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&trackpad_irq>;
> +
> +	trackpad: trackpad@15 {
> +		compatible =3D "elan,ekth3000";
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <117 IRQ_TYPE_LEVEL_LOW>;
> +		reg =3D <0x15>;
> +		vcc-supply =3D <&mt6397_vgp6_reg>;
> +		wakeup-source;
> +	};
> +};
> +
> +&mipi_tx0 {
> +	status =3D "okay";
> +};
> +
> +&mmc0 {
> +	status =3D "okay";
> +	pinctrl-names =3D "default", "state_uhs";
> +	pinctrl-0 =3D <&mmc0_pins_default>;
> +	pinctrl-1 =3D <&mmc0_pins_uhs>;
> +	bus-width =3D <8>;
> +	max-frequency =3D <200000000>;
> +	cap-mmc-highspeed;
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	cap-mmc-hw-reset;
> +	hs400-ds-delay =3D <0x14015>;
> +	mediatek,hs200-cmd-int-delay=3D<30>;
> +	mediatek,hs400-cmd-int-delay=3D<14>;
> +	mediatek,hs400-cmd-resp-sel-rising;
> +	vmmc-supply =3D <&mt6397_vemc_3v3_reg>;
> +	vqmmc-supply =3D <&mt6397_vio18_reg>;
> +	assigned-clocks =3D <&topckgen CLK_TOP_MSDC50_0_SEL>;
> +	assigned-clock-parents =3D <&topckgen CLK_TOP_MSDCPLL_D2>;
> +	non-removable;
> +};
> +
> +&mmc1 {
> +	status =3D "okay";
> +	pinctrl-names =3D "default", "state_uhs";
> +	pinctrl-0 =3D <&mmc1_pins_default>;
> +	pinctrl-1 =3D <&mmc1_pins_uhs>;
> +	bus-width =3D <4>;
> +	max-frequency =3D <200000000>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	cd-gpios =3D <&pio 1 GPIO_ACTIVE_LOW>;
> +	vmmc-supply =3D <&mt6397_vmch_reg>;
> +	vqmmc-supply =3D <&mt6397_vmc_reg>;
> +};
> +
> +&mmc3 {
> +	status =3D "okay";
> +	pinctrl-names =3D "default", "state_uhs";
> +	pinctrl-0 =3D <&mmc3_pins_default>;
> +	pinctrl-1 =3D <&mmc3_pins_uhs>;
> +	bus-width =3D <4>;
> +	max-frequency =3D <200000000>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	keep-power-in-suspend;
> +	enable-sdio-wakeup;
> +	cap-sdio-irq;
> +	vmmc-supply =3D <&sdio_fixed_3v3>;
> +	vqmmc-supply =3D <&mt6397_vgp3_reg>;
> +	non-removable;
> +	cap-power-off-card;
> +
> +	#address-cells =3D <1>;
> +	#size-cells =3D <0>;
> +
> +	btmrvl: btmrvl@2 {
> +		compatible =3D "marvell,sd8897-bt";
> +		reg =3D <2>;
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <119 IRQ_TYPE_LEVEL_LOW>;
> +		marvell,wakeup-pin =3D /bits/ 16 <0x0d>;
> +		marvell,wakeup-gap-ms =3D /bits/ 16 <0x64>;
> +	};
> +
> +	mwifiex: mwifiex@1 {
> +		compatible =3D "marvell,sd8897";
> +		reg =3D <1>;
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <38 IRQ_TYPE_LEVEL_LOW>;
> +		marvell,wakeup-pin =3D <3>;
> +	};
> +};
> +
> +&nor_flash {
> +	status =3D "okay";
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&nor_gpio1_pins>;
> +	bus-width =3D <8>;
> +	max-frequency =3D <50000000>;
> +	non-removable;
> +	flash@0 {
> +		compatible =3D "jedec,spi-nor";
> +		reg =3D <0>;
> +	};
> +};
> +
> +&pio {
> +	gpio-line-names =3D "EC_INT_1V8",
> +			  "SD_CD_L",
> +			  "ALC5514_IRQ",
> +			  "ALC5650_IRQ",
> +			  /*
> +			   * AP_FLASH_WP_L is crossystem ABI. Schematics
> +			   * call it SFWP_B.
> +			   */
> +			  "AP_FLASH_WP_L",
> +			  "SFIN",
> +			  "SFCS0",
> +			  "SFHOLD",
> +			  "SFOUT",
> +			  "SFCK",
> +			  "WRAP_EVENT_S_EINT10",
> +			  "PMU_INT",
> +			  "I2S2_WS_ALC5650",
> +			  "I2S2_BCK_ALC5650",
> +			  "PWR_BTN_1V8",
> +			  "DA9212_IRQ",
> +			  "IDDIG",
> +			  "WATCHDOG",
> +			  "CEC",
> +			  "HDMISCK",
> +			  "HDMISD",
> +			  "HTPLG",
> +			  "MSDC3_DAT0",
> +			  "MSDC3_DAT1",
> +			  "MSDC3_DAT2",
> +			  "MSDC3_DAT3",
> +			  "MSDC3_CLK",
> +			  "MSDC3_CMD",
> +			  "USB_C0_OC_FLAGB",
> +			  "USBA_OC1_L",
> +			  "PS8640_1V2_ENABLE",
> +			  "THERM_ALERT_N",
> +			  "PANEL_LCD_POWER_EN",
> +			  "ANX7688_CHIP_PD_C",
> +			  "EC_IN_RW_1V8",
> +			  "ANX7688_1V_EN_C",
> +			  "USB_DP_HPD_C",
> +			  "TPM_DAVINT_N",
> +			  "MARVELL8897_IRQ",
> +			  "EN_USB_A0_PWR",
> +			  "USBA_A0_OC_L",
> +			  "EN_PP3300_DX_EDP",
> +			  "",
> +			  "SOC_I2C2_1V8_SDA_400K",
> +			  "SOC_I2C2_1V8_SCL_400K",
> +			  "SOC_I2C0_1V8_SDA_400K",
> +			  "SOC_I2C0_1V8_SCL_400K",
> +			  "EMMC_ID1",
> +			  "EMMC_ID0",
> +			  "MEM_CONFIG3",
> +			  "EMMC_ID2",
> +			  "MEM_CONFIG1",
> +			  "MEM_CONFIG2",
> +			  "BRD_ID2",
> +			  "MEM_CONFIG0",
> +			  "BRD_ID0",
> +			  "BRD_ID1",
> +			  "EMMC_DAT0",
> +			  "EMMC_DAT1",
> +			  "EMMC_DAT2",
> +			  "EMMC_DAT3",
> +			  "EMMC_DAT4",
> +			  "EMMC_DAT5",
> +			  "EMMC_DAT6",
> +			  "EMMC_DAT7",
> +			  "EMMC_CLK",
> +			  "EMMC_CMD",
> +			  "EMMC_RCLK",
> +			  "PLT_RST_L",
> +			  "LID_OPEN_1V8_L",
> +			  "AUDIO_SPI_MISO_R",
> +			  "",
> +			  "AC_OK_1V8",
> +			  "SD_DATA0",
> +			  "SD_DATA1",
> +			  "SD_DATA2",
> +			  "SD_DATA3",
> +			  "SD_CLK",
> +			  "SD_CMD",
> +			  "PWRAP_SPI0_MI",
> +			  "PWRAP_SPI0_MO",
> +			  "PWRAP_SPI0_CK",
> +			  "PWRAP_SPI0_CSN",
> +			  "",
> +			  "",
> +			  "WIFI_PDN",
> +			  "RTC32K_1V8",
> +			  "DISP_PWM0",
> +			  "TOUCHSCREEN_INT_L",
> +			  "",
> +			  "SRCLKENA0",
> +			  "SRCLKENA1",
> +			  "PS8640_MODE_CONF",
> +			  "TOUCHSCREEN_RESET_R",
> +			  "PLATFORM_PROCHOT_L",
> +			  "PANEL_POWER_EN",
> +			  "REC_MODE_L",
> +			  "EC_FW_UPDATE_L",
> +			  "ACCEL2_INT_L",
> +			  "HDMI_DP_INT",
> +			  "ACCELGYRO3_INT_L",
> +			  "ACCELGYRO4_INT_L",
> +			  "SPI_EC_CLK",
> +			  "SPI_EC_MI",
> +			  "SPI_EC_MO",
> +			  "SPI_EC_CSN",
> +			  "SOC_I2C3_1V8_SDA_400K",
> +			  "SOC_I2C3_1V8_SCL_400K",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "",
> +			  "PS8640_SYSRSTN_1V8",
> +			  "APIN_MAX98090_DOUT2",
> +			  "TP_INT_1V8_L_R",
> +			  "RST_USB_HUB_R",
> +			  "BT_WAKE_L",
> +			  "ACCEL1_INT_L",
> +			  "TABLET_MODE_L",
> +			  "",
> +			  "V_UP_IN_L_R",
> +			  "V_DOWN_IN_L_R",
> +			  "SOC_I2C1_1V8_SDA_1M",
> +			  "SOC_I2C1_1V8_SCL_1M",
> +			  "PS8640_PDN_1V8",
> +			  "MAX98090_LRCLK",
> +			  "MAX98090_BCLK",
> +			  "MAX98090_MCLK",
> +			  "APOUT_MAX98090_DIN",
> +			  "APIN_MAX98090_DOUT",
> +			  "SOC_I2C4_1V8_SDA_400K",
> +			  "SOC_I2C4_1V8_SCL_400K";
> +
> +	aud_i2s2: aud_i2s2 {
> +		pins1 {
> +			pinmux =3D <MT8173_PIN_128_I2S0_LRCK__FUNC_I2S1_WS>,
> +				 <MT8173_PIN_129_I2S0_BCK__FUNC_I2S1_BCK>,
> +				 <MT8173_PIN_130_I2S0_MCK__FUNC_I2S1_MCK>,
> +				 <MT8173_PIN_131_I2S0_DATA0__FUNC_I2S1_DO_1>,
> +				 <MT8173_PIN_12_EINT12__FUNC_I2S2_WS>,
> +				 <MT8173_PIN_13_EINT13__FUNC_I2S2_BCK>,
> +				 <MT8173_PIN_132_I2S0_DATA1__FUNC_I2S2_DI_2>;
> +			bias-pull-down;
> +		};
> +	};
> +
> +	bl_fixed_pins: bl_fixed_pins {
> +		pins1 {
> +			pinmux =3D <MT8173_PIN_32_UTXD2__FUNC_GPIO32>;
> +			output-low;
> +		};
> +	};
> +
> +	bt_wake_pins: bt_wake_pins {
> +		pins1 {
> +			pinmux =3D <MT8173_PIN_119_KPROW0__FUNC_GPIO119>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	disp_pwm0_pins: disp_pwm0_pins {
> +		pins1 {
> +			pinmux =3D <MT8173_PIN_87_DISP_PWM0__FUNC_DISP_PWM0>;
> +			output-low;
> +		};
> +	};
> +
> +	gpio_keys_pins: gpio_keys_pins {
> +		volume_pins {
> +			pinmux =3D <MT8173_PIN_123_KPCOL1__FUNC_GPIO123>,
> +				 <MT8173_PIN_124_KPCOL2__FUNC_GPIO124>;
> +			bias-pull-up;
> +		};
> +
> +		tablet_mode_pins {
> +			pinmux =3D <MT8173_PIN_121_KPROW2__FUNC_GPIO121>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	hdmi_mux_pins: hdmi_mux_pins {
> +		pins1 {
> +			pinmux =3D <MT8173_PIN_36_DAISYNC__FUNC_GPIO36>;
> +		};
> +	};
> +
> +	i2c1_pins_a: i2c1 {
> +		da9211_pins {
> +			pinmux =3D <MT8173_PIN_15_EINT15__FUNC_GPIO15>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	mmc0_pins_default: mmc0default {
> +		pins_cmd_dat {
> +			pinmux =3D <MT8173_PIN_57_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
> +				 <MT8173_PIN_58_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
> +				 <MT8173_PIN_59_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
> +				 <MT8173_PIN_60_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
> +				 <MT8173_PIN_61_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
> +				 <MT8173_PIN_62_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
> +				 <MT8173_PIN_63_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
> +				 <MT8173_PIN_64_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
> +				 <MT8173_PIN_66_MSDC0_CMD__FUNC_MSDC0_CMD>;
> +			bias-pull-up;
> +		};
> +
> +		pins_clk {
> +			pinmux =3D <MT8173_PIN_65_MSDC0_CLK__FUNC_MSDC0_CLK>;
> +			bias-pull-down;
> +		};
> +
> +		pins_rst {
> +			pinmux =3D <MT8173_PIN_68_MSDC0_RST___FUNC_MSDC0_RSTB>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	mmc1_pins_default: mmc1default {
> +		pins_cmd_dat {
> +			pinmux =3D <MT8173_PIN_73_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
> +				 <MT8173_PIN_74_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
> +				 <MT8173_PIN_75_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
> +				 <MT8173_PIN_76_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
> +				 <MT8173_PIN_78_MSDC1_CMD__FUNC_MSDC1_CMD>;
> +			input-enable;
> +			drive-strength =3D <MTK_DRIVE_4mA>;
> +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins_clk {
> +			pinmux =3D <MT8173_PIN_77_MSDC1_CLK__FUNC_MSDC1_CLK>;
> +			bias-pull-down;
> +			drive-strength =3D <MTK_DRIVE_4mA>;
> +		};
> +
> +		pins_insert {
> +			pinmux =3D <MT8173_PIN_1_EINT1__FUNC_GPIO1>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	mmc3_pins_default: mmc3default {
> +		pins_dat {
> +			pinmux =3D <MT8173_PIN_22_MSDC3_DAT0__FUNC_MSDC3_DAT0>,
> +				 <MT8173_PIN_23_MSDC3_DAT1__FUNC_MSDC3_DAT1>,
> +				 <MT8173_PIN_24_MSDC3_DAT2__FUNC_MSDC3_DAT2>,
> +				 <MT8173_PIN_25_MSDC3_DAT3__FUNC_MSDC3_DAT3>;
> +			input-enable;
> +			drive-strength =3D <MTK_DRIVE_8mA>;
> +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins_cmd {
> +			pinmux =3D <MT8173_PIN_27_MSDC3_CMD__FUNC_MSDC3_CMD>;
> +			input-enable;
> +			drive-strength =3D <MTK_DRIVE_8mA>;
> +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins_clk {
> +			pinmux =3D <MT8173_PIN_26_MSDC3_CLK__FUNC_MSDC3_CLK>;
> +			bias-pull-down;
> +			drive-strength =3D <MTK_DRIVE_8mA>;
> +		};
> +	};
> +
> +	mmc0_pins_uhs: mmc0 {
> +		pins_cmd_dat {
> +			pinmux =3D <MT8173_PIN_57_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
> +				 <MT8173_PIN_58_MSDC0_DAT1__FUNC_MSDC0_DAT1>,
> +				 <MT8173_PIN_59_MSDC0_DAT2__FUNC_MSDC0_DAT2>,
> +				 <MT8173_PIN_60_MSDC0_DAT3__FUNC_MSDC0_DAT3>,
> +				 <MT8173_PIN_61_MSDC0_DAT4__FUNC_MSDC0_DAT4>,
> +				 <MT8173_PIN_62_MSDC0_DAT5__FUNC_MSDC0_DAT5>,
> +				 <MT8173_PIN_63_MSDC0_DAT6__FUNC_MSDC0_DAT6>,
> +				 <MT8173_PIN_64_MSDC0_DAT7__FUNC_MSDC0_DAT7>,
> +				 <MT8173_PIN_66_MSDC0_CMD__FUNC_MSDC0_CMD>;
> +			input-enable;
> +			drive-strength =3D <MTK_DRIVE_6mA>;
> +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins_clk {
> +			pinmux =3D <MT8173_PIN_65_MSDC0_CLK__FUNC_MSDC0_CLK>;
> +			drive-strength =3D <MTK_DRIVE_6mA>;
> +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins_ds {
> +			pinmux =3D <MT8173_PIN_67_MSDC0_DSL__FUNC_MSDC0_DSL>;
> +			drive-strength =3D <MTK_DRIVE_10mA>;
> +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_01>;
> +		};
> +
> +		pins_rst {
> +			pinmux =3D <MT8173_PIN_68_MSDC0_RST___FUNC_MSDC0_RSTB>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	mmc1_pins_uhs: mmc1 {
> +		pins_cmd_dat {
> +			pinmux =3D <MT8173_PIN_73_MSDC1_DAT0__FUNC_MSDC1_DAT0>,
> +				 <MT8173_PIN_74_MSDC1_DAT1__FUNC_MSDC1_DAT1>,
> +				 <MT8173_PIN_75_MSDC1_DAT2__FUNC_MSDC1_DAT2>,
> +				 <MT8173_PIN_76_MSDC1_DAT3__FUNC_MSDC1_DAT3>,
> +				 <MT8173_PIN_78_MSDC1_CMD__FUNC_MSDC1_CMD>;
> +			input-enable;
> +			drive-strength =3D <MTK_DRIVE_6mA>;
> +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins_clk {
> +			pinmux =3D <MT8173_PIN_77_MSDC1_CLK__FUNC_MSDC1_CLK>;
> +			drive-strength =3D <MTK_DRIVE_8mA>;
> +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +		};
> +	};
> +
> +	mmc3_pins_uhs: mmc3 {
> +		pins_dat {
> +			pinmux =3D <MT8173_PIN_22_MSDC3_DAT0__FUNC_MSDC3_DAT0>,
> +				 <MT8173_PIN_23_MSDC3_DAT1__FUNC_MSDC3_DAT1>,
> +				 <MT8173_PIN_24_MSDC3_DAT2__FUNC_MSDC3_DAT2>,
> +				 <MT8173_PIN_25_MSDC3_DAT3__FUNC_MSDC3_DAT3>;
> +			input-enable;
> +			drive-strength =3D <MTK_DRIVE_8mA>;
> +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins_cmd {
> +			pinmux =3D <MT8173_PIN_27_MSDC3_CMD__FUNC_MSDC3_CMD>;
> +			input-enable;
> +			drive-strength =3D <MTK_DRIVE_8mA>;
> +			bias-pull-up =3D <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins_clk {
> +			pinmux =3D <MT8173_PIN_26_MSDC3_CLK__FUNC_MSDC3_CLK>;
> +			drive-strength =3D <MTK_DRIVE_8mA>;
> +			bias-pull-down =3D <MTK_PUPD_SET_R1R0_10>;
> +		};
> +	};
> +
> +	nor_gpio1_pins: nor {
> +		pins1 {
> +			pinmux =3D <MT8173_PIN_6_EINT6__FUNC_SFCS0>,
> +				 <MT8173_PIN_7_EINT7__FUNC_SFHOLD>,
> +				 <MT8173_PIN_8_EINT8__FUNC_SFIN>;
> +			input-enable;
> +			drive-strength =3D <MTK_DRIVE_4mA>;
> +			bias-pull-up;
> +		};
> +
> +		pins2 {
> +			pinmux =3D <MT8173_PIN_5_EINT5__FUNC_SFOUT>;
> +			drive-strength =3D <MTK_DRIVE_4mA>;
> +			bias-pull-up;
> +		};
> +
> +		pins_clk {
> +			pinmux =3D <MT8173_PIN_9_EINT9__FUNC_SFCK>;
> +			input-enable;
> +			drive-strength =3D <MTK_DRIVE_4mA>;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	panel_fixed_pins: panel_fixed_pins {
> +		pins1 {
> +			pinmux =3D <MT8173_PIN_41_CMMCLK__FUNC_GPIO41>;
> +		};
> +	};
> +
> +	ps8640_pins: ps8640_pins {
> +		pins1 {
> +			pinmux =3D <MT8173_PIN_92_PCM_CLK__FUNC_GPIO92>,
> +				 <MT8173_PIN_115_URTS0__FUNC_GPIO115>,
> +				 <MT8173_PIN_127_LCM_RST__FUNC_GPIO127>;
> +		};
> +	};
> +
> +	ps8640_fixed_pins: ps8640_fixed_pins {
> +		pins1 {
> +			pinmux =3D <MT8173_PIN_30_URTS2__FUNC_GPIO30>;
> +		};
> +	};
> +
> +	rt5650_irq: rt5650_irq {
> +		pins1 {
> +			pinmux =3D <MT8173_PIN_3_EINT3__FUNC_GPIO3>;
> +			bias-pull-down;
> +		};
> +	};
> +
> +	sdio_fixed_3v3_pins: sdio_fixed_3v3_pins {
> +		pins1 {
> +			pinmux =3D <MT8173_PIN_85_AUD_DAT_MOSI__FUNC_GPIO85>;
> +			output-low;
> +		};
> +	};
> +
> +	spi_pins_a: spi1 {
> +		pins1 {
> +			pinmux =3D <MT8173_PIN_0_EINT0__FUNC_GPIO0>;
> +			bias-pull-up;
> +		};
> +
> +		pins_spi {
> +			pinmux =3D <MT8173_PIN_102_MSDC2_DAT2__FUNC_SPI_CK_1_>,
> +				 <MT8173_PIN_103_MSDC2_DAT3__FUNC_SPI_MI_1_>,
> +				 <MT8173_PIN_104_MSDC2_CLK__FUNC_SPI_MO_1_>,
> +				 <MT8173_PIN_105_MSDC2_CMD__FUNC_SPI_CS_1_>;
> +			bias-disable;
> +		};
> +	};
> +
> +	trackpad_irq: trackpad_irq {
> +		pins1 {
> +			pinmux =3D <MT8173_PIN_117_URXD3__FUNC_GPIO117>;
> +			input-enable;
> +			bias-pull-up;
> +		};
> +	};
> +
> +	usb_pins: usb {
> +		pins1 {
> +			pinmux =3D <MT8173_PIN_101_MSDC2_DAT1__FUNC_GPIO101>;
> +			output-high;
> +			bias-disable;
> +		};
> +	};
> +
> +	wifi_wake_pins: wifi_wake_pins {
> +		pins1 {
> +			pinmux =3D <MT8173_PIN_38_CONN_RST__FUNC_GPIO38>;
> +			bias-pull-up;
> +		};
> +	};
> +};
> +
> +&pwm0 {
> +	status =3D "okay";
> +};
> +
> +&pwrap {
> +	pmic: mt6397 {
> +		compatible =3D "mediatek,mt6397";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <1>;
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <11 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-controller;
> +		#interrupt-cells =3D <2>;
> +
> +		clock: mt6397clock {
> +			compatible =3D "mediatek,mt6397-clk";
> +			#clock-cells =3D <1>;
> +		};
> +
> +		pio6397: pinctrl {
> +			compatible =3D "mediatek,mt6397-pinctrl";
> +			pins-are-numbered;
> +			gpio-controller;
> +			#gpio-cells =3D <2>;
> +		};
> +
> +		regulator: mt6397regulator {
> +			compatible =3D "mediatek,mt6397-regulator";
> +
> +			mt6397_vpca15_reg: buck_vpca15 {
> +				regulator-compatible =3D "buck_vpca15";
> +				regulator-name =3D "vpca15";
> +				regulator-min-microvolt =3D < 700000>;
> +				regulator-max-microvolt =3D <1350000>;
> +				regulator-ramp-delay =3D <12500>;
> +				regulator-always-on;
> +				regulator-allowed-modes =3D <0 1>;
> +			};
> +
> +			mt6397_vpca7_reg: buck_vpca7 {
> +				regulator-compatible =3D "buck_vpca7";
> +				regulator-name =3D "vpca7";
> +				regulator-min-microvolt =3D < 700000>;
> +				regulator-max-microvolt =3D <1350000>;
> +				regulator-ramp-delay =3D <12500>;
> +				regulator-enable-ramp-delay =3D <115>;
> +				regulator-always-on;
> +			};
> +
> +			mt6397_vsramca15_reg: buck_vsramca15 {
> +				regulator-compatible =3D "buck_vsramca15";
> +				regulator-name =3D "vsramca15";
> +				regulator-min-microvolt =3D < 700000>;
> +				regulator-max-microvolt =3D <1350000>;
> +				regulator-ramp-delay =3D <12500>;
> +				regulator-always-on;
> +			};
> +
> +			mt6397_vsramca7_reg: buck_vsramca7 {
> +				regulator-compatible =3D "buck_vsramca7";
> +				regulator-name =3D "vsramca7";
> +				regulator-min-microvolt =3D < 700000>;
> +				regulator-max-microvolt =3D <1350000>;
> +				regulator-ramp-delay =3D <12500>;
> +				regulator-always-on;
> +			};
> +
> +			mt6397_vcore_reg: buck_vcore {
> +				regulator-compatible =3D "buck_vcore";
> +				regulator-name =3D "vcore";
> +				regulator-min-microvolt =3D < 700000>;
> +				regulator-max-microvolt =3D <1350000>;
> +				regulator-ramp-delay =3D <12500>;
> +				regulator-always-on;
> +			};
> +
> +			mt6397_vgpu_reg: buck_vgpu {
> +				regulator-compatible =3D "buck_vgpu";
> +				regulator-name =3D "vgpu";
> +				regulator-min-microvolt =3D < 700000>;
> +				regulator-max-microvolt =3D <1350000>;
> +				regulator-ramp-delay =3D <12500>;
> +				regulator-enable-ramp-delay =3D <115>;
> +			};
> +
> +			mt6397_vdrm_reg: buck_vdrm {
> +				regulator-compatible =3D "buck_vdrm";
> +				regulator-name =3D "vdrm";
> +				regulator-min-microvolt =3D <1200000>;
> +				regulator-max-microvolt =3D <1400000>;
> +				regulator-ramp-delay =3D <12500>;
> +				regulator-always-on;
> +			};
> +
> +			mt6397_vio18_reg: buck_vio18 {
> +				regulator-compatible =3D "buck_vio18";
> +				regulator-name =3D "vio18";
> +				regulator-min-microvolt =3D <1620000>;
> +				regulator-max-microvolt =3D <1980000>;
> +				regulator-ramp-delay =3D <12500>;
> +				regulator-always-on;
> +			};
> +
> +			mt6397_vtcxo_reg: ldo_vtcxo {
> +				regulator-compatible =3D "ldo_vtcxo";
> +				regulator-name =3D "vtcxo";
> +				regulator-always-on;
> +			};
> +
> +			mt6397_va28_reg: ldo_va28 {
> +				regulator-compatible =3D "ldo_va28";
> +				regulator-name =3D "va28";
> +			};
> +
> +			mt6397_vcama_reg: ldo_vcama {
> +				regulator-compatible =3D "ldo_vcama";
> +				regulator-name =3D "vcama";
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-enable-ramp-delay =3D <218>;
> +			};
> +
> +			mt6397_vio28_reg: ldo_vio28 {
> +				regulator-compatible =3D "ldo_vio28";
> +				regulator-name =3D "vio28";
> +				regulator-always-on;
> +			};
> +
> +			mt6397_vusb_reg: ldo_vusb {
> +				regulator-compatible =3D "ldo_vusb";
> +				regulator-name =3D "vusb";
> +			};
> +
> +			mt6397_vmc_reg: ldo_vmc {
> +				regulator-compatible =3D "ldo_vmc";
> +				regulator-name =3D "vmc";
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-enable-ramp-delay =3D <218>;
> +			};
> +
> +			mt6397_vmch_reg: ldo_vmch {
> +				regulator-compatible =3D "ldo_vmch";
> +				regulator-name =3D "vmch";
> +				regulator-min-microvolt =3D <3000000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-enable-ramp-delay =3D <218>;
> +			};
> +
> +			mt6397_vemc_3v3_reg: ldo_vemc3v3 {
> +				regulator-compatible =3D "ldo_vemc3v3";
> +				regulator-name =3D "vemc_3v3";
> +				regulator-min-microvolt =3D <3000000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-enable-ramp-delay =3D <218>;
> +			};
> +
> +			mt6397_vgp1_reg: ldo_vgp1 {
> +				regulator-compatible =3D "ldo_vgp1";
> +				regulator-name =3D "vcamd";
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-enable-ramp-delay =3D <240>;
> +			};
> +
> +			mt6397_vgp2_reg: ldo_vgp2 {
> +				regulator-compatible =3D "ldo_vgp2";
> +				regulator-name =3D "vcamio";
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-enable-ramp-delay =3D <218>;
> +			};
> +
> +			mt6397_vgp3_reg: ldo_vgp3 {
> +				regulator-compatible =3D "ldo_vgp3";
> +				regulator-name =3D "vcamaf";
> +				regulator-min-microvolt =3D <1800000>;
> +				regulator-max-microvolt =3D <1800000>;
> +				regulator-enable-ramp-delay =3D <218>;
> +			};
> +
> +			mt6397_vgp4_reg: ldo_vgp4 {
> +				regulator-compatible =3D "ldo_vgp4";
> +				regulator-name =3D "vgp4";
> +				regulator-min-microvolt =3D <1200000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-enable-ramp-delay =3D <218>;
> +			};
> +
> +			mt6397_vgp5_reg: ldo_vgp5 {
> +				regulator-compatible =3D "ldo_vgp5";
> +				regulator-name =3D "vgp5";
> +				regulator-min-microvolt =3D <1200000>;
> +				regulator-max-microvolt =3D <3000000>;
> +				regulator-enable-ramp-delay =3D <218>;
> +			};
> +
> +			mt6397_vgp6_reg: ldo_vgp6 {
> +				regulator-compatible =3D "ldo_vgp6";
> +				regulator-name =3D "vgp6";
> +				regulator-min-microvolt =3D <3300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-enable-ramp-delay =3D <218>;
> +				regulator-always-on;
> +			};
> +
> +			mt6397_vibr_reg: ldo_vibr {
> +				regulator-compatible =3D "ldo_vibr";
> +				regulator-name =3D "vibr";
> +				regulator-min-microvolt =3D <1300000>;
> +				regulator-max-microvolt =3D <3300000>;
> +				regulator-enable-ramp-delay =3D <218>;
> +			};
> +		};
> +
> +		rtc: mt6397rtc {
> +			compatible =3D "mediatek,mt6397-rtc";
> +		};
> +
> +		syscfg_pctl_pmic: syscfg_pctl_pmic@c000 {
> +			compatible =3D "mediatek,mt6397-pctl-pmic-syscfg",
> +				     "syscon";
> +			reg =3D <0 0x0000c000 0 0x0108>;
> +		};
> +	};
> +};
> +
> +&spi {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&spi_pins_a>;
> +	mediatek,pad-select =3D <1>;
> +	status =3D "okay";
> +	/* clients */
> +	cros_ec: ec@0 {
> +		compatible =3D "google,cros-ec-spi";
> +		reg =3D <0x0>;
> +		spi-max-frequency =3D <12000000>;
> +		interrupt-parent =3D <&pio>;
> +		interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
> +		google,cros-ec-spi-msg-delay =3D <500>;
> +
> +		i2c_tunnel: i2c-tunnel0 {
> +			compatible =3D "google,cros-ec-i2c-tunnel";
> +			google,remote-bus =3D <0>;
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			battery: sbs-battery@b {
> +				compatible =3D "sbs,sbs-battery";
> +				reg =3D <0xb>;
> +				sbs,i2c-retry-count =3D <2>;
> +				sbs,poll-retry-count =3D <1>;
> +			};
> +		};
> +	};
> +};
> +
> +&ssusb {
> +	dr_mode =3D "host";
> +	wakeup-source;
> +	vusb33-supply =3D <&mt6397_vusb_reg>;
> +	status =3D "okay";
> +};
> +
> +&thermal {
> +	bank0-supply =3D <&mt6397_vpca15_reg>;
> +	bank1-supply =3D <&da9211_vcpu_reg>;
> +};
> +
> +&uart0 {
> +	status =3D "okay";
> +};
> +
> +&usb_host {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&usb_pins>;
> +	vusb33-supply =3D <&mt6397_vusb_reg>;
> +	status =3D "okay";
> +};
> +
> +#include <arm/cros-ec-keyboard.dtsi>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8173.dtsi
> index 2b7f566fb407..3e34396478dd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -1440,4 +1440,3 @@ larb5: larb@19001000 {
>  		};
>  	};
>  };
> -
>=20

