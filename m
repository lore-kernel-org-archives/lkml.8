Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0370C54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0ECE20675
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 11:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgELLbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 07:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgELLbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:31:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A800C061A0C;
        Tue, 12 May 2020 04:31:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id B27BB2A208B
Received: by earth.universe (Postfix, from userid 1000)
        id 18C513C08C6; Tue, 12 May 2020 13:31:28 +0200 (CEST)
Date:   Tue, 12 May 2020 13:31:28 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Jean Delvare <jdelvare@suse.com>,
        Lee Jones <lee.jones@linaro.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Samu Nuutamo <samu.nuutamo@vincit.fi>
Subject: Re: [PATCH] hwmon: da9052: Synchronize access with mfd
Message-ID: <20200512113128.yfg2vihkbbg3f762@earth.universe>
References: <20200511110219.68188-1-sebastian.reichel@collabora.com>
 <930d27f3-46f8-2e7a-5028-b593f4fe84a3@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dtasy64h7n6tklmq"
Content-Disposition: inline
In-Reply-To: <930d27f3-46f8-2e7a-5028-b593f4fe84a3@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dtasy64h7n6tklmq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Mon, May 11, 2020 at 09:51:25AM -0700, Guenter Roeck wrote:
> On 5/11/20 4:02 AM, Sebastian Reichel wrote:
> > From: Samu Nuutamo <samu.nuutamo@vincit.fi>
> >=20
> > When tsi-as-adc is configured it is possible for in7[0123]_input read to
> > return an incorrect value if a concurrent read to in[456]_input is
> > performed. This is caused by a concurrent manipulation of the mux
> > channel without proper locking as hwmon and mfd use different locks for
> > synchronization.
> >=20
> > Switch hwmon to use the same lock as mfd when accessing the TSI channel.
> >=20
> > Fixes: 4f16cab19a3d5 ("hwmon: da9052: Add support for TSI channel")
> > Signed-off-by: Samu Nuutamo <samu.nuutamo@vincit.fi>
> > [rebase to current master, reword commit message slightly]
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
>=20
> Have you explored calling da9052_adc_manual_read() instead ?
> At the very least we should have a comment explaining why that
> isn't feasible.

da9052_adc_manual_read() writes to DA9052_ADC_MAN_REG, waits for an
IRQ and then reads DA9052_ADC_RES_H_REG/DA9052_ADC_RES_L_REG. The
function called here works with the TSI registers instead. So
calling da9052_adc_manual_read() is not an option.

The reason for the locking problem is, that the same ADC is used
internally by the devices and muxed to different pins in the
background. In continuous touchscreen mode, the device is supposed
to schedule the ADC slots automatically and I assumed this would
also work here when I wrote the original support. Turns out the
device is not smart enough for that :(

-- Sebastian

> Thanks,
> Guenter
>=20
> > ---
> >  drivers/hwmon/da9052-hwmon.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/hwmon/da9052-hwmon.c b/drivers/hwmon/da9052-hwmon.c
> > index 53b517dbe7e6..4af2fc309c28 100644
> > --- a/drivers/hwmon/da9052-hwmon.c
> > +++ b/drivers/hwmon/da9052-hwmon.c
> > @@ -244,9 +244,9 @@ static ssize_t da9052_tsi_show(struct device *dev,
> >  	int channel =3D to_sensor_dev_attr(devattr)->index;
> >  	int ret;
> > =20
> > -	mutex_lock(&hwmon->hwmon_lock);
> > +	mutex_lock(&hwmon->da9052->auxadc_lock);
> >  	ret =3D __da9052_read_tsi(dev, channel);
> > -	mutex_unlock(&hwmon->hwmon_lock);
> > +	mutex_unlock(&hwmon->da9052->auxadc_lock);
> > =20
> >  	if (ret < 0)
> >  		return ret;
> >=20
>=20

--dtasy64h7n6tklmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl66iQIACgkQ2O7X88g7
+poUkA//ZgeIB40UjFCzLiTemGNhHPVyrtf8oWt8lbrYknJ4dR1sYcJv5po+wA0b
hEniRGKcaqKlUdRRN9YTIdjjYimp//z61eUoqG3emWuL0GW25uISxrqtTwRsh6PL
+C1WjME1D8DANK7pzLA7vnUoUc7q12sKIWacMi7r/rTrSjALA+YGTrru+BmO13Af
BZEljnxZ40B236svT+e9mzVMRdoHaxb+CKPQVtzh9v5uhhx1OjYEkeKNe9D5zv3M
GQAEMw8YWB/lEoXu8rWHYqghku5iESUEMdTid7+cwRSo33M3Uf4u/ZtxGwGYnYkq
Xa2v9OfR9btNH4pbWcEO54UE4hW5BTFALiXmC+w4MVqacWKs2OszrS4VuAaMmrRc
Cn1QCIsrGPYPtn5kwDs1qDqd0xlk+NuEoufvp7ywNTxtrsRbsDk4gsSf+g2nEpeC
qR3MuikW/eewUl3E5LoLRH/11oA09oWvZQfgF8T2c1IGq7uf+cU9r+g94L2DiXWb
wzu4aBH3udoNmQZn1G42VADgPoHahl1tr/FwypxOg0bQe6FfqfWAwdM3wHHy7E2h
mBLWSC0oZSXB3JESsI/2SvnqL2/IWiuORrDHRlwY3gG+9hfUCTScNHmeEUd24VtZ
poGaUJvKqhQqh3DQaV/CZDBgILa8YDxDSer5Elpb6mB8syQEhs4=
=Vq5Y
-----END PGP SIGNATURE-----

--dtasy64h7n6tklmq--
