Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675E3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48E772063A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgFKLPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:15:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:59908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgFKLPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:15:03 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A4284AAC6;
        Thu, 11 Jun 2020 11:15:04 +0000 (UTC)
Message-ID: <7cf4a213862145abd8e0368b669aab39112ffaeb.camel@suse.de>
Subject: Re: [PATCH v4 21/27] clk: bcm: rpi: Discover the firmware clocks
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
Date:   Thu, 11 Jun 2020 13:14:58 +0200
In-Reply-To: <40ab5a9718000636a513d374e7579e2d2b57f961.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
         <40ab5a9718000636a513d374e7579e2d2b57f961.1591860665.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-/HZv/CDJ5nGFBA3EUvfy"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/HZv/CDJ5nGFBA3EUvfy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-06-11 at 09:32 +0200, Maxime Ripard wrote:
> The RaspberryPi4 firmware actually exposes more clocks than are currently
> handled by the driver and we will need to change some of them directly
> based on the pixel rate for the display related clocks, or the load for t=
he
> GPU.
>=20
> Since the firmware implements DVFS, this rate change can have a number of
> side-effects, including adjusting the various PLL voltages or the PLL
> parents. The firmware also implements thermal throttling, so even some
> thermal pressure can change those parameters behind Linux back.
>=20
> DVFS is currently implemented on the arm, core, h264, v3d, isp and hevc
> clocks, so updating any of them using the MMIO driver (and thus behind th=
e
> firmware's back) can lead to troubles, the arm clock obviously being the
> most problematic.
>=20
> In order to make Linux play as nice as possible with those constraints, i=
t
> makes sense to rely on the firmware clocks as much as possible. However,
> the firmware doesn't seem to provide some equivalents to their MMIO
> counterparts, so we can't really replace that driver entirely.
>=20
> Fortunately, the firmware has an interface to discover the clocks it
> exposes.
>=20
> Let's use it to discover, register the clocks in the clocks framework and
> then expose them through the device tree for consumers to use them.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-/HZv/CDJ5nGFBA3EUvfy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7iEjIACgkQlfZmHno8
x/5O/wgAojiCQn8IWPe5AD2kCeaAi3GY+ivhNVp+ylf43QI1C0rv3ie+dyzYTHFe
YBp1ll774sFXWcHYoz2GIfWn1r1xKtsaLmsgQSW6iCOzTr6/jhhmHUZqZSgMcW2Y
sozYVnzsEbdAGpbsZ37CFPMbvXdYi91GW9vet+w/lkEvPcP6UOTCW13sFfdsrOVi
xUQxHElDMq4cNjMMqBmA57EjCyltxfUYD4eLZ+5dlw93GSH0IsXfFTBRupFApN/Y
K4vNFlWJur4B0WzWekZMYGXbePmxV02RTBv+53KLBr1/pDRDTaF/ndPbk9iuq7U+
anDlvK61kOm4M+bXQpdWVlw3dKnKbA==
=zn5D
-----END PGP SIGNATURE-----

--=-/HZv/CDJ5nGFBA3EUvfy--

