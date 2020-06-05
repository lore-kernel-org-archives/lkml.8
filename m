Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3942DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FEF22075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbgFEKmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:42:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:58814 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgFEKms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:42:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7AD1FAB5C;
        Fri,  5 Jun 2020 10:42:49 +0000 (UTC)
Message-ID: <6ae138d4ed6633ec34e5199d0672dc54fec4db43.camel@suse.de>
Subject: Re: [PATCH v3 19/25] clk: bcm: rpi: Add DT provider for the clocks
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 05 Jun 2020 12:42:44 +0200
In-Reply-To: <58f0ca794ae24bb2026b3051d1f5cd0affab42ee.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
         <58f0ca794ae24bb2026b3051d1f5cd0affab42ee.1590594293.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pWlr8403LQFYMCkvS4sV"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pWlr8403LQFYMCkvS4sV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-05-27 at 17:45 +0200, Maxime Ripard wrote:
> For the upcoming registration of the clocks provided by the firmware, mak=
e
> sure it's exposed to the device tree providers.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: linux-clk@vger.kernel.org
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-pWlr8403LQFYMCkvS4sV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7aIaQACgkQlfZmHno8
x/7qIAf/QtFeVelhKGGX//nLMMPHMSUDAT+xooDh+izo7bG7E6VDA9Vbbbc/XYLY
m6mp5zgjei5fCM9oX3SzBPOe4YdOBQv2qDls3SGSITzILz7oj23yzxLYukyoRufX
HAS7r/v2oZS8BsWt5IPQV2OgDR2rbEjYwkIhlwxmkljZOEhfcKs7SqLSN5JQjMeF
cJ7wFDjP/u//gR3dW87iVE+Uq97YLnNr5jJEPUtPXLvnjLCbTbgaokFr7RfhOmQz
BTmqC1koG6IV44VA+gd5+Xlqg5WCDJv2wkYeIg/U+eimusvT6u8vlrCuZ0pKKtX6
UnuNPItXMELJO3DpN0f0c5S7J7Ut/w==
=Vwou
-----END PGP SIGNATURE-----

--=-pWlr8403LQFYMCkvS4sV--

