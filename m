Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B06C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B4332177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdEkfTqR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgH0MuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729129AbgH0Mqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:46:30 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57676C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:46:30 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id kx11so2530723pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BHmZEvhLEtaO7aqOAe1Kz0vxpzzyDph3TU1ME4obtnc=;
        b=gdEkfTqRbB/Kce9J4U43NYTJ0FSw5bKcLylX1r5TuuVtKYudxTe4eisWe7++garpR3
         AIMwQObELacZK6InF/KInf7LuBEgBr6AaRHQStv9BaZVNp6lw7JL0/vXQnlmoNs1v9jh
         UvrUCzc9kXrr+f1K62TpVeUwHjaTrQM0Q8ckQazsHehf9HIC23NGw5PmXOgku21EWYw2
         ju1tontr5nq6w6KtK+/MwdSriWs0LnK1SptCBWazsG9VU3nERavUd14/lRcn/w1Q0396
         A1OBPTCV1T9KDVtn6B6aMYmFHLFQKXRCnkc264DNEfKyXuPKbpWhGoPvpgJoroJWzE5h
         8vWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHmZEvhLEtaO7aqOAe1Kz0vxpzzyDph3TU1ME4obtnc=;
        b=tgU52QZHyWBqbQ7DOVNQ2vViAy7tuJA8bQbmPXKHKaD7kdq5yiC2AM9e12ctWtUl4n
         PNHXz3ZaXQaGggcSKPyU2Ql57X4o3zbaRT/Jbii1ju9wu14IxCXTGQcztD3HdT+GcuUW
         5BwL5TCzv23vKtBJBgQ9l2O3XE/IQ/Zp8bSctL/iwjsD6Mh3e5NkSPz9DaNBcUHDPh+N
         8SkgQfqCVIwmsoemadpJNAP0S2MsElabZLKFEvpsj3+v/f/SCU1KTe6wrBWsvGpmDR8f
         Hajj/ch78Eo38l9gG3QCuZkxjdTgQ9c4f2y8u+mBaOm64gJLk6uPgWU0tJJre1cc9Nu3
         WsJQ==
X-Gm-Message-State: AOAM530MX8BXc96QDpxgdOYfHXFHuNG5pDuAcg63r2RhL5O96M5VcsNH
        xOOmDqb8cgQjVUD/UsGpuuVOvjtmIVBxoxz4x/tzDg==
X-Google-Smtp-Source: ABdhPJwDOypO69lt7F9hkmMpo7AI0YZxyVjlAoqUwRCQcwPpqL5dsDTNUlMHW7hsHiiESPEGq3wlEDJDnZQgKzAqWNs=
X-Received: by 2002:a17:90a:2d82:: with SMTP id p2mr9503738pjd.166.1598532389629;
 Thu, 27 Aug 2020 05:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <2cf260bdc20793419e32240d2a3e692b0adf1f80.1597425745.git.andreyknvl@google.com>
 <20200827093808.GB29264@gaia>
In-Reply-To: <20200827093808.GB29264@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 27 Aug 2020 14:46:18 +0200
Message-ID: <CAAeHK+xFzMRLuYtPV4gsb5FByFLp0Czt2+kokYKnp+L3kQwKvg@mail.gmail.com>
Subject: Re: [PATCH 20/35] arm64: mte: Add in-kernel MTE helpers
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 11:38 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Fri, Aug 14, 2020 at 07:27:02PM +0200, Andrey Konovalov wrote:
> > diff --git a/arch/arm64/include/asm/mte.h b/arch/arm64/include/asm/mte.h
> > index 1c99fcadb58c..733be1cb5c95 100644
> > --- a/arch/arm64/include/asm/mte.h
> > +++ b/arch/arm64/include/asm/mte.h
> > @@ -5,14 +5,19 @@
> >  #ifndef __ASM_MTE_H
> >  #define __ASM_MTE_H
> >
> > -#define MTE_GRANULE_SIZE     UL(16)
> > +#include <asm/mte_asm.h>
>
> So the reason for this move is to include it in asm/cache.h. Fine by
> me but...
>
> >  #define MTE_GRANULE_MASK     (~(MTE_GRANULE_SIZE - 1))
> >  #define MTE_TAG_SHIFT                56
> >  #define MTE_TAG_SIZE         4
> > +#define MTE_TAG_MASK         GENMASK((MTE_TAG_SHIFT + (MTE_TAG_SIZE - 1)), MTE_TAG_SHIFT)
> > +#define MTE_TAG_MAX          (MTE_TAG_MASK >> MTE_TAG_SHIFT)
>
> ... I'd rather move all these definitions in a file with a more
> meaningful name like mte-def.h. The _asm implies being meant for .S
> files inclusion which isn't the case.

Sounds good, I'll leave fixing this and other arm64-specific comments
to Vincenzo. I'll change KASAN code to use mte-def.h once I have
patches where this file is renamed.

