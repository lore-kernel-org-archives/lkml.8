Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F16C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 14:43:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E5D720885
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 14:43:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgGDOnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 10:43:24 -0400
Received: from orion.archlinux.org ([88.198.91.70]:54230 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDOnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 10:43:24 -0400
Received: from orion.archlinux.org (localhost [127.0.0.1])
        by orion.archlinux.org (Postfix) with ESMTP id 860851D3582663;
        Sat,  4 Jul 2020 14:43:21 +0000 (UTC)
Received: from centaurus (unknown [37.189.45.160])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ffy00)
        by orion.archlinux.org (Postfix) with ESMTPSA;
        Sat,  4 Jul 2020 14:43:20 +0000 (UTC)
Message-ID: <908bf287f370a947e60bc7817b395c91c5be63d9.camel@archlinux.org>
Subject: Re: [PATCH v2] HID: logitech-hidpp: add support for Logitech G533
 headset
From:   Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
To:     Kamil =?UTF-8?Q?Doma=C5=84ski?= <kamil@domanski.co>,
        linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
In-Reply-To: <52609283-6d37-9e0e-be24-7df378e4fead@domanski.co>
References: <023148f582cc20bef7079508ce417c8ebeb0febb.camel@domanski.co>
         <137acb00c6ec098d7506901df05067e8d7207aa9.camel@archlinux.org>
         <52609283-6d37-9e0e-be24-7df378e4fead@domanski.co>
Organization: Archlinux
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-pGP/VXSr2cqvTSWNfpQw"
Date:   Sat, 04 Jul 2020 15:48:30 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.36.4 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-pGP/VXSr2cqvTSWNfpQw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 2020-07-04 at 02:37 +0200, Kamil Doma=C5=84ski wrote:
> Hi Filipe,
>=20
> > My main point here is that long means different things in different
> > architectures, and we only want one byte so I would go for u8.
>=20
> I used long, because the test_bit macro accepts long and the similar
> function for voltage reading already used long too.
> That will be changed in v3 - see next paragraph.

The compiler can handle these conversions. Explicit is generally better
than implicit, and in cases where the implicit assumptions might break,
explicit is definitely better. We know the data size, so let's use it
:D

> > > +
> > > +	*voltage =3D get_unaligned_be16(data);
> > > +	isConnected =3D test_bit(0, &flags);
> > > +	isCharging =3D test_bit(1, &flags);
> > > +	chargingComplete =3D test_bit(2, &flags);
> > > +	chargingFault =3D test_bit(3, &flags);
> > > I don't think this is needed, just do it in the ifs directly.
> > >=20
> > > Here I would add a #define for each bit:
> > >=20
> > > #define FLAG_ADC_MAP_STATUS_CONNECTED 0
> > > ...
> > > if (data[2] & FLAG_ADC_MAP_STATUS_CONNECTED)
>=20
> Yeah, I it will do exactly that for v3, which allows to drop the flag
> variables and avoid using a long.
>=20
> =20
> > Same thing here. We should see if the device supports the DJ protocol
> > and add it in hid-logitech-dj instead.
>=20
> It doesn't seem to be a DJ device. The DJ driver just detects the extra i=
nterfaces
> and skips directly to hid_hw_start.

Thanks for looking into this!

Cheers,
Filipe La=C3=ADns

--=-pGP/VXSr2cqvTSWNfpQw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAl8AlrcACgkQ+JPGdIFq
qV0C7g//ak1uA7fSG2ruS8LAvg6Fgy1qtvBPvL54Vs9qFZL+pgilwBidZawahYVs
48MoS+U2nLLCyjWRtceEFJNDOa0if2aW1V+M1SRHKdf6XhVZ2xHDKxYUk7GAu7Vp
J0Y9kObMSXNdd4EgUT/n+Dta+9W90UsITIBKpkPQmk0lMGlQI0eONT8oqGqDtSZv
RJV6GwNjX8fIhTiHhLgl4UeN5boLumFNpM13RGO2+wpvDLUTvaIZRXYcRjPgm/yr
lb+iqVfKLH50BV5G3yKkEyG8wythxq9+a1FWEBCKHYmalPQX3ZXFGnW17GOozTYj
OJjWJk3s1esBdK6B30h/lGX+n9ItaxcBz0k4SenepLTPdffZaItRrkbqCBbkjX5l
91yzwi8FwtVVYdRBPUuNMtMNvqflMg+lsNyfP2iWzxGHl7FQcyaTmR7J/BKYXu+7
LpaA7o3Qv6LY7s7prle73EvoyXGS6GW17O1HxWm1k0cX+UD4w6TPnA0ljbdA9roe
EaIG0SPr53yS+pyzNGKl3Sf96WZZVcrgtB+sPo5o7hi+y+T53KgQLWvQBLAT7cF4
rh3+pC6tmWAaPurdq5lABbdGkAlyGloyUMB3mLDj6p2wJvUUcMJpwvURqtsXKRn3
GkTA5yaLZcvwpfmMEYuZrcMvYhvmlzV4GlmeX+fRqpS7Pmjj50g=
=1+tX
-----END PGP SIGNATURE-----

--=-pGP/VXSr2cqvTSWNfpQw--
