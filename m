Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD9DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02518206E6
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgFENJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:09:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:33974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbgFENJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:09:20 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9086EACAE;
        Fri,  5 Jun 2020 13:09:21 +0000 (UTC)
Message-ID: <ef54a57d7a7475a3e052805d1d1d3cd81e36569d.camel@suse.de>
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
Date:   Fri, 05 Jun 2020 15:09:15 +0200
In-Reply-To: <d8be3a45491224e0c91355131a9bcf605f38fb76.camel@suse.de>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
         <c56fb0a912fe254416ed5a247e6fb6d79fb604bc.1590594293.git-series.maxime@cerno.tech>
         <d8be3a45491224e0c91355131a9bcf605f38fb76.camel@suse.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-zBa+R9/+djnaoJfqzPmm"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zBa+R9/+djnaoJfqzPmm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

On Fri, 2020-06-05 at 14:04 +0200, Nicolas Saenz Julienne wrote:
> On Wed, 2020-05-27 at 17:45 +0200, Maxime Ripard wrote:
> > While the firmware allows us to discover the available clocks, we need =
to
> > discriminate those clocks to only register the ones meaningful to Linux=
.
> > The firmware also doesn't provide a clock name, so having a list of the=
 ID
> > will help us to give clocks a proper name later on.
> >=20
> > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > ---
> >  drivers/clk/bcm/clk-raspberrypi.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-
> > raspberrypi.c
> > index 5f4e2d49432f..eebd16040f8a 100644
> > --- a/drivers/clk/bcm/clk-raspberrypi.c
> > +++ b/drivers/clk/bcm/clk-raspberrypi.c
> > @@ -18,7 +18,23 @@
> > =20
> >  #include <soc/bcm2835/raspberrypi-firmware.h>
> > =20
> > -#define RPI_FIRMWARE_ARM_CLK_ID		0x00000003
> > +enum rpi_firmware_clk_id {
> > +	RPI_FIRMWARE_EMMC_CLK_ID =3D 1,
> > +	RPI_FIRMWARE_UART_CLK_ID,
> > +	RPI_FIRMWARE_ARM_CLK_ID,
> > +	RPI_FIRMWARE_CORE_CLK_ID,
> > +	RPI_FIRMWARE_V3D_CLK_ID,
> > +	RPI_FIRMWARE_H264_CLK_ID,
> > +	RPI_FIRMWARE_ISP_CLK_ID,
> > +	RPI_FIRMWARE_SDRAM_CLK_ID,
> > +	RPI_FIRMWARE_PIXEL_CLK_ID,
> > +	RPI_FIRMWARE_PWM_CLK_ID,
> > +	RPI_FIRMWARE_HEVC_CLK_ID,
> > +	RPI_FIRMWARE_EMMC2_CLK_ID,
> > +	RPI_FIRMWARE_M2MC_CLK_ID,
> > +	RPI_FIRMWARE_PIXEL_BVB_CLK_ID,
> > +	RPI_FIRMWARE_NUM_CLK_ID,
> > +};
> > =20
> >  #define RPI_FIRMWARE_STATE_ENABLE_BIT	BIT(0)
> >  #define RPI_FIRMWARE_STATE_WAIT_BIT	BIT(1)
> > @@ -31,8 +47,6 @@
> > =20
> >  #define A2W_PLL_FRAC_BITS		20
> > =20
> > -#define NUM_FW_CLKS			16
> > -
> >  struct raspberrypi_clk {
> >  	struct device *dev;
> >  	struct rpi_firmware *firmware;
> > @@ -320,7 +334,8 @@ static int raspberrypi_clk_probe(struct platform_de=
vice
> > *pdev)
> >  	rpi->firmware =3D firmware;
> >  	platform_set_drvdata(pdev, rpi);
> > =20
> > -	clk_data =3D devm_kzalloc(dev, struct_size(clk_data, hws, NUM_FW_CLKS=
),
> > +	clk_data =3D devm_kzalloc(dev, struct_size(clk_data, hws,
> > +						 RPI_FIRMWARE_NUM_CLK_ID),
>=20
> nit: you're allocating one structure too many right?

Nevermind this comment, as pointed out privately by Phil Elwell, I forgot t=
he
firmware clk description structure starts at 0. So we need to make space fo=
r
that.

It would maybe make sense to add RPI_FIRMWARE_RESERVED_CLK_ID above the EMM=
C
clk entry. Although it's just a suggestion.

> Acked-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> Regards,
> Nicolas
>=20


--=-zBa+R9/+djnaoJfqzPmm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7aQ/sACgkQlfZmHno8
x/51JAf9E6hIeONQ04AS5nc+CNgytiK5+f+O/3DL9v+pjoI2tV+K+vFz6xZmgfML
ktmejzaCEWThKJfmvNTZutm1MHnBSyXO3osOufF3MIo88zjTj0gZgX3Ls2TinE6N
urPDhetiInbD3Ysl5Buz7KyvIiPWin6H4l5EkPED5hnbftQ8H3WMR8CEknV5BWvM
9NjTmnYfpFpLnCzbV6i2MLPgOXOQ1DHbj7+JIen0Bpt3nOyAs2JTTfIC8jyxG3HS
lEJ1dJiR1Hzw/z0yvysAeYrtUHqDJsgU2Sfj4Mp9ysOB/yzFfKoWBJiJQZaQaShL
Nx5mzSj0jK3TXqxDEwkeOuaYNoBn6w==
=FpmO
-----END PGP SIGNATURE-----

--=-zBa+R9/+djnaoJfqzPmm--

