Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9522C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925FE24649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbgCIWd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:33:26 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36766 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgCIWd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:33:26 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 50CD81C0315; Mon,  9 Mar 2020 23:33:24 +0100 (CET)
Date:   Mon, 9 Mar 2020 23:33:23 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-can@vger.kernel.org, yangerkun@huawei.com,
        davem@davemloft.net, mkl@pengutronix.de, wg@grandegger.com
Subject: [PATCH] net: slcan, slip -- no need for goto when if () will do
Message-ID: <20200309223323.GA1634@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


No need to play with gotos to jump over single statement.

Signed-off-by: Pavel Machek <pavel@ucw.cz>

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 2f5c287eac95..686d853fc249 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -348,11 +348,8 @@ static void slcan_write_wakeup(struct tty_struct *tty)
=20
 	rcu_read_lock();
 	sl =3D rcu_dereference(tty->disc_data);
-	if (!sl)
-		goto out;
-
-	schedule_work(&sl->tx_work);
-out:
+	if (sl)
+		schedule_work(&sl->tx_work);
 	rcu_read_unlock();
 }
=20
diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index babb01888b78..f81fb0b13a94 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -456,11 +456,8 @@ static void slip_write_wakeup(struct tty_struct *tty)
=20
 	rcu_read_lock();
 	sl =3D rcu_dereference(tty->disc_data);
-	if (!sl)
-		goto out;
-
-	schedule_work(&sl->tx_work);
-out:
+	if (sl)
+		schedule_work(&sl->tx_work);
 	rcu_read_unlock();
 }
=20

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXmbEMwAKCRAw5/Bqldv6
8hDXAKCRVq42BcxWbNAQDXa2dXa0pOjB+gCcDrRW7amFSwxnqJ3+zMuISqvLn6s=
=6zMv
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
