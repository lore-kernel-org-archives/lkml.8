Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06D9C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 731CC20707
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 19:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CzK5MevC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgH0TOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 15:14:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgH0TOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 15:14:39 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70962C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:14:39 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id m200so3556333ybf.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 12:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8EbCOeZ1KrDUva8Qo9ruBWoAtdzcTodwXUPT6QjLJgQ=;
        b=CzK5MevCoTJjSYEKsR6BXPClIs48eH9pjn6p7fKUCBn5JS6ZcYj7+wuJVw63jDYkJm
         zWBhJ/lu6AJgQP7W+lQVNnVjfA1GhaNAwSoc/7j4N4ysvalHprcpTMCgTFCsERwCEK3J
         ZlUkGW7sKCTG7SMpWyt6WwFMcHSZIDUuxWzSSVTJ29v8jeP2+3X070RVHhD2opTeQPIu
         5hqe5nAc2dApnbSaGk9LbKUyUgf6e6bDL5xmrdM7Hc0WVjjAQOXFc9/rV2MZYCdAan9+
         0wHMAE7RqUcmSgEQezkLSqEt+nozFbyVnJi0BzlX1QdVJrL37eqS7KWadSAmRYvSk+U/
         ZaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8EbCOeZ1KrDUva8Qo9ruBWoAtdzcTodwXUPT6QjLJgQ=;
        b=OhfNcSceTNTL2dercxdmeY+i8Gd24pUayw7n5dUEowmRWs8qb/dc3BxkMQiK87PPhA
         v6HAkOzxSHa21WZ+tcRxXJw7FkqhDe/uSXfWblI/b0KZkgXMePc7NqdL+6WbY0/4a1Ak
         553FYoT7aEYULkLxR2VkoFdeHueDRR7skFifWDm8i3J93vwv6xu733/fJutxcZ2TG2LT
         gy4yshfBW2T8iSZJyM32CuyoaEz8wAYXivNkaa1tUjcD+FAk2AhZccreoRb+r6vhOxMJ
         9ecEvqlkqm7okj+F0MJkm1ml2figDTQZIoC4cy2lxOAKWBjoYhaXak1YAMUl1rQxUtK/
         O1NA==
X-Gm-Message-State: AOAM5332Vdv54xEt8SHWpYxKT7IYmDfQwJPTzHHOSBDETCKWnj6HgcIe
        bjQUrSZCW510fnIhk1KgOvgJxxRiHTJqaoOJCVjlvA==
X-Google-Smtp-Source: ABdhPJxkQYG/edhUcGiwy3weZ87oxUfXXeGP9hZPA0qzfNe8+TonDNIFV26AsiWzge2Pm7kQqIj8Thn+X/uM5A/BanI=
X-Received: by 2002:a5b:744:: with SMTP id s4mr32088872ybq.26.1598555678461;
 Thu, 27 Aug 2020 12:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1597425745.git.andreyknvl@google.com> <f173aacd755e4644485c551198549ac52d1eb650.1597425745.git.andreyknvl@google.com>
 <20200827095429.GC29264@gaia> <CAAeHK+xHQDMsTehppknjNTEMFh18ufWB1XLUGdVFoc-QZ-mVrw@mail.gmail.com>
 <20200827131045.GM29264@gaia> <CAAeHK+xraz7E41b4LW6VW9xOH51UoZ+odNEDrDGtaJ71n=bQ3A@mail.gmail.com>
 <20200827145642.GO29264@gaia>
In-Reply-To: <20200827145642.GO29264@gaia>
From:   Evgenii Stepanov <eugenis@google.com>
Date:   Thu, 27 Aug 2020 12:14:26 -0700
Message-ID: <CAFKCwrhAPrognS7WtKXV-nJN-9k6BW+RWmM56z-urvbWepTAKg@mail.gmail.com>
Subject: Re: [PATCH 21/35] arm64: mte: Add in-kernel tag fault handler
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
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

On Thu, Aug 27, 2020 at 7:56 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Aug 27, 2020 at 03:34:42PM +0200, Andrey Konovalov wrote:
> > On Thu, Aug 27, 2020 at 3:10 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > On Thu, Aug 27, 2020 at 02:31:23PM +0200, Andrey Konovalov wrote:
> > > > On Thu, Aug 27, 2020 at 11:54 AM Catalin Marinas
> > > > <catalin.marinas@arm.com> wrote:
> > > > > On Fri, Aug 14, 2020 at 07:27:03PM +0200, Andrey Konovalov wrote:
> > > > > > +static int do_tag_recovery(unsigned long addr, unsigned int esr,
> > > > > > +                        struct pt_regs *regs)
> > > > > > +{
> > > > > > +     report_tag_fault(addr, esr, regs);
> > > > > > +
> > > > > > +     /* Skip over the faulting instruction and continue: */
> > > > > > +     arm64_skip_faulting_instruction(regs, AARCH64_INSN_SIZE);
> > > > >
> > > > > Ooooh, do we expect the kernel to still behave correctly after this? I
> > > > > thought the recovery means disabling tag checking altogether and
> > > > > restarting the instruction rather than skipping over it.
> [...]
> > > > Can we disable MTE, reexecute the instruction, and then reenable MTE,
> > > > or something like that?
> > >
> > > If you want to preserve the MTE enabled, you could single-step the
> > > instruction or execute it out of line, though it's a bit more convoluted
> > > (we have a similar mechanism for kprobes/uprobes).
> > >
> > > Another option would be to attempt to set the matching tag in memory,
> > > under the assumption that it is writable (if it's not, maybe it's fine
> > > to panic). Not sure how this interacts with the slub allocator since,
> > > presumably, the logical tag in the pointer is wrong rather than the
> > > allocation one.
> > >
> > > Yet another option would be to change the tag in the register and
> > > re-execute but this may confuse the compiler.
> >
> > Which one of these would be simpler to implement?
>
> Either 2 or 3 would be simpler (re-tag the memory location or the
> pointer) with the caveats I mentioned. Also, does the slab allocator
> need to touch the memory on free with a tagged pointer? Otherwise slab
> may hit an MTE fault itself.

Changing the memory tag can cause faults in other threads, and that
could be very confusing.
Probably the safest thing is to retag the register, single step and
then retag it back, but be careful with the instructions that change
the address register (like ldr x0, [x0]).

>
> > Perhaps we could somehow only skip faulting instructions that happen
> > in the KASAN test module?.. Decoding stack trace would be an option,
> > but that's a bit weird.
>
> If you want to restrict this to the KASAN tests, just add some
> MTE-specific accessors with a fixup entry similar to get_user/put_user.
> __do_kernel_fault() (if actually called) will invoke the fixup code
> which skips the access and returns an error. This way KASAN tests can
> actually verify that tag checking works, I'd find this a lot more
> useful.
>
> --
> Catalin
