Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57BDEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CA85207F5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 18:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593626958;
	bh=oRoMkCtjdUg55KH56aj8mpptY7/t3IumKCMW0WzoHd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XSpfsckyYOqSFXUPVxIJPrgwO7p/mYYfraHhx7+2u80rh5PnG+PFdc/xcVMsZkhXH
	 QXbEzQAgMbN+Ze/ScwpAFyG/OVKnRiVgGKCpmJ74OwDLVxaWbr4QOimXJ5PUpuxkuw
	 4kLfD+bljqdgYuNgs8xd6AV5aPyX3yO9CHK0fjiE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbgGASJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 14:09:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgGASJQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 14:09:16 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25E80207F5;
        Wed,  1 Jul 2020 18:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593626955;
        bh=oRoMkCtjdUg55KH56aj8mpptY7/t3IumKCMW0WzoHd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SQ3o1PnPswZBz/haPZrL4LB0SQ1An4nKpJPR55M96+NjSjI2gdan5iwXlZW6td/Qz
         ziEFoDkOc4eE6a+w4Zpo8/MgSkCx3p1t6fYlS3Ot3X8VKPwT4RULNrF7VICH0k2esD
         c17ACg3qA9KWbGLofFSehLPEEYOGBTE9dHjqG0ek=
Date:   Wed, 1 Jul 2020 19:09:13 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Christoph Fritz <chf.fritz@googlemail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] regulator: fan53880: Add initial support
Message-ID: <20200701180913.GA22871@sirena.org.uk>
References: <20200630185203.22882-1-chf.fritz@googlemail.com>
 <20200630185203.22882-2-chf.fritz@googlemail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
In-Reply-To: <20200630185203.22882-2-chf.fritz@googlemail.com>
X-Cookie: fortune: No such file or directory
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2020 at 08:52:02PM +0200, Christoph Fritz wrote:
> This patch adds support for ON Semiconductor FAN53880 regulator.
>=20
> The FAN53880 is an I2C porgrammable power management IC (PMIC)
> that contains a BUCK (step-down converter), four LDOs (low dropouts)
> and one BOOST (step-up converter).  It is designed for mobile power
> applications.

This doesn't build with current code, there are *many* errors in the
form

/mnt/kernel/drivers/regulator/fan53880.c:48:52: error: array type has incom=
plete element type 'struct regulator_linear_range'
   .linear_ranges =3D   (struct regulator_linear_range[]) { \
                                                    ^
/mnt/kernel/drivers/regulator/fan53880.c:63:2: note: in expansion of macro =
'FAN53880_LDO'
  FAN53880_LDO(1, "VIN12", 2800000),
  ^~~~~~~~~~~~
In file included from /mnt/kernel/drivers/regulator/fan53880.c:5:
/mnt/kernel/include/linux/regulator/driver.h:46:2: error: field name not in=
 record or union initializer
  .min  =3D _min_uV,     \
  ^
/mnt/kernel/drivers/regulator/fan53880.c:49:9: note: in expansion of macro =
'REGULATOR_LINEAR_RANGE'
         REGULATOR_LINEAR_RANGE(_default, 0x0, 0x0, 0), \
         ^~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/regulator/fan53880.c:63:2: note: in expansion of macro =
'FAN53880_LDO'
  FAN53880_LDO(1, "VIN12", 2800000),
  ^~~~~~~~~~~~
/mnt/kernel/include/linux/regulator/driver.h:46:2: note: (near initializati=
on for '(anonymous)')
  .min  =3D _min_uV,     \
  ^
/mnt/kernel/drivers/regulator/fan53880.c:49:9: note: in expansion of macro =
'REGULATOR_LINEAR_RANGE'
         REGULATOR_LINEAR_RANGE(_default, 0x0, 0x0, 0), \
         ^~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/regulator/fan53880.c:63:2: note: in expansion of macro =
'FAN53880_LDO'
  FAN53880_LDO(1, "VIN12", 2800000),
  ^~~~~~~~~~~~
/mnt/kernel/include/linux/regulator/driver.h:47:2: error: field name not in=
 record or union initializer
  .min_sel =3D _min_sel,     \
  ^

most likely due to the conversion introduced in 60ab7f4153b6af46
(regulator: use linear_ranges helper).  Please rebase against current
code.

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl780UgACgkQJNaLcl1U
h9AT8wf495r68vZKdK9avH8NnewD+DkphtHtdWLDgwWHgGUfGPmb+QzTFzE00v6W
FdLMuOPaUfnBn/bKB6Dzzoh/qm2ZK37JkyQOLEQhOBtCbkutE6T/rFWRgMGJvBl0
+BKye8EojxtIhOBD2qSinQ4pTWudULWCFFZoPOhm63IPDbOcdMQmLi3X+8EkXGqd
YBIStS9+jfH9yCG9h4p3+VYlIG1OEwiZekjFgpFAgTT1E4vcJhhspC1NjP3XRMCD
C/eqSRdAOjEy2GvOH0Dao7/UgEyZXvmOJ1kjQK4AN8ZpjvpgU0iee9pFDQkCoZfV
1vJQajBaumpmIymOESyi1WndLydF
=xM/a
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
