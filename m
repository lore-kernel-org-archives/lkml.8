Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FE4C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:41:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E584B20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 17:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgBXRlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 12:41:46 -0500
Received: from foss.arm.com ([217.140.110.172]:40750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728090AbgBXRln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 12:41:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBC701FB;
        Mon, 24 Feb 2020 09:41:42 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C8693F703;
        Mon, 24 Feb 2020 09:41:41 -0800 (PST)
Date:   Mon, 24 Feb 2020 17:41:39 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] sched/rt: Better manage pushing unfit tasks on
 wakeup
Message-ID: <20200224174138.n6pmoeffqg7eqiy2@e107158-lin.cambridge.arm.com>
References: <20200223184001.14248-1-qais.yousef@arm.com>
 <20200223184001.14248-6-qais.yousef@arm.com>
 <20200224061004.GH28029@codeaurora.org>
 <20200224121139.cbz2dt5heiouknif@e107158-lin.cambridge.arm.com>
 <CAEU1=PncyV=-vqjkDHSJ4hUhhTfYUgVN-HAe4zXMHtFx1oc5XA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAEU1=PncyV=-vqjkDHSJ4hUhhTfYUgVN-HAe4zXMHtFx1oc5XA@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/24/20 21:34, Pavan Kondeti wrote:
> Hi Qais,
> 
> On Mon, Feb 24, 2020 at 5:42 PM Qais Yousef <qais.yousef@arm.com> wrote:
> [...]
> > We could do, temporarily, to get these fixes into 5.6. But I do think
> > select_task_rq_rt() doesn't do a good enough job into pushing unfit tasks to
> > the right CPUs.
> >
> > I don't understand the reasons behind your objection. It seems you think that
> > select_task_rq_rt() should be enough, but not AFAICS. Can you be a bit more
> > detailed please?
> >
> > FWIW, here's a screenshot of what I see
> >
> >         https://imgur.com/a/peV27nE
> >
> > After the first activation, select_task_rq_rt() fails to find the right CPU
> > (due to the same move all tasks to the cpumask_fist()) - but when the task
> > wakes up on 4, the logic I put causes it to migrate to CPU2, which is the 2nd
> > big core. CPU1 and CPU2 are the big cores on Juno.
> >
> > Now maybe we should fix select_task_rq_rt() to better balance tasks, but not
> > sure how easy is that.
> >
> 
> Thanks for the trace. Now things are clear to me. Two RT tasks woke up
> simultaneously and the first task got its previous CPU i.e CPU#1. The next task
> goes through find_lowest_rq() and got the same CPU#1. Since this task priority
> is not more than the just queued task (already queued on CPU#1), it is sent
> to its previous CPU i.e CPU#4 in your case.
> 
> From task_woken_rt() path, CPU#4 attempts push_rt_tasks(). CPU#4 is
> not overloaded,
> but we have rt_task_fits_capacity() check which forces the push. Since the CPU
> is not overloaded, your has_unfit_tasks() comes to rescue and push the
> task. Since
> the task has not scheduled in yet, it is eligible for push. You added checks
> to skip resched_curr() in push_rt_tasks() otherwise the push won't happen.

Nice summary, that's exactly what it is :)

> Finally, I understood your patch. Obviously this is not clear to me
> before. I am not
> sure if this patch is the right approach to solve this race. I will
> think a bit more.

I haven't been staring at this code for as long as you, but since we have
logic at wakeup to do a push, I think we need something here anyway for unfit
tasks.

Fixing select_task_rq_rt() to better balance tasks will help a lot in general,
but if that was enough already then why do we need to consider a push at the
wakeup at all then?

AFAIU, in SMP the whole push-pull mechanism is racy and we introduce redundancy
at taking the decision on various points to ensure we minimize this racy nature
of SMP systems. Anything could have happened between the time we called
select_task_rq_rt() and the wakeup, so we double check again before we finally
go and run. That's how I interpret it.

I am open to hear about other alternatives first anyway. Your help has been
much appreciated so far.

Thanks

--
Qais Yousef
