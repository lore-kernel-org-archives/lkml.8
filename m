Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D36C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 539CB20663
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="cxLxSk93";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Thb2uVjh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgGAGvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:51:14 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:44489 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727817AbgGAGvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:51:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DC494AA7;
        Wed,  1 Jul 2020 02:51:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 01 Jul 2020 02:51:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=DMlwC4LDZdJp/AElsdSkN7QDFdA
        xaBzbT1BNfb3j+c0=; b=cxLxSk93t8J6dOd9wq+KFmXn34ZCBDSQqIKdR4Wb0yL
        AIKvHg2d9TLY1njfPXqdbyId8+oRdwWGKfYlvRU8Dw0zdDSBSFlEPRbpDAzvG+qk
        VcW+WwrBnCEfKDRG6Ne8GyvqEoUgV2SLIcNRN4xz5BgXqiDd4BxzbBZ1JMwIyRIJ
        DvjUrIW0pkXRlsMoU48b8x+gdMhxa74miehgDWW6He23mwJpdgtpSGcg+Wf97Jic
        I+4I2ifemhF/DdTiNw1mPrfqjlldNa2MpRBkhUS2ogAF16GbE5P5RKoMm0wTEB2P
        TMJa70yPIhhtd6WhKr7ImA8hISsQ9f8AK9WicAd24hw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=DMlwC4
        LDZdJp/AElsdSkN7QDFdAxaBzbT1BNfb3j+c0=; b=Thb2uVjhGDFYSOBdjBXJiP
        3u+y5J53+9pRuUxU/eNw+cZVANLrLEyXbpP1gi8c61D+J6U0U6742MUlUwl1a8Yz
        pi7i0OcwrDbjDuwyOrCRKOebG335obRy12b6DmZV0EDDpUAdYET1ml9y+23EAPLQ
        tHMmAA+1gIum1iRzIyuibLTJnpIbi4n+Dle/2ozZkrIKTRntq5DIIqMjkeuHcByr
        ZNH4kYqvUREJjZsm9Ddpbo556E6pwddXGBg1YcztLNbA5TCgVYlmzOLaPJ1K7ukW
        eTQI1ec7dQ/KUIEPFJn3mcRSnjHVR6LDrzNlCsQBOvm4SJCq6FhYcPrBCulynbQQ
        ==
X-ME-Sender: <xms:XDL8Xmq0aaZWCwKkaWJfKNzsiK-nqXWWAxS5A5o1psW4xi9xgacQow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrtddugdduudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:XDL8Xkopx1jOmA49yAwBC3rc-9VW7Yr8xqo03MtoZug9NgM462_4Og>
    <xmx:XDL8XrNofe-BCmqXUMGf01Hm3tgRMX_R-sUyFNUNQtzsRF5e7jEY2g>
    <xmx:XDL8Xl7SXahVf5qVwJPf1hroEw3NXNxK709Aw9haqlEyaFyCXqdOEA>
    <xmx:XzL8XlGFyaNxBpbCImJWUPj1CEyjT3kkOA4udqttLvAMOhQaU1a0ag>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1ABE7328005A;
        Wed,  1 Jul 2020 02:51:08 -0400 (EDT)
Date:   Wed, 1 Jul 2020 08:51:05 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2] dt-bindings: display: Convert connectors to DT schema
Message-ID: <20200701065105.skz3ln54h3qo4div@gilmour.lan>
References: <20200630200216.1172566-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="g3kj2uw52dmun5h6"
Content-Disposition: inline
In-Reply-To: <20200630200216.1172566-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--g3kj2uw52dmun5h6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 02:02:16PM -0600, Rob Herring wrote:
> Convert the analog TV, DVI, HDMI, and VGA connector bindings to DT schema
> format.
>=20
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime

--g3kj2uw52dmun5h6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXvwyWQAKCRDj7w1vZxhR
xasDAP9r4tg1fgeE0OZMBPlT1tZ6mI4krecIcchC8sEDC0LnWwD/d6jfFt9QEnRZ
Ekag5CaO0kUl1bT5fgnQxuhWYFlaRg0=
=2psa
-----END PGP SIGNATURE-----

--g3kj2uw52dmun5h6--
