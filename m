Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE62C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1164A20760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 08:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgGPIbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 04:31:11 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:37060 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgGPIbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:31:08 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2A7671C0BDE; Thu, 16 Jul 2020 10:31:05 +0200 (CEST)
Date:   Thu, 16 Jul 2020 10:31:04 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, robh@kernel.org, marek.behun@nic.cz,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v30 05/16] leds: multicolor: Introduce a multicolor class
 definition
Message-ID: <20200716083104.GA30361@amd>
References: <20200713154544.1683-1-dmurphy@ti.com>
 <20200713154544.1683-6-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <20200713154544.1683-6-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

First, let's substitute multi.color -> multicolor globally,
LEDS_CLASS_MULTI_COLOR is most visible example of this. Please also
decide whether it is MultiColor or multicolor, and make it consistent.

> Introduce a multicolor class that groups colored LEDs
> within a LED node.
>=20
> The multi color class groups monochrome LEDs and allows controlling two

For example here. Plus, the LEDs are not neccessarily monochrome, we
support white LEDs, too. Let's use "simple LEDs"?

> aspects of the final combined color: hue and lightness. The former is
> controlled via the intensity file and the latter is controlled
> via brightness file.

> +	depends on LEDS_CLASS
> +	help
> +	  This option enables the multicolor LED sysfs class in /sys/class/leds.
> +	  It wraps LED class and adds multicolor LED specific sysfs attributes
> +	  and kernel internal API to it. You'll need this to provide support
> +	  for multicolor LEDs that are grouped together. This class is not
> +	  intended for single color LEDs. It can be built as a module.

"single color" -> "simple"?

> +	/* account for the new line at the end of the buffer */
> +	offset++;
> +	if (offset < size) {
> +		ret =3D -EINVAL;
> +		goto err_out;
> +	}

"new line" -> "newline", and actually check that character you are
skipping is newline. Someone could put '%' in there...

> +		if (i < mcled_cdev->num_colors - 1)
> +			len +=3D sprintf(buf + len, " ");
> +	len +=3D sprintf(buf + len, "\n");

Using sprintf for single character has... quite a lot of
overhead. Something like buf[len++] =3D '\n' would be
simpler/shorter/better. Please fix all relevant places.

Note I already applied patches 1-4.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8QEEgACgkQMOfwapXb+vLCTACff5DIlTEKpnar18gbrYa/V9pA
+DEAnRF2FZd5xx4tNyqdWG9UCEZzwJhe
=HdIg
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
