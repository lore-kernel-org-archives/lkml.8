Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B23C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51EEC20787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389918AbgEYKts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:49:48 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:40716 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389484AbgEYKts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:49:48 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 84E591C0256; Mon, 25 May 2020 12:49:46 +0200 (CEST)
Date:   Mon, 25 May 2020 12:49:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Hongbo Yao <yaohongbo@huawei.com>
Cc:     jansimon.moeller@gmx.de, jacek.anaszewski@gmail.com,
        chenzhou10@huawei.com, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH -next] leds: blinkm: remove set but not used variable
Message-ID: <20200525104945.GA27989@amd>
References: <20200509142357.33702-1-yaohongbo@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <20200509142357.33702-1-yaohongbo@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2020-05-09 22:23:57, Hongbo Yao wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> drivers/leds/leds-blinkm.c:483:6: warning: variable =E2=80=98ret=E2=80=99=
 set
> but not used [-Wunused-but-set-variable]
>   int ret;

Should error be propagated?
								Pavel
							=09

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
> ---
>  drivers/leds/leds-blinkm.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
> index e11fe1788242..a493ee0e0fc7 100644
> --- a/drivers/leds/leds-blinkm.c
> +++ b/drivers/leds/leds-blinkm.c
> @@ -480,9 +480,8 @@ static int blinkm_led_blue_set(struct led_classdev *l=
ed_cdev,
> =20
>  static void blinkm_init_hw(struct i2c_client *client)
>  {
> -	int ret;
> -	ret =3D blinkm_transfer_hw(client, BLM_STOP_SCRIPT);
> -	ret =3D blinkm_transfer_hw(client, BLM_GO_RGB);
> +	blinkm_transfer_hw(client, BLM_STOP_SCRIPT);
> +	blinkm_transfer_hw(client, BLM_GO_RGB);
>  }
> =20
>  static int blinkm_test_run(struct i2c_client *client)

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7LoskACgkQMOfwapXb+vKRLQCfTW75g1n1akDEJ892GY+dT3fo
Ei4AoIFaJwilTcqvq6wj9im5fmu4flXX
=FG0N
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
