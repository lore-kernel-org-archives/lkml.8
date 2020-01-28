Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5C0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF924207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="YzB3/Slq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgA1Sqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:46:31 -0500
Received: from mail.andi.de1.cc ([85.214.55.253]:53892 "EHLO mail.andi.de1.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726233AbgA1Sqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:46:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Type:MIME-Version:References:
        In-Reply-To:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=o5b4zT6ABTt/Bpva8YQVV770fwaMN/nJ/cLNpYQvi3k=; b=YzB3/Slq/LCHsK8jDCDbv0TFr
        1iK8Y4SOX+pMvYNXry5XiuMUvASGi6pG5suIKcJSMACnFveFHW5f0DbQ9W5D1MPTWx0ScQUMi8rW9
        jX8sVQ74vZGrIKINpVHx9UPN2+JYmeqjzKFO4fWeg4vWzS0I6dRfOca2WVD77u3yA2VAQ=;
Received: from p200300ccff16f4007ee9d3fffe1fa246.dip0.t-ipconnect.de ([2003:cc:ff16:f400:7ee9:d3ff:fe1f:a246] helo=eeepc)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iwVsa-0002bY-2C; Tue, 28 Jan 2020 19:46:29 +0100
Received: from [::1] (helo=localhost)
        by eeepc with esmtp (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1iwVsZ-0002kM-6A; Tue, 28 Jan 2020 19:46:27 +0100
Date:   Tue, 28 Jan 2020 19:45:55 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: rn5t618: cleanup i2c_device_id
Message-ID: <20200128194555.324cff21@kemnade.info>
In-Reply-To: <20191211215731.19350-1-andreas@kemnade.info>
References: <20191211215731.19350-1-andreas@kemnade.info>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/OBoX2dOW+n5S9UzDv+26TUn"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OBoX2dOW+n5S9UzDv+26TUn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi,

just re-checking the patch again. Seems that I have added it on top of my R=
TC
series. It breaks because of...

On Wed, 11 Dec 2019 22:57:31 +0100
Andreas Kemnade <andreas@kemnade.info> wrote:

> That list was just empty, so it can be removed if .probe_new
> instead of .probe is used
>=20
> Suggested-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  drivers/mfd/rn5t618.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/mfd/rn5t618.c b/drivers/mfd/rn5t618.c
> index 18d56a732b20..70d52b46ee8a 100644
> --- a/drivers/mfd/rn5t618.c
> +++ b/drivers/mfd/rn5t618.c
> @@ -150,8 +150,7 @@ static const struct of_device_id rn5t618_of_match[] =
=3D {
>  };
>  MODULE_DEVICE_TABLE(of, rn5t618_of_match);
> =20
> -static int rn5t618_i2c_probe(struct i2c_client *i2c,
> -			     const struct i2c_device_id *id)
> +static int rn5t618_i2c_probe(struct i2c_client *i2c)
>  {
>  	const struct of_device_id *of_id;
>  	struct rn5t618 *priv;
> @@ -251,11 +250,6 @@ static int __maybe_unused rn5t618_i2c_resume(struct =
device *dev)
>  	return 0;
>  }
> =20
I added the pm stuff above ...


> -static const struct i2c_device_id rn5t618_i2c_id[] =3D {
> -	{ }
> -};
> -MODULE_DEVICE_TABLE(i2c, rn5t618_i2c_id);
> -

and below it in my RTC series.

>  static SIMPLE_DEV_PM_OPS(rn5t618_i2c_dev_pm_ops,
>  			rn5t618_i2c_suspend,
>  			rn5t618_i2c_resume);

Do you want to have it rebased so it can be applied first?
Sorry for the confusion here.

Regards,
Andreas

--Sig_/OBoX2dOW+n5S9UzDv+26TUn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEPIWxmAFyOaBcwCpFl4jFM1s/ye8FAl4wgWQACgkQl4jFM1s/
ye9MeQ//QCP2dZEiG99itkv3sMCQiOL2zcduv7o9pHpP+ha+glSy6ueXj1XYOwFj
zhaU+cIOmVJXbyHXRyUY2V/Agr5CMrp0bS6+x99BLkBNkjCOBjdgQoLpDNQKbgr1
MIC53iPOIcil4wrUzP9X0egI/jrH3lPbHi5yXLj0DsoUPzfQGRMBWeyRDmmNiW3e
PkRuQZgVkCvVOHmIDD5pSwDk3WlPBzPLHAPolKCfvDkHQSCl/WIvCts8PPC5lYgQ
MGNAnYRP48F7QZxV4vemhbN5t6rIy0nW/YKx3Fkszmkp+oh9wDLb5x7NJ8tWWUcb
JeeJ0D5TnfhkC6srmlXe15RDeFtKfX2xoTqZBrUs3hs88iqA7Zs1+rDV+dorkL3V
YlLlDXGM21rVzF9LExzC8zrp2888c9FpF0LLKbJQIinNzxmHZyLipmK9Z7laTAvo
IFEJaIdiJ8CJFW33m6j8vdBnIYNWQCOhuI2toGnLbVXjw3A/kMpeLqCj/roqDeZ+
Y6peKO+JSZ4SWYUkMOTCriOzwUOyBWcVGKw6pBBP1yqIquFXAl5ti3FIsxOTzo7N
fLSfFi3SSfTN3/Eopupi/M93m0myrXrh7Ezt50rfCNl9EsxTR0yeWuC6LP9+88cU
mbG5qDtC8eZ9ZNEdnqRFc6xa7RV8EO8M5HNCVKaRJx/LF0GeKnI=
=EFa8
-----END PGP SIGNATURE-----

--Sig_/OBoX2dOW+n5S9UzDv+26TUn--
