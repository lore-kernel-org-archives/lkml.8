Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B713C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 06:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 276A420776
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 06:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgEVGD0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 02:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbgEVGD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 02:03:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBC2C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 23:03:25 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jc0mA-0001ss-IU; Fri, 22 May 2020 08:03:22 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jc0m9-0001bD-HH; Fri, 22 May 2020 08:03:21 +0200
Date:   Fri, 22 May 2020 08:03:21 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     robh@kernel.org
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 5/5] dt-bindings: arm: fsl: add different Protonic
 boards
Message-ID: <20200522060321.j73heuzhughmrvrw@pengutronix.de>
References: <20200520154116.12909-1-o.rempel@pengutronix.de>
 <20200520154116.12909-6-o.rempel@pengutronix.de>
 <20200521200002.GA2800876@bogus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bqrs4b63lj2fy3tv"
Content-Disposition: inline
In-Reply-To: <20200521200002.GA2800876@bogus>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:01:27 up 188 days, 21:20, 178 users,  load average: 0.24, 0.14,
 0.04
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bqrs4b63lj2fy3tv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2020 at 02:00:02PM -0600, robh@kernel.org wrote:
> On Wed, 20 May 2020 17:41:16 +0200, Oleksij Rempel wrote:
> > Add Protonic PRTI6Q, WD2, RVT, VT7 boards.
> >=20
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
>=20
>=20
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>=20
> If a tag was not added on purpose, please state why and what changed.

Sorry, there is no special reason. I just missed it.

Regards,
Oleksij
--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--bqrs4b63lj2fy3tv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl7HayEACgkQ4omh9DUa
UbMcmg//c0+BK3cTveZkOGqDqq4z9leCABwaeqO9pETzG5eMyjwl8c/AktiGc43O
BVAx2ejlrRPSOfH9Y6NtMd3qkF563mqYfK+L9OWmhvnk6pfN9rgnxNxNE8ZBqT3+
AwjaOBVD6+YhzOxFk/pywM4E96ER5h4A3PB6lYoQo88nzTSfv3aSxzwh5IzyISOL
oAZYO+cs+XDi5Snj1r2gfjuFIRoHbc8dTX1v3m3nefkKdHI3pDPgB7AckE9OtPEW
io/87X3WevPbd7JqEBWqR5LoB+SLse8DTAqNwwZSV+W5GeNAWFY/tnHz5wJPy68c
nYtJN6hMjZ5o9pVLFtYpVhM1MVJOJ/nCC3DtKO6vDU4RN+yulgtXEWPC4sXYaB7P
6qmaCnQ0s+cFkEPCexG/6NpBAgexFd4OtHwZpvDUW9IMRK8ln5YIn4PC2YsNBJuh
gC9Is07Q6JvdggqSa+QqZBNMow/gpZpNaTRVI6w/Xg7oQv9nVAEQuipCH291nt0F
NNKGSzMYwCh7nMAdvOAlV0xpx/ruPrJG9C2PpJwQtyPFBUj2BOjdgsm56pW1qN7M
be4HakGTav/oiuwqz0v+D3q/UvnHyi8NKWw5akhBk8dYWcFdkjo90Yv4YIHLNE/w
pWluoSaAUk4orYOZpEZ48sB5e18uuKCIX388QTf3WLgm0Zo8bIE=
=EHZY
-----END PGP SIGNATURE-----

--bqrs4b63lj2fy3tv--
