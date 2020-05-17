Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDADAC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A83A207D4
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 15:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgEQP6O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 11:58:14 -0400
Received: from orion.archlinux.org ([88.198.91.70]:49148 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727979AbgEQP6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 11:58:13 -0400
X-Greylist: delayed 329 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 May 2020 11:58:12 EDT
Received: from orion.archlinux.org (localhost [127.0.0.1])
        by orion.archlinux.org (Postfix) with ESMTP id E85061BE6BF9B1;
        Sun, 17 May 2020 15:52:40 +0000 (UTC)
Received: from genesis (unknown [IPv6:2001:8a0:f254:2300:34be:8c97:bb49:e7fd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: ffy00)
        by orion.archlinux.org (Postfix) with ESMTPSA;
        Sun, 17 May 2020 15:52:40 +0000 (UTC)
Message-ID: <4ad2e18d37772bed00f1fd7c8a62ce4f98d69fe8.camel@archlinux.org>
Subject: Re: [PATCH] HID: logitech-hidpp: add support for Logitech G533
 headset
From:   Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
To:     Kamil =?UTF-8?Q?Doma=C5=84ski?= <kamil@domanski.co>,
        linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
In-Reply-To: <273f52604e8cb2eae1629ba7c55020227b36b1ba.camel@domanski.co>
References: <273f52604e8cb2eae1629ba7c55020227b36b1ba.camel@domanski.co>
Organization: Archlinux
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-hDPsm5GUFiKwv6eXUHs9"
Date:   Sun, 17 May 2020 16:52:39 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.36.2 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hDPsm5GUFiKwv6eXUHs9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2020-04-26 at 17:18 +0200, Kamil Doma=C5=84ski wrote:

*snip*

> +/* ---------------------------------------------------------------------=
----- */
> +/* 0x1F20: Analog-digital converter measurement                         =
      */
> +/* ---------------------------------------------------------------------=
----- */
> +
> +#define HIDPP_PAGE_ADC_MEASUREMENT 0x1F20
> +
> +#define CMD_ADC_MEASUREMENT_GET_VOLTAGE 0x01
> +
> +/**
> + * hidpp20_adc_map_status_voltage() - convert HID++ code to power supply=
 status
> + * @hidpp: HID++ device struct.
> + * @data: ADC report data.
> + * @voltage: Pointer to variable where the ADC voltage shall be written.
> + *
> + * This function decodes the ADC voltage and charge status
> + * of the device's battery.
> + *
> + * Return: Returns the power supply charge status code.
> + */
> +static int hidpp20_adc_map_status_voltage(struct hidpp_device *hidpp,
> +						u8 data[3], int *voltage)
> +{
> +	bool isConnected;
> +	bool isCharging;
> +	bool chargingComplete;
> +	bool chargingFault;

We use snake case.

> +
> +	long flags =3D (long) data[2];

Use u8 instead. Why are we even using a variable for this?

> +
> +	*voltage =3D get_unaligned_be16(data);
> +	isConnected =3D test_bit(0, &flags);
> +	isCharging =3D test_bit(1, &flags);
> +	chargingComplete =3D test_bit(2, &flags);
> +	chargingFault =3D test_bit(3, &flags);

I don't think this is needed, just do it in the ifs directly.

Here I would add a #define for each bit:

#define FLAG_ADC_MAP_STATUS_CONNECTED 0
...
if (data[2] & FLAG_ADC_MAP_STATUS_CONNECTED)

> +
> +	if (!isConnected)
> +		return POWER_SUPPLY_STATUS_UNKNOWN;
> +
> +	if (chargingFault)
> +		return POWER_SUPPLY_STATUS_NOT_CHARGING;

=46rom the spec:
> Only valid if 'isCharging' is 1.

> +
> +	if (chargingComplete)
> +		return POWER_SUPPLY_STATUS_FULL;

=46rom the spec:
> Only valid if 'isCharging' is 1.

> +
> +	if (isCharging)
> +		return POWER_SUPPLY_STATUS_CHARGING;

Put the two previous checks inside this if.

> +	return POWER_SUPPLY_STATUS_DISCHARGING;
> +}
>=20

*snip*

> @@ -3994,6 +4189,8 @@ static const struct hid_device_id hidpp_devices[] =
=3D {
> =20
>  	{ /* Logitech G403 Wireless Gaming Mouse over USB */
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082) },
> +	{ /* Logitech G533 Wireless Headset over USB */
> +	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0x0A66) },

Is this a receiver? If so, we need to know if it is used by other
devices. Or better, see if it supports the DJ protocol and add it to
hid-logitech-dj instead.

>  	{ /* Logitech G703 Gaming Mouse over USB */
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
>  	{ /* Logitech G703 Hero Gaming Mouse over USB */

Cheers,
Filipe La=C3=ADns

--=-hDPsm5GUFiKwv6eXUHs9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAl7BXcAACgkQ+JPGdIFq
qV3dFg/9H/8qP/XCsbtCQq+SP52oCmC8gcVE66TLgfWgAcUwyh7SRihEbHsn3TGK
81bC56ybt0AhrCpGMd9bakqOz4VKR6oXBaDV9f+DttcScQnjSE5gdrjH3mtXJUOM
kMcWU7QmL+tC3JLOKL1RGX7MH+/jsvbsiFh3ghhXGPeIF8wJvIlvi4FDczh7TaYA
cV7uOXoaYUOhfyoV5V46utmDtRgKtKBv1rtVlbDQUWlZJ1rnGHErx4Ahjj8JHXV0
0zDMqxmaVP5Z1oVEgoLhkXQqlzMLS/ZRzC3W0p1nQC/y8vocHaItpQb8yS3Q4nMe
IQ/StYoUDfHNEWV+6NxnNEvW4JGodC7CYV8bWkEUJpI9JuCLwZ4sYbPCKKOhv2QW
/Dcnok6rfLUR47N/PYCmvw+Uoovx49T+9D18hVkY6EgH4Kc+Tnx7rn5vH2+nglYn
mguXVebhRB2TlFcny1z7SU2O1CcuPExcBFzbZMFmwmOGrPKdWccLc1pzhV72G9uK
fdma3VU8o3JYz3Rj2tSPhobWFjomKvlOzPdp7uecilHMU6fR1DA0aGv3bULdTR/D
HHlvL4mhWNXg5Dr2VOJumr7Zmhmlaho0jUrt3wVwtP7Hb2+2oeUZ8vEFaSyHUzC7
usmhGUoJJrz9q0O8dzbkAR3LhgohQJY6+LfKInHfZNgIsD6wPDk=
=9AgG
-----END PGP SIGNATURE-----

--=-hDPsm5GUFiKwv6eXUHs9--
