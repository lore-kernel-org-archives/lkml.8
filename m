Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D5BDC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E684622525
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 18:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgATSVK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 13:21:10 -0500
Received: from outbound-smtp01.blacknight.com ([81.17.249.7]:52101 "EHLO
        outbound-smtp01.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726982AbgATSVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 13:21:07 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp01.blacknight.com (Postfix) with ESMTPS id 9C66C98BCC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 18:21:02 +0000 (GMT)
Received: (qmail 15094 invoked from network); 20 Jan 2020 18:21:02 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 20 Jan 2020 18:21:02 -0000
Date:   Mon, 20 Jan 2020 18:21:00 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small load imbalance between low
 utilisation SD_NUMA domains v4
Message-ID: <20200120182100.GU3466@techsingularity.net>
References: <20200114101319.GO3466@techsingularity.net>
 <20200117175631.GC20112@linux.vnet.ibm.com>
 <20200117215853.GS3466@techsingularity.net>
 <20200120080935.GD20112@linux.vnet.ibm.com>
 <20200120083354.GT3466@techsingularity.net>
 <20200120172706.GE20112@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20200120172706.GE20112@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 10:57:06PM +0530, Srikar Dronamraju wrote:
> > And this is why I'm curious as to why your workload is affected at all
> > because it uses many tasks.  I stopped allowing an imbalance for higher
> > task counts partially on the basis of your previous report.
> > 
> 
> With this hunk on top of your patch and 5 runs of numa02, there were 0
> traces.
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ade7a8dca5e4..7506cf67bde8 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8714,8 +8714,10 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  			 * the risk that lower domains have to be rebalanced.
>  			 */
>  			imbalance_min = 2;
> -			if (busiest->sum_nr_running <= imbalance_min)
> +			if (busiest->sum_nr_running <= imbalance_min) {
> +				trace_printk("Reseting imbalance: busiest->sum_nr_running=%d, local->sum_nr_running=%d\n", busiest->sum_nr_irunning, local->sum_nr_running);
>  				env->imbalance = 0;
> +			}
>  		}
>  
>  		return;
> 

Ok, thanks. No traces indicates that the patch should have no effect at
all and any difference in performance is a coincidence. What about the
other test programs?

> 
> perf stat for the 5 iterations this time shows: 
> 77.817 +- 0.995 seconds time elapsed  ( +-  1.28% )
> which I think is significantly less than last time around.
> 
> So I think it may be some other noise that could have contributed to the
> jump last time. Also since the time consumption of numa02 is very small, a
> small disturbance can show up as a big number from a percentage perspective.

Understood. At the moment, I'm going to assume that the patch has zero
impact on your workload but confirmation that the other test programs
trigger no traces would be appreciated.

-- 
Mel Gorman
SUSE Labs
