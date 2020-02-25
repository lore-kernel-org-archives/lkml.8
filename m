Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3221EC35E0B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EB302072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730950AbgBYQBC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:01:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:41860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730422AbgBYQBB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:01:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2B30FADBE;
        Tue, 25 Feb 2020 16:00:58 +0000 (UTC)
Message-ID: <71cd7b35af81ee91c3b4dc5e7c05760ecd590c5d.camel@suse.de>
Subject: Re: [PATCH 07/89] clk: bcm: rpi: Allow the driver to be probed by DT
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
Date:   Tue, 25 Feb 2020 17:00:56 +0100
In-Reply-To: <c358081207dcf4f320a6b7e2932f0d5365bf3242.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
         <c358081207dcf4f320a6b7e2932f0d5365bf3242.1582533919.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-rHY9rlJOyK3Y6KPoBaSb"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-rHY9rlJOyK3Y6KPoBaSb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Mon, 2020-02-24 at 10:06 +0100, Maxime Ripard wrote:
> The current firmware clock driver for the RaspberryPi can only be probed =
by
> manually registering an associated platform_device.
>=20
> While this works fine for cpufreq where the device gets attached a clkdev
> lookup, it would be tedious to maintain a table of all the devices using
> one of the clocks exposed by the firmware.
>=20
> Since the DT on the other hand is the perfect place to store those
> associations, make the firmware clocks driver probe-able through the devi=
ce
> tree so that we can represent it as a node.

I'm not convinced this is the right approach, and if we decide to go this w=
ay,
there are more changes to take into account.

For one, if we create a dt node for this driver, we'd have to delete the
platform device creation in firmware/raspberrypi.c and then we'd be even ab=
le
to bypass raspberrypi-cpufreq altogether by creating opp tables in dt. But
there are reasons we didn't go that way at the time.

We've made an effort to avoid using dt for firmware interfaces whenever
possible as, on one hand, it's arguable they don't fit device-tree's hardwa=
re
description paradigm and, on the other, the lack of flexibility they impose
once the binding is defined. VC4's firmware interfaces are not set in stone=
,
nor standardized like SCMI, so the more flexible we are to future changes t=
he
better.

Another thing I'm not all that happy about it's how dynamic clock registeri=
ng
is handled in patch #22 (but I'll keep it here as relevant to the discussio=
n):

- Some of those fw managed clocks you're creating have their mmio counterpa=
rt
  being registered by clk-bcm238. IMO either register one or the other, giv=
ing
  precedence to the mmio counterpart. Note that for pllb, we deleted the
  relevant code from clk-bcm2385.

- The same way we were able to map the fw CPU clock into the clk tree
  (pllb/pllb_arm) there are no reasons we shouldn't be able to do the same =
for
  the VPU clocks. It's way nicer and less opaque to users (this being a
  learning platform adds to the argument).

- On top of that, having a special case for the CPU clock registration is
  nasty. Lets settle for one solution and make everyone follow it.

- I don't see what's so bad about creating clock lookups. IIUC there are on=
ly
  two clocks that need this special handling CPU & HDMI, It's manageable. Y=
ou
  don't even have to mess with the consumer driver, if there was ever to be=
 a
  dt provided mmio option to this clock.

>  drivers/clk/bcm/clk-raspberrypi.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-
> raspberrypi.c
> index 1654fd0eedc9..94870234824c 100644
> --- a/drivers/clk/bcm/clk-raspberrypi.c
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -255,15 +255,13 @@ static int raspberrypi_clk_probe(struct platform_de=
vice
> *pdev)
>  	struct raspberrypi_clk *rpi;
>  	int ret;
> =20
> -	firmware_node =3D of_find_compatible_node(NULL, NULL,
> -					"raspberrypi,bcm2835-firmware");
> +	firmware_node =3D of_parse_phandle(dev->of_node, "raspberrypi,firmware"=
,
> 0);

There is no such phandle in the upstream device tree. Maybe this was aimed =
at
the downstream dt?

Regards,
Nicolas


--=-rHY9rlJOyK3Y6KPoBaSb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5VRLgACgkQlfZmHno8
x/6Q2gf+ISkwE0dJhNaeauh1TOB9Ymx8NHoZYccWJLmwg4vqH+nOGwxQM4O26qbu
lXwrXTBzGcDwvdJkGmBsrTqRGGRbgtmeBQu4siPFNjD7hl775Uz2FIfNlWnUEieQ
lKbdquRkNjoHvXoDDuHEHuBlHQ2W0IckhNFiEMhdDGb2n9eAvBaILoba+pgjgwP6
IAnRGDlk7JBf7kuWHk6RWEOjOwKoCJlHJsNA09ZK2tjXMkaOqKLWnGIVGFMECm7/
ThGgG9gqv65WG/8uK1E/F5hnR3qVbYXLcXAXZLK28nxkXODDw7fNBEXEUfXHJKqT
TtEHMJ79mu2FeQA32GE0G3lduoWGjg==
=HBgi
-----END PGP SIGNATURE-----

--=-rHY9rlJOyK3Y6KPoBaSb--

