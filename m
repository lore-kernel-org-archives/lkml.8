Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C60C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 04:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A491206DA
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 04:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgHAEiI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 00:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgHAEiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 00:38:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8A9C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 21:38:07 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1k1jHS-0001AB-7S; Sat, 01 Aug 2020 06:37:58 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1k1jHQ-00041z-Fr; Sat, 01 Aug 2020 06:37:56 +0200
Date:   Sat, 1 Aug 2020 06:37:56 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     peng.fan@nxp.com
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, mathieu.poirier@linaro.org, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] remoteproc: imx_rproc: add elf memory hooks
Message-ID: <20200801043756.eylyv4d2ymj6hzvr@pengutronix.de>
References: <1595928673-26306-1-git-send-email-peng.fan@nxp.com>
 <1595928673-26306-2-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tntbww4ujgs3gjvq"
Content-Disposition: inline
In-Reply-To: <1595928673-26306-2-git-send-email-peng.fan@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 06:36:47 up 259 days, 19:55, 238 users,  load average: 0.15, 0.06,
 0.01
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tntbww4ujgs3gjvq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

please fix errors reported by test robot.

On Tue, Jul 28, 2020 at 05:31:13PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
>=20
> Please not apply 2/2 for now, this 2/2 has not gone through
> test on all i.MX8 platforms.
>=20
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/remoteproc/imx_rproc.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rpro=
c.c
> index 8957ed271d20..8ad860c65256 100644
> --- a/drivers/remoteproc/imx_rproc.c
> +++ b/drivers/remoteproc/imx_rproc.c
> @@ -6,6 +6,7 @@
>  #include <linux/clk.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
> +#include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> @@ -241,10 +242,22 @@ static void *imx_rproc_da_to_va(struct rproc *rproc=
, u64 da, size_t len)
>  	return va;
>  }
> =20
> +static void *imx_rproc_memcpy(struct rproc *rproc, void *dest, const voi=
d *src, size_t count)
> +{
> +       memcpy_toio((void * __iomem)dest, src, count);
> +}
> +
> +static void *imx_rproc_memset(struct rproc *rproc, void *s, int c, size_=
t count)
> +{
> +	memset_io((void * __iomem)s, c, count);
> +}
> +
>  static const struct rproc_ops imx_rproc_ops =3D {
>  	.start		=3D imx_rproc_start,
>  	.stop		=3D imx_rproc_stop,
>  	.da_to_va       =3D imx_rproc_da_to_va,
> +	.memset		=3D imx_rproc_memset,
> +	.memcpy		=3D imx_rproc_memcpy,
>  };
> =20
>  static int imx_rproc_addr_init(struct imx_rproc *priv,
> --=20
> 2.16.4
>=20
>=20

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--tntbww4ujgs3gjvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl8k8Z8ACgkQ4omh9DUa
UbPd2BAAx/k4TMCUaFJljdJS02U5zdAnW0/bkUSYZQq2mvh2IEwztSbMer5YKrz+
+LrZuzhrBu2aautziu5/M4kfWG/NvHbFSuIcDuB31cp69fc+UYv07hzM3gYIyFCO
2oZ5GHQIjwY2sJQ+IFfWFx/u/2M0AUGJGikV2qseZaX8d0ZWHKZB+hreIG2oEP3u
Brpv8ihZwCK2I1y+tSto9gWz5G7DRFWIaDy5AB6Lk+546Jlyb5vRFTWbdeIcM4vy
90rrNqIL3Glc730SP4luWoNmyJ29DaOVCQ6QZGWoCTuhre1UXJArWO1pqLYjJJTL
v9mXK/WEUlIoDDDuGHOF5X5AwAYyv4rCe4kXASWMTF4PbzP430+BXBb0CQqXSqvk
T6vac01OxxIfJnYvG6rmUDBJ0iy0AuNGyyNMeDbxDQtleLVKx7xN/Izz+uzJSBgV
QDC8xJVwcTKp+zMOrTM83lek2H2yXfcSGakhdIYu+24WExp1yN9s8OYis1wPsIOe
RfsUvLVZFkyggtmjxLK0eNP8InK6qItLdhQ96QvQdBPPXE5raVRqyRZDFewNLHeg
zLFtbXM0mcwzEi4x3cMMSDU98CFsf1xyjsBEoVVj6BE0U8Rt3xqWJ1uexDZizNE1
Wfzo6FbbKZakKKXmdU8dK8pdcQPMSyBLUphzM4giAwpnqP6nk7M=
=pBQs
-----END PGP SIGNATURE-----

--tntbww4ujgs3gjvq--
