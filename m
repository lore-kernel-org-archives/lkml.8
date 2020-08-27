Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201F9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F27582054F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728403AbgH0O5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:57:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbgH0MZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:25:28 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D0BA207CD;
        Thu, 27 Aug 2020 12:16:06 +0000 (UTC)
Date:   Thu, 27 Aug 2020 13:16:04 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
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
Subject: Re: [PATCH 24/35] arm64: mte: Switch GCR_EL1 in kernel entry and exit
Message-ID: <20200827121604.GL29264@gaia>
References: <cover.1597425745.git.andreyknvl@google.com>
 <ec314a9589ef8db18494d533b6eaf1fd678dc010.1597425745.git.andreyknvl@google.com>
 <20200827103819.GE29264@gaia>
 <8affcfbe-b8b4-0914-1651-368f669ddf85@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8affcfbe-b8b4-0914-1651-368f669ddf85@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 11:56:49AM +0100, Vincenzo Frascino wrote:
> On 8/27/20 11:38 AM, Catalin Marinas wrote:
> > On Fri, Aug 14, 2020 at 07:27:06PM +0200, Andrey Konovalov wrote:
> >> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> >> index 7717ea9bc2a7..cfac7d02f032 100644
> >> --- a/arch/arm64/kernel/mte.c
> >> +++ b/arch/arm64/kernel/mte.c
> >> @@ -18,10 +18,14 @@
> >>  
> >>  #include <asm/barrier.h>
> >>  #include <asm/cpufeature.h>
> >> +#include <asm/kasan.h>
> >> +#include <asm/kprobes.h>
> >>  #include <asm/mte.h>
> >>  #include <asm/ptrace.h>
> >>  #include <asm/sysreg.h>
> >>  
> >> +u64 gcr_kernel_excl __read_mostly;
> > 
> > Could we make this __ro_after_init?
> 
> Yes, it makes sense, it should be updated only once through mte_init_tags().
> 
> Something to consider though here is that this might not be the right approach
> if in future we want to add stack tagging. In such a case we need to know the
> kernel exclude mask before any C code is executed. Initializing the mask via
> mte_init_tags() it is too late.

It depends on how stack tagging ends up in the kernel, whether it uses
ADDG/SUBG or not. If it's only IRG, I think it can cope with changing
the GCR_EL1.Excl in the middle of a function.

> I was thinking to add a compilation define instead of having gcr_kernel_excl in
> place. This might not work if the kernel excl mask is meant to change during the
> execution.

A macro with the default value works for me. That's what it basically is
currently, only that it ends up in a variable.

-- 
Catalin
