Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF1D9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8603E2063A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 11:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgFKLSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 07:18:55 -0400
Received: from mx2.suse.de ([195.135.220.15]:60844 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728014AbgFKLSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 07:18:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 62155AD12;
        Thu, 11 Jun 2020 11:18:55 +0000 (UTC)
Message-ID: <333956e7b6b186f751baf7f1b69be3c2cf4d077f.camel@suse.de>
Subject: Re: [PATCH v4 27/27] clk: bcm: rpi: Remove the quirks for the CPU
 clock
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
Date:   Thu, 11 Jun 2020 13:18:50 +0200
In-Reply-To: <a636a413f26014901ff1acb8df046049a79c4c6d.1591860665.git-series.maxime@cerno.tech>
References: <cover.58c6e44891ff5bf61052b5804f7da9b5ba074840.1591860665.git-series.maxime@cerno.tech>
         <a636a413f26014901ff1acb8df046049a79c4c6d.1591860665.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-U285mDlmyFSu1bffEK5R"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-U285mDlmyFSu1bffEK5R
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-06-11 at 09:32 +0200, Maxime Ripard wrote:
> The CPU clock has had so far a bunch of quirks to expose the clock tree
> properly, but since we reverted to exposing them through the MMIO driver,
> we can remove that code from the firmware driver.
>=20
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-U285mDlmyFSu1bffEK5R
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7iExoACgkQlfZmHno8
x/7NEwgAmtZn8c3AHDT++MR4B7LhujoGQ8LYybQXxK3GT42QsGrQC1gJTHb37q1h
GFFMOJA+WL4dEvVOWujZe88cnZkIgoneF3a/y+6x9ZBDYRb15rljvJXxWDDEpDNq
I4pzHw2RldYDTbe+bM8qy4c5LN+uPrtvujT9ZWXKBDjE2ixTwrVqWNBMMtiNacYu
xEGJrr4Bwi11Gng1qmRD+MwNrwhIfQDMAqvhV865eqfWnri3+xws2Xa1wfcNYUaf
oyX8gzx/LV8LbpdXLQpddhiPxKzDXWqXTHcnpZXyPPXAgRDUDLGy0I/Irxqnw5tk
zOPDY89bcrKowlAUqAM5uDFIBI9btQ==
=Cn2+
-----END PGP SIGNATURE-----

--=-U285mDlmyFSu1bffEK5R--

