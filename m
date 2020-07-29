Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E63C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4CAF206D8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgG2WIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:08:07 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:41154 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726628AbgG2WIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:08:07 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 984F21C0C0B; Thu, 30 Jul 2020 00:08:04 +0200 (CEST)
Date:   Thu, 30 Jul 2020 00:08:03 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, tony@atomide.com,
        merlijn@wizzup.org, martin_rysavy@centrum.cz,
        maemo-leste@lists.dyne.org
Subject: Modem on Droid 4 (mdm6600) in recent mainline
Message-ID: <20200729220803.GA553@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

There's something very wrong with /dev/ttyUSB4 in recent kernels:
unsolicited incoming data from the modem are getting lost; I believe
it means also SMS notifications, but it is very easy to reproduce with
incoming call notifications.

They just don't come.

But if you keep pasting "AT" into minicom, they actually do.

Of course... that means that trying to debug ofono is ... "interesting".

I tried playing with
/sys/bus/platform/drivers/phy-mapphone-mdm6600/usb-phy\@1/power/control
files and timeouts, but could not get it to work.

Any idea what could be wrong there?

Is there easy way to disable power management for testing?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--DocE+STaALJfprDB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8h80IACgkQMOfwapXb+vI5uACgqIJpI2GbVhRm/EFY2QD3Iiy7
aVUAn3VVTiu8spgdZQc6S4bk9gfTGryg
=bS/8
-----END PGP SIGNATURE-----

--DocE+STaALJfprDB--
