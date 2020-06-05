Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 099E4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:04:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A182065C
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 12:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KaWM5eMS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgFEMEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 08:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgFEME3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 08:04:29 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76321C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 05:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KZz+sQK4LPHja6YFeoddpUkcV49dBXnT6yLG+sR4tCM=; b=KaWM5eMSeJwRLEvot2bT3wItgd
        gS/wJcxl/Bkdrifs/I1kz2tBTM2gLkVzNlplI+Hxu5GRh97PBGQmCpD2jbYjy0Fsbhy/dt4W7KP5w
        tVnzblJ7WLd9owreJ+VxlVOM+qzkMsog+YOzlmdZvNIJGH+b3A72EFN02Ujz1JgyNzlrIhoga2l5X
        /A/kI68HcG502pTreIPbTvhSJAskTqM3XdJngUJMOcsO2EcNC2n7fHgnAUw6wcui3i3h0ExhQtP/0
        JJfMWdvJY3QALy7P8L+Icl+wL6WEVPogGVSRwtrNZyGpcXvfQwfi5fHb0OYLbM+AzyB/fib3sq95K
        ez54gZzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhB4l-00084B-Iy; Fri, 05 Jun 2020 12:03:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BFF74301A7A;
        Fri,  5 Jun 2020 14:03:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8847A21A75216; Fri,  5 Jun 2020 14:03:52 +0200 (CEST)
Date:   Fri, 5 Jun 2020 14:03:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions
 noinstr-compatible
Message-ID: <20200605120352.GJ3976@hirez.programming.kicks-ass.net>
References: <20200605082839.226418-1-elver@google.com>
 <CACT4Y+ZqdZD0YsPHf8UFJT94yq5KGgbDOXSiJYS0+pjgYDsx+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZqdZD0YsPHf8UFJT94yq5KGgbDOXSiJYS0+pjgYDsx+A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 12:57:15PM +0200, Dmitry Vyukov wrote:
> On Fri, Jun 5, 2020 at 10:28 AM Marco Elver <elver@google.com> wrote:
> >
> > While we lack a compiler attribute to add to noinstr that would disable
> > KCOV, make the KCOV runtime functions return if the caller is in a
> > noinstr section, and mark them noinstr.
> >
> > Declare write_comp_data() as __always_inline to ensure it is inlined,
> > which also reduces stack usage and removes one extra call from the
> > fast-path.
> >
> > In future, our compilers may provide an attribute to implement
> > __no_sanitize_coverage, which can then be added to noinstr, and the
> > checks added in this patch can be guarded by an #ifdef checking if the
> > compiler has such an attribute or not.
> 
> Adding noinstr attribute to instrumentation callbacks looks fine to me.
> 
> But I don't understand the within_noinstr_section part.
> As the cover letter mentions, kcov callbacks don't do much and we
> already have it inserted and called. What is the benefit of bailing
> out a bit earlier rather than letting it run to completion?
> Is the only reason for potential faults on access to the vmalloc-ed
> region? 

Vmalloc faults (on x86, the only arch that had them IIRC) are gone, per
this merge window.

The reason I mentioned them is because it is important that they are
gone, and that this hard relies on them being gone, and the patch didn't
call that out.

There is one additional issue though; you can set hardware breakpoint on
vmalloc space, and that would trigger #DB and then we'd be dead when we
were already in #DB (IST recursion FTW).

And that is not something you can trivially fix, because you can set the
breakpoint before the allocation (or perhaps on a previous allocation).

That said; we already have this problem with task_struct (and
task_stack). IIRC Andy wants to fix the task_stack issue by making all
of noinstr run on the entry stack, but we're not there yet.

There are no good proposals for random allocations like task_struct or
in your case kcov_area.

> Andrey, Mark, do you know if it's possible to pre-fault these areas?

Under the assumption that vmalloc faults are still a thing:

You cannot pre-fault the remote area thing, kernel threads use the mm of
the previous user task, and there is no guarantee that mm will have had
the vmalloc fault.

