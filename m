Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5DF5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:54:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8804207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbgG2WyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:54:11 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:44352 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbgG2WyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:54:11 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9071C1C0C13; Thu, 30 Jul 2020 00:54:09 +0200 (CEST)
Date:   Thu, 30 Jul 2020 00:54:09 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, tony@atomide.com,
        merlijn@wizzup.org, martin_rysavy@centrum.cz,
        maemo-leste@lists.dyne.org
Subject: Re: [maemo-leste] Modem on Droid 4 (mdm6600) in recent mainline
Message-ID: <20200729225409.wqboxq77ryvmmxhe@duo.ucw.cz>
References: <20200729220803.GA553@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="6myjq22emsku76i4"
Content-Disposition: inline
In-Reply-To: <20200729220803.GA553@amd>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6myjq22emsku76i4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> There's something very wrong with /dev/ttyUSB4 in recent kernels:
> unsolicited incoming data from the modem are getting lost; I believe
> it means also SMS notifications, but it is very easy to reproduce with
> incoming call notifications.
>=20
> They just don't come.
>=20
> But if you keep pasting "AT" into minicom, they actually do.
>=20
> Of course... that means that trying to debug ofono is ... "interesting".
>=20
> I tried playing with
> /sys/bus/platform/drivers/phy-mapphone-mdm6600/usb-phy\@1/power/control
> files and timeouts, but could not get it to work.
>=20
> Any idea what could be wrong there?
>=20
> Is there easy way to disable power management for testing?

I tried this... and it did not fix the problem :-(.

									Pavel

diff --git a/drivers/phy/motorola/phy-mapphone-mdm6600.c b/drivers/phy/moto=
rola/phy-mapphone-mdm6600.c
index 94a34cf75eb3..7ddf5aa35105 100644
--- a/drivers/phy/motorola/phy-mapphone-mdm6600.c
+++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
@@ -21,7 +21,7 @@
 #define PHY_MDM6600_PHY_DELAY_MS	4000	/* PHY enable 2.2s to 3.5s */
 #define PHY_MDM6600_ENABLED_DELAY_MS	8000	/* 8s more total for MDM6600 */
 #define PHY_MDM6600_WAKE_KICK_MS	600	/* time on after GPIO toggle */
-#define MDM6600_MODEM_IDLE_DELAY_MS	1000	/* modem after USB suspend */
+#define MDM6600_MODEM_IDLE_DELAY_MS	100000000	/* modem after USB suspend */
 #define MDM6600_MODEM_WAKE_DELAY_MS	200	/* modem response after idle */
=20
 enum phy_mdm6600_ctrl_lines {


--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--6myjq22emsku76i4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXyH+EQAKCRAw5/Bqldv6
8qk2AJ9JggBntoRtGpJeDOf8Ym6s468QawCfV+5wKcPO0hpIPY/1CL6AFH9rdFo=
=v0CY
-----END PGP SIGNATURE-----

--6myjq22emsku76i4--
