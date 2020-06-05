Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43294C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21BCD2074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 10:34:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgFEKei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 06:34:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:55158 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbgFEKeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 06:34:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 182A9B1BA;
        Fri,  5 Jun 2020 10:34:39 +0000 (UTC)
Message-ID: <9c3d28922f343bcb19243894d3385a8fe1fb3606.camel@suse.de>
Subject: Re: [PATCH v3 17/25] clk: bcm: rpi: Split pllb clock hooks
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 05 Jun 2020 12:34:32 +0200
In-Reply-To: <10e269b4c3c5cf38eba9c0684341b191b9ab7abe.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
         <10e269b4c3c5cf38eba9c0684341b191b9ab7abe.1590594293.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-kBBCKrUQb2v8gZXGREOB"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-kBBCKrUQb2v8gZXGREOB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-05-27 at 17:45 +0200, Maxime Ripard wrote:
> The driver only supports the pllb for now and all the clock framework hoo=
ks
> are a mix of the generic firmware interface and the specifics of the pllb=
.
> Since we will support more clocks in the future let's split the generic a=
nd
> specific hooks
>=20
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: linux-clk@vger.kernel.org
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-kBBCKrUQb2v8gZXGREOB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7aH7gACgkQlfZmHno8
x/4xWwf/RYRgzsbakQqmxDtyx2MpHrL5pyM3SCfIlrEoNmp0pInOHxEiPDyM4gHG
M1nMPJiZqDKXKYbbTXB4LkzLt7OelM3FEtgUiZYUOiKk/kKmFeXdXpRUY9yLtcGg
mwypxmeNKfXXX7NAH+UOuuvxv1luAgeW+FP8hGQVoDp12R6TDScRHHJu9OJC/2CO
fWwOCU4ROOiIqbPAL/YdOXdfEN62D6AJhDIoviS1zU4QG0+pMsxdERkcGac1Hr26
lDYR8ManeMQPO03IUZGcOKcDdY2iflgzaQvFBvSHeFiOIkGYucDFMF0q173q+O8X
S+mbc0Xe4WLmffWUA6EmQ0s73kLt6w==
=ayQ0
-----END PGP SIGNATURE-----

--=-kBBCKrUQb2v8gZXGREOB--

