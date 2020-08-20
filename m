Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0A4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DEEA20674
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Phws8BHU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgHTOTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726947AbgHTOTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:19:44 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90548C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:19:44 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id r6so438214oon.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQb9WVGZOx9n9j1FigmsnSqdEAP41Eibw43enyJulIg=;
        b=Phws8BHUL0rUuOaS64E2fTWRZt9Xw776XjmJ2R1c/Hs4o7LUXA/dRJkOBCvjOR38Qm
         k1/SI/7I9n+X2CSLxuurpdv3E+7JZ8jK7n7+cQ/BPmCzXBdTaQWkfR9GN2cUgVn5lGLa
         G/fWMnjIvdIaYf2gOXJ83vUsrFRSkG0J60nkpCxtBv01hK9A/oIdsBnDEUvSZu39MHXp
         T/YsqM4ksVBjDaKSYM2ZYiIyTkIF/ZY+u9QotE0y9ifo8nK4tr7n6gmGV6dbBslWSc/d
         J/Nim7X6TUEoCYaZDnbBpBifL53hflbz05yy3N8Up7dTK0Ub0xP0e3snxl274kmA6xde
         KZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQb9WVGZOx9n9j1FigmsnSqdEAP41Eibw43enyJulIg=;
        b=Z3PtYeLPAF63scigEg6eZhyUHu5GngGwiZfHYXsLp1R6hUP0Z9wI+zVbPPs2i/0/Hh
         +yCPx/bZCpjUKSv+hi9dibNHFA99h+Sni4IcKhpipa/flHKvG4iJcaX+KjfU8mVKa2oH
         AWpuly+v9dgXTkUZ+cftSwWBiTzZFJvR9nc+4Q+uK4CqUR11+lZMYu3NevXPfpDSWy+p
         Ft4Hsw9Z52HG0j+l1p9Pw6p7f/d3q7NSaKUGpreSqMB0eLw/zt5X37X/bfAEBU+duqVw
         CU38eE8OK7LsOyMJRnEbSxXda9jj6awIlEWhe3LRj5SqdepTmp1jScF/lEN4+2FjH0dl
         e5HQ==
X-Gm-Message-State: AOAM530ObzwoRmaMs6WB2xlWPNcmiTECUtLYSyGJy0l4u/naYIjPTa65
        Mv5uPYWrq3v3rc9SXil3J8nzqIvZ+ayfirOyB53AeEHaVPvPEQ==
X-Google-Smtp-Source: ABdhPJyhjS63/b7WDVE9wM6oUnylRf6OwbI259OrGMTGANyQn2bOCLku2JrRZ5P9CrNozQGO1Sgqpy0LvqHAo91+ycY=
X-Received: by 2002:a4a:d2d8:: with SMTP id j24mr2588594oos.82.1597933182847;
 Thu, 20 Aug 2020 07:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200820120025.74460-1-benbjiang@tencent.com> <CAKfTPtABCbEuYf3uup5ZODyPXpUqBjgM8A5gBQqM0cQGxWk5zw@mail.gmail.com>
 <20200820125829.GT2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200820125829.GT2674@hirez.programming.kicks-ass.net>
From:   Jiang Biao <benbjiang@gmail.com>
Date:   Thu, 20 Aug 2020 22:19:32 +0800
Message-ID: <CAPJCdB=f_qSS-t_TFSjtT9uDo6q57bScCyau=gkF4E1gNcSjmQ@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: avoid vruntime compensation for SCHED_IDLE task
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
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

On Thu, 20 Aug 2020 at 20:58, <peterz@infradead.org> wrote:
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
I'll try to have a test and get some data. :)

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
Would it be better to limit to task se case? like
 +       if (!initial && likely(!entity_is_task(se) ||
!task_has_idle_policy(task_of(se)))) {



>
> > >                 unsigned long thresh = sysctl_sched_latency;
> > >
> > >                 /*
> > > --
> > > 2.21.0
> > >
