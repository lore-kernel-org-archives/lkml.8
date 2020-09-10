Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87196C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D08F2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 16:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cIEj1NRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725831AbgIJQ1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 12:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgIJQW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 12:22:26 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A33C061795
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 09:22:26 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id n2so6497231oij.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 09:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G8lEmdXJHmLOdLPgAHRWZC3Ha8HGaj35IzxQ2qyGHjk=;
        b=cIEj1NRaBj3M+vU2iU5O6NxPxOz2OWM1BzVMyxB4iPiscMa9JGHXkOCcWTjuRKdQn+
         WW3XmjV4GSKBqibNlmOnZMdYU1FSj7QhwWIM4h/5UvZyFxO1GuT1DC2ZsFq0IUK2urFK
         2xOEYLoylWBJQlA1j2lpZSv00UpBNmW7Y1O7vtigGc8RFmSFpUQtNLAmtMH8+BCCLOfD
         HLUSvIKlP7HTRs8ocXFmIkKXrDHKTqU+YDL2DcPRmJ8isxfkmVK7mlxvfqUmKnQTJif1
         xV8/VTAG5c5yDEDHCOjSpoYUil7R3ci2GtAoq5lF1msz4i3k3XT/em3WjQHx7Fe5Yx5E
         EoIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G8lEmdXJHmLOdLPgAHRWZC3Ha8HGaj35IzxQ2qyGHjk=;
        b=HDms5HONW5RHub+7AxsfQX7O8b09FocAyjBWBk3mjzi9qbtbYOE5ugDwU+nGGyFdjR
         XngiG+lFCcpyWH/0vkxag84tw8pZTwRol6Qm5KmrAvyxVVFioRDOre1blSv0RoL4qnXd
         hZUB1kDj+f4zh2ySggpNyd8jqrX12N/paSjjNRuOdtRCumCGTNLIVdbTYCh4HJNMYZ/s
         Jg6AfnsKhiFlnaZ3gdXGOAIqT3ILWZyRAFD7DTjh/g7fCZPCb+EG/R7PSsqvb25NTYwM
         Jc06QtwlcZflwG5AFtDh8vFTKDmBzulca9n0whmZ8cJ3lwmwKikJRz8sp1CX/nbpWTKH
         C6Rg==
X-Gm-Message-State: AOAM531f7jVSoy0kysrNpXGjMVzqY68ZkafmvCKFbjssNKE9iXEwYwu3
        m9u+OOjNfh85v9xdN/x/s/+1zKkaAagVY9ez2+vfvg==
X-Google-Smtp-Source: ABdhPJzKNGteSKAUrvVsUcBoSfx3F9MALvWpVeqSzgYD6tFzAaSmto/tK7cbRNgR8Dn3g9SKOUDKEr5MqvOYL+UKHww=
X-Received: by 2002:aca:54d1:: with SMTP id i200mr508579oib.172.1599754945387;
 Thu, 10 Sep 2020 09:22:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134055.2878499-1-elver@google.com> <20200907134055.2878499-2-elver@google.com>
 <CACT4Y+aBpeQYOWGrCoaJ=HAa0BsSekyL88kcLBTGwc--C+Ch0w@mail.gmail.com>
 <CANpmjNN7qAtnUmibwGJEnxd+UcjBM1WeocoLeW0SO24NW3SkVA@mail.gmail.com> <CACT4Y+Z2Nay4mDjnHjooRa7u3ZXf72AFkF=EfkrZjCg9YEduMw@mail.gmail.com>
In-Reply-To: <CACT4Y+Z2Nay4mDjnHjooRa7u3ZXf72AFkF=EfkrZjCg9YEduMw@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 10 Sep 2020 18:22:14 +0200
Message-ID: <CANpmjNM53_yGwC1VFybzzZQ8f9wM=cjtmDdUYjWVct9CO1z6Ag@mail.gmail.com>
Subject: Re: [PATCH RFC 01/10] mm: add Kernel Electric-Fence infrastructure
To:     Dmitry Vyukov <dvyukov@google.com>
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

