Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956D0C54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FB020663
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGVJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:09:57 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:40690 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgEGVJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:09:57 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 38AD11C0257; Thu,  7 May 2020 23:09:55 +0200 (CEST)
Date:   Thu, 7 May 2020 23:09:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Xing Zhang <Xing.Zhang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Murphy <dmurphy@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v1] Add support for MediaTek regulator vibrator driver
Message-ID: <20200507210954.GB19557@duo.ucw.cz>
References: <20200429081759.26964-1-Xing.Zhang@mediatek.com>
 <20200507174519.GD1216@bug>
 <49089bf3-d64b-2a50-269c-623a6ea9c14c@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cvVnyQ+4j833TQvp"
Content-Disposition: inline
In-Reply-To: <49089bf3-d64b-2a50-269c-623a6ea9c14c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cvVnyQ+4j833TQvp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2020-05-07 22:45:35, Jacek Anaszewski wrote:
> Hi Pavel,
>=20
> On 5/7/20 7:45 PM, Pavel Machek wrote:
> > Hi!
> >=20
> > > This patchset add regulator vibrator driver for MTK Soc. The driver
> > > controls vibrator through regulator's enable and disable.
> >=20
> > We'd prefer not to have vibrators in led subsystem.
> >=20
> > >=20
> > > Xing Zhang (3):
> > >    dt-bindings: add regulator vibrator documentation
> > >    arm64: mediatek: Add regulator vibrator support
> > >    Vibrator: Add regulator vibrator driver
> > >=20
> > >   .../bindings/leds/regulator-vibrator.txt      |  39 ++
> > >   arch/arm64/configs/defconfig                  |   1 +
> > >   drivers/leds/Kconfig                          |  10 +
> > >   drivers/leds/Makefile                         |   1 +
> > >   drivers/leds/regulator-vibrator.c             | 450 +++++++++++++++=
+++
> >=20
> > OTOH, connecting LED to regulator might make some sense. I can take the=
 driver with
> > vibrator functionality stripped, provided it is named the usual way...
>=20
> We already had an attempt of solving this in more generic way [0],
> but you opposed then [1]. Just for the record.

That's something different. led-regulator.c might be
acceptable. Special code to support vibrator quirks... not so much.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cvVnyQ+4j833TQvp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXrR5IgAKCRAw5/Bqldv6
8rhUAJwNZ8AJbpTJwM0okF7XO54EiI6dkQCfdJRagMkst3LRHughjgIVPDh4RiA=
=07yZ
-----END PGP SIGNATURE-----

--cvVnyQ+4j833TQvp--
