Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6326C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B019120748
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgHGKR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 06:17:29 -0400
Received: from foss.arm.com ([217.140.110.172]:54516 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726511AbgHGKR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:17:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 547EE1FB;
        Fri,  7 Aug 2020 03:17:28 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.37.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE5153F887;
        Fri,  7 Aug 2020 03:17:25 -0700 (PDT)
Date:   Fri, 7 Aug 2020 11:17:23 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel =?utf-8?B?RMOtYXo=?= <daniel.diaz@linaro.org>,
        tytso@mit.edu, Qian Cai <cai@lca.pw>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] arm64: kaslr: Use standard early random function
Message-ID: <20200807101723.GB72666@C02TD0UTHF1T.local>
References: <20200807004904.72893-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807004904.72893-1-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Thu, Aug 06, 2020 at 05:49:04PM -0700, Guenter Roeck wrote:
> Commit 585524081ecd ("random: random.h should include archrandom.h, not
> the other way around") tries to fix a problem with recursive inclusion
> of linux/random.h and arch/archrandom.h for arm64. Unfortunately, this
> results in the following compile error if ARCH_RANDOM is disabled.
> 
> arch/arm64/kernel/kaslr.c: In function 'kaslr_early_init':
> arch/arm64/kernel/kaslr.c:128:6: error: implicit declaration of function
> '__early_cpu_has_rndr'; did you mean '__early_pfn_to_nid'?
> [-Werror=implicit-function-declaration]
>   if (__early_cpu_has_rndr()) {
>       ^~~~~~~~~~~~~~~~~~~~
>       __early_pfn_to_nid
> arch/arm64/kernel/kaslr.c:131:7: error: implicit declaration of function
> '__arm64_rndr' [-Werror=implicit-function-declaration]
>    if (__arm64_rndr(&raw))
>        ^~~~~~~~~~~~
> 
> Problem is that arch/archrandom.h is only included from linux/random.h if
> ARCH_RANDOM is enabled. If not, __arm64_rndr() and __early_cpu_has_rndr()
> are undeclared, causing the problem.
> 
> Use arch_get_random_seed_long_early() instead of arm64 specific functions
> to solve the problem. As a side effect of this change, the code no longer
> bypasses ARCH_RANDOM, which I consider desirable (after all, ARCH_RANDOM
> was disabled for a reason).

There's no bypass of ARCH_RANDOM; the bits KASLR depends on are empty
stubs when ARCH_RANDOM is not selected. I added the common early
functions after this code was written.

> Reported-by: Qian Cai <cai@lca.pw>
> Fixes: 585524081ecd ("random: random.h should include archrandom.h, not the other way around")

This is where things broke; there was no need to change kaslr.c's
include of <asm/archrandom.h>, since kaslr.c only depends on the RNDR
bits defined there./

> Fixes: 2e8e1ea88cbc ("arm64: Use v8.5-RNG entropy for KASLR seed")

I don't think this tag is necessary; this commit built and worked fine,
and there wasn't any ARCH_RANDOM bypass to speak of.

> Cc: Qian Cai <cai@lca.pw>
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

This patch itself looks fine, but as above I think the commit message is
misleading w.r.t. bypassing ARCH_RANDOM, and the second fixes tag isn't
necessary.

With those bits gone:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/kernel/kaslr.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/kaslr.c b/arch/arm64/kernel/kaslr.c
> index 9ded4237e1c1..b181e0544b79 100644
> --- a/arch/arm64/kernel/kaslr.c
> +++ b/arch/arm64/kernel/kaslr.c
> @@ -84,6 +84,7 @@ u64 __init kaslr_early_init(u64 dt_phys)
>  	void *fdt;
>  	u64 seed, offset, mask, module_range;
>  	const u8 *cmdline, *str;
> +	unsigned long raw;
>  	int size;
>  
>  	/*
> @@ -122,15 +123,12 @@ u64 __init kaslr_early_init(u64 dt_phys)
>  	}
>  
>  	/*
> -	 * Mix in any entropy obtainable architecturally, open coded
> -	 * since this runs extremely early.
> +	 * Mix in any entropy obtainable architecturally if enabled
> +	 * and supported.
>  	 */
> -	if (__early_cpu_has_rndr()) {
> -		unsigned long raw;
>  
> -		if (__arm64_rndr(&raw))
> -			seed ^= raw;
> -	}
> +	if (arch_get_random_seed_long_early(&raw))
> +		seed ^= raw;
>  
>  	if (!seed) {
>  		kaslr_status = KASLR_DISABLED_NO_SEED;
> -- 
> 2.17.1
> 
