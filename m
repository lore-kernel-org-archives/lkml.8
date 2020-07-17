Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA20C433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A0520737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T6HKmBM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgGQRsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgGQRsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:48:04 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2942CC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:48:04 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a21so11722521ejj.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 10:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ouPoIbaznwUvpvUZ+d9Lmd0+7ZlkFrw9Vubc0luuMm4=;
        b=T6HKmBM9wpL/nF5N2IowQkS/pBz5KcI4emAgAF/8bejb3Rhx2qwrGgob1UjZiG3w7S
         sV6mfszfROVCaEu8RGIpZ4VkI2TfV76l3kRAt5KhIYLORviINuEzJTcBZun0PPQ+17yC
         sL7ngdlkBSr0haa/a+I8w89hJ7YH96WrmJqjEEQ0IghXlJVhpi5weKEIajlkG6ys7hyd
         bZmMEpFCkEu4wbXN27ODtK768/E5FhwvDDArao/vNYiIfxrf2lW3myBzMBQ5v233gbff
         d1eBjiTWMO6Gs1QkbbmCsFdWavwcujwbbYY4NlsshvUcQAPvgs23KuSHpFcZHhwd9zi3
         jBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ouPoIbaznwUvpvUZ+d9Lmd0+7ZlkFrw9Vubc0luuMm4=;
        b=IKHatP6jDHRLrWAzIH2fLBL+/HdH/moHgEF1KQEkFoNloMFmHqtlFKJ0o5V+nBxJ45
         UNx7y2SNA/D5Eu22ckfbJGv1e/5llSWA7gJo7d3WVchugZ38n1W7+1E+N/Bwa31TbD+R
         84prQXlMw9wAIzslsSFenxfyKEFqZ9L2HtyAu1VRhkGyJKPjIM5fC3j7+OjdoBvDpFQ6
         DctlUejfJDtBP4f2WWb4Nnbgtb8zUjf29JFhn0C2qlRiRr4EXo8h7BTlrVB7uqTwgt6n
         sCNAQ30i6UWlbViYOub9OPFOcRW4FjJjWpEooMv1BumtShkZHLqTH7/fwfEk9RlkAQuk
         jMzQ==
X-Gm-Message-State: AOAM532dCLlPvDgxmNWCtrFZ4d5ktP9ybA3Y6+yh6kPB1eAjlxMAccPM
        bJhGaaK4+9tksDl2SJSz0/D12ztG8cNi2+hCC4hEwA==
X-Google-Smtp-Source: ABdhPJxAkNoEdvBMsNoiwT/xtC3KzAJM3mngqfnMyotl0K4+5QQM9nsSc91iJTIh6/lQ8mnSCUp3b+j2mW212gFA81Q=
X-Received: by 2002:a17:906:6959:: with SMTP id c25mr9393908ejs.375.1595008082575;
 Fri, 17 Jul 2020 10:48:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
 <20200624203200.78870-5-samitolvanen@google.com> <20200624212737.GV4817@hirez.programming.kicks-ass.net>
 <20200624214530.GA120457@google.com> <20200625074530.GW4817@hirez.programming.kicks-ass.net>
 <20200625161503.GB173089@google.com> <20200625200235.GQ4781@hirez.programming.kicks-ass.net>
 <20200625224042.GA169781@google.com> <20200626112931.GF4817@hirez.programming.kicks-ass.net>
 <CABCJKucSM7gqWmUtiBPbr208wB0pc25afJXc6yBQzJDZf4LSWA@mail.gmail.com> <20200717133645.7816c0b6@oasis.local.home>
In-Reply-To: <20200717133645.7816c0b6@oasis.local.home>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Fri, 17 Jul 2020 10:47:51 -0700
Message-ID: <CABCJKuda0AFCZ-1J2NTLc-M0xax007a9u-fzOoxmU2z60jvzbA@mail.gmail.com>
Subject: Re: [RFC][PATCH] objtool,x86_64: Replace recordmcount with objtool
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
        X86 ML <x86@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Matt Helsley <mhelsley@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:36 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 17 Jul 2020 10:28:13 -0700
> Sami Tolvanen <samitolvanen@google.com> wrote:
>
> > On Fri, Jun 26, 2020 at 4:29 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Thu, Jun 25, 2020 at 03:40:42PM -0700, Sami Tolvanen wrote:
> > >
> > > > > Not boot tested, but it generates the required sections and they look
> > > > > more or less as expected, ymmv.
> > >
> > > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > > > > index a291823f3f26..189575c12434 100644
> > > > > --- a/arch/x86/Kconfig
> > > > > +++ b/arch/x86/Kconfig
> > > > > @@ -174,7 +174,6 @@ config X86
> > > > >     select HAVE_EXIT_THREAD
> > > > >     select HAVE_FAST_GUP
> > > > >     select HAVE_FENTRY                      if X86_64 || DYNAMIC_FTRACE
> > > > > -   select HAVE_FTRACE_MCOUNT_RECORD
> > > > >     select HAVE_FUNCTION_GRAPH_TRACER
> > > > >     select HAVE_FUNCTION_TRACER
> > > > >     select HAVE_GCC_PLUGINS
> > > >
> > > > This breaks DYNAMIC_FTRACE according to kernel/trace/ftrace.c:
> > > >
> > > >   #ifndef CONFIG_FTRACE_MCOUNT_RECORD
> > > >   # error Dynamic ftrace depends on MCOUNT_RECORD
> > > >   #endif
> > > >
> > > > And the build errors after that seem to confirm this. It looks like we might
> > > > need another flag to skip recordmcount.
> > >
> > > Hurm, Steve, how you want to do that?
> >
> > Steven, did you have any thoughts about this? Moving recordmcount to
> > an objtool pass that knows about call sites feels like a much cleaner
> > solution than annotating kernel code to avoid unwanted relocations.
> >
>
> Bah, I started to reply to this then went to look for details, got
> distracted, forgot about it, my laptop crashed (due to a zoom call),
> and I lost the email I was writing (haven't looked in the drafts
> folder, but my idea about this has changed since anyway).
>
> So the problem is that we process mcount references in other areas and
> that confuses the ftrace modification portion?

Correct.

> Someone just submitted a patch for arm64 for this:
>
> https://lore.kernel.org/r/20200717143338.19302-1-gregory.herrero@oracle.com
>
> Is that what you want?

That looks like the same issue, but we need to fix this on x86 instead.

Sami
