Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 763F7C3567B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 471EF246A3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 17:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582824749;
	bh=Q4R1N+GYKcL+Wl2TxKY61azxKzF7ZZk6yZvhBTp5ShA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Qp/eLXLiFNf4sgIWpFoluIg9WSw1aoAq3sesAtQTHdYoUwddXE76THALknA6LtCW7
	 0y7CPasTQQIg+147FuYD8tn0Soh945pOsBHWg/tMWKf6UxBtRJtO3uobhNbIcu4wHZ
	 LT0Rur8+M5tcBkndgMuMJ1bWKZpOT/vErcDl/Z2Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730247AbgB0Rc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 12:32:28 -0500
Received: from foss.arm.com ([217.140.110.172]:55262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729361AbgB0Rc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 12:32:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11E221FB;
        Thu, 27 Feb 2020 09:32:27 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 544EF3F73B;
        Thu, 27 Feb 2020 09:32:26 -0800 (PST)
Date:   Thu, 27 Feb 2020 17:32:24 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        vigneshr@ti.com, robh+dt@kernel.org, marex@denx.de,
        devicetree@vger.kernel.org, tien.fong.chee@intel.com,
        tudor.ambarus@gmail.com, boris.brezillon@free-electrons.com,
        richard@nod.at, qi-ming.wu@intel.com,
        simon.k.r.goldschmidt@gmail.com, david.oberhollenzer@sigma-star.at,
        dinguyen@kernel.org, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, cheol.yong.kim@intel.com,
        mark.rutland@arm.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, cyrille.pitchen@atmel.com
Subject: Re: [PATCH v11 2/2] spi: cadence-quadspi: Add support for the
 Cadence QSPI controller
Message-ID: <20200227173224.GH4062@sirena.org.uk>
References: <20200227062708.21544-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200227062708.21544-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200227183032.77ef0795@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3VRmKSg17yJg2MZg"
Content-Disposition: inline
In-Reply-To: <20200227183032.77ef0795@collabora.com>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3VRmKSg17yJg2MZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2020 at 06:30:32PM +0100, Boris Brezillon wrote:
> "Ramuthevar, Vadivel MuruganX"

> > Reported-by: kbuild test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

> Reported-by? What has been reported?

There were static checker issues with some of the earlier versions.
Vadivel, normally you wouldn't carry tags like that forward when you fix
them.

--3VRmKSg17yJg2MZg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5X/SgACgkQJNaLcl1U
h9CP5Qf/R3Kg6m1IWYoLkvaxFnCJfsEmQTyGre/OzTAMNH3ty0K8C9jwRptIMF+/
69RV5hxWCG1R6XgKC2LNnJmyF47gHp2KdM89xqQmnPgXqiYaUplvaUy2E1nkBcKK
tkBSsytqi0qGduCjxVyPt6/gu3Dswfp5iCJBMjkV+6IAsQ9tueI94+UXj95QypTk
03mVesWb4Px1CXmQ5HnJDVeXK+6ifjD+NdWmp9Pzlta8mpINdxgxMRdHYpfXDKkx
o/nUks7zBEZl5/4X72QckO+FVR7TueA5Y3V6plkWaMWMfgxJYVp1977p2IDwY5qt
nUkq+fXkt1K0vuTcXAk+U9Pk9aEgFQ==
=3qen
-----END PGP SIGNATURE-----

--3VRmKSg17yJg2MZg--
