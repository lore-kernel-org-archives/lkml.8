Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C432C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E758A2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgFKLPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:15:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:60058 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726708AbgFKLPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:15:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 43D20AC20;
        Thu, 11 Jun 2020 11:15:39 +0000 (UTC)
Message-ID: <768f70443c84a33a6685df79c630192e9e72f893.camel@suse.de>
Subject: Re: [PATCH v4 23/27] Revert "clk: bcm2835: remove pllb"
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
Date:   Thu, 11 Jun 2020 13:15:33 +0200
In-Reply-To: <2795d7ad33c9eba631fb356df7ff075ee5e8a0b8.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
         <2795d7ad33c9eba631fb356df7ff075ee5e8a0b8.1591860665.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-hbYUkMWex4Zkya5EfVIi"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hbYUkMWex4Zkya5EfVIi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-06-11 at 09:32 +0200, Maxime Ripard wrote:
> This reverts commit 2256d89333bd17b8b56b42734a7e1046d52f7fc3. Since we
> will be expanding the firmware clock driver, we'll need to remove the
> quirks to deal with the PLLB. However, we still want to expose the clock
> tree properly, so having that clock in the MMIO driver will allow that.
>=20
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-hbYUkMWex4Zkya5EfVIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7iElUACgkQlfZmHno8
x/7qEQgAjZnjjXvRdAi/lc/o42kdtkguD5/CJSpvXou0kiL3FOFcffpKKOAkOzWq
Z/yk+9EJ4/qHLuarbUHVa+JYFHb9y/iXBVJyGwgDUAgGRz9sJYzujHNYQ9AS9ODF
0abA1KUTWSvXTb4uWsEavq5fqR5g2QjUctjPta3WcdsCmkQ9Hg4AAleRM5GF6+St
wJbCRx/teGUuMKq0LZ/nQBypV6QyAgb3gSxNqitenCT/BXBgt3N0nNgF4+UoFvM/
GQ0vUYB7zyET9sYNYQ/d1C3upKOLyV8veg1bfpHdYKc3uqYp+hiq1xHmjIXP/eLJ
vwQKYuRVj3vsEZ1SQOIkc7CoXKrF4Q==
=p+Ci
-----END PGP SIGNATURE-----

--=-hbYUkMWex4Zkya5EfVIi--

