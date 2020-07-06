Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E09C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A012D2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 05:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Jeh0GA+y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LycLHK9w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgGFF3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 01:29:42 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:38967 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbgGFF3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 01:29:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 6533B580518;
        Mon,  6 Jul 2020 01:29:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 06 Jul 2020 01:29:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=pwom6EhByiguzZVplfbjBnBP65w
        atD/Qn4Iq6UPhCSk=; b=Jeh0GA+ypz8EHMTRzL76IUGJl29Rnm+e0X53z/B/7C+
        WZ5CpKOIR3zzyFU98bkX8gWeghJyXRPCG3l/0+v5y5RVY10rdLVfPB/fP2AwsArW
        /G6OZuS1vuQlJlGGtfKOJLNlyPnJQ3/lYfMnWgEg5X1+Gk93pRCrhrenKGUTpSMF
        T5Lc63S05GDs4rnqD10C8fpZDfMNvN1JBuRHA/n9gmRuOjQnn3VwGY8i0jt3TaAO
        BHbN+SvAlAfTvcDzHFf2/oQZqsHghmWyhFh5yAITDdu+0AdKULZ6z27olBg8Jlpq
        dK7EcaHH5n46tuRNWxZRbyPvVFF519g2DDkPJ9PexVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=pwom6E
        hByiguzZVplfbjBnBP65watD/Qn4Iq6UPhCSk=; b=LycLHK9wRLe6SwSvULlPnX
        vLHEZUbyZlpky8x2c4hqRFXxThr/VFW67+8QV3oDqOCdSrdBCrWxJT27XSEhPPiI
        qhchhUD/46dJlK07hX+LjCKmUu6+prtCqAtBy4EsPcqdhS4SIaDBDqCZF+H3pkIj
        TXt+niEn5v+Nws8b7PeV1O3510JSYSHs38pnQgrkgHcr+gVFAY88g2WPZ/B7LT4e
        4jr9Qf5AD+bmUZbBKD+jeDZu9VMBxblatZj34BVsd90GMg/GbITnQvoGeEB1M8d9
        bt+/Bj52XMd3zdLroU1yhDum3WyIu1f6R8gbuM9FRkc4p8ijjNCFId9NX0aZbvCw
        ==
X-ME-Sender: <xms:wrYCX2oQdaez2-1MdZQ8RRa-F7XjLuqbwf4q_EWZ9So-qQGjflOXJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeduvdduhfekkeehgffftefflefgffdtheffudffgeevteffheeuiedvvdejvdfg
    veenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:wrYCX0pVRc-oOakKcXYdCzBzdqhSpX0HGfEUrJlwWeMiZL56LooRLA>
    <xmx:wrYCX7Mkvk7_u-VkWxEjGOLqVZhFhioCNP1LMBuHIZx5S8i2eErSHQ>
    <xmx:wrYCX17e1a-ZaoRFLR-BCWWBpRT2GXiXP5lt-rku6EP0yLj6-9FrcA>
    <xmx:xLYCXyzMiC6b5Hgi2yPOxwVvyJzvnkGvIxm1vbl_EE9vq6JTfOaM0A>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7AADD328005E;
        Mon,  6 Jul 2020 01:29:38 -0400 (EDT)
Date:   Mon, 6 Jul 2020 07:29:37 +0200
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
Subject: Re: [PATCH 08/16] arm64: dts: allwinner: h6: Add HDMI audio node
Message-ID: <20200706052937.ygjjllrsj7rvynkq@gilmour.lan>
References: <20200704113902.336911-1-peron.clem@gmail.com>
 <20200704113902.336911-9-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zabvcj3d4ofdrekw"
Content-Disposition: inline
In-Reply-To: <20200704113902.336911-9-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zabvcj3d4ofdrekw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 04, 2020 at 01:38:54PM +0200, Cl=E9ment P=E9ron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>=20
> Add a simple-soundcard to link audio between HDMI and I2S.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 33 ++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
> index 78b1361dfbb9..ae169d07b939 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -67,6 +67,25 @@ de: display-engine {
>  		status =3D "disabled";
>  	};
> =20
> +	hdmi_sound: hdmi-sound {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,format =3D "i2s";
> +		simple-audio-card,name =3D "sun50i-h6-hdmi";
> +		simple-audio-card,mclk-fs =3D <128>;
> +		simple-audio-card,frame-inversion;

Have you figured that one out?

> +		status =3D "disabled";
> +
> +		simple-audio-card,codec {
> +			sound-dai =3D <&hdmi>;
> +		};
> +
> +		simple-audio-card,cpu {
> +			sound-dai =3D <&i2s1>;
> +			dai-tdm-slot-num =3D <2>;
> +			dai-tdm-slot-width =3D <32>;

I'm not sure why you need to use the TDM stuff here. IIRC the HDMI
controller can output on up to 6 channels, so how would that work out?

Maxime

--zabvcj3d4ofdrekw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXwK2wAAKCRDj7w1vZxhR
xZM5AP48KiovnrBuDrRSfzXBBjVfHTI9Y+xsX21MeZsf8aYsBQEA8lBvXN/W6RPo
OtYiNKW1d7/qBWi5EkuPxGrsxT7PYQU=
=A3Kc
-----END PGP SIGNATURE-----

--zabvcj3d4ofdrekw--
