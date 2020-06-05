Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BDEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53832206A2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 15:15:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgFEPPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 11:15:53 -0400
Received: from orion.archlinux.org ([88.198.91.70]:43476 "EHLO
        orion.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726742AbgFEPPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 11:15:52 -0400
Received: from orion.archlinux.org (localhost [127.0.0.1])
        by orion.archlinux.org (Postfix) with ESMTP id 0B59C1C90FD6B1;
        Fri,  5 Jun 2020 15:15:45 +0000 (UTC)
Received: from genesis (unknown [IPv6:2001:8a0:f254:2300:34be:8c97:bb49:e7fd])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: ffy00)
        by orion.archlinux.org (Postfix) with ESMTPSA;
        Fri,  5 Jun 2020 15:15:44 +0000 (UTC)
Message-ID: <137acb00c6ec098d7506901df05067e8d7207aa9.camel@archlinux.org>
Subject: Re: [PATCH v2] HID: logitech-hidpp: add support for Logitech G533
 headset
From:   Filipe =?ISO-8859-1?Q?La=EDns?= <lains@archlinux.org>
To:     Kamil =?UTF-8?Q?Doma=C5=84ski?= <kamil@domanski.co>,
        linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
In-Reply-To: <023148f582cc20bef7079508ce417c8ebeb0febb.camel@domanski.co>
References: <023148f582cc20bef7079508ce417c8ebeb0febb.camel@domanski.co>
Organization: Archlinux
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MLffL35euR0/LFoSi3jD"
Date:   Fri, 05 Jun 2020 16:15:43 +0100
MIME-Version: 1.0
User-Agent: Evolution 3.36.3 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MLffL35euR0/LFoSi3jD
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kamil,

On v2 patches it s usual to add a changelog (could be small) to help
keep track of what changed.

On Fri, 2020-06-05 at 16:59 +0200, Kamil Doma=C5=84ski wrote:
> Signed-off-by: Kamil Doma=C5=84ski <kamil@domanski.co>

*snip*

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

=46rom my initial comments:

> We use snake case.

> +
> +	long flags =3D (long) data[2];

> Use u8 instead. Why are we even using a variable for this?

My main point here is that long means different things in different
architectures, and we only want one byte so I would go for u8.

> +
> +	*voltage =3D get_unaligned_be16(data);
> +	isConnected =3D test_bit(0, &flags);
> +	isCharging =3D test_bit(1, &flags);
> +	chargingComplete =3D test_bit(2, &flags);
> +	chargingFault =3D test_bit(3, &flags);

> I don't think this is needed, just do it in the ifs directly.
>
> Here I would add a #define for each bit:
>
> #define FLAG_ADC_MAP_STATUS_CONNECTED 0
> ...
> if (data[2] & FLAG_ADC_MAP_STATUS_CONNECTED)

> +
> +	if (!isConnected)
> +		return POWER_SUPPLY_STATUS_UNKNOWN;
> +
> +	if (isCharging) {
> +		if (chargingFault)
> +			return POWER_SUPPLY_STATUS_NOT_CHARGING;
> +
> +		if (chargingComplete)
> +			return POWER_SUPPLY_STATUS_FULL;
> +
> +		return POWER_SUPPLY_STATUS_CHARGING;
> +	}
> +
> +	return POWER_SUPPLY_STATUS_DISCHARGING;
> +}

The algorithm is now correct, thanks!

*snip*

> @@ -3994,6 +4190,8 @@ static const struct hid_device_id hidpp_devices[] =
=3D {
> =20
>  	{ /* Logitech G403 Wireless Gaming Mouse over USB */
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC082) },
> +	{ /* Logitech G533 Wireless Headset over USB */
> +	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0x0A66) },
>  	{ /* Logitech G703 Gaming Mouse over USB */
>  	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, 0xC087) },
>  	{ /* Logitech G703 Hero Gaming Mouse over USB */

Same thing here. We should see if the device supports the DJ protocol
and add it in hid-logitech-dj instead.

Most of my comments here are nitpicks, I am not sure how strict
Benjamin/Jiri are about that.

Cheers,
Filipe La=C3=ADns

--=-MLffL35euR0/LFoSi3jD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0jW0leqs33gyftiw+JPGdIFqqV0FAl7aYZoACgkQ+JPGdIFq
qV1MDw//Rds5LDFHwKnq32ug4ZUStpKPmjdZDXd6JzMdXFtxSALCXM1jKm/sebdQ
QtWrsoayLNYav0X3zhauM0OmDg+qnsuvQHLrHzebzw6nGdF6jNJa5vZzwiyT0DHi
u5yUbQuteer4vi2Z8XLSw/NM7tgoSTupbdF/LpYt3RAv1c00Lt/9BQ8ecwCdmxuV
ogo5XKi3z524uh6r4WsA8DHE3a7BPgyYTn3kTAZDm2bqCqKQGZRXIaI6u9l457nV
VfhkqBetAvyXXq2E/6JUKbpuiJr+Gbfze8aHd053zKzH5Fu4Ya5oQhw5RY07x8nX
N6RGj154gZO4Ghcc0KOxRUZku7nroelWWXFhq7ovH78EFYI2ALZDxN7XN8aIflkY
B7NMdGgvb9Qgddys6bw8jI2VdqgxOMKe47uekcZT0SzU54tS2IfAIFkofDeWRcry
lGD5Ly7WPdYLcmJVDKyGMjE5Dv+eRBGdaGxhqRc30uLMkZfvQSMA2EbP+ZEGdl/q
E1GP+8D1zSoAH0BiaBVvMKuJwtQymp2jEDV9hQDpGzhLf0v3SZ8zCBZrto94w7xi
nF1D1grXZic0Ou0Z0v/1E3u09dk2iTaPTL59cQiXAnRuZeTJBgA/TS1bws58lDKD
P1d6kR+nInLBXXu93A0B8ua3saN4dEght+Ma3pI8RKiXCZY9uY4=
=16Uj
-----END PGP SIGNATURE-----

--=-MLffL35euR0/LFoSi3jD--
