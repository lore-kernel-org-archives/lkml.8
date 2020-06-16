Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE03C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E997B20734
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:36:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="M014hv6S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UjEXWmFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgFPKga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:36:30 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:33087 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726452AbgFPKgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:36:22 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 70AD01B1;
        Tue, 16 Jun 2020 06:36:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 16 Jun 2020 06:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=UIpR3OcQr1VhZFmrKqImDBYkcR+
        LfAGA7lozqCBKyyA=; b=M014hv6SCnQirV1ZC8PNY5Kp0nQz3egQcugRwDGARI3
        tQbzQx6BDORKt9xhVLsZxg//g95V/7NNtMJ9z0cmaGe2lvwocwKGoMhzhzJIRHB6
        hWMzH7PRbn2vE09LNeEoDvoIuozYfea9ORw9VmvKl/bl+rSVQq3Y6m4azUkkC6iL
        YCy7UANyoWI7EfDCqB8p/irvXTdQcp+mVNz+1CuSlHSqoMuo6W4ThyNdEjOV+U31
        QpO4BqFM50PLVH4h/xHd9iSHPVhcr96VCdsUDQQagNcP7rvhhhXMPEhrDBKoc21Z
        GwLn9fuHWqKbMyu4kp099flFiITKyAQvy/V16pr1wzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=UIpR3O
        cQr1VhZFmrKqImDBYkcR+LfAGA7lozqCBKyyA=; b=UjEXWmFKQYWW0Na1SChIsO
        kqDAlSvy/xGG1k1Sec3PMV3eFFp2Sinj4HvxNztrvrMD+nP5AixNfQ3NW0TetyTM
        ZrXwPFsmXc9cYo6D1hhy0YF5pjkGK9uhnu40AsV+G0Ijs+nYLRIIAzsIT/mns0qh
        hSKuKAdXFZXbKo0yTq04TsrPAZKj7wPFB+lse6Qqot9OSaYCFRHEnrxTzdR7vgOw
        yS+htzMnApCZDIWxTXN8w0oLp+w/PQicLH8z/7VEkm85sePUp99VfQLLwHqg7ogx
        i2sGMgUwE8H6b1Zyw92tNOh3HYaJvkCbo49aX1k7AUoB/KYo4TuHPGIxAqS9zmHw
        ==
X-ME-Sender: <xms:o6DoXsJx_W1GrhUkaq8WeZvyqWeGKpYxKARNDDYkr4yDyCBHV0uHvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejtddgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:o6DoXsLX6-uqGc3jLAe-QjHy2kP4Zo73GhgiR1hlmZ4nLDZD5ULzdg>
    <xmx:o6DoXsuBe3Ga5Ycy4ewuHLPa42iZZeXqh5PPJuOct9P8LR2zEqGtrQ>
    <xmx:o6DoXpYROj4DMqVZQzzd2YEMYEjTbJkILW_mAF9n2hzsn7unbnXboA>
    <xmx:pKDoXvF3RmDVfnWBd2n7ALDCPRHj4fByVW0SZiHzOlDktV_0bAQHjg>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 29A62328005A;
        Tue, 16 Jun 2020 06:36:19 -0400 (EDT)
Date:   Tue, 16 Jun 2020 12:36:17 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Diego Rondini <diego.rondini@kynetics.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH v2 2/2] ARM: dts: orange-pi-zero-plus2: add leds
 configuration
Message-ID: <20200616103617.ddzfbz7yvnpl3ss4@gilmour.lan>
References: <20200615130223.34464-1-diego.rondini@kynetics.com>
 <20200615130223.34464-2-diego.rondini@kynetics.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="augg5iz66jyevl6m"
Content-Disposition: inline
In-Reply-To: <20200615130223.34464-2-diego.rondini@kynetics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--augg5iz66jyevl6m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 15, 2020 at 03:02:25PM +0200, Diego Rondini wrote:
> Add pwr and status leds configuration and turn on pwr led by default for =
Orange
> Pi Zero Plus 2 (both H3 and H5 variants).
>=20
> Signed-off-by: Diego Rondini <diego.rondini@kynetics.com>

Applied both ,thanks!
Maxime

--augg5iz66jyevl6m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXuigoQAKCRDj7w1vZxhR
xRzjAP0UVUc51P9p6mICdulyK7gjndsyarVDsU3W1zc2VrdYpQEAq4hcUnP+jHVV
ynDLt5rRNVkGy1G8ZdpLLrdsTc4KPQ0=
=ZfHR
-----END PGP SIGNATURE-----

--augg5iz66jyevl6m--
