Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A86AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 273812065C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgFEMt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:49:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:53850 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgFEMt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:49:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7335AAD85;
        Fri,  5 Jun 2020 12:49:30 +0000 (UTC)
Message-ID: <400023013d9b53b0f4647909387d844f1a959d09.camel@suse.de>
Subject: Re: [PATCH v3 22/25] clk: bcm: rpi: Give firmware clocks a name
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Fri, 05 Jun 2020 14:49:25 +0200
In-Reply-To: <135a5d32e42d9a117e264f1f52ac9fb6b9dc20e6.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
         <135a5d32e42d9a117e264f1f52ac9fb6b9dc20e6.1590594293.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-6BoIZ1J7R/yVno28uORR"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-6BoIZ1J7R/yVno28uORR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-05-27 at 17:45 +0200, Maxime Ripard wrote:
> We've registered the firmware clocks using their ID as name, but it's muc=
h
> more convenient to register them using their proper name. Since the
> firmware doesn't provide it, we have to duplicate it.
>=20
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/clk/bcm/clk-raspberrypi.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-
> raspberrypi.c
> index 8d3acf3ee053..cee634cb5323 100644
> --- a/drivers/clk/bcm/clk-raspberrypi.c
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -36,6 +36,23 @@ enum rpi_firmware_clk_id {
>  	RPI_FIRMWARE_NUM_CLK_ID,
>  };
> =20
> +static char *rpi_firmware_clk_names[] =3D {
> +	[RPI_FIRMWARE_EMMC_CLK_ID]	=3D "emmc",
> +	[RPI_FIRMWARE_UART_CLK_ID]	=3D "uart",
> +	[RPI_FIRMWARE_ARM_CLK_ID]	=3D "arm",
> +	[RPI_FIRMWARE_CORE_CLK_ID]	=3D "core",
> +	[RPI_FIRMWARE_V3D_CLK_ID]	=3D "v3d",
> +	[RPI_FIRMWARE_H264_CLK_ID]	=3D "h264",
> +	[RPI_FIRMWARE_ISP_CLK_ID]	=3D "isp",
> +	[RPI_FIRMWARE_SDRAM_CLK_ID]	=3D "sdram",
> +	[RPI_FIRMWARE_PIXEL_CLK_ID]	=3D "pixel",
> +	[RPI_FIRMWARE_PWM_CLK_ID]	=3D "pwm",
> +	[RPI_FIRMWARE_HEVC_CLK_ID]	=3D "hevc",
> +	[RPI_FIRMWARE_EMMC2_CLK_ID]	=3D "emmc2",
> +	[RPI_FIRMWARE_M2MC_CLK_ID]	=3D "m2mc",
> +	[RPI_FIRMWARE_PIXEL_BVB_CLK_ID]	=3D "pixel-bvb",
> +};
> +
>  #define RPI_FIRMWARE_STATE_ENABLE_BIT	BIT(0)
>  #define RPI_FIRMWARE_STATE_WAIT_BIT	BIT(1)
> =20
> @@ -343,7 +360,9 @@ static struct clk_hw *raspberrypi_clk_register(struct
> raspberrypi_clk *rpi,
>  	data->rpi =3D rpi;
>  	data->id =3D id;
> =20
> -	init.name =3D devm_kasprintf(rpi->dev, GFP_KERNEL, "fw-clk-%u", id);
> +	init.name =3D devm_kasprintf(rpi->dev, GFP_KERNEL,
> +				   "fw-clk-%s",
> +				   rpi_firmware_clk_names[id]);
>  	init.ops =3D &raspberrypi_firmware_clk_ops;
>  	init.flags =3D CLK_GET_RATE_NOCACHE;
> =20
> @@ -367,8 +386,8 @@ static struct clk_hw *raspberrypi_clk_register(struct
> raspberrypi_clk *rpi,
>  		return ERR_PTR(ret);
>  	}
> =20
> -	dev_info(rpi->dev, "Clock %d frequency range: min %u, max %u\n",
> -		 id, min_rate, max_rate);
> +	dev_info(rpi->dev, "Clock %s frequency range: min %u, max %u\n",
> +		 rpi_firmware_clk_names[id], min_rate, max_rate);

I belive this might change. Otherwise:

Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-6BoIZ1J7R/yVno28uORR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7aP1UACgkQlfZmHno8
x/4I8wf+NnWnFjJw0qH9nDGFXtvQQsS46VYH+/3Yq9GiuXvy1QwmQT9m2+ccW6CJ
tMMkIsE2hJLoi4gO9EZSN5JV1lH0Og/xPxdNmyCn9sGFTIkFIDdM8QMHktC0V79k
wsyq5qNw3WgywB8l9k8EyFls41sLxhi53tI9Qt/DXW7cNr2sx164JVgPCwc4wlO5
WS+5CKWxhQPhLmWWpl0YzB3SnRMQROvu536EDJnjcrf7Y+j8du492UUqLylmIaNz
QkEoR5YInC/jxgdx9o09Jp46D13Exf6frU6vS18ic792fDX4AWhqVMocjdjNcW+K
xE8gA09s5OQ9+K+olo6lL0HBuQtD0Q==
=UER2
-----END PGP SIGNATURE-----

--=-6BoIZ1J7R/yVno28uORR--

