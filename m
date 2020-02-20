Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB9DC11D10
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01BA1207FD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="ajY+f6+o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fiZBiIh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgBTRX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:23:26 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42897 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728173AbgBTRX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:23:26 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BBB4021E29;
        Thu, 20 Feb 2020 12:23:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 20 Feb 2020 12:23:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=vbvI29EQ0v8H6J4KfL2LWXgZy9K
        YsqNtddfsF3hvK68=; b=ajY+f6+oQcGeRKarwVpE9Yi1OOem4Ka7HuzwJqJwqyn
        nRWtiEhP6XHwd0kci0kCV+LE3tGIdAOR79YosPBczTLT3pa3r5Pr9c+nH0VLz3Cm
        azkXzJSb33yaxX1fIFuTeu290KZKyjUs+CHNwmXuvRz1wM5QaSVf2uvyfLqlcGgh
        4KD5uHZGi3FQKSZ6lbMCzD4H5uY9zdZsmj2SVerUEFTTdMb+4gxNzE7ojqhFOCe9
        Gd1CRT0asFYI5DXTLors4fH7Zf+F8NKXedLaP4O1ZOgPWMNuaf2jVdpnNScLy+An
        XltbPA70DuvRE6AyvUTzf52EYBlmPqRaVQnEasdUz0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vbvI29
        EQ0v8H6J4KfL2LWXgZy9KYsqNtddfsF3hvK68=; b=fiZBiIh2MzQrDMzZaPhzVZ
        XUs09j+V726JW9G8OmfADC8oJT1dVdLoNkbvMkrylFXB8SUBK3/O/CfM7iw7xWB7
        TDPkz1XL7Dv6/au5VA1OsQU8LLcNWMvWP6vRCB/yGHJFBteA1VNSdOma5H7VTsPu
        QYYV6GCJIMETbYphucDpRSaWA8R1bH00B5eoWy8kPMuEqxtS99wLRvfzh3pJ1X9Y
        QvWpfZ1vt5ywJ7gdQy5QckmelIHiKY1uSWvPvuPaYtgPirWzGSuLSeqN716teg+C
        tpsv8cmP5+w/7NMlAloMv6/90u8iH2oCNy2MOLO6xx/hA1z2fZxnRNk0LCBPrrqA
        ==
X-ME-Sender: <xms:jMBOXpoTszGApMQqaWMuP_TfBQNkNYyb7fCcmlslDqMVV_o3_ctncQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkedvgddutddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:jMBOXsYSqqXSTc0ZkfbaHClmHG83dM5_0KmNul_PJGIWZui7_nB51g>
    <xmx:jMBOXqAhxezaAXxV1RwoHrTTdvhQV4eEgvP8moiqpgTfrREUqbYT4A>
    <xmx:jMBOXme_vgWaV1dFv66xNiuIeJbqfyeqrI7CphkbP4KYUmwL0cj7gw>
    <xmx:jcBOXhG6PMBYwIQkIavaIA1kfyU_zcpnZ2Wa5cc_hmrbfrxRkYZztw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7E5D3328005D;
        Thu, 20 Feb 2020 12:23:24 -0500 (EST)
Date:   Thu, 20 Feb 2020 18:23:23 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Andrey Lebedev <andrey.lebedev@gmail.com>
Cc:     wens@csie.org, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Andrey Lebedev <andrey@lebedev.lt>
Subject: Re: [PATCH 3/5] ARM: dts: sun7i: Add LVDS panel support on A20
Message-ID: <20200220172323.lgeb4zqmbg6kcvr6@gilmour.lan>
References: <20200210195633.GA21832@kedthinkpad>
 <20200219180858.4806-1-andrey.lebedev@gmail.com>
 <20200219180858.4806-4-andrey.lebedev@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="d6sfey5dsbwbndvm"
Content-Disposition: inline
In-Reply-To: <20200219180858.4806-4-andrey.lebedev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--d6sfey5dsbwbndvm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 19, 2020 at 08:08:56PM +0200, Andrey Lebedev wrote:
> From: Andrey Lebedev <andrey@lebedev.lt>
>
> Define pins for LVDS channels 0 and 1, configure reset line for tcon0 and
> provide sample LVDS panel, connected to tcon0.
>
> Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
> ---
>  arch/arm/boot/dts/sun7i-a20.dtsi | 30 ++++++++++++++++++++++++++----
>  1 file changed, 26 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
> index 92b5be97085d..d50263c1ca9a 100644
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
> @@ -404,11 +405,12 @@
>  		};
>
>  		tcon0: lcd-controller@1c0c000 {
> -			compatible = "allwinner,sun7i-a20-tcon";
> +			compatible = "allwinner,sun7i-a20-tcon0",
> +				     "allwinner,sun7i-a20-tcon";
>  			reg = <0x01c0c000 0x1000>;
>  			interrupts = <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> -			resets = <&ccu RST_TCON0>;
> -			reset-names = "lcd";
> +			resets = <&ccu RST_TCON0>, <&ccu RST_LVDS>;
> +			reset-names = "lcd", "lvds";
>  			clocks = <&ccu CLK_AHB_LCD0>,
>  				 <&ccu CLK_TCON0_CH0>,
>  				 <&ccu CLK_TCON0_CH1>;
> @@ -444,6 +446,11 @@
>  					#size-cells = <0>;
>  					reg = <1>;
>
> +					tcon0_out_lvds: endpoint@0 {
> +						reg = <0>;
> +						allwinner,tcon-channel = <0>;
> +					};
> +

This isn't necessarily true. The endpoint would be the same for an RGB
panel for example. I've followed what we're doing elsewhere and
removed that endpoint entirely while applying, thanks!
Maxime

--d6sfey5dsbwbndvm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXk7AiwAKCRDj7w1vZxhR
xbrdAP9X63/5hBLxm5f2JSxXpC2INrkCYBsgrd+YWuJGEwqb2wEAmkyx5BXcSBsi
+JmpgeKEkfyHNnXY6iu8ddp9SayGMgI=
=1aoH
-----END PGP SIGNATURE-----

--d6sfey5dsbwbndvm--
