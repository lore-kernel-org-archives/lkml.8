Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4309C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82651206DC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 22:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j2qZHmeg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgHKWWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgHKWWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 18:22:39 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240D8C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 15:22:39 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h16so399021oti.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 15:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W/huS475fQsIt3TnWXWCkTB3aVVuQSvTxEVuKvlu6dg=;
        b=j2qZHmegCEhDNspLauyB+kdVvkes8CWrlZcQqRI1LHyAMo5fB60/BzJDDlu07DLbob
         izAX8Dc4i9szyBWt1R7ga4E4pS1VjAfpm1tUutFiNhm2UIc3kJn0W0O6RdI6wzEgnxlH
         /MTvu4zc4HmX78TaVarH5jtHRol934wJjTOCOQDKvg4Bab1J3H96JCcd8SrN9CNNkd5C
         581sNDvs/rxYEFOVfutD8+GyEyM3I25/3MgPbyRn/mfIpNb8EHVJ2YPWFJJz1UORjnNt
         xM2nMDX3m73d0KHhVn4eQPEQXozuBcclCTfOZhc0JSuzY/69fgfuf7ytGCTrZ/E9lZlN
         mslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W/huS475fQsIt3TnWXWCkTB3aVVuQSvTxEVuKvlu6dg=;
        b=ZIjjMSf3ua7mdBDp+ylF55nRgX10ZxFyu8HCdV93IrwypUgf9yv2Yj49jqtyYcgFtF
         nwd0YURw3RsJgN8w2b+qei2dp5NLO/iK5lZ82JO7YqOXY+OtgPMTCsULbdpxSwXK2K0B
         MDA+4JkCXZ8c4rmrRkqb1/LNGO4oyxeS/n6AQfnf7iw7e726+udTmse4+Etip56ryrvP
         oLW74aNKG8lMAkBoUD7HC0kre0pspm2LPiwU6YfqDS3cTor6qf5K1S7N/ZQafhvXaCF9
         FZyg4Gq0oVXx3ZcC0K8XeFWcXKnpVbRrsa6uAMLpmk1oh57cfJAxrylG9qt4JG5vNGnt
         OQLA==
X-Gm-Message-State: AOAM5329+KwCuH9jk0TU0aDlq398P955V8EZgcLR2E6mo98g7IvvZuRD
        FxrslqFUgPfciM0gaa6aYTHY5uLLsyZJANfMB/4Rng==
X-Google-Smtp-Source: ABdhPJzo6xFt7EBwhEM5Yh8tY2Vg5XchQe6Al7fpjWcsazLjuKnluCY0+ec2TvIT8FBNQYO/kkPbCza3XAljg/go4qw=
X-Received: by 2002:a9d:450a:: with SMTP id w10mr6980762ote.327.1597184557742;
 Tue, 11 Aug 2020 15:22:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200810213257.438861-1-urielguajardojr@gmail.com>
 <20200810214328.GM3982@worktop.programming.kicks-ass.net> <CAG30EecPEzM7hkPxagCD8GQb=JUZhatyW50KAoaHjrHoj4BiFw@mail.gmail.com>
 <20200811190517.GG2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200811190517.GG2674@hirez.programming.kicks-ass.net>
From:   Uriel Guajardo <urielguajardo@google.com>
Date:   Tue, 11 Aug 2020 17:22:26 -0500
Message-ID: <CAG30EeehU=pjZSPDpzM81y1776sM-9XE_vrxJ44QaWU-kVJ=Ug@mail.gmail.com>
Subject: Re: [PATCH] kunit: added lockdep support
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Uriel Guajardo <urielguajardojr@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>, mingo@redhat.com,
        will@kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 2:05 PM <peterz@infradead.org> wrote:
>
> On Tue, Aug 11, 2020 at 12:03:51PM -0500, Uriel Guajardo wrote:
> > On Mon, Aug 10, 2020 at 4:43 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > On Mon, Aug 10, 2020 at 09:32:57PM +0000, Uriel Guajardo wrote:
> > > > +static inline void kunit_check_locking_bugs(struct kunit *test,
> > > > +                                         unsigned long saved_preempt_count)
> > > > +{
> > > > +     preempt_count_set(saved_preempt_count);
> > > > +#ifdef CONFIG_TRACE_IRQFLAGS
> > > > +     if (softirq_count())
> > > > +             current->softirqs_enabled = 0;
> > > > +     else
> > > > +             current->softirqs_enabled = 1;
> > > > +#endif
> > > > +#if IS_ENABLED(CONFIG_LOCKDEP)
> > > > +     local_irq_disable();
> > > > +     if (!debug_locks) {
> > > > +             kunit_set_failure(test);
> > > > +             lockdep_reset();
> > > > +     }
> > > > +     local_irq_enable();
> > > > +#endif
> > > > +}
> > >
> > > Unless you can guarantee this runs before SMP brinup, that
> > > lockdep_reset() is terminally broken.
> >
> > Good point. KUnit is initialized after SMP is set up, and KUnit can
> > also be built as a module, so it's not a guarantee that we can make.
>
> Even if you could, there's still the question of wether throwing out all
> the dependencies learned during boot is a sensible idea.
>
> > Is there any other way to turn lockdep back on after we detect a
> > failure? It would be ideal if lockdep could still run in the next test
> > case after a failure in a previous one.
>
> Not really; the moment lockdep reports a failure it turns off all
> tracking and we instantly loose state.
>
> You'd have to:
>
>  - delete the 'mistaken' dependency from the graph such that we loose
>    the cycle, otherwise it will continue to find and report the cycle.
>
>  - put every task through a known empty state which turns the tracking
>    back on.
>
> Bart implemented most of what you need for the first item last year or
> so, but the remaining bit and the second item would still be a fair
> amount of work.
>
> Also, I'm really not sure it's worth it, the kernel should be free of
> lock cycles, so just fix one, reboot and continue.
>
> > I suppose we could only display the first failure that occurs, similar
> > to how lockdep does it. But it could also be useful to developers if
> > they saw failures in subsequent test cases, with the knowledge that
> > those failures may be unreliable.
>
> People already struggle with lockdep reports enough; I really don't want
> to given them dodgy report to worry about.

Ah, ok! Fair enough, thanks for the info. Although resetting lockdep
would be nice to have in the future, I think it's enough to only
report the first failure and warn the user that further test cases
will have lockdep disabled. People can then fix the issue and then
re-run it. I'll follow up with a patch that does this.
