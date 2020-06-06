Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E60C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 15:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370562077D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 15:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgFFPhH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 11:37:07 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:58326 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgFFPhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 11:37:06 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 11A111C0BD2; Sat,  6 Jun 2020 17:37:05 +0200 (CEST)
Date:   Sat, 6 Jun 2020 17:37:03 +0200
From:   Pavel Machek <pavel@denx.de>
To:     hminas@synopsys.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>, trivial@kernel.org
Subject: [PATCH] sr: dwc2/gadget: remove unneccessary if
Message-ID: <20200606153703.GA18931@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We don't really need if/else to set variable to 1/0.

Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 12b98b466287..f9f6fd470c81 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -1761,10 +1761,7 @@ static int dwc2_hsotg_process_req_feature(struct dwc=
2_hsotg *hsotg,
 	case USB_RECIP_DEVICE:
 		switch (wValue) {
 		case USB_DEVICE_REMOTE_WAKEUP:
-			if (set)
-				hsotg->remote_wakeup_allowed =3D 1;
-			else
-				hsotg->remote_wakeup_allowed =3D 0;
+			hsotg->remote_wakeup_allowed =3D set;
 			break;
=20
 		case USB_DEVICE_TEST_MODE:

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--IS0zKkzwUGydFO0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl7buB8ACgkQMOfwapXb+vJ5lwCeJfyNpCyxeCljs/cjyrzXVJ8j
PB0AnRwbXKRnpGNDIqOpBWhpF0CLcLjl
=ddQV
-----END PGP SIGNATURE-----

--IS0zKkzwUGydFO0o--
