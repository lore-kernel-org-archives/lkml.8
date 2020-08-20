Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76997C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E5ED20658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sZMJamaR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgHTNQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 09:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728812AbgHTNPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 09:15:45 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E49FC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 06:15:44 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id j7so1786798oij.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uxwgX0CmrS+bL9jcwOXBNfIFagcjimHKU8Dz8OFh9wM=;
        b=sZMJamaRU56/9uttmwSR1aZ9G2hQwvy/8xKscuv5uhdh4WUpL6qL1uGWJoWCRGg/x3
         w16ByBrSQR6vmgPtfSHPBRAUrJkJ9e7/gmgKuSVoIsiSzNYEVvivHLjG8XiNUL4fh2u9
         OmnOgDnmg7k14yNQHRaGVH4UaH1qjuT3CSsM+RMR4xxNVDZHeFXYee136MF1itGmA5pt
         SYKgQSZHQHVZ8ZT7gQMZqhoKq3dheJ5g7glvd8f4/JarRBjblg8FVCCxDVDa6UnznyZv
         A5y3htjBXdZl4xw1R1GQbCR7NQXka8fvcHPtKi/SokPZEwqA/YtgMPi3M/xODRXkMZPj
         DtZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uxwgX0CmrS+bL9jcwOXBNfIFagcjimHKU8Dz8OFh9wM=;
        b=HlXnsPB0JfD2+ThL8emo7ypmxQsQxc+k+qDRYv4m0WCh/iKF1UKKsoLFLD4zl4Exof
         q9Ii/pHFyZfYCi0uv6YvQXcNnClAmPuKtiW1ODHnc4z3bpPYlAwkH+53Abys7dGrFCP2
         tgrlmTPBH8LDVDS1K/hJG5J7Csq+gRMaeQk0mMqYQCkuWJ/4q4wVa21jRrAIK2mg67Pq
         143UWXTHOXW0/zZdNVtxDYW2j7OXvOAHVwSdWiP0Zm3rTqJL+uuwbv3ZBVe1AhMKraDz
         apKrCipCVqXpdoKeSjx5jvmI6JMAqAU6ogZakAIMyZQUDKnP252JCastv5Mdmi4KSlYq
         Z/rA==
X-Gm-Message-State: AOAM531BrqOeM+c6rCytmm4aaXcKUVbbQhJUrPYC7LweXfx9ooadvgo+
        p1X1JeCVyuX4+kgCiOAW/169F/BdZLQkSvtsqnXolA==
X-Google-Smtp-Source: ABdhPJx8MtyIqEt4eq5i7NpkgELb0LW4xVC/Qxsp/06hphz7mwCsibbMQmzcpjEBP3sxVH9VQLg0AZn0NKOaarJ+bmw=
X-Received: by 2002:a05:6808:3da:: with SMTP id o26mr1573458oie.3.1597929343965;
 Thu, 20 Aug 2020 06:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200820120025.74460-1-benbjiang@tencent.com> <CAKfTPtABCbEuYf3uup5ZODyPXpUqBjgM8A5gBQqM0cQGxWk5zw@mail.gmail.com>
 <20200820125829.GT2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200820125829.GT2674@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 20 Aug 2020 15:15:32 +0200
Message-ID: <CAKfTPtBuZOb9-W5sS=DqxcuMFa8Lw=7XqMJ_YrXEgd5zvufYjA@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: avoid vruntime compensation for SCHED_IDLE task
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiang Biao <benbjiang@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jiang Biao <benbjiang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 at 14:58, <peterz@infradead.org> wrote:
>
> On Thu, Aug 20, 2020 at 02:51:06PM +0200, Vincent Guittot wrote:
> > On Thu, 20 Aug 2020 at 14:00, Jiang Biao <benbjiang@gmail.com> wrote:
> > >
> > > From: Jiang Biao <benbjiang@tencent.com>
> > >
> > > Vruntime compensation has been down in place_entity() to
> > > boot the waking procedure for fair tasks. There is no need to
> >
> > s/boot/boost/ ?
> >
> > > do that for SCHED_IDLE task actually.
> > >
> > > Not compensating vruntime for SCHED_IDLE task could make
> > > SCHED_IDLE task more harmless for normal tasks.
>
> This is rather week. It would be much better if there's some actual data
> to support this claim.
>
> > > Signed-off-by: Jiang Biao <benbjiang@tencent.com>
> > > ---
> > >  kernel/sched/fair.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 1a68a0536add..adff77676a0a 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4115,7 +4115,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
> > >                 vruntime += sched_vslice(cfs_rq, se);
> > >
> > >         /* sleeps up to a single latency don't count. */
> > > -       if (!initial) {
> > > +       if (!initial && likely(!task_has_idle_policy(task_of(se)))) {
> >
> > What if se is not a task ?
>
> Then we very much need it, because it might have fair tasks inside. I
> suppose you could do something complicated with idle_h_nr_running, but
> is all that really worth the effort?

Not sure that Jiang is using cgroups otherwise he would have seen a
warning I think.
That's been said, not compensating the vruntime for a sched_idle task
makes sense for me. Even if that will only help for others task in the
same cfs_rq

>
> > >                 unsigned long thresh = sysctl_sched_latency;
> > >
> > >                 /*
> > > --
> > > 2.21.0
> > >
