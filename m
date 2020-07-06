Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0214BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F0220715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="GyDU8QU/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pDpLaGQG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgGFFb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 01:31:27 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:45577 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728710AbgGFFb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 01:31:27 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 5124458051B;
        Mon,  6 Jul 2020 01:31:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 06 Jul 2020 01:31:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=WKyQCL1ic+iC6Uc1+65VueAxHLF
        Mh0dPBP5e4GWcnGs=; b=GyDU8QU/z7cxgfHZiIPPvULXoGTAqGZkqWusgkAa15E
        cTErUycNQExN4pf/rfnRAErLlcMPWLv6SK9gaousOBpCDIBPdD56ATDg9Ka1ET38
        o+s+LlCAqZYMo6nXsJZU9YBKwA2X4B48D9iPU2B8aaSFOotpYHxW2bakjmOm8ZF+
        Pyc8OMj5mBmencafRx8WSmdmmhgyTFGB/E8cGSApPVNV0d8ue3ZgKNNmDVDS9j0P
        r0cuSK1mnubxxagDSPNvA+464P8IUVhHTWi4u4P32EYdJCpOUKI+m5qtmQJtssP5
        9kE7ZsFHhC2D2xUWGdg5QU2FOapRH+X8iubQwFfdRIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=WKyQCL
        1ic+iC6Uc1+65VueAxHLFMh0dPBP5e4GWcnGs=; b=pDpLaGQGpdL9nUt2M4RZCo
        HMKGeLzoDqp++2dKS55uTuRNSO7YvWTjj/MomaEsDSpHDAa3Dcdq5wfqJcQcPY+s
        D3QbIoBDKY7oi4wGLv6giD00zP/Cnajh3oWb/V0u9nJXIm2lrMLPyoQ4um/7PcHD
        ZXkL4+bgReq2ZivDqxQnZsdeUk0bYe4i4HqQzK3paWzGLmIju44BINH82kH5DyTb
        kMo+LLwq+QVkDq1W9RyvYAgwpEenSej8wHH74L/s7GCF2Nfk/pAKT6MDynvA5XU3
        uIqLe0DFF4EXVPyYFsUsmtjJLr66bn02FyJdUkaAvrzk80taZ75N1mCIlOHJItjg
        ==
X-ME-Sender: <xms:LLcCX22MaQPKnxDX7jZwLd2K7G4C0HVgPYSJpAj88yDXTmESd1qVHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgdelgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:LLcCX5HUjIopOW31gQaPlCc3NMOr9SrMuSwjXYAJa9WEWfe7tBP8GQ>
    <xmx:LLcCX-4f_S-dnLZ3uT5lP_PXpvbHahrPJte1uF9i1tbHI_wdMJcnOw>
    <xmx:LLcCX33YwfGtcMHMg6mMKdEih2R_6kynmFi58Et8hL1pBin3ZrbL9A>
    <xmx:LrcCXx_YcoAP3BCYjTJLq92D4z_MGH5umNWRGL_uGS7hQYuXDkvNsg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6A35F30653ED;
        Mon,  6 Jul 2020 01:31:24 -0400 (EDT)
Date:   Mon, 6 Jul 2020 07:31:23 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 13/16] arm64: dts: allwinner: a64: Add HDMI audio
Message-ID: <20200706053123.uenb3nrdrckdvao7@gilmour.lan>
References: <20200704113902.336911-1-peron.clem@gmail.com>
 <20200704113902.336911-14-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uyy6f6byomhmdood"
Content-Disposition: inline
In-Reply-To: <20200704113902.336911-14-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uyy6f6byomhmdood
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 04, 2020 at 01:38:59PM +0200, Cl=E9ment P=E9ron wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>=20
> Add a simple-soundcard to link audio between HDMI and I2S.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/b=
oot/dts/allwinner/sun50i-a64.dtsi
> index c662f6a170ce..6a321fdc8e90 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -102,6 +102,25 @@ de: display-engine {
>  		status =3D "disabled";
>  	};
> =20
> +	hdmi_sound: hdmi-sound {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,format =3D "i2s";
> +		simple-audio-card,name =3D "sun50i-a64-hdmi";
> +		simple-audio-card,mclk-fs =3D <128>;
> +		simple-audio-card,frame-inversion;
> +		status =3D "disabled";
> +
> +		simple-audio-card,codec {
> +			sound-dai =3D <&hdmi>;
> +		};
> +
> +		simple-audio-card,cpu {
> +			sound-dai =3D <&i2s2>;
> +			dai-tdm-slot-num =3D <2>;
> +			dai-tdm-slot-width =3D <32>;
> +		};
> +	};
> +
>  	osc24M: osc24M_clk {
>  		#clock-cells =3D <0>;
>  		compatible =3D "fixed-clock";
> @@ -856,6 +875,7 @@ i2s2: i2s@1c22800 {
>  			resets =3D <&ccu RST_BUS_I2S2>;
>  			dma-names =3D "tx";
>  			dmas =3D <&dma 27>;
> +			allwinner,playback-channels =3D <8>;

This isn't documented anywhere

Maxime

--uyy6f6byomhmdood
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXwK3KwAKCRDj7w1vZxhR
xerOAQDJKnS9jqfb9I6HEIiwk9owTLZ5YOI48O1UfvR91KSL5wD/eqv9UZ1V230I
0ozBROi+ZprQ2l9brT8puh88zJF1RAA=
=3Ow7
-----END PGP SIGNATURE-----

--uyy6f6byomhmdood--
