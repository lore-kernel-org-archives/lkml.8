Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47C3C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 16:26:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821122071E
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 16:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbgHAQ0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 12:26:14 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:38890 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgHAQ0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 12:26:13 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 277651C0BD4; Sat,  1 Aug 2020 18:26:11 +0200 (CEST)
Date:   Sat, 1 Aug 2020 18:26:10 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     kernel list <linux-kernel@vger.kernel.org>, tony@atomide.com,
        merlijn@wizzup.org, martin_rysavy@centrum.cz,
        maemo-leste@lists.dyne.org
Subject: Re: [maemo-leste] Modem on Droid 4 (mdm6600) in recent mainline
Message-ID: <20200801162610.GA11576@amd>
References: <20200729220803.GA553@amd>
 <20200729225409.wqboxq77ryvmmxhe@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20200729225409.wqboxq77ryvmmxhe@duo.ucw.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > There's something very wrong with /dev/ttyUSB4 in recent kernels:
> > unsolicited incoming data from the modem are getting lost; I believe
> > it means also SMS notifications, but it is very easy to reproduce with
> > incoming call notifications.
> >=20
> > They just don't come.
> >=20
> > But if you keep pasting "AT" into minicom, they actually do.
> >=20
> > Of course... that means that trying to debug ofono is ... "interesting".
> >=20
> > I tried playing with
> > /sys/bus/platform/drivers/phy-mapphone-mdm6600/usb-phy\@1/power/control
> > files and timeouts, but could not get it to work.
> >=20
> > Any idea what could be wrong there?
> >=20
> > Is there easy way to disable power management for testing?
>=20
> I tried this... and it did not fix the problem :-(.

This does fix the problem:

# writing to ttyUSB3 eventually crashes the modem
# ttyUSB0 -- works w/o delay for an hour.
date
DEV=3D/dev/ttyUSB0
while test -e $DEV; do
  echo > $DEV
    sleep .3
      done
      date

=2E..and with that:

1) AT commands work over ttyUSB4; yes that interface is far away from
fully compliant with the standard.

2) AFAICT, there are attempts at delivering SMS messages over QMI:

ofonod[16913]: src/network.c:ofono_netreg_strength_notify() strength
60


ofonod[16913]: QMI: < 01 89 00 80 05 01 04 00 00 01 00 7d 00 11 7a 00
=2E..........}..z.
ofonod[16913]: QMI:   00 00 00 00 00 06 72 00 04 14 d0 d4 f2 7c fc 6e
=2E.....r......|.n
ofonod[16913]: QMI:   bf c5 69 76 19 00 00 02 80 10 81 61 21 80 68 d6
=2E.iv.......a!.h.
ofonod[16913]: QMI:   b0 be ec ce 83 f4 e1 75 58 ef 4e af eb 2c 90 38
=2E......uX.N..,.8
ofonod[16913]: QMI:   cf 7e 83 ac e1 36 c8 9e 3f 97 dd 65 f9 db 1e 76
=2E~...6..?..e...v
ofonod[16913]: QMI:   97 41 ee f0 9c 5d 26 d7 d5 e9 71 1a a4 2e 93 dd
=2EA...]&...q.....
ofonod[16913]: QMI:   6f 79 58 ff b6 97 41 e8 f2 9c fd 06 c1 e5 6f 10
oyX...A.......o.
ofonod[16913]: QMI:   5c 9e 9e d3 eb 70 10 f9 0d 9a 87 db ef b7 78 ce
\....p........x.
ofonod[16913]: QMI:   ae a3 f3 3a d0 8d 96 8b c5 70
=2E..:.....p
ofonod[16913]: QMI:     WMS_ind msg=3D1 len=3D125
[client=3D1,type=3D4,tid=3D0,len=3D137]
ofonod[16913]: QMI:        {type=3D17,len=3D122}
ofonod[16913]: drivers/qmimodem/sms.c:event_notify()
ofonod[16913]: drivers/qmimodem/sms.c:event_notify() ack_required 0
transaction id 0
ofonod[16913]: drivers/qmimodem/sms.c:event_notify() msg format 6 PDU
length 114
ofonod[16913]: src/sms.c:ofono_sms_deliver_notify() len 114 tpdu len
114
ofonod[16913]: src/sms.c:handle_deliver()
ofonod[16913]: src/sms.c:sms_dispatch()
ofonod[16913]: src/sms.c:sms_dispatch() dst -1 src -1
ofonod[16913]: Aborting (signal 11) [src/ofonod]
user@devuan:/my/ofono$

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8ll6IACgkQMOfwapXb+vKwrgCfQXdUVsmCFqXei5+vsZjgKqvw
eHcAn3R/vQTQrd94sxldzTwHgbez1zAZ
=U4P9
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
