Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F1EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0652A20739
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 17:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgFQRak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 13:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgFQRak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 13:30:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5E1C061755
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 10:30:40 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jlbtR-00074W-BJ; Wed, 17 Jun 2020 19:30:33 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jlbtP-00036W-Nq; Wed, 17 Jun 2020 19:30:31 +0200
Date:   Wed, 17 Jun 2020 19:30:31 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Guru Das Srinagesh <gurus@codeaurora.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] video: ssd1307fb: Print PWM period using 64-bit
 format specifier
Message-ID: <20200617173031.tzzpzihcxtf4e6t6@taurus.defre.kleine-koenig.org>
References: <20200615141606.2814208-1-thierry.reding@gmail.com>
 <20200615141606.2814208-2-thierry.reding@gmail.com>
 <CAMuHMdWaKgNOz02eVXkFnGRpsjdNNGVtuCf0setigH31-9aXQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rxl2imxmh4ztjdin"
Content-Disposition: inline
In-Reply-To: <CAMuHMdWaKgNOz02eVXkFnGRpsjdNNGVtuCf0setigH31-9aXQg@mail.gmail.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rxl2imxmh4ztjdin
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2020 at 09:18:34AM +0200, Geert Uytterhoeven wrote:
> Hi Thierry,
>=20
> On Mon, Jun 15, 2020 at 4:17 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> > The PWM core will soon change the duty cycle and period of PWMs to 64
> > bits to allow for a broader range of values. Use a 64-bit format
> > specifier to avoid a warning when that change is made.
> >
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
>=20
> > --- a/drivers/video/fbdev/ssd1307fb.c
> > +++ b/drivers/video/fbdev/ssd1307fb.c
> > @@ -312,7 +312,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
> >                 /* Enable the PWM */
> >                 pwm_enable(par->pwm);
> >
> > -               dev_dbg(&par->client->dev, "Using PWM%d with a %dns per=
iod.\n",
> > +               dev_dbg(&par->client->dev, "Using PWM%d with a %lluns p=
eriod.\n",
> >                         par->pwm->pwm, pwm_get_period(par->pwm));
> >         }
>=20
> This change must be done together with changing the return type of
> pwm_get_period(), else you will get a compiler warning, and will print a
> bogus value.

Right, or we must change to passing (unsigned long
long)pwm_get_period(par->pwm), then change the prototype and then drop
the cast again.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--rxl2imxmh4ztjdin
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl7qUzQACgkQwfwUeK3K
7Al5CggAh8+r0Y0C/ThEZNWlCxMmhx0L8XAMh5KCzFqGs4RtUTs/gCzwKDD13y1o
YOA7JbWwL44I06iFwXbFpYcEbnRR8Id9ZWsTjNQ9tdAyqu69Ms675Rcl+BOIAWtZ
RZoc0OUnFc2JxTDUMomnk+lPNNqELa8U/MX6ipDfXFhKYOv83XI0/9Ili3yknjfO
tl6couylxCAO7zcLoG6WEHXAjj+nHmtTTshlrNEg0yeLsrmGPVZX+QNwkR04nuiP
CPe63DiY6BtaWhW9tsZ9BD0y2lio1SYHrQeb1t5eLpf52dk0SXl0hzAUOb1e8TS4
C6vvvqC7ecm1+rPBEBDiW2479HVP4w==
=laBW
-----END PGP SIGNATURE-----

--rxl2imxmh4ztjdin--
