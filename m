Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80D09C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 16:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBE42081A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 16:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="uhsW5CKm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZvoSsfXj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbgE3QXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 12:23:49 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:50245 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728797AbgE3QXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 12:23:48 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 513F799C;
        Sat, 30 May 2020 12:23:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Sat, 30 May 2020 12:23:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=tRLW7jASUA/7qXtyJTN53ouwzXK
        3073xV/nniK6Mf4A=; b=uhsW5CKmUl1aJaOAfdh+QYD9tqgFP39Ex0uTI+pP8fR
        8oUyDYfz6fFaEndkj5cyalHj9BV/cW63qo9BSZGBF2n7LI+zhUJSA58nokZSB72f
        LBsBPsb7T30/Pkgvv/5H3voPyI+i7n007k/+LxsgY/t3rG1aJj9wc+1PWv8bE6f2
        hssG0/UL09QSfPD1VGJUbJQm/82cjVsIRP+0VNI5C88SecQpxqTG6ZOhgPFP9c5h
        RB7ebZCIrTGUJ3spfwkDUeX6RgMtUfAKIyMWHRqXOidckqru2XlFOxKBtY4s39Sz
        izeaTah0ofp0+QmZBER7YOfyjcANV63CaeAdfMcIqww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=tRLW7j
        ASUA/7qXtyJTN53ouwzXK3073xV/nniK6Mf4A=; b=ZvoSsfXjppjshWsm6G2JiB
        R7d+mxzHmGnuooTiDjePiCBlVp8ZqAB7oF5HhvnRkkw71UYsgaVjAD/cvUABL1Iy
        4Gh8u4eRqAjSG/taQnXFNzEY3jRuDPDiHYgmD++v6Ip4SpymMq4+QS2GnE1ZpBoi
        df2p0DPBuvDTI3vlewryv5UrJFA5aaaC2BWkf6dMnbD7XV4+KauePcKl2s/E+ObY
        EJo7CLnLtgFg3gHpAUWK5T7QVPFcnXZZ1pA+5mD1uLk+xZ1RHV/JVZrLZ1Tj8t8S
        OnDX8wuT5xwbUirMyow7qWZ69Z7IDziBKWWYgsI0pLW8WJPqUw1UMNtELq7xsdDQ
        ==
X-ME-Sender: <xms:kIjSXmQf8AIxBTw2y82qdT_16CqT5XwJZFhwvOI8xJdc5lSVenEu3g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudeftddgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:kIjSXrxRl-x5yT4N4YFfGJPVvFJ4UIKXkF7xWdf4vCWmASGHUTQXNg>
    <xmx:kIjSXj0NjQin7VXxUgn4mY2SJ_ckR0Vl--lS1mkZxMrJxHweEw23qw>
    <xmx:kIjSXiDdEr1iNkm0p0VzK5fZVpGjPzu0HhtjPfggQJe5rYzw9VTBzg>
    <xmx:kYjSXuOFGXeF5r1AzCUppMP4sZLILnoXoQkFnoVQr4wjeEh_2qANGoDwdOI>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 875933280059;
        Sat, 30 May 2020 12:23:44 -0400 (EDT)
Date:   Sat, 30 May 2020 18:23:43 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 02/25] dt-bindings: clock: Add a binding for the RPi
 Firmware clocks
Message-ID: <20200530162343.6a26bfojrmnkimh3@gilmour>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
 <919e2f2f13583d4d53d0e95b81fc3fb8a7606107.1590594293.git-series.maxime@cerno.tech>
 <159078703613.69627.13627047580756230984@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="q6u7kxg7uz4ypprh"
Content-Disposition: inline
In-Reply-To: <159078703613.69627.13627047580756230984@swboyd.mtv.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--q6u7kxg7uz4ypprh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

Thanks for your review :)

On Fri, May 29, 2020 at 02:17:16PM -0700, Stephen Boyd wrote:
> > +      "#clock-cells":
> > +        const: 1
> > +        description: >
>=20
> Just curious if this is the same as the | syntax? I haven't seen this
> used before.

It differs on how it keeps the formatting of text below. | will keep the
formatting as is, > will leave the formatting to whatever is going to use i=
t.

Maxime

--q6u7kxg7uz4ypprh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXtKIjwAKCRDj7w1vZxhR
xWouAQCgq7KmeDnD6Gdb9kx0K/yZKnUJF1mt0Y62LZ9jZNWYbAEApzWnR7SP6Tg6
efcwInK571yukcmFjFrQ8InCGpkMigk=
=w9yk
-----END PGP SIGNATURE-----

--q6u7kxg7uz4ypprh--
