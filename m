Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18133C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F369320675
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732312AbgF2UCO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387485AbgF2TkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:40:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C65FC03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 12:40:03 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jpzdH-0006Hf-Lb; Mon, 29 Jun 2020 21:39:59 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jpzdG-0005D9-HF; Mon, 29 Jun 2020 21:39:58 +0200
Date:   Mon, 29 Jun 2020 21:39:58 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     thierry.reding@gmail.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, NeilBrown <neilb@suse.de>,
        Grant Erickson <marathon96@gmail.com>
Subject: Re: [PATCH 4/4] pwm: omap-dmtimer: Repair pwm_omap_dmtimer_chip's
 broken kerneldoc header
Message-ID: <20200629193958.dasxmmkcexfxorfq@pengutronix.de>
References: <20200629124752.1018358-1-lee.jones@linaro.org>
 <20200629124752.1018358-5-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ktwuwrjs6xawhva4"
Content-Disposition: inline
In-Reply-To: <20200629124752.1018358-5-lee.jones@linaro.org>
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ktwuwrjs6xawhva4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

[dropped Joachim Eastwood <manabian@gmail.com> from recipents as his
address bounces]

On Mon, Jun 29, 2020 at 01:47:52PM +0100, Lee Jones wrote:
> Argument descriptions must be prepended with a '@' to be understood
> by the kerneldoc tooling/parsers/validators.
>=20
> Fixes the following W=3D1 warning:
>=20
>   drivers/pwm/pwm-omap-dmtimer.c:70: warning: Function parameter or membe=
r 'dm_timer_pdev' not described in 'pwm_omap_dmtimer_chip'
>=20
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Joachim Eastwood <manabian@gmail.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Grant Erickson <marathon96@gmail.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-omap-dmtimer.c b/drivers/pwm/pwm-omap-dmtime=
r.c
> index 0d31833db2e2c..75cea7f2aff5e 100644
> --- a/drivers/pwm/pwm-omap-dmtimer.c
> +++ b/drivers/pwm/pwm-omap-dmtimer.c
> @@ -58,7 +58,7 @@
>   * @mutex:		Mutex to protect pwm apply state
>   * @dm_timer:		Pointer to omap dm timer.
>   * @pdata:		Pointer to omap dm timer ops.
> - * dm_timer_pdev:	Pointer to omap dm timer platform device
> + * @dm_timer_pdev:	Pointer to omap dm timer platform device
>   */
>  struct pwm_omap_dmtimer_chip {
>  	struct pwm_chip chip;

LGTM,

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ktwuwrjs6xawhva4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAl76Q4sACgkQwfwUeK3K
7AmzWAf/Zj9Hhj4s99PZArypybzk5l2H7shVDnUei4T1aCiVqD9rL+QJitW3TzTZ
HyhCa7plxP9BHXDPcQKagFjgnj/zj/tNPSst12WGmX6rc2omP5DHpzzMqAkCCAb+
Iw3YHQPmQQOdFNYIgQ2CsIIJs4Yo+pkm+XswLVR7pRJpuHu8omfiK6BhklqjJ/IG
nskRKoHfPpzmay1PlTmhDytmtpT6wlb67xbEzLv59kZlYabgWjTClYN14fHRpELe
AgWX0v3tdwPZLcVRuRcv2aPWuayBGSnLUi4H8h42WpxuveHjkWJql/2ETbSqCaP3
6rtluenkb9KLsjjeLxIatc3UjArhYg==
=3KKv
-----END PGP SIGNATURE-----

--ktwuwrjs6xawhva4--
