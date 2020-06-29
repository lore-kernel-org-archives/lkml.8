Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1BE9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDA5120724
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:59:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388529AbgF2T7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388442AbgF2T6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:58:53 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A708C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:58:53 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jpzvT-0001Px-Tj; Mon, 29 Jun 2020 21:58:47 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jpzvS-0005io-8i; Mon, 29 Jun 2020 21:58:46 +0200
Date:   Mon, 29 Jun 2020 21:58:46 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Rahul Tanwar <rahul.tanwar@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@intel.com, songjun.Wu@intel.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com,
        rahul.tanwar.linux@gmail.com
Subject: Re: [PATCH v3 2/2] Add PWM fan controller driver for LGM SoC
Message-ID: <20200629195846.6fonhke5d2rs4mna@pengutronix.de>
References: <cover.1593420979.git.rahul.tanwar@linux.intel.com>
 <df22a642083474e71f9f8274c033a6ef9757af5f.1593420979.git.rahul.tanwar@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kjvrp6vjwce3kmbh"
Content-Disposition: inline
In-Reply-To: <df22a642083474e71f9f8274c033a6ef9757af5f.1593420979.git.rahul.tanwar@linux.intel.com>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--kjvrp6vjwce3kmbh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Jun 29, 2020 at 05:03:47PM +0800, Rahul Tanwar wrote:
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index cb8d739067d2..a3303e22d5fa 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -232,6 +232,15 @@ config PWM_IMX_TPM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called pwm-imx-tpm.
> =20
> +config PWM_INTEL_LGM
> +	tristate "Intel LGM PWM support"
> +	depends on X86 || COMPILE_TEST

Another thing I just noticed: You're using regmap, so I think you should
have

	select REGMAP_MMIO

here.

> +	help
> +	  Generic PWM fan controller driver for LGM SoC.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-intel-lgm.
> +

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--kjvrp6vjwce3kmbh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl76R/IACgkQwfwUeK3K
7AnSIwgAioBKgOURNuZlj2ZaOEbNv0Asga+afCAc5eCL1G1zoFg3nIUlLLtz0EUT
MGLMD63sjZHvB3kkMZYwA5DZFs6prNaWoI2HxN6LA2SCNalwjIQvbxQMvwUh9vwD
9sJfzQaubgGEawID/xOniJyuTOf66HFXQ9moU0VEf3NwTm2pfrapFrOzsKQP8a/K
8VPsgHGCWrIchyhSyw+zOM36XccSSl/TXLWEspAoPh5dOLKKxlcpPsgAe37v7JGJ
QXg09RtvP+ipfWdrPSrt/+2tOj2b5AgatzgBh0Gdt0JEO0SMprMwkl+8PIv7mqhF
LrDM55V72Emp+3WPOdTJUwrR7zN+iQ==
=J0cp
-----END PGP SIGNATURE-----

--kjvrp6vjwce3kmbh--
