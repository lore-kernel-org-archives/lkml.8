Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81CF6C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F385223C8
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 15:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3kd1XId"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgIHPpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 11:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730649AbgIHPh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:37:56 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391C7C0A3BDF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 07:53:46 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 7so10195783pgm.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 07:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h4oc8hr/YvrS6TIcr2rM+0VMi5Y0HYQXm5AxoqLVhU0=;
        b=M3kd1XIdiG2XvkuCGKloch04eeb5A6g6aBO/dOIhxyEYsZFluGrTdxCvdV40JKBKyS
         F5A529/gcHMWbE17VjvMMe1P3KM6PP46oYOdjAY/S7zmkeut3mDYz+MpElAEgLD5jDtL
         jc5c/GhRR2N1F3aRx/B4u7VhcTzvJIKagrZCUUbCeFOJhUgyjbSNHAavz9Q0dOhTtGsB
         jw+Nmwbjdb2AkvrxFPlUGMeJwIhrAC3yfN4QpIdUbncTG6l8XM8gQ6zyOTfh+/MFBBcv
         ub20zW/WuZ0Vc/qMIWLUyNPzfOUgsSQOsjD7HnAXtS/57XDAYes0VHP0N/BjaHucLxI9
         g78g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h4oc8hr/YvrS6TIcr2rM+0VMi5Y0HYQXm5AxoqLVhU0=;
        b=DO3IJfteHDVAALbiz5w1HYmstDM3dNVMEV5ph9FOA7/T6hKW/+cxFxmwNlcXB7U1FD
         hxGpeQVJRU/qElyPxvONZXWqBtO/qmoFnqjz1RbgYmvo9jtfONDk02w7QU3mQFRcYHjb
         Fa5VoV+2fTS8ZcPQpqpYIVMfVaDF0OZhJakulGc8lNQNLsltzbLHksBEgpT5bsQ4Ow05
         Gf/4d+ortvXo1qBMnmlODzMe65eg1DRH7UnA5o6pMn39aIvQMY/PvJaI3jZaIiQQs9wK
         PcNnrN0dwyXWoC0pyUkG6OAc4ATGbnKFBBx/qfosowKBGzZkhhWepI2lFS40YT1gF7jI
         18Tw==
X-Gm-Message-State: AOAM531J7KjobLUnpSbZt7AuOJ182DJF3WvS/ukRClvo704mydGD5i9P
        sr9KzoUzyWkv4mwRU9f4+bmRThyVELqWvEXZ2H7F+A==
X-Google-Smtp-Source: ABdhPJxlprLfbBJLDFyTvj7RZPm2BtbklD1ycEcy9NRsm+MfrJgVB2CUb3Dub7IuO+YVJqZZUQFvp6s5FNoKeSwvJ5I=
X-Received: by 2002:a62:7cd0:: with SMTP id x199mr710416pfc.114.1599576825487;
 Tue, 08 Sep 2020 07:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <ec314a9589ef8db18494d533b6eaf1fd678dc010.1597425745.git.andreyknvl@google.com>
 <20200827103819.GE29264@gaia> <8affcfbe-b8b4-0914-1651-368f669ddf85@arm.com>
 <20200827121604.GL29264@gaia> <CAAeHK+yYEFHAQMxhL=uwfgaejo3Ld0gp5=ss38CjW6wyYCaZFw@mail.gmail.com>
In-Reply-To: <CAAeHK+yYEFHAQMxhL=uwfgaejo3Ld0gp5=ss38CjW6wyYCaZFw@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 8 Sep 2020 16:53:34 +0200
Message-ID: <CAAeHK+wZtsoPXe-ZiMJM-SdxBrraxUTfbZ5oJR8SR05qcZcQnQ@mail.gmail.com>
Subject: Re: [PATCH 24/35] arm64: mte: Switch GCR_EL1 in kernel entry and exit
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 4:02 PM Andrey Konovalov <andreyknvl@google.com> wrote:
>
> On Thu, Aug 27, 2020 at 2:16 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> >
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

Thinking more about this, I think we've actually discussed moving
KASAN_MAX_TAG to somewhere in low-level headers, so I guess we can
reuse that and make gcr_kernel_excl a define. I'll look into this.
