Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61146C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F88520FC3
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 11:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="Bi02m5qx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="asY7KNSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732213AbgFSLxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 07:53:12 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:51165 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730957AbgFSLxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:53:09 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 19396646;
        Fri, 19 Jun 2020 07:53:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 19 Jun 2020 07:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=sfZjp4sTM7Emq7BJU/T6vVdzlnq
        Wh7zLSYAr0LXmurU=; b=Bi02m5qxN12oOMeaCIVRKncESB+L6KQJ6/NkF89pjHa
        mCeF40JplX5dXjeju9oRLJr3Pe7SICJGBB62jncNQq22XjG9cleoMtOaqC8ARa2e
        /XiCObvXQluyrR8YpwAwNasKpJc4o9i/DyYfCtvoAqdsWfm948cPWtujw7JWyVgx
        IabW3PLrBoMax/zyZW80zm4lzi+Ff3nL/CSNeAU9kHNwAgn8mI/vv6LTXB8X67Ds
        F5CrVECVgG1Lrfr/aysfBzS7Kh9ls2H2/5lbBjIxIze+mnvLV0KCRMIkAVt02wLE
        +SYQZwfUTDmBMAme/C1gyG9bvGjggu6O/4Mia78ZxAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=sfZjp4
        sTM7Emq7BJU/T6vVdzlnqWh7zLSYAr0LXmurU=; b=asY7KNSAY43aIaaGnCWA5y
        EnjF17HAsaDdkcgKxX0NQQZEV+euzBpszSdepZ3CEA1g6tRjEJkDnyqt3esnYQ0q
        8+u9f3Zer6Kxqnuk3pb8ntTDLLnsod/8CpYZTrrjImAvDgNBj+lKTlKi8F/k+Xlo
        ymnd5P75eM3QPOFu0UIZoJaKao4z8GKAEx9v6FC+yq+dblElxQAsr6EK40Kh0jv/
        Nu18tbP8WT2cq6MnvURI4x0nilISzz5oaZyWru7hTAXu8cmZQZ69Ik/RFhyiUzJj
        3W5qYla6EpfhmdngxWc3fVp4XmZPO9J+vMAQlhi3ukKBU5EHZhkGJVEDKCe5GCIA
        ==
X-ME-Sender: <xms:GafsXuQL47X7GVOoFtSjMPe2wqlYpcwCNLMV7H3-3EUKpfNCQgejjw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudejiedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:GafsXjwEgWS4OeXYVnHVblrtYkZU7a2cwFfyIsVNgZ2PelPF5v6XXA>
    <xmx:GafsXr0NbZs2qvaGGxqC1oHFnMg_0BMX_4LPMqPtIBlzAVFHitAnlg>
    <xmx:GafsXqAT5vx_GVXX0GZBe3MF1U5qxxjkOVn_YtvjL6iQHcDTC5hQpw>
    <xmx:IqfsXqoT0jbODuadnCRXsDleS90AgOvDfg5Om2Nx9hyBvVkg_8A6TU7S39k>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5A4273280059;
        Fri, 19 Jun 2020 07:52:57 -0400 (EDT)
Date:   Fri, 19 Jun 2020 13:52:55 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Philipp Zabel <p.zabel@pengutronix.de>,
        devicetree@vger.kernel.org, Kamal Dasu <kdasu.kdev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v5 00/27] clk: bcm: rpi: Add support for BCM2711 firmware
 clocks
Message-ID: <20200619115255.6pk5xb42b5ol7bk4@gilmour.lan>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
 <159255945796.62212.5838238989498858379@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ntaccarc64fykhfj"
Content-Disposition: inline
In-Reply-To: <159255945796.62212.5838238989498858379@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ntaccarc64fykhfj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

On Fri, Jun 19, 2020 at 02:37:37AM -0700, Stephen Boyd wrote:
> Quoting Maxime Ripard (2020-06-15 01:40:40)
> > Hi,
> >=20
> > Since the whole DRM/HDMI support began to grow fairly big, I've chosen
> > to split away the two discussions between the firmware clocks and the
> > HDMI support.
> >=20
> > Let me know what you think,
> > Maxime
>=20
> Do you want this to go through clk tree? Or looking for acks/review
> tags?

As far as I understood, you usually apply the bcm patches to the clk
tree directly, so if you could apply them it would be awesome :)

Maxime

--ntaccarc64fykhfj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXuynFwAKCRDj7w1vZxhR
xZ4xAP0Sfca4/e1tGZp6/nnT1IhBlYcuye8OrXKHYG26/k3e2AEAvsKlVXn7bMKS
brBCogY8lfWcyNhM+OeajUP3NA4hqQI=
=ZUsj
-----END PGP SIGNATURE-----

--ntaccarc64fykhfj--
