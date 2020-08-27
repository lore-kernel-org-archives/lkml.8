Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43671C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2175E20825
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbgH0KCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:02:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbgH0KCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 06:02:01 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C892075B;
        Thu, 27 Aug 2020 10:01:58 +0000 (UTC)
Date:   Thu, 27 Aug 2020 11:01:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 22/35] arm64: mte: Enable in-kernel MTE
Message-ID: <20200827100155.GD29264@gaia>
References: <cover.1597425745.git.andreyknvl@google.com>
 <6a83a47d9954935d37a654978e96c951cc56a2f6.1597425745.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a83a47d9954935d37a654978e96c951cc56a2f6.1597425745.git.andreyknvl@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 07:27:04PM +0200, Andrey Konovalov wrote:
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 4d3abb51f7d4..4d94af19d8f6 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -1670,6 +1670,9 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
>  	write_sysreg_s(0, SYS_TFSR_EL1);
>  	write_sysreg_s(0, SYS_TFSRE0_EL1);
>  
> +	/* Enable Match-All at EL1 */
> +	sysreg_clear_set(tcr_el1, 0, SYS_TCR_EL1_TCMA1);
> +
>  	/*
>  	 * CnP must be enabled only after the MAIR_EL1 register has been set
>  	 * up. Inconsistent MAIR_EL1 between CPUs sharing the same TLB may
> @@ -1687,6 +1690,9 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
>  	mair &= ~MAIR_ATTRIDX(MAIR_ATTR_MASK, MT_NORMAL_TAGGED);
>  	mair |= MAIR_ATTRIDX(MAIR_ATTR_NORMAL_TAGGED, MT_NORMAL_TAGGED);
>  	write_sysreg_s(mair, SYS_MAIR_EL1);
> +
> +	/* Enable MTE Sync Mode for EL1 */
> +	sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);

In the 8th incarnation of the user MTE patches, this initialisation
moved to proc.S before the MMU is initialised. When rebasing, please
take this into account.

-- 
Catalin
