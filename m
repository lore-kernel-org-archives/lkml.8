Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FC8C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E64E82467A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582224126;
	bh=R1llzUyB9Jl6Eeqj5K/tTW+IULqaRBEjDP6VmBqsA/o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T9kzrqpyLwY9Z1gHZf8kiOWgjhGEoBOR9L1Ot3NDJ1TOnxz+Jt6ld+OxJNWvPvcL+
	 +JVMdXPVzNRtkIk3S0sD1WQ4l5vhpNpH5QOfF03y2c4cy2ljlUYXj1ZOFgGq+l0rPR
	 jyrlZpsXuBwD0EuizVUUtABGK4GNbAH7i+zgalAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgBTSmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:42:04 -0500
Received: from foss.arm.com ([217.140.110.172]:49386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728336AbgBTSmE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:42:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC53730E;
        Thu, 20 Feb 2020 10:42:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 62B213F6CF;
        Thu, 20 Feb 2020 10:42:03 -0800 (PST)
Date:   Thu, 20 Feb 2020 18:42:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Oleksandr Suvorov <cryosay@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>
Subject: Re: [PATCH 2/2] spi: spidev: fix a max speed setting
Message-ID: <20200220184201.GE3926@sirena.org.uk>
References: <20200220141143.3902922-1-oleksandr.suvorov@toradex.com>
 <20200220141143.3902922-3-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Content-Disposition: inline
In-Reply-To: <20200220141143.3902922-3-oleksandr.suvorov@toradex.com>
X-Cookie: You are number 6!  Who is number one?
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 20, 2020 at 02:11:51PM +0000, Oleksandr Suvorov wrote:
> SPI_IOC_WR_MAX_SPEED_HZ command always sets spi->max_speed_hz
> to the initial value come from DT.

This is intentional.  It's doing a call to spi_setup() then restoring
the original value, the goal being just to run spi_setup() with the new
value - it's not really a good idea to change the maximum speed in the
first place.

> It leads to set a wrong max speed with IOCTL call.

In what way does it lead to the wrong speed being set?

> Fix the logic of a max speed assignment.

If the expectation is that the default speed should be changed for the
device this should be handled at the spidev level rather than in the
core.

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5O0vgACgkQJNaLcl1U
h9CHKAf/SBwTBBlMx+ka5Ypwl270AEXWAyIyvIekkMZzI/QmE0TkpWpCeBaVyVsK
alxy6DfOGTWecBIn8m/uvMxa/05NxIqlN3PNtXySaEVuMwMePIACJXMNQeg744tu
7iVPnBD94Cdoc7aLsRp8qFBV4FY2xTt2ZaEWNR/5uruIYpfCu/fQpuTG2bPhuO+1
jXGkR4iZLHsHeijEXllLPSOFUMtuqdpPu10rtclYM9gXLDgDxGasdMSkn6MZbm1A
Tj8EPQmque2xnm/YCmqJLE3CsKiknqG6p3DoAaZHS8y1njbvzpAmQ77oinV1XrH2
JyGnqCRwyKIcxuGjeugW2NmUMmQQ3Q==
=D9Fo
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--
