Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E15C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A84021927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgBZNfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:35:45 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:38126 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgBZNfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:35:44 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 857751C2228; Wed, 26 Feb 2020 14:35:42 +0100 (CET)
Date:   Wed, 26 Feb 2020 14:35:42 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH -next] leds: leds-bd2802: remove set but not used
 variable 'pdata'
Message-ID: <20200226133542.GC4080@duo.ucw.cz>
References: <20200108015322.51103-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <20200108015322.51103-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2020-01-08 01:53:22, YueHaibing wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
>=20
> drivers/leds/leds-bd2802.c: In function 'bd2802_probe':
> drivers/leds/leds-bd2802.c:663:35: warning:
>  variable 'pdata' set but not used [-Wunused-but-set-variable]
>=20
> commit 4c3718f9d6a6 ("leds: bd2802: Convert to use GPIO descriptors")
> left behind this unused variable.
>=20
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks, applied.
								Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXlZ0LgAKCRAw5/Bqldv6
8pH4AJ9xvxAZkpy6T7XHvo8qDEytYkQFMQCgsyB2TzRbBnybDx7t/BwUvk621bg=
=WhOt
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
