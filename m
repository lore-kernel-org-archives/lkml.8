Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_RHS_DOB autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 731AAC33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 21:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE3F2072B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 21:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgASVbJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 16:31:09 -0500
Received: from mx.blih.net ([212.83.155.74]:30300 "EHLO mx.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbgASVbJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 16:31:09 -0500
Received: from skull.home.blih.net (lfbn-idf2-1-1164-130.w90-92.abo.wanadoo.fr [90.92.223.130])
        by mx.blih.net (OpenSMTPD) with ESMTPSA id 0a3f8ca7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 19 Jan 2020 21:31:04 +0000 (UTC)
Date:   Sun, 19 Jan 2020 22:31:02 +0100
From:   Emmanuel Vadot <manu@bidouilliste.com>
To:     Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Emmanuel Vadot <manu@freebsd.org>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, aballier@gentoo.org, vicencb@gmail.com,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        robh+dt@kernel.org, kever.yang@rock-chips.com,
        m.reichl@fivetechno.de, linux-rockchip@lists.infradead.org,
        mka@chromium.org, jagan@amarulasolutions.com, nick@khadas.com,
        andy.yan@rock-chips.com, robin.murphy@arm.com,
        linux-arm-kernel@lists.infradead.org, pbrobinson@gmail.com
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Add initial support for
 Pinebook Pro
Message-Id: <20200119223102.f97ba545ebf59c14563a95c7@bidouilliste.com>
In-Reply-To: <2816238.fSnfubHXRg@diego>
References: <20200116225617.6318-1-manu@freebsd.org>
        <20200116225617.6318-2-manu@freebsd.org>
        <2816238.fSnfubHXRg@diego>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd13.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2020 21:17:39 +0100
Heiko Stübner <heiko@sntech.de> wrote:

> Hi,
> 
> overall looks good, but some small things below
> 
> Am Donnerstag, 16. Januar 2020, 23:56:17 CET schrieb Emmanuel Vadot:
> > From: Peter Robinson <pbrobinson@gmail.com>
> > 
> > Pinebook Pro is a RK3399 based laptop produced by Pine64.
> > 
> > Add a basic DTS for it.
> > 
> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/Makefile         |   1 +
> >  .../boot/dts/rockchip/rk3399-pinebook-pro.dts | 626 ++++++++++++++++++
> >  2 files changed, 627 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
> > index 48fb631d5451..9099fb7e2073 100644
> > --- a/arch/arm64/boot/dts/rockchip/Makefile
> > +++ b/arch/arm64/boot/dts/rockchip/Makefile
> > @@ -28,6 +28,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopc-t4.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-m4.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-nanopi-neo4.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-orangepi.dtb
> > +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-pinebook-pro.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc.dtb
> >  dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-roc-pc-mezzanine.dtb
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> > new file mode 100644
> > index 000000000000..d2e3d7b35cc6
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-pinebook-pro.dts
> > @@ -0,0 +1,626 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
> 
> You might want to clarify the copyright ... 2020 and Pine64-something?

 This is a DTS that Peter Robinson first wrote, I've just kept the
copyright.

> > + */
> > +
> > +/dts-v1/;
> > +#include <dt-bindings/input/linux-event-codes.h>
> > +#include <dt-bindings/pwm/pwm.h>
> > +#include <dt-bindings/pinctrl/rockchip.h>
> > +#include "rk3399.dtsi"
> > +#include "rk3399-opp.dtsi"
> > +
> > +/ {
> > +	model = "Pine64 Pinebook Pro";
> > +	compatible = "pine64,pinebook-pro", "rockchip,rk3399";
> > +
> > +	chosen {
> > +		stdout-path = "serial2:115200n8";
> > +	};
> > +
> > +	aliases {
> > +		spi0 = &spi1;
> 
> why is this needed ... I'd think spi can just enumerate itself?

 This was taken from u-boot and yes I think it's not needed for both
Linux and FreeBSD.

> 
> > +	};
> > +
> > +	backlight: backlight {
> > +		compatible = "pwm-backlight";
> > +		enable-gpios = <&gpio1 RK_PA0 GPIO_ACTIVE_HIGH>;
> > +		pwms = <&pwm0 0 740740 0>;
> > +	};
> > +
> > +	gpio-keys {
> > +		compatible = "gpio-keys";
> > +		autorepeat;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pwrbtn>;
> > +
> > +		power {
> > +			debounce-interval = <100>;
> > +			gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
> > +			label = "GPIO Key Power";
> > +			linux,code = <KEY_POWER>;
> > +			wakeup-source;
> > +		};
> > +	};
> > +
> > +	leds {
> > +		status = "okay";
> 
> new board-specific nodes don't need a status property

 Ok.

> > +		compatible = "gpio-leds";
> > +
> > +		work-led {
> > +			label = "work";
> > +			gpios = <&gpio0 RK_PB3 GPIO_ACTIVE_HIGH>;
> > +		};
> > +
> > +		standby-led {
> > +			label = "standby";
> > +			gpios = <&gpio0 RK_PA2 GPIO_ACTIVE_HIGH>;
> > +		};
> > +	};
> > +
> > +	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc1v8_s3";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <1800000>;
> > +		regulator-max-microvolt = <1800000>;
> > +		vin-supply = <&vcc_1v8>;
> > +	};
> > +
> > +	dc_12v: dc-12v {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "dc_12v";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <12000000>;
> > +		regulator-max-microvolt = <12000000>;
> > +	};
> > +
> > +	vcc3v3_sys: vcc3v3-sys {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc3v3_sys";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		vin-supply = <&vcc_sys>;
> > +	};
> > +
> > +	vcc5v0_host: vcc5v0-host-regulator {
> > +		compatible = "regulator-fixed";
> > +		gpio = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&host_vbus_drv>;
> > +		regulator-name = "vcc5v0_host";
> > +	};
> > +
> > +	vcc5v0_usb3_host: vcc5v0-usb3-host-regulator {
> > +		compatible = "regulator-fixed";
> > +		enable-active-high;
> > +		gpio = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&host_usb3_drv>;
> > +		regulator-name = "vcc5v0_usb3_host";
> > +		regulator-always-on;
> > +	};
> > +
> > +	vcc3v3_s0: vcc3v3-s0-regulator {
> > +		compatible = "regulator-fixed";
> > +		enable-active-high;
> > +		gpio = <&gpio1 RK_PC6 GPIO_ACTIVE_HIGH>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&lcdvcc_en>;
> > +		regulator-name = "vcc3v3_s0";
> > +		regulator-always-on;
> > +	};
> > +
> > +	vcc_sys: vcc-sys {
> > +		compatible = "regulator-fixed";
> > +		regulator-name = "vcc_sys";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		vin-supply = <&dc_12v>;
> > +	};
> > +
> > +	vdd_log: vdd-log {
> > +		compatible = "pwm-regulator";
> > +		pwms = <&pwm2 0 25000 1>;
> > +		pwm-supply = <&vcc_sys>;
> > +		regulator-name = "vdd_log";
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		regulator-init-microvolt = <950000>;
> 
> There is no init-microvolt property in mainline, I'd think bootloader should
> already setup the pwm to a suitable setting?
> 
> Not

 I'll fix that.

> > +		regulator-min-microvolt = <800000>;
> > +		regulator-max-microvolt = <1400000>;
> > +	};
> > +};
> > +
> > +&cpu_l0 {
> > +	cpu-supply = <&vdd_cpu_l>;
> > +};
> > +
> > +&cpu_l1 {
> > +	cpu-supply = <&vdd_cpu_l>;
> > +};
> > +
> > +&cpu_l2 {
> > +	cpu-supply = <&vdd_cpu_l>;
> > +};
> > +
> > +&cpu_l3 {
> > +	cpu-supply = <&vdd_cpu_l>;
> > +};
> 
> what happened to cpu_b0 and cpu_b1 supplies?
> Should probably reference the cpu_b regulator below?

 Yes, sorry.

