Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BADF7C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9531F2073E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beR9fUb9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgGRJHJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 05:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgGRJHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:07:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A35AC0619D2;
        Sat, 18 Jul 2020 02:07:07 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q15so17917450wmj.2;
        Sat, 18 Jul 2020 02:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0BWRPw8g2XYVXSVbobArkBx7EWxJQQknqmb4NXpsOwM=;
        b=beR9fUb9+Ju9lRSUK9d40Ng8sbQhSPEP+kpI4XRfDpSg2UtZhGEpV8WGFjBFE0hite
         H4B24U3qEGTY+NNzNtrKw1wkdr7K/UTZyNbMfCQEzC6J09nQHgMjoSansJWwRNErAPdN
         T3onXS7bYI9gakeJU5vJRE4NxkBI3kUKtpcSQOXFTJZ84HBb6O/LgjIbAwy2eLwbNG50
         d/gk67Wiy4i/WQLqYBei6xn6R3rFBPB3avLRlLnZyWDTAsgZj6dT9UbL54p0kWoT9AJI
         EzmrKdVrPe3E9DI/ouOKEFHu4x6lFdCN4nu+e5cHpDOYOrufNcza2R/tNNVp3kvPu/wD
         tt6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=0BWRPw8g2XYVXSVbobArkBx7EWxJQQknqmb4NXpsOwM=;
        b=D4RuL9BIqv8cG6pCmRc1FDDIAEX5fRfBdsz/CZ6Nlj+iUtbGAvroNX7mriYraLksLc
         eKM1I52XK1EZxZMw10MOKFMk0MaxVBCTvg9TT6zmQzpvRTfw5fU7SebCny0KoZueTflp
         HEdfdzIVioPnGwYETh7FvYM8nGy95yVABcsopFEW6lX9mxOpp1FecfCF/BVEOJZTf019
         vgNFahzZNTLcJsKdVtsY2TtCXU5BFzqUdb6IawuFj/ER7FzqrH1nDpGvfvjjMqLYqJ0x
         1YXduDRJz818Pj6BI0+fqQuQUPdciK14uaJDHVszDatVbG9L4I+BOaHO+BzLQV4YYGAZ
         y8xg==
X-Gm-Message-State: AOAM531FJHGGn5T29FMUUaDoAq0lriLUeAfDzy1DTEMCN9+1OGS2ZsYl
        XmBHLDPMEAVW7hGb1vTr1JM=
X-Google-Smtp-Source: ABdhPJzoshdcpFBb5Yye8csFmbaOC7pfVxul+09SAuay65V7kYX7aTIBoGARazBeNCiCYARxn+7I0A==
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr13389823wmo.72.1595063226154;
        Sat, 18 Jul 2020 02:07:06 -0700 (PDT)
Received: from [172.16.20.20] ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id w12sm20824919wrm.79.2020.07.18.02.07.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Jul 2020 02:07:05 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH 2/2] arm64: dts: meson: add support for the WeTek Core 2
From:   Christian Hewitt <christianshewitt@gmail.com>
In-Reply-To: <2ab5e28a-77f6-cac1-68ed-f0a23d5f2a24@baylibre.com>
Date:   Sat, 18 Jul 2020 13:07:02 +0400
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <109D2AE5-AF4B-4DAF-B2C5-3B8740BF33BD@gmail.com>
References: <20200718050056.1713-1-christianshewitt@gmail.com>
 <20200718050056.1713-2-christianshewitt@gmail.com>
 <2ab5e28a-77f6-cac1-68ed-f0a23d5f2a24@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 18 Jul 2020, at 12:52 pm, Neil Armstrong <narmstrong@baylibre.com> =
