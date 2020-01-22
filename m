Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4624AC33CAF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 315D82465A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 19:05:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgAVTFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 14:05:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36418 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgAVTFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 14:05:12 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id F11DE28FE9A
Received: by earth.universe (Postfix, from userid 1000)
        id 6C5A03C0C7C; Wed, 22 Jan 2020 20:05:08 +0100 (CET)
Date:   Wed, 22 Jan 2020 20:05:08 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        Ondrej =?utf-8?Q?=C4=8Cerman?= <ocerman@sda1.eu>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        Michael Larabel <michael@phoronix.com>,
        Jonathan McDowell <noodles@earth.li>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        Darren Salt <devspam@moreofthesa.me.uk>
Subject: Re: [PATCH v4 0/6] hwmon: k10temp driver improvements
Message-ID: <20200122190508.tudp3gjscsxyidhw@earth.universe>
References: <20200122160800.12560-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2envaqjajvlzizv4"
Content-Disposition: inline
In-Reply-To: <20200122160800.12560-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2envaqjajvlzizv4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The series is

Tested-by: Sebastian Reichel <sebastian.reichel@collabora.com>

on 3800X.

idle:

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:       919.00 mV
Vsoc:          1.01 V
Tdie:         +41.1=B0C
Tctl:         +41.1=B0C
Tccd1:        +39.8=B0C
Icore:         0.00 A
Isoc:          4.50 A

with load:

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:         1.29 V
Vsoc:          1.01 V
Tdie:         +80.4=B0C
Tctl:         +80.4=B0C
Tccd1:        +78.5=B0C
Icore:        61.00 A
Isoc:          6.50 A

debugfs output is also register dumps are also working.

-- Sebastian

On Wed, Jan 22, 2020 at 08:07:54AM -0800, Guenter Roeck wrote:
> This patch series implements various improvements for the k10temp driver.
>=20
> Patch 1/6 introduces the use of bit operations.
>=20
> Patch 2/6 converts the driver to use the devm_hwmon_device_register_with_=
info
> API. This not only simplifies the code and reduces its size, it also
> makes the code easier to maintain and enhance.=20
>=20
> Patch 3/6 adds support for reporting Core Complex Die (CCD) temperatures
> on Zen2 (Ryzen and Threadripper) CPUs (note that reporting is incomplete
> for Threadripper CPUs - it is known that additional temperature sensors
> exist, but the register locations are unknown).
>=20
> Patch 4/6 adds support for reporting core and SoC current and voltage
> information on Ryzen CPUs (note: voltage and current measurements for
> Threadripper and EPYC CPUs are known to exist, but register locations
> are unknown, and values are therefore not reported at this time).
>=20
> Patch 5/6 removes the maximum temperature from Tdie for Ryzen CPUs.
> It is inaccurate, misleading, and it just doesn't make sense to report
> wrong information.
>=20
> Patch 6/6 adds debugfs files to provide raw thermal and SVI register
> dumps. This may help in the future to identify additional sensors and/or
> to fix problems.
>=20
> With all patches in place, output on Ryzen 3900X CPUs looks as follows
> (with the system under load).
>=20
> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:        +1.39 V
> Vsoc:         +1.18 V
> Tdie:         +79.9=B0C
> Tctl:         +79.9=B0C
> Tccd1:        +61.8=B0C
> Tccd2:        +76.5=B0C
> Icore:       +46.00 A
> Isoc:        +12.00 A
>=20
> The voltage and current information is limited to Ryzen CPUs. Voltage
> and current reporting on Threadripper and EPYC CPUs is different, and the
> reported information is either incomplete or wrong. Exclude it for the ti=
me
> being; it can always be added if/when more information becomes available.
>=20
> Tested with the following Ryzen CPUs:
>     1300X A user with this CPU in the system reported somewhat unexpected
>           values for Vcore; it isn't entirely if at all clear why that is
>           the case. Overall this does not warrant holding up the series.
>     1600
>     1800X
>     2200G
>     2400G
>     2700
>     2700X
>     2950X
>     3600X
>     3800X
>     3900X
>     3950X
>     3970X
>     EPYC 7302
>     EPYC 7742
>=20
> Many thanks to everyone who helped to test this series.
>=20
> ---
> v4: Normalize current calculations do show 1A / LSB for core current and
>     0.25A / LSB for SoC current. The reported current values are board
>     specific and need to be scaled using the configuration file.
>     Clarified that the maximum temperature of 70 degrees C (which is no
>     longer displayed) was associated to Tctl and not to Tdie.
>     Added debugfs support.
>=20
> v3: Added more Tested-by: tags
>     Added detection for 3970X, and report Tccd1 for this CPU.
>=20
> v2: Added Tested-by: tags as received.
>     Don't display voltage and current information for Threadripper and EP=
YC.
>     Stop displaying the fixed (and wrong) maximum temperature of 70 degre=
es C
>     for Tdie on model 17h/18h CPUs.

--2envaqjajvlzizv4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl4onNwACgkQ2O7X88g7
+pqJkBAApQ3XTw47RVPnd+DHTQzpJth1lOhlMv3ObtkNcnno5fKoTN4MrgPS+tym
NzsOoBFYJtVIZqJ9MBzPdm25+wtGOLyxp59jU0ewASlhvOsJfcbYnSQpSP9ofmXf
5yqWURvhYJK/U/bl3bFu8GoO+JDO1PdAHcMW2IzWC1zW/mi8XMs5ZWzMzeTU2IEM
yy+PNVh546JlV3bsOprNNQ2X4f+VFgNp9XdcidjO9mQCVaHfNT1/Zfo5agk2Fx+W
f6uFRAszyFacE6Csms7RSQctkFQq7tunj4jpqkL7K6CUp3Z9vIoY6loF+ejEGGwX
TuoOJa6E12eXgMls1hj+i8ojHVNpETLSxh89Xy/nitK1ABRtFp/ejdMl6BDTIvIX
i8iBDIt+AjX0TfEcQOb0DJ21GSma5LYgOMPdE6qfP6EEUZCHTjTfARs44B5Dg3fE
zRHKc6lyWDCc9rPUkLGGxWZuqyOCEQLruEs2X0lWnyjt9tC3PneSEy4T7Ik2MEgs
swTHsW+SA+sEth5HxvxfAEFiQjmx/O4P5LpC0hIqCSjkLhn+eXma1umu5PzZXTD8
CsMHqy9Y/DD3ri7IGmFLha1LhTGzH8Ib4Rr1e0VQRG57g7s+aGE/VeOH4GtzFW2M
OUCNKh14T5f58nJihgM4Zu3OAE+O8nIKYLk3hxQ3mP/khv2DT0I=
=m+GZ
-----END PGP SIGNATURE-----

--2envaqjajvlzizv4--
