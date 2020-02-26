Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C002C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28C6321D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nD60SHOS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgBZVBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:01:50 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44946 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgBZVBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:01:50 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so674066ljj.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 13:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cxtTUuGGBnBqk8GWMEJkzjvxvt2ATxKqyf/9k5yzLHE=;
        b=nD60SHOSpqxspfYMC9aWPBFxLAJXqr6Yy1qW6p1B8fZoz2oUyPFSw7I/VIP3k86D8h
         Trh/TLD2ys5h4iUROAlqoE4asrTwTXm/tMBGuRF9mTD2VT46M3knvGbvIG/HAehc9lji
         7B/1KRk9RPs7ppfaj8kd3fyPLVz0qAcuhX7rVfOpyDOVNLuryvmCv+QscjYRcIxtksUb
         qaKZlf84rkHfpu8fDxzkf+0f2QecafcC7faKW546HcRnLyRVEuOSDGPnOrihbKsVKOW6
         hiXem2JoUJ8+VcwYfs2aL0y+78WRIHR3LzkxWsF4cQoAXvYgX6AMUof0iQzZPA6Wzzad
         iACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cxtTUuGGBnBqk8GWMEJkzjvxvt2ATxKqyf/9k5yzLHE=;
        b=ejwwpI7zzDnLTAxiMvOMaoOmG2crXtxU1JHO6oVFVWjpticdspmGl3p6Y5145yXTiC
         R0SDkqjySqhrdxTE4Nn9hNJMMY3VPH3+RogXApmwWtLNHOvXbavMDjk1/hEA1p4k9i4G
         sR/KnvXOcp/VCPfecQRgYiLlqKY/5coUd/ba4KRUQLykzZ2X0LKHbSSe4sLjHkucstJA
         l95f6wWdt9nccytMEhR0fXk2nuv4aAsGBmA0gK1oMfrT/nw4oNkEubsXsEqn/gGvw+wY
         GRVyZt4ioeIBuC6XzTP+FOOvzIUySwI1g8QhiAjvokAGsHrCBJyXu/jysQKX7s4lc5aK
         WiQQ==
X-Gm-Message-State: ANhLgQ11Cj4BNFAPSOT1K/jEvTRw9KaQIQGFoewTsq45ZH/I4MIWudWm
        x1Qg+gaygXQnA0MNU6py1RC2I6sweCxUN92zV+VsiQ==
X-Google-Smtp-Source: ADFU+vvZ5GtCq0BwN5WueaDpR1syXQQpKP/hdIBLv5PEu+z0D1OgjehbwvoK4Rhi1oWLq16HlPlWeTFvjrFFVfeJMFg=
X-Received: by 2002:a2e:8699:: with SMTP id l25mr508265lji.137.1582750908551;
 Wed, 26 Feb 2020 13:01:48 -0800 (PST)
MIME-Version: 1.0
References: <20200226181640.21664-1-vincent.guittot@linaro.org> <xm26r1yhtbjr.fsf@bsegall-linux.svl.corp.google.com>
In-Reply-To: <xm26r1yhtbjr.fsf@bsegall-linux.svl.corp.google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 26 Feb 2020 22:01:36 +0100
Message-ID: <CAKfTPtBm9Gt16gqQgxoErOOmpbUHit6bNf4CVLvDzf04SjWtEg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix runnable_avg for throttled cfs
To:     Ben Segall <bsegall@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>, zhout@vivaldi.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020 at 20:04, <bsegall@google.com> wrote:
>
> Vincent Guittot <vincent.guittot@linaro.org> writes:
>
> > When a cfs_rq is throttled, its group entity is dequeued and its running
> > tasks are removed. We must update runnable_avg with current h_nr_running
> > and update group_se->runnable_weight with new h_nr_running at each level
> > of the hierarchy.
>
> You'll also need to do this for task enqueue/dequeue inside of a
> throttled hierarchy, I'm pretty sure.

AFAICT, this is already done with patch "sched/pelt: Add a new
runnable average signal" when task is enqueued/dequeued inside a
throttled hierarchy

>
> >
> > Fixes: 9f68395333ad ("sched/pelt: Add a new runnable average signal")
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> > This patch applies on top of tip/sched/core
> >
> >  kernel/sched/fair.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index fcc968669aea..6d46974e9be7 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4703,6 +4703,11 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
> >
> >               if (dequeue)
> >                       dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
> > +             else {
> > +                     update_load_avg(qcfs_rq, se, 0);
> > +                     se_update_runnable(se);
> > +             }
> > +
> >               qcfs_rq->h_nr_running -= task_delta;
> >               qcfs_rq->idle_h_nr_running -= idle_task_delta;
> >
> > @@ -4772,6 +4777,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> >               cfs_rq = cfs_rq_of(se);
> >               if (enqueue)
> >                       enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> > +             else {
> > +                     update_load_avg(cfs_rq, se, 0);
>
>
> > +                     se_update_runnable(se);
> > +             }
> > +
> >               cfs_rq->h_nr_running += task_delta;
> >               cfs_rq->idle_h_nr_running += idle_task_delta;
