Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5B9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DF552081A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390629AbgFYIRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:17:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:34470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390456AbgFYIRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:17:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 85FBAAFCD;
        Thu, 25 Jun 2020 08:16:59 +0000 (UTC)
Message-ID: <03c2305fe0b5bcd26c1fe440ffe643f004ebbeb5.camel@suse.de>
Subject: Re: [PATCH v5 24/27] ARM: dts: bcm2711: Add firmware clocks node
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Date:   Thu, 25 Jun 2020 10:16:56 +0200
In-Reply-To: <9a6f113140b3115150bfb18ecb248a48d58562cf.1592210452.git-series.maxime@cerno.tech>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
         <9a6f113140b3115150bfb18ecb248a48d58562cf.1592210452.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-mvJWUCSI4MCqcu6RhwOq"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-mvJWUCSI4MCqcu6RhwOq
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-06-15 at 10:41 +0200, Maxime Ripard wrote:
> Now that we have a clock driver for the clocks exposed by the firmware,
> let's add the device tree nodes for it.
>=20
> Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied for-next.

Thanks!
Nicolas


--=-mvJWUCSI4MCqcu6RhwOq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl70XXgACgkQlfZmHno8
x/6Jjgf/RK/YBWcjRzmSnDYBO9CCoUVP8G3nVCvNSouvorVXK5Drrhkc8hKFV41V
gEWpSzj06QNGUAXDFqDf6gr2d2VKa1pUyF0APE7PgwAm+xCjTrrmmmgg6DZDtVZi
/2JIbiX6DSfl/Fm7e89h+w4PWRzRJSPi6RGKx+49YGiXyKYXWy/SjJqvlymvpdFV
rneJSeEKfJfjAAy9nnpIW6hT/D9xeVjatMHGjFu3JAN/XY8q7begmXd3nGVlkT9f
WdBakVBml6S0HpKEPDFWAtkzjetPJ1rmMT2g+QZozxFuor5cqvYWNXUCB69yKE4x
PqtIRAhv3H1/A+DLSIw3u1+PEZtIQw==
=dXqf
-----END PGP SIGNATURE-----

--=-mvJWUCSI4MCqcu6RhwOq--

