Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD22C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359FC246A2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:39:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JgOOQNHN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729391AbgB0Pjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:39:43 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34420 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbgB0Pjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:39:42 -0500
Received: by mail-lj1-f193.google.com with SMTP id x7so3982130ljc.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 07:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9syb0EuTMFRZmvzXG0o95S31OaTn3/XSsmj6a7wCaI=;
        b=JgOOQNHN8EQzsavUAuP7X5E+4Iof3SDJzl4QtKXNt4UX5j/cFJi9or+XRIfwp+El/7
         AMiKvrvZinHP6vm38Npqly13hR5jpKT3eNaJpu/wA+cr0MnQZWC0CcsA2uAVDEWzoUnt
         EQqiDI8eOanC41fV2silCVJFX9LGrR9z5njhA9VgUx69HpU51lHVuSrskR80b2wmMYGz
         xH0CPx+tGTCFgxLexiIGie7TK7wq8tEPZA99cQdjH7L2VPdKVxdMD0SzZgnkECvd60nA
         or1Kp6UyWu/ljXBPJmxRh/CL02ICVRsdYg83BGm9V9f6YbHw2kAFrEu5HEJGO41MLRCz
         e+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9syb0EuTMFRZmvzXG0o95S31OaTn3/XSsmj6a7wCaI=;
        b=RdAHDhpmef5BR3vj+cm/bsyviotB3UZCJ4tvUpZmjnVDZJ7VxvC/QxU8kBtNlmUiN4
         oIhFcv3lSBNHAqNiwTA9qE3+LoTj7mPb/bqXOdSRxmqFdVJrPQjVnAt4fg9q29lj18at
         TX1skVwVaFlN0VmcHuT/fEcf2oc5p+VRvx2pamDPIkdjeDc4Z4fNDp6dmB+FJOrbDM0i
         tcUbz50oubvd1bpv1PHasThaqRqn6VU1lP4509SPX3H3Se4oMnrhmH2nMQPqy1CePrCo
         F/Dyp3eDHykYDvoJvhtdoUo61AEmhlOVMJ0dD9fsQ/tN75LqWjVUC7w0ykGYcy1wJMLp
         NHkg==
X-Gm-Message-State: ANhLgQ0bh3e+tjlR/p+n839ln8eG6byiKJFwSawALsYtj8+DW/nyDL7J
        TTR3hMADqWq6MRtQDwNCCt9cUeB8hDXq65MCmkXm5w==
X-Google-Smtp-Source: ADFU+vsz2mQjzE7sSPUm/jwZpZ7OXDbwKCPmd20sTGCJ+ZqGd1Teg1Ga4/KvmipJeh0ptHJ+/6UW+4XcRvTl/jinZMY=
X-Received: by 2002:a2e:96c6:: with SMTP id d6mr82283ljj.4.1582817979525; Thu,
 27 Feb 2020 07:39:39 -0800 (PST)
MIME-Version: 1.0
References: <20200226181640.21664-1-vincent.guittot@linaro.org>
 <xm26r1yhtbjr.fsf@bsegall-linux.svl.corp.google.com> <CAKfTPtBm9Gt16gqQgxoErOOmpbUHit6bNf4CVLvDzf04SjWtEg@mail.gmail.com>
 <8f72ea72-f36d-2611-e026-62ddff5c3422@arm.com> <CAKfTPtC9bkMQJsWw6Z2QD0RrV=qN7yMFviVnSeTpDp=-vLBL0g@mail.gmail.com>
 <CAKfTPtD4iVQmxWgNDDVhKPbu+rYEf=_1xKoPVOy343qo51pD_A@mail.gmail.com> <20200227153444.GB30178@pauld.bos.csb>
