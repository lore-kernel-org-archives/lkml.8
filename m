Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C4DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EF5120BED
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QA40R1vz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgIARa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIARaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:30:55 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0978BC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 10:30:55 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 60so1519090qtc.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Dv3VdlkLKfSzN/kpT7a37/cDiEE7QKzbn4dVlTcp+8E=;
        b=QA40R1vzfssiArrSOjzgXirThCZeDBEprFlZcdiHbR5lBfh7efubugybosUZ5DCAxv
         N6kKKp2/U6wQWk1vYx2h3Etc+uzTKRn0InsDl+vAQK8ai/njhpURcXTI831nkjxwyxX0
         qOnnlhU5hthTKIRUE0j8m0v5OscwgsZstK1cE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Dv3VdlkLKfSzN/kpT7a37/cDiEE7QKzbn4dVlTcp+8E=;
        b=kfLwnTg2lvKisa5EIs0EbK2XMG3EYr9SErDu5nmrpcG8Wf4Z3Qc8PRYWrZZmtj/z+O
         uuWqYk5g4SEsOpWOjTUUurj0UPSjTAeaWaQTW7BRYhHXUKTf2K5Tb6NuBGSPpbxUsRLv
         gapmIiGiz/1INCVGVM3tbPLWf0sLnitd4gU9kOxjVsiEamomRC/O3j+hIk8iXXu2ePkq
         A4nCz8kwGGmr7HIdfLxt3sKEJqaLEse4xs2uJnay5Tf2uwlnXuschT8S4Eha81AE4vmI
         i53Wb1VN66+RvbwTjrG0jMax/gf6bwV4dCppb4eAdhgO0Drn0djTj502t1ZrljJu2VEV
         gG5w==
X-Gm-Message-State: AOAM533OT8sMZ4nOZ6FSrDAsdcuOOez6e8VyUat0ajJoX34fljVIEEJT
        2oDGCziQ9m4BJ0GTFU6G2iHO1IZWEj4BTA==
X-Google-Smtp-Source: ABdhPJwgbP34OXWYQ6N1WOoOKLxJN0GBQCM4C7A60o92pxYcFtyzbdXcMZXlecfTB35mSD7s6zik+g==
X-Received: by 2002:aed:2d62:: with SMTP id h89mr2928823qtd.193.1598981454071;
        Tue, 01 Sep 2020 10:30:54 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id y73sm2420586qkb.23.2020.09.01.10.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 10:30:53 -0700 (PDT)
Date:   Tue, 1 Sep 2020 13:30:52 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     peterz@infradead.org,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Subject: Re: [RFC PATCH v7 08/23] sched: Add core wide task selection and
 scheduling.
Message-ID: <20200901173052.GA1703315@google.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
 <20200828205154.GB29142@worktop.programming.kicks-ass.net>
 <381e6ea5-a48c-9882-4c0d-49cfa92d21cc@linux.microsoft.com>
 <20200829074719.GJ1362448@hirez.programming.kicks-ass.net>
 <20200901051014.GA3993517@google.com>
 <a41dac6f-6864-c215-0f7a-90f2126673a6@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a41dac6f-6864-c215-0f7a-90f2126673a6@linux.microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vineeth,

On Tue, Sep 01, 2020 at 08:34:23AM -0400, Vineeth Pillai wrote:
> Hi Joel,
> 
> On 9/1/20 1:10 AM, Joel Fernandes wrote:
> > 3. The 'Rescheduling siblings' loop of pick_next_task() is quite fragile. It
> > calls various functions on rq->core_pick which could very well be NULL because:
> > An online sibling might have gone offline before a task could be picked for it,
> > or it might be offline but later happen to come online, but its too late and
> > nothing was picked for it. Just ignore the siblings for which nothing could be
> > picked. This avoids any crashes that may occur in this loop that assume
> > rq->core_pick is not NULL.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> I like this idea, its much simpler :-)

Thanks.

> > ---
> >   kernel/sched/core.c | 24 +++++++++++++++++++++---
> >   1 file changed, 21 insertions(+), 3 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 717122a3dca1..4966e9f14f39 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4610,13 +4610,24 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >   	if (!sched_core_enabled(rq))
> >   		return __pick_next_task(rq, prev, rf);
> > +	cpu = cpu_of(rq);
> > +
> > +	/* Stopper task is switching into idle, no need core-wide selection. */
>
> I think we can come here when hotplug thread is scheduled during online, but
> mask is not yet updated. Probably can add it with this comment as well.
> 

