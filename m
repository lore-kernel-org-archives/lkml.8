Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C210C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB9C206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730286AbgFDRuq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:50:46 -0400
Received: from mx2.suse.de ([195.135.220.15]:46818 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730055AbgFDRup (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:50:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EC828B145;
        Thu,  4 Jun 2020 17:50:46 +0000 (UTC)
Message-ID: <47efdefe8873d8907ea20aa7f3ba025227ee3699.camel@suse.de>
Subject: Re: [PATCH v3 03/25] firmware: rpi: Only create clocks device if we
 don't have a node for it
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org
Date:   Thu, 04 Jun 2020 19:50:42 +0200
In-Reply-To: <f0b979221dedec7db9cab201388bf44c0d987a3d.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
         <f0b979221dedec7db9cab201388bf44c0d987a3d.1590594293.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-dbG+zekS2b9Psb4A2LAz"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-dbG+zekS2b9Psb4A2LAz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-05-27 at 17:44 +0200, Maxime Ripard wrote:
> The firmware clocks driver was previously probed through a platform_devic=
e
> created by the firmware driver.
>=20
> Since we will now have a node for that clocks driver, we need to create t=
he
> device only in the case where there's no node for it already.
>=20
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas

>  drivers/firmware/raspberrypi.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberryp=
i.c
> index ef8098856a47..b25901a77c09 100644
> --- a/drivers/firmware/raspberrypi.c
> +++ b/drivers/firmware/raspberrypi.c
> @@ -208,6 +208,20 @@ rpi_register_hwmon_driver(struct device *dev, struct
> rpi_firmware *fw)
> =20
>  static void rpi_register_clk_driver(struct device *dev)
>  {
> +	struct device_node *firmware;
> +
> +	/*
> +	 * Earlier DTs don't have a node for the firmware clocks but
> +	 * rely on us creating a platform device by hand. If we do
> +	 * have a node for the firmware clocks, just bail out here.
> +	 */
> +	firmware =3D of_get_compatible_child(dev->of_node,
> +					   "raspberrypi,firmware-clocks");
> +	if (firmware) {
> +		of_node_put(firmware);
> +		return;
> +	}
> +
>  	rpi_clk =3D platform_device_register_data(dev, "raspberrypi-clk",
>  						-1, NULL, 0);
>  }


--=-dbG+zekS2b9Psb4A2LAz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7ZNHIACgkQlfZmHno8
x/4/+Qf+KoDl73XDh5SQOyDp+euseA0GBAbtp3C2cPcPRD4caDDDoNq+9Qx6HvjI
5dFfT4xdFV8Yyt9WXBFKJ3cWrJ8ubxes1FksaHAaAel7F8yiH4KS7iCm2A0DIW2P
fQMlPSyuSYCd5JpvBBoKxRzaMqkzY8QclpbDwLWhTOu06h1vBQR+YiulI4RdPVxe
r4payGStM+QYVGW+RmNv+XbtljaO5ELGf001cS5rCjuDsbfkQz+pdKvA2HbW6rIy
gPxDIgznfjTur/h/T7grnHXePiXvrMhleHdHA2ISs6b6/Hb0uhimPjKqO4EIRGaz
utM1xP1bhKzZgVW9YJyIjTIj/7E8xw==
=5Iyd
-----END PGP SIGNATURE-----

--=-dbG+zekS2b9Psb4A2LAz--

