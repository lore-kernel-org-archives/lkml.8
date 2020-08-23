Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65217C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 367DC2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598172541;
	bh=xln95DSz6gTLUqcwsrJ1cMBbA0quzMWZWeBbVowcoUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dX1I58ZliC02O44o122NCrJX3JjVZUtURYpNMusxiLR1PEd0fEGVI+7XKaArIPkF9
	 17pcMHNXiPCKa6HfWL17OhduKGNqvdbc0Z89/gmne7N/JXJdfaIAPFHesoJrvs5hoI
	 m5IlVbnD1DQ0143Dfaa/hkoinyTMwUjFzPPiXLEk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbgHWItA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 04:49:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35508 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgHWIs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 04:48:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id o21so5520735wmc.0;
        Sun, 23 Aug 2020 01:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZOB4lcb/A2ReYuIUZFY4rzqWtKh3ZMQm/mmnSUmm+x4=;
        b=DxY6pRn7qgKM9fBWCgAmPEq/NrCtaOGz9mjMs35Xx1mc6JSgqICn5iRLQEk3SjElN3
         PKMsIjzJ5kCUFRU53xManh2nE/tfjOLRG8MPaKYVQ/rcl8zaqBGDjSeSKN8c+TPIXVXL
         Yo8N1QdGx3v1eF08kRIJq9Tsr+az9v0zOJyL8PsTFnnfRyjrmGyX31ob/XNohp4M4mNV
         SR3DiDDq0xxIxeaPmgSdizoiGVNctlqQcTkIfgBPKJBW0h2zkiOGTuwYk1yZ1TxGwTZv
         5hzwQzqZ8jGTh5DBpqjZkuBs9xcAU6VnzKFYAKejStGs8HS3HFirt56f6z1Qi+kandDs
         vJ5w==
X-Gm-Message-State: AOAM533s9hBdhwrWiclO8Kx7BLAeII2KL86S86pfl01jxyrmjyI+zrCG
        y4+93QrwIJaHZyasT6lpMPY=
X-Google-Smtp-Source: ABdhPJwVDJgt9eQi5BkKRHYmA+DP2U2rRi2QS5nJ+ul/+/k/6oqiRnRpUJ5bzoClktMDpoQsS0SPyA==
X-Received: by 2002:a05:600c:2189:: with SMTP id e9mr707230wme.171.1598172534248;
        Sun, 23 Aug 2020 01:48:54 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id 32sm17409125wrh.18.2020.08.23.01.48.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Aug 2020 01:48:53 -0700 (PDT)
Date:   Sun, 23 Aug 2020 10:48:51 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] arm64: dts: imx8mm-var-som: Add Variscite
 VAR-SOM-MX8MM System on Module
Message-ID: <20200823084851.GB2886@kozik-lap>
References: <20200817070120.4937-1-krzk@kernel.org>
 <20200817070120.4937-3-krzk@kernel.org>
 <20200823015647.GI30094@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200823015647.GI30094@dragon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 09:56:47AM +0800, Shawn Guo wrote:
