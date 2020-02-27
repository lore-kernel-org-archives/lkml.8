Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 395E9C3567B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0642E24677
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582820928;
	bh=PCjKORMBbMQ2LrgS5y4b7Ex0vbve5F8fpRfoJAjITFw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eh0fxVi37IMKWCQsvZ6WinIqQbFa0zl1Mu3X8o99MBbDKQWjGMNd6E00DH+ggne4b
	 QRq9p6n2sZOiYg84MjL/mt6vgIpTgs2yPOOU/i6IZfG49cRroFd3cDHgus1YFtY0Bn
	 P5goGr3qQYVq48Tbwpcg1sEcevjhi1LbVZFKBc44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgB0Q2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:28:47 -0500
Received: from foss.arm.com ([217.140.110.172]:54412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729263AbgB0Q2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:28:47 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 858671FB;
        Thu, 27 Feb 2020 08:28:44 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F12813F7B4;
        Thu, 27 Feb 2020 08:28:43 -0800 (PST)
Date:   Thu, 27 Feb 2020 16:28:42 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v2 01/11] dt-bindings: spi: allow expressing DTR
 capability
Message-ID: <20200227162842.GE4062@sirena.org.uk>
References: <20200226093703.19765-1-p.yadav@ti.com>
 <20200226093703.19765-2-p.yadav@ti.com>
 <20200227171147.32cc6fcf@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y2zxS2PfCDLh6JVG"
Content-Disposition: inline
In-Reply-To: <20200227171147.32cc6fcf@collabora.com>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--y2zxS2PfCDLh6JVG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 05:11:47PM +0100, Boris Brezillon wrote:
> Pratyush Yadav <p.yadav@ti.com> wrote:

> > Allow spi devices to express DTR receive and transmit capabilities via
> > the properties "spi-rx-dtr" and "spi-tx-dtr".

> Is the RX/TX granularity really useful?

It's what we do for other properties, and if this is anything like the
other things adding extra wiring you can't assume that the ability to
use the feature for TX implies RX.

--y2zxS2PfCDLh6JVG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5X7jcACgkQJNaLcl1U
h9A5kgf/Y0DRJYdf4AUiGakcZO9I33l1RhLd5LtXAlID2YL52F81QjI/Uh6tRy8r
6otcXAH1qzNwt2nV9Rsns7oy/Em4FpAf248Syn9SZiGE5JtiAS3opEuoAxKeJ604
JNMbbAB/6AdKeIN3HrtjEb560Ht2WF9EEkrA5L45YYC6uHNf3YD1QseYg5l88d/K
0g/2qCx8TpynDd2YEKAxBjExG6u4MK2pRtJBMZSAO/Ky3foUaUxUy/jBne/8IF+8
6/YhGyxrXmJoklyW8KFJsPYNuR6pKAyl769Gy0w9KNvvs+O4cuBrVMxP+EUOwWbt
OdSZ0ur//F4vDI6KkaOrG2YCg2r7Nw==
=OoLn
-----END PGP SIGNATURE-----

--y2zxS2PfCDLh6JVG--
