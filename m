Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5EAC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A790220658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732525AbgIHUDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730447AbgIHPXy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:23:54 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E3942074D;
        Tue,  8 Sep 2020 14:52:40 +0000 (UTC)
Date:   Tue, 8 Sep 2020 15:52:37 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
        LKML <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 22/35] arm64: mte: Enable in-kernel MTE
Message-ID: <20200908145237.GI25591@gaia>
References: <cover.1597425745.git.andreyknvl@google.com>
 <6a83a47d9954935d37a654978e96c951cc56a2f6.1597425745.git.andreyknvl@google.com>
 <CAAeHK+y-gJ5JKcGZYfZutKtb=BoM3qfkOyoTi7CtW6apHUcCAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+y-gJ5JKcGZYfZutKtb=BoM3qfkOyoTi7CtW6apHUcCAw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 04:39:35PM +0200, Andrey Konovalov wrote:
> On Fri, Aug 14, 2020 at 7:28 PM Andrey Konovalov <andreyknvl@google.com> wrote:
> > From: Vincenzo Frascino <vincenzo.frascino@arm.com>
> >
> > The Tag Checking operation causes a synchronous data abort as
> > a consequence of a tag check fault when MTE is configured in
> > synchronous mode.
> >
> > Enable MTE in Synchronous mode in EL1 to provide a more immediate
> > way of tag check failure detection in the kernel.
> >
> > As part of this change enable match-all tag for EL1 to allow the
> > kernel to access user pages without faulting. This is required because
> > the kernel does not have knowledge of the tags set by the user in a
> > page.
> >
> > Note: For MTE, the TCF bit field in SCTLR_EL1 affects only EL1 in a
> > similar way as TCF0 affects EL0.
> >
> > Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> > ---
> >  arch/arm64/kernel/cpufeature.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> > index 4d3abb51f7d4..4d94af19d8f6 100644
> > --- a/arch/arm64/kernel/cpufeature.c
> > +++ b/arch/arm64/kernel/cpufeature.c
> > @@ -1670,6 +1670,9 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
> >         write_sysreg_s(0, SYS_TFSR_EL1);
> >         write_sysreg_s(0, SYS_TFSRE0_EL1);
> >
> > +       /* Enable Match-All at EL1 */
> > +       sysreg_clear_set(tcr_el1, 0, SYS_TCR_EL1_TCMA1);
> > +
> >         /*
> >          * CnP must be enabled only after the MAIR_EL1 register has been set
> >          * up. Inconsistent MAIR_EL1 between CPUs sharing the same TLB may
> > @@ -1687,6 +1690,9 @@ static void cpu_enable_mte(struct arm64_cpu_capabilities const *cap)
> >         mair &= ~MAIR_ATTRIDX(MAIR_ATTR_MASK, MT_NORMAL_TAGGED);
> >         mair |= MAIR_ATTRIDX(MAIR_ATTR_NORMAL_TAGGED, MT_NORMAL_TAGGED);
> >         write_sysreg_s(mair, SYS_MAIR_EL1);
> > +
> > +       /* Enable MTE Sync Mode for EL1 */
> > +       sysreg_clear_set(sctlr_el1, SCTLR_ELx_TCF_MASK, SCTLR_ELx_TCF_SYNC);
> >         isb();
> >
> >         local_flush_tlb_all();
> > --
> > 2.28.0.220.ged08abb693-goog
> >
> 
> Should we change this commit to enable in-kernel MTE only if
> KASAN_HW_TAGS is enabled?

I think so. We don't currently have any patchset decoupling MTE from
KASAN.

See my other comment on TCR_EL1.TBI1, you'd need to set TCMA1 as well in
the same proc.S file.

-- 
Catalin
