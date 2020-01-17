Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A902C33CB3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F72220728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 19:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgAQTPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 14:15:22 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43116 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbgAQTPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 14:15:22 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id E61DA2949D0
Received: by earth.universe (Postfix, from userid 1000)
        id 118AC3C0C7E; Fri, 17 Jan 2020 20:15:18 +0100 (CET)
Date:   Fri, 17 Jan 2020 20:15:17 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFT PATCH 0/4] hwmon: k10temp driver improvements
Message-ID: <20200117191517.pp4vqzkectju4mnd@earth.universe>
References: <20200116141800.9828-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="m77cbq6inhnra5di"
Content-Disposition: inline
In-Reply-To: <20200116141800.9828-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--m77cbq6inhnra5di
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 16, 2020 at 06:17:56AM -0800, Guenter Roeck wrote:
> This patch series implements various improvements for the k10temp driver.
>=20
> Patch 1/4 introduces the use of bit operations.
>=20
> Patch 2/4 converts the driver to use the devm_hwmon_device_register_with_=
info
> API. This not only simplifies the code and reduces its size, it also
> makes the code easier to maintain and enhance.=20
>=20
> Patch 3/4 adds support for reporting Core Complex Die (CCD) temperatures
> on Ryzen 3 (Zen2) CPUs.
>=20
> Patch 4/4 adds support for reporting core and SoC current and voltage
> information on Ryzen CPUs.
>=20
> With all patches in place, output on Ryzen 3900 CPUs looks as follows
> (with the system under load).
>=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:        +1.36 V
> Vsoc:         +1.18 V
> Tdie:         +86.8=B0C  (high =3D +70.0=B0C)
> Tctl:         +86.8=B0C
> Tccd1:        +80.0=B0C
> Tccd2:        +81.8=B0C
> Icore:       +44.14 A
> Isoc:        +13.83 A
>=20
> The patch series has only been tested with Ryzen 3900 CPUs. Further test
> coverage will be necessary before the changes can be applied to the Linux
> kernel.

Looks ok on 3800X (idle):

$ lscpu | grep "Model name"
Model name:                      AMD Ryzen 7 3800X 8-Core Processor
$ sensors "k10temp-*"
k10temp-pci-00c3
Adapter: PCI adapter
Vcore:       937.00 mV=20
Vsoc:          1.01 V =20
Tdie:         +35.2=B0C  (high =3D +70.0=B0C)
Tctl:         +35.2=B0C =20
Tccd1:        +35.8=B0C =20
Icore:         4.61 A =20
Isoc:          6.18 A =20

And after compiling the kernel with 32 threads for 1 minute:

$ sensors "k10temp-*"=20
k10temp-pci-00c3
Adapter: PCI adapter
Vcore:         1.29 V =20
Vsoc:          1.01 V =20
Tdie:         +77.1=B0C  (high =3D +70.0=B0C)
Tctl:         +77.1=B0C =20
Tccd1:        +78.8=B0C =20
Icore:        39.53 A =20
Isoc:          6.18 A =20

Board Information during the idle check:

$ sudo dmidecode -s system-manufacturer
Gigabyte Technology Co., Ltd.
$ sudo dmidecode -s system-product-name
X570 AORUS ULTRA
$ sensors "it8792-*"
it8792-isa-0a60
Adapter: ISA adapter
in0:           1.79 V  (min =3D  +0.00 V, max =3D  +2.78 V)
in1:         589.00 mV (min =3D  +0.00 V, max =3D  +2.78 V)
in2:         981.00 mV (min =3D  +0.00 V, max =3D  +2.78 V)
+3.3V:         1.68 V  (min =3D  +0.00 V, max =3D  +2.78 V)
in4:           1.79 V  (min =3D  +0.00 V, max =3D  +2.78 V)
in5:           1.18 V  (min =3D  +0.00 V, max =3D  +2.78 V)
in6:           2.78 V  (min =3D  +0.00 V, max =3D  +2.78 V)  ALARM
3VSB:          1.68 V  (min =3D  +0.00 V, max =3D  +2.78 V)
Vbat:          1.61 V =20
fan1:           0 RPM  (min =3D    0 RPM)
fan2:           0 RPM  (min =3D    0 RPM)
fan3:           0 RPM  (min =3D    0 RPM)
temp1:        +37.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermistor
temp3:        +36.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  sensor=
 =3D thermistor
intrusion0:  ALARM

-- Sebastian

--m77cbq6inhnra5di
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4iB7QACgkQ2O7X88g7
+pqdnhAAmHGMrXD9ugL/667AEWW8lcw09Luujjnd6UUmOU3f/Cul4D6PCC6npYq7
DZgeO5h8uGZM3EtCaPIZOjEccfR9w/+Frtp1YfnbvXz0Jnj4He4Oi0Dz8wRtnvCJ
ObjUQWP+DqAhw0bd7JQEPCF154PJgmXBoNZkmIxtETXV5mNMCXOIVTXV0+F6hzob
opYlfAVh+lDrPi9aa+OPs/q5kl+nqXnpBM3IDxSHelPQr7j84py+WW1a8s5yjkUY
5oCWoSOX7Kr/YbadvJgP4g8VUq04jI9SvkLmaHsTpPTB6nM5T4x8O96wHBUW9ukk
5WIbMe+Dup/TPb1qM/XwiLbF6IWfWxPzqo2WYGJuRR92v27owSbJk/DGncaX0zBu
vIpdnCDOFKoXDN6x7HKdUNCYSKmhp1zQ37dPSaClMoXVBYYNEjyoAjW+JHl9gEZD
xCteJBXA1/o0MDhHRks3rnUtimqgyKm7Ah6ArjdnOLV+y+4GIp0wl5ahnOYpXjyB
ckkFFgeszd3G9elO4XG9P+tpfwsyjOFWIVmCC0Yj8HHfTOQhnh7nB0R1mpwAuN04
uRVVsyk8joJ5L8ic9Mv7xV+lx9HZAP0VImW0L+qSMaWm0SvV6BN5TincMD/Te+Dh
+UMN4m6c7BftzO1wSUREqRdn02DcIIbTzr0UEIqECrwgOsFM3bY=
=5egf
-----END PGP SIGNATURE-----

--m77cbq6inhnra5di--
