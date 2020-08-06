Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529E3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D441206A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgHFTIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:08:44 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:35468 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFTIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:08:44 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id EB4271C0BD2; Thu,  6 Aug 2020 21:08:40 +0200 (CEST)
Date:   Thu, 6 Aug 2020 21:08:40 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     Grant Feng <von81@163.com>, jacek.anaszewski@gmail.com,
        robh+dt@kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] leds: is31fl319x: Add sdb pin and generate a 5ms low
 pulse when startup
Message-ID: <20200806190840.zyovbkqgr2ey7rd6@duo.ucw.cz>
References: <20200806062130.25187-1-von81@163.com>
 <7c828160-bef6-45b5-60d1-85c6074953c4@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="bbh4x4visauhrnzh"
Content-Disposition: inline
In-Reply-To: <7c828160-bef6-45b5-60d1-85c6074953c4@ti.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bbh4x4visauhrnzh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!
> On 8/6/20 1:21 AM, Grant Feng wrote:
> > generate a 5ms low pulse on sdb pin when startup, then the chip
> > becomes more stable in the complex EM environment.
> >=20
> > Signed-off-by: Grant Feng <von81@163.com>
> > ---
> >   drivers/leds/leds-is31fl319x.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >=20
> > diff --git a/drivers/leds/leds-is31fl319x.c b/drivers/leds/leds-is31fl3=
19x.c
> > index ca6634b8683c..b4f70002cec9 100644
> > --- a/drivers/leds/leds-is31fl319x.c
> > +++ b/drivers/leds/leds-is31fl319x.c
> > @@ -16,6 +16,8 @@
> >   #include <linux/of_device.h>
> >   #include <linux/regmap.h>
> >   #include <linux/slab.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> >   /* register numbers */
> >   #define IS31FL319X_SHUTDOWN		0x00
> > @@ -61,6 +63,7 @@
> >   struct is31fl319x_chip {
> >   	const struct is31fl319x_chipdef *cdef;
> >   	struct i2c_client               *client;
> > +	struct gpio_desc		*sdb_pin;
> >   	struct regmap                   *regmap;
> >   	struct mutex                    lock;
> >   	u32                             audio_gain_db;
> > @@ -265,6 +268,15 @@ static int is31fl319x_parse_dt(struct device *dev,
> >   		is31->audio_gain_db =3D min(is31->audio_gain_db,
> >   					  IS31FL319X_AUDIO_GAIN_DB_MAX);
> > +	is31->sdb_pin =3D gpiod_get(dev, "sdb", GPIOD_ASIS);
>=20
> Since this is optional maybe use devm_gpiod_get_optional.
>=20
> If this is required for stability then if the GPIO is not present then the
> parse_dt should return the error.
>=20
> And use the devm_gpiod_get call.=A0 Otherwise you are missing the gpiod_p=
ut
> when exiting or removing the driver.

Yep, thanks for the review, I dropped it from for-next.

And yes, this should be in series with device tree change, and we need
Rob 's ack.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--bbh4x4visauhrnzh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXyxVOAAKCRAw5/Bqldv6
8mvbAJ46DdLOlQpYoIX7cBpeV+MXqJF7sACgjhIt85JkN1o3CwQpzvbS95S9rWo=
=MLCx
-----END PGP SIGNATURE-----

--bbh4x4visauhrnzh--
