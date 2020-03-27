Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8EAC2D0E5
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 827E42082D
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 12:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgC0Mk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 08:40:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:39640 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726742AbgC0Mk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 08:40:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6AD9BAE1C;
        Fri, 27 Mar 2020 12:40:54 +0000 (UTC)
Message-ID: <d6325a2610d349eba922cdcdd3381364ab927159.camel@suse.de>
Subject: Re: [PATCH] drm/vc4: Fix HDMI mode validation
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-rpi-kernel@lists.infradead.org, f.fainelli@gmail.com,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Fri, 27 Mar 2020 13:40:52 +0100
In-Reply-To: <20200327124014.cpadv7npw2q6iaxe@gilmour.lan>
References: <20200326122001.22215-1-nsaenzjulienne@suse.de>
         <65a2d18ec2b901c6a89acc091cf9573a98fda75f.camel@suse.de>
         <20200327124014.cpadv7npw2q6iaxe@gilmour.lan>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5Iqt3qdKsxOyWAW1tzPj"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5Iqt3qdKsxOyWAW1tzPj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-03-27 at 13:40 +0100, Maxime Ripard wrote:
> On Fri, Mar 27, 2020 at 12:46:52PM +0100, Nicolas Saenz Julienne wrote:
> > Hi Daniel,
> >=20
> > On Thu, 2020-03-26 at 13:20 +0100, Nicolas Saenz Julienne wrote:
> > > Current mode validation impedes setting up some video modes which sho=
uld
> > > be supported otherwise. Namely 1920x1200@60Hz.
> > >=20
> > > Fix this by lowering the minimum HDMI state machine clock to pixel cl=
ock
> > > ratio allowed.
> > >=20
> > > Fixes: 32e823c63e90 ("drm/vc4: Reject HDMI modes with too high of clo=
cks")
> > > Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> > > Suggested-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >=20
> > Would it be possible for you to take this in for v5.7 (or as a fix for =
v5.6,
> > but it seems a little late)?
> >=20
> > A device-tree patch I have to channel trough the SoC tree depends on th=
is to
> > avoid regressions.
>=20
> I've applied it for 5.7-rc1

Thanks!


--=-5Iqt3qdKsxOyWAW1tzPj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl599FQACgkQlfZmHno8
x/44LAf9HAcHO90kKZkw5zqsWzAr69zCvbeLuO9UCtVc8Iul7mVEIb5n2KAS/BjD
wsSHNZwvAKU8FT4DTuTIqF7kSzOb7iaKErzt/QgyVuRovM1yNS9ZgQQUVbFungxi
g+GtSPnLkil5ydnN72MU3m52xsdqe4GA/7plv6sbbsFlH08N1dl/T0vSd3lHNO8a
CY9yIId3RkfhoC74QfBGL7tRyoJyiKyt4xrOLlfyR7el9CR0hzcfC+5qHdER8Mig
jooqcstPltByTHY/4OCewAhfA5b3lf2iul1kQMgHrkqZe2WGxMy6z80Stxfm3nsM
2gVYNeIuq4K74o++da6R3jDE/7mn1g==
=mJWx
-----END PGP SIGNATURE-----

--=-5Iqt3qdKsxOyWAW1tzPj--