In-Reply-To: <20200227153444.GB30178@pauld.bos.csb>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 27 Feb 2020 16:39:28 +0100
Message-ID: <CAKfTPtDkJ-pfbWCDoj333c3egQjDhDAYUR5LwvweNmyJPh=4cg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: fix runnable_avg for throttled cfs
To:     Phil Auld <pauld@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Hillf Danton <hdanton@sina.com>, zhout@vivaldi.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 at 16:34, Phil Auld <pauld@redhat.com> wrote:
>
> On Thu, Feb 27, 2020 at 03:58:02PM +0100 Vincent Guittot wrote:
> > On Thu, 27 Feb 2020 at 14:10, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> > >
> > > On Thu, 27 Feb 2020 at 12:20, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > > >
> > > > On 26.02.20 21:01, Vincent Guittot wrote:
> > > > > On Wed, 26 Feb 2020 at 20:04, <bsegall@google.com> wrote:
> > > > >>
> > > > >> Vincent Guittot <vincent.guittot@linaro.org> writes:
> > > > >>
> > > > >>> When a cfs_rq is throttled, its group entity is dequeued and its running
> > > > >>> tasks are removed. We must update runnable_avg with current h_nr_running
> > > > >>> and update group_se->runnable_weight with new h_nr_running at each level
> > > >
> > > >                                               ^^^
> > > >
> > > > Shouldn't this be 'current' rather 'new' h_nr_running for
> > > > group_se->runnable_weight? IMHO, you want to cache the current value
> > > > before you add/subtract task_delta.
> > >
> > > hmm... it can't be current in both places. In my explanation,
> > > "current" means the current situation when we started to throttle cfs
> > > and "new" means the new situation after we finished to throttle the
> > > cfs. I should probably use old and new to prevent any
> > > misunderstanding.
> >
> > I'm about to send a new version to fix some minor changes: The if
> > statement should have some  { }   as there are some on the else part
> >
> > Would it be better for you if i use old and new instead of current and
> > new in the commit message ?
> >
>
> Seems better to me. You could also consider "the old" and "the new".

ok, will do
>
> Cheers,
> Phil
>
> > >
> > > That being said, we need to update runnable_avg with the old
> > > h_nr_running: the one before we started to throttle the cfs which is
> > > the value saved in group_se->runnable_weight. Once we have updated
> > > runnable_avg, we save the new h_nr_running in
> > > group_se->runnable_weight that will be used for next updates.
> > >
> > > >
> > > > >>> of the hierarchy.
> > > > >>
> > > > >> You'll also need to do this for task enqueue/dequeue inside of a
> > > > >> throttled hierarchy, I'm pretty sure.
> > > > >
> > > > > AFAICT, this is already done with patch "sched/pelt: Add a new
> > > > > runnable average signal" when task is enqueued/dequeued inside a
> > > > > throttled hierarchy
> > > > >
> > > > >>
> > > > >>>
> > > > >>> Fixes: 9f68395333ad ("sched/pelt: Add a new runnable average signal")
> > > > >>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > > >>> ---
> > > > >>> This patch applies on top of tip/sched/core
> > > > >>>
> > > > >>>  kernel/sched/fair.c | 10 ++++++++++
> > > > >>>  1 file changed, 10 insertions(+)
> > > > >>>
> > > > >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > > >>> index fcc968669aea..6d46974e9be7 100644
> > > > >>> --- a/kernel/sched/fair.c
> > > > >>> +++ b/kernel/sched/fair.c
> > > > >>> @@ -4703,6 +4703,11 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
> > > > >>>
> > > > >>>               if (dequeue)
> > > > >>>                       dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
> > > > >>> +             else {
> > > > >>> +                     update_load_avg(qcfs_rq, se, 0);
> > > > >>> +                     se_update_runnable(se);
> > > > >>> +             }
> > > > >>> +
> > > > >>>               qcfs_rq->h_nr_running -= task_delta;
> > > > >>>               qcfs_rq->idle_h_nr_running -= idle_task_delta;
> > > > >>>
> > > > >>> @@ -4772,6 +4777,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> > > > >>>               cfs_rq = cfs_rq_of(se);
> > > > >>>               if (enqueue)
> > > > >>>                       enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> > > > >>> +             else {
> > > > >>> +                     update_load_avg(cfs_rq, se, 0);
> > > > >>
> > > > >>
> > > > >>> +                     se_update_runnable(se);
> > > > >>> +             }
> > > > >>> +
> > > > >>>               cfs_rq->h_nr_running += task_delta;
> > > > >>>               cfs_rq->idle_h_nr_running += idle_task_delta;
> >
>
> --
>
