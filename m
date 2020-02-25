Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4BEC35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0EAE2176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 09:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="mNh/y5Q5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dfnhGt4v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgBYJEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 04:04:39 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:35025 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729153AbgBYJEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 04:04:39 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id EF26521EBC;
        Tue, 25 Feb 2020 04:04:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 25 Feb 2020 04:04:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=2uAmNfXp/nheDUf7m8Ia1NiqBIQ
        3V0NGUD9iv59hcp4=; b=mNh/y5Q5V+86oXAGiuYeZGyl+cz1NeKGf87d3IWOPuX
        1mcIvKqtuB54mFf+guwXj3Vzgd5tYu3z68DpW3+kvlW8AR0hM6J75bWzsRekEvzi
        honPhHYUQ4R1cODry3KIGz7ZT3eVBgY4I2apfXVs+dqqyFlJvuCsye6ETz8RQjRS
        ZYkqPzRFrBckAqYJ4Pzl3uNNE1rggJrbtVYn/KjDws9UadCnlRSfiq30VDZhHNM+
        UogALCSNTRN2cLQI/+RZ1r4lsfTomU9Fhbuni03Jg/4gnUQP1nUmAOOZenO2vzRP
        RpjyJ8H/zBVhZ/Ms2HbeWjGiccHM2dVJojOqZB/8bjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=2uAmNf
        Xp/nheDUf7m8Ia1NiqBIQ3V0NGUD9iv59hcp4=; b=dfnhGt4viOhr0msPYsbcQG
        xXsa8gS83w1IXfAHqqr30p+DTcfYz05K3XdnKwWkXEsg8w63OCoHa6ita2hSuEjp
        XRQLaxiOYciSnwcJLdUyqBOlPaZtepjuBUO9BXEZaZUZWOyPVEdZY7o7QGdA/qC5
        z+Pl9xhAV4vU8tnYIvcxvBjjZOGbx43bpGFh9+40qg0z0bbgDYOoJbZVTzstcnXU
        W6IFFOq6ONzwSZsi7VHJD7fZ0G/04Z3t29cnyAxj3rujrc2uZg9xHTI2BfU58vv8
        UUj7fTvVlOdcCU34lD15/gnFh927GboKnb9B9AUHBAwP8DSgpo0Hsagx3EIEOT2A
        ==
X-ME-Sender: <xms:JeNUXrs5YgpmXGtb0xXXAElj8Qk55Y-aAOiJRDgrrxKwpEUASQ5OKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledugdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecukfhppeeltd
    drkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:JeNUXvZ4yM6zyMkpw137PUbeSSFlcpLfIgQ78HK8f2cDck0hEjS9vg>
    <xmx:JeNUXiLsniPtUUmOpwjwEUfDddgf_R7tgkCa5c-ZVdEUAtfmulLsrA>
    <xmx:JeNUXhsDmPiSHHKx-N2khh8XQIFw3dEQR96EYtNT9Srqe8lBeR6uCg>
    <xmx:JeNUXvtgDT0RHboTZzj-O4yTQb28Xc-3HjQYNfFV54YyRc92pINBtQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 376A33060F09;
        Tue, 25 Feb 2020 04:04:37 -0500 (EST)
Date:   Tue, 25 Feb 2020 10:04:35 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ARM: dts: sun8i-h3: Add thermal trip points/cooling
 maps
Message-ID: <20200225090435.63licyt55thlievi@gilmour.lan>
References: <20200224165446.334712-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ef37cxbs77ojiiit"
Content-Disposition: inline
In-Reply-To: <20200224165446.334712-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ef37cxbs77ojiiit
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2020 at 05:54:46PM +0100, Ondrej Jirman wrote:
> This enables passive cooling by down-regulating CPU voltage
> and frequency.
>
> For trip points, I used a slightly lowered values from the BSP
> code. The critical temperature of 110=B0C from BSP code seemed
> like a lot, so I rounded it off to 100=B0C.
>
> The critical trip point value is 30=B0C above the maximum recommended
> ambient temperature (70=B0C) for the SoC from the datasheet, so there's
> some headroom even at such a high ambient temperature.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>

Applied, thanks

Maxime

--ef37cxbs77ojiiit
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHQEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlTjIwAKCRDj7w1vZxhR
xdrDAPiY7uUqle4oy7ZfhyvwkJMp0IoCHkzpKm/956C+OumXAQCLjcgwO1IKcKvQ
+/R56Jp7e0RC+a7+tovDO/hPn153Dg==
=vEfK
-----END PGP SIGNATURE-----

--ef37cxbs77ojiiit--
