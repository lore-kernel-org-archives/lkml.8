Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D37C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C3F8206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="A97YDx9p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="acVa4t8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgD1IIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:08:18 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:40111 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgD1IIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:08:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 59CAC5802E9;
        Tue, 28 Apr 2020 04:08:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 28 Apr 2020 04:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=OVZvX9ztpd3XO2zL1SITFUQ9DK5
        Z2gkbV9MIZCnCejk=; b=A97YDx9pFcTwEC5Eor+FoCSnxhkgx3giVjOGqyiOt4A
        atW1Qr06fsoPI+jEj/kPk6FGdXuPiyPYzMVFb3SjCeNFsGJrU82eW85D+EKC0RQp
        WgchYwQXxdyTnWXvLpC4wxFEijEwJktaYS9bDQbPesXQW85X8qv8r3HvlathPBP/
        3D8WaYkknpJA9Fes7VpC6PjeNU5GrhB4Ge0smn9pJf0JRbwtWmZ+zB0CtgrkLMUj
        SttfQgzNLsBcDhMpmtlU2iTUzDx9pMobL0K8TQ8OKPRAp/NmqCq6lAiokUcdg7F2
        /VTYVtOhNYqaFSOSMXdypJckaHsNun5UOuF3/eBhmzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=OVZvX9
        ztpd3XO2zL1SITFUQ9DK5Z2gkbV9MIZCnCejk=; b=acVa4t8SGRiPe0dSv6nKx3
        EXA/Wok0esjUe11KXXPCqhUWsm9lka0dIvIZpSyBjDSRS67eirA8VYpzc5SIy09V
        0gtKP6ttMTbze285gJ5OMGcwmkyhvwN1OzThRnRM2WsEn15Df2XSolk5plfIPYjz
        jLu4C2en7VWEPDhyIKTk7DWRRHoTKOiYAtmJyN0hiGce7enwFXffZs4ktVDx+w2X
        P/rSNtxGzJyhyddHV3cazH7H4NLJ651FpzAz1/0QixbATlM3PX8UBvp1ZviAzTlG
        p/BY/pea26eN7lV8oIKKPL6XxwC5Vuo4JSVXohF+WxiZl1/lV313G5aYGoH71I9g
        ==
X-ME-Sender: <xms:b-SnXgWxTXvdISPFiZrB4LN6FGORQVik4Lc5WJOZl68qupLHc0ZoyA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieduucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhmvgcutfhi
    phgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltddrkeelrd
    eikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:b-SnXhQpZeFTgZ5WSDqescbIPH9xvHgH_gpcvAaMx73MAKqOyZ3G9w>
    <xmx:b-SnXoRYWIsHZ3J8cS3g9aPlS0VZfxF-hy1zb2_eQqNtfq9MBAjr8w>
    <xmx:b-SnXpc7mmOGQoliWXn8ickLqT7sXTw6yRoe9wH2s6KiZvrL73YkgQ>
    <xmx:ceSnXmZR4NXkjCHV49g7STZyYbdkwpdyP1Dp7IL4PDMJCzmQakF1TQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 950693280064;
        Tue, 28 Apr 2020 04:08:15 -0400 (EDT)
Date:   Tue, 28 Apr 2020 10:08:14 +0200
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
Subject: Re: [PATCH v3 2/7] dt-bindings: ASoC: sun4i-i2s: Add H6 compatible
Message-ID: <20200428080814.ohoheyzsxuz3a2vx@gilmour.lan>
References: <20200426104115.22630-1-peron.clem@gmail.com>
 <20200426104115.22630-3-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bzjincgmfho5il5t"
Content-Disposition: inline
In-Reply-To: <20200426104115.22630-3-peron.clem@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bzjincgmfho5il5t
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2020 at 12:41:10PM +0200, Cl=E9ment P=E9ron wrote:
> From: Jernej Skrabec <jernej.skrabec@siol.net>
>=20
> H6 I2S is very similar to H3, except that it supports up to 16 channels
> and thus few registers have fields on different position.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> Signed-off-by: Cl=E9ment P=E9ron <peron.clem@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--bzjincgmfho5il5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXqfkbgAKCRDj7w1vZxhR
xX1iAQCyxmpAiKfglOauQ1fEaSGCeuG5209yy891bHX9EQTBfQEAic7/IcGTay+I
duX3bvjzJqt4tuc/CDhoFux4gXacJAM=
=2Teg
-----END PGP SIGNATURE-----

--bzjincgmfho5il5t--
