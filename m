Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8927FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B362063A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgFKLRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:17:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:60460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgFKLRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:17:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5D151AC20;
        Thu, 11 Jun 2020 11:17:50 +0000 (UTC)
Message-ID: <ce0901dd4b9046b67ada36b0a18c36c8def811d9.camel@suse.de>
Subject: Re: [PATCH v4 26/27] clk: bcm2835: Don't cache the PLLB rate
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Date:   Thu, 11 Jun 2020 13:17:45 +0200
In-Reply-To: <264ad21afaae4a7098c3da59970d6cb9da1a8b0e.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
         <264ad21afaae4a7098c3da59970d6cb9da1a8b0e.1591860665.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-X1xORuuAQB8Hb0to6LkD"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-X1xORuuAQB8Hb0to6LkD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-06-11 at 09:32 +0200, Maxime Ripard wrote:
> The PLLB rate will be changed through the firmware clocks drivers and wil=
l
> change behind this drivers' back, so we don't want to cache the rate.
>=20
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Thanks!

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-X1xORuuAQB8Hb0to6LkD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7iEtkACgkQlfZmHno8
x/4H7gf9H/VIGYTrqw7T7k4J9ZsElmbeuIbyHgbrPS8t8lDUMX6tzdqrGwqQX5wX
SjR19NEMVS/B7NPHZ2D87lRCpoS2+PP4reZjEEBS1aeaQxEEgZ3mEslvJIWaPYo3
S9136B45/0RvqkOM3ymgy2XohcTmuu8qt1X3ToaEtmyzVTz05mf/EWBNS19Y+5cA
TvXy48mDNNY+j5tEQgFljALEapV4DJ3PmVyxCKiJ9et8j4W5fenTA1cFHjqJGu36
XvvfB5j8cQiIw4skAwvv3WVaBmh7wm211bT8HrgNI0Zw1KFvDQTrwIBgiOukY4V6
3mBGM6Qc7py38NVB3B/B1VpEz+onzQ==
=SDXg
-----END PGP SIGNATURE-----

--=-X1xORuuAQB8Hb0to6LkD--