>
> > diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
> > index eb39504e390a..e2d708b4583d 100644
> > --- a/arch/arm64/kernel/mte.c
> > +++ b/arch/arm64/kernel/mte.c
> > @@ -72,6 +74,47 @@ int memcmp_pages(struct page *page1, struct page *page2)
> >       return ret;
> >  }
> >
> > +u8 mte_get_mem_tag(void *addr)
> > +{
> > +     if (system_supports_mte())
> > +             addr = mte_assign_valid_ptr_tag(addr);
>
> The mte_assign_valid_ptr_tag() is slightly misleading. All it does is
> read the allocation tag from memory.
>
> I also think this should be inline asm, possibly using alternatives.
> It's just an LDG instruction (and it saves us from having to invent a
> better function name).
>
> > +
> > +     return 0xF0 | mte_get_ptr_tag(addr);
> > +}
> > +
> > +u8 mte_get_random_tag(void)
> > +{
> > +     u8 tag = 0xF;
> > +
> > +     if (system_supports_mte())
> > +             tag = mte_get_ptr_tag(mte_assign_random_ptr_tag(NULL));
>
> Another alternative inline asm with an IRG instruction.
>
> > +
> > +     return 0xF0 | tag;
> > +}
> > +
> > +void * __must_check mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> > +{
> > +     void *ptr = addr;
> > +
> > +     if ((!system_supports_mte()) || (size == 0))
> > +             return addr;
> > +
> > +     tag = 0xF0 | (tag & 0xF);
> > +     ptr = (void *)__tag_set(ptr, tag);
> > +     size = ALIGN(size, MTE_GRANULE_SIZE);
>
> I think aligning the size is dangerous. Can we instead turn it into a
> WARN_ON if not already aligned? At a quick look, the callers of
> kasan_{un,}poison_memory() already align the size.
>
> > +
> > +     mte_assign_mem_tag_range(ptr, size);
> > +
> > +     /*
> > +      * mte_assign_mem_tag_range() can be invoked in a multi-threaded
> > +      * context, ensure that tags are written in memory before the
> > +      * reference is used.
> > +      */
> > +     smp_wmb();
> > +
> > +     return ptr;
>
> I'm not sure I understand the barrier here. It ensures the relative
> ordering of memory (or tag) accesses on a CPU as observed by other CPUs.
> While the first access here is setting the tag, I can't see what other
> access on _this_ CPU it is ordered with.
>
> > +}
> > +
> >  static void update_sctlr_el1_tcf0(u64 tcf0)
> >  {
> >       /* ISB required for the kernel uaccess routines */
> > diff --git a/arch/arm64/lib/mte.S b/arch/arm64/lib/mte.S
> > index 03ca6d8b8670..8c743540e32c 100644
> > --- a/arch/arm64/lib/mte.S
> > +++ b/arch/arm64/lib/mte.S
> > @@ -149,3 +149,44 @@ SYM_FUNC_START(mte_restore_page_tags)
> >
> >       ret
> >  SYM_FUNC_END(mte_restore_page_tags)
> > +
> > +/*
> > + * Assign pointer tag based on the allocation tag
> > + *   x0 - source pointer
> > + * Returns:
> > + *   x0 - pointer with the correct tag to access memory
> > + */
> > +SYM_FUNC_START(mte_assign_valid_ptr_tag)
> > +     ldg     x0, [x0]
> > +     ret
> > +SYM_FUNC_END(mte_assign_valid_ptr_tag)
> > +
> > +/*
> > + * Assign random pointer tag
> > + *   x0 - source pointer
> > + * Returns:
> > + *   x0 - pointer with a random tag
> > + */
> > +SYM_FUNC_START(mte_assign_random_ptr_tag)
> > +     irg     x0, x0
> > +     ret
> > +SYM_FUNC_END(mte_assign_random_ptr_tag)
>
> As I said above, these two can be inline asm.
>
> > +
> > +/*
> > + * Assign allocation tags for a region of memory based on the pointer tag
> > + *   x0 - source pointer
> > + *   x1 - size
> > + *
> > + * Note: size is expected to be MTE_GRANULE_SIZE aligned
> > + */
> > +SYM_FUNC_START(mte_assign_mem_tag_range)
> > +     /* if (src == NULL) return; */
> > +     cbz     x0, 2f
> > +     /* if (size == 0) return; */
>
> You could skip the cbz here and just document that the size should be
> non-zero and aligned. The caller already takes care of this check.
>
> > +     cbz     x1, 2f
> > +1:   stg     x0, [x0]
> > +     add     x0, x0, #MTE_GRANULE_SIZE
> > +     sub     x1, x1, #MTE_GRANULE_SIZE
> > +     cbnz    x1, 1b
> > +2:   ret
> > +SYM_FUNC_END(mte_assign_mem_tag_range)
>
> --
> Catalin
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200827093808.GB29264%40gaia.
