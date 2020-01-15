Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3128C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC3402081E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 20:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgAOULZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 15:11:25 -0500
Received: from sauhun.de ([88.99.104.3]:41234 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729442AbgAOULY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 15:11:24 -0500
Received: from localhost (p54B33239.dip0.t-ipconnect.de [84.179.50.57])
        by pokefinder.org (Postfix) with ESMTPSA id D13B82C39C2;
        Wed, 15 Jan 2020 21:11:22 +0100 (CET)
Date:   Wed, 15 Jan 2020 21:11:22 +0100
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jean Delvare <jdelvare@suse.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v3 1/3] i2c: pmcmsp: Use proper printk format for
 resource_size_t
Message-ID: <20200115201122.GD23789@ninjato>
References: <20200115200250.10849-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="n2Pv11Ogg/Ox8ay5"
Content-Disposition: inline
In-Reply-To: <20200115200250.10849-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--n2Pv11Ogg/Ox8ay5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2020 at 09:02:48PM +0100, Krzysztof Kozlowski wrote:
> resource_size_t should be printed with its own size-independent format
> to fix warnings when compiling on 64-bit platform (e.g. with
> COMPILE_TEST):
>=20
>     drivers/i2c/busses/i2c-pmcmsp.c: In function =E2=80=98pmcmsptwi_probe=
=E2=80=99:
>     drivers/i2c/busses/i2c-pmcmsp.c:276:25: warning:
>         format =E2=80=98%x=E2=80=99 expects argument of type =E2=80=98uns=
igned int=E2=80=99,
>         but argument 3 has type =E2=80=98resource_size_t {aka long long u=
nsigned int}=E2=80=99 [-Wformat=3D]
>=20
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>=20

Applied to for-next, thanks!


--n2Pv11Ogg/Ox8ay5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl4fceUACgkQFA3kzBSg
Kbaqsw//fd/tBuZAf0ECoBh5tOS9OHNnch60MhHR1/66F+fZJu0d51QyirtYSeXI
9E+eS4MHn3Eoa7MpuNFG+6P16VaecghOOWNFp9mCqboutGRU0UiF32qicCmYRx7d
TiMiILh67d8Y9+WcPqRIOtEjjrGWLIqSYXC1nEz7fNEOQ4/5NU1cj73GFjd1Oc4e
IEjeRYzxg6nnS46q3CT94gFERxTb/x4Z+r5WFMSlkDtOZMpYjlQSplazQyn7eLIZ
Af/okYkrexFsh5xayYRldbHWUK9pHky1nlj+K8EbnRIoc+imM7q7opOlhWJMnGBT
0pj+33JTYTIKuKPUtoReM8yvTST63SUpjCC6vZTu+verAZvzXX2dvXfzq55rDknr
U5c6+/PMUf17A3/XPzWcaBR/00L7B0MoLRVRICAAtLSnXOg1RJW07Xc+ichmgFNU
05X1eUWWI5pIpZjbpVxLyNk/ta2J4lG76LEW/79/ieU7P7GVcZAFKHloTvHBfNVQ
PqWxuAAlwdHQl6eG7gwJD4lv53OK0MLVHPXR//XiiKQNIoGxmQUoj4O8oZ4wrspi
tFB261pBx8FNc5ioqfL3WJh798KX/XEKGBAizj6cRhHC/Y/6WXs6QKk8gqjyDIZK
uF1TH08xWErH1MxiwUy37wMIzH0rlDFs2JHQGgJd4QDq4qc0lns=
=QP0H
-----END PGP SIGNATURE-----

--n2Pv11Ogg/Ox8ay5--
