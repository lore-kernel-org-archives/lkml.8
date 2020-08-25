Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67235C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415802071E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="I7qgSfhP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gxCb/zTL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgHYNgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:36:36 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:55561 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725468AbgHYNf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:35:58 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 12DFCC18;
        Tue, 25 Aug 2020 09:35:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:35:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=oG9g42t4c+YiGB3NS+r0GEHvP3C
        e/x2yFnpF8fYIC84=; b=I7qgSfhP9YSyUkRWE4lzt6RS97OSMjFIuRNU0fd9OeZ
        iZ/o0UHhTwaOHyLh3Gh+/HEXe3YPu+JZeBuu9/vOHnp7uU6QyIJx5JGX8mkeAI+s
        wdIC8htWA/QOmHNa8DfTAqjoebZ1WPcubL/vTsa3D+3Lo9Lg9KZGbhqUx0jL43rL
        njtr0vWmhy8TB6M6GFKzOw6HWYgZZiqS3ffut2Ff2ACGDIKJGpRCGGeVn5tLGMHf
        0dQ+GEbZGndRku6SZdFjxnGhk7EW4Lyfy+MpcPN+ywnJDdAwmbkgm1ruPSk9ZgsD
        RL5Zxc1RO9xH/c/tG4xflxvOV9axKo42S00IJgwvRxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=oG9g42
        t4c+YiGB3NS+r0GEHvP3Ce/x2yFnpF8fYIC84=; b=gxCb/zTLx0aAeFh+cg/P0K
        9s5LNcftkpsk0RrzAKqHu8DylQTnpXRk6ZSTEos7GCcigJQ6ZYYxQ72IVN5z2TiR
        RF6dJA3dDwAoY7agFlCfOshjun/oEaGCrALs12p4/3OgWNI4ARvnnHGOoNpJGq+w
        C2Vkj5ZvAkqYTWRE0Z/eeaVNvVeFkbLVjM4AWhZ2cwJGAe0wbKgFkJkyILufGCks
        NkHNQxjOrNrDSjQcT+hXDrWVXXYQ+C2IKCzxMzOM4f7yzOIMoZ79C4UMVImiZtk+
        xj/0IZfFWVP9MHVPtswhkiRyWz6HJy5P0dnwhFJXeudod12izvCXYphFK/AHILCg
        ==
X-ME-Sender: <xms:uhNFX0F6ihM3z2gecCOi6y6IqmRxvpdT2fbma08PAdawnhTd38MccQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepjeenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:uhNFX9WPrhUhInSQ8edGm1LlH9_ScmSNvyXl4qPI_Kox7fLNkGgg2A>
    <xmx:uhNFX-LzSFaKFkmoUsxx9hGEbha6ZKBHm_LGpvzFfGtm2_SfwTvhzA>
    <xmx:uhNFX2FPaF2axPZk9cTKeEOikP-IrN8_dbzjwPWrYNXAp4HUyrKjJA>
    <xmx:uhNFX4y9kGsjaVxLBRhlI4G-9s8VyL0cfhRUw5JTdfJ1WJe3KLKQiw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F2AC3280059;
        Tue, 25 Aug 2020 09:35:53 -0400 (EDT)
Date:   Tue, 25 Aug 2020 10:38:02 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     wens@csie.org, robh+dt@kernel.org, icenowy@aosc.io,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH] ARM: dts: sun8i: r40: bananapi-m2-ultra: Fix dcdc1
 regulator
Message-ID: <20200825083802.cvbnsdqg7yp7rcu2@gilmour.lan>
References: <20200824193649.978197-1-jernej.skrabec@siol.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dngkqn3e4bkmqagi"
Content-Disposition: inline
In-Reply-To: <20200824193649.978197-1-jernej.skrabec@siol.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dngkqn3e4bkmqagi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2020 at 09:36:49PM +0200, Jernej Skrabec wrote:
> DCDC1 regulator powers many different subsystems. While some of them can
> work at 3.0 V, some of them can not. For example, VCC-HDMI can only work
> between 3.24 V and 3.36 V. According to OS images provided by the board
> manufacturer this regulator should be set to 3.3 V.
>=20
> Set DCDC1 and DCDC1SW to 3.3 V in order to fix this.
>=20
> Fixes: da7ac948fa93 ("ARM: dts: sun8i: Add board dts file for Banana Pi M2
> 		      Ultra")
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Applied, thanks

Maxime

--dngkqn3e4bkmqagi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0TN6QAKCRDj7w1vZxhR
xd5kAP9I7pPi4g79u4rqf7w3IPhQiis0EpQAO3x9V9FqnYSIaQD/XBQiV8WTPVJM
79nNvBj2yerWGBEwGe+NfCkeYubn+A4=
=/Iyd
-----END PGP SIGNATURE-----

--dngkqn3e4bkmqagi--
