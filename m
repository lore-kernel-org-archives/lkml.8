Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31760C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D556F2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 15:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rZS11rVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbgIJPvy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 11:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731431AbgIJPtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:49:31 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAC1C061795
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:48:46 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id cv8so3546098qvb.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mzZ2lLN/xoCXQCadMP3KD01lnN0CJF5729OTiX4TA1k=;
        b=rZS11rVGYL5ep4IWino2NQi6goYHWye6jCPxILs3Ix3/bXbZEy+oW9dhA3uWl/9kSl
         OvQfGVC3GCJPLaseAZRCG0qA4mfMcw8hk8EBu8VZ8OFLPZe1Axx64ljgqCtxruwPkZAD
         Q3vWzxZws/NIoaTu71iD4PPu6sScpp4aytj00Dg/7lyKydCTfnXeY4h4sgEM5ROww+f4
         v+N4GT/+MGo71yWSm45kTtU8uEhY8SrLw8ak87gYoy4h1Mq1a8eSEGmMCOJRpdevtoS9
         VuZUWtwRqZY8/t5WvHtrRTz1Osj7MVCaplXa1UIZPf3Hm8YvfrB0Uqc6QR+WoN8whxAZ
         7Uvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mzZ2lLN/xoCXQCadMP3KD01lnN0CJF5729OTiX4TA1k=;
        b=cabUPJKRLESdlkW7AHwTIf4nQcPHNPa4ZfoJQ52teKCaA73NIBUu6o4VCtP6F0PXmS
         7liiIQJQWpJePbZrqDbxYptec32mPGlE/dKnjr3yriIUmR4TDtIg3CAdqLxL2ooS9QIT
         d82kRIrq9ZJAj7gaTMyX7E+fK/eHklnkdkMat66ZLF6eAWIt7n0BbcyGuzGRKVw1ULl+
         zlXJPFEeGfOR+6/GyEqrsNqMmYuOWEuc6IKHPxQzjL2f+0gRJMfYAUyrJBwtqmoJaeuY
         /As0BCDP+TdG5pMPestuLLuvO51BuaFyCSWav5dZv+9aG+Qafre8X4oazkpeqKNbg6LW
         gVeA==
X-Gm-Message-State: AOAM531EuDMjbsKnh4LfNG1OpG3ptWiL0zSO4QJQBQEj2AFQs9bktirt
        t/E593BXQgIJ4NbI6R7p8ntz7r0pemDBzPHZz7EfkA==
X-Google-Smtp-Source: ABdhPJxh2XVwiSK5Cy8rwdS2ADng5rr5wnF88amN70Agx8Eq7w/KffAyyLi/G4AzlUPalDqC/TNQ17vsb+5sAfyNH4U=
X-Received: by 2002:a0c:e543:: with SMTP id n3mr9296354qvm.11.1599752925133;
 Thu, 10 Sep 2020 08:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <20200907134055.2878499-2-elver@google.com>
 <CACT4Y+aBpeQYOWGrCoaJ=HAa0BsSekyL88kcLBTGwc--C+Ch0w@mail.gmail.com> <CANpmjNN7qAtnUmibwGJEnxd+UcjBM1WeocoLeW0SO24NW3SkVA@mail.gmail.com>
In-Reply-To: <CANpmjNN7qAtnUmibwGJEnxd+UcjBM1WeocoLeW0SO24NW3SkVA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 10 Sep 2020 17:48:34 +0200
Message-ID: <CACT4Y+Z2Nay4mDjnHjooRa7u3ZXf72AFkF=EfkrZjCg9YEduMw@mail.gmail.com>
Subject: Re: [PATCH RFC 01/10] mm: add Kernel Electric-Fence infrastructure
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pekka Enberg <penberg@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, Qian Cai <cai@lca.pw>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 5:06 PM Marco Elver <elver@google.com> wrote:
> > On Mon, Sep 7, 2020 at 3:41 PM Marco Elver <elver@google.com> wrote:
> > > +config KFENCE_NUM_OBJECTS
> > > +       int "Number of guarded objects available"
> > > +       default 255
> > > +       range 1 65535
> > > +       help
> > > +         The number of guarded objects available. For each KFENCE object, 2
> > > +         pages are required; with one containing the object and two adjacent
> > > +         ones used as guard pages.
> >
> > Hi Marco,
> >
> > Wonder if you tested build/boot with KFENCE_NUM_OBJECTS=65535? Can a
> > compiler create such a large object?
>
> Indeed, I get a "ld: kernel image bigger than KERNEL_IMAGE_SIZE".
> Let's lower it to something more reasonable.
>
> The main reason to have the limit is to constrain random configs and
> avoid the inevitable error reports.
>
> > > +config KFENCE_FAULT_INJECTION
> > > +       int "Fault injection for stress testing"
> > > +       default 0
> > > +       depends on EXPERT
> > > +       help
> > > +         The inverse probability with which to randomly protect KFENCE object
> > > +         pages, resulting in spurious use-after-frees. The main purpose of
> > > +         this option is to stress-test KFENCE with concurrent error reports
> > > +         and allocations/frees. A value of 0 disables fault injection.
> >
> > I would name this differently. "FAULT_INJECTION" is already taken for
> > a different thing, so it's a bit confusing.
> > KFENCE_DEBUG_SOMETHING may be a better name.
> > It would also be good to make it very clear in the short description
> > that this is for testing of KFENCE itself. When I configure syzbot I
> > routinely can't figure out if various DEBUG configs detect user
> > errors, or enable additional unit tests, or something else.
>
> Makes sense, we'll change the name.
>
> > Maybe it should depend on DEBUG_KERNEL as well?
>
> EXPERT selects DEBUG_KERNEL, so depending on DEBUG_KERNEL doesn't make sense.
>
> > > +/*
> > > + * Get the canary byte pattern for @addr. Use a pattern that varies based on the
> > > + * lower 3 bits of the address, to detect memory corruptions with higher
> > > + * probability, where similar constants are used.
> > > + */
> > > +#define KFENCE_CANARY_PATTERN(addr) ((u8)0xaa ^ (u8)((unsigned long)addr & 0x7))
> >
> > (addr) in macro body
>
> Done for v2.
>
> > > +       seq_con_printf(seq,
> > > +                      "kfence-#%zd [0x" PTR_FMT "-0x" PTR_FMT
> >
> > PTR_FMT is only used in this file, should it be declared in report.c?
>
> It's also used by the test.
>
> > Please post example reports somewhere. It's hard to figure out all
> > details of the reporting/formatting.
>
> They can be seen in Documentation added later in the series (also
> viewable here: https://github.com/google/kasan/blob/kfence/Documentation/dev-tools/kfence.rst)


Looking at the first report. I got impression we are trying to skip
__kfence frames, but this includes it:

kfence-#17 [0xffffffffb672f000-0xffffffffb672f01f, size=32,
cache=kmalloc-32] allocated in:
   __kfence_alloc+0x42d/0x4c0
   __kmalloc+0x133/0x200

Is it working as intended?
