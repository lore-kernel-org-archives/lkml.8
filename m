Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C8D2C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:06:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5CDB2137B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731815AbgIHQTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:19:21 -0400
Received: from mx2.suse.de ([195.135.220.15]:56302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731395AbgIHQJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:09:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 29CF9ADDB;
        Tue,  8 Sep 2020 16:09:48 +0000 (UTC)
Message-ID: <f3d9a4a95e419b2cd67469b4adba4cfe4da71f7a.camel@suse.de>
Subject: Re: [PATCH v2 1/4] clk: bcm: rpi: Add register to control pixel bvb
 clk
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
Date:   Tue, 08 Sep 2020 18:09:44 +0200
In-Reply-To: <20200901040759.29992-2-hoegeun.kwon@samsung.com>
References: <20200901040759.29992-1-hoegeun.kwon@samsung.com>
         <CGME20200901040851epcas1p28f443c0e819bea756ebf9296491b32da@epcas1p2.samsung.com>
         <20200901040759.29992-2-hoegeun.kwon@samsung.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-bRnBewXchSGzBuzQX1iH"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-bRnBewXchSGzBuzQX1iH
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-09-01 at 13:07 +0900, Hoegeun Kwon wrote:
> To use QHD or higher, we need to modify the pixel_bvb_clk value. So
> add register to control this clock.
>=20
> Signed-off-by: Hoegeun Kwon <hoegeun.kwon@samsung.com>
> ---
>  drivers/clk/bcm/clk-raspberrypi.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-rasp=
berrypi.c
> index 5cc82954e1ce..f89b9cfc4309 100644
> --- a/drivers/clk/bcm/clk-raspberrypi.c
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -271,6 +271,7 @@ static int raspberrypi_discover_clocks(struct raspber=
rypi_clk *rpi,
>  		case RPI_FIRMWARE_CORE_CLK_ID:
>  		case RPI_FIRMWARE_M2MC_CLK_ID:
>  		case RPI_FIRMWARE_V3D_CLK_ID:
> +		case RPI_FIRMWARE_PIXEL_BVB_CLK_ID:
>  			hw =3D raspberrypi_clk_register(rpi, clks->parent,
>  						      clks->id);
>  			if (IS_ERR(hw))

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-bRnBewXchSGzBuzQX1iH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl9XrMgACgkQlfZmHno8
x/5Piwf8CYoN2PUqTObU8bIxbxLs0x5KdJ0l4F+I0cw3UhAtM8A0+OSU2hOZLEHH
xgw/OG9Ejn4mG6V32drl5FuTcGuXO1q0z+dJn7B33mtBHFUy2XX9Qk1RdsBcjt38
wdTxlupb/ggrkqeTEH7wOjVteRHGa/mSsKnGnLUJhNPQd3L5EMRKdQ+wUJnbE0E2
5nDJ8W0+oIgbDoP5KVhduAV17jWQ9OoAZEffeX9KQ6z+HOs5/rKQRrKw+38Tv2DO
JuWd8XPDem3+KJ89G8ohVWn6ugsoLX77V+6U5cp8Tp/5WtLBqa7p7Y852GB1jn+T
IIUkypxQvzYaa6gNlQguSSORoALCxw==
=VNO1
-----END PGP SIGNATURE-----

--=-bRnBewXchSGzBuzQX1iH--

