Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14878C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC06220CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgBYQFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:05:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:44234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728051AbgBYQFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:05:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7540FACB8;
        Tue, 25 Feb 2020 16:05:10 +0000 (UTC)
Message-ID: <1ac802c877be35f9065230fb657b5249b201c36d.camel@suse.de>
Subject: Re: [PATCH 08/89] clk: bcm: rpi: Statically init clk_init_data
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
Date:   Tue, 25 Feb 2020 17:05:09 +0100
In-Reply-To: <9ca2cfd02a75d6680533233a9a4e2b60d2ad0ff5.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
         <9ca2cfd02a75d6680533233a9a4e2b60d2ad0ff5.1582533919.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-QEtcQAOM4pSVPW/kdM3g"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-QEtcQAOM4pSVPW/kdM3g
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-24 at 10:06 +0100, Maxime Ripard wrote:
> Instead of declaring the clk_init_data and then calling memset on it, jus=
t
> initialise properly.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!
Nicolas


--=-QEtcQAOM4pSVPW/kdM3g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5VRbUACgkQlfZmHno8
x/5Lkgf/RGwXdMhFQQIz9ZY+f+MAzsSdRjRkEHxy3s5tJqSgI6muZTrC1I1Zt85a
XrQKG44hswhNqI+fPduksGqRQwj5j3Neh4QTyNlSfNPW1kQ2mHR5PqUgNt4husNz
wQCIafF/scKUWXFSZLFHS7GJXaqmlE+u7wQqeYOzRuklJXtG1LG2+0DnaYKBHFLT
vPJC96MYKxW0+bP3QD3P3vwXwoNSc7cH0d6Y8FVy0ttKZrh3Y1VPBAYMSnCgUdaQ
/rNcJqD/dJsfEsMpn02gDZm7IXJgX6noCPWklw4HDXfKI9u8/jmBN8IgE352F4fg
ASIY8V7SpueYJCk2A/L3/1i2l/bHFQ==
=jbQQ
-----END PGP SIGNATURE-----

--=-QEtcQAOM4pSVPW/kdM3g--

