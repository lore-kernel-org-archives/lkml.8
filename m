Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02FBC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDDDF2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:38:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbgFEKiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:38:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:56358 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgFEKiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:38:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 803E3ABBE;
        Fri,  5 Jun 2020 10:38:07 +0000 (UTC)
Message-ID: <c9ae665f45d8669e6834e7f6a006698496542d68.camel@suse.de>
Subject: Re: [PATCH v3 18/25] clk: bcm: rpi: Make the PLLB registration
 function return a clk_hw
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
Date:   Fri, 05 Jun 2020 12:38:00 +0200
In-Reply-To: <be60ef4f29c929e633363a4473aa119f69ace7a0.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
         <be60ef4f29c929e633363a4473aa119f69ace7a0.1590594293.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-GKBfxlAyyMcO4y1FBBUP"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GKBfxlAyyMcO4y1FBBUP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-05-27 at 17:45 +0200, Maxime Ripard wrote:
> The raspberrypi_register_pllb has been returning an integer so far to
> notify whether the functions has exited successfully or not.
>=20
> However, the OF provider functions in the clock framework require access =
to
> the clk_hw structure so that we can expose those clocks to device tree
> consumers.
>=20
> Since we'll want that for the future clocks, let's return a clk_hw pointe=
r
> instead of the return code.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: linux-clk@vger.kernel.org
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-GKBfxlAyyMcO4y1FBBUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7aIIgACgkQlfZmHno8
x/49AQf+NEJCsV2JOsSPe7EgOc95gd6JyUWOEua0ulSmnIKXlzz0Slu/WTt5dq3K
y1rmylaZUECzHLB/iMw0VxIovd0VAMRwef24x7c5Xu6SWAIjr7XSihennsgwU9kp
KOqPvC2IejaU/bW0aMBYb7jWr21cRqtSU4FMwUK73mtdg4kjHmE+o2sXGTDMSdLF
kTUZJAJCMAAQl36As1gk6xpiQnvAqkphJIfULpQGjsn2WxDa6tmHER1Pu1SjLQ/x
5O12dePkhZhg+MlTWq8/v+o1KXIGOd5L7MfkgulGqKZbPV1lXrVkBMiyDEByh0K1
WYSdPQF9hRXjmAsFwkCo/8LVUKgm7w==
=zDZM
-----END PGP SIGNATURE-----

--=-GKBfxlAyyMcO4y1FBBUP--

