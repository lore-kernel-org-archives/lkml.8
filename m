Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F835C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12E6020CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730634AbgBYQYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:24:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:54360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729817AbgBYQYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:24:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CB7D8AD48;
        Tue, 25 Feb 2020 16:24:06 +0000 (UTC)
Message-ID: <b411e2a675dd1b2e688815fa3eb0bd3c7c86946d.camel@suse.de>
Subject: Re: [PATCH 15/89] clk: bcm: rpi: Create a data structure for the
 clocks
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
Date:   Tue, 25 Feb 2020 17:24:02 +0100
In-Reply-To: <adc5810f9ed6400940f36be6e0a3a7255c557687.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
         <adc5810f9ed6400940f36be6e0a3a7255c557687.1582533919.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-NxrkRqtfUvDY/OjkZYGj"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-NxrkRqtfUvDY/OjkZYGj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-24 at 10:06 +0100, Maxime Ripard wrote:
> So far the driver has really only been providing a single clock, and stor=
ed
> both the data associated to that clock in particular with the data
> associated to the "controller".
>=20
> Since we will change that in the future, let's decouple the clock data fr=
om
> the provider data.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!
Nicolas


--=-NxrkRqtfUvDY/OjkZYGj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5VSiIACgkQlfZmHno8
x/67cQf9ElW7VnzLZaFV3c8EcEp/LDyKUov3/WaAU+cOAeaQeXhBsw6PuOhDYoe4
WBbwNikei9qvSn48Vq/kH00pkXvoHQsVY2BY4O7ImbuHTEyYkeIguWeAtVHLFv0m
sP35lY0G/MeI1MZkPO8NCCNXoQPvLqyVU65gnjAAsnEvpfKe2PCzbjmGp+E85Yov
oRxeevriB34mlrTDEIDQ2cxPvku3YO2yHyPqbq+1CLHjqJV4nK1JJq/b7vcTKbue
OkhCsNJb+ddOD4J7MMJGTdiZJrfO2tPe7PyFAEuaAK7ytHLy/G0S1kvBWW/e2+XV
jOLl9CnX6QQBZoLloLB+OplaQFqj5A==
=73tJ
-----END PGP SIGNATURE-----

--=-NxrkRqtfUvDY/OjkZYGj--

