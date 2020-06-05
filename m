Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B78AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 651E020663
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WaP9I3El"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgFENZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726812AbgFENZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:25:46 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95174C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 06:25:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d66so4910855pfd.6
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 06:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xJJnlLNjBPmVl14e43YLrTf5lqn0jzr6Vaq59xpn/uY=;
        b=WaP9I3ElIDIApsMdYU/mTqlJHL20jm1Xb59CH5wbExpSqO4rn99KTxRdSrr20Hdm+a
         QmZbVfF0VH+hLDhx4Klz8e4fNCRVR6ZmRBkDli2RbBC/K/fGWqzwqrri/X6dWwHHboS3
         N5RPq/ZNOYEpou0LOAMortIOBYzH3n0LnHcfXvHkmpHkoMvzWZka0YwvE6se+iCbkdkH
         b6BmB2CZ4pmTgToSrsny9eMGO230gw9rNYjQoYI/iFreCKHWTYd7XsxE1R4Gbf40gnYv
         NDwSBdd/RepaAWQBpSTCa6lL+a50gbRRLKdUge92j/qStQAQ6VL7d75cFQDz0k1kydEO
         WeKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xJJnlLNjBPmVl14e43YLrTf5lqn0jzr6Vaq59xpn/uY=;
        b=FRbtzzXRtRSubUQxthhTebDGGVqaS9XxGncRKnH/14jx03Lz32j4j2RhAJJG3m1twy
         QCKgjjzWWtNpRsFbKX9iJtOYRcEE+20yJdaJx3gZjL+4EtOyfSIy/dpn0P3FG7sJlBIW
         YPlVLYDvchOMwlRGSj0oRiNjsFER10Xt/N1bmhr4iaq6d9ghJB7UxgiU70NQtG2qFYV5
         0nRtvyMg/a4m2DQD4cBhB31M46FBmx6ULlyWPHUYMv+UvOzMVohh02dgWrDpP4Pjubic
         nA5Q1asBa2uFlsy9OP2U36++gLCqSVhTiPkMBEw3xPhc/amZj7tgKPczIGieXbkBg4qC
         +Rjg==
X-Gm-Message-State: AOAM532e1ThzMaB8CgBnAJd4nrz9s6UH7WihQsrTgAwWoyIP2dN7Z3Nh
        ZbYNBEamDdrO8vRAq9t1lW2/1A0yhHsYJRBk0V0jIiKj
X-Google-Smtp-Source: ABdhPJyH03MAm3lR9m3OnxfciF8u9qhQVKG97nBBoTnGIk0LVKHMrR8saOwHYF84+w+P7fbdfxTcZewD9bDFRCg6s3Y=
X-Received: by 2002:a63:e454:: with SMTP id i20mr9457353pgk.440.1591363545752;
 Fri, 05 Jun 2020 06:25:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200605082839.226418-1-elver@google.com> <CACT4Y+ZqdZD0YsPHf8UFJT94yq5KGgbDOXSiJYS0+pjgYDsx+A@mail.gmail.com>
 <20200605120352.GJ3976@hirez.programming.kicks-ass.net>
In-Reply-To: <20200605120352.GJ3976@hirez.programming.kicks-ass.net>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 5 Jun 2020 15:25:34 +0200
Message-ID: <CAAeHK+zErjaB64bTRqjH3qHyo9QstDSHWiMxqvmNYwfPDWSuXQ@mail.gmail.com>
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions noinstr-compatible
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>, Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 2:04 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jun 05, 2020 at 12:57:15PM +0200, Dmitry Vyukov wrote:
> > On Fri, Jun 5, 2020 at 10:28 AM Marco Elver <elver@google.com> wrote:
> > >
> > > While we lack a compiler attribute to add to noinstr that would disable
> > > KCOV, make the KCOV runtime functions return if the caller is in a
> > > noinstr section, and mark them noinstr.
> > >
> > > Declare write_comp_data() as __always_inline to ensure it is inlined,
> > > which also reduces stack usage and removes one extra call from the
> > > fast-path.
> > >
> > > In future, our compilers may provide an attribute to implement
> > > __no_sanitize_coverage, which can then be added to noinstr, and the
> > > checks added in this patch can be guarded by an #ifdef checking if the
> > > compiler has such an attribute or not.
> >
> > Adding noinstr attribute to instrumentation callbacks looks fine to me.
> >
> > But I don't understand the within_noinstr_section part.
> > As the cover letter mentions, kcov callbacks don't do much and we
> > already have it inserted and called. What is the benefit of bailing
> > out a bit earlier rather than letting it run to completion?
> > Is the only reason for potential faults on access to the vmalloc-ed
> > region?
>
> Vmalloc faults (on x86, the only arch that had them IIRC) are gone, per
> this merge window.
>
> The reason I mentioned them is because it is important that they are
> gone, and that this hard relies on them being gone, and the patch didn't
> call that out.
>
> There is one additional issue though; you can set hardware breakpoint on
> vmalloc space, and that would trigger #DB and then we'd be dead when we
> were already in #DB (IST recursion FTW).
>
> And that is not something you can trivially fix, because you can set the
> breakpoint before the allocation (or perhaps on a previous allocation).
>
> That said; we already have this problem with task_struct (and
> task_stack). IIRC Andy wants to fix the task_stack issue by making all
> of noinstr run on the entry stack, but we're not there yet.
>
> There are no good proposals for random allocations like task_struct or
> in your case kcov_area.
>
> > Andrey, Mark, do you know if it's possible to pre-fault these areas?
>
> Under the assumption that vmalloc faults are still a thing:
>
> You cannot pre-fault the remote area thing, kernel threads use the mm of
> the previous user task, and there is no guarantee that mm will have had
> the vmalloc fault.

To clarify this part AFAIU it, even if we try to prefault the whole
remote area each time kcov_remote_start() is called, then (let alone
the performance impact) the kernel thread can be rescheduled between
kcov_remote_start() and kcov_remote_stop(), and then it might be
running with a different mm than the one that was used when
kcov_remote_start() happened.
