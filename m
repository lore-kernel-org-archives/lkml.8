Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA379C35E09
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC50320CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 16:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbgBYQLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 11:11:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:46660 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729206AbgBYQLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 11:11:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CA24AACB8;
        Tue, 25 Feb 2020 16:11:35 +0000 (UTC)
Message-ID: <f7d43591965dd9c5aed7af194709e15f68f63d3d.camel@suse.de>
Subject: Re: [PATCH 09/89] clk: bcm: rpi: Use clk_hw_register for pllb_arm
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
Date:   Tue, 25 Feb 2020 17:11:34 +0100
In-Reply-To: <1c47c839fda93460994d37b4c851d805a3282d5f.1582533919.git-series.maxime@cerno.tech>
References: <cover.6c896ace9a5a7840e9cec008b553cbb004ca1f91.1582533919.git-series.maxime@cerno.tech>
         <1c47c839fda93460994d37b4c851d805a3282d5f.1582533919.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-WxIH33aUvejlhlKylEgn"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WxIH33aUvejlhlKylEgn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-02-24 at 10:06 +0100, Maxime Ripard wrote:
> The pllb_arm clock is defined as a fixed factor clock with the pllb clock
> as a parent. However, all its configuration is entirely static, and thus =
we
> don't really need to call clk_hw_register_fixed_factor but can simply cal=
l
> clk_hw_register with a static clk_fixed_factor structure.
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Thanks!
Nicolas


--=-WxIH33aUvejlhlKylEgn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl5VRzYACgkQlfZmHno8
x/47yggAt8HYPSSAwxIpPsTANQ5MOmHcSrWHPtoeQ9a34zlBUUytK4V4bHUW0oXO
W1GOccGSIUHjMHxIZxvOQtiTPgQH56S9SwygQc46T1w+wk/PbuWbBIp7PD71ff1t
JM80+4P+PUb/DU45sjzNlJ7pjVf1u5TrSjcSyZsTKgvDBH871y/+bQhv2vyvCD50
tpnI/h4TdEg4J3xJjXGqqlKHJGUL9QzWUid4iUDzrWJUedsERifPTNTWGtHGuJrJ
sULf1ByFTAgzjY9rY9ss+uP1lQVcspatnr8aqU9H1Zs+fBzN4f7eLnbdC3vM9SBq
96EoI2KTjpdggc67GD/da+kMBmYCHg==
=UyQW
-----END PGP SIGNATURE-----

--=-WxIH33aUvejlhlKylEgn--

