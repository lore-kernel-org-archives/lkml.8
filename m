Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB597C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F7F622C7B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbgGUVLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:11:39 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:44736 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgGUVLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:11:39 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3B5AD1C0BD8; Tue, 21 Jul 2020 23:11:36 +0200 (CEST)
Date:   Tue, 21 Jul 2020 23:11:35 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, robh@kernel.org, marek.behun@nic.cz,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v31 06/12] leds: lp55xx: Add multicolor framework support
 to lp55xx
Message-ID: <20200721211135.GE5966@amd>
References: <20200716182007.18389-1-dmurphy@ti.com>
 <20200716182007.18389-7-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
In-Reply-To: <20200716182007.18389-7-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Add multicolor framework support for the lp55xx family.
>=20
> Acked-by: Pavel Machek <pavel@ucw.cz>
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Applied 4,5,6 and 8,9.

>  config LEDS_LP55XX_COMMON
>  	tristate "Common Driver for TI/National LP5521/5523/55231/5562/8501"
> -	depends on LEDS_LP5521 || LEDS_LP5523 || LEDS_LP5562 || LEDS_LP8501
> +	depends on LEDS_CLASS_MULTICOLOR || !LEDS_CLASS_MULTICOLOR
> +	depends on OF
>  	select FW_LOADER
>  	select FW_LOADER_USER_HELPER

But I have to ask: what does this do to userland interface once
LEDS_CLASS_MULTICOLOR is enabled?

Will users see some changes? Will they see some changes after dts
parts are applied?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8XWgcACgkQMOfwapXb+vJs8gCgjiyUjz1Qm40NgHKrj1ROiK6w
piAAnibro4jCdEmW1PAfv4OLVl3T65wz
=Hh5F
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--
