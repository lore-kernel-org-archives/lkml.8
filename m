Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A7CC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC872053B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="e+s/MFO1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G+Do9nny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgD1H6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:58:20 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:55825 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbgD1H6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:58:20 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 53D78580139;
        Tue, 28 Apr 2020 03:58:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 28 Apr 2020 03:58:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=E2zDRhRAXT59srKZrN/sdPOtf/1
        VxLhZFcu+n6RQ+70=; b=e+s/MFO1aKDyXc98fjOF6sGkjUtEDWkRrtpM1gXl59Y
        /4bEIjhRPD8pcErFk+EStYtKDaXCs3erk4Cifkz4VNoPzt7YcisKqsXB3oemRy9G
        jWXc95m9/dApLNcaJ78xwkS/aUmQ+3Gq2GS5OLevDuwMjFs+v4rWl2SFJ2l4r//M
        g8tXmawyEt7QgMxu2cKcvQA5dHWxVI7+HSSBhGxjD3QC9Rm6f1sedhccHvfZo9kN
        UCCGHR/QdLfbOW5j8iSpojFHZGXIFfM5RI2RE33GrhW+OZi5jv14ChIpm4OyV1IW
        vAxuwUvzNrz4V5a0+qrUIxfw3EzSJD/zAYqpSPNPRAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=E2zDRh
        RAXT59srKZrN/sdPOtf/1VxLhZFcu+n6RQ+70=; b=G+Do9nnyXMVKs+tVrfUW/x
        lPzV2CSYXrAZkSaVCBm8LxW0KlOHZVn9VpMs49KE4FlxhYhgJO/d/Q53fJcYnF+8
        6ls8hCtb2voX1zGPjVnPqdyhV4fv4uCxKDJPytvXJvJZkUS/JHqHG6WYheSXpFy5
        CxI/V1qdyujXz/Cdvy+bGl8wEk1XFGFB+jSqCug+MjESFUqjs3ZCKpcxNX3fBoYd
        z2NjTa32fi4kGAWZrUsom6+C5weSGcXrvjKADn6MhaUAzKqpxAgY+pcp+99oR4XY
        ST0uuaNKIQ07k83mmeCygu2IHyLZw7lw0z1bbJ7adAE1JAxPAwQ7w1ounSwPMseA
        ==
X-ME-Sender: <xms:GuKnXlQp9-TvG0uZNDh0JTcfGTyDVOWb_vI5cCDQ7sHPnzaPNX-U3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedriedtgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:GuKnXpCuCThrunnZ6dFJYzWl3_95Qc-NEcGLy3N09_n9Nz8qtkDHdw>
    <xmx:GuKnXsmBtkjBZaH7hPWjH0_OynDP__2OulZYbSq882aHtQ-wCIC7tA>
    <xmx:GuKnXhkewsyxDRHdqfwjYNbJ49HYxCPwbj3_A4iYLuIMRF6pUtU41g>
    <xmx:G-KnXhewACw1mmiW1mKWwm47E5k5TAvNIRXUXQPs-9F1wK6umaOnwg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 025803280067;
        Tue, 28 Apr 2020 03:58:17 -0400 (EDT)
Date:   Tue, 28 Apr 2020 09:58:16 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH 2/7] arm: dts: sunxi: h3/h5: Add HDMI audio
Message-ID: <20200428075816.p46abv7rrnlg6my6@gilmour.lan>
References: <20200426120442.11560-1-peron.clem@gmail.com>
 <20200426120442.11560-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bats57frlj3pqipa"
Content-Disposition: inline
In-Reply-To: <20200426120442.11560-3-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bats57frlj3pqipa
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Apr 26, 2020 at 02:04:37PM +0200, Cl=E9ment P=E9ron wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>=20
> Add a simple-soundcard to link audio between HDMI and I2S.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>=20
> diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi=
-h3-h5.dtsi
> index 9be13378d4df..3a4262294950 100644
> --- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> +++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
> @@ -105,6 +105,25 @@
>  		status =3D "disabled";
>  	};
> =20
> +	hdmi_sound: hdmi-sound {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,format =3D "i2s";
> +		simple-audio-card,name =3D "allwinner,hdmi";
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
>  	soc {
>  		compatible =3D "simple-bus";
>  		#address-cells =3D <1>;
> @@ -672,6 +691,7 @@
>  			dmas =3D <&dma 27>;
>  			resets =3D <&ccu RST_BUS_I2S2>;
>  			dma-names =3D "tx";
> +			allwinner,playback-channels =3D <8>;

This property doesn't exist in the binding

Maxime

--bats57frlj3pqipa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqfiGAAKCRDj7w1vZxhR
xXKlAQCv6MNWlrAX1U69XHGf0wvaL+nfygE1iVSzCRhMAp+wdAD/d9UJm7+SpDnw
YKDqJ4jLcBeUm3rEGjBnSLcIByUUNwI=
=l3WT
-----END PGP SIGNATURE-----

--bats57frlj3pqipa--
