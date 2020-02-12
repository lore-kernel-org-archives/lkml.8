Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1200DC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E221B2073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgBLNUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:20:44 -0500
Received: from mx2.suse.de ([195.135.220.15]:58646 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgBLNUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 08:20:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7986CAEEE;
        Wed, 12 Feb 2020 13:20:39 +0000 (UTC)
Date:   Wed, 12 Feb 2020 13:20:36 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, valentin.schneider@arm.com
Subject: Re: [PATCH 1/4] sched/fair: reorder enqueue/dequeue_task_fair path
Message-ID: <20200212132036.GT3420@suse.de>
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200211174651.10330-2-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 06:46:48PM +0100, Vincent Guittot wrote:
> The walk through the cgroup hierarchy during the enqueue/dequeue of a task
> is split in 2 distinct parts for throttled cfs_rq without any added value
> but making code less readable.
> 
> Change the code ordering such that everything related to a cfs_rq
> (throttled or not) will be done in the same loop.
> 
> In addition, the same steps ordering is used when updating a cfs_rq:
> - update_load_avg
> - update_cfs_group
> - update *h_nr_running
> 
> No functional and performance changes are expected and have been noticed
> during tests.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 42 ++++++++++++++++++++----------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 1a0ce83e835a..a1ea02b5362e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5259,32 +5259,31 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  		cfs_rq = cfs_rq_of(se);
>  		enqueue_entity(cfs_rq, se, flags);
>  
> -		/*
> -		 * end evaluation on encountering a throttled cfs_rq
> -		 *
> -		 * note: in the case of encountering a throttled cfs_rq we will
> -		 * post the final h_nr_running increment below.
> -		 */
> -		if (cfs_rq_throttled(cfs_rq))
> -			break;
>  		cfs_rq->h_nr_running++;
>  		cfs_rq->idle_h_nr_running += idle_h_nr_running;
>  
> +		/* end evaluation on encountering a throttled cfs_rq */
> +		if (cfs_rq_throttled(cfs_rq))
> +			goto enqueue_throttle;
> +
>  		flags = ENQUEUE_WAKEUP;
>  	}
>  
>  	for_each_sched_entity(se) {
>  		cfs_rq = cfs_rq_of(se);
> -		cfs_rq->h_nr_running++;
> -		cfs_rq->idle_h_nr_running += idle_h_nr_running;
>  
> +		/* end evaluation on encountering a throttled cfs_rq */
>  		if (cfs_rq_throttled(cfs_rq))
> -			break;
> +			goto enqueue_throttle;
>  
>  		update_load_avg(cfs_rq, se, UPDATE_TG);
>  		update_cfs_group(se);
> +
> +		cfs_rq->h_nr_running++;
> +		cfs_rq->idle_h_nr_running += idle_h_nr_running;
>  	}
>  
> +enqueue_throttle:
>  	if (!se) {
>  		add_nr_running(rq, 1);
>  		/*

I'm having trouble reconciling the patch with the description and the
comments explaining the intent behind the code are unhelpful.

There are two loops before and after your patch -- the first dealing with
sched entities that are not on a runqueue and the second for the remaining
entities that are. The intent appears to be to update the load averages
once the entity is active on a runqueue.

I'm not getting why the changelog says everything related to cfs is
now done in one loop because there are still two. But even if you do
get throttled, it's not clear why you jump to the !se check given that
for_each_sched_entity did not complete. What it *does* appear to do is
have all the h_nr_running related to entities being enqueued updated in
one loop and all remaining entities stats updated in the other.

Following the accounting is tricky. Before the patch, if throttling
happened then h_nr_running was updated without updating the corresponding
nr_running counter in rq. They are out of sync until unthrottle_cfs_rq
is called at the very least. After your patch, the same is true and while
the accounting appears to be equivalent, it's not clear it's correct and
I do not find the code any easier to understand after the patch or how
it's connected to runnable_load_avg which this series is about :(

I think the patch is functionally ok but I am having trouble figuring
out the motive. Maybe it'll be obvious after I read the rest of the series.

-- 
Mel Gorman
SUSE Labs