> On Mon, Aug 17, 2020 at 09:01:19AM +0200, Krzysztof Kozlowski wrote:
> > Add DTSI of Variscite VAR-SOM-MX8MM System on Module in a basic version,
> > delivered with Variscite Symphony Evaluation kit.  This version comes
> > with:
> >  - 2 GB of RAM,
> >  - 16 GB eMMC,
> >  - Gigabit Ethernet PHY,
> >  - 802.11 ac/a/b/g/n WiFi with 4.2 Bluetooth (Cypress CYW43353),
> >  - CAN bus,
> >  - Audio codec (not yet configured in DTSI).
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Changes since v1:
> > 1. None
> > ---
> >  .../boot/dts/freescale/imx8mm-var-som.dtsi    | 579 ++++++++++++++++++
> >  1 file changed, 579 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
> > new file mode 100644
> > index 000000000000..c5b8f6db19b0
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som.dtsi
> > @@ -0,0 +1,579 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright 2019 NXP
> > + * Copyright (C) 2020 Krzysztof Kozlowski <krzk@kernel.org>
> > + */
> > +
> > +#include "imx8mm.dtsi"
> > +
> > +/ {
> > +	model = "Variscite VAR-SOM-MX8MM module";
> > +	compatible = "variscite,var-som-mx8mm", "fsl,imx8mm";
> > +
> > +	chosen {
> > +		stdout-path = &uart4;
> > +	};
> > +
> > +	memory@40000000 {
> > +		device_type = "memory";
> > +		reg = <0x0 0x40000000 0 0x80000000>;
> > +	};
> > +
> > +	reg_eth_phy: regulator-0 {
> > +		compatible = "regulator-fixed";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_reg_eth_phy>;
> > +		regulator-name = "eth_phy_pwr";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		gpio = <&gpio2 9 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +	};
> > +};
> > +
> > +&A53_0 {
> > +	cpu-supply = <&buck2_reg>;
> > +};
> > +
> > +&A53_1 {
> > +	cpu-supply = <&buck2_reg>;
> > +};
> > +
> > +&A53_2 {
> > +	cpu-supply = <&buck2_reg>;
> > +};
> > +
> > +&A53_3 {
> > +	cpu-supply = <&buck2_reg>;
> > +};
> > +
> > +&ddrc {
> > +	operating-points-v2 = <&ddrc_opp_table>;
> > +
> > +	ddrc_opp_table: opp-table {
> > +		compatible = "operating-points-v2";
> > +
> > +		opp-25M {
> > +			opp-hz = /bits/ 64 <25000000>;
> > +		};
> > +
> > +		opp-100M {
> > +			opp-hz = /bits/ 64 <100000000>;
> > +		};
> > +
> > +		opp-750M {
> > +			opp-hz = /bits/ 64 <750000000>;
> > +		};
> > +	};
> > +};
> > +
> > +&ecspi1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_ecspi1>;
> > +	cs-gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>,
> > +		   <&gpio1  0 GPIO_ACTIVE_HIGH>;
> > +	fsl,spi-num-chipselects = <2>;
> 
> This property is not supported any more.

Sure.

> 
> > +	/delete-property/ dmas;
> > +	/delete-property/ dma-names;
> > +	status = "okay";
> > +
> > +	/* Resistive touch controller */
> > +	touchscreen@0 {
> > +		reg = <0>;
> > +		compatible = "ti,ads7846";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_restouch>;
> > +		interrupt-parent = <&gpio1>;
> > +		interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
> > +
> > +		spi-max-frequency = <1500000>;
> > +		pendown-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
> > +
> > +		ti,x-min = /bits/ 16 <125>;
> > +		touchscreen-size-x = /bits/ 16 <4008>;
> > +		ti,y-min = /bits/ 16 <282>;
> > +		touchscreen-size-y = /bits/ 16 <3864>;
> > +		ti,x-plate-ohms = /bits/ 16 <180>;
> > +		touchscreen-max-pressure = /bits/ 16 <255>;
> > +		touchscreen-average-samples = /bits/ 16 <10>;
> > +		ti,debounce-tol = /bits/ 16 <3>;
> > +		ti,debounce-rep = /bits/ 16 <1>;
> > +		ti,settle-delay-usec = /bits/ 16 <150>;
> > +		ti,keep-vref-on;
> > +		wakeup-source;
> > +	};
> > +
> > +	can: can@1 {
> > +		/* TODO: binding not documented, patches on the LKML */
> 
> Do not submit stuff that haven't landed.

It is in the HW so for completeness of HW description it has a meaning.
However if that's not desired, I can skip it.

> 
> > +		compatible = "microchip,mcp2517fd";
> > +		reg = <1>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_can>;
> > +		interrupt-parent = <&gpio1>;
> > +		interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
> > +		spi-max-frequency = <20000000>;
> > +	};
> > +};
> > +
> > +&fec1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_fec1>;
> > +	phy-mode = "rgmii";
> > +	phy-handle = <&ethphy>;
> > +	phy-supply = <&reg_eth_phy>;
> > +	phy-reset-gpios = <&gpio1 9 GPIO_ACTIVE_LOW>;
> > +	phy-reset-duration = <100>;
> > +	phy-reset-post-delay = <100>;
> 
> These properties are deprecated.  Check out bindings/net/fsl-fec.txt.

