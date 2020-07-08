Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B0EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F96E20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 13:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594215730;
	bh=R9qdQMVF6jYFLBjnOTlIxsV4VC7X7oeEN/boZFtPUto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DhoW0BQsMB4tfJ3pg8kVU1sOdZSvwv7Eq3grGtIsgRgbrLHNX89bcaMVcfsLAweEW
	 LEFp2tLe8vMpOPWQ8MDNu6Xfow++BMPbt5DwE7HEx2m/UH0RsVJ3mXlEyrXQhi+Vck
	 TwgzYuGStZWnHP3PLFySUryJc0k0+yy/5L4dtQoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729436AbgGHNmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 09:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbgGHNmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 09:42:08 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 94973206E9;
        Wed,  8 Jul 2020 13:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594215728;
        bh=R9qdQMVF6jYFLBjnOTlIxsV4VC7X7oeEN/boZFtPUto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mKU2MkhG1wQA3vAM/QfKJ90toW+lIOZyRe50fYYgLFpYzLij/HvclaJpRakIrEbli
         WnAKod1055cy4NWEKl26l1rWeaqIcpM7KBa1uYeSgeDISClOZq4Ows/4SxIBhtVvUJ
         bzIv95p1MbI7Uqvxc9yn652tVyGaKK4v5Z34fYR0=
Date:   Wed, 8 Jul 2020 14:42:02 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com,
        tiwai@suse.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        vkoul@kernel.org
Subject: Re: [PATCH 10/11] ASoC: qdsp6-dai: add gapless support
Message-ID: <20200708134202.GR4655@sirena.org.uk>
References: <20200707163641.17113-1-srinivas.kandagatla@linaro.org>
 <20200707163641.17113-11-srinivas.kandagatla@linaro.org>
 <62af11d3-db26-a31b-00c8-9d78b11862cc@linux.intel.com>
 <04a7f696-e23d-5563-7cc3-aedfaf2c7636@linaro.org>
 <cf9b2d33-9b63-f3d2-2e51-a88c528dad53@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EkxpYdHiqGHPYbUt"
Content-Disposition: inline
In-Reply-To: <cf9b2d33-9b63-f3d2-2e51-a88c528dad53@linux.intel.com>
X-Cookie: Oh Dad!  We're ALL Devo!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--EkxpYdHiqGHPYbUt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2020 at 08:32:02AM -0500, Pierre-Louis Bossart wrote:

> To avoid confusion I believe the capabilities would need to be extended so
> that applications know that gapless playback is supported across unrelated
> profiles/formats. The point is that you don't want a traditional
> implementation to use a capability that isn't supported in hardware or will
> lead to audio issues.

We'd also need error handling in case someone ignores the capability
checks.

--EkxpYdHiqGHPYbUt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8FzSkACgkQJNaLcl1U
h9DCkgf+JEC2hdc751A8OHEKoIY50HxlCgLea4x5JZtPeQUrtnridmPh+C1aFQd/
31k2PwzAM+xJ2nyOK0LYdlfF4f3sTA1r0ltaIr4KCpUQQ3glkkelABrHrblvUea0
C1cFzPBU4CzQPKO7b3YQ1ORjVt/PxScuK1kxUjITFeaUSGn5bF8+VQbibW/14aO/
TF1M6LNytypWFB86U7vO4OyhtrKv/s/QQ8wUD6mN4I1Q0ymL/0ekQsjP9UuAEJwH
Mq3HN9IFb5cQknIZAYpthwk4xeN/Rv6QphZdjtO6aPbpMPpbG/3kFmTP9/QxnPs9
3CSrUqp9+j06SZ4A65PFB3lf4/+olg==
=Xb5s
-----END PGP SIGNATURE-----

--EkxpYdHiqGHPYbUt--
