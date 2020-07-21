Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C850EC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B32AA20658
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 11:27:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgGUL1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 07:27:45 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:51918 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgGUL1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 07:27:43 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9DC911C0BE5; Tue, 21 Jul 2020 13:27:40 +0200 (CEST)
Date:   Tue, 21 Jul 2020 13:27:40 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Pavel Machek <pavel@denx.de>, stable@kernel.org,
        kernel list <linux-kernel@vger.kernel.org>, gregkh@duo.ucw.cz,
        roscaeugeniu@gmail.com, stern@rowland.harvard.edu,
        qais.yousef@arm.com, linux@prisktech.co.nz,
        mathias.nyman@intel.com, oneukum@suse.de, linux-usb@vger.kernel.org
Subject: Re: hibernation reverts in 4.19.134: better alternative?
Message-ID: <20200721112740.GA17778@duo.ucw.cz>
References: <20200720101522.GB13137@amd>
 <20200721065054.GA8290@lxhi-065.adit-jv.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
In-Reply-To: <20200721065054.GA8290@lxhi-065.adit-jv.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> On Mon, Jul 20, 2020 at 12:15:22PM +0200, Pavel Machek wrote:
> > This is queued for 4.19.134-stable, reverting 3 patches. But it seems
> > better alternative is available...
> >=20
> > commit f3e697b7b6f5e2c570226f8f8692fb7db57215ec
> > Author: Sasha Levin <sashal@kernel.org>
> > Date:   Fri Jul 17 12:58:32 2020 -0400
> >=20
> >     Revert "usb/ohci-platform: Fix a warning when hibernating"
> >    =20
> >     This reverts commit c83258a757687ffccce37ed73dba56cc6d4b8a1b.
> >    =20
> >     Eugeniu Rosca writes:
> >=20
> > ...
> >=20
> >     > - Backporting 987351e1ea7772 ("phy: core: Add consumer device
> >     >   link support") to v4.14.187 looks challenging enough, so probab=
ly not
> >     >   worth it. Anybody to contradict this?
> >=20
> > Backporting 987351e1ea7772 to 4.4 may be "interesting", but backport
>=20
> Typo? 4.14 meant?

4.4 meant. I care about 4.4 and 4.19.

> > to 4.19 seems trivial, here, and it seems to work ok according to CIP
> > test suites:
> >=20
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1684874=
77
> >=20
> > (You can simply apply 987351e1ea7772 ignoring one file that is not yet
> > present in 4.19.)
>=20
> Technically yes. Backporting 987351e1ea7772 to v4.19.x avoids the panic.
> But it means integrating a v5.6 feature (isn't 987351e1ea7772 one?) into
> the v4.19.x stable tree. Isn't v4.19.x (just like any other stable
> branch) supposed to contain just fixes?

Well, backport might be preffered to reverting 3 patches that will
re-introduce WARN()s. Yes, documentation does not match reality here.

> Should then any missing prerequisite features be pumped in into the
> stable tree, whenever backporting a bugfix produces unexpected results?
>=20
> FWIW I confirm that:
> * setup [A] leads to the issue reported in [C]
> * setup [B] resolves the issue reported in [C]

Thank you!

> [A] v4.19 + 16bdc04cc98 + 1cb3b0095c3 + 79112cc3c29f
> [B] v4.19 + 16bdc04cc98 + 1cb3b0095c3 + 79112cc3c29f + 987351e1ea7
> [C] https://lore.kernel.org/linux-usb/20200709070023.GA18414@lxhi-065.adi=
t-jv.com/

Best regards,
								Pavel
--=20
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXxbRLAAKCRAw5/Bqldv6
8gemAKCaQwdHz0sm2+FFlMPzlc0Mr9Bt2gCffVQ9yd4JJPpnRhhrQP873z6IUi8=
=UcJi
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--