I don't see how that is possible. Because the cpuhp threads run during the
CPU onlining process, the boot thread for the CPU coming online would have
already updated the mask.

> > +	if (cpu_is_offline(cpu))
> > +		return __pick_next_task(rq, prev, rf);
> > +
> We would need reset core_pick here I think. Something like
>     if (cpu_is_offline(cpu)) {
>         rq->core_pick = NULL;
>         return __pick_next_task(rq, prev, rf);
>     }
> 
> Without this we can end up in a crash like this:
> 1. Sibling of this cpu picks a task (rq_i->core_pick) and this cpu goes
>     offline soon after.
> 2. Before this cpu comes online, sibling goes through another pick loop
>     and before its IPI loop, this cpu comes online and we get an IPI.
> 3. So when this cpu gets into schedule, we have core_pick set and
>     core_pick_seq != core_sched_seq. So we enter the fast path. But
>     core_pick might no longer in this runqueue.
> 
> So, to protect this, we should reset core_pick I think. I have seen this
> crash
> occasionally.

Ok, done.

> >   	/*
> >   	 * If there were no {en,de}queues since we picked (IOW, the task
> >   	 * pointers are all still valid), and we haven't scheduled the last
> >   	 * pick yet, do so now.
> > +	 *
> > +	 * rq->core_pick can be NULL if no selection was made for a CPU because
> > +	 * it was either offline or went offline during a sibling's core-wide
> > +	 * selection. In this case, do a core-wide selection.
> >   	 */
> >   	if (rq->core->core_pick_seq == rq->core->core_task_seq &&
> > -	    rq->core->core_pick_seq != rq->core_sched_seq) {
> > +	    rq->core->core_pick_seq != rq->core_sched_seq &&
> > +	    !rq->core_pick) {
> Should this check be reversed? I mean, we should enter the fastpath if
> we have rq->core_pick is set right?

Done. Sorry my testing did not catch it, but it eventually caused a problem
after several hours of the stress test so I'd have eventually caught it.

> Another unrelated, but related note :-)
> Besides this, I think we need to retain on more change from the previous
> patch. We would need to make core_pick_seq per sibling instead of per
> core. Having it per core might lead to unfairness. For eg: When a cpu
> sees that its sibling's core_pick is the one which is already running, it
> will not send IPI. but core_pick remains set and core->core_pick_seq is
> incremented. Now if the sibling is preempted due to a high priority task

Then don't keep the core_pick set then. If you don't send it IPI and if
core_pick is already running, then NULL it already. I don't know why we add
to more corner cases by making assumptions. We have enough open issues that
are not hotplug related. Here's my suggestion :

1.  Keep the ideas consistent, forget about the exact code currently written
and just understand the pick_seq is for siblings knowing that something was
picked for the whole core.  So if their pick_seq != sched_seq, then they have
to pick what was selected.

2. If core_pick should be NULL, then NULL it in some path. If you keep some
core_pick and you increment pick_seq, then you are automatically asking the
sibling to pick that task up then next time it enters schedule(). See if [1]
will work?

Note that, we have added logic in this patch that does a full selection if
rq->core_pick == NULL.

> or its time slice expired, it enters schedule. But it goes to fast path and
> selects the running task there by starving the high priority task. Having
> the core_pick_seq per sibling will avoid this. It might also help in some
> hotplug corner cases as well.

That can be a separate patch IMHO. It has nothing to do with
stability/crashing of concurrent and rather infrequent CPU hotplug
operations.

Also, Peter said pick_seq is for core-wide picking. If you want to add
another semantic, then maybe add another counter which has a separate
meaning and justify why you are adding it.

thanks,

 - Joel

[1]
---8<-----------------------

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7728ca7f6bb2..7a03b609e3b7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4793,6 +4793,8 @@ next_class:;
 
 		if (rq_i->curr != rq_i->core_pick)
 			resched_curr(rq_i);
+		else
+			rq_i->core_pick = NULL;
 
 		/* Did we break L1TF mitigation requirements? */
 		WARN_ON_ONCE(!cookie_match(next, rq_i->core_pick));
