Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2932C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D74720768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BNRMmLHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731479AbgIHUE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730408AbgIHPXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:23:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E0BC061264
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 06:23:32 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k15so10921515pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 06:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7QJMDMbNmolR6AioGkNQtnG3AJr/WPDscGoTEPtadkI=;
        b=BNRMmLHzf/L4KStfbtlT5lPRA5uRA3qlVF6BjWYdYtCPGPu3N3+sbNok5GP3FxCwHL
         soiZ47Ocytr8BONR/bXPxZBKU5qe1b5sdBjcMsVPJCiVTXFRm6NUZJDRKzzClKLSw/QN
         2wNVwSS02//ZFGqO65wr6un2nUE8+2KjhPTL1vTihJSfmbfgzLckLmX4b906cLYM4hFb
         oAuG36s0RK2K+ru1b7aC6/VS9VISv0oNkeKDBNBveMvW531wlGGT/w2Cy40YZ1OXXOxE
         uMWKyxxqhR/pmjOxr8OmlKgWU4u5smzwhNM1w8QHoyxnAUVew0eCn8w135HTYTsfWoh/
         V+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7QJMDMbNmolR6AioGkNQtnG3AJr/WPDscGoTEPtadkI=;
        b=O82oofIGlV1jBlMTBrm/qoka4WoBzIxzlp/y+Q4OzDX/JmB0iw5XocLRoH+puW8Eqj
         9n8aqrtrxxEShYG4lRZ4UM2sQlxFUfjcLf+MCjcFPFZXI3zywfX/j6wYHtZGELmehkRs
         7wnRv1yqMPVsWPjv7I+LKgotPU4/foK/IqeJD9hm3scX3ma2R77appD7QmBwEEvImBbf
         zpd9Nkgo6p0dFFRybIhFxX5ZcqZzW402ZxDDMGwcfvhcrXVxEXZp+mXRdVbGpjBWtUzW
         B0NhvuNzKaRBikCLuhE82j2MJWSMCxPwHdBbJ+9l5/tQIO0ZoRNpL2SX2B9EyJ6i+0y5
         SsQg==
X-Gm-Message-State: AOAM5304oA6Ob/xO3vGgKFDkDZRuVi7R/64/tHZjQMyMH9JlwSlyfXQI
        Bcd0WNkJ5sx9Opdrr6JoGt/jthLG5y01DIUrJBuZIA==
X-Google-Smtp-Source: ABdhPJzTowZLkPaF7Ke2jVTQZa2hLHDoHcJM3WSVrcD+SKJADteSyd8EQhhclsk7eUVN/PuMj+uUge3z+0tBAd+51d8=
X-Received: by 2002:a17:902:b94c:b029:d0:cbe1:e737 with SMTP id
 h12-20020a170902b94cb02900d0cbe1e737mr790548pls.18.1599571411337; Tue, 08 Sep
 2020 06:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <2cf260bdc20793419e32240d2a3e692b0adf1f80.1597425745.git.andreyknvl@google.com>
 <20200827093808.GB29264@gaia>
In-Reply-To: <20200827093808.GB29264@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Tue, 8 Sep 2020 15:23:20 +0200
Message-ID: <CAAeHK+w-NLfCXFxJNEQ2pLpS6P3KCtAWJrxAFog9=BNiZ58wAQ@mail.gmail.com>
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

Could you point me to an example of inline asm with alternatives if
there's any? I see alternative_if and other similar macros used in
arch/arm64/ code, is that what you mean? Those seem to always use
static conditions, like config values, but here we have a dynamic
system_supports_mte(). Could you elaborate on how I should implement
this?
