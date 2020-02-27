Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0561CC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C146D2469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LOGSoHuD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgB0Pe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:34:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58665 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727592AbgB0Pe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:34:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582817695;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ph6zNvRlMjBgEifT68quDtBVSaXm9rcB1KivMTIcqD0=;
        b=LOGSoHuDUjG9nlx8wQgtGFh9ZhZE/sWaGYeYT8IktyIS1oLoq/FtiNS/4s1p/x0Jxn/PgA
        +9fe2ujQ2Cyp3tL4a+Gd8mm5HnrA/QeIyJszobOXYslugWkNpI99x5q7X7jg+Ubxf8Inhs
        GZbXKgN2JCd+wgRrb8+OiMQZIQGdPg0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-gczZdh52PeySscz9vobOOw-1; Thu, 27 Feb 2020 10:34:52 -0500
X-MC-Unique: gczZdh52PeySscz9vobOOw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2171E1005514;
        Thu, 27 Feb 2020 15:34:51 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 622C787B08;
        Thu, 27 Feb 2020 15:34:46 +0000 (UTC)
Date:   Thu, 27 Feb 2020 10:34:44 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
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
Subject: Re: [PATCH] sched/fair: fix runnable_avg for throttled cfs
Message-ID: <20200227153444.GB30178@pauld.bos.csb>
References: <20200226181640.21664-1-vincent.guittot@linaro.org>
 <xm26r1yhtbjr.fsf@bsegall-linux.svl.corp.google.com>
 <CAKfTPtBm9Gt16gqQgxoErOOmpbUHit6bNf4CVLvDzf04SjWtEg@mail.gmail.com>
 <8f72ea72-f36d-2611-e026-62ddff5c3422@arm.com>
 <CAKfTPtC9bkMQJsWw6Z2QD0RrV=qN7yMFviVnSeTpDp=-vLBL0g@mail.gmail.com>
 <CAKfTPtD4iVQmxWgNDDVhKPbu+rYEf=_1xKoPVOy343qo51pD_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtD4iVQmxWgNDDVhKPbu+rYEf=_1xKoPVOy343qo51pD_A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 03:58:02PM +0100 Vincent Guittot wrote:
> On Thu, 27 Feb 2020 at 14:10, Vincent Guittot
> <vincent.guittot@linaro.org> wrote:
> >
> > On Thu, 27 Feb 2020 at 12:20, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> > >
> > > On 26.02.20 21:01, Vincent Guittot wrote:
> > > > On Wed, 26 Feb 2020 at 20:04, <bsegall@google.com> wrote:
> > > >>
> > > >> Vincent Guittot <vincent.guittot@linaro.org> writes:
> > > >>
> > > >>> When a cfs_rq is throttled, its group entity is dequeued and its running
> > > >>> tasks are removed. We must update runnable_avg with current h_nr_running
> > > >>> and update group_se->runnable_weight with new h_nr_running at each level
> > >
> > >                                               ^^^
> > >
> > > Shouldn't this be 'current' rather 'new' h_nr_running for
> > > group_se->runnable_weight? IMHO, you want to cache the current value
> > > before you add/subtract task_delta.
> >
> > hmm... it can't be current in both places. In my explanation,
> > "current" means the current situation when we started to throttle cfs
> > and "new" means the new situation after we finished to throttle the
> > cfs. I should probably use old and new to prevent any
> > misunderstanding.
> 
> I'm about to send a new version to fix some minor changes: The if
> statement should have some  { }   as there are some on the else part
> 
> Would it be better for you if i use old and new instead of current and
> new in the commit message ?
> 

Seems better to me. You could also consider "the old" and "the new".

Cheers,
Phil

> >
> > That being said, we need to update runnable_avg with the old
> > h_nr_running: the one before we started to throttle the cfs which is
> > the value saved in group_se->runnable_weight. Once we have updated
> > runnable_avg, we save the new h_nr_running in
> > group_se->runnable_weight that will be used for next updates.
> >
> > >
> > > >>> of the hierarchy.
> > > >>
> > > >> You'll also need to do this for task enqueue/dequeue inside of a
> > > >> throttled hierarchy, I'm pretty sure.
> > > >
> > > > AFAICT, this is already done with patch "sched/pelt: Add a new
> > > > runnable average signal" when task is enqueued/dequeued inside a
> > > > throttled hierarchy
> > > >
> > > >>
> > > >>>
> > > >>> Fixes: 9f68395333ad ("sched/pelt: Add a new runnable average signal")
> > > >>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > >>> ---
> > > >>> This patch applies on top of tip/sched/core
> > > >>>
> > > >>>  kernel/sched/fair.c | 10 ++++++++++
> > > >>>  1 file changed, 10 insertions(+)
> > > >>>
> > > >>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > >>> index fcc968669aea..6d46974e9be7 100644
> > > >>> --- a/kernel/sched/fair.c
> > > >>> +++ b/kernel/sched/fair.c
> > > >>> @@ -4703,6 +4703,11 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
> > > >>>
> > > >>>               if (dequeue)
> > > >>>                       dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
> > > >>> +             else {
> > > >>> +                     update_load_avg(qcfs_rq, se, 0);
> > > >>> +                     se_update_runnable(se);
> > > >>> +             }
> > > >>> +
> > > >>>               qcfs_rq->h_nr_running -= task_delta;
> > > >>>               qcfs_rq->idle_h_nr_running -= idle_task_delta;
> > > >>>
> > > >>> @@ -4772,6 +4777,11 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
> > > >>>               cfs_rq = cfs_rq_of(se);
> > > >>>               if (enqueue)
> > > >>>                       enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
> > > >>> +             else {
> > > >>> +                     update_load_avg(cfs_rq, se, 0);
> > > >>
> > > >>
> > > >>> +                     se_update_runnable(se);
> > > >>> +             }
> > > >>> +
> > > >>>               cfs_rq->h_nr_running += task_delta;
> > > >>>               cfs_rq->idle_h_nr_running += idle_task_delta;
> 

-- 

