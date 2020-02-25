Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25070C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8FC2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730628AbgBYQ0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:26:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:55718 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbgBYQ0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:26:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6C079AD48;
        Tue, 25 Feb 2020 16:26:14 +0000 (UTC)
Message-ID: <0b93ed0c1332e9966616c8c2aaeac35503096f8f.camel@suse.de>
Subject: Re: [PATCH 17/89] clk: bcm: rpi: Pass the clocks data to the
 firmware function
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>, Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Date:   Tue, 25 Feb 2020 17:26:12 +0100
In-Reply-To: <5a02a46e899abfca7257a725678f1131490e6b11.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
         <5a02a46e899abfca7257a725678f1131490e6b11.1582533919.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-k7HUefi2lZk06DdeDb2b"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-k7HUefi2lZk06DdeDb2b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-24 at 10:06 +0100, Maxime Ripard wrote:
> The raspberry_clock_property only takes the clock ID as an argument, but
> now that we have a clock data structure it makes more sense to just pass
> that structure instead.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!
Nicolas


--=-k7HUefi2lZk06DdeDb2b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5VSqQACgkQlfZmHno8
x/5d1wgAqGqboihG+8tsmV0N9IYrcZjuNVb4fKhnZwB2UhnwGBfzoV3LQiRwimoy
w0VJB+ITS3nxs6gnUyb6c+wJmBalGd0odtCJd9IzkUsv+Zh6byikhlzDhPflCQ8S
Qhcj4sMHLfuFW51+zTMw9WYtGiXmgDu3zUore5LCMO0cTQumDmwg1dqEr5MoCgPA
N9rRKRtqTcs1JNlhxlT6XBv0zGTuwUOKkcab5dZ8P7TnZlcwNo6nvKpDHAy+ihC9
1uai4H/hT3A0rDOeiEHhkVFL2SbFZaouYyAGSeZ04LmO9/LSQV7AWPJ9Afn4qkJQ
mrf5zAjSWTH9A9xRPbUhLXrcGgeapA==
=00Mu
-----END PGP SIGNATURE-----

--=-k7HUefi2lZk06DdeDb2b--

