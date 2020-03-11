Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B93C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A476F20737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583956676;
	bh=zWn91M4ieW3uyWmeopnLk/XJ/uaRZCNqXuoSYUTcaNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jFSJG0N4wkF9YHnO75+V2wQjf4ATUJ0aR8Ow1nlOQ+E8XQ6n/Dvk7aMc/E4LGdMG6
	 mYmQPECbeOGRCyxGmol+g6R0J3E/tANb6b6CFtYCWCl2/OqVKfVdBBzD9ZD8d50CPU
	 F2PkRb3Y3wHxaUewrStbTowwjZD5sPeXAhRwMzms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387467AbgCKT5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:57:54 -0400
Received: from foss.arm.com ([217.140.110.172]:54778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387409AbgCKT5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:57:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 199F71FB;
        Wed, 11 Mar 2020 12:57:53 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EEF73F534;
        Wed, 11 Mar 2020 12:57:52 -0700 (PDT)
Date:   Wed, 11 Mar 2020 19:57:50 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        vigneshr@ti.com, richard@nod.at, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, robh+dt@kernel.org,
        linux-mediatek@lists.infradead.org, miquel.raynal@bootlin.com,
        matthias.bgg@gmail.com, gch981213@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] mtd: spi-nor: remove mtk-quadspi driver
Message-ID: <20200311195750.GL5411@sirena.org.uk>
References: <20200306085052.28258-1-gch981213@gmail.com>
 <20200309121020.GD4101@sirena.org.uk>
 <2471214.x7VzW1FXlQ@localhost.localdomain>
 <4427171.IzkiAjLLdB@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TnYVF1hk1c8rpHiF"
Content-Disposition: inline
In-Reply-To: <4427171.IzkiAjLLdB@localhost.localdomain>
X-Cookie: I'm a Lisp variable -- bind me!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TnYVF1hk1c8rpHiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2020 at 09:11:29AM +0000, Tudor.Ambarus@microchip.com wrote:

> You can also create an immutable tag that I can merge in my spi-nor/next=
=20
> branch, so that Linus doesn't have to deal with the conflict.

The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/mtk-=
mtd-spi-move

for you to fetch changes up to e11e8473bcec748c3820636f11b986f611c9309b:

  mtd: spi-nor: remove mtk-quadspi driver (2020-03-11 19:56:08 +0000)

----------------------------------------------------------------
spi: Rewrite mtk-quadspi spi-nor driver with spi-mem

This patchset from Chuanhong Guo <gch981213@gmail.com> adds a spi-mem
driver for Mediatek SPI-NOR controller, which already has limited
support by mtk-quadspi. This new driver can make use of full quadspi
capability of this controller.

----------------------------------------------------------------
Chuanhong Guo (4):
      spi: make spi-max-frequency optional
      spi: add support for mediatek spi-nor controller
      dt-bindings: convert mtk-quadspi binding doc for spi-mtk-nor
      mtd: spi-nor: remove mtk-quadspi driver

 .../{mtd/mtk-quadspi.txt =3D> spi/spi-mtk-nor.txt}   |  15 +-
 drivers/mtd/spi-nor/Kconfig                        |   8 -
 drivers/mtd/spi-nor/Makefile                       |   1 -
 drivers/mtd/spi-nor/mtk-quadspi.c                  | 565 -----------------
 drivers/spi/Kconfig                                |  10 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-mtk-nor.c                          | 689 +++++++++++++++++=
++++
 drivers/spi/spi.c                                  |   9 +-
 8 files changed, 708 insertions(+), 590 deletions(-)
 rename Documentation/devicetree/bindings/{mtd/mtk-quadspi.txt =3D> spi/spi=
-mtk-nor.txt} (75%)
 delete mode 100644 drivers/mtd/spi-nor/mtk-quadspi.c
 create mode 100644 drivers/spi/spi-mtk-nor.c

--TnYVF1hk1c8rpHiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5pQr0ACgkQJNaLcl1U
h9BuJgf+J4BVeDZ89cXm1ecHsmkFxwEbC3B2+ALUZTKsTZ4n5rM4aliKanEGJ5XX
llfEUpxE7QAnZE9vv8yoKCfE8njVTTmyYi2TBJKg0hrcXb1Q3pvbsQJTO8uXm57g
iajxxjrO0mdISzR0gErKYgJjdDyIUThSR89v5b7YXpWP4dHf7JSA4qwIWFhOLCZd
fX3G8RIjqXkSJx2yKPjK7+xkA7u7GvP7U9kt1Nynt1NOlRtGyUywUZblL5MhZ2MG
Bjln0lpBnhN285Mvntm49LmpoEnPdeHzbozsMVZHmD0+sdpGZ8PIQSiILb/mGCJf
jpg/Q++KbM01LDw26eSGVIsnqAFBdA==
=Neg9
-----END PGP SIGNATURE-----

--TnYVF1hk1c8rpHiF--
