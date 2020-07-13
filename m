Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB72AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE94B206F0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 09:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgGMJqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 05:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgGMJqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 05:46:11 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF07DC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 02:46:10 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1juv2E-0002EX-BQ; Mon, 13 Jul 2020 11:46:06 +0200
Subject: Re: [PATCH 3/3] ARM: dts: colibri-imx7: add usb dual-role switch
 capability
To:     Philippe Schenker <philippe.schenker@toradex.com>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20200710132423.497230-1-philippe.schenker@toradex.com>
 <20200710132423.497230-3-philippe.schenker@toradex.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <73240ab0-5069-40c5-4ade-7fcc2207dfaf@pengutronix.de>
Date:   Mon, 13 Jul 2020 11:46:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710132423.497230-3-philippe.schenker@toradex.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Philippe,

On 7/10/20 3:24 PM, Philippe Schenker wrote:
> Since the runtime-pm wakeup bug was fixed in
> drivers/usb/chipidea/core.c usb dual-role host/device switching is
> working. So make use of it.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> 
> ---
> 
>  arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 9 +++++++++
>  arch/arm/boot/dts/imx7-colibri.dtsi         | 4 ++--
>  2 files changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> index 97601375f264..db56a532a34a 100644
> --- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> @@ -20,6 +20,14 @@ clk16m: clk16m {
>  		clock-frequency = <16000000>;
>  	};
>  
> +	extcon_usbc_det: usbc_det {
> +		compatible = "linux,extcon-usb-gpio";

According to 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver"):
"the old way using extcon to support USB Dual-Role switch is now deprecated
 when use Type-B connector."

Have you considered using a compatible = "gpio-usb-b-connector" child node instead?

Cheers,
Ahmad

> +		id-gpio = <&gpio7 14 GPIO_ACTIVE_HIGH>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_usbc_det>;
> +	};
> +
> +
>  	gpio-keys {
>  		compatible = "gpio-keys";
>  		pinctrl-names = "default";
> @@ -174,6 +182,7 @@ &uart3 {
>  };
>  
>  &usbotg1 {
> +	extcon = <0>, <&extcon_usbc_det>;
>  	status = "okay";
>  };
>  
> diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
> index e18e89dec879..caea90d2421f 100644
> --- a/arch/arm/boot/dts/imx7-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri.dtsi
> @@ -457,7 +457,7 @@ &uart3 {
>  };
>  
>  &usbotg1 {
> -	dr_mode = "host";
> +	dr_mode = "otg";
>  };
>  
>  &usdhc1 {
> @@ -486,7 +486,7 @@ &usdhc3 {
>  &iomuxc {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_gpio1 &pinctrl_gpio2 &pinctrl_gpio3 &pinctrl_gpio4
> -		     &pinctrl_gpio7 &pinctrl_usbc_det>;
> +		     &pinctrl_gpio7>;
>  
>  	pinctrl_gpio1: gpio1-grp {
>  		fsl,pins = <
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
