Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AA5C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B3D120866
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 12:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="UzzPsvAT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LS/LxoeT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgHaMmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 08:42:02 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:36515 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgHaMlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:41:55 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 9B93E9DD;
        Mon, 31 Aug 2020 08:41:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 31 Aug 2020 08:41:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=a2/0cAti7fRZnNrhavvYmYZV37C
        YMMnRg+cCcgtHRKo=; b=UzzPsvAT1iDQgLb9X6ty/scoPpsWFx5NmAsg96KHB8c
        ABeck/QX3R1yJFsTgOumTOZ3OXxtXJQKbeezPJ3RPeZQqfBW1bArFMzXbJ7l96+e
        5seLnWY5GDhq/4jaZLUrrvEGy5vShIGjIDtvaCboEzOg/jL3pk43aVrhF+/5PSt0
        DnaJ6UhyfhLqZjg8eRfe9VTB7bs75n9Yi6f4Bxnf4fAjiXB8v0aeZgzhywRJUS86
        Pr/UP8C6YEyaaGfM5Wha3UBS+a8xtgmH+yi8p8dXtNcPVcsqCA1SR8YpL/btRthF
        waBcA+I+y1GxWoerUnId7qkJ5MnaWcjHe6GgyGIfyRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=a2/0cA
        ti7fRZnNrhavvYmYZV37CYMMnRg+cCcgtHRKo=; b=LS/LxoeTl7Yf3gMl3fRRYN
        3onXdkKkCMkwRmpei65DGbbbpcRkAU/uQ+kMJ0PnDVgwGoGNrnJPHJL0KnxASbK+
        mYTJzKvcKvtVU5HpFDCEdziBBIQMFGlEWa4gvf5p72No/ONC1UgOdEKuC6mpOquA
        0ATDSF8MjgcRUQdi13J9kBx/OGgD0vOChaxBINmLZaAO5602yyk5vjZVxuV/yHEe
        H9lDc7axjghIGsBBl86mWtIBzwrZPurunvGmKNwJqsyIW142xPSHMWdGdIqreLVu
        6lspccLgldyRfOiHaeA2veCtsZxL2yK0vkDltgeZAAvP7Na/nR+DggX3Y+zJ0prQ
        ==
X-ME-Sender: <xms:DvBMXyy_aZOvBpo58GOnYw9fU1KcPYPVKSvGfwDx8DnAsd15Uzy-KQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefhedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:DvBMX-QJTnIhN6pDUF3Z5yBrFQHAmfbOjZRWsZw1bMtlDZtra2YN6Q>
    <xmx:DvBMX0VmrZUn6Acg1u9kk78coKfgSyAufC-NDRdDQvWw1xdOOMuR0g>
    <xmx:DvBMX4j1Nef_d-cdd0YKSdeQDo7nj6gF_fWqWh22MZ7JYGo9mI3aUA>
    <xmx:EfBMXz7wKYi1yJHY1rljH6-cxmCmYauk9Ux76vt_HRjC7qZJ1YpUDA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6B0D53280060;
        Mon, 31 Aug 2020 08:41:50 -0400 (EDT)
Date:   Mon, 31 Aug 2020 14:41:48 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] drm/sun4i: Fix dsi dcs long write function
Message-ID: <20200831124148.wxklchu3bygnumt4@gilmour.lan>
References: <20200828125032.937148-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bo4es2ituvyk4gfz"
Content-Disposition: inline
In-Reply-To: <20200828125032.937148-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bo4es2ituvyk4gfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2020 at 02:50:32PM +0200, Ondrej Jirman wrote:
> It's writing too much data. regmap_bulk_write expects number of
> register sized chunks to write, not a byte sized length of the
> bounce buffer. Bounce buffer needs to be padded too, so that
> regmap_bulk_write will not read past the end of the buffer.
>=20
> Fixes: 133add5b5ad4 ("drm/sun4i: Add Allwinner A31 MIPI-DSI controller su=
pport")
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks
Maxime

--bo4es2ituvyk4gfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0zwDAAKCRDj7w1vZxhR
xUvxAQCi4X8KG2ve/vqvH7ccu9eiejZWW3SS62xXNT3V5YX9AQEAwlCIsdLKx6kC
h9cF4hcGyros+fqCR/D32gijLZl4BAM=
=A4sy
-----END PGP SIGNATURE-----

--bo4es2ituvyk4gfz--
