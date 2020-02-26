Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB14C4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2036F2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582733529;
	bh=zD95C8jXvKeA2Lkq8Qa1pNu3GAc/DOkXqzcvvDopkzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YmBGpRKN2l5y95BFxpvVJE9p9+3qjJ8mwc0WOi0hUZ2Kdnmd1fCZRcQRV75PojkDq
	 gBv7wcnseVAeH4Hwz8nS+dT+LiFb1x1VkAO7c9A9AszdCHO8NV4yh8oFYm7t2vFnBI
	 TrBzzhhFvo27D1FGhe+mgQbNxaoTgtVnlShzojVo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgBZQMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 11:12:07 -0500
Received: from foss.arm.com ([217.140.110.172]:38568 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgBZQMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 11:12:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D7A630E;
        Wed, 26 Feb 2020 08:12:07 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58AC83F819;
        Wed, 26 Feb 2020 08:12:06 -0800 (PST)
Date:   Wed, 26 Feb 2020 16:12:04 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH for-next 3/3] ASoC: tas2562: Fix sample rate error message
Message-ID: <20200226161204.GG4136@sirena.org.uk>
References: <20200226130305.12043-1-dmurphy@ti.com>
 <20200226130305.12043-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FwyhczKCDPOVeYh6"
Content-Disposition: inline
In-Reply-To: <20200226130305.12043-3-dmurphy@ti.com>
X-Cookie: May all your PUSHes be POPped.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FwyhczKCDPOVeYh6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2020 at 07:03:05AM -0600, Dan Murphy wrote:
> Fix error message for setting the sample rate.  It says bitwidth but
> should say sample rate.

Fixes should always go at the start of a series so they can be applied
as such without any dependency on any new features or cleanups.

--FwyhczKCDPOVeYh6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5WmNMACgkQJNaLcl1U
h9B0awf9ESCiHU9RD3/A8kZRztiJ/i6v+mqv3grUXiccDepGBvBCBSTt4rAbsR8Z
1huZ8Sx5uf3xiPy6MxjDtWEoBbr2X/jNM7MRgHc8NLCcGGpv3wvjuvyMcdE38ADg
SfBT4DHipWUcZ9AxU8ke4DvtiK72PmEzNaQeKxIi59HgfJCBW3y8Fzr48oDSYbkX
kvGxYLxWaItvEtEHL08jo40+yGaoKHpsG+EGw9qVghTBmhyp8TYdbw6T+RFKGgSa
U21PS0RePP40e7ypLrueU2wTE2b30z2ti0D/qv2aQ8D0PoM/KOrQ89Vh8r/pzp5m
vcGYefDoOJxBKpi8S0q3+MWLtGBClw==
=K3NC
-----END PGP SIGNATURE-----

--FwyhczKCDPOVeYh6--
