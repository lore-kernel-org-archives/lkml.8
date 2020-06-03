Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC18C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D4E205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A5dMEFz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726221AbgFCR0j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgFCR0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:26:39 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE775C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 10:26:38 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id x202so2496939oix.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUrXAxbaK8qdUKcp3CbtwChnwnIyrE0At9MXTdrVxtQ=;
        b=A5dMEFz+3vRovcqAyCo5oehkK3bj8teEcWwCbRKb1Yxe5eAyHo0+HiXvR9A4vYoY+X
         NhQReaf9Mi4jk64bFbBh0gU21nmXmq7BGYQeFmtJsNZtdclj+SvzxVelkEMH8VdgXlv/
         hy7OH8AOiRk2JJZSLSLMuUG3atdVezr7YG1mKqSSFbrmH9aPa292OamWoZuLp/k2Mhyu
         qv1ZB59tr954bmzTJ6ELZu67N/idCSqbEdWWLGXRhTodRk0ibDX4U97r6AHfeKa3HSvV
         wZtJE++do/PVpmBPiP2akm0VTjUxQWGAkp69UMy0gT49oLWpPMzeQ9uSQytLI26EUQt3
         e2Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VUrXAxbaK8qdUKcp3CbtwChnwnIyrE0At9MXTdrVxtQ=;
        b=XI0ZwXhOjAfNEY7BSVbep6eQP9wPzDE2WStK0b3taHsDLCGehSfqsxZA3lPEOKb2Kz
         Tl2i9EVtywNz7UluEAvbH6l/xxSToG79Dd8QUa5gtzXZc4qd/1Ib391n0xiXyhnb9jfl
         czNvGFJOFkh1nn7yT9VT6e6Vupz9OLVSmhP2EcG/M6tcKrPGqYYnX1Oemhuv9Vrz7pbw
         XkdUpFLAenMUpTQJASY7RbFdTUoCoI5jW5Wx/5kVYFtE6hvYbkgcfu2KrJdn2aafTAMN
         hreR+yZwPiZKzT92SQ5p3sNztJV3L4jblhDpVo7selgrMV0rngDFIWuD9DGiZe0aeAOc
         zEWA==
X-Gm-Message-State: AOAM530vKNHnMFY19TT/Ry8kgg5xBk8lX1jWT2ZfvII+/mRlZKKNScCr
        sWp9AOEe7PPSPKMmaaVScNZwKTxVgSgSB7zzlrcySg==
X-Google-Smtp-Source: ABdhPJz0J5rPCj5Mwl4lzlIdhf/22/TdIgxVL8tvh3coN+fAiGBzHphPcV7hmqKHcEXQ3pFWAYJf4vK4TmO6awFY6rQ=
X-Received: by 2002:a05:6808:3ac:: with SMTP id n12mr545955oie.172.1591205197996;
 Wed, 03 Jun 2020 10:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200603114014.152292216@infradead.org> <20200603120037.GA2570@hirez.programming.kicks-ass.net>
 <20200603120818.GC2627@hirez.programming.kicks-ass.net> <CANpmjNOxLkqh=qpHQjUC_bZ0GCjkoJ4NxF3UuNGKhJSvcjavaA@mail.gmail.com>
 <20200603121815.GC2570@hirez.programming.kicks-ass.net> <CANpmjNPxMo0sNmkbMHmVYn=WJJwtmYR03ZtFDyPhmiMuR1ug=w@mail.gmail.com>
 <CANpmjNPzmynV2X+e76roUmt_3oq8KDDKyLLsgn__qtAb8i0aXQ@mail.gmail.com> <20200603160722.GD2570@hirez.programming.kicks-ass.net>
In-Reply-To: <20200603160722.GD2570@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 3 Jun 2020 19:26:25 +0200
Message-ID: <CANpmjNMCAv4JS1Go0KUoCgc5y17ROTbaEGFy=tAYosE9sOAnAg@mail.gmail.com>
Subject: Re: [PATCH 0/9] x86/entry fixes
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Jun 2020 at 18:07, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Jun 03, 2020 at 04:47:54PM +0200, Marco Elver wrote:
>
> > This is fun: __always_inline functions inlined into
> > __no_sanitize_undefined *do* get instrumented because apparently UBSan
> > passes must run before the optimizer (before inlining), contrary to
> > what [ATM]SAN instrumentation does. Both GCC and Clang do this.
>
> That's just broken :-( You can keep it marked and then strip it out at
> the end if it turns out it wasn't needed after all (of course I do
> realize this might not be entirely as trivial as it sounds).

Eventually we may get the compilers to do this. But adding even more
ifdefs and Kconfig variables to check which combinations of things
work is getting out of hand. :-/ So if we can make the below work
would be great.

> > Some options to fix:
> >
> > 1. Add __no_sanitize_undefined to the problematic __always_inline
> > functions. I don't know if a macro like '#define
> > __always_inline_noinstr __always_inline __no_sanitize_undefined' is
> > useful, but it's not an automatic fix either. This option isn't great,
> > because it doesn't really scale.
>
> Agreed, that's quite horrible and fragile.
>
> > 2. If you look at the generated code for functions with
> > __ubsan_handle_*, all the calls are actually guarded by a branch. So
> > if we know that there is no UBSan violation in the function, AFAIK
> > we're fine.
>
> > What are the exact requirements for 'noinstr'?
>
> > Is it only "do not call anything I didn't tell you to call?" If that's
> > the case, and there is no bug in the function ;-), then for UBSan
> > we're fine.
>
> This; any excursion out of noinstr for an unknown reason can have
> unknown side effects which we might not be able to deal with at that
> point.
>
> For instance, if we cause a #PF before the current #PF has read CR2,
> we're hosed. If we hit a hardware breakpoint before we're ready for it,
> we're hosed (and we explicitly disallow setting breakpoints on noinstr,
> but not stuff outside it).
>
> So IFF UBSAN only calls out when things have gone wrong, as opposed to
> checking if things go wrong (say, an out-of-line bounds check), then,
> indeed, assuming no bug, no harm in having them.
>
> And in that regard they're no different from all the WARN_ON() crud we
> have all over the place, those are deemed safe under the assumption they
> don't happen either.
>
> > With that in mind, you could whitelist "__ubsan_handle"-prefixed
> > functions in objtool. Given the __always_inline+noinstr+__ubsan_handle
> > case is quite rare, it might be reasonable.
>
> Yes, I think so. Let me go have dinner and then I'll try and do a patch
> to that effect.

Very good. Yes, UBSan inlines the check and the __ubsan_handle
functions are just to generate the report.

Thanks,
-- Marco
