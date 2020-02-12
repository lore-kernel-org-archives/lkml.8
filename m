Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A7ABC3F68F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB13720661
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 18:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="S3codB0S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DKi/2qYk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbgBLSBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 13:01:36 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:54525 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726728AbgBLSBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 13:01:35 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CF6F3889;
        Wed, 12 Feb 2020 13:01:33 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 12 Feb 2020 13:01:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=X0tUEgWYpJskWtZqIPoTJqiI8dE
        WemwbHtY1RuLYLac=; b=S3codB0SjgfiIeerPWZhWCajm4HsdDALTl7fEkpMSD+
        eTtCk0tBX/aaMgE6NiI3ZYCRSB8L3Qpm/oQtC9uKtxa/mygebsxXLRPI1S+GGoPk
        FKzM0uZvzjV7GY55Oxr8iwsh8lBqYIv4tEMwI1Z//tIKc4slQQkVLUyN0KqEi40j
        kN0/fI1SiCubXxhmSJejIlyF3K7PrqK1hQPmZnDhAXfCUoYlZKhDuey2fslIRxvn
        HgLGbSKqU9ld0/FSZ0sd2rfe1rKzXZtdV/aF2XofZD03eJa91QFiklt33nRSE/6T
        tVbQU6++FLZd5aVosEqGp/p7LeKdfd+Bgngek1fzVIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=X0tUEg
        WYpJskWtZqIPoTJqiI8dEWemwbHtY1RuLYLac=; b=DKi/2qYkOb4RXiyBa0ZtqP
        VlIpTADIqROLl600En03rfr0/3XG4PGk4RKjV7trRkGwQRHMVHGXRlgey410zib5
        PkRS5LeVrZhTkR7q5Z+IwweUWaPX1gRo+ku34IrAH8B6ntRincJXTESm9MnXepgM
        6YEBsVFpjzl5dke+cG6ibcdE5BLdCPDetH0wa6yATxC2bxGdkSceKg9ETL7f6Edx
        WwYsEeO5mwXQlpIn0ssYXsnH8MQQ1lcEXhdOntxmtY9FYbaW666/5qqrOmKo3r3O
        QzszbqksMGs1QlHkfge77LSak8ymVnm20m3X+5rO4+uTKLB/2uau54io9uFiwWDA
        ==
X-ME-Sender: <xms:fD1EXgncqtNlKrmcXmTRI4OPNk4OtsF-8B_knl0x1Q75ufg5Kg2aqQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieehgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:fD1EXnJb43z0HlyQTC8HtyJzy3SBxOBRT9xyaOew91gFXah7c4q6DA>
    <xmx:fD1EXhTL0-N2gPgABFG_wBbwHEPvr5_KKzXY6VoC_zerTiwDxGtD1g>
    <xmx:fD1EXmqUM0DYEA2_Wcm2XI_tATG7lXCXnIdH6jxtjxwkUqxgD_-tAA>
    <xmx:fT1EXlPb8FRYWG31si6SJypIn8ezCY230mMzItnY3AVP3zHI1Uu6AA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 462ED3280059;
        Wed, 12 Feb 2020 13:01:32 -0500 (EST)
Date:   Wed, 12 Feb 2020 19:01:30 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, mturquette@baylibre.com, sboyd@kernel.org,
        icenowy@aosc.io, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] clk: sunxi-ng: sun8i-de2: Multiple fixes
Message-ID: <20200212180130.kqxcafhbhw76gbmu@gilmour.lan>
References: <20200211185936.245174-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="svjny34pbuqgftj2"
Content-Disposition: inline
In-Reply-To: <20200211185936.245174-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--svjny34pbuqgftj2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 11, 2020 at 07:59:29PM +0100, Jernej Skrabec wrote:
> In current sun8i-de2 clock driver, rotation core related clocks and
> reset weren't considered properly. All SoC which have that core don't
> have those definitions. Even worse, the only SoC which have rotation
> core related definitions doesn't have that core at all.
>
> This series fixes this mess.

Applied all of them, thanks!
Maxime

--svjny34pbuqgftj2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXkQ9egAKCRDj7w1vZxhR
xRlkAP9fPgQUlJwexenVqLaVnutT9EYmHdW/yd43xbmwPlJpgAD/fyvsNedPpviW
OWmV/BPxV3fmlN3vlGhTn9TsLWNrjAc=
=PIcB
-----END PGP SIGNATURE-----

--svjny34pbuqgftj2--
