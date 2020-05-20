Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAC8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E84D7207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 04:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgETEwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 00:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgETEwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 00:52:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E85C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 21:52:08 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jbGi6-0006TK-QU; Wed, 20 May 2020 06:52:06 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jbGi5-00028J-3x; Wed, 20 May 2020 06:52:05 +0200
Date:   Wed, 20 May 2020 06:52:05 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     jassisinghbrar@gmail.com, kernel@pengutronix.de, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mailbox: imx: Disable the clock on
 devm_mbox_controller_register() failure
Message-ID: <20200520045205.ag6i7z2xmeenmqpg@pengutronix.de>
References: <20200520032246.12482-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7bmp72cg7y2mwspo"
Content-Disposition: inline
In-Reply-To: <20200520032246.12482-1-festevam@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:51:06 up 186 days, 20:09, 181 users,  load average: 0.04, 0.03,
 0.00
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7bmp72cg7y2mwspo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2020 at 12:22:46AM -0300, Fabio Estevam wrote:
> devm_mbox_controller_register() may fail, and in the case of failure the
> priv->clk clock that was previously enabled, should be disabled.
>=20
> Fixes: 2bb7005696e2 ("mailbox: Add support for i.MX messaging unit")
> Signed-off-by: Fabio Estevam <festevam@gmail.com>

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

> ---
>  drivers/mailbox/imx-mailbox.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 7906624a731c..3f7c4548c18f 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -508,7 +508,13 @@ static int imx_mu_probe(struct platform_device *pdev)
> =20
>  	platform_set_drvdata(pdev, priv);
> =20
> -	return devm_mbox_controller_register(dev, &priv->mbox);
> +	ret =3D devm_mbox_controller_register(dev, &priv->mbox);
> +	if (ret) {
> +		clk_disable_unprepare(priv->clk);
> +		return ret;
> +	}
> +
> +	return 0;
>  }
> =20
>  static int imx_mu_remove(struct platform_device *pdev)
> --=20
> 2.17.1
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--7bmp72cg7y2mwspo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl7Et3QACgkQ4omh9DUa
UbPjEA//QgEWw4m0bNgKXh2n+zSBOgCnjZFToTsq9sSFbM9hszMEF2qZv/Ju2H2D
ntWUnL8j66M6A33GfGQlPJKf1ZJIgVAP7In//Xk0/TBDi+qakmYTTnm54b44HjW8
N6RBOUExlFiiJAxuzlvidOy01HctuAMC2WRzyIqrMv//WubrbrmalllYnysJAEE9
R5SjJqYxuV8RBl7nZHsMd0CFC4fUS3LYfCd6nNGYyvEfBbuLxJgRQgp+FohQapkT
g25wH8RKk82Rqf+nlFtnen2l76NYwMxzZVx+x5Bci6qumFUYKmL4aVNFqZYQBATO
9TLAFyVN4FqFQormzZuNfXDrjsmhf9AfNuSTcfDVXpWuT5zpLwPihtu8Iq91lUsC
tNFH5W2zAvBWhrRHkT4M5oY6zPigjeagrMpUmzBmCG2ptCRTbHzYTKKhmdSFLQXE
PcdQfMdsh7R2COkGiRQQJmB0n9BrON6ybVDTb+U4a8clOJIvmRH2+0jkoO3TfoAu
T1KP08ACcV4BbbsfNyvpSLwDy5etVydDbyVFDwPOxB+UIAoH8b8I2WuLeEVkOxQQ
0nFTc8upPqCqk5QcFNl6LtpMloltfqLj0i3C2iuHA09f5M8D3XV+5b/HO2lI0+e6
6d1//OLVj6SolMzqQ40o5lkuQ29KSt1l6LI0RyL0F1vDGzGzU3s=
=d9Sl
-----END PGP SIGNATURE-----

--7bmp72cg7y2mwspo--
