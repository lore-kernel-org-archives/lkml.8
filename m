Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BEDC4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A06B2469D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582809185;
	bh=YlVUxfcvD/beBDmKrHeJiolRj+Z0v4n2W4m8yS8ZA38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=a1vb/CasyDQZnD3c/eITlbaCtqw4+xejLSFmPEPrKwYGoReUpaeojqvlnfDfALIwK
	 MCyfykVtXez+ZvE1iKeVK7uwh4Ixf3d+/tygVTWxTrbVzD33lKr56q1jjfqTejWxeY
	 tm5B7v5CE5krrhsWx2FTl1U0dMCPlJwlngZ+MVuA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgB0NNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:13:04 -0500
Received: from foss.arm.com ([217.140.110.172]:50276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729073AbgB0NND (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:13:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10EA030E;
        Thu, 27 Feb 2020 05:13:03 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B1603F703;
        Thu, 27 Feb 2020 05:13:02 -0800 (PST)
Date:   Thu, 27 Feb 2020 13:13:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v7 00/11] arm64: Branch Target Identification support
Message-ID: <20200227131300.GB4062@sirena.org.uk>
References: <20200226155714.43937-1-broonie@kernel.org>
 <202002261343.3B2ECE90@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <202002261343.3B2ECE90@keescook>
X-Cookie: Edwin Meese made me wear CORDOVANS!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 26, 2020 at 01:44:59PM -0800, Kees Cook wrote:

> Looks good. I sent a few more Reviewed-bys where I could. Who is
> expected to pick this up? Catalin? Will?

Thanks, I'm expecting it'll go through the arm64 tree.

--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5XwFwACgkQJNaLcl1U
h9BVcAf+IT0x9Rm5Qvg7iutzvlk4f961QXDY77LCMmKkuIyjzf2qoM3UKYdN5A+s
XCh02Tc8GwVaSWaipJplvGn2y3aPrb1oLBU8yp2zkFHk3UuDdkrIhwTqmg9EH6qO
HMxhgu7d6bKkjgpIMZe78MrbRRJUCej3S9SHehfJjGHStqjcyN65h4a7GJZUkHkB
8UMKB9ln6VV8BZHBWEZZa875jAojja3k2OzUTrtBmbq7WsuQIsIqjVblRGOIZXNQ
6ok8vsW83J6iRtR6J46oSoIJqkXjfYucnbP7ulIOQDtUMvpS0O/C982bW0mtMvLB
Qy9hBI9hA/mdTTxfXA8PF2WvD3HTHQ==
=r3OK
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
