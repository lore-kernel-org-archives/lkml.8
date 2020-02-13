Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB007C3B18C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC592206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581615652;
	bh=9qhP70TQYX0Fhp8mLCEFovMaOkgWy/GwfzV5PAx7aRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0SPRkMNlGtL489iVx7XsT6PzGpgXyI45fFb8CB5DQVD+kkc34LwVBAWJFCHdeKdUQ
	 SGuZle+Xn52BUEFVL69KiODabhTV2ercO3c3DVpjcOHgu5in5GWp4s4fu4LxDtVR5X
	 L4tw/Kh5Dnp6mFbOr24tUvJ7TL3T2ou+aNjPjTjk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgBMRkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:40:52 -0500
Received: from foss.arm.com ([217.140.110.172]:51492 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgBMRkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:40:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11579328;
        Thu, 13 Feb 2020 09:40:51 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88E763F6CF;
        Thu, 13 Feb 2020 09:40:50 -0800 (PST)
Date:   Thu, 13 Feb 2020 17:40:49 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/9] ASoC: core: allow a dt node to provide several
 components
Message-ID: <20200213174049.GI4333@sirena.org.uk>
References: <20200213155159.3235792-1-jbrunet@baylibre.com>
 <20200213155159.3235792-2-jbrunet@baylibre.com>
 <20200213171830.GH4333@sirena.org.uk>
 <1j4kvufkwq.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2xeD/fx0+7k8I/QN"
Content-Disposition: inline
In-Reply-To: <1j4kvufkwq.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Academicians care, that's who.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2xeD/fx0+7k8I/QN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 13, 2020 at 06:37:41PM +0100, Jerome Brunet wrote:

> > My first question here would be why you'd want to do that rather than
> > combine everything into a single component since the hardware seems to
> > be doing that anyway.  Hopefully the rest of the series will answer this
> > but it'd be good in the changelog here.

> Do you think there is something wrong with a linux device providing
> several ASoC components ?

I don't know that it's actively wrong, it's more a comment about the
changelog only describing the what of the change and not the why - the
original idea for a component was that there should be a 1:1 mapping
between components and devices but as you say it's not actually a big
change to let things get split up more.

--2xeD/fx0+7k8I/QN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5FiiAACgkQJNaLcl1U
h9C46Af/TpnlCjwtU4fMMnm8c7NfPorK7RegG0x4rLJk+edJ9/SFZTQw+xzrqVqN
nPQMM1kD0EyLWF7yyIfRTupKgib8azZih6jb2hxU1kp8LdmkDqNsN4urF9cPw16i
0ZljRlQJlVyNLarFet7ctm38otSlAXCadIlzZVODeytxnXrrh0Av6wujTqqBaRCV
8DGNYnfvQxHLh07dxM93Yxe2kP2wWHjYnbPiaXqsYARsK7KfqdqZEW+ojCptuhPL
VXgEbh9Gn9ZHCClylentU1Y3Tg9AmpyUpHrNeEvFT9urgLpTDbcAzW1vP/k/35CD
GBbkYBwAxXr8jfIftVZwP9foH48WRg==
=WHzO
-----END PGP SIGNATURE-----

--2xeD/fx0+7k8I/QN--
