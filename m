Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B71C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BFE2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 08:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598173134;
	bh=EXBOnoskmtCv9SoSv1Nu7jWTkyLtDFIsYjuVMPanlLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zDdIyhEyrHpSdnFzPL37kHcs5haf0tbZtQ9vF04tdO1VTCv2O3VcSLZjeCshfF6r6
	 e9JV0P/ILf2WcPrY8ZDYJBV+e63hhgPpwtiPBKPyFgLCxr/JOP8jSfGv2keM5h1dkt
	 Y4SXO36DJS+r+QFlnLqOUNUwUFilHRotNuBT+M/0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728671AbgHWI6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 04:58:53 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35024 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgHWI6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 04:58:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id o21so5530799wmc.0;
        Sun, 23 Aug 2020 01:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=viEQQ0usSckhrn0C7JCLFxxV3CMZUjtmTLKCclnLX+g=;
        b=G6KWwyrQ5CJICtr/8Uz+PIgPr8DWZqjQ4yfaGSD2qC7jSEoaH1Jq6nS9Gcwn239Teb
         RPa8EGj+L8XYb2jYBZ8B8IdoaKsa+F0OOiZ+FZUboNq91diVQbRTaPBR9G3OS2C0jpr6
         f7KwhHqYp0fQCxjW35uvwxBZbqvCPqHS5ZrWw3rUXXk01VIMso8kvlh0GhNa4t3HZd8J
         yqlO3+okEBWdMv17P3AfnDI9kQxBUTkbdbZPtQyNv+wOy0uHb0YzBAVDXqLKdxQE1cjV
         hI/4OCcUjhi6fd5nTH0yBpey2fjGI6C4zraiEGdN6B7YKnuIAyiBE+1gYedUYk1hcIIZ
         XxeQ==
X-Gm-Message-State: AOAM530nGIyuIHKPKs+7S9sbDQSThbr3fnzOVg8Wyiu9dqDw8TcZfCyN
        lbYFyCvY0qEqk4eD/lFV8Pg=
X-Google-Smtp-Source: ABdhPJxpdmtmzOkq7B7XVVLIYxvPQuRJ4WCziA67k3OjXNsm9wgkmeRgXG5nhrJ8ISYtQwGAjgr8NQ==
X-Received: by 2002:a1c:964b:: with SMTP id y72mr720949wmd.69.1598173129897;
        Sun, 23 Aug 2020 01:58:49 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id z6sm16496008wml.41.2020.08.23.01.58.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 23 Aug 2020 01:58:49 -0700 (PDT)
Date:   Sun, 23 Aug 2020 10:58:47 +0200
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
Subject: Re: [PATCH v2 4/4] arm64: dts: imx8mm-var-som-symphony: Add
 Variscite Symphony board with VAR-SOM-MX8MM
Message-ID: <20200823085847.GC2886@kozik-lap>
References: <20200817070120.4937-1-krzk@kernel.org>
 <20200817070120.4937-4-krzk@kernel.org>
 <20200823020051.GJ30094@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200823020051.GJ30094@dragon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 10:00:51AM +0800, Shawn Guo wrote:
