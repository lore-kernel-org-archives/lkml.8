Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F836C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:10:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69512177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596798649;
	bh=0mfZ3tCewEYBpMJJOPz0BmMamhTElZWdvCmOX36KiAo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fJqg7NYfzFMOkdnjGd7q6hBgQytVek63kpvjMXAoxFtc/zs8qVmBbUiLeImaoWaMD
	 aO5cnNjeZw63SpF+CVlVTigs15IZha3QsPx0qqwUWdToRZveXrSStmqY8GNnhQRjRN
	 H3FQuDLiEPgjxjzgo0qpzrCzNGOZCOzmgNHI6+DY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgHGLKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:10:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbgHGLKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:10:21 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5471B22CAE;
        Fri,  7 Aug 2020 11:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596798588;
        bh=0mfZ3tCewEYBpMJJOPz0BmMamhTElZWdvCmOX36KiAo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vLkvaRQqeXWKNg6wKaEQ8PDKcjcIsdzCJ9bTQ0Gm5WhT6Yn5TS0QLKQnWKMdWmHvb
         ckswyLGYNEMx5onBTEN9cgAd2RP8HSgrQbgg6jj46UlBMFD/RSTFCl30ir5D0knxp2
         evLNGLwT+HDJvHqOxRajUIe37yRe45iMZ8SVbeQk=
Date:   Fri, 7 Aug 2020 12:09:23 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        tytso@mit.edu, Qian Cai <cai@lca.pw>
Subject: Re: [PATCH] arm64: kaslr: Use standard early random function
Message-ID: <20200807110923.GA5435@sirena.org.uk>
References: <20200807004904.72893-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20200807004904.72893-1-linux@roeck-us.net>
X-Cookie: Disposable, use only once.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 06, 2020 at 05:49:04PM -0700, Guenter Roeck wrote:

> Use arch_get_random_seed_long_early() instead of arm64 specific functions
> to solve the problem. As a side effect of this change, the code no longer
> bypasses ARCH_RANDOM, which I consider desirable (after all, ARCH_RANDOM
> was disabled for a reason).

This should be fine since the entire implementation is still static
inline in the header other than the prints in the WARN_ON() which should
never be triggered here so it should be fine.

Reviewed-by: Mark Brown <broonie@kernel.org>
Tested-by: Mark Brown <broonie@kernel.org>

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8tNmMACgkQJNaLcl1U
h9DK4Qf5AVSYfMMgTTvwKue9Ks6IYBH3gzG07ukffM+vAlE/RXqck638YxoU8wHU
208wtyCiKeAPZiO9dawkdTsF8Rcks1XWCvYYDL1VdK6HIkUetFDD14D7/JFykuwi
y4iZFMSHXiJ6L73afGWUMzY6p7OirJiyJ1aIfgsBSMgz8kKG7DcD2xiKzo72HcFt
0mlWjbFH/PU3zNf24sB4Z67B0qCPguNNMQ+Iu0z5ETSNYZw+Bi3pPiN7JXzoPUdB
2O6VcYXei1jJYHWihgetLv8E/hCFkaxUOIru705kIHp1pYma/yfMhmYYmlr/dlzs
IAJVL1LhZ7dG/PYxpYevIgoSFjkGKA==
=dHzU
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
