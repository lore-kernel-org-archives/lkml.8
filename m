Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F214CC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D6224650
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 09:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="o8B+D7eX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EmmPIq3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729817AbgBMJnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 04:43:09 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:38995 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729440AbgBMJnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 04:43:08 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4EE0721F8E;
        Thu, 13 Feb 2020 04:43:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 13 Feb 2020 04:43:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=mraLXR1UzZtD3bIaM15nHcYWwvQ
        LOE+cfoM1QmqErKE=; b=o8B+D7eXShRldG2XErB+8R+Wmqoa06qXCcf+BnBa+AI
        LfZQQggfxmWFW2+GvwCiMvpwdgs/LQOahAJEvCP914588AkZ2QwYON0CeEvZw0b9
        ZSNvXrrTJgptXcVYe4UU9iwNX0Pwwu0JVddpUNY1Sfm2yQ5SJNTPSGQXSxvAttPN
        j4QmaFnLP1SG82MWk3PRx+SaiKvXzdgnj4+ae764VkzGA2b+ItNFBRsOnXEztnTc
        nkRhbVOdJGqUJk1B1tNOI4BavCXfPjSjnX5UYn6n+FKYLWwQ3IityLC4SL14xteK
        MA/CzvK+882O5ccKpsZh9kJxsa3HWcV0JeFvEI+esYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=mraLXR
        1UzZtD3bIaM15nHcYWwvQLOE+cfoM1QmqErKE=; b=EmmPIq3bT5Ve+6LefZTiyh
        ejdDpz0Gj/W0/zIjZyfBTR8R2I/f/WRHLVAETa9iBQCYFxtuWUrpUjJPykSpfLor
        pOop7sY58AOcNFzt2rFXI+WFExCYMflVMD90R7veW2dl8Y9oxvgaqar0e1a2pFAZ
        NOMhvAI+wLylBGRsjyJXU1/LIzed8WJNa7OUXMVh9nRgvFv8wOkNXyODC2+oujWD
        np8bGTGFbeHISNe9Sb7O6AH7k8CUrLr59iNdGvKGoNr1EBq2ux82fp/1Fv9/RcyU
        N2ttnu+pSkE6WjsWtiNDqAAmFvPgGGOlk8W87aIlEyB5Y/5o0ZA14M511vMvx/dg
        ==
X-ME-Sender: <xms:KhpFXtJtYSwlwPuc5Kr4nCDqhdgJJVJ0VrNNpNjAyv6OBKJeBtMiYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieekgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:KhpFXnaeMp-s2_3W8oVdM_ywlRLPR8QA95LPnZPSLsJRv2yJBuiTRA>
    <xmx:KhpFXu1zfEq1wI8irD8HTXkfb80zvWzZ5USE7loNaDMDkStaNrYKWg>
    <xmx:KhpFXvlzNXl5PT-Xy2KwTz5Q0BbznCtjyz6tlCkUcY2CPwh88Hvscw>
    <xmx:KxpFXpIoVcx1b4i_yvT630G23TUOI1KHxqWj0N8Rzmzj6swj-LxRTg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2C73D3280063;
        Thu, 13 Feb 2020 04:43:06 -0500 (EST)
Date:   Thu, 13 Feb 2020 10:43:04 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     andrey.lebedev@gmail.com
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: Re: [PATCH v2 2/2] ARM: sun7i: dts: Add LVDS panel support on A20
Message-ID: <20200213094304.hf3glhgmquypxpyf@gilmour.lan>
References: <20200210195633.GA21832@kedthinkpad>
 <20200212222355.17141-2-andrey.lebedev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zztmkqxcnfnc34uw"
Content-Disposition: inline
In-Reply-To: <20200212222355.17141-2-andrey.lebedev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zztmkqxcnfnc34uw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2020 at 12:23:57AM +0200, andrey.lebedev@gmail.com wrote:
> From: Andrey Lebedev <andrey@lebedev.lt>
>
> Define pins for LVDS channels 0 and 1, configure reset line for tcon0 and
> provide sample LVDS panel, connected to tcon0.
>
> Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>

And this prefix should be ARM: dts: sun7i ;)

> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 45 +++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 92b5be97085d..b05fdf8df32e 100644
> --- a/arch/arm/boot/dts/sun7i-a20.dtsi
> +++ b/arch/arm/boot/dts/sun7i-a20.dtsi
> @@ -47,6 +47,7 @@
>  #include <dt-bindings/dma/sun4i-a10.h>
>  #include <dt-bindings/clock/sun7i-a20-ccu.h>
>  #include <dt-bindings/reset/sun4i-a10-ccu.h>
> +#include <dt-bindings/pinctrl/sun4i-a10.h>
>
>  / {
>  	interrupt-parent = <&gic>;
> @@ -407,8 +408,8 @@
>  			compatible = "allwinner,sun7i-a20-tcon";
>  			reg = <0x01c0c000 0x1000>;
>  			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> -			resets = <&ccu RST_TCON0>;
> -			reset-names = "lcd";
> +			resets = <&ccu RST_TCON0>, <&ccu RST_LVDS>;
> +			reset-names = "lcd", "lvds";
>  			clocks = <&ccu CLK_AHB_LCD0>,
>  				 <&ccu CLK_TCON0_CH0>,
>  				 <&ccu CLK_TCON0_CH1>;
> @@ -444,6 +445,11 @@
>  					#size-cells = <0>;
>  					reg = <1>;
>
> +					tcon0_out_lvds: endpoint@0 {
> +						reg = <0>;
> +						remote-endpoint = <&lvds_in_tcon0>;
> +						allwinner,tcon-channel = <0>;
> +					};

A new line here would be nice

>  					tcon0_out_hdmi: endpoint@1 {
>  						reg = <1>;
>  						remote-endpoint = <&hdmi_in_tcon0>;
> @@ -686,6 +692,19 @@
>  			};
>  		};
>
> +		lvds_panel: panel@1c16500 {
> +			compatible = "panel-lvds";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			status = "disabled";
> +
> +			port {
> +				lvds_in_tcon0: endpoint {
> +					remote-endpoint = <&tcon0_out_lvds>;
> +				};
> +			};
> +		};
> +

There's no point in creating that panel.

>  		spi2: spi@1c17000 {
>  			compatible = "allwinner,sun4i-a10-spi";
>  			reg = <0x01c17000 0x1000>;
> @@ -872,7 +891,7 @@
>  			gmac_rgmii_pins: gmac-rgmii-pins {
>  				pins = "PA0", "PA1", "PA2",
>  				       "PA3", "PA4", "PA5", "PA6",
> -				        "PA7", "PA8", "PA10",
> +					"PA7", "PA8", "PA10",
>  				       "PA11", "PA12", "PA13",
>  				       "PA15", "PA16";
>  				function = "gmac";
> @@ -1162,6 +1181,26 @@
>  				pins = "PI20", "PI21";
>  				function = "uart7";
>  			};
> +
> +			/omit-if-no-ref/
> +			lcd_lvds0_pins: lcd_lvds0_pins {

underscores in the node names will create a dtc warning at
compilation, you should use lcd-lvds0-pins instead.

> +				allwinner,pins =
> +					"PD0", "PD1", "PD2", "PD3", "PD4",
> +					"PD5", "PD6", "PD7", "PD8", "PD9";
> +				allwinner,function = "lvds0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> +				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;

Those properties are deprecated and should be replaced by pins and
functions. allwinner,drive and allwinner,pull are at their default
values and can be dropped.

This will create a spurious warning message for TCON1, since we
adjusted the driver to tell it supports LVDS, but there's no LVDS
reset line, so we need to make it finer grained.

Maybe adding a tcon0 / tcon1 compatible? Chen-Yu, any thought?

Maxime

--zztmkqxcnfnc34uw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXkUaKAAKCRDj7w1vZxhR
xWvqAQDWlCEogDZ5hH+fBXPvo6T5UizTKCW8akmEaSCXi1OH0AEAuYrejnkpB02Z
OIBbgDk1XuTQW5eT8yzabddVdXyjego=
=IugG
-----END PGP SIGNATURE-----

--zztmkqxcnfnc34uw--
