Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90FA0C4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 10:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 730A324692
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 10:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgB0KaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 05:30:03 -0500
Received: from foss.arm.com ([217.140.110.172]:48144 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728652AbgB0KaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 05:30:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B07C1FB;
        Thu, 27 Feb 2020 02:30:02 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E52E03F881;
        Thu, 27 Feb 2020 02:30:00 -0800 (PST)
Date:   Thu, 27 Feb 2020 10:29:58 +0000
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
Message-ID: <20200227102957.c5dmaq45hmcaicvu@e107158-lin.cambridge.arm.com>
References: <20200223184001.14248-1-qais.yousef@arm.com>
 <20200223184001.14248-6-qais.yousef@arm.com>
 <20200224061004.GH28029@codeaurora.org>
 <20200224121139.cbz2dt5heiouknif@e107158-lin.cambridge.arm.com>
 <CAEU1=PncyV=-vqjkDHSJ4hUhhTfYUgVN-HAe4zXMHtFx1oc5XA@mail.gmail.com>
 <20200224174138.n6pmoeffqg7eqiy2@e107158-lin.cambridge.arm.com>
 <20200225035505.GI28029@codeaurora.org>
 <20200226160247.iqvdakiqbakk2llz@e107158-lin.cambridge.arm.com>
 <20200227033608.GN28029@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200227033608.GN28029@codeaurora.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/20 09:06, Pavan Kondeti wrote:
> On Wed, Feb 26, 2020 at 04:02:48PM +0000, Qais Yousef wrote:
> > On 02/25/20 09:25, Pavan Kondeti wrote:
> > > > I haven't been staring at this code for as long as you, but since we have
> > > > logic at wakeup to do a push, I think we need something here anyway for unfit
> > > > tasks.
> > > > 
> > > > Fixing select_task_rq_rt() to better balance tasks will help a lot in general,
> > > > but if that was enough already then why do we need to consider a push at the
> > > > wakeup at all then?
> > > > 
> > > > AFAIU, in SMP the whole push-pull mechanism is racy and we introduce redundancy
> > > > at taking the decision on various points to ensure we minimize this racy nature
> > > > of SMP systems. Anything could have happened between the time we called
> > > > select_task_rq_rt() and the wakeup, so we double check again before we finally
> > > > go and run. That's how I interpret it.
> > > > 
> > > > I am open to hear about other alternatives first anyway. Your help has been
> > > > much appreciated so far.
> > > > 
> > > 
> > > The search inside find_lowest_rq() happens without any locks so I believe it
> > > is expected to have races like this. In fact there is a comment in the code
> > > saying "This test is optimistic, if we get it wrong the load-balancer
> > > will have to sort it out" in select_task_rq_rt(). However, the push logic
> > > as of today works only for overloaded case. In that sense, your patch fixes
> > > this race for b.L systems. At the same time, I feel like tracking nonfit tasks
> > > just to fix this race seems to be too much. I will leave this to Steve and
> > > others to take a decision.
> > 
> > I do think without this tasks can end up on the wrong CPU longer than they
> > should. Keep in mind that if a task is boosted to run on a big core, it still
> > have to compete with non-boosted tasks who can run on a any cpu. So this
> > opportunistic push might be necessary.
> > 
> > For 5.6 though, I'll send an updated series that removes the fitness check from
> > task_woken_rt() && switched_to_rt() and carry on with this discussion for 5.7.
> > 
> > > 
> > > I thought of suggesting to remove the below check from select_task_rq_rt()
> > > 
> > > p->prio < cpu_rq(target)->rt.highest_prio.curr
> > > 
> > > which would then make the target CPU overloaded and the push logic would
> > > spread the tasks. That works for a b.L system too. However there seems to
> > > be a very good reason for doing this. see
> > > https://lore.kernel.org/patchwork/patch/539137/
> > > 
> > > The fact that a CPU is part of lowest_mask but running a higher prio RT
> > > task means there is a race. Should we retry one more time to see if we find
> > > another CPU?
> > 
> > Isn't this what I did in v1?
> > 
> > https://lore.kernel.org/lkml/20200214163949.27850-4-qais.yousef@arm.com/
> > 
> 
> Yes, that patch allows overloading the CPU When the priorities are same.

So I assume you're okay with this patch now?

> I think, We should also consider when a low prio task and high prio task
> are waking at the same time and high prio task winning the race.

You mean the bug I describe here?

https://lore.kernel.org/lkml/20200219140243.wfljmupcrwm2jelo@e107158-lin/

That needs more serious thinking.

Thanks

--
Qais Yousef
