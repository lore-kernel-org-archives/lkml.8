Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C87CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 800C8207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbgFOQ0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:26:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:56484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730788AbgFOQ0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:26:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 747E9ACFE;
        Mon, 15 Jun 2020 16:26:25 +0000 (UTC)
Message-ID: <810816166d8ef554e1bb1f4a2b39ea0b8a1a3d5b.camel@suse.de>
Subject: Re: [PATCH v4 3/3] ARM: dts: bcm2711: Add HDMI DVP
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        MaximeRipard <maxime@cerno.tech>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Date:   Mon, 15 Jun 2020 18:26:19 +0200
In-Reply-To: <e22222ca7f41b960e9bb1a31e0dd2de95b8c0cd1.1591867332.git-series.maxime@cerno.tech>
References: <cover.4c4625a8e076f3163b800b3d8986b282ee98d908.1591867332.git-series.maxime@cerno.tech>
         <e22222ca7f41b960e9bb1a31e0dd2de95b8c0cd1.1591867332.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-q9+H19jK4iCuSUzIgRNL"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q9+H19jK4iCuSUzIgRNL
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-06-11 at 11:23 +0200, Maxime Ripard wrote:
> Now that we have a driver for the DVP, let's add its DT node.
>=20
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

I can take this patch, but I guess the rest should go trough the clock tree=
.
Is it OK with you?

Regards,
Nicolas



--=-q9+H19jK4iCuSUzIgRNL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7noSsACgkQlfZmHno8
x/60KQf8DcikWxE71NrTvwrqPcZ8tTbET2o1LmElA8UjZC1GyON6J5rb7G9wZ3b7
ZacWpXr+y8DfgVVGKdCnUGjS2MNwA1GRvweSOldqrDnftVIjLoGkr7dDIVyPfIc2
EaqkX8o5xzWDNYrvzRjOllOr7hTKl9SiDvE6XTTpZakBUAweqQSLWyJI0Ns5dJJD
x3MBxn2NJvP7FJI6pKatBcLFnx68QLy5SXr3WbcXSM7Np2qW66vkM5oWu7PLHull
CBJEBiStVhGxWM9Ej/WGAl8SsWqEnZN/g8CBqMDWdMvMSFgcyAcxaz7PnaT8OrK7
DLuSwuP/IZe/pTsekRuENoXtSEcESg==
=0XwD
-----END PGP SIGNATURE-----

--=-q9+H19jK4iCuSUzIgRNL--

