Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFC3C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:07:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD86A2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581509276;
	bh=KEdWYDnv376xAqYcybyyA7EK6tgUIVP6M2gPLFggL9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YJEjTgIPKTBcRxgoL8NhGT7aEOEtwcURceJw11kmI/CXJxYk+E5cj8rf1MC/WVNGu
	 ycb47Rz1AquiROZehwzpVxQ7L4yXpo7vGKf67vIgiqKZjOqMwP+qXzoKvd3/zOV3c9
	 DoQsqUMb5yh83wYq8xLA3TjUP5f6wi6J49tNe9iQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbgBLMH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:07:56 -0500
Received: from foss.arm.com ([217.140.110.172]:60322 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgBLMH4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:07:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8D1F730E;
        Wed, 12 Feb 2020 04:07:55 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 115DB3F6CF;
        Wed, 12 Feb 2020 04:07:54 -0800 (PST)
Date:   Wed, 12 Feb 2020 12:07:53 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Fabio Estevam <festevam@gmail.com>,
        linux-spi <linux-spi@vger.kernel.org>, Han Xu <han.xu@nxp.com>,
        Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V2 2/5] spi: fspi: dynamically alloc AHB memory
Message-ID: <20200212120753.GF4028@sirena.org.uk>
References: <20200202125950.1825013-1-aford173@gmail.com>
 <20200202125950.1825013-2-aford173@gmail.com>
 <CAOMZO5D3emrAk84wDS04qJC-3AyvFnqodhoMsXO-ukHnYsU+PQ@mail.gmail.com>
 <CAHCN7xJyZRwJhnWW2mAbOeGyrMsB7Au_e6AvwiNmNS8gFUfSyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Content-Disposition: inline
In-Reply-To: <CAHCN7xJyZRwJhnWW2mAbOeGyrMsB7Au_e6AvwiNmNS8gFUfSyw@mail.gmail.com>
X-Cookie: Violence is molding.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 03, 2020 at 04:53:34AM -0600, Adam Ford wrote:

> My motivation is to get the flexspi on the i.MX8MM to work, and I did
> a list of the patches applied on the NXP branch to see what was
> applied on top of their 4.19 kernel and this patch series generated
> from that list.  Most of the NXP commits are one-line commits, and I
> don't know the motivation for what's happening.  NXP did it, and I
> know it works on the Flexspi driver.

Adding new compatibles and so on seems fine but the patches making
random changes without explanation like the one for octal mode I just
replied to are more worrying, do they work with older versions of the IP
or in all use cases for example?  I'd suggest cutting the initial patch
series down to the bare minimum needed to get things working and then
building on top of that if that's not already been done.

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5D6pgACgkQJNaLcl1U
h9CVMgf/QyhKBWAfMkP4Rp+HGO7kGTkLUcFcDDEVLppg3P994e+Hw7xkEhHlxZzR
Pk3L02ATqS7BzaqcD6YYWlUNUhq84BASOdHvlXmkHbj2zUH1YXHGToNmImnyz+ij
PvQMg+4jX2+O/lS74JysuPSmnBaKzjCow8YHCD7eOF4/vBOpUbf2mSl2j5FqiQ61
epX3f2ggXN/mHWb5lHsRFg0BeiX0FY0z6x+eKtRhkMlcWFDSi4tEAtCWQeJdln/Z
fBzuVHcuRml1QT7eUkipD/rvtj5X04qwFvOHjHdVFRTlsWT9NqAEKyvwofEAml9G
LQ/fLV2WIr5f6MFYAgsFwhj6PpLOYA==
=3v+9
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--
