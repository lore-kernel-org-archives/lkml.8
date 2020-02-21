Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A9AC35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F6F124656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 11:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbgBULM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 06:12:28 -0500
Received: from foss.arm.com ([217.140.110.172]:36834 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgBULM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 06:12:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FE7A31B;
        Fri, 21 Feb 2020 03:12:27 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DB9A3F68F;
        Fri, 21 Feb 2020 03:12:26 -0800 (PST)
Date:   Fri, 21 Feb 2020 11:12:23 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched/rt: fix pushing unfit tasks to a better CPU
Message-ID: <20200221111223.bb4y57zdox7qdy2w@e107158-lin.cambridge.arm.com>
References: <20200214163949.27850-1-qais.yousef@arm.com>
 <20200214163949.27850-4-qais.yousef@arm.com>
 <20200217092329.GC28029@codeaurora.org>
 <20200217135306.cjc2225wdlwqiicu@e107158-lin.cambridge.arm.com>
 <20200219140243.wfljmupcrwm2jelo@e107158-lin>
 <20200221081551.GG28029@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200221081551.GG28029@codeaurora.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/20 13:45, Pavan Kondeti wrote:
> On Wed, Feb 19, 2020 at 02:02:44PM +0000, Qais Yousef wrote:
> > On 02/17/20 13:53, Qais Yousef wrote:
> > > On 02/17/20 14:53, Pavan Kondeti wrote:
> > > > I notice a case where tasks would migrate for no reason (happens without this
> > > > patch also). Assuming BIG cores are busy with other RT tasks. Now this RT
> > > > task can go to *any* little CPU. There is no bias towards its previous CPU.
> > > > I don't know if it makes any difference but I see RT task placement is too
> > > > keen on reducing the migrations unless it is absolutely needed.
> > > 
> > > In find_lowest_rq() there's a check if the task_cpu(p) is in the lowest_mask
> > > and prefer it if it is.
> > > 
> > > But yeah I see it happening too
> > > 
> > > https://imgur.com/a/FYqLIko
> > > 
> > > Tasks on CPU 0 and 3 swap. Note that my tasks are periodic but the plots don't
> > > show that.
> > > 
> > > I shouldn't have changed something to affect this bias. Do you think it's
> > > something I introduced?
> > > 
> > > It's something maybe worth digging into though. I'll try to have a look.
> > 
> > FWIW, I dug a bit into this and I found out we have a thundering herd issue.
> > 
> > Since I just have a set of periodic task that all start together,
> > select_task_rq_rt() ends up selecting the same fitting CPU for all of them
> > (CPU1). The end up all waking up on CPU1, only to get pushed back out
> > again with only one surviving.
> > 
> > This reshuffles the task placement ending with some tasks being swapped.
> > 
> > I don't think this problem is specific to my change and could happen without
> > it.
> > 
> > The problem is caused by the way find_lowest_rq() selects a cpu in the mask
> > 
> > 1750                         best_cpu = cpumask_first_and(lowest_mask,
> > 1751                                                      sched_domain_span(sd));
> > 1752                         if (best_cpu < nr_cpu_ids) {
> > 1753                                 rcu_read_unlock();
> > 1754                                 return best_cpu;
> > 1755                         }
> > 
> > It always returns the first CPU in the mask. Or the mask could only contain
> > a single CPU too. The end result is that we most likely end up herding all the
> > tasks that wake up simultaneously to the same CPU.
> > 
> > I'm not sure how to fix this problem yet.
> > 
> 
> Yes, I have seen this problem too. This is not limited to RT even fair class
> (find_energy_efficient_cpu path) also have the same issue. There is a window
> where we select a CPU for the task and the task being queued there. Because of
> this, we may select the same CPU for two successive waking tasks. Turning off
> TTWU_QUEUE sched feature addresses this up to some extent. At least it would
> solve the cases like multiple tasks getting woken up from an interrupt handler.

Oh, handy. Let me try this out.

I added it to my to-do to investigate it when I have time anyway.

In modern systems where L3 is spanning all CPUs, the migration isn't that
costly, but it'd still be unnecessary wakeup latency that can add up.

Thanks

--
Qais Yousef
