Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E8DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D90BA2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="IBnGPESx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V+XPQPvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgHYNhd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:37:33 -0400
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:59527 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726691AbgHYNgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:36:12 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 81886CCF;
        Tue, 25 Aug 2020 09:36:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 25 Aug 2020 09:36:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=q9y79dK6Ff2hKKrhQAqB4OGme9b
        PP6PxZFR8NbOIXhs=; b=IBnGPESx8DV2FlgkkDmVWlyVLQWch5UcUe919HCTUc1
        z7vADAEJMRRW/aIxz8Kz4ZvLn62cW1eHtmGSVnGjkddNvcS2KYhuuvcSfznzwYas
        njeQupr261REnPTmjsCHnqtEtoYCygrcM0WhNE4+gbxjrwUUQ51I3TsgvKfLmQ5k
        7ZZKuVDO0RMNc5dk+dMv5tgnSsNyAS6FvmKrW8A7QMYrNfEWTkYDGnz5FO38dDHT
        uGXfNYef+GHnOA5ECEU5QVhQbI7msMUSZkNDjNu2kmfs9RHV7y8qFu5NhJX7oYWF
        amXc7brEmunTwkmp8efd5Z/oRBsawViOhFU8PORaMqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=q9y79d
        K6Ff2hKKrhQAqB4OGme9bPP6PxZFR8NbOIXhs=; b=V+XPQPvc7dYZWkHMOdV4RV
        G9OkiorcIBOarDu4t2kN+cDvFrkUPA9oFeG5dhbUEp1Lj0XzXrgd42IGH7XLrzlc
        /ZW3egDqnhiWOaFWfG4bOypjbuoBVxFlFuFJdI6mDFiM9YAovtu1QGtEszM4MU9r
        +JAQ+thei2frFQDXWT15/tVj60p1z46ZEfrWrz9YEPAWBWxtDg2JyNhDJ0EIA4KP
        OwRzY68NI3PtkH148V24qR/RGpwciM4vw1UiecDgnlnB2TKSLcpkMhl7mYM0zwiV
        rCcKlB2Mfo/3y0syU07MVog37pT095eVpcHRqb41jKnDDttWm/S+vleUm5+U7mEw
        ==
X-ME-Sender: <xms:yhNFXzAAEdom8j7DWRrpm4U6rGg_CbkAKis6O0q_I3sZM8yHUs2f5g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedruddvtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgepudekne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:yhNFX5hQnjMiVkLkHJRfsbcGpgNc9D6h5asF2Mh1sSWzdFucfEkCvQ>
    <xmx:yhNFX-k4UUpGLA99Kp2jGzvxJ2diAYk1IJB7P3DALysPl-4Vw3pTuw>
    <xmx:yhNFX1z9ZWe1JMe3j01re9mkGrGwsN8rKyTTsZKpLlnScmqbPFi8Nw>
    <xmx:yhNFXx8tpXfvzVTaPXW1snq0Gst01A0atJB8O20kqzcA-FPhMVhlX4JBJtw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id B599330600B2;
        Tue, 25 Aug 2020 09:36:09 -0400 (EDT)
Date:   Tue, 25 Aug 2020 10:49:41 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Frank Lee <frank@allwinnertech.com>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, maz@kernel.org,
        robh+dt@kernel.org, wens@csie.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        tiny.windzz@gmail.com, huangshuosheng@allwinnertech.com,
        liyong@allwinnertech.com, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 12/16] dt-bindings: irq: sun7i-nmi: Add binding for
 A100's NMI controller
Message-ID: <20200825084941.q7tubirmqrexl2pu@gilmour.lan>
References: <cover.1595572867.git.frank@allwinnertech.com>
 <953b76413563551b82dd11cadbc99c695f74f721.1595572867.git.frank@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uxlre6ekf3dh7rdl"
Content-Disposition: inline
In-Reply-To: <953b76413563551b82dd11cadbc99c695f74f721.1595572867.git.frank@allwinnertech.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uxlre6ekf3dh7rdl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2020 at 03:15:53PM +0800, Frank Lee wrote:
> From: Yangtao Li <frank@allwinnertech.com>
>=20
> Add a binding for A100's nmi controller.
>=20
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> Acked-by: Rob Herring <robh@kernel.org>

Applied, thanks!
Maxime

--uxlre6ekf3dh7rdl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX0TQpQAKCRDj7w1vZxhR
xe31AP9eTRsD4ZEt5iWvSwijSWRdCftNvfwd46iiX9W/eQ7tiAEA5lE0EfbRcyGi
nSOR8/sT1fUeYFjOGpOTdcKNnOj/VQY=
=OaaA
-----END PGP SIGNATURE-----

--uxlre6ekf3dh7rdl--
