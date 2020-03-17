Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D6EC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 764B920752
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584453443;
	bh=b8vjWdrp4novBJCSOe8aDz4sezN0TkVJjtw03tKFpqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XR/nXum9nwVQnby/thXPLVPOxKinV68784CQOeXfs5OEE+aWUliqDIzaW+jRbzyNF
	 8RUDP665cYQyUgupTEKIoiTg04aq3ZcN8I3Rg8ADCSLk6ZYHlY5Jj0kzwcleQHigum
	 QJFpJDhEKMZx5A1UR0iN0FnfY+NHiJ2RASgC37vQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgCQN5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:57:22 -0400
Received: from foss.arm.com ([217.140.110.172]:38500 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbgCQN5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:57:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BBBDFEC;
        Tue, 17 Mar 2020 06:57:21 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F172C3F534;
        Tue, 17 Mar 2020 06:57:20 -0700 (PDT)
Date:   Tue, 17 Mar 2020 13:57:19 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Hongbo Yao <yaohongbo@huawei.com>,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] arm64: fix the missing ktpi= cmdline check in
 arm64_kernel_unmapped_at_el0()
Message-ID: <20200317135719.GH3971@sirena.org.uk>
References: <20200317114708.109283-1-yaohongbo@huawei.com>
 <20200317121050.GH8831@lakrids.cambridge.arm.com>
 <20200317124323.GA16200@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Content-Disposition: inline
In-Reply-To: <20200317124323.GA16200@willie-the-truck>
X-Cookie: There's only one everything.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2020 at 12:43:24PM +0000, Will Deacon wrote:
> On Tue, Mar 17, 2020 at 12:10:51PM +0000, Mark Rutland wrote:
> > On Tue, Mar 17, 2020 at 07:47:08PM +0800, Hongbo Yao wrote:

> > > Kpti cannot be disabled from the kernel cmdline after the commit
> > > 09e3c22a("arm64: Use a variable to store non-global mappings decision").

> > > Bring back the missing check of kpti= command-line option to fix the
> > > case where the SPE driver complains the missing "kpti-off" even it has
> > > already been set.

> > > -	return arm64_use_ng_mappings;
> > > +	return arm64_use_ng_mappings &&
> > > +		cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
> > >  }

> This probably isn't the right fix, since this will mean that early mappings
> will be global and we'll have to go through the painful page-table rewrite
> logic when the cap gets enabled for KASLR-enabled kernels.

Aren't we looking for a rewrite from non-global to global here (disable
KPTI where we would otherwise have it), which we don't currently have
code for?

> Maybe a better bodge is something like:

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 0b6715625cf6..ad10f55b7bb9 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1085,6 +1085,8 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>  		if (!__kpti_forced) {
>  			str = "KASLR";
>  			__kpti_forced = 1;
> +		} else if (__kpti_forced < 0) {
> +			arm64_use_ng_mappings = false;
>  		}
>  	}

That is probably a good idea but I think that runs too late to affect
the early mappings, they're done based on kaslr_requires_kpti() well
before we start secondaries.  My first pass not having paged everything
back in yet is that there needs to be command line parsing in
kaslr_requires_kpti() but as things stand the command line isn't
actually ready then...

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5w1z4ACgkQJNaLcl1U
h9DHPQf/Yk+8QriE8OOokiXkCDmOzV62HaR9JUB4YrP/wXt51ciPUarL47VDjxX0
BVZornO01cOyFwLJ9ZPhFc+XXYoaO7hhRXI+9eervR0LYo9pEvTzGyAXPpKyyldo
lNUHzr5zABlfNy9XMAPHWUu2audTlT5ECyLd5jzKYvQH6fIQ3GMr7niaEauktkue
mJYqjjnCXMZdCfIPB1djyXTWIwHWA1d4SC1IuxSfEG1Z+3pmWB6O2xcuLXPzDpiC
C9pZ8fPwDbG1fqOKCMT4RkoAgceWg2jhE2ATlpEawsOyF8Xy9pnlXcV4el33+rMP
iNg5UVCxpnbw8Z2WQXOD4er3dk5BHw==
=o53u
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--
