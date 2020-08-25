Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BABCBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8532620578
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="BPudZ4Di";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X/8Y+AmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHYOnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:43:42 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:53025 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726218AbgHYOnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:43:35 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 67CA7A9F;
        Tue, 25 Aug 2020 10:43:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 10:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=G+BwascLzyFPnImweXcLxkco9Sz
        SuhxlJ7okMvsbLh0=; b=BPudZ4Di3VAFcsSm6vRjf5BTJoobmhwYfiJslXL+Q4C
        TBqaFDJQtMtKZCrj8mMbNqSwdYUy5WzGtRvM2q+1vCYfRP4L5rreqGU2wPyijY2B
        B5yR64TrGICzCNIQ8pW8ZZSADpFt8W1n+YHD4/soYG1Bp8/F88rfd41UeHz7k3rf
        I2PGQ1Nw2q0sKgL5RBGY/70KHlr3w7xth0yGB4JRQ829MLByXvlQYBANhVD46dHu
        NZzjvSWoMXrV5AX5GQDM1+d2eFTuxNVn28vPFqTGBJR3bMPL4DCqOdemKot3S4xB
        3QTM52RyMug3qWVlrUi+b53PtA2yjXDeqCaSXuT0f2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=G+Bwas
        cLzyFPnImweXcLxkco9SzSuhxlJ7okMvsbLh0=; b=X/8Y+AmDI1E6xJOsStOQnL
        E9QhuFbOv64z4vWqSkgHJ/7qdMNkZIx4X1AL0Oxxewqn9eLtcKNVgq1Fxvq0YV0c
        KAqAwOtvunXgeHhxnHcCARRjYYOJ1O3K0b+9Rw0bLNpeJ16NkQ3BrvebqpVvksqs
        953458dmzbG1OIVUA51IAxtODw+wN1M/QzX9fMJX3QywapBjqIxchKbEc/R3a/om
        nHo9SBIePcYNsKfp7JoMyBaJ5xf7OnEP96sJcwHk7gADtubdTbv8DH3LwLnfjwBl
        HFt0tF4wDG6EJWIRh2vfHMHDZSgMHFW/Mtbs5jGZV6KpWqiBCmmPDndG+rKc2QQg
        ==
X-ME-Sender: <xms:lSNFX8bwjWxmaKaKiPBaS66IMlEUWaUsX7Q7pCQ7HjzvevL5fGkbhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:lSNFX3aEP7FxKVHamK8ctUsImjKmKUeFMDAhAIqShQHTrp9Ig3VE5A>
    <xmx:lSNFX2_CNfF-BLwhfa0dC4M624RzH1J-w6UZgc-E45EpFFwo_uUYvg>
    <xmx:lSNFX2rvysVX9ZgEgTO-lu2kVlxk_1Iqvy6TB68herWoI8WoajqB3g>
    <xmx:liNFX4nWjoEe9Q57Qq8UIkpga9lCY00Z9JKZq4X5Ii50ej1IZAYEFQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C6AAC3280064;
        Tue, 25 Aug 2020 10:43:32 -0400 (EDT)
Date:   Tue, 25 Aug 2020 16:43:31 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] clk: sunxi-ng: sun8i: r40: Use sigma delta modulation
 for audio PLL
Message-ID: <20200825144331.fw75zyu6aid7wlaz@gilmour.lan>
References: <20200825131049.1277596-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6icvwhtcgumkpw2o"
Content-Disposition: inline
In-Reply-To: <20200825131049.1277596-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6icvwhtcgumkpw2o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2020 at 03:10:49PM +0200, Jernej Skrabec wrote:
> Audio cores need specific clock rates which can't be simply obtained by
> adjusting integer multipliers and dividers. HW for such cases supports
> delta-sigma modulation which enables fractional multipliers.
>=20
> Port H3 delta-sigma table to R40. They have identical audio PLLs.
>=20
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks!
Maxime

--6icvwhtcgumkpw2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0UjkwAKCRDj7w1vZxhR
xR7KAP9Ppt49Gp0BuHp/CbXPOo3pnWV7/Ut8AJMvqbQOqR+OzgD+K/VTnPQ1G0w+
paW7WN68vQn5FDb2Hb9kQxhnf9nxlQA=
=r/vC
-----END PGP SIGNATURE-----

--6icvwhtcgumkpw2o--
