Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26251C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDBBD20578
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 11:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="rqjz591J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Jo4xIfDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgBXLBF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 06:01:05 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:47271 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727302AbgBXLBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 06:01:04 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id E5629762B;
        Mon, 24 Feb 2020 06:01:03 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 06:01:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ZcsAxlQzmgfp+248gfkt50f72yf
        XGFM0CMrpGGcfUak=; b=rqjz591JyJS7eCFFOrCKQhv/MhN/QfOGyBQHd2az1pe
        WoqWgpILpqn+XAr01g3Y/9dvYLq7Px2l+vOrWjirHSTKJ9M2TDOjem/FhVYW16Fy
        m5obfjQOt43XZUtCALzLBvYqNNG3eODcPaWqR4jTmSUAc6mOrjGkPGjbGwUyZtD5
        SIoR3MG7B6/ZG6IFXDdy8aSbSQM8ZkJ/lqAU9WNI2pcxWkfjlIYuPFUAgfqo4zMQ
        rZhrxUFTICGUBUF67QKAcjvOIlqY2/sOSn/Yrm6epoV5f0Nbhf1ribeFFlhzHgNh
        +68wIZz4oI/zTlcarut4v6Puy4ue/AXzsZbuTW6Tgog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ZcsAxl
        Qzmgfp+248gfkt50f72yfXGFM0CMrpGGcfUak=; b=Jo4xIfDL4pFRKONJsrXrFG
        AeGka/mFhVhUhgta9DD9XrZ8f30gJMqjGgId7HQMTyVn0bQW082W2Qb2TdhRRrrq
        37ExqrAwI5CPuPfaqeULjwziJWHym10gzeF5ZqiEjESUZO3fi1dGBrfvT4aTMtsS
        guieuIG1OY3sAKcVkzgsOJVA99XbSWzG1836DpPLesT8m525wfeqjZslrrj4hjpm
        /vDnIF1aG9IsN7izRd+EBRrdtWUmbwUVkkKs4sPNUCNJ42xYkoSJBSOOKI7/8nCP
        BYVmQXeFOzkGQ6yVHrH2Re2AInKDt5sJd0E8LyRBL6gUKEPYhimASk61+jiAGMWw
        ==
X-ME-Sender: <xms:7axTXmfCGfACAU-Go-6vz9eql4Q2BSZVUiXte9X8yotSfx2FCw1XUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtgddvfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:7axTXkh9gpLI75GndVJ3GdD5soM5-p7zjLEBMKls7wFQRkKiZw7r-Q>
    <xmx:7axTXiYK4d3j8xndCEeDylH7DAgYfHrpspQOaMPMJ2zryJiOFBF_2Q>
    <xmx:7axTXvINQpa3s1NrVBiSHThpOsjpCYByxIgwTPYIhYnm3f3f7HhLDA>
    <xmx:76xTXguzJNiO0fOLLqMGRMeXVH-bHX0VrUTxCVQTQS6xoCpM9ZDL8Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8B3CC3060FD3;
        Mon, 24 Feb 2020 06:01:01 -0500 (EST)
Date:   Mon, 24 Feb 2020 12:01:00 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Georgii Staroselskii <georgii.staroselskii@emlid.com>,
        Samuel Holland <samuel@sholland.org>,
        Martijn Braam <martijn@brixit.nl>, Luca Weiss <luca@z3ntu.xyz>,
        Bhushan Shah <bshah@kde.org>, Icenowy Zheng <icenowy@aosc.io>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: sun50i-a64: Add i2c2 pins
Message-ID: <20200224110100.acwln7zv3j5y67b2@gilmour.lan>
References: <20200223172916.843379-1-megous@megous.com>
 <20200223172916.843379-2-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="itczx53dk2nynkp7"
Content-Disposition: inline
In-Reply-To: <20200223172916.843379-2-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--itczx53dk2nynkp7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 23, 2020 at 06:29:14PM +0100, Ondrej Jirman wrote:
> PinePhone needs I2C2 pins description. Add it.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 862b47dc9dc90..0fdf5f400d743 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -671,6 +671,11 @@ i2c1_pins: i2c1-pins {
>  				function = "i2c1";
>  			};
>
> +			i2c2_pins: i2c2-pins {
> +				pins = "PE14", "PE15";
> +				function = "i2c2";
> +			};
> +

Setting it as the default muxing for i2c2 would be great

Maxime

--itczx53dk2nynkp7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlOs6wAKCRDj7w1vZxhR
xWI6AP44VoFKHK85VXx0xXuA1V0bHXa63zvjVyvoz5TB5O0mBAEAkLlwyvfiL8mG
2Ch1ACilRsLV/RB4PLsPCRzuHl8uNwU=
=M8JW
-----END PGP SIGNATURE-----

--itczx53dk2nynkp7--
