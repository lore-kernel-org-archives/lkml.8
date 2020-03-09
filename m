Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BC5C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:05:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F2EB2464B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583787909;
	bh=LrpstKSS0rJrCTMBq4WQecbURWbFWbhOPZJnK1mHVlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ILqibIU7s/bMxYaKqXRHUe7eNWmgyIV8VdwFzGiKh3rw6RRQLOhCODQ4liR3jM1Vd
	 R4M5st+L2eX3FGrEDpKAJyNecAoyQnN/OJIpG3rAsvB66gLMm9MasSuLTxI5HfEalN
	 n3GSG5aIjX+EtH7s+dsS4n5JClg73JWzN9rHGB/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbgCIVFH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:05:07 -0400
Received: from foss.arm.com ([217.140.110.172]:57536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbgCIVFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:05:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1222D1FB;
        Mon,  9 Mar 2020 14:05:07 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 891E23F534;
        Mon,  9 Mar 2020 14:05:06 -0700 (PDT)
Date:   Mon, 9 Mar 2020 21:05:05 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
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
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v8 00/11] arm64: Branch Target Identification support
Message-ID: <20200309210505.GM4101@sirena.org.uk>
References: <20200227174417.23722-1-broonie@kernel.org>
 <20200306102729.GC2503422@arrakis.emea.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qySB1iFW++5nzUxH"
Content-Disposition: inline
In-Reply-To: <20200306102729.GC2503422@arrakis.emea.arm.com>
X-Cookie: Above all things, reverence yourself.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--qySB1iFW++5nzUxH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 06, 2020 at 10:27:29AM +0000, Catalin Marinas wrote:
> On Thu, Feb 27, 2020 at 05:44:06PM +0000, Mark Brown wrote:

> > This patch series implements support for ARMv8.5-A Branch Target
> > Identification (BTI), which is a control flow integrity protection
> > feature introduced as part of the ARMv8.5-A extensions.

> Does this series affect uprobes in any way? I.e. can you probe a landing
> pad?

You can't probe a landing pad, uprobes on landing pads will be silently
ignored so the program isn't disrupted, you just don't get the expected
trace from those uprobes.  This isn't new with the BTI support since
the landing pads are generally pointer auth instructions, these already
can't be probed regardless of what's going on with this series.  It's
already on the list to get sorted.

--qySB1iFW++5nzUxH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5mr4AACgkQJNaLcl1U
h9Blwwf8CR8zwN1uUuwJWSzyItw8ZiSf2fLHJ6Smgao/rc/O876dKM+ZZQqzuQ3B
kG8nQyocUyEa7jghPeuTnqveuK4hpSDe/++EG1Ncl+7gMe8pmbTLVfOCYZzs1TPc
3QiBL54YSDsAtYFT/Q+2Q27pv4vP3Xm7vsyhvWHYujG6HuFVt3Oco0Nnh8ipL6Eo
XPOS5rfxJTLe2vcwFfj6Nf03zK+DoS2gU4LAXCjQeXGuwGep9BYzoEQhXk8srTA7
ZJSrDH0XTMYRRmkmHTcppBRfqbKwES2xZYt6GDRWKqG7yvnEcq+v1MFR2Mgw87ZA
eQr2xNhLMxU8o5zqjJiwHMI5S3jMoQ==
=TGul
-----END PGP SIGNATURE-----

--qySB1iFW++5nzUxH--
