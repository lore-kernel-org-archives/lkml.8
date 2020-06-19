Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3219FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 151332080C
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 09:45:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732110AbgFSJo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 05:44:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:39246 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729718AbgFSJo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 05:44:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id DB8E6AEB2;
        Fri, 19 Jun 2020 09:44:56 +0000 (UTC)
Message-ID: <bdc91c1b015d2f02bd0ea90ae81a122123c62b38.camel@suse.de>
Subject: Re: [PATCH v5 00/27] clk: bcm: rpi: Add support for BCM2711
 firmware clocks
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Stephen Boyd <sboyd@kernel.org>, Maxime Ripard <maxime@cerno.tech>
Cc:     devicetree@vger.kernel.org, Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 19 Jun 2020 11:44:54 +0200
In-Reply-To: <159255945796.62212.5838238989498858379@swboyd.mtv.corp.google.com>
References: <cover.98f979c2af2337c57217016d21d7c68e1ac2ce8a.1592210452.git-series.maxime@cerno.tech>
         <159255945796.62212.5838238989498858379@swboyd.mtv.corp.google.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-fZ7yXxkuArogoYxiG0Gc"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fZ7yXxkuArogoYxiG0Gc
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-06-19 at 02:37 -0700, Stephen Boyd wrote:
> Quoting Maxime Ripard (2020-06-15 01:40:40)
> > Hi,
> >=20
> > Since the whole DRM/HDMI support began to grow fairly big, I've chosen
> > to split away the two discussions between the firmware clocks and the
> > HDMI support.
> >=20
> > Let me know what you think,
> > Maxime
>=20
> Do you want this to go through clk tree? Or looking for acks/review
> tags?
>=20

FWIW I don't mind taking the device tree changes trough the RPi soc tree.

Regards,
Nicolas


--=-fZ7yXxkuArogoYxiG0Gc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7siRYACgkQlfZmHno8
x/5pSQf/exFv/66MuXsAeM5ue9vwfKbkmJ1AI4WY+HeyniqK7yARVlufqNDDHNry
JW+BPgp/zFe6ZMhVfD/l9xc/tf3dn0vT/CINKP2Uhgey4GeVZ+TuekJ9pOQmlDjt
HaormE0veBP+pk07pwOj7vXUNEd5spHlMjdu/xPT0NgZXQanvBy+NYIRZjWSXjs2
pmxNSsSr9LGT2ypipzUtyqAtILTUobwgXFAWNeSp9uxyHD+V2qLatUtJCbP+Lqii
nrosXYxiGw4CaZ2Ypl14pcOfQ24nsaAQNInTDetN47MCJtJZDcINclfqG0IWfvE3
2+ZxejWhAankUhgBWQDZXcoPsLcgkA==
=Fnq6
-----END PGP SIGNATURE-----

--=-fZ7yXxkuArogoYxiG0Gc--

