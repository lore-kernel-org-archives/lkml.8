Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7A5C433E3
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 16:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 975152075B
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 16:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Va45Xos9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgHWQi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 12:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgHWQi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 12:38:27 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92800C061573;
        Sun, 23 Aug 2020 09:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YGI9CUlHRdCGssJcQqqFI32/JdSs/OG4pNXNnIVDjlM=; b=Va45Xos9+GWduEXlVaM2nPXmrT
        kNIIyeulu4SvMYVxkIDYzUGJYtXKC2XFEZzwYhiUjyxUTgBetHfBBOs1bNb1hQX1iMsY9508jeof3
        uuvT50KEIZ5SnJ5kzshTU8mIljOvsZsa8+StULVXDSVkQ1DN23Chpw1WxkOZpjFah/vQ=;
Received: from pd9e2f105.dip0.t-ipconnect.de ([217.226.241.5] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1k9t0R-0004GD-O8; Sun, 23 Aug 2020 18:38:07 +0200
Date:   Sun, 23 Aug 2020 18:38:06 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     robh+dt@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, Anson.Huang@nxp.com,
        marcel.ziswiler@toradex.com, sebastien.szymanski@armadeus.com,
        michael@walle.cc, rjones@gateworks.com, leoyang.li@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, j.neuschaefer@gmx.net,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH RFC 2/2] ARM: dts: imx: add devicetree for Tolino Shine
 2 HD
Message-ID: <20200823183806.4a5c4134@aktux>
In-Reply-To: <20200823014226.GG30094@dragon>
References: <20200815193336.21598-1-andreas@kemnade.info>
        <20200815193336.21598-3-andreas@kemnade.info>
        <20200823014226.GG30094@dragon>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 Aug 2020 09:42:31 +0800
Shawn Guo <shawnguo@kernel.org> wrote:

> On Sat, Aug 15, 2020 at 09:33:36PM +0200, Andreas Kemnade wrote:
> > This adds a devicetree for the Tolino Shine 2 HD Ebook reader. It is based
> > on boards marked with "37NB-E60QF0+4A2". It is equipped with an i.MX6SL
> > SoC.
> > 
> > Expected to work:
> > - Buttons
> > - Wifi
> > - Touchscreen
> > - LED
> > - uSD
> > - USB
> > - RTC
> > 
> > Not working due to missing drivers:
> > - Backlight (requires NTXEC driver)
> > - EPD
> > 
> > Not working due to unknown reasons:
> > - deep sleep (echo standby >/sys/power/state works),
> >   wakeup fails when imx_gpc_pre_suspend(true) was called.
> > 
> > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > ---
> > Reason for RFC: The suspend trouble might be caused by bad devicetree.
> > But as the devicetree is already useful I decided to submit it.
> > 
> >  arch/arm/boot/dts/Makefile                   |   1 +
> >  arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts | 582 +++++++++++++++++++
> >  2 files changed, 583 insertions(+)
> >  create mode 100644 arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
> > 
> > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > index e6a1cac0bfc7..c65fa3852246 100644
> > --- a/arch/arm/boot/dts/Makefile
> > +++ b/arch/arm/boot/dts/Makefile
> > @@ -581,6 +581,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
> >  	imx6qp-zii-rdu2.dtb
> >  dtb-$(CONFIG_SOC_IMX6SL) += \
> >  	imx6sl-evk.dtb \
> > +	imx6sl-tolino-shine2hd.dtb \
> >  	imx6sl-tolino-shine3.dtb \
> >  	imx6sl-warp.dtb
> >  dtb-$(CONFIG_SOC_IMX6SLL) += \
> > diff --git a/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
> > new file mode 100644
> > index 000000000000..7b28e19a1d98
> > --- /dev/null
> > +++ b/arch/arm/boot/dts/imx6sl-tolino-shine2hd.dts
> > @@ -0,0 +1,582 @@
> > +// SPDX-License-Identifier: (GPL-2.0)
> > +/*
> > + * Device tree for the Tolino Shine 2 HD ebook reader
> > + *
> > + * Name on mainboard is: 37NB-E60QF0+4A2
> > + * Serials start with: E60QF2
> > + *
> > + * Copyright 2020 Andreas Kemnade
> > + */
> > +
> > +/dts-v1/;
> > +
> > +#include <dt-bindings/input/input.h>
> > +#include <dt-bindings/gpio/gpio.h>
> > +#include "imx6sl.dtsi"
> > +
> > +/ {
> > +	model = "Tolino Shine 2 HD";
> > +	compatible = "kobo,tolino-shine2hd", "fsl,imx6sl";
> > +
> > +	chosen {
> > +		stdout-path = &uart1;
> > +	};
> > +
> > +	gpio_keys: gpio-keys {
> > +		compatible = "gpio-keys";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_gpio_keys>;
> > +
> > +		cover {
> > +			label = "Cover";
> > +			gpios = <&gpio5 12 GPIO_ACTIVE_LOW>;
> > +			linux,code = <SW_LID>;
> > +			linux,input-type = <EV_SW>;
> > +			wakeup-source;
> > +		};
> > +
> > +		fl {
> > +			label = "Frontlight";
> > +			gpios = <&gpio3 26 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_BRIGHTNESS_CYCLE>;
> > +		};
> > +
> > +		home {
> > +			label = "Home";
> > +			gpios = <&gpio3 25 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_HOME>;
> > +		};
> > +
> > +		power {
> > +			label = "Power";
> > +			gpios = <&gpio5 8 GPIO_ACTIVE_LOW>;
> > +			linux,code = <KEY_POWER>;
> > +			wakeup-source;
> > +		};
> > +	};
> > +
> > +	leds: leds {
> > +		compatible = "gpio-leds";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_led>;
> > +
> > +		on {
> > +			label = "tolinoshine2hd:white:on";
> > +			gpios = <&gpio5 13 GPIO_ACTIVE_LOW>;
> > +			linux,default-trigger = "timer";
> > +		};
> > +	};
> > +
> > +	memory@80000000 {
> > +		device_type = "memory";
> > +		reg = <0x80000000 0x20000000>;
> > +	};
> > +
> > +	reg_wifi: regulator-wifi {
> > +		compatible = "regulator-fixed";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&pinctrl_wifi_power>;
> > +		regulator-name = "SD3_SPWR";
> > +		regulator-min-microvolt = <3000000>;
> > +		regulator-max-microvolt = <3000000>;
> > +		gpio = <&gpio4 29 GPIO_ACTIVE_HIGH>;  
> 
> Missing enable-active-high?
> 
no. I should rather use GPIO_ACTIVE_LOW to avoid that confusion.
corresponding code in vendor kernel is the function
_ntx_wifi_power_ctrl()


Regards,
Andreas
