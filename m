Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF22DC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:32:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8253C20714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="WWOqYQDa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hh0uNwDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbgBXJck (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:32:40 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:56345 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbgBXJck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:32:40 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id BEA8D20B51;
        Mon, 24 Feb 2020 04:32:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 24 Feb 2020 04:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=SmI05YfllgEMaDGebG7yKu+Qbjz
        kPlrBEKDifZ9AT5U=; b=WWOqYQDaH8h49mUNSnqF4QsbjkvmJTMOFxqCjBvYI1S
        8g8kyo1JMmxO+r4aX2c/9CgtT3CTV0c4jAm6M3QiQQRAudfnfc8Ocyf7V3hCHDvb
        +tCrDU5pxSJsuoFw2uaPYFbb9Ax3z3Ap8swNSFyZCCP9fpj2ajygohh6pSfZ4OFK
        TqNE9mnTxjdR4dj+dRa1QA+6LfSimBblFVbuFjDlFrH+LaelgBmjSwX2bFMDjZEk
        sjXtesCZXUqbyvjriM2MMLyHi2eWB9+ogZeeaCqslwScj2elqrkPPd7b6lVzecEy
        8NMPoScYGkTo7qlVW3URVxDnFh4tk6xT56GRNcpJkVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=SmI05Y
        fllgEMaDGebG7yKu+QbjzkPlrBEKDifZ9AT5U=; b=Hh0uNwDyojH9X9eU0N1JxH
        bFgKcpkwxC3DrLOPoPQrQqYSWatF27WPH9BKDnC+S4gNbKjdmiGlRXIxwRcFhKpt
        fThBFLxmqkyk8C97NCGQ2oPQJO0iUkELNerQbv7SVjl0w8lJSwTvr1ahjVuIrq9A
        TB7p8Ye+pDi/wkexY8aH/mKyWYioKQkCoJtbKE8/mVySbVZY7859BXHww2Beh5v0
        M0//GD4TcPsE3J8PLszeb9OPWLFeGJX4ELCeJgEnaTZgNs50LN9mmUC9I1bvOTs5
        Y6BEPU+OlrrqQ4YnRMNa+YX6Ffeazr0LtZ/X3MWh1Mk958LltVtZpeI18O6Z4m3w
        ==
X-ME-Sender: <xms:NZhTXu3feOUHnxI6g5TRmQnFx5ov_Ol7tkPfmKoQSACpNTiqO-wzPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrledtgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucfkphepledtrd
    ekledrieekrdejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:NZhTXn_Bg6y2yQfRTOwOjxBwzLPrEnIw3S1NtDxpcWjbwzu8lk5-tQ>
    <xmx:NZhTXj3-lmGiZHCsCU-snpOGhVFNytNdzqIQHbZsOl3ab1IW_BJB5g>
    <xmx:NZhTXs8XxOlhrTQ4rkwBQydE2tczzM5MnXviVfQu4eqS8OHYxJuMIw>
    <xmx:NphTXhNLSY6qOWm83RgG_0rWEgmnx_kO13MJXHxq7dKmK0PiFWI8JQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 283DB3280060;
        Mon, 24 Feb 2020 04:32:37 -0500 (EST)
Date:   Mon, 24 Feb 2020 10:32:35 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Ondrej Jirman <megous@megous.com>
Cc:     linux-sunxi@googlegroups.com, Chen-Yu Tsai <wens@csie.org>,
        Tomas Novotny <tomas@novotny.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] Assortment of fixes for TBS A711 Tablet
Message-ID: <20200224093235.7hqazfxzadzqwlng@gilmour.lan>
References: <20200222223154.221632-1-megous@megous.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ugm5lafujjcs4zuh"
Content-Disposition: inline
In-Reply-To: <20200222223154.221632-1-megous@megous.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ugm5lafujjcs4zuh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 22, 2020 at 11:31:50PM +0100, Ondrej Jirman wrote:
> This series fixes some issues with camera overvolting, USB-OTG/charging,
> and WiFi OOB interrupt being stuck.
>
> Please take a look.

Applied 2,3 and 4

Maxime

--ugm5lafujjcs4zuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXlOYMwAKCRDj7w1vZxhR
xXS1AP0ZLJkOP74wrxp4yvAMDXitjkezQh6SiGvTEOgZkrMpbQEA4NTdiVYQUVPW
dGuZKk/63QYvyf81LF2BFCmuenIV2wk=
=C6+q
-----END PGP SIGNATURE-----

--ugm5lafujjcs4zuh--
