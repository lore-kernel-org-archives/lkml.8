Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993B3C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0612073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgDUHhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgDUHhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:37:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E8BC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:37:22 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jQnT0-00017T-JC; Tue, 21 Apr 2020 09:37:14 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jQnSz-00045M-IL; Tue, 21 Apr 2020 09:37:13 +0200
Date:   Tue, 21 Apr 2020 09:37:13 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        David Jander <david@protonic.nl>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH v3 2/5] ARM: dts: add Protonic PRTI6Q board
Message-ID: <20200421073713.hnv3poogl65ln77w@pengutronix.de>
References: <20200324110432.25062-1-o.rempel@pengutronix.de>
 <20200324110432.25062-3-o.rempel@pengutronix.de>
 <20200421040747.GE8571@dragon>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4cydpp6pjv3rbmqg"
Content-Disposition: inline
In-Reply-To: <20200421040747.GE8571@dragon>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:23:29 up 157 days, 22:42, 166 users,  load average: 0.07, 0.07,
 0.08
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4cydpp6pjv3rbmqg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Shawn,

Thank you for the review. You was reviewing v3, the last version is v5.
Never the less, part of comments still apply. I'll fix them.


On Tue, Apr 21, 2020 at 12:07:49PM +0800, Shawn Guo wrote:
> On Tue, Mar 24, 2020 at 12:04:29PM +0100, Oleksij Rempel wrote:
> > Protonic PRTI6Q is a development board and a base class for different
> > specific customer application boards based on the i.MX6 family of SoCs,
> > developed by Protonic Holland.
> >=20
> > Signed-off-by: David Jander <david@protonic.nl>
> > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > ---

> > +&usdhc2 {
> > +	pinctrl-names =3D "default";
> > +	pinctrl-0 =3D <&pinctrl_usdhc2>;
> > +	non-removable;
> > +	vmmc-supply =3D <&reg_wifi>;
> > +	cap-power-off-card;
> > +	keep-power-in-suspend;
> > +	status =3D "okay";
> > +
> > +	wifi {
> > +		compatible =3D "ti,wl1271";
> > +		pinctrl-names =3D "default";
> > +		pinctrl-0 =3D <&pinctrl_wifi>;
> > +		irq-gpio =3D <&gpio1 30 GPIO_ACTIVE_HIGH>;
>=20
> I failed to find this in "ti,wl1271" bindings.

Indeed. But it is required by the code:

drivers/net/wireless/ti/wlcore/sdio.c:
static int wlcore_probe_of(struct device *dev, int *irq, int *wakeirq,
			   struct wlcore_platdev_data *pdev_data)
{
=2E...
	*irq =3D irq_of_parse_and_map(np, 0);
	if (!*irq) {
		dev_err(dev, "No irq in platform data\n");
		return -EINVAL;
	}

I'll send a patch to fix it.

Regards,
Oleksij
--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--4cydpp6pjv3rbmqg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl6eoqMACgkQ4omh9DUa
UbMcrxAApMsUmQ33pQEOrk9ulSJkkSg8xm+CMZKkas4aamjE0q+LOe97WArayMXB
db1ttp4L3b12I6qhcnDrgfhw+ZUduM+PU4ZD3MOi+F9Fy6nwkxJW2HQ3z/q1M6JN
Fy9UJtSTZ5dY74xtlL9mqZ/ifulWCuuxJxXjKkghe8lUcV2Nerf/X0+A72wHVep6
2bydbKk7Uu8ioBCLuHMOf1jXHNx2GhEmCc66B2VfpLcsitjy3l40+aEBW4JdBY+f
STmD6DW9VekFJxOnu1Z/IbFuIIIL+mjKUvAwb6sqXjmnr0DVq/XXN/FQ8fgHZRnq
AHHqhr3jOOqtHc/VHb2jFGgKAmGMYHdUbotlj/0gWy9Uxw0ZGV6tljL8imJ38/CJ
dbduR7qjQf3W5+XgouJTb2lq3DIzcQ6Fw5U2iIkdtHxNneigP0WVEA1sBL/ksgos
d2Lx6FRYF5gHbYerSiPGZH8f2tWHtsV6smAjHjXUF8sGxdLsUzmQDefL1iYOQNeJ
7N6nVssD+AWjJ0TzdEuorvTepcbKYfsjQlOrX9sMr7pwqAKIRgbd6nESrRgLIHbM
Yumu4MedWmr98zj9eXckVw8Ezedt/fMR3rXNI8OpM1f9G8qFSpU+zDI0cUIMc/He
5tVW6uxytjLe6//+mBrk1cKqHph4oiaOsPvARZ/NzBjEeqP9MXo=
=CZn8
-----END PGP SIGNATURE-----

--4cydpp6pjv3rbmqg--
