Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B3BAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66FDE22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I1epf77j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726153AbgH0M7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgH0MmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:42:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839D6C06121B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:31:39 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id q1so2515369pjd.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 05:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yQ34VdsT1gZZpD4I8FVa5CTJn00Te78jNd2pA6lLPkY=;
        b=I1epf77jfolvXZ3lxPPerNV6b8ZR+vAs1jMXJRljeHO4smH2mv2d/HofqXH/7th22j
         RAuCv5zawN4S0NQp1oMcbV7rprwSgI9inHZv6mH5ztgY0JijkSvpAwvgvIgUuNEz/J7m
         +h5oynsBLzazcuzTgTdIrP0CLSswcNzISkJ2Dhg+naUoEP7PfnG3dEnEqXF3lwxRjH/k
         1HkGx3MrXz0pMyMcOldMH88mE1GlygmVmHBRAC5UtpsHzusbufe4vrn2WbIPqpjnehrD
         GN4t7ktbeaWZUrIDi3yQuWHZXqVtYYvF6aUj+le8gk/4mQwukcfGQBu0f87Vf1dKd1rh
         Iiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQ34VdsT1gZZpD4I8FVa5CTJn00Te78jNd2pA6lLPkY=;
        b=EU5zHpjJWTwFLISnYOdohbE2aKFb0dLGMOoQG3KVW7K+Vwt8XUBxuu1Y7Wsb8GSndL
         DQJ3MDd8WXhMso//WCbmzjwj4Hvm3iBLFV4XHdJnAoUQdnVzA8CPjGgM2iT09P8/A5VG
         jVxhe5x3jXBcSuvZtVExpJJ17GF99y0VtZsSzZAqctX/ImGGdbaSNn2mjGB7R1KFWFr0
         7CL9zyJL2ANQVS9aqEG2Gpy5HJI/de3kT/Ut+JSBCimKifqAlkVzbXYR2AYijsFbW0QE
         8pE7jMhqzr11aBE/B4SOMKdP6Rt9aHSTpYy8If5AzNpHv2Tgo+2QBnBI2/JcUrFW0God
         Zthg==
X-Gm-Message-State: AOAM530eSOclNFyRXtQ+A+G3tl22YEah4CnI0X1EZi3pgg3V2XjKHmlC
        lQnBkMf+APkYgquy7qUfBpC0z7QB34q4AagEhnUTQw==
X-Google-Smtp-Source: ABdhPJwxzIdT6r9g81onp4MRqvYw7f8GGSwFXswQ6f0+r9QV6hN6QDWWv4HYAZfzDIlvMnb+t7jPZJne+TEwcPQdEZ8=
X-Received: by 2002:a17:90a:a791:: with SMTP id f17mr10252307pjq.136.1598531494572;
 Thu, 27 Aug 2020 05:31:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <f173aacd755e4644485c551198549ac52d1eb650.1597425745.git.andreyknvl@google.com>
 <20200827095429.GC29264@gaia>
In-Reply-To: <20200827095429.GC29264@gaia>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Thu, 27 Aug 2020 14:31:23 +0200
Message-ID: <CAAeHK+xHQDMsTehppknjNTEMFh18ufWB1XLUGdVFoc-QZ-mVrw@mail.gmail.com>
Subject: Re: [PATCH 21/35] arm64: mte: Add in-kernel tag fault handler
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
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

