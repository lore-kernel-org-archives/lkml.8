Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7A8C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6771C20BED
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:17:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="FH98ECTw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rLUXQXeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbgIDJRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:17:40 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57971 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730040AbgIDJRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:17:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id E88665C00DE;
        Fri,  4 Sep 2020 05:17:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 04 Sep 2020 05:17:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=nXtW0JM/wQOy2uCuK/dLlEM2S2h
        S3nRUa7pxa/yayMM=; b=FH98ECTwp+ZqR17ouKPYsTMtCsO2SLRcmc6SgyiY2xy
        LlTj2b2lB5DzyLFXO6ojaooTN34kqtPfb69M8qvWm6pAinhm9vPN2hrMGEb3Agpi
        ar7/6KLeo9+zhZSImuVDybYxx5gM1z9Q8LsEf+6ANR+QG+IYHSoDlvvNX6Eu6YLT
        cb6T/tw1SkIdjPnWeLYutm77sIDnTeConEeG+p0qquZYehbSkd3ffsktHJm10wS7
        bkK31fE4nQyEYCYAR1V2dz4xv2RnHBW26bJFHdCqsw/YCYPnQ/fVjBjelwjoYArM
        /+iZI0AKPebf1kJJqR44svnLwMGc0nSsX9qhXcTPIXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=nXtW0J
        M/wQOy2uCuK/dLlEM2S2hS3nRUa7pxa/yayMM=; b=rLUXQXeTj2tPZC28kPtwXx
        Pd3hXhLPAp3ArNXS5yxVtlC9An/rU54kGNWIzlxxSmP7WYtrOjPGGZMDSxBablWE
        GT1sPsCN/MfjenTjt4ulvAH5Tb1zX4hx83/5dm4TQiVOBwAyb2GtkTqnLwny/zpL
        ZnTLA1gxMlXdj4KBibufkYBao2xvBj5sm9vuzi7R/y9lTlBdh/XjTAih931mvsGt
        7Mn4dV8VdZsF5Zik+H7FX6lnXCAFgvjHuWF5XNRtQnGeJywcJ810AzuPVnVRCrRI
        kwatKMo3jc49WKkv9jCphDtOmi2DRkt8Pwl6h/SRCvNcnbAQCo2w9Bixr/dv9CEA
        ==
X-ME-Sender: <xms:MAZSX3nW7hAQSJOgWdc6UUqm6bRrKZpOOmnK4vqhv6F7vlJflMYjXw>
    <xme:MAZSX60j5LfGUuJ-TbfkjE_krS8R9gCo7ppZSGCmVt62fISjRk9geYCFoks4hiOMX
    M_y-N45UBc3t9zXf7g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudegfedgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:MAZSX9r2DCVLoZfolNAbfSxqE-lIH-owYcGhbzbYe3IFUC4a1Y0QLA>
    <xmx:MAZSX_liKE4ZQjh9e4vB_gbggfTsLmvY3tOgv2oX-lxyAzFzQ7_hTg>
    <xmx:MAZSX12e7feZfJiEWd05hIki6UFlJp0Ym82jGwMrq_h5NSkjCBKOhA>
    <xmx:MQZSXynzAXYqlbeDnsXEIapb_-IZRtWVyBn_Ko67jCBRWh3ol_Hgww>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0A09B3280059;
        Fri,  4 Sep 2020 05:17:35 -0400 (EDT)
Date:   Fri, 4 Sep 2020 11:17:35 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ondrej Jirman <megous@megous.com>, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] ASoC: sun8i-codec: Attach the bus clock to the regmap
Message-ID: <20200904091735.vnb4u6l4t2iipe4t@gilmour.lan>
References: <20200831034852.18841-1-samuel@sholland.org>
 <20200831034852.18841-9-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kyjiehp5lg45epo2"
Content-Disposition: inline
In-Reply-To: <20200831034852.18841-9-samuel@sholland.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kyjiehp5lg45epo2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2020 at 10:48:51PM -0500, Samuel Holland wrote:
> When attached to the regmap, the bus clock is automatically enabled as
> needed to access device registers. This avoids needing code to manage it
> separately in the driver.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--kyjiehp5lg45epo2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX1IGLwAKCRDj7w1vZxhR
xR3aAP9tr4i8/MgEGjzLOk1dppyp12G0jxAn27lU5ULr6DWEqwEAzhscJnmVVjny
GVBualf1cUKONE+QN1x9iktXD5HsGA0=
=1Dov
-----END PGP SIGNATURE-----

--kyjiehp5lg45epo2--
