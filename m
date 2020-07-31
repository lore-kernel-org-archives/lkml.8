Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CC2C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C6222B43
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596217351;
	bh=1RBJrByuU1/4YwH7R7c4LoRXyjsSYMzkPBOWevrI01g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XE9eLGQPfpM/YqkVDNujVPbeIKFcnc8BjiCY0i+nqW+uOZ2EF4ivmpMCBiv6d8+ML
	 SA1uDbEgM8mx/hTb1TUmD1yfw34aCjEQKNVgK9impPZSonJr7GscC2EC4vkiEvQByg
	 JUHA/V+f6H9toTrh6P8jnGNIwBzgw4e6AFdfTnP0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387585AbgGaRma (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:42:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733265AbgGaRm3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:42:29 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1620D2083B;
        Fri, 31 Jul 2020 17:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596217348;
        bh=1RBJrByuU1/4YwH7R7c4LoRXyjsSYMzkPBOWevrI01g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1Gn+rYBxy/1RR7v0EzwvHkDTLU3XQqh+OPCnvh/csSGj/3+GWe+7hjTF+3qa4xilB
         Xy7aqJY5CtRnyLrJA6QcmvjxrgpO6op0Q2fVH0eaomPAFXnf0nsDUOQwnblR33tvTc
         CoAEdiePSFluw00g8kTPlbfIHXYbOWeXwcp1X1sk=
Date:   Fri, 31 Jul 2020 18:42:07 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        alsa-devel@alsa-project.org, Stephan Gerhold <stephan@gerhold.net>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org, zhangn1985@outlook.com,
        linux-amlogic@lists.infradead.org
Subject: Re: [PATCH] ASoC: core: restore dpcm flags semantics
Message-ID: <20200731174207.GC4510@sirena.org.uk>
References: <20200723180533.220312-1-pierre-louis.bossart@linux.intel.com>
 <20200729154639.1983854-1-jbrunet@baylibre.com>
 <2ad13f95-434d-376a-bc38-b209623b461e@linux.intel.com>
 <1jft998jbe.fsf@starbuckisacylon.baylibre.com>
 <936d6e37-0ad0-b0d7-814a-1ace12087746@linux.intel.com>
 <20200730185229.GH5055@sirena.org.uk>
 <1j7duj98wk.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
Content-Disposition: inline
In-Reply-To: <1j7duj98wk.fsf@starbuckisacylon.baylibre.com>
X-Cookie: Some optional equipment shown.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 31, 2020 at 02:16:43PM +0200, Jerome Brunet wrote:

> One last thing I'd like to understand. Is this behavior of throwing an
> error going to applied to the non-DPCM case as well ? so at least thing
> are consistent between both cases ?

> IOW:
>  * An error is now throw if dpcm_capture is set on the link and the CPU
>  DAI support playback_only

We should definitely complain about that.

>  * on non-DPCM links, will an error be thrown as well if playback_only
>  is not set and the CPU on the link happen to not support capture ?

I think we should move towards not needing to do that for DPCM.

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8kV+8ACgkQJNaLcl1U
h9B67Af+MxqJXiRcEr3b1wsfZYNzZAmN8zNYmZH8ubxUHrcXWUMDl5SAjY/+aEMq
JL+V4yKWh6qgn0fB5NoCNak05vKjZ12E3RpBZu7zN5q620XE3DXC45b+2pv91DCn
FBVrTazkRYfe2IOp2odw47F5Mfnd4x4yfiTuIgGgolmmC8uXeTIZ5TIUGzrPwKoX
aZESOyB5mglx21aMK4JqHah0Lo/fzYIxjdejoAG2yClR11CdHKgPxI6JQA6+/FQr
17Xx+Xd2pd4rhdOIJ91Shgmd5jIyroODzlU3k7PIiNPGeCMP7MlzwUv6ehBOPUGU
n+e6KyufvWAE7FCqi86jv6GQFhguPQ==
=9eeM
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
