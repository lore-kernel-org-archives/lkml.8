Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85EBC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851E3206DB
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbgIHQgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:36:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:48044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731934AbgIHQbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:31:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2F7A0B7D1;
        Tue,  8 Sep 2020 16:31:46 +0000 (UTC)
Message-ID: <df34d0ab703600822a7bf1978ecafb01ba1013e8.camel@suse.de>
Subject: Re: [PATCH v5 80/80] ARM: dts: bcm2711: Enable the display pipeline
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>, Eric Anholt <eric@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Date:   Tue, 08 Sep 2020 18:31:42 +0200
In-Reply-To: <cfce2276d172d3d9c4d34d966b58fd47f77c4e46.1599120059.git-series.maxime@cerno.tech>
References: <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
         <cfce2276d172d3d9c4d34d966b58fd47f77c4e46.1599120059.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-AwMin9yk1eCNmWRMdPWo"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AwMin9yk1eCNmWRMdPWo
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-09-03 at 10:01 +0200, Maxime Ripard wrote:
> Now that all the drivers have been adjusted for it, let's bring in the
> necessary device tree changes.
>=20
> The VEC and PV3 are left out for now, since it will require a more specif=
ic
> clock setup.
>=20
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> Tested-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Applied for-next.

Thanks!
Nicolas


--=-AwMin9yk1eCNmWRMdPWo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl9Xse4ACgkQlfZmHno8
x/7r7wf/c9LMy3CL6TDMF3nNWJaJPclZUgPWhuKeAd5RIOMbjR+REcXp0GtBl288
tA3a2Le4uwgSyLL+slJrXrnIZncbFwXa87NVC/N92yYzXAUqfocCkxRqpXE8trKq
vBJz3fWh9AqDjZEQCcayZvXFFYbZ97fqJXJErPJOX5lHDMd2/LUAcpNN3b7aEGeP
OqRno1Yl5v/GtNzGtx4rLbd+qUT/2TZalSxhUzlzpkFLaLZCuHLVkJfzgdwPkGbl
cnj3wPBiJ6rnDS3N7RAdoxTj08ZdJOng1+5M7RdjwFrewwDtS24sfTTCBAQYSRzK
eoii/d6dArfaYhhBOM7uTXBRhD80Dw==
=vUSx
-----END PGP SIGNATURE-----

--=-AwMin9yk1eCNmWRMdPWo--

