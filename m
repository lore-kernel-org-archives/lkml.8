Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58901C11D2A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA6120658
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="hNX7A17R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UB+LyOuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbgBXJSN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:18:13 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:39093 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727168AbgBXJSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:18:12 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 758296FF4;
        Mon, 24 Feb 2020 04:18:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=2VnOSy+3DXO97qhGNXt4Spz18WD
        yHUSX81DuJnanSz8=; b=hNX7A17RBZUX4hBcqnYqP/48iwn86MHoidSrqwYYS3x
        G7ezQglw0KIsme7t5JDgIJttVq4bmz25LTx7RQEuLXvRc2n3AeL7ABTTUVnN9THY
        IJ1VFnTfIEcZAexmRLswPWx8L2Pq7TqMZV0lITGklUSvy8CjDEDnIAXFkFrPyinq
        n5hECwBMFGKWZ1LZ2yWLtdqe5dqdCYFXfVBO9i00aRCNe94C6FSNYPociDLpd2qT
        lNKcyJvVw5HD5jiiKSuq4uFJ80viZBxA2x2qTIw50Kcd/n3X0OpzEam5tc2tVnGI
        C3Bj2saKp6Y4z1Jd01gIj7IhBSmvZMJBSIilxZzjBQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=2VnOSy
        +3DXO97qhGNXt4Spz18WDyHUSX81DuJnanSz8=; b=UB+LyOujSuXg63CQn1Qq31
        3VnV7fExDdzy6mqSgD1qW5Xv1ZWpuc1sd+H+zD6a+cvm9gq+AFww8jVGqrMIQ8yY
        dDAzp6peQaQG/tUkwWjKo4CyRHSWcK464vOebPD2p9Hpdi72Sel07cFqMz8uv/uR
        j7M/V6Wh5a2X7wl0R5bkYtOnAR/0LkweKdzj4I3ZuNBjVnolbCJnSEcmKaP/Hs0n
        dIVVHyG5kiJevoWT+Ls0d8nCJNkpolaWCWw7TNUlkM95C0JgCQXoexnR1eGRlJNb
        zhp6O43gzGZ7OG0Xn6W4dEsychjUfzfI5qPFtjQWhPC+tX0OG9utt70T65G50yKg
        ==
X-ME-Sender: <xms:05RTXv0YPnGmwVuKELFToEd_g0qRP8NQ9r7usG0QRHo9m7--3PpPWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucffohhmrghinh
    epmhgvghhouhhsrdgtohhmnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnh
    hordhtvggthh
X-ME-Proxy: <xmx:05RTXoshoPK7pOxYrp0ct_K-uuwvbTrNpnSuL89eqQz4NcgReE_KRw>
    <xmx:05RTXl7gFrS16oAeAPc3Rz1p0Nl6y5MrO3nZYhbmTQMo7EIBBei8JA>
    <xmx:05RTXkf4AF8VryzMmEyQiq5z7VxyVom0FAxNUrFcdsfHxd5VkgrOaQ>
    <xmx:05RTXhPMyrLR0BIG7cj9XXEnhFR4mWTC9lcgPoIuxTE49zNY7eBJRw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1547E3060FD3;
        Mon, 24 Feb 2020 04:18:10 -0500 (EST)
Date:   Mon, 24 Feb 2020 10:18:09 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Sunil Mohan Adapa <sunil@medhas.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Add support for PocketBook Touch Lux 3 e-book reader
Message-ID: <20200224091809.teqbrhpzgirda4cx@gilmour.lan>
References: <20200223031614.515563-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fqx3qgvmmsrljpca"
Content-Disposition: inline
In-Reply-To: <20200223031614.515563-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fqx3qgvmmsrljpca
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Feb 23, 2020 at 04:16:11AM +0100, Ondrej Jirman wrote:
> This series adds a fairly complete support for this e-book reader.
>
> Missing parts are eink display driver and the touch panel driver.
> Support for both is available out-of-tree for now at:
>   https://megous.com/git/linux/log/?h=pb-5.6
>
> The rest of the board is supported by the mainline drivers.
>
> Please take a look.

Applied 2 and 3, thanks!
Maxime

--fqx3qgvmmsrljpca
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlOU0QAKCRDj7w1vZxhR
xW2DAQCiFvMw9EjUs7TQc7LJ2hozvZzWnmOKjgfWyMWSbkjMxwEAzDPUWCF2EBy5
Myv7TAuzmgu4b6L9Uo+lEOlaRvkBewQ=
=mNCG
-----END PGP SIGNATURE-----

--fqx3qgvmmsrljpca--
