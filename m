Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39B4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9220206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgFDSC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:02:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:49848 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730055AbgFDSC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:02:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8AD8BAC40;
        Thu,  4 Jun 2020 18:02:27 +0000 (UTC)
Message-ID: <e096d89ab881d69b2477b209838a308f9de114b1.camel@suse.de>
Subject: Re: [PATCH v3 12/25] clk: bcm: rpi: Use CCF boundaries instead of
 rolling our own
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Date:   Thu, 04 Jun 2020 20:02:22 +0200
In-Reply-To: <eb1b2838f1c3c006c24bcb9816f75e1351c63b05.1590594293.git-series.maxime@cerno.tech>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
         <eb1b2838f1c3c006c24bcb9816f75e1351c63b05.1590594293.git-series.maxime@cerno.tech>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-+uejN3Q43Y4PuptNv516"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+uejN3Q43Y4PuptNv516
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2020-05-27 at 17:45 +0200, Maxime Ripard wrote:
> The raspberrypi firmware clock driver has a min_rate / max_rate clamping =
by
> storing the info it needs in a private structure.
>=20
> However, the CCF already provides such a facility, so we can switch to it
> to remove the boilerplate.
>=20
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> ---
>  drivers/clk/bcm/clk-raspberrypi.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-
> raspberrypi.c
> index a20492fade6a..e135ad28d38d 100644
> --- a/drivers/clk/bcm/clk-raspberrypi.c
> +++ b/drivers/clk/bcm/clk-raspberrypi.c
> @@ -36,9 +36,6 @@ struct raspberrypi_clk {
>  	struct rpi_firmware *firmware;
>  	struct platform_device *cpufreq;
> =20
> -	unsigned long min_rate;
> -	unsigned long max_rate;
> -
>  	struct clk_hw pllb;
>  };
> =20
> @@ -142,13 +139,11 @@ static int raspberrypi_fw_pll_set_rate(struct clk_h=
w
> *hw, unsigned long rate,
>  static int raspberrypi_pll_determine_rate(struct clk_hw *hw,
>  					  struct clk_rate_request *req)
>  {
> -	struct raspberrypi_clk *rpi =3D container_of(hw, struct raspberrypi_clk=
,
> -						   pllb);
>  	u64 div, final_rate;
>  	u32 ndiv, fdiv;
> =20
>  	/* We can't use req->rate directly as it would overflow */
> -	final_rate =3D clamp(req->rate, rpi->min_rate, rpi->max_rate);
> +	final_rate =3D clamp(req->rate, req->min_rate, req->max_rate);
> =20
>  	div =3D (u64)final_rate << A2W_PLL_FRAC_BITS;
>  	do_div(div, req->best_parent_rate);
> @@ -215,12 +210,15 @@ static int raspberrypi_register_pllb(struct
> raspberrypi_clk *rpi)
>  	dev_info(rpi->dev, "CPU frequency range: min %u, max %u\n",
>  		 min_rate, max_rate);
> =20
> -	rpi->min_rate =3D min_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
> -	rpi->max_rate =3D max_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
> -
>  	rpi->pllb.init =3D &init;
> =20
> -	return devm_clk_hw_register(rpi->dev, &rpi->pllb);
> +	ret =3D devm_clk_hw_register(rpi->dev, &rpi->pllb);
> +	if (!ret)
> +		clk_hw_set_rate_range(&rpi->pllb,
> +				      min_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE,
> +				      max_rate *
> RPI_FIRMWARE_PLLB_ARM_DIV_RATE);

Isn't there a potential race here? Albeit unlikely, cpufreq could show up a=
nd
call clk_round_rate() in between the registration and you setting the range=
s.

Regards,
Nicolas



--=-+uejN3Q43Y4PuptNv516
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7ZNy4ACgkQlfZmHno8
x/6rLgf+MI7j31eml7V9G28ZgJulg/9yfgQn1humlrU63+IKDhYbogSdbp7/hVJz
YdQSu0b7LXKltV1XmIB7582ieZxBsAK4nKSmqVq+D2VoEOIm6KgBuFWW/WXIwDS3
DPavaLSEHlNX/o+9w80P+oQ96HNJszg4n1Nu+1ZpffG51Y/0E8H2s+UNgrZlrRO4
MYrpfeN0ywrH7euU3T9XSdsJ9H3HwAAj/Osp1Y8P8KcJxBE7vLN3GOqtpMjKReha
DjtcypqZ1L0chi+C/Nu692yPOMrVjFeYkpLex7GyhWmLe84KRXDFrG0kK5o9c8S5
j3HLs/hWF7eqO7D/oOKImGbf/nSM9A==
=57iT
-----END PGP SIGNATURE-----

--=-+uejN3Q43Y4PuptNv516--

