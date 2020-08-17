Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B45BC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 20:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE6CB20674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 20:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHQUfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 16:35:24 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:40280 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgHQUfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 16:35:21 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CB3611C0BB7; Mon, 17 Aug 2020 22:35:19 +0200 (CEST)
Date:   Mon, 17 Aug 2020 22:35:19 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, robh@kernel.org, marek.behun@nic.cz,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v33 0/6] LP50xx addition and remainder Multicolor patches
Message-ID: <20200817203519.GA14622@amd>
References: <20200812195020.13568-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <20200812195020.13568-1-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> These are the final patches from the original multicolor framework patchs=
et.
>=20
> Changes made were to the LP50xx to rework regmap_defaults to eliminate us=
ed
> only once #defines.  Also fixed putting the child node in the dt parsing =
and
> changed regmap regcache type to flat.

Thanks. I applied 1 and 2 of the series to the for-next branch.

Best regards,
								Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl866gcACgkQMOfwapXb+vK3/gCgm1Jg7V7qaZpX1QGT/ZtA4YAD
8XIAnj3SrFGh3d1vaa5D5YEMboS1eNrv
=+nSX
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
