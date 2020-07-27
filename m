Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50900C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A3442075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 06:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgG0Gip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 02:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgG0Gio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:38:44 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55183C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 23:38:44 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jzwmW-0004H6-Sg; Mon, 27 Jul 2020 08:38:40 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jzwmV-0004Hl-PW; Mon, 27 Jul 2020 08:38:39 +0200
Date:   Mon, 27 Jul 2020 08:38:39 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, festevam@gmail.com,
        s.hauer@pengutronix.de, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 00/10] remoteproc: imx_rproc: support iMX8M and early boot
Message-ID: <20200727063839.kfgrtperzkygvjr2@pengutronix.de>
References: <20200724080813.24884-1-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jgzy57rifx3b5uxa"
Content-Disposition: inline
In-Reply-To: <20200724080813.24884-1-peng.fan@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:27:50 up 254 days, 21:46, 240 users,  load average: 0.01, 0.03,
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


--jgzy57rifx3b5uxa
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jul 24, 2020 at 04:08:03PM +0800, Peng Fan wrote:
> This patchset is to support i.MX8MQ/M coproc booted before linux.
> Since i.MX8MQ/M was not supported, several patches are needed
> to first support the platform, then support early boot case.
>=20
> I intended to included i.MX8QM/QXP, but that would introduce a large
> patchset, so not included. But the clk/syscon optional patch for
> i.MX8QM/QXP was still kept here to avoid rebase error.

Thank you for your work.

Can you please provide more information about big picture of this work.

If I see it correctly, we have here support for i.MX8MM, which seems to
be able to fully control Cortex M4 (enable CPU core, etc...).

And other case, where remoteproc is running on application processor and
can't or should not touch M4 (i.MX7ULP, i.MX8QM/QXP..). Since M4
provides some functionality, you are trying to reuse remoteproc
framework to get resource table present in ELF header and to dynamically
load things. For some reasons this header provides more information then
needed, so you are changing the ELF parser in the kernel to workaround
it.

Correct?

> Peng Fan (10):
>   dt-bindings: remoteproc: imx_rproc: add i.MX8MQ/M
>   remoteproc: imx_rproc: correct err message
>   remoteproc: imx: use devm_ioremap
>   remoteproc: imx_rproc: make syscon optional
>   remoteproc: imx_rproc: make clk optional
>   remoteproc: imx_rproc: add load hook
>   remoteproc: imx_rproc: add i.MX specific parse fw hook
>   remoteproc: imx_rproc: support i.MX8MQ/M
>   remoteproc: imx_proc: enable virtio/mailbox
>   remoteproc: imx_rproc: support coproc booting before Linux
>=20
>  .../devicetree/bindings/remoteproc/imx-rproc.txt   |   3 +
>  drivers/remoteproc/imx_rproc.c                     | 409 +++++++++++++++=
+++++-
>  2 files changed, 401 insertions(+), 11 deletions(-)
>=20
> --=20
> 2.16.4
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>=20

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--jgzy57rifx3b5uxa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl8edmsACgkQ4omh9DUa
UbNQhBAAkwHiOS81ib5qVUSNvSbJ/1N33m/DR1gjUKkdZMTWcsMgzd9dZ9obP957
MYxTDIY2zH1lrCZEuGiVzrbRPyu85ORdd/baU8bM274gxA8i+GVYgJfiu0AcMWy6
jKa2B7gfvFEozIe7Xpw/VSd7hslzwzgEoTZfsaEU21tvF8oY2etidXrxJBLOT0aw
7yTtuAJVBpr1FFeAIy2g0tXypYv1UqiSkLLLXQEEKBFvZJg1fAaJehD4YbZw9iwo
H9tMmxy2sMbGrGISH4BLUOJ4NMxb5TOrs1HJxCQYgCovRTS5K+1aT7UYhMlBtfZ4
Cb16rKe/u+oFOSOcu6pyDUVhmW9nsiGpRpxXphG9bxMgXcPkJnW26rd3i1ZLGtGH
slM32ePpBOCCPdmU8l56+TVKveELEPE8zZcksWknGRc7hvI/EUUcqPLM4RG55fas
0T1nIX2O13kVyK/yBxJ0UzhIu2SkMzIEL/thsghW31FmAcQpODsFb8ZMw0IsN5vU
hXYHA8fJSCeU78rW7h1IpA/fWqNH23iMT5qKUWLjjHS/oh9cDNdEh7Nq8E8PyYu6
l5ONoPvvDjFXMeRnL35lHU82+qcw5JO6h7+0LoGc3zTYddewuBmAjhgX/ebcXjEJ
sFtSPFAquFbgPxeQ6MHl1ac5NW5Rdg/oGAr796y4LdHit2r0zfI=
=4XyE
-----END PGP SIGNATURE-----

--jgzy57rifx3b5uxa--
