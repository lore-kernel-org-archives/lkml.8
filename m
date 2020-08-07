Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLACK,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16616C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCDF2204EC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726630AbgHGRfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:35:23 -0400
Received: from foss.arm.com ([217.140.110.172]:60304 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726038AbgHGRfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:35:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B71E1FB;
        Fri,  7 Aug 2020 10:35:22 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7AA713F7D7;
        Fri,  7 Aug 2020 10:35:20 -0700 (PDT)
Date:   Fri, 7 Aug 2020 18:35:14 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
        tytso@mit.edu, Qian Cai <cai@lca.pw>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] arm64: kaslr: Use standard early random function
Message-ID: <20200807173513.GR6750@gaia>
References: <20200807144521.34732-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807144521.34732-1-linux@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 07:45:21AM -0700, Guenter Roeck wrote:
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
> to solve the problem.
> 
> Reported-by: Qian Cai <cai@lca.pw>
> Fixes: 585524081ecd ("random: random.h should include archrandom.h, not the other way around")
> Cc: Qian Cai <cai@lca.pw>
> Cc: Mark Brown <broonie@kernel.org>
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Tested-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>

Linus, could you please pick this up directly? Otherwise, it will wait
until we reach -rc1 to avoid basing a branch on a random commit.

(at the moment I can't build Linus' tree at all, fails early with some
device tree errors)

Thanks.

-- 
Catalin
