Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A307FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:07:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F7620720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731073AbgGUVH2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:07:28 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:44350 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgGUVH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:07:27 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 46A151C0BD8; Tue, 21 Jul 2020 23:07:25 +0200 (CEST)
Date:   Tue, 21 Jul 2020 23:07:24 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, robh@kernel.org, marek.behun@nic.cz,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v31 03/12] leds: lp50xx: Add the LP50XX family of the RGB
 LED driver
Message-ID: <20200721210724.GD5966@amd>
References: <20200716182007.18389-1-dmurphy@ti.com>
 <20200716182007.18389-4-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
In-Reply-To: <20200716182007.18389-4-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--AbQceqfdZEv+FvjW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2020-07-16 13:19:58, Dan Murphy wrote:
> Introduce the LP5036/30/24/18/12/9 RGB LED driver.
> The difference in these parts are the number of
> LED outputs where the:
>=20
> LP5036 can control 36 LEDs
> LP5030 can control 30 LEDs
> LP5024 can control 24 LEDs
> LP5018 can control 18 LEDs
> LP5012 can control 12 LEDs
> LP5009 can control 9 LEDs
>=20
> The device has the ability to group LED output into control banks
> so that multiple LED banks can be controlled with the same mixing and
> brightness.  Inversely the LEDs can also be controlled independently.
>=20
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

> +/*
> + * struct lp50xx_chip_info -
> + * @num_leds: number of LED outputs available on the device
> + * @led_brightness0_reg: first brightness register of the device
> + * @mix_out0_reg: first color mix register of the device
> + * @bank_brt_reg: bank brightness register
> + * @bank_mix_reg: color mix register
> + * @reset_reg: device reset register
> + */

Should have /** if this is kerneldoc.

> +		init_data.fwnode =3D child;
> +		num_colors =3D 0;
> +
> +		/* There are only 3 LEDs per module otherwise they should be
> +		 * banked which also is presented as 3 LEDs
> +		 */

This is not usual comment style for kernel. (And add . at end of
sentence).

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8XWQwACgkQMOfwapXb+vLZXQCgtqz9dEGyErkUzNfv1kbn+2+U
PlIAoIpGic43RNmIyNASnUrUMvihDFlV
=w59v
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
