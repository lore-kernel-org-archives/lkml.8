Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A544CC4BA14
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8357B20838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBZO57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:57:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:46724 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgBZO56 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:57:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id E490AAC5C;
        Wed, 26 Feb 2020 14:57:56 +0000 (UTC)
Message-ID: <f34f037ebb9219c34480814433a277054c345690.camel@suse.de>
Subject: Re: [PATCH 10/89] clk: bcm: rpi: Remove global pllb_arm clock
 pointer
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Eric Anholt <eric@anholt.net>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 26 Feb 2020 15:57:53 +0100
In-Reply-To: <20200226142617.mvis6olfzakiwqcc@gilmour.lan>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
         <3876f732b3fec2059270678d464d27b7d3a0414b.1582533919.git-series.maxime@cerno.tech>
         <52aebb76952df530f93e9de539124ddf1b825876.camel@suse.de>
         <20200226142617.mvis6olfzakiwqcc@gilmour.lan>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-H7D2q/McolpIoggtEKhp"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-H7D2q/McolpIoggtEKhp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-02-26 at 15:26 +0100, Maxime Ripard wrote:
> Hi Nicolas,
>=20
> On Tue, Feb 25, 2020 at 05:13:33PM +0100, Nicolas Saenz Julienne wrote:
> > On Mon, 2020-02-24 at 10:06 +0100, Maxime Ripard wrote:
> > > The pllb_arm clk_hw pointer in the raspberry_clk structure isn't used
> > > anywhere but in the raspberrypi_register_pllb_arm.
> > >=20
> > > Let's remove it, this will make our lives easier in future patches.
> > >=20
> > > Cc: Michael Turquette <mturquette@baylibre.com>
> > > Cc: Stephen Boyd <sboyd@kernel.org>
> > > Cc: linux-clk@vger.kernel.org
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> I guess you meant Acked or Reviewed-by?

Yes sorry, I ran the wrong macro in vim.

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!
Nicolas


--=-H7D2q/McolpIoggtEKhp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5Wh3EACgkQlfZmHno8
x/5dXwf/bKHxAxeQ4QoZjBlowsDSKby25i/UiGoQRjMihV8lAF5kvgszeIQN06d3
QFyxNv6+5IGxrr59IVdsYrnNV2dEVmKjg+6LZuVRPNCVRvEFdfRiTpukk3uxgFlX
sLaq8Lka4a64P4aoKJmqlge6JgXxhURwb/sUC9BBv+InbDws6+XxkDCXG0UmH8rG
sTsmoW8/gUiUJ+koBCxtipKbgzjzLim2LdWX2kUrdMZCBAP/Rxxp1bHCiHaGYRh8
pUvVxJ/IpJ0KC0Ef7QYlyk3/hnnPHPtcwo1z5NfXOsgTBLFXSv9rq6Jrqk0OJkga
LB3ZGFODiroFr+Q15H+sdaU4BV+KLw==
=93WR
-----END PGP SIGNATURE-----

--=-H7D2q/McolpIoggtEKhp--

