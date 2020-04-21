Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A2BC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 014352071C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgDUIAQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:00:16 -0400
Received: from mga03.intel.com ([134.134.136.65]:44813 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgDUIAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:00:15 -0400
IronPort-SDR: 2qDMjm2HVaVSGZUYCfmlVkMPPn4h7xbW4cMMjxQ97kiExBJQQC5aNyTsy1jQKiJwlkCbWp3XCJ
 +LhmN0pgdhSQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 01:00:15 -0700
IronPort-SDR: X8Q0uUFFTXyIY6RJ64PYo7y0nRGE7CYiw2K+mKghqyjfJBNHzpM5yD9LQUsFn/0Y0i6nKAkVOp
 3AgDu6A/RZwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,409,1580803200"; 
   d="scan'208";a="273446547"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga002.jf.intel.com with ESMTP; 21 Apr 2020 01:00:12 -0700
Date:   Tue, 21 Apr 2020 16:00:42 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2][v2] sched: Extract the task putting code from
 pick_next_task()
Message-ID: <20200421080042.GC9721@chenyu-office.sh.intel.com>
References: <cover.1587393807.git.yu.c.chen@intel.com>
 <4f301770996c02f44d52a4868f510025d5a3a558.1587393807.git.yu.c.chen@intel.com>
 <jhjy2qqkq6a.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhjy2qqkq6a.mognet@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Mon, Apr 20, 2020 at 06:44:29PM +0100, Valentin Schneider wrote:
> 
> On 20/04/20 16:01, Chen Yu wrote:
> > Introduce a new function finish_prev_task() to do the balance
> > when necessary, and then put previous task back to the run queue.
> > This function is extracted from pick_next_task() to prepare for
> > future usage by other type of task picking logic.
> >
> > No functional change.
> >
> 
> With the absolutely tiny nit below:
> 
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> 
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
> > ---
> >  kernel/sched/core.c | 39 +++++++++++++++++++++++----------------
> >  1 file changed, 23 insertions(+), 16 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 3a61a3b8eaa9..bf59a5cf030c 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3904,6 +3904,28 @@ static inline void schedule_debug(struct task_struct *prev, bool preempt)
> >       schedstat_inc(this_rq()->sched_count);
> >  }
> >
> > +static void finish_prev_task(struct rq *rq, struct task_struct *prev,
> > +			     struct rq_flags *rf)
> > +{
> > +	const struct sched_class *class;
> > +#ifdef CONFIG_SMP
> 
> Nit: I would've put that declaration within the ifdef, given it isn't used
> outside of it.
> 
Okay, I'll do.

Thanks,
Chenyu