> On Mon, Aug 17, 2020 at 09:01:20AM +0200, Krzysztof Kozlowski wrote:
> > Add a DTS for Variscite Symphony evaluation kit with VAR-SOM-MX8MM
> > System on Module.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > 
> > ---
> > 
> > Changes since v1:
> > 1. Remove duplicated "leds" node,
> > 2. Fix heartbeat to active low,
> > 3. Add nxp,ptn5150 extcon.
> > ---
> >  arch/arm64/boot/dts/freescale/Makefile        |   1 +
> >  .../dts/freescale/imx8mm-var-som-symphony.dts | 248 ++++++++++++++++++
> >  2 files changed, 249 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> > index a39f0a1723e0..dcfb8750cd78 100644
> > --- a/arch/arm64/boot/dts/freescale/Makefile
> > +++ b/arch/arm64/boot/dts/freescale/Makefile
> > @@ -29,6 +29,7 @@ dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-qds.dtb
> >  dtb-$(CONFIG_ARCH_LAYERSCAPE) += fsl-lx2160a-rdb.dtb
> >  
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mm-evk.dtb
> > +dtb-$(CONFIG_ARCH_MXC) += imx8mm-var-som-symphony.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mn-ddr4-evk.dtb
> >  dtb-$(CONFIG_ARCH_MXC) += imx8mp-evk.dtb
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
> > new file mode 100644
> > index 000000000000..2d3c30ac5e04
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/freescale/imx8mm-var-som-symphony.dts
> > @@ -0,0 +1,248 @@
> > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > +/*
> > + * Copyright (C) 2020 Krzysztof Kozlowski <krzk@kernel.org>
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include "imx8mm-var-som.dtsi"
> > +
> > +/ {
> > +	model = "Variscite VAR-SOM-MX8MM Symphony evaluation board";
> > +	compatible = "variscite,var-som-mx8mm-symphony", "variscite,var-som-mx8mm", "fsl,imx8mm";
> > +
> > +	reg_usdhc2_vmmc: regulator-1 {
> 
> regulator-usdhc2-vmmc

You mean the node name? If so, it's not correct with device tree
specification:
"The node-name (...) should describe the general class of device.:
If appropriate, the name should be one of the following choices:
(...)
 - regulator"

Adding specific function/type/usage to the name of the node is a
opposite choice to "general class".


> 
> > +		compatible = "regulator-fixed";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
> > +		regulator-name = "VSD_3V3";
> > +		regulator-min-microvolt = <3300000>;
> > +		regulator-max-microvolt = <3300000>;
> > +		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +	};
> > +
> > +	reg_usb_otg2_vbus: regulator-2 {
> 
> regulator-usb-otg2-vbus
> 
> > +		compatible = "regulator-fixed";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_reg_usb_otg2_vbus>;
> > +		regulator-name = "usb_otg2_vbus";
> > +		regulator-min-microvolt = <5000000>;
> > +		regulator-max-microvolt = <5000000>;
> > +		gpio = <&gpio5 1 GPIO_ACTIVE_HIGH>;
> > +		enable-active-high;
> > +	};
> > +
> > +	gpio-keys {
> > +		compatible = "gpio-keys";
> > +
> > +		back {
> > +			label = "Back";
> > +			gpios = <&pca9534 1 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_BACK>;
> > +		};
> > +
> > +		home {
> > +			label = "Home";
> > +			gpios = <&pca9534 2 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_HOME>;
> > +		};
> > +
> > +		menu {
> > +			label = "Menu";
> > +			gpios = <&pca9534 3 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_MENU>;
> > +		};
> > +	};
> > +
> > +	leds {
> > +		compatible = "gpio-leds";
> > +
> > +		heartbeat {
> > +			label = "Heartbeat";
> > +			gpios = <&pca9534 0 GPIO_ACTIVE_LOW>;
> > +			linux,default-trigger = "heartbeat";
> > +		};
> > +	};
> > +};
> > +
> > +&ethphy {
> > +	reset-gpios = <&pca9534 5 GPIO_ACTIVE_HIGH>;
> > +};
> > +
> > +&i2c2 {
> > +	clock-frequency = <400000>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_i2c2>;
> > +	status = "okay";
> > +
> > +	pca9534: gpio@20 {
> > +		compatible = "nxp,pca9534";
> > +		reg = <0x20>;
> > +		gpio-controller;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_pca9534>;
> > +		interrupt-parent = <&gpio1>;
> > +		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
> > +		#gpio-cells = <2>;
> > +		wakeup-source;
> > +
> > +		/* USB 3.0 OTG (usbotg1) / SATA port switch, set to USB 3.0 */
> > +		usb3-sata-sel-hog {
> > +			gpio-hog;
> > +			gpios = <4 GPIO_ACTIVE_HIGH>;
> > +			output-low;
> > +			line-name = "usb3_sata_sel";
> > +		};
> > +
> > +		som-vselect-hog {
> > +			gpio-hog;
> > +			gpios = <6 GPIO_ACTIVE_HIGH>;
> > +			output-low;
> > +			line-name = "som_vselect";
> > +		};
> > +
> > +		enet-sel-hog {
> > +			gpio-hog;
> > +			gpios = <7 GPIO_ACTIVE_HIGH>;
> > +			output-low;
> > +			line-name = "enet_sel";
> > +		};
> > +	};
> > +
> > +	extcon_usbotg1: typec@3d {
> > +		compatible = "nxp,ptn5150";
> > +		reg = <0x3d>;
> > +		int-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_ptn5150>;
> > +		status = "okay";
> > +	};
> > +};
> > +
> > +&i2c3 {
> > +	clock-frequency = <400000>;
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_i2c3>;
> > +	status = "okay";
> > +
> > +	/* Capacitive touch controller */
> > +	ft5x06_ts: touchscreen@38 {
> > +		compatible = "edt,edt-ft5406";
> > +		reg = <0x38>;
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_captouch>;
> > +		interrupt-parent = <&gpio5>;
> > +		interrupts = <4 GPIO_ACTIVE_HIGH>;
> > +
> > +		touchscreen-size-x = <800>;
> > +		touchscreen-size-y = <480>;
> > +		touchscreen-inverted-x;
> > +		touchscreen-inverted-y;
> > +	};
> > +
> > +	rtc@68 {
> > +		compatible = "dallas,ds1337";
> > +		reg = <0x68>;
> > +		wakeup-source;
> > +	};
> > +};
> > +
> > +/* Header */
> > +&uart1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_uart1>;
> > +	status = "okay";
> > +};
> > +
> > +/* Header */
> > +&uart3 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_uart3>;
> > +	status = "okay";
> > +};
> > +
> > +&usbotg1 {
> > +	disable-over-current;
> > +	extcon = <&extcon_usbotg1>, <&extcon_usbotg1>;
> > +};
> > +
> > +&usbotg2 {
> > +	dr_mode = "host";
> > +	vbus-supply = <&reg_usb_otg2_vbus>;
> > +	srp-disable;
> > +	hnp-disable;
> > +	adp-disable;
> > +	disable-over-current;
> > +	/delete-property/ usb-role-switch;
> > +	/*
> > +	 * FIXME: having USB2 enabled hangs the boot just after:
> > +	 * [    1.943365] ci_hdrc ci_hdrc.1: EHCI Host Controller
> > +	 * [    1.948287] ci_hdrc ci_hdrc.1: new USB bus registered, assigned bus number 1
> > +	 * [    1.971006] ci_hdrc ci_hdrc.1: USB 2.0 started, EHCI 1.00
> > +	 * [    1.977203] hub 1-0:1.0: USB hub found
> > +	 * [    1.980987] hub 1-0:1.0: 1 port detected
> > +	 */
> > +	status = "disabled";
> > +};
> > +
> > +&iomuxc {
> > +	pinctrl-names = "default";
> 
> Drop this.

Indeed, thanks.

Best regards,
Krzysztof