On Thu, Aug 27, 2020 at 11:54 AM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> On Fri, Aug 14, 2020 at 07:27:03PM +0200, Andrey Konovalov wrote:
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 5e832b3387f1..c62c8ba85c0e 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -33,6 +33,7 @@
> >  #include <asm/debug-monitors.h>
> >  #include <asm/esr.h>
> >  #include <asm/kprobes.h>
> > +#include <asm/mte.h>
> >  #include <asm/processor.h>
> >  #include <asm/sysreg.h>
> >  #include <asm/system_misc.h>
> > @@ -222,6 +223,20 @@ int ptep_set_access_flags(struct vm_area_struct *vma,
> >       return 1;
> >  }
> >
> > +static bool is_el1_mte_sync_tag_check_fault(unsigned int esr)
> > +{
> > +     unsigned int ec = ESR_ELx_EC(esr);
> > +     unsigned int fsc = esr & ESR_ELx_FSC;
> > +
> > +     if (ec != ESR_ELx_EC_DABT_CUR)
> > +             return false;
> > +
> > +     if (fsc == ESR_ELx_FSC_MTE)
> > +             return true;
> > +
> > +     return false;
> > +}
> > +
> >  static bool is_el1_instruction_abort(unsigned int esr)
> >  {
> >       return ESR_ELx_EC(esr) == ESR_ELx_EC_IABT_CUR;
> > @@ -294,6 +309,18 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
> >       do_exit(SIGKILL);
> >  }
> >
> > +static void report_tag_fault(unsigned long addr, unsigned int esr,
> > +                          struct pt_regs *regs)
> > +{
> > +     bool is_write = ((esr & ESR_ELx_WNR) >> ESR_ELx_WNR_SHIFT) != 0;
> > +
> > +     pr_alert("Memory Tagging Extension Fault in %pS\n", (void *)regs->pc);
> > +     pr_alert("  %s at address %lx\n", is_write ? "Write" : "Read", addr);
> > +     pr_alert("  Pointer tag: [%02x], memory tag: [%02x]\n",
> > +                     mte_get_ptr_tag(addr),
> > +                     mte_get_mem_tag((void *)addr));
> > +}
> > +
> >  static void __do_kernel_fault(unsigned long addr, unsigned int esr,
> >                             struct pt_regs *regs)
> >  {
> > @@ -317,12 +344,16 @@ static void __do_kernel_fault(unsigned long addr, unsigned int esr,
> >                       msg = "execute from non-executable memory";
> >               else
> >                       msg = "read from unreadable memory";
> > +     } else if (is_el1_mte_sync_tag_check_fault(esr)) {
> > +             report_tag_fault(addr, esr, regs);
> > +             msg = "memory tagging extension fault";
>
> IIUC, that's dead code. See my comment below on do_tag_check_fault().
>
> >       } else if (addr < PAGE_SIZE) {
> >               msg = "NULL pointer dereference";
> >       } else {
> >               msg = "paging request";
> >       }
> >
> > +
>
> Unnecessary empty line.
>
> >       die_kernel_fault(msg, addr, esr, regs);
> >  }
> >
> > @@ -658,10 +689,27 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> >       return 0;
> >  }
> >
> > +static int do_tag_recovery(unsigned long addr, unsigned int esr,
> > +                        struct pt_regs *regs)
> > +{
> > +     report_tag_fault(addr, esr, regs);
> > +
> > +     /* Skip over the faulting instruction and continue: */
> > +     arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
>
> Ooooh, do we expect the kernel to still behave correctly after this? I
> thought the recovery means disabling tag checking altogether and
> restarting the instruction rather than skipping over it.

The intention is to be able to catch multiple MTE faults without
panicking or disabling MTE when executing KASAN tests (those do
multiple bad accesses one after another). We do
arm64_skip_faulting_instruction() for software tag-based KASAN too,
it's not ideal, but works for testing purposes.

Can we disable MTE, reexecute the instruction, and then reenable MTE,
or something like that?

When running in-kernel MTE in production, we'll either panic or
disable MTE after the first fault. This was controlled by the
panic_on_mte_fault option Vincenzo initially had.

> We only skip if we emulated it.

I'm not sure I understand this part, what do you mean by emulating?

>
> > +
> > +     return 0;
> > +}
> > +
> > +
> >  static int do_tag_check_fault(unsigned long addr, unsigned int esr,
> >                             struct pt_regs *regs)
> >  {
> > -     do_bad_area(addr, esr, regs);
> > +     /* The tag check fault (TCF) is per TTBR */
> > +     if (is_ttbr0_addr(addr))
> > +             do_bad_area(addr, esr, regs);
> > +     else
> > +             do_tag_recovery(addr, esr, regs);
>
> So we never invoke __do_kernel_fault() for a synchronous tag check in
> the kernel. What's with all the is_el1_mte_sync_tag_check_fault() check
> above?
>
> --
> Catalin
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20200827095429.GC29264%40gaia.
