Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB41C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E3CF222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="tywSwr8n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jwUvz1sG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgBNIzp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:55:45 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60029 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726004AbgBNIzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:55:45 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 6905021E50;
        Fri, 14 Feb 2020 03:55:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 14 Feb 2020 03:55:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=/a85ZSsJiYdegZEdtXRPQlGTMav
        avDGNTs4eYyPQzJ8=; b=tywSwr8n8QHjBlblmLU5aBpL1DvLo+5/rV8/BGgkCGm
        CP3fb82G/Ad1WsdxgE/1OtzbjhSapfFXP2/Ai032DiWXJvRYfbvu1UoYjeWC/Mz7
        ZuCIQ4ohLtmlORxknqU08LWF86QuLpJjIsa8eB/23sh7n68WqlHc1DyCFMa7gM15
        TgcGP4+uVnuNWS+HqlMh6L9uRwhVFHRxb62GUv1vZqiZG7PW+IytEE7TASOMKdJ/
        VxEvZ3R95ja5/2Vq/YLvlHeu8LIv1Vi5AgBYblbC04Bocu5qmA3i0BC8lboHJJz3
        a9TttybUoo4ak+b0EcbOxRk4zf5f0IX0FHeD6z8qDJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/a85ZS
        sJiYdegZEdtXRPQlGTMavavDGNTs4eYyPQzJ8=; b=jwUvz1sGGhS8mq/RYpI6tk
        nHuQY2j3Q2edywj2uBKEOEznYxcF/zHLX6vCM5xpGDS0iIWbXaUd7XpYyvvS98W8
        7EgIE2+gNRDGAyFQtJGMPw7KzpJfNiMCOYfX3iaJabhfMZLE8hUvT46/w692n0Dc
        CAaXyHl2C4ptEl0Wd+6NWqs5Mq/7ygaXwQtA7zEDIuoENsxYvR1WH2Jf+F5vUyj+
        py1QA0qCJYE9+1MrUDtfPLidZq8A44pYk+WJthB/zxbp2uGbTVmn2PHKVR6StT7f
        OdjExoN5fWRXjyP0/AAXzoOZKKnpn1PmogT+r8n69uJUbFox/yw7ag/RLU05NbwQ
        ==
X-ME-Sender: <xms:j2BGXjhI5cXxGTATvjjUPdWBr9ClJNUb4DULFVErDPysoTotsSrsTg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieelgdduvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:j2BGXj9XTDMNi4XblnVWX7Nmc13cKvr0PehX93_WQe3Dm598ZNN8zw>
    <xmx:j2BGXrn_tMYDpMPfhO5wpnGRGbGMuvrr5iN9CFJnYaUOW9d3js-W-A>
    <xmx:j2BGXp0oOddO2V6SE4V3ybGjl-1XJgr02jduVIuTr56zfiUjY36eFQ>
    <xmx:kGBGXifppv6BfQHpLCpbiGe9Ydeauys2uygyhqqTwfW6UbuO37E4Kg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 15C3F3060BD1;
        Fri, 14 Feb 2020 03:55:42 -0500 (EST)
Date:   Fri, 14 Feb 2020 09:55:41 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andrey Lebedev <andrey.lebedev@gmail.com>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: Re: [PATCH v3 3/3] ARM: dts: sun7i: Add LVDS panel support on A20
Message-ID: <20200214085541.mfp72rwyidfkf6wr@gilmour.lan>
References: <20200210195633.GA21832@kedthinkpad>
 <20200213201854.810-3-andrey.lebedev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vxvbh5ewfbsbnjy5"
Content-Disposition: inline
In-Reply-To: <20200213201854.810-3-andrey.lebedev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vxvbh5ewfbsbnjy5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2020 at 10:18:57PM +0200, Andrey Lebedev wrote:
> From: Andrey Lebedev <andrey@lebedev.lt>
>
> Define pins for LVDS channels 0 and 1, configure reset line for tcon0 and
> provide sample LVDS panel, connected to tcon0.
>
> Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 92b5be97085d..3b3c366a2bee 100644
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
> +						allwinner,tcon-channel = <0>;
> +					};
> +
>  					tcon0_out_hdmi: endpoint@1 {
>  						reg = <1>;
>  						remote-endpoint = <&hdmi_in_tcon0>;
> @@ -1162,6 +1168,24 @@
>  				pins = "PI20", "PI21";
>  				function = "uart7";
>  			};
> +
> +			/omit-if-no-ref/
> +			lcd_lvds0_pins: lcd-lvds0-pins {

The nodes here should be ordered by alphabetical order

> +				pins =

I'm not sure why you need a new line here

> +					"PD0", "PD1", "PD2", "PD3", "PD4",
> +					"PD5", "PD6", "PD7", "PD8", "PD9";
> +				function = "lvds0";
> +				allwinner,drive = <SUN4I_PINCTRL_10_MA>;

And allwinner,drive is also deprecated and at its default value anyway

Maxime

--vxvbh5ewfbsbnjy5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXkZgjQAKCRDj7w1vZxhR
xUpIAQCU4grCWDNWYH8iKUVKxI050gsFcXKfbe4o1PEEMKl+awEA0I7IdRkoWQva
VEi+atkzhqlMoosoisULNuchXIdCPgA=
=6FR0
-----END PGP SIGNATURE-----

--vxvbh5ewfbsbnjy5--
