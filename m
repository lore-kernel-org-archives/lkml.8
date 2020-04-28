Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E525C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:14:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 391F02082E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="V7lGextH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0KR9/7Z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgD1IOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:14:48 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:43963 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726621AbgD1IOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:14:48 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id EC5E25800DA;
        Tue, 28 Apr 2020 04:14:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 28 Apr 2020 04:14:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=Rl2dKFp212hN23zX63f+C/P6dfS
        tbQu0uWJ4H7pCcec=; b=V7lGextHwtaxIFTLlazW3bKC48l9uSC2as9K94BLlMN
        z+AIrtVYMgFeI5s1fzR2vZJLTgCYuMiBHXX8XjwKg40/GBOj9YbDA8X3/9dtlL2p
        Ej2qudOwnoPoD9HGVJLJ8dtKa7sjd/lGCFZcVV8/0BYE+V4Gw1pSyKcpfTroKhkf
        KwRym875pnQhhDJwsEA7HoCRGs+5gYjlAisfoxfEoDdudnOXt9J8mFNU/VNRKi9H
        ae0dMzVTUQpVx/8162Z2XjOeCVGYggcWGm1Z92aTlEUDLmUxdFlyHdO2VWBzGMqi
        ic9o79CB86xGTeVdfrkOBgE+nJARcul+d1ZZceJiOAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Rl2dKF
        p212hN23zX63f+C/P6dfStbQu0uWJ4H7pCcec=; b=0KR9/7Z4PvGy27sTQOgVhj
        fGBAcavBXb62ROKnUOLF+FhaTXS1GLunRIez5dtgmzfkV37pamU2rRkRFGMSVzpL
        9flAOJrM3Xg9COKeQPuLSHSw8gwvwjQ9zWKuCLxiXWDdrGuxQ/rVVkzMBg4KSOXn
        6TlxnGOu3BsGNZ89VLacYb9DB+bll6azrrXztMMNlwksskTU/cC1HtY2ZjW7Tk6p
        OdosNU7dG2H61smxEyfMxjjLcLOKqIHFAMA3CNthGapohsg2TmBAzu2hZ29P2idq
        W74I9/CgUDRPa56fZZ7sxMSLHirhyUyXf3U1jUdVkLPFWRamKxx/JUM0z2SJ3RFA
        ==
X-ME-Sender: <xms:9uWnXsCpwV72yiqvxhE4nlArD6ON2JmAIoGATUy4T4viAwDmIL002Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedriedugddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:9uWnXgYfvH5yydUG2zNGQbmZvHRp1Jgmr6I2BlxSAswQCOVr9Hd72Q>
    <xmx:9uWnXkvL3rjW4j_ePDEEF4RS3SbMxrhRIp6P0PFVwJegIDnkOFqqrw>
    <xmx:9uWnXi9ad555hJxDt44hBAfwSzBHkpTsqqS5RQnRq1C3b-mP-reWIg>
    <xmx:9uWnXgFEU8EeGc3Pciue44v7fhSNlZ52z06WyNWJc36pdBh_avXZxQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id BBFA13065E8D;
        Tue, 28 Apr 2020 04:14:45 -0400 (EDT)
Date:   Tue, 28 Apr 2020 10:14:44 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Marcus Cooper <codekipper@gmail.com>
Subject: Re: [PATCH v3 7/7] arm64: dts: sun50i-h6: Add HDMI audio to H6 DTSI
Message-ID: <20200428081444.vddwswsorl5tf7yp@gilmour.lan>
References: <20200426104115.22630-1-peron.clem@gmail.com>
 <20200426104115.22630-8-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="34tj5oypfixbg5ni"
Content-Disposition: inline
In-Reply-To: <20200426104115.22630-8-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--34tj5oypfixbg5ni
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2020 at 12:41:15PM +0200, Cl=E9ment P=E9ron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>=20
> Add a simple-soundcard to link audio between HDMI and I2S.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 31 ++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/bo=
ot/dts/allwinner/sun50i-h6.dtsi
> index a5ee68388bd3..558fe63739cb 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -88,6 +88,24 @@
>  			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>  	};
> =20
> +	sound_hdmi: sound {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,format =3D "i2s";
> +		simple-audio-card,name =3D "allwinner-hdmi";

It doesn't seem to be on purpose, but the name is different from the other
series you sent.

Maxime

--34tj5oypfixbg5ni
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqfl9AAKCRDj7w1vZxhR
xSzfAQCyUP2gys2O31vFV8nbzG01R6D7k8xImWeYCJji+veaSgEA8v2gBNki9GaR
+i4rWPFMYJfnRvxQOzIiQzMgStA4hQ4=
=PQem
-----END PGP SIGNATURE-----

--34tj5oypfixbg5ni--