> > +
> > +&emmc_phy {
> > +	status = "okay";
> > +};
> > +
> > +&i2c0 {
> > +	clock-frequency = <400000>;
> > +	i2c-scl-rising-time-ns = <168>;
> > +	i2c-scl-falling-time-ns = <4>;
> > +	status = "okay";
> 
> [...]
> 
> > +	vdd_cpu_b: regulator@40 {
> > +		compatible = "silergy,syr827";
> > +		reg = <0x40>;
> > +		fcs,suspend-voltage-selector = <1>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&vsel1_gpio>;
> > +		vsel-gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
> 
> This is not yet specified in the syr82x (fan5355) bindings and
> also unknown to the driver

 I'll have another look at the bindings, thanks.

> > +		regulator-compatible = "fan53555-reg";
> > +		regulator-name = "vdd_cpu_b";
> > +		regulator-min-microvolt = <712500>;
> > +		regulator-max-microvolt = <1500000>;
> > +		regulator-ramp-delay = <1000>;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		vin-supply = <&vcc_sys>;
> > +
> > +		regulator-state-mem {
> > +			regulator-off-in-suspend;
> > +		};
> > +	};
> > +
> > +	vdd_gpu: regulator@41 {
> > +		compatible = "silergy,syr828";
> > +		reg = <0x41>;
> > +		fcs,suspend-voltage-selector = <1>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&vsel2_gpio>;
> > +		vsel-gpios = <&gpio1 RK_PB6 GPIO_ACTIVE_HIGH>;
> 
> same
> 
> > +		regulator-compatible = "fan53555-reg";
> > +		regulator-name = "vdd_gpu";
> > +		regulator-min-microvolt = <712500>;
> > +		regulator-max-microvolt = <1500000>;
> > +		regulator-ramp-delay = <1000>;
> > +		regulator-always-on;
> > +		regulator-boot-on;
> > +		vin-supply = <&vcc_sys>;
> > +
> > +		regulator-state-mem {
> > +			regulator-off-in-suspend;
> > +		};
> > +	};
> > +
> > +};
> 
> [...]
> 
> > +&saradc {
> > +	status = "okay";
> 
> needs a vref-supply
> 
> > +};
> > +
> > +&sdmmc {
> > +	bus-width = <4>;
> > +	status = "okay";
> > +	max-frequency = <20000000>;
> 
> vmmc / vqmmc supplies?
> Especially if one wants to achieve higher speeds on uhs cards.

 Yep, will do that.

> Heiko
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
