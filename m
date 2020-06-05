Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14A4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D97E2065C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgFEME5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:04:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:56360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbgFEME5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:04:57 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7D510AEBE;
        Fri,  5 Jun 2020 12:04:58 +0000 (UTC)
Message-ID: <d8be3a45491224e0c91355131a9bcf605f38fb76.camel@suse.de>
Subject: Re: [PATCH v3 20/25] clk: bcm: rpi: Add an enum for the firmware
 clocks
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Date:   Fri, 05 Jun 2020 14:04:51 +0200
In-Reply-To: <c56fb0a912fe254416ed5a247e6fb6d79fb604bc.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
         <c56fb0a912fe254416ed5a247e6fb6d79fb604bc.1590594293.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-GP9+0KNilneDNEwCxB11"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-GP9+0KNilneDNEwCxB11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-05-27 at 17:45 +0200, Maxime Ripard wrote:
> While the firmware allows us to discover the available clocks, we need to
> discriminate those clocks to only register the ones meaningful to Linux.
> The firmware also doesn't provide a clock name, so having a list of the I=
D
> will help us to give clocks a proper name later on.
>=20
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/clk/bcm/clk-raspberrypi.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-
> raspberrypi.c
> index 5f4e2d49432f..eebd16040f8a 100644
> --- a/drivers/clk/bcm/clk-raspberrypi.c
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -18,7 +18,23 @@
> =20
>  #include <soc/bcm2835/raspberrypi-firmware.h>
> =20
> -#define RPI_FIRMWARE_ARM_CLK_ID		0x00000003
> +enum rpi_firmware_clk_id {
> +	RPI_FIRMWARE_EMMC_CLK_ID =3D 1,
> +	RPI_FIRMWARE_UART_CLK_ID,
> +	RPI_FIRMWARE_ARM_CLK_ID,
> +	RPI_FIRMWARE_CORE_CLK_ID,
> +	RPI_FIRMWARE_V3D_CLK_ID,
> +	RPI_FIRMWARE_H264_CLK_ID,
> +	RPI_FIRMWARE_ISP_CLK_ID,
> +	RPI_FIRMWARE_SDRAM_CLK_ID,
> +	RPI_FIRMWARE_PIXEL_CLK_ID,
> +	RPI_FIRMWARE_PWM_CLK_ID,
> +	RPI_FIRMWARE_HEVC_CLK_ID,
> +	RPI_FIRMWARE_EMMC2_CLK_ID,
> +	RPI_FIRMWARE_M2MC_CLK_ID,
> +	RPI_FIRMWARE_PIXEL_BVB_CLK_ID,
> +	RPI_FIRMWARE_NUM_CLK_ID,
> +};
> =20
>  #define RPI_FIRMWARE_STATE_ENABLE_BIT	BIT(0)
>  #define RPI_FIRMWARE_STATE_WAIT_BIT	BIT(1)
> @@ -31,8 +47,6 @@
> =20
>  #define A2W_PLL_FRAC_BITS		20
> =20
> -#define NUM_FW_CLKS			16
> -
>  struct raspberrypi_clk {
>  	struct device *dev;
>  	struct rpi_firmware *firmware;
> @@ -320,7 +334,8 @@ static int raspberrypi_clk_probe(struct platform_devi=
ce
> *pdev)
>  	rpi->firmware =3D firmware;
>  	platform_set_drvdata(pdev, rpi);
> =20
> -	clk_data =3D devm_kzalloc(dev, struct_size(clk_data, hws, NUM_FW_CLKS),
> +	clk_data =3D devm_kzalloc(dev, struct_size(clk_data, hws,
> +						 RPI_FIRMWARE_NUM_CLK_ID),

nit: you're allocating one structure too many right?

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-GP9+0KNilneDNEwCxB11
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7aNOMACgkQlfZmHno8
x/663Af/Ue9v4O4m3tuVBEUtlVFqdD+i3sT2CM6Kgid7VjNWLvsgN8tbreLEg/kj
MSPVWTG+XKpO/gk+qom/1tuUTCXYtc69+v/ZeTUfKPr/qhrijdrgwv7MHZx53zUi
t6ZAFskKADhFQbMXPQQjXzUUwAtSf+RpWGIz2QcLpX6k3KlYkSYcVs2V5l1uxcv6
xa7cBA3m+CPK2URXdFdyrb1+xCKKL+hWPTI8Sxhb/jST92xsfV3m/nV6x9NaJweI
tqb7oybKtgK5D8nmpU7Uk5cFMrN/c+TUpgB8fC+j4Wk/laqtNI5MsIC/5oZsnXlq
JJwitiIAqvtbem36Y5KbsOjGUhW3JQ==
=ytwt
-----END PGP SIGNATURE-----

--=-GP9+0KNilneDNEwCxB11--

