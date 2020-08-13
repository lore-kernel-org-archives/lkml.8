Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB30BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 13:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A328207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 13:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dx3NyCqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgHMNPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgHMNPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 09:15:43 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551F4C061383
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 06:15:42 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u63so4977684oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 06:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=amVDbDf/cLsaykKYWF9FuSxMbm/nBOZt2H1uNX9eFZ8=;
        b=dx3NyCqigtr2t3jtQ/IMwtuMBkhILVT1UmzPUtb4b2jCYAr+ZYn7BPmv3+YmijhshN
         P4khHU8jeFGpytrXSxxCyJfspnPyk4/VdLTgIcIsger4AhcutPrQvLAM8wc9ap3KfvTq
         IQ8RmnmQUQa+qA12npIau3fVNGq7AvSlTXJx/+Td8fIPUPs9ozva718Ag2JmCk/WuvHz
         ji+vVofQrr44BpY19X/RvLQnuTMbhVKh0Dm92Ld47aX6xHuMfh3Sj5t6ePFGP/iDQ9O5
         tRQjb11AI+GERSlmpHzmfTiYD6VUxTaB6cvV2gqu4Kw49IlrE39YWiDFUq8PGA8j/yBw
         f+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=amVDbDf/cLsaykKYWF9FuSxMbm/nBOZt2H1uNX9eFZ8=;
        b=GihnAeAkBN+x96OYMqIG8pyYJwAOZVz3KLd7MmaVIOasPgshJp6OmiN5OHiNjwL0Hl
         tYJbn51XHdFCpL2T7at07uP7C/gEObjL8oezzJtkgPkMqaba45yBmCW8ZW20xLxaEn3B
         N/8QL6SmIwbY6yT8rcWkUloX7ocBKsT+9bdX2lVwNfcVQq7/CnzqZbK3Ln5zCrNX3BJn
         thJ357pb6JS4Q1aXBftthLUM3qzL0cet5syLVBIh065AO2+lzKYJ2LgkWbJd4ptNvV9O
         vVcKd0c+Zj+JUf7icVVupoDfZKUAfuKHUzrxd1tZr9+a/gM0swjUDOgccI3X7dQP6NXX
         E2Cw==
X-Gm-Message-State: AOAM531nRqXOMwHbH/nh7kXA/z72XQwEcs6kfRA6mOfnl3npW7wq8R2B
        WPdc7kRr7xdv9TUzbS9nDEPPdSuuh0y/NcyePyf4Mg==
X-Google-Smtp-Source: ABdhPJzT91SoRH9TzoDHHDkZs8acikukFVst91Z+8KqgqXM6PYEOrqrEbVPQF8tqWyPsnWaufHxMCs0RUWuUOwzHLqk=
X-Received: by 2002:a54:480c:: with SMTP id j12mr3393250oij.85.1597324538126;
 Thu, 13 Aug 2020 06:15:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200812193332.954395-1-urielguajardojr@gmail.com> <20200813103615.GT2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200813103615.GT2674@hirez.programming.kicks-ass.net>
From:   Uriel Guajardo <urielguajardo@google.com>
Date:   Thu, 13 Aug 2020 08:15:27 -0500
Message-ID: <CAG30Eec2w1zG7CEd=TVGoNssCZu49TBF+1xXPKrKh+d7hJZfsg@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: added lockdep support
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

On Thu, Aug 13, 2020 at 5:36 AM <peterz@infradead.org> wrote:
>
> On Wed, Aug 12, 2020 at 07:33:32PM +0000, Uriel Guajardo wrote:
> > KUnit will fail tests upon observing a lockdep failure. Because lockdep
> > turns itself off after its first failure, only fail the first test and
> > warn users to not expect any future failures from lockdep.
> >
> > Similar to lib/locking-selftest [1], we check if the status of
> > debug_locks has changed after the execution of a test case. However, we
> > do not reset lockdep afterwards.
> >
> > Like the locking selftests, we also fix possible preemption count
> > corruption from lock bugs.
>
> > +static void kunit_check_locking_bugs(struct kunit *test,
> > +                                  unsigned long saved_preempt_count,
> > +                                  bool saved_debug_locks)
> > +{
> > +     preempt_count_set(saved_preempt_count);
> > +#ifdef CONFIG_TRACE_IRQFLAGS
> > +     if (softirq_count())
> > +             current->softirqs_enabled = 0;
> > +     else
> > +             current->softirqs_enabled = 1;
> > +#endif
>
> Urgh, don't silently change these... if they're off that's a hard fail.
>
>         if (DEBUG_LOCKS_WARN_ON(preempt_count() != saved_preempt_count))
>                 preempt_count_set(saved_preempt_count);
>
> And by using DEBUG_LOCKS_WARN_ON() it will kill IRQ tracing and trigger
> the below fail.

Hmm, I see. My original assumption was that lock related bugs that
could corrupt preempt_count would always be intervened by lockdep
(resulting in debug_locks already being off). Is this not always true?
In any case, I think it's better to explicitly show the failure
associated with preemption count as you have done, but I'm still
curious.

Also, for further clarification: the check you have made on
preempt_count also covers softirq_count, right? My understanding is
that softirqs are re-{enabled/disabled} due to the corruption of the
preemption count, so no changes should occur if the preemption count
remains the same. If it does change, we've already failed from
DEBUG_LOCKS_WARN_ON.

>
> > +     if (saved_debug_locks && !debug_locks) {
> > +             kunit_set_failure(test);
> > +             kunit_warn(test, "Dynamic analysis tool failure from LOCKDEP.");
> > +             kunit_warn(test, "Further tests will have LOCKDEP disabled.");
> > +     }
> > +}
