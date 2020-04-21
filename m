Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3344AC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05970206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 08:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgDUI2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 04:28:17 -0400
Received: from mga02.intel.com ([134.134.136.20]:46899 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUI2P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 04:28:15 -0400
IronPort-SDR: Gu50vmakIoIE4FDTjt+k31+AFj9dM+IahIFe0n2Zm/Vxta6SBx2IM9JSgl7cfQuqWR+WOqvNuE
 S5zMe6ojU44Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 01:28:04 -0700
IronPort-SDR: tYpd9XYj0rIS1xtRZpb6mUnsjXJcZoLdqcfdWMVuWRC181uxqpzHgPi/YbH884TIR9QNfQ54zt
 046xbfesXN7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,409,1580803200"; 
   d="scan'208";a="300540575"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Apr 2020 01:28:02 -0700
Date:   Tue, 21 Apr 2020 16:28:32 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH 2/2] sched: Extract the task putting code from
 pick_next_task()
Message-ID: <20200421082832.GD9721@chenyu-office.sh.intel.com>
References: <cover.1587309963.git.yu.c.chen@intel.com>
 <7c1eab789cb4b53ec5f54644c089ce27ea14088a.1587309963.git.yu.c.chen@intel.com>
 <20200420183232.16b83374@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420183232.16b83374@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 06:32:32PM -0400, Steven Rostedt wrote:
> On Mon, 20 Apr 2020 00:31:52 +0800
> Chen Yu <yu.c.chen@intel.com> wrote:
> 
> > Introduce a new function finish_prev_task() to do the balance
> > when necessary, and then put previous task back to the run queue.
> > This function is extracted from pick_next_task() to prepare for
> > future usage by other type of task picking logic.
> > 
> > No functional change.
> > 
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
> >  	schedstat_inc(this_rq()->sched_count);
> >  }
> >  
> > +static void finish_prev_task(struct rq *rq, struct task_struct *prev,
> > +			     struct rq_flags *rf)
> > +{
> > +	const struct sched_class *class;
> > +#ifdef CONFIG_SMP
> > +	/*
> > +	 * We must do the balancing pass before put_next_task(), such
> 
> I know this is just a cut and paste move, but I'm thinking that this
> comment is wrong. Shouldn't this be "put_prev_task()" as we have no
> "put_next_task()" function.
> 
>
Okay, I'll fix it in v3.
> > +	finish_prev_task(rq, prev, rf);
> 
> I'm not sure I like the name of this function. Perhaps
> "balance_and_put_prev_task()"? Something more in kind to what the function
> does.
>
Per the discussion, I think put_prev_task_balance() might be an
appropriate one.

Thanks,
Chenyu
> -- Steve
> 
> >  
> >  	for_each_class(class) {
> >  		p = class->pick_next_task(rq);
> 
