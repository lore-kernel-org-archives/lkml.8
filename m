Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D1AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 625B62065E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbgGVMBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:01:44 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:50550 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgGVMBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:01:44 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 515C81C0BD8; Wed, 22 Jul 2020 14:01:41 +0200 (CEST)
Date:   Wed, 22 Jul 2020 14:01:41 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Diego Elio =?iso-8859-1?Q?Petten=F2?= <flameeyes@flameeyes.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19 048/133] scsi: sr: remove references to
 BLK_DEV_SR_VENDOR, leave it enabled
Message-ID: <20200722120140.GA25691@duo.ucw.cz>
References: <20200720152803.732195882@linuxfoundation.org>
 <20200720152806.028495676@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <20200720152806.028495676@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> [ Upstream commit 679b2ec8e060ca7a90441aff5e7d384720a41b76 ]
>=20
> This kernel configuration is basically enabling/disabling sr driver quirks
> detection. While these quirks are for fairly rare devices (very old CD
> burners, and a glucometer), the additional detection of these models is a
> very minimal amount of code.
>=20
> The logic behind the quirks is always built into the sr driver.
>=20
> This also removes the config from all the defconfig files that are enabli=
ng
> this already.

Why is this in -stable?

It forcefully enables code most people don't need, and is rather
intrusive with all the defconfig changes.

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXxgqpAAKCRAw5/Bqldv6
8ohrAJ4oXa8axcrJxmXQigNUOyMg2QlWNACfUsuMov4hoTyleJULjW4o+Mlujus=
=P1Uz
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
