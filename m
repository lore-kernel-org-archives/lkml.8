Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F37AC4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:12:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2722469D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x6GyZJy6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgB0NMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:12:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36278 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729125AbgB0NMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:12:23 -0500
Received: by mail-lj1-f194.google.com with SMTP id r19so3360938ljg.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hgDPuFgqNNjYp8TK2gleYVtj6m36FxOdqFNLJteFThk=;
        b=x6GyZJy624MM4KUrgtjgaSsHLegnL3Bb7n2ZitPwN+zfj1Pg3KLtkB3ZCMl4nwFyEW
         hhP56CT/202FsxHWk7AqyRdlC+/0aJyEKba0lajgDUDeDU/KPGUXvM1qFiPQmrV/xN4/
         sJ74v5eZ+AYFhk8VK9bK3C++p8ZGLVcJzywmvjh+RvSSzce6LPjbMdiqnmLfmYIWQSCf
         HIIDX4RdlkA5axhx505gaIvknMFrlKa0Vdwru1tu9XqfGzEWv0DKE3lvrjBPTfP9Y8eF
         2aXqbguYzt3V6+F8RKmZIixVTeLcaeuwIh18hV43vaXfsaO4CBXSxnCgPt+hvrEbaNtq
         6E7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hgDPuFgqNNjYp8TK2gleYVtj6m36FxOdqFNLJteFThk=;
        b=C0uaIPCiVQKtAOMtyloiQuvzv/yu9ad7jp0Ecd1Irqcx9JfqNqWfVlkX+uYJURq64/
         8O2Nfpy5LI0DHMBTkNrdkwgUSdmAle0A/xr+pp9wBScYfR3gMETPI1P1HTaFt4CXPXJ8
         cj+BEErnT2Ftse6SzBOhb2OOOT7Abdp0V+CF7uilKbLO5cDzZOO8Re2jGGWgFA0iDU1A
         nEBDxgYgWqjWuvt76mrRgZj0qHA2VNu8HCerYsy1u4Xh9tWF5Y1RKSmzifoTZbG78Q3v
         LlLu9WBrJ5X2ODLKnI53Lr6/JItyERnAQqg1g1LncWQoLrcdDi0JIJDF7oZbBy3/p89h
         fH9g==
X-Gm-Message-State: ANhLgQ3Rv+ZABjDY+grvjaFrkDTKdL1Pf7ldWjUW9+392G0s14DTyXxX
        +0wZ4iSL9Tn+vEys6ao6GpfR9UIxFYjLBdzRLPIhUg==
X-Google-Smtp-Source: ADFU+vu+rgrjksiwfPL94ft7zljBUIH5zzDgAQw4cMlCo7H06NO12Dmy65wga/LRyMVB5J7uzt/sf8SLOsHISAlayiY=
X-Received: by 2002:a2e:808a:: with SMTP id i10mr2789949ljg.151.1582809140984;
 Thu, 27 Feb 2020 05:12:20 -0800 (PST)
MIME-Version: 1.0
References: <20200226181640.21664-1-vincent.guittot@linaro.org>
 <xm26r1yhtbjr.fsf@bsegall-linux.svl.corp.google.com> <CAKfTPtBm9Gt16gqQgxoErOOmpbUHit6bNf4CVLvDzf04SjWtEg@mail.gmail.com>
 <8f72ea72-f36d-2611-e026-62ddff5c3422@arm.com> <20200227131228.GA5872@geo.homenetwork>
In-Reply-To: <20200227131228.GA5872@geo.homenetwork>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 27 Feb 2020 14:12:09 +0100
Message-ID: <CAKfTPtBXYTORWdx9fGOBgEMYk6noa7X-4RSdSM+gKgv47nmjXw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix runnable_avg for throttled cfs
To:     Tao Zhou <zhout@vivaldi.net>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 at 14:10, Tao Zhou <zhout@vivaldi.net> wrote:
>
> Hi Dietmar,
>
> On Thu, Feb 27, 2020 at 11:20:05AM +0000, Dietmar Eggemann wrote:
> > On 26.02.20 21:01, Vincent Guittot wrote:
> > > On Wed, 26 Feb 2020 at 20:04, <bsegall@google.com> wrote:
> > >>
> > >> Vincent Guittot <vincent.guittot@linaro.org> writes:
> > >>
> > >>> When a cfs_rq is throttled, its group entity is dequeued and its running
> > >>> tasks are removed. We must update runnable_avg with current h_nr_running
> > >>> and update group_se->runnable_weight with new h_nr_running at each level
> >
> >                                               ^^^
> >
> > Shouldn't his be 'curren' rather 'new' h_nr_running for
> > group_se->runnable_weight? IMHO, you want to cache the current value
> > before you add/subtract task_delta.
>
> /me think Vincent is right. h_nr_running is updated in the previous
> level or out. The next level will use current h_nr_running to update
> runnable_avg and use the new group cfs_rq's h_nr_running which was
> updated in the previous level or out to update se runnable_weight.

Yes that's what I want to say

>
> update_h_nr_running (E.G. in enqueue_task_fair)
>
> throttle_cfs_rq()
>   for() {
>     update_load_avg()
>       se_runnable() --> current h_nr_running
>     update_se_runnable() --> use group cfs_rq h_nr_running
>                              updated in the prev level or out
>     update_h_nr_running
>   }
>
> Thanks,
> Tao
>
> > >>> of the hierarchy.
> > >>
> > >> You'll also need to do this for task enqueue/dequeue inside of a
> > >> throttled hierarchy, I'm pretty sure.
> > >
> > > AFAICT, this is already done with patch "sched/pelt: Add a new
> > > runnable average signal" when task is enqueued/dequeued inside a
> > > throttled hierarchy
> > >
> > >>
> > >>>
> > >>> Fixes: 9f68395333ad ("sched/pelt: Add a new runnable average signal")
> > >>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > >>> ---
> > >>> This patch applies on top of tip/sched/core
> > >>>
> > >>>  kernel/sched/fair.c | 10 ++++++++++
> > >>>  1 file changed, 10 insertions(+)
> > >>>
> > >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > >>> index fcc968669aea..6d46974e9be7 100644
> > >>> --- a/kernel/sched/fair.c
> > >>> +++ b/kernel/sched/fair.c
> > >>> @@ -4703,6 +4703,11 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
> > >>>
> > >>>               if (dequeue)
> > >>>                       dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
> > >>> +             else {
> > >>> +                     update_load_avg(qcfs_rq, se, 0);
> > >>> +                     se_update_runnable(se);
> > >>> +             }
> > >>> +
> > >>>               qcfs_rq->h_nr_running -= task_delta;
> > >>>               qcfs_rq->idle_h_nr_running -= idle_task_delta;
> > >>>
> > >>> @@ -4772,6 +4777,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> > >>>               cfs_rq = cfs_rq_of(se);
> > >>>               if (enqueue)
> > >>>                       enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> > >>> +             else {
> > >>> +                     update_load_avg(cfs_rq, se, 0);
> > >>
> > >>
> > >>> +                     se_update_runnable(se);
> > >>> +             }
> > >>> +
> > >>>               cfs_rq->h_nr_running += task_delta;
> > >>>               cfs_rq->idle_h_nr_running += idle_task_delta;
