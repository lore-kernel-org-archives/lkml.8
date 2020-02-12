Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF846C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3DC7206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 14:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728311AbgBLOa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 09:30:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:55788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgBLOa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 09:30:29 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B3AEDAE0D;
        Wed, 12 Feb 2020 14:30:26 +0000 (UTC)
Date:   Wed, 12 Feb 2020 14:30:23 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        linux-kernel@vger.kernel.org, pauld@redhat.com,
        parth@linux.ibm.com, valentin.schneider@arm.com
Subject: Re: [RFC 3/4] sched/fair: replace runnable load average by runnable
 average
Message-ID: <20200212143023.GV3420@suse.de>
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200211174651.10330-4-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 06:46:50PM +0100, Vincent Guittot wrote:
> Now that runnable_load_avg is not more used, we can replace it by a new
> signal that will highlight the runnable pressure on a cfs_rq. This signal
> track the waiting time of tasks on rq and can help to better define the
> state of rqs.
> 
> At now, only util_avg is used to define the state of a rq:
>   A rq with more that around 80% of utilization and more than 1 tasks is
>   considered as overloaded.
> 
> But the util_avg signal of a rq can become temporaly low after that a task
> migrated onto another rq which can bias the classification of the rq.
> 
> When tasks compete for the same rq, their runnable average signal will be
> higher than util_avg as it will include the waiting time and we can use
> this signal to better classify cfs_rqs.
> 
> The new runnable_avg will track the runnable time of a task which simply
> adds the waiting time to the running time. The runnbale _avg of cfs_rq
> will be the /Sum of se's runnable_avg and the runnable_avg of group entity
> will follow the one of the rq similarly to util_avg.
> 

s/runnbale/runnable/

Otherwise, all I can do is give a heads-up that I will not be able to
review this patch and the next patch properly in the short-term. While the
new metric appears to have a sensible definition, I've not spent enough
time comparing/contrasting the pro's and con's of PELT implementation
details or their consequences. I am not confident I can accurately
predict whether this is better or if there are corner cases that make
poor placement decisions based on fast changes of runnable_avg. At least
not within a reasonable amount of time.

This caught my attention though

> @@ -4065,8 +4018,8 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>  	 *   - Add its new weight to cfs_rq->load.weight
>  	 */
>  	update_load_avg(cfs_rq, se, UPDATE_TG | DO_ATTACH);
> +	se_update_runnable(se);
>  	update_cfs_group(se);
> -	enqueue_runnable_load_avg(cfs_rq, se);
>  	account_entity_enqueue(cfs_rq, se);
>  
>  	if (flags & ENQUEUE_WAKEUP)

I don't think the ordering matters any more because of what was removed
from update_cfs_group. Unfortunately, I'm not 100% confident so am
bringing it to your attention in case it does.

-- 
Mel Gorman
SUSE Labs