OK

> 
> > +	fsl,magic-packet;
> > +	status = "okay";
> > +
> > +	mdio {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		ethphy: ethernet-phy@4 {
> > +			compatible = "ethernet-phy-ieee802.3-c22";
> > +			reg = <4>;
> > +		};
> > +	};
> > +};
> > +
> > +&i2c1 {
> > +	clock-frequency = <400000>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_i2c1>;
> > +	status = "okay";
> > +
> > +	pmic@4b {
> > +		compatible = "rohm,bd71847";
> > +		reg = <0x4b>;
> > +		pinctrl-0 = <&pinctrl_pmic>;
> > +		interrupt-parent = <&gpio2>;
> > +		interrupts = <8 GPIO_ACTIVE_LOW>;
> > +		rohm,reset-snvs-powered;
> > +
> > +		regulators {
> > +			buck1_reg: BUCK1 {
> > +				regulator-name = "BUCK1";
> > +				regulator-min-microvolt = <700000>;
> > +				regulator-max-microvolt = <1300000>;
> > +				regulator-boot-on;
> > +				regulator-always-on;
> > +				regulator-ramp-delay = <1250>;
> > +			};
> > +
> > +			buck2_reg: BUCK2 {
> > +				regulator-name = "BUCK2";
> > +				regulator-min-microvolt = <700000>;
> > +				regulator-max-microvolt = <1300000>;
> > +				regulator-boot-on;
> > +				regulator-always-on;
> > +				regulator-ramp-delay = <1250>;
> > +				rohm,dvs-run-voltage = <1000000>;
> > +				rohm,dvs-idle-voltage = <900000>;
> > +			};
> > +
> > +			buck3_reg: BUCK3 {
> > +				regulator-name = "BUCK3";
> > +				regulator-min-microvolt = <700000>;
> > +				regulator-max-microvolt = <1350000>;
> > +				regulator-boot-on;
> > +				regulator-always-on;
> > +			};
> > +
> > +			buck4_reg: BUCK4 {
> > +				regulator-name = "BUCK4";
> > +				regulator-min-microvolt = <3000000>;
> > +				regulator-max-microvolt = <3300000>;
> > +				regulator-boot-on;
> > +				regulator-always-on;
> > +			};
> > +
> > +			buck5_reg: BUCK5 {
> > +				regulator-name = "BUCK5";
> > +				regulator-min-microvolt = <1605000>;
> > +				regulator-max-microvolt = <1995000>;
> > +				regulator-boot-on;
> > +				regulator-always-on;
> > +			};
> > +
> > +			buck6_reg: BUCK6 {
> > +				regulator-name = "BUCK6";
> > +				regulator-min-microvolt = <800000>;
> > +				regulator-max-microvolt = <1400000>;
> > +				regulator-boot-on;
> > +				regulator-always-on;
> > +			};
> > +
> > +			ldo1_reg: LDO1 {
> > +				regulator-name = "LDO1";
> > +				regulator-min-microvolt = <1600000>;
> > +				regulator-max-microvolt = <1900000>;
> > +				regulator-boot-on;
> > +				regulator-always-on;
> > +			};
> > +
> > +			ldo2_reg: LDO2 {
> > +				regulator-name = "LDO2";
> > +				regulator-min-microvolt = <800000>;
> > +				regulator-max-microvolt = <900000>;
> > +				regulator-boot-on;
> > +				regulator-always-on;
> > +			};
> > +
> > +			ldo3_reg: LDO3 {
> > +				regulator-name = "LDO3";
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <3300000>;
> > +				regulator-boot-on;
> > +				regulator-always-on;
> > +			};
> > +
> > +			ldo4_reg: LDO4 {
> > +				regulator-name = "LDO4";
> > +				regulator-min-microvolt = <900000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				regulator-boot-on;
> > +				regulator-always-on;
> > +			};
> > +
> > +			ldo5_reg: LDO5 {
> > +				regulator-compatible = "LDO5";
> > +				regulator-min-microvolt = <1800000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				regulator-always-on;
> > +			};
> > +
> > +			ldo6_reg: LDO6 {
> > +				regulator-name = "LDO6";
> > +				regulator-min-microvolt = <900000>;
> > +				regulator-max-microvolt = <1800000>;
> > +				regulator-boot-on;
> > +				regulator-always-on;
> > +			};
> > +		};
> > +	};
> > +};
> > +
> > +&i2c3 {
> > +	clock-frequency = <400000>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_i2c3>;
> > +	status = "okay";
> > +
> > +	/* TODO: configure audio, as of now just put a placeholder */
> > +	wm8904: codec@1a {
> > +		compatible = "wlf,wm8904";
> > +		reg = <0x1a>;
> > +		status = "disabled";
> > +	};
> > +};
> > +
> > +&snvs_pwrkey {
> > +	status = "okay";
> > +};
> > +
> > +/* Bluetooth */
> > +&uart2 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_uart2>;
> > +	assigned-clocks = <&clk IMX8MM_CLK_UART2>;
> > +	assigned-clock-parents = <&clk IMX8MM_SYS_PLL1_80M>;
> > +	uart-has-rtscts;
> > +	status = "okay";
> > +};
> > +
> > +/* Console */
> > +&uart4 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_uart4>;
> > +	status = "okay";
> > +};
> > +
> > +&usbotg1 {
> > +	dr_mode = "otg";
> > +	usb-role-switch;
> > +	status = "okay";
> > +};
> > +
> > +&usbotg2 {
> > +	dr_mode = "otg";
> > +	usb-role-switch;
> > +	status = "okay";
> > +};
> > +
> > +/* WIFI */
> > +&usdhc1 {
> > +	#address-cells = <1>;
> > +	#size-cells = <0>;
> > +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > +	pinctrl-0 = <&pinctrl_usdhc1>;
> > +	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
> > +	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
> > +	bus-width = <4>;
> > +	non-removable;
> > +	keep-power-in-suspend;
> > +	status = "okay";
> > +
> > +	brcmf: bcrmf@1 {
> > +		reg = <1>;
> > +		compatible = "brcm,bcm4329-fmac";
> > +	};
> > +};
> > +
> > +/* SD */
> > +&usdhc2 {
> > +	assigned-clocks = <&clk IMX8MM_CLK_USDHC2>;
> > +	assigned-clock-rates = <200000000>;
> > +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > +	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
> > +	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
> > +	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
> > +	cd-gpios = <&gpio1 10 GPIO_ACTIVE_LOW>;
> > +	bus-width = <4>;
> > +	vmmc-supply = <&reg_usdhc2_vmmc>;
> > +	status = "okay";
> > +};
> > +
> > +/* eMMC */
> > +&usdhc3 {
> > +	assigned-clocks = <&clk IMX8MM_CLK_USDHC3_ROOT>;
> > +	assigned-clock-rates = <400000000>;
> > +	pinctrl-names = "default", "state_100mhz", "state_200mhz";
> > +	pinctrl-0 = <&pinctrl_usdhc3>;
> > +	pinctrl-1 = <&pinctrl_usdhc3_100mhz>;
> > +	pinctrl-2 = <&pinctrl_usdhc3_200mhz>;
> > +	bus-width = <8>;
> > +	non-removable;
> > +	status = "okay";
> > +};
> > +
> > +&wdog1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_wdog>;
> > +	fsl,ext-reset-output;
> > +	status = "okay";
> > +};
> > +
> > +&iomuxc {
> > +	pinctrl-names = "default";
> 
> The property 'pinctrl-names' should be used with pinctrl-X as pair.

Indeed, this does not make much sense. Thanks for the review.

Best regards,
Krzysztof
