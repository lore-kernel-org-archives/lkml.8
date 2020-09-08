Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5DE9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846682078B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 18:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731534AbgIHSKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 14:10:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:57860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731322AbgIHQLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:11:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 892F8B74F;
        Tue,  8 Sep 2020 16:11:39 +0000 (UTC)
Message-ID: <7367c17489ef7d5bc24c0452c9887663f938344b.camel@suse.de>
Subject: Re: [PATCH v2 0/4] drm/vc4: Support HDMI QHD or higher output
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Hoegeun Kwon <hoegeun.kwon@samsung.com>, eric@anholt.net,
        maxime@cerno.tech, stefan.wahren@i2se.com,
        dave.stevenson@raspberrypi.com
Cc:     devicetree@vger.kernel.org, tim.gover@raspberrypi.com,
        sboyd@kernel.org, mturquette@baylibre.com, kdasu.kdev@gmail.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, robh+dt@kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org, phil@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org
Date:   Tue, 08 Sep 2020 18:11:36 +0200
In-Reply-To: <20200901040759.29992-1-hoegeun.kwon@samsung.com>
References: <CGME20200901040850epcas1p2150ea195dfb20b46d6421af63b1f5129@epcas1p2.samsung.com>
         <20200901040759.29992-1-hoegeun.kwon@samsung.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-KMxdxbhMfC1Bf45kOePp"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KMxdxbhMfC1Bf45kOePp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-09-01 at 13:07 +0900, Hoegeun Kwon wrote:
> Hi everyone,
>=20
> There is a problem that the output does not work at a resolution
> exceeding FHD. To solve this, we need to adjust the bvb clock at a
> resolution exceeding FHD.
>=20
> Rebased on top of next-20200708 and [1].
>=20
> [1] : [PATCH v4 00/78] drm/vc4: Support BCM2711 Display Pipeline (Maxime'=
s patchset)
>=20
> Changes from v1:
>   - Added dt-bindings documents
>   - Change patch order, first fix driver and then device tree
>=20
> Hoegeun Kwon (4):
>   clk: bcm: rpi: Add register to control pixel bvb clk
>   drm/vc4: hdmi: Add pixel bvb clock control
>   dt-bindings: display: vc4: hdmi: Add bvb clock-names property
>   ARM: dts: bcm2711: Add bvb clock for hdmi-pixel
>=20
>  .../bindings/display/brcm,bcm2711-hdmi.yaml   | 12 ++++++---
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts         |  6 +++--
>  drivers/clk/bcm/clk-raspberrypi.c             |  1 +
>  drivers/gpu/drm/vc4/vc4_hdmi.c                | 25 +++++++++++++++++++
>  drivers/gpu/drm/vc4/vc4_hdmi.h                |  1 +
>  5 files changed, 39 insertions(+), 6 deletions(-)

Small note to anyone reviewing this, patches 3 & 4 where squashed into this
series: https://lkml.org/lkml/2020/9/3/219

Regards,
Nicolas


--=-KMxdxbhMfC1Bf45kOePp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl9XrTgACgkQlfZmHno8
x/4bVwf+N7uuI1uhrijPKBHw/kVDjkfpbhhO78uXdO7AwTDOGvasQGmyTwz6rZLo
nWSHBPD+B8UnmdaSPbBqKpt2b1hDcxCYAh6jdWvd2hwUiX4zzu0dQFrzg+JqVL6n
7YsL6yIteSo5kBxBnWNZ6XZBCjIsgbXSplVQY2EAEqOhyhD47c1jr9wkam899PE3
L3s0Qlox7zAGWI9IE9OJoS+pATo2+wyMrUjx8nlSs7ygUP1WCUOnVII6dCJusTXP
iD5J/IoO/c9VQHa68m9VQUorEW3KG4P0v4I5gCB8dRtSiPXN30bpZZqysWBb1aiv
uJ0vrxKphu9teKjIoBXxEHl4vBfy0g==
=2yE8
-----END PGP SIGNATURE-----

--=-KMxdxbhMfC1Bf45kOePp--

