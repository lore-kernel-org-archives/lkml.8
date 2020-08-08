Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF039C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 10:32:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D301D20748
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 10:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgHHKcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 06:32:43 -0400
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:32987 "EHLO
        6.mo2.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725980AbgHHKcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 06:32:43 -0400
X-Greylist: delayed 12593 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Aug 2020 06:32:41 EDT
Received: from player692.ha.ovh.net (unknown [10.110.171.30])
        by mo2.mail-out.ovh.net (Postfix) with ESMTP id 7AA611E22E2
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 08:53:43 +0200 (CEST)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player692.ha.ovh.net (Postfix) with ESMTPSA id B7F0014F99554;
        Sat,  8 Aug 2020 06:53:36 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-105G00604a03001-07ae-404f-8b1c-e8e00fea8c5d,
                    79D32C5DBA076DF52B56DF0DE49DD07428F72CA9) smtp.auth=steve@sk2.org
Date:   Sat, 8 Aug 2020 08:53:29 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH v3] hwmon/pmbus: use simple i2c probe function
Message-ID: <20200808085329.4713bf38@heffalump.sk2.org>
In-Reply-To: <20200807210707.7dd1d9b9@heffalump.sk2.org>
References: <20200807173231.GA47449@roeck-us.net>
        <20200807210707.7dd1d9b9@heffalump.sk2.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 boundary="Sig_/y.bcllr/2+vwSjXRyoFtyXy"; protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 5473843875180530958
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkeefgdduudefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeevledvueefvdeivefftdeugeekveethefftdffteelheejkeejjeduffeiudetkeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelvddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/y.bcllr/2+vwSjXRyoFtyXy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Aug 2020 21:07:07 +0200, Stephen Kitt <steve@sk2.org> wrote:

> On Fri, 7 Aug 2020 10:32:31 -0700, Guenter Roeck <linux@roeck-us.net> wro=
te:
> > On Fri, Aug 07, 2020 at 06:28:01PM +0200, Stephen Kitt wrote: =20
> > > =20
> > > -static int ltc2978_probe(struct i2c_client *client,
> > > -			 const struct i2c_device_id *id)
> > > +static int ltc2978_probe(struct i2c_client *client)
> > >  {
> > >  	int i, chip_id;
> > >  	struct ltc2978_data *data;
> > > @@ -670,10 +669,10 @@ static int ltc2978_probe(struct i2c_client
> > > *client, return chip_id;
> > > =20
> > >  	data->id =3D chip_id;
> > > -	if (data->id !=3D id->driver_data)
> > > +	if (strcmp(client->name, ltc2978_id[data->id].name) !=3D 0)   =20
> >=20
> > I was about to apply this patch, but this is problematic: It assumes th=
at
> > __stringify(id) =3D=3D ltc2978_id[id].name and that ltc2978_id[id].driv=
er_data
> > =3D=3D id. While that is curently the case (as far as I can see), it is=
 still
> > unsafe. I think it would be much safer to use i2c_match_id() here. =20
>=20
> I=E2=80=99m not following the __stringify assumption
[...]

I get it, the code assumes there=E2=80=99s a bijection between the set of n=
ames and
the set of driver_data values. So effectively we can=E2=80=99t log the dete=
cted name
based on the chip_id...

Regards,

Stephen

--Sig_/y.bcllr/2+vwSjXRyoFtyXy
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAl8uS+kACgkQgNMC9Yht
g5xIzxAAlaUtrB0ITq9gTE6oXUQv1bI/nUA7jM0Th2HsVOEjUDr6TOT/RatMscfk
gRywHUPfPLczg0fbt5oYLN8F+laBkYE8gdhurUqalS5AC2YgnBraooAXRDWd7bux
hCGkkwoP8jdV3wg5FDwdsE+WeUzCOKcy0oO25MSgFsAnb9xcj7Q7EI0GQE0HsKL+
AopKclYJjpnI4micMOXkTsxjtFthCt9U2BTxQ7O4ehy0ENiDDuVw+S5PfIXlcu3r
aXXv4onAgRJSWRbLQ93pMAyd4DKXl5lY9duhQbyALlZIB9svpOkvL8xd4F3RQAeV
Bo45bMV1LDmBlkc5IU6NREHW2xFnSL4xjM3evJ9Wb0h7QoI3QmhvJC363nNKJ2kK
60nDefPvLiYIFIm7L0Ym0uRSc+4sLJpSZLWL+fGYaHa2hKWmcdnDih/aT6i1/jsc
GDxHiaigPZwqlui/ehI8VZkuuN5skrMMpidle7sZZbp0Gf0dwdtMegYd07Oye+pK
o1yJp8mMwPEdJ31oi+O7ra8NWcEBDVW0jSFUck/V8WeOqSkArvEsm+K8BxaRoz58
b8nimZKFSnLfIybE4uPSYGOnSfrjRCmNwqDQe3gFagcHUFvsqmE46gls5uhlia96
RkqBwvQ0R+DY0CbV4FUXY0Qyxm0gVHuunKgO5GZcoiGihqrdAgs=
=aVzI
-----END PGP SIGNATURE-----

--Sig_/y.bcllr/2+vwSjXRyoFtyXy--
