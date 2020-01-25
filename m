Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4FCC35242
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 23:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EAF72064A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 23:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAYX7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 18:59:42 -0500
Received: from foss.arm.com ([217.140.110.172]:33596 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbgAYX7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 18:59:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4EDEF328;
        Sat, 25 Jan 2020 15:59:41 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8475B3F68E;
        Sat, 25 Jan 2020 15:59:39 -0800 (PST)
Date:   Sat, 25 Jan 2020 23:59:37 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Wei Wang <wvw@google.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <qperret@google.com>,
        Wei Wang <wei.vince.wang@gmail.com>, dietmar.eggemann@arm.com,
        chris.redpath@arm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] sched: restrict iowait boost for boosted task only
Message-ID: <20200125235934.wrs2nryuk3wmtkxr@e107158-lin>
References: <20200124002811.228334-1-wvw@google.com>
 <20200124025238.jsf36n6w4rrn2ehc@e107158-lin>
 <20200124095125.GA121494@google.com>
 <849cc9f0-f4ae-f2b6-8449-f55697928cf5@arm.com>
 <20200124113050.i6ovkibcmutypm3q@e107158-lin>
 <CAGXk5yrTc2-k5oDjGyAwYn2KTroQy0JtEYQzSeOizjg_hyMGkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGXk5yrTc2-k5oDjGyAwYn2KTroQy0JtEYQzSeOizjg_hyMGkg@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/24/20 12:55, Wei Wang wrote:
> > > So I'm pretty sure we *do* want tasks with the default clamps to get iowait
> > > boost'd. What we don't want are background tasks driving up the frequency,
> > > and that should be via uclamp.max (as Quentin is suggesting) rather than
> > > uclamp.min (as is suggested in the patch).
> > >
> > > Now, whether that is overloading the usage of uclamp... I'm not sure.
> > > One of the argument for uclamp was actually frequency selection, so if
> > > we just make iowait boost respect that, IOW not boost further than
> > > uclamp.max (which is a bit better than a simple on/off switch), that
> > > wouldn't be too crazy I think.
> >
> > Capping iowait boost value in schedutil based on uclamp makes sense indeed.
> >
> > What didn't make sense to me is the use of uclamp as a switch to toggle iowait
> > boost on/off.
> 
> Sounds like we all agree on adding a new toggle, so will move forward
> with that then.

Looking more closely at iowait boost, it's not actually a generic cpufreq
attribute. Only schedutil and intel_pstate have it. Other governors might
implement something similar but under a different name.

So I'm not sure how easy it'd be to implement a generic toggle for something
that probably should be considered an implementation detail of a governor and
userspace shouldn't care much about.

Of course, the maintainers might have a different opinion. So don't let mine
discourage you from pursuing this further! :-)

> For capping iowait boost, it should be a seperate patch. I am not sure
> if we want to apply what's the current max clamp on the rq but I do
> see the per-task iowait boost makes sense.

It is true the 2 patches are orthogonal, but if you already cap the max
frequencies the background task can use, by ensuring the iowait_boost in
schedutil respects the uclamp restrictions then this should solve your problem
too, no?

The patch below only compile tested.


	background/cpu.uclamp.max = 200 # Cap background tasks max frequencies

---

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 9b8916fd00a2..a76c02eecdaf 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -421,7 +421,8 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
         * into the same scale so we can compare.
         */
        boost = (sg_cpu->iowait_boost * max) >> SCHED_CAPACITY_SHIFT;
-       return max(boost, util);
+       boost = max(boost, util);
+       return uclamp_util_with(cpu_rq(sg_cpu->cpu), boost, NULL);
 }

 #ifdef CONFIG_NO_HZ_COMMON

--
Qais Yousef
