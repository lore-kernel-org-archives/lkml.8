Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D56BC55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6747D2073A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:40:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgDUHkC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgDUHkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:40:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8DEAC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 00:40:01 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jQnVa-0001KH-KN; Tue, 21 Apr 2020 09:39:54 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jQnVa-00047T-5r; Tue, 21 Apr 2020 09:39:54 +0200
Date:   Tue, 21 Apr 2020 09:39:54 +0200
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
Message-ID: <20200421073954.dh4omcokxap2vh2v@pengutronix.de>
References: <20200324110432.25062-1-o.rempel@pengutronix.de>
 <20200324110432.25062-3-o.rempel@pengutronix.de>
 <20200421040747.GE8571@dragon>
 <20200421073713.hnv3poogl65ln77w@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yldmmw33f7ntstg3"
Content-Disposition: inline
In-Reply-To: <20200421073713.hnv3poogl65ln77w@pengutronix.de>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 09:38:50 up 157 days, 22:57, 167 users,  load average: 0.13, 0.10,
 0.09
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yldmmw33f7ntstg3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2020 at 09:37:13AM +0200, Oleksij Rempel wrote:
> Hi Shawn,
>=20
> Thank you for the review. You was reviewing v3, the last version is v5.
> Never the less, part of comments still apply. I'll fix them.
>=20
>=20
> On Tue, Apr 21, 2020 at 12:07:49PM +0800, Shawn Guo wrote:
> > On Tue, Mar 24, 2020 at 12:04:29PM +0100, Oleksij Rempel wrote:
> > > Protonic PRTI6Q is a development board and a base class for different
> > > specific customer application boards based on the i.MX6 family of SoC=
s,
> > > developed by Protonic Holland.
> > >=20
> > > Signed-off-by: David Jander <david@protonic.nl>
> > > Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> > > ---
>=20
> > > +&usdhc2 {
> > > +	pinctrl-names =3D "default";
> > > +	pinctrl-0 =3D <&pinctrl_usdhc2>;
> > > +	non-removable;
> > > +	vmmc-supply =3D <&reg_wifi>;
> > > +	cap-power-off-card;
> > > +	keep-power-in-suspend;
> > > +	status =3D "okay";
> > > +
> > > +	wifi {
> > > +		compatible =3D "ti,wl1271";
> > > +		pinctrl-names =3D "default";
> > > +		pinctrl-0 =3D <&pinctrl_wifi>;
> > > +		irq-gpio =3D <&gpio1 30 GPIO_ACTIVE_HIGH>;
> >=20
> > I failed to find this in "ti,wl1271" bindings.
>=20
> Indeed. But it is required by the code:
>=20
> drivers/net/wireless/ti/wlcore/sdio.c:
> static int wlcore_probe_of(struct device *dev, int *irq, int *wakeirq,
> 			   struct wlcore_platdev_data *pdev_data)
> {
> ....
> 	*irq =3D irq_of_parse_and_map(np, 0);
> 	if (!*irq) {
> 		dev_err(dev, "No irq in platform data\n");
> 		return -EINVAL;
> 	}
>=20
> I'll send a patch to fix it.


Ah.. forget it, my mistake. It should be interrupts.

Regards,
Oleksij
--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--yldmmw33f7ntstg3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl6eo0kACgkQ4omh9DUa
UbNblw/9HVrRv9NQo100spx7YQPlrOsoOMy3ti3SUlnExUfoTh0HIa6S7tzfE5rh
DYN8cgfxp/EwAg81w4BK0qBwv1CNu0Z7aCjxD8m0nVRAojoz9E00BwWIrmppY2Gj
8722PAA/lVwXNwhsw9wnG7I19iBrYaUsFfogff2w6MEUhzim0lDVYQ4j8DQwFs5x
88FuXM34yJliQ5G6b+GWDRJVJR2m6ULBKSX5tZxFrG8P4t648HrM+gpEP69/0Joy
MlEkbwzohcc2Y5cJcFlc1twxgapdM+zI0iGs9jZTg9gg+S+WZl9XG9ZfB+JTUujC
MZ1NMg/bVnaDyTHqwACEgehBLKPVlUy2s2EOxIVOr+JAXeMsfaF6eTlR8HE0BWCX
tAhH5x54N5493O+lZeVFD3nFizptb5MpEAzDmNHdLEBrX/1ms8+eEnL0cYQqzyRz
sLqud802H/8tc8RveBBso3lNHGOpPTUimpp7/GoZSGdHvula95ZU49E/fpPE0ggL
imC17uBNagu9WB/dTyBLavYnIDly34wSJURWQaT1tByDjp2y+/r42/esVF31LajP
xFW+bRUUDjPpboGlZqNDedkk39U9jLFnJEFN4XH3g5YJIYZBeS64y4LSrlIGcmnC
FQqGG8+XwX3DwKnJyVM13KKnAR675h+eRheFJaLIhWVy5fZ0/W4=
=5rx1
-----END PGP SIGNATURE-----

--yldmmw33f7ntstg3--
