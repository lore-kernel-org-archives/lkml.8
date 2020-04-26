Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A4EC55191
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 08:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01AE42071E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 08:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgDZIQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 04:16:54 -0400
Received: from sauhun.de ([88.99.104.3]:43276 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgDZIQy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 04:16:54 -0400
Received: from localhost (p54B33954.dip0.t-ipconnect.de [84.179.57.84])
        by pokefinder.org (Postfix) with ESMTPSA id 84CD02C01E8;
        Sun, 26 Apr 2020 10:16:52 +0200 (CEST)
Date:   Sun, 26 Apr 2020 10:16:52 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Jason Yan <yanaijie@huawei.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: busses: remove unneeded conversion to bool
Message-ID: <20200426081652.GH1262@kunai>
References: <20200420042816.18989-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LZFKeWUZP29EKQNE"
Content-Disposition: inline
In-Reply-To: <20200420042816.18989-1-yanaijie@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZFKeWUZP29EKQNE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 20, 2020 at 12:28:16PM +0800, Jason Yan wrote:
> The '>' expression itself is bool, no need to convert it to bool again.
> This fixes the following coccicheck warning:
>=20
> drivers/i2c/busses/i2c-qup.c:960:48-53: WARNING: conversion to bool not n=
eeded here
> drivers/i2c/busses/i2c-qup.c:962:47-52: WARNING: conversion to bool not n=
eeded here
> drivers/i2c/busses/i2c-qup.c:1531:29-34: WARNING: conversion to bool not =
needed here
> drivers/i2c/busses/i2c-qup.c:1533:29-34: WARNING: conversion to bool not =
needed here
>=20
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied to for-next, thanks! But please fix $subject to have the driver
name "qup" next time.


--LZFKeWUZP29EKQNE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6lQ3AACgkQFA3kzBSg
KbbPmQ//REatWshvQZ2+D9K9K+XGNUsZXGd1r3Vhl+QLR5zlQK1pcxW5p72VHXPj
/f7wEZqhCawEKcY6VUbBFquHyZipMoUS7DUKsZa2r0fBLjAyY5rxGc/q/tWs4iHB
PlBvoo0XBPLAwGr54mpiFju5PHuU6kQfhA/hPp9++anIq7WJwqxT7lJf9GM7w7Tz
/FHZkBBFONE4yN0tD0h70JiJosrvGciJ62ymkCdqOGOO2Zt7SDmT4T0EZjPijIsk
7IX0wevyCgqZkmxdLlFlPawh+0gbyp8larSYelNQBVw58o5hGK7JeSgIa0qyZIBq
lZ+O5eO+0pMHONdNcjIbznJXhTMXcn28u2fegpMT3ku/YS0SenJ/QoqIK80J16/a
3avxEVxSlOYcIXf5+OH+HtL7xfZCLwtalVu2rWwcpIikJGyD2axNz0B/c9FozQHo
Ox80wyCkRzDVvL99fo9vBJe8/MLNezlZzlpINkmPIkjNv5ZR3cYzSs0W4ckKXTjA
ABI4lQhQstVucG070SdxF6zJInWi+su2hLBqBT5DQ7ECt1BmoWFP7YWEBOaY9z31
KkG6BK+DaScpka0liHt1Gy85p/lXBsKY/o5F9n8/1NsUniZ9blHqju6mNfTzLEDI
oPHxnBR9jN/+vEq5GfgHQKnCQ0hd0jLGmpzvugbLNj0KOjf9g+U=
=ouID
-----END PGP SIGNATURE-----

--LZFKeWUZP29EKQNE--
