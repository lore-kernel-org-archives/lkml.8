Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F75EC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0127A2081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729937AbgAOULc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:11:32 -0500
Received: from sauhun.de ([88.99.104.3]:41284 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729442AbgAOULc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:11:32 -0500
Received: from localhost (p54B33239.dip0.t-ipconnect.de [84.179.50.57])
        by pokefinder.org (Postfix) with ESMTPSA id 3D5F12C39CE;
        Wed, 15 Jan 2020 21:11:30 +0100 (CET)
Date:   Wed, 15 Jan 2020 21:11:29 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jean Delvare <jdelvare@suse.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 3/3] i2c: highlander: Use proper printk format for
 size_t
Message-ID: <20200115201129.GF23789@ninjato>
References: <20200115200250.10849-1-krzk@kernel.org>
 <20200115200250.10849-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aZoGpuMECXJckB41"
Content-Disposition: inline
In-Reply-To: <20200115200250.10849-3-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--aZoGpuMECXJckB41
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 09:02:50PM +0100, Krzysztof Kozlowski wrote:
> size_t should be printed with its own format to be 64-bit friendly and
> fix warning when compiling on 64-bit platform (e.g. with COMPILE_TEST):
>=20
>     drivers/i2c/busses/i2c-highlander.c: In function =E2=80=98highlander_=
i2c_smbus_xfer=E2=80=99:
>     drivers/i2c/busses/i2c-highlander.c:325:22: warning:
>         format =E2=80=98%d=E2=80=99 expects argument of type =E2=80=98int=
=E2=80=99,
>         but argument 3 has type =E2=80=98size_t {aka long unsigned int}=
=E2=80=99 [-Wformat=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20

Applied to for-next, thanks!


--aZoGpuMECXJckB41
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4fcfEACgkQFA3kzBSg
KbbGbA//V4Pd/oZSzcwC+gh8impSTd2ltc1fdkHj2NdO2PWaI6Z0Sft6BEhFWuPq
VZij+N0uNkEwP9SUPgL5paDSlHX+a684bSObv3g4EkM3ZSl9vGvGnHeVkQRVM+2c
eZRyEnszq+9FU2tG945L3y2iqOmym8XOOILqwRhnxJRI+cB52kzQ7IH5g6oMHQcc
RftZRMwjS1bxQKdVQTaaUyvI+6x5HMH7MzQMjCoqLuIWxkglF7hEjfx1cYjnO9x8
zVvsMwBtqOaIHg/KNHER/zXEh6Bjc1bVc5z6ycb3raIaqk79BhBxFjICVKXtPrXo
5y46SSL8NMfDmVjZS1mCPwOTM/f3uAhMyPiOWixY/l2z6+LAQUWhWEC4NGYPUTHJ
CP8panoD/9FHqgYLRPNrf3xfJklbKxR4cqgHJvbh5HBjwFOFrdRUxURlhchT7kym
hE3xiOkVnbL8OO+CabShgVN2w/vG9H27YDiLgWXgT8Pdk6rjnpip+x9OWXluA4Ld
repFYBsR7U21fQ7Ofi/SZnWnFwlmrxxxE4Pyt5vwMxIsHtTalXs2xDA6QKtBDGrS
6avSqCtkS/8ZWIS30sYTv7n7BJj1LK8WCAT4ieh54NOiE20pjDSNTbeKe6kLAybV
CbMkkNqjVKMRrSXUdP8t5knn4IHbhwpr3txW38uFIX+GgogYuoM=
=MSqQ
-----END PGP SIGNATURE-----

--aZoGpuMECXJckB41--
