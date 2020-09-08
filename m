Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B946C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1253A20732
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbgIHRM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:12:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:59170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731803AbgIHQTT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:19:19 -0400
Received: from gaia (unknown [46.69.195.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D4D522B49;
        Tue,  8 Sep 2020 14:50:22 +0000 (UTC)
Date:   Tue, 8 Sep 2020 15:50:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
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
Subject: Re: [PATCH 20/35] arm64: mte: Add in-kernel MTE helpers
Message-ID: <20200908145019.GH25591@gaia>
References: <cover.1597425745.git.andreyknvl@google.com>
 <2cf260bdc20793419e32240d2a3e692b0adf1f80.1597425745.git.andreyknvl@google.com>
 <20200827093808.GB29264@gaia>
 <CAAeHK+w-NLfCXFxJNEQ2pLpS6P3KCtAWJrxAFog9=BNiZ58wAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+w-NLfCXFxJNEQ2pLpS6P3KCtAWJrxAFog9=BNiZ58wAQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 03:23:20PM +0200, Andrey Konovalov wrote:
> On Thu, Aug 27, 2020 at 11:38 AM Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> > On Fri, Aug 14, 2020 at 07:27:02PM +0200, Andrey Konovalov wrote:
> > > diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> > > index 1c99fcadb58c..733be1cb5c95 100644
> > > --- a/arch/arm64/include/asm/mte.h
> > > +++ b/arch/arm64/include/asm/mte.h
> > > @@ -5,14 +5,19 @@
> > >  #ifndef __ASM_MTE_H
> > >  #define __ASM_MTE_H
> > >
> > > -#define MTE_GRANULE_SIZE     UL(16)
> > > +#include <asm/mte_asm.h>
> >
> > So the reason for this move is to include it in asm/cache.h. Fine by
> > me but...
> >
> > >  #define MTE_GRANULE_MASK     (~(MTE_GRANULE_SIZE - 1))
> > >  #define MTE_TAG_SHIFT                56
> > >  #define MTE_TAG_SIZE         4
> > > +#define MTE_TAG_MASK         GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
> > > +#define MTE_TAG_MAX          (MTE_TAG_MASK >> MTE_TAG_SHIFT)
> >
> > ... I'd rather move all these definitions in a file with a more
> > meaningful name like mte-def.h. The _asm implies being meant for .S
> > files inclusion which isn't the case.
> >
> > > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > > index eb39504e390a..e2d708b4583d 100644
> > > --- a/arch/arm64/kernel/mte.c
> > > +++ b/arch/arm64/kernel/mte.c
> > > @@ -72,6 +74,47 @@ int memcmp_pages(struct page *page1, struct page *page2)
> > >       return ret;
> > >  }
> > >
> > > +u8 mte_get_mem_tag(void *addr)
> > > +{
> > > +     if (system_supports_mte())
> > > +             addr = mte_assign_valid_ptr_tag(addr);
> >
> > The mte_assign_valid_ptr_tag() is slightly misleading. All it does is
> > read the allocation tag from memory.
> >
> > I also think this should be inline asm, possibly using alternatives.
> > It's just an LDG instruction (and it saves us from having to invent a
> > better function name).
> 
> Could you point me to an example of inline asm with alternatives if
> there's any? I see alternative_if and other similar macros used in
> arch/arm64/ code, is that what you mean? Those seem to always use
> static conditions, like config values, but here we have a dynamic
> system_supports_mte(). Could you elaborate on how I should implement
> this?

There are plenty of ALTERNATIVE macro uses under arch/arm64, see
arch/arm64/include/asm/alternative.h for the definition and some simple
documentation.

In this case, something like (untested, haven't even checked whether it
matches the mte_assign_valid_ptr_tag() code):

	asm(ALTERNATIVE("orr %0, %1, #0xff << 56", "ldg %0, [%1]", ARM64_HAS_MTE));

-- 
Catalin
