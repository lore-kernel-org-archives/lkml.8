Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C76C10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DB821D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgCKOLk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:11:40 -0400
Received: from foss.arm.com ([217.140.110.172]:50224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729646AbgCKOLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:11:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C33B631B;
        Wed, 11 Mar 2020 07:11:39 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 747323F67D;
        Wed, 11 Mar 2020 07:11:38 -0700 (PDT)
Date:   Wed, 11 Mar 2020 14:11:36 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] sched/rt: Fix pushing unfit tasks to a better CPU
Message-ID: <20200311141135.kyonj52ogwns3rf3@e107158-lin.cambridge.arm.com>
References: <20200302132721.8353-1-qais.yousef@arm.com>
 <20200302132721.8353-7-qais.yousef@arm.com>
 <20200306175112.vkpeouec2c47yujl@e107158-lin.cambridge.arm.com>
 <20200311105358.GO28029@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200311105358.GO28029@codeaurora.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/20 16:23, Pavan Kondeti wrote:
> On Fri, Mar 06, 2020 at 05:51:13PM +0000, Qais Yousef wrote:
> > Hi Pavan
> > 
> > On 03/02/20 13:27, Qais Yousef wrote:
> > > If a task was running on unfit CPU we could ignore migrating if the
> > > priority level of the new fitting CPU is the *same* as the unfit one.
> > > 
> > > Add an extra check to select_task_rq_rt() to allow the push in case:
> > > 
> > > 	* p->prio == new_cpu.highest_priority
> > > 	* task_fits(p, new_cpu)
> > > 
> > > Fixes: 804d402fb6f6 ("sched/rt: Make RT capacity-aware")
> > > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > > ---
> > 
> > Can you please confirm if you have any objection to this patch? Without it
> > I see large delays in the 2 tasks test like I outlined in [1]. It wasn't clear
> > from [2] whether you are in agreement now or not.
> > 
> > [1] https://lore.kernel.org/lkml/20200217135306.cjc2225wdlwqiicu@e107158-lin.cambridge.arm.com/
> > [2] https://lore.kernel.org/lkml/20200227033608.GN28029@codeaurora.org/
> > 
> 
> I am not very sure about this. Like we discussed, this patch is addressing a
> specific scenario i.e two equal prio tasks waking at the same time. We allow
> the packing so that task_woken_rt() spread the tasks. The enqueue operation
> is waste here.
> 
> At the same time, I can't think of a better alternative. Retrying
> find_lowest_rq() may still give the same result until the previous task
> is fully woken on the CPU.
> 
> btw, the commit description does not talk about the race at all. If there is
> no race, we won't even end up in this scenario i.e find_lowest_rq() may simply
> return -1.

Josh has a new API that can help fix both the thundering herd issue and this
one too.

https://lore.kernel.org/lkml/20200311010113.136465-1-joshdon@google.com/

I did try to have a stab at it but my implementation wasn't as good as Josh.

I think if we get this function in and make find_lowest_rq() use it then we
should be okay when multiple tasks wakeup simultaneously. It's not bullet
proof, but good enough, me thinks.

Thoughts?

Thanks

--
Qais Yousef