On Thu, 10 Sep 2020 at 17:48, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Thu, Sep 10, 2020 at 5:06 PM Marco Elver <elver@google.com> wrote:
> > > On Mon, Sep 7, 2020 at 3:41 PM Marco Elver <elver@google.com> wrote:
> > > > +config KFENCE_NUM_OBJECTS
> > > > +       int "Number of guarded objects available"
> > > > +       default 255
> > > > +       range 1 65535
> > > > +       help
> > > > +         The number of guarded objects available. For each KFENCE object, 2
> > > > +         pages are required; with one containing the object and two adjacent
> > > > +         ones used as guard pages.
> > >
> > > Hi Marco,
> > >
> > > Wonder if you tested build/boot with KFENCE_NUM_OBJECTS=65535? Can a
> > > compiler create such a large object?
> >
> > Indeed, I get a "ld: kernel image bigger than KERNEL_IMAGE_SIZE".
> > Let's lower it to something more reasonable.
> >
> > The main reason to have the limit is to constrain random configs and
> > avoid the inevitable error reports.
> >
> > > > +config KFENCE_FAULT_INJECTION
> > > > +       int "Fault injection for stress testing"
> > > > +       default 0
> > > > +       depends on EXPERT
> > > > +       help
> > > > +         The inverse probability with which to randomly protect KFENCE object
> > > > +         pages, resulting in spurious use-after-frees. The main purpose of
> > > > +         this option is to stress-test KFENCE with concurrent error reports
> > > > +         and allocations/frees. A value of 0 disables fault injection.
> > >
> > > I would name this differently. "FAULT_INJECTION" is already taken for
> > > a different thing, so it's a bit confusing.
> > > KFENCE_DEBUG_SOMETHING may be a better name.
> > > It would also be good to make it very clear in the short description
> > > that this is for testing of KFENCE itself. When I configure syzbot I
> > > routinely can't figure out if various DEBUG configs detect user
> > > errors, or enable additional unit tests, or something else.
> >
> > Makes sense, we'll change the name.
> >
> > > Maybe it should depend on DEBUG_KERNEL as well?
> >
> > EXPERT selects DEBUG_KERNEL, so depending on DEBUG_KERNEL doesn't make sense.
> >
> > > > +/*
> > > > + * Get the canary byte pattern for @addr. Use a pattern that varies based on the
> > > > + * lower 3 bits of the address, to detect memory corruptions with higher
> > > > + * probability, where similar constants are used.
> > > > + */
> > > > +#define KFENCE_CANARY_PATTERN(addr) ((u8)0xaa ^ (u8)((unsigned long)addr & 0x7))
> > >
> > > (addr) in macro body
> >
> > Done for v2.
> >
> > > > +       seq_con_printf(seq,
> > > > +                      "kfence-#%zd [0x" PTR_FMT "-0x" PTR_FMT
> > >
> > > PTR_FMT is only used in this file, should it be declared in report.c?
> >
> > It's also used by the test.
> >
> > > Please post example reports somewhere. It's hard to figure out all
> > > details of the reporting/formatting.
> >
> > They can be seen in Documentation added later in the series (also
> > viewable here: https://github.com/google/kasan/blob/kfence/Documentation/dev-tools/kfence.rst)
>
>
> Looking at the first report. I got impression we are trying to skip
> __kfence frames, but this includes it:
>
> kfence-#17 [0xffffffffb672f000-0xffffffffb672f01f, size=32,
> cache=kmalloc-32] allocated in:
>    __kfence_alloc+0x42d/0x4c0
>    __kmalloc+0x133/0x200
>
> Is it working as intended?

We're not skipping them for the allocation/free stacks. We can skip
the kfence+kmalloc frame as well.
