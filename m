Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B80C8300C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F9E206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="f65ebsSB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N5AWIvge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgD1IAa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:00:30 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:60207 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726253AbgD1IAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:00:25 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 7D59D580305;
        Tue, 28 Apr 2020 04:00:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 28 Apr 2020 04:00:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=QKnGsgk4OM0TOmaItjELfauJeFA
        9d1+f5+xcE296M/w=; b=f65ebsSBuYtNvUzQD1D/EKKPdF7I4mR18U6NcIicujK
        7pEHbeW6Z2u7Nd3WjPH0wKdMKrxF9yGtt1XDFHslN2xjlIN1SCW1RZXcNBRRsYJ0
        /ADAwcNpeD6+9UrVgkigOCh8U+D+AqDX+zMSbqkk6mOOu8KAl2CU6FMFQJiy/c+n
        bV6SILCzbPXecC2aEOp26y+jc4aP+BOT4A9jW/6fOeZOYkRKs4C1Lj3UQp/DOl1q
        x2SvazWn1pjzTPdzifW3dJZqafVrhcvaFGMLb3cDjSmHprH3w+dmtVlf6GlvFEmY
        oj0IGlqXzHIjhRTD0RQRMBW52VMg7+//cRqK1UXZGxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QKnGsg
        k4OM0TOmaItjELfauJeFA9d1+f5+xcE296M/w=; b=N5AWIvge0CixkUA4JOg+0U
        Rnm7noh+st93ixLYq4lhVEZbD1Mpl4JTEs+sTfeeXPO6SY56E8RDbc5+XW1BPWXJ
        mVyHrbVJKJ+9qA0B25xCfT8kSBCc55ZmtLBs1WMaUYim0BKGFYvbmxF/Ta948plH
        Lv5Uql0NWvS11Q3fHkzbSJsM8tW9VWe2PJD6bFTJ63XwvFpNwcIzFraPxTaOFl0l
        4n1OgHAAqebDzTR9hDKAYFnRd4+OOhATKKVOf2zuwk9L67eZ3prOyTMRGSvleStF
        1hIcKoO6M+R9FpizMYfNp7ys0A3F5Yqe2VCLWIFn0iebka1ItnxmmFCGbjMW1YaQ
        ==
X-ME-Sender: <xms:l-KnXoyUO1XN3ffF3xnEd7HHPe9yeZ-OseJDr6mNtoWWa4rZUvI86w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedriedtgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:l-KnXs91k7lnVuYQAjLtdkPJbsBG34LFPAAjrncgcT2VBJdn9R5YzQ>
    <xmx:l-KnXoj3KeSihdw2k43jvBVlm_suW6AOgfhOab1MBXCk6DuJqe2WjA>
    <xmx:l-KnXrH0700yoQE9hAaubCUwvDeHNBVTurPnVUmxtUNiKO_2OR4pZw>
    <xmx:mOKnXrmGsRPT5O5irMYC50hvK-Nu-adIK3BIFGBZzmENBTRnRczDGw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3BE253065E8D;
        Tue, 28 Apr 2020 04:00:21 -0400 (EDT)
Date:   Tue, 28 Apr 2020 10:00:20 +0200
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
Subject: Re: [PATCH 4/7] arm64: dts: allwinner: a64: Add HDMI audio
Message-ID: <20200428080020.35qcuylwq2ylmubu@gilmour.lan>
References: <20200426120442.11560-1-peron.clem@gmail.com>
 <20200426120442.11560-5-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="l7t7g67wc3rnzd33"
Content-Disposition: inline
In-Reply-To: <20200426120442.11560-5-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--l7t7g67wc3rnzd33
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2020 at 02:04:39PM +0200, Cl=E9ment P=E9ron wrote:
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
> index e56e1e3d4b73..08ab6b5e72a5 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -102,6 +102,25 @@
>  		status =3D "disabled";
>  	};
> =20
> +	hdmi_sound: hdmi-sound {
> +		compatible =3D "simple-audio-card";
> +		simple-audio-card,format =3D "i2s";
> +		simple-audio-card,name =3D "allwinner,hdmi";

I'm not sure what the usual card name should be like though. I would assume=
 that
this should be something specific enough so that you're able to differentia=
te
between boards / SoC so that the userspace can choose a different configura=
tion
based on it?

If so, it's really too generic.

Maxime

--l7t7g67wc3rnzd33
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqfilAAKCRDj7w1vZxhR
xUrBAQCbumUlWsmdgdc+kpR+FkqE+YcGoZOrfRXqGiqZpskC0gD/Xu0cJh7MGRSA
crG2mlpqdCmsMDhoXZAU05/rhM98oQA=
=Yq8j
-----END PGP SIGNATURE-----

--l7t7g67wc3rnzd33--
