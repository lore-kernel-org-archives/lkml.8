Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F26F1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BC320772
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 09:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgFEJeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 05:34:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:47434 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726188AbgFEJeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 05:34:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 29C5EAD1A;
        Fri,  5 Jun 2020 09:34:11 +0000 (UTC)
Message-ID: <99eb84154ef837832d872e05f4c6323908cdf456.camel@suse.de>
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
Date:   Fri, 05 Jun 2020 11:34:05 +0200
In-Reply-To: <20200605092802.xkoazjnin7xyqkoy@gilmour.lan>
References: <cover.662a8d401787ef33780d91252a352de91dc4be10.1590594293.git-series.maxime@cerno.tech>
         <eb1b2838f1c3c006c24bcb9816f75e1351c63b05.1590594293.git-series.maxime@cerno.tech>
         <e096d89ab881d69b2477b209838a308f9de114b1.camel@suse.de>
         <20200605092802.xkoazjnin7xyqkoy@gilmour.lan>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-cb1rk5pgqkytLeD/HsnD"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cb1rk5pgqkytLeD/HsnD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-06-05 at 11:28 +0200, Maxime Ripard wrote:
> Hi Nicolas,
>=20
> On Thu, Jun 04, 2020 at 08:02:22PM +0200, Nicolas Saenz Julienne wrote:
> > On Wed, 2020-05-27 at 17:45 +0200, Maxime Ripard wrote:
> > > The raspberrypi firmware clock driver has a min_rate / max_rate clamp=
ing
> > > by
> > > storing the info it needs in a private structure.
> > >=20
> > > However, the CCF already provides such a facility, so we can switch t=
o it
> > > to remove the boilerplate.
> > >=20
> > > Signed-off-by: Maxime Ripard <maxime@cerno.tech>
> > > ---
> > >  drivers/clk/bcm/clk-raspberrypi.c | 18 ++++++++----------
> > >  1 file changed, 8 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-
> > > raspberrypi.c
> > > index a20492fade6a..e135ad28d38d 100644
> > > --- a/drivers/clk/bcm/clk-raspberrypi.c
> > > +++ b/drivers/clk/bcm/clk-raspberrypi.c
> > > @@ -36,9 +36,6 @@ struct raspberrypi_clk {
> > >  	struct rpi_firmware *firmware;
> > >  	struct platform_device *cpufreq;
> > > =20
> > > -	unsigned long min_rate;
> > > -	unsigned long max_rate;
> > > -
> > >  	struct clk_hw pllb;
> > >  };
> > > =20
> > > @@ -142,13 +139,11 @@ static int raspberrypi_fw_pll_set_rate(struct c=
lk_hw
> > > *hw, unsigned long rate,
> > >  static int raspberrypi_pll_determine_rate(struct clk_hw *hw,
> > >  					  struct clk_rate_request *req)
> > >  {
> > > -	struct raspberrypi_clk *rpi =3D container_of(hw, struct raspberrypi=
_clk,
> > > -						   pllb);
> > >  	u64 div, final_rate;
> > >  	u32 ndiv, fdiv;
> > > =20
> > >  	/* We can't use req->rate directly as it would overflow */
> > > -	final_rate =3D clamp(req->rate, rpi->min_rate, rpi->max_rate);
> > > +	final_rate =3D clamp(req->rate, req->min_rate, req->max_rate);
> > > =20
> > >  	div =3D (u64)final_rate << A2W_PLL_FRAC_BITS;
> > >  	do_div(div, req->best_parent_rate);
> > > @@ -215,12 +210,15 @@ static int raspberrypi_register_pllb(struct
> > > raspberrypi_clk *rpi)
> > >  	dev_info(rpi->dev, "CPU frequency range: min %u, max %u\n",
> > >  		 min_rate, max_rate);
> > > =20
> > > -	rpi->min_rate =3D min_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
> > > -	rpi->max_rate =3D max_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE;
> > > -
> > >  	rpi->pllb.init =3D &init;
> > > =20
> > > -	return devm_clk_hw_register(rpi->dev, &rpi->pllb);
> > > +	ret =3D devm_clk_hw_register(rpi->dev, &rpi->pllb);
> > > +	if (!ret)
> > > +		clk_hw_set_rate_range(&rpi->pllb,
> > > +				      min_rate * RPI_FIRMWARE_PLLB_ARM_DIV_RATE,
> > > +				      max_rate *
> > > RPI_FIRMWARE_PLLB_ARM_DIV_RATE);
> >=20
> > Isn't there a potential race here? Albeit unlikely, cpufreq could show
> > up and call clk_round_rate() in between the registration and you
> > setting the ranges.
>=20
> IIRC, driver's probe are not called in parallel but in sequence, so we
> should be covered here.

Right, of course.

Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

Regards,
Nicolas


--=-cb1rk5pgqkytLeD/HsnD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7aEY0ACgkQlfZmHno8
x/4umQf/Uc3QL2xEaD4EW/hr8XDzlJ9lGMJ5F7R36Z4DMXaYoZQD5qNeZDiOiHuy
rvo5pwHIJMC4Pxl14Rpc9R8CThc0PoNyEFmC8fQFSILD/iQq67YDh2HvURg0klGi
1FPDbDkLboH757AN1ghsHDP38gYPehhyeCL//HcDuHYgFbFzhtC4T5+dF/4C9GBK
pD3NaQlkfKFuPEjkMOhKOI0oWgYprzuDG9LUQgUOXpkexsJkMzTng8PqidhgGreM
eQPpFeMBn/wd9TYtyGSBYIKzvCeTu73BrALg8hOtrioSRXMwnrm/eSygEwvc8ehQ
Em1ViGFL7VnKAbT1tAMZckefzadfxA==
=gAK7
-----END PGP SIGNATURE-----

--=-cb1rk5pgqkytLeD/HsnD--