wrote:
>=20
> Le 18/07/2020 =C3=A0 07:00, Christian Hewitt a =C3=A9crit :
>> The WeTek Core2 is a commercial device based on the Amlogic Q200 =
reference
>> design but with the following differences:
>>=20
>> - 3GB RAM, 32GB eMMC
>> - Blue and Red LEDs used to signal on/off status
>> - uart_AO can be accessed after opening the case; soldering required
>> - USB OTG is not accessible (inside the case)
>> - Realtek RTL8152 Ethernet (internal USB connection)
>>=20
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>> arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>> .../dts/amlogic/meson-gxm-wetek-core2.dts     | 90 =
+++++++++++++++++++
>> 2 files changed, 91 insertions(+)
>> create mode 100644 =
arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts
>>=20
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile =
b/arch/arm64/boot/dts/amlogic/Makefile
>> index 5cac4d1d487d..4e2239ffcaa5 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -41,6 +41,7 @@ dtb-$(CONFIG_ARCH_MESON) +=3D meson-gxm-q201.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-gxm-rbox-pro.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-gxm-s912-libretech-pc.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-gxm-vega-s96.dtb
>> +dtb-$(CONFIG_ARCH_MESON) +=3D meson-gxm-wetek-core2.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-sm1-sei610.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-sm1-khadas-vim3l.dtb
>> dtb-$(CONFIG_ARCH_MESON) +=3D meson-sm1-odroid-c4.dtb
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts =
b/arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts
>> new file mode 100644
>> index 000000000000..44fc5ea38dc0
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxm-wetek-core2.dts
>> @@ -0,0 +1,90 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2020 Christian Hewitt <christianshewitt@gmail.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "meson-gxm.dtsi"
>> +#include "meson-gx-p23x-q20x.dtsi"
>> +#include <dt-bindings/input/input.h>
>> +#include <dt-bindings/leds/common.h>
>> +
>> +/ {
>> +	compatible =3D "wetek,core2", "amlogic,s912", =
"amlogic,meson-gxm";
>> +	model =3D "WeTek Core 2";
>> +
>> +	memory@0 {
>> +		device_type =3D "memory";
>> +		reg =3D <0x0 0x0 0x0 0x80000000>; /* 2 GiB or 3 GiB */
>> +	};
>> +
>> +	leds {
>> +		compatible =3D "gpio-leds";
>> +
>> +		blue {
>> +			color =3D <LED_COLOR_ID_BLUE>;
>> +			function =3D LED_FUNCTION_STATUS;
>> +			gpios =3D <&gpio GPIODV_24 GPIO_ACTIVE_HIGH>;
>> +			default-state =3D "on";
>> +		};
>> +	};
>> +
>> +	adc-keys {
>> +		compatible =3D "adc-keys";
>> +		io-channels =3D <&saradc 0>;
>> +		io-channel-names =3D "buttons";
>> +		keyup-threshold-microvolt =3D <1710000>;
>> +
>> +		button-update {
>> +			label =3D "update";
>> +			linux,code =3D <KEY_VENDOR>;
>> +			press-threshold-microvolt =3D <10000>;
>> +		};
>> +	};
>> +
>> +	gpio-keys-polled {
>> +		compatible =3D "gpio-keys-polled";
>> +		#address-cells =3D <1>;
>> +		#size-cells =3D <0>;
>> +		poll-interval =3D <100>;
>> +
>> +		button-power {
>> +			label =3D "power";
>> +			linux,code =3D <KEY_POWER>;
>> +			gpios =3D <&gpio_ao GPIOAO_2 GPIO_ACTIVE_LOW>;
>> +		};
>> +	};
>> +};
>> +
>> +/* This is disabled as Realtek RTL8152 USB provides Ethernet */
>> +&ethmac {
>> +	status =3D "disabled";
>> +	phy-mode =3D "rmii";
>> +	phy-handle =3D <&internal_phy>;
>=20
> I think you can remove these 2 lines
>=20
>> +};
>> +
>> +&internal_phy {
>> +	pinctrl-0 =3D <&eth_link_led_pins>, <&eth_act_led_pins>;
>> +	pinctrl-names =3D "default";
>=20
> Simply add :
> status =3D "disabled";
>=20
>> +};
>> +
>> +&ir {
>> +	linux,rc-map-name =3D "rc-wetek-play2";
>> +};
>> +
>> +/* This is connected to the Bluetooth module: */
>> +&uart_A {
>> +	status =3D "okay";
>> +	pinctrl-0 =3D <&uart_a_pins>, <&uart_a_cts_rts_pins>;
>> +	pinctrl-names =3D "default";
>> +	uart-has-rtscts;
>> +
>> +	bluetooth {
>> +		compatible =3D "brcm,bcm43438-bt";
>> +		enable-gpios =3D <&gpio GPIOX_17 GPIO_ACTIVE_HIGH>;
>> +		max-speed =3D <2000000>;
>> +		clocks =3D <&wifi32k>;
>> +		clock-names =3D "lpo";
>> +	};
>> +};
>>=20
>=20
>=20
> Otherwise looks good
>=20
> Neil

I=E2=80=99ve tested both changes, both are fine so will send v2.

Thanks for the quick review.

Christian

