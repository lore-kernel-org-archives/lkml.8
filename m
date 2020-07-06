Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4270C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 894FB206E9
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgGFQxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:53:08 -0400
Received: from mx2.suse.de ([195.135.220.15]:53408 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729384AbgGFQxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:53:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0C9EBABF4;
        Mon,  6 Jul 2020 16:53:06 +0000 (UTC)
Message-ID: <6da99a10debca368985e69d61f917785da8061a3.camel@suse.de>
Subject: Re: [PATCH v4 3/3] ARM: dts: bcm2711: Add HDMI DVP
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Mon, 06 Jul 2020 18:53:04 +0200
In-Reply-To: <e22222ca7f41b960e9bb1a31e0dd2de95b8c0cd1.1591867332.git-series.maxime@cerno.tech>
References: <cover.4c4625a8e076f3163b800b3d8986b282ee98d908.1591867332.git-series.maxime@cerno.tech>
         <e22222ca7f41b960e9bb1a31e0dd2de95b8c0cd1.1591867332.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-3gU7U7fv64+BGKtfJm+D"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3gU7U7fv64+BGKtfJm+D
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-06-11 at 11:23 +0200, Maxime Ripard wrote:
> Now that we have a driver for the DVP, let's add its DT node.
>=20
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied for-next,

Thanks,
Nicolas


--=-3gU7U7fv64+BGKtfJm+D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl8DVvAACgkQlfZmHno8
x/4Bdgf+K6eembVjOyppSnpyDFUnzdc2w7IjmENlzuXT0eUzG70ZpbImjgDfbAWF
dzCmVd31hdwMh+dFQSAeeBNWeE54zH1YAkSLPFfc89mbyTOD5+Iyf1BeKRUGecNR
spygrX8+nKB6ajaYYpql9PGpATjQ12yv+2j5vuUQAshjBI1uJ5bhFNfH8HBeTlg5
oJcZ+0WIvFVhHmB/z3rdDTBsgW0I4Kj/F0s40zcV6kgnsFDohWNaCvyAlAn9r7dI
2HLWX8inPtdyg/H3ZIN/5SyneLKqAqIN4eLDfKQhBhmn5/rBmn/Gr7lkbQD3IlIh
/j+0Iu//rQg4uRAtAPYLokgAOnZ+Qg==
=tz83
-----END PGP SIGNATURE-----

--=-3gU7U7fv64+BGKtfJm+D--

