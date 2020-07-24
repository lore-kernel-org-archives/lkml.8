Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BD7C433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB8EE206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:15:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgGXJPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbgGXJPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:15:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE5BC0619E4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 02:15:16 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1jytnL-0003D4-HH; Fri, 24 Jul 2020 11:15:11 +0200
Received: from ore by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ore@pengutronix.de>)
        id 1jytnH-0004vH-88; Fri, 24 Jul 2020 11:15:07 +0200
Date:   Fri, 24 Jul 2020 11:15:07 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: Re: [PATCH net-next v1 5/5] net: phy: micrel: ksz886x/ksz8081: add
 cabletest support
Message-ID: <20200724091507.s7g5ijt7mfussmk2@pengutronix.de>
References: <20200710120851.28984-1-o.rempel@pengutronix.de>
 <20200710120851.28984-6-o.rempel@pengutronix.de>
 <20200711182912.GP1014141@lunn.ch>
 <20200713041129.gyoldkmsti4vl4m2@pengutronix.de>
 <20200713151719.GE1078057@lunn.ch>
 <20200714072501.GA5072@pengutronix.de>
 <20200714131240.GE1140268@lunn.ch>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="muunsg545bfq5xay"
Content-Disposition: inline
In-Reply-To: <20200714131240.GE1140268@lunn.ch>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:13:03 up 252 days, 31 min, 251 users,  load average: 0.08, 0.05,
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


--muunsg545bfq5xay
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2020 at 03:12:40PM +0200, Andrew Lunn wrote:
> > OK. So, i'll cover both errata with separate flags? Set flags in the DSA
> > driver and apply workarounds in the PHY. ACK?
>=20
> Yes. Assume the issues are limited to just the first PHY in this
> switch. If there are discrete PHYs with the same issue, we can come up
> with a different way to identify them.

I assume, it is not the blocker for the current patch set?

Regards,
Oleksij

--=20
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--muunsg545bfq5xay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEERBNZvwSgvmcMY/T74omh9DUaUbMFAl8appUACgkQ4omh9DUa
UbNp6g//UD2UD0ig5iyJhR2aFdXq7oYLOh05ez87jUoZWUiSoEz8hGw1EsB9uIiQ
8MDo/IckZWsE91V7dkIWUEDNBq6Pe7r92l4+WcRjrqQpqlx+msgtyVCqL/ct9T+r
STrrusugUIzund5vfZ2FSRGGPfrlAtQhsuoVDeMrCBF1r68CCA1VDp/N+QWodRv3
hd644fT5O1XT/jtoXgYzM2X87fqrZ72sQimnFa7nuiyg+SMbf49XbX+uLI2VRuEy
5HRwyQMr/MH2u8wDKWFdaHyUSPv5MgUeoUUsWHjGAdok6byUgPrbFATF1hFObNJZ
dZmximROHc24xvtzbvroSq3r6ABdQe0das3/qeqP2T9UQ3Gk+dtj4Jjuc2Evh0eS
fNNZOiEKfDynBmaJmeiObc8qZX2tDhQKzXORPOQ9AEK5zpFhhH17K/ZkRmbPGEcS
taw6w+q9SENr2eIo5yjDuzYM6HmjIqRFAlloWfkHR4d3GSwBIoo6+rl1ydKAPLUW
XrGc56Aq7aObtPbNA/jC4MwVfPZIRy++tQczCyHQemDblGkqEQuv+/qsGa9xfKIy
+YfkwUpslsRBF+axEOuKjXtsokMJPI4/uqD6cgzldYXAROQBXdIxFpX/XlNDFPUq
2nGdAwo/SrcYvkETxGSf6VUkxajpMlGsiQNfEwipbskY8rzr2bA=
=Lc0c
-----END PGP SIGNATURE-----

--muunsg545bfq5xay--
