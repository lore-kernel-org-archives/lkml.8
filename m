Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ABF5C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEA22137B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbgIHTdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:33:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:47724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731014AbgIHP6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:58:05 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6EA92463B;
        Tue,  8 Sep 2020 15:39:13 +0000 (UTC)
Date:   Tue, 8 Sep 2020 16:39:11 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 24/35] arm64: mte: Switch GCR_EL1 in kernel entry and exit
Message-ID: <20200908153910.GK25591@gaia>
References: <cover.1597425745.git.andreyknvl@google.com>
 <ec314a9589ef8db18494d533b6eaf1fd678dc010.1597425745.git.andreyknvl@google.com>
 <20200827103819.GE29264@gaia>
 <8affcfbe-b8b4-0914-1651-368f669ddf85@arm.com>
 <20200827121604.GL29264@gaia>
 <CAAeHK+yYEFHAQMxhL=uwfgaejo3Ld0gp5=ss38CjW6wyYCaZFw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+yYEFHAQMxhL=uwfgaejo3Ld0gp5=ss38CjW6wyYCaZFw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 04:02:06PM +0200, Andrey Konovalov wrote:
> On Thu, Aug 27, 2020 at 2:16 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Aug 27, 2020 at 11:56:49AM +0100, Vincenzo Frascino wrote:
> > > On 8/27/20 11:38 AM, Catalin Marinas wrote:
> > > > On Fri, Aug 14, 2020 at 07:27:06PM +0200, Andrey Konovalov wrote:
> > > >> diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > > >> index 7717ea9bc2a7..cfac7d02f032 100644
> > > >> --- a/arch/arm64/kernel/mte.c
> > > >> +++ b/arch/arm64/kernel/mte.c
> > > >> @@ -18,10 +18,14 @@
> > > >>
> > > >>  #include <asm/barrier.h>
> > > >>  #include <asm/cpufeature.h>
> > > >> +#include <asm/kasan.h>
> > > >> +#include <asm/kprobes.h>
> > > >>  #include <asm/mte.h>
> > > >>  #include <asm/ptrace.h>
> > > >>  #include <asm/sysreg.h>
> > > >>
> > > >> +u64 gcr_kernel_excl __read_mostly;
> > > >
> > > > Could we make this __ro_after_init?
> > >
> > > Yes, it makes sense, it should be updated only once through mte_init_tags().
> > >
> > > Something to consider though here is that this might not be the right approach
> > > if in future we want to add stack tagging. In such a case we need to know the
> > > kernel exclude mask before any C code is executed. Initializing the mask via
> > > mte_init_tags() it is too late.
> >
> > It depends on how stack tagging ends up in the kernel, whether it uses
> > ADDG/SUBG or not. If it's only IRG, I think it can cope with changing
> > the GCR_EL1.Excl in the middle of a function.
> >
> > > I was thinking to add a compilation define instead of having gcr_kernel_excl in
> > > place. This might not work if the kernel excl mask is meant to change during the
> > > execution.
> >
> > A macro with the default value works for me. That's what it basically is
> > currently, only that it ends up in a variable.
> 
> Some thoughts on the topic: gcr_kernel_excl is currently initialized
> in mte_init_tags() and depends on the max_tag value dynamically
> provided to it, so it's not something that can be expressed with a
> define. In the case of KASAN the max_tag value is static, but if we
> rely on that we make core MTE code depend on KASAN, which doesn't seem
> right from the design perspective.

The design is debatable. If we want MTE to run on production devices, we
either (1) optimise out some bits of KASAN (configurable) or (2) we
decouple MTE and KASAN completely and add new callbacks in the core code
(slab allocator etc.) specific to MTE.

My first choice is (1), unless there is a strong technical argument why
it is not possible.

-- 
Catalin
