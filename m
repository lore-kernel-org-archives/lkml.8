Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8208BC2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BEAD222C2
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728017AbgBMSct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:32:49 -0500
Received: from foss.arm.com ([217.140.110.172]:52050 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMSct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:32:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 357B4328;
        Thu, 13 Feb 2020 10:32:49 -0800 (PST)
Received: from [10.1.195.59] (ifrit.cambridge.arm.com [10.1.195.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D1FE13F68E;
        Thu, 13 Feb 2020 10:32:47 -0800 (PST)
Subject: Re: [RFC 4/4] sched/fair: Take into runnable_avg to classify group
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     pauld@redhat.com, parth@linux.ibm.com
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-5-vincent.guittot@linaro.org>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <94eae44f-7608-936d-4fde-dcf93cfa6b9b@arm.com>
Date:   Thu, 13 Feb 2020 18:32:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200211174651.10330-5-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/20 5:46 PM, Vincent Guittot wrote:
> Take into account the new runnable_avg signal to classify a group and to
> mitigate the volatility of util_avg in face of intensive migration.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 7d7cb207be30..5f8f12c902d4 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7691,6 +7691,7 @@ struct sg_lb_stats {
>  	unsigned long group_load; /* Total load over the CPUs of the group */
>  	unsigned long group_capacity;
>  	unsigned long group_util; /* Total utilization of the group */
> +	unsigned long group_runnable; /* Total utilization of the group */
                                               ^^^^^^^^^^^
"Total runnable" hurts my eyes, but in any case this shouldn't be just
"utilization".

>  	unsigned int sum_nr_running; /* Nr of tasks running in the group */
>  	unsigned int sum_h_nr_running; /* Nr of CFS tasks running in the group */
>  	unsigned int idle_cpus;
> @@ -7911,6 +7912,10 @@ group_has_capacity(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>  	if (sgs->sum_nr_running < sgs->group_weight)
>  		return true;
>  
> +	if ((sgs->group_capacity * imbalance_pct) <
> +			(sgs->group_runnable * 100))
> +		return false;
> +

I haven't stared long enough at patch 2, but I'll ask anyway - with this new
condition, do we still need the next one (based on util)? AIUI
group_runnable is >= group_util, so if group_runnable is within the allowed
margin then group_util has to be as well.

>  	if ((sgs->group_capacity * 100) >
>  			(sgs->group_util * imbalance_pct))
>  		return true;
> @@ -7936,6 +7941,10 @@ group_is_overloaded(unsigned int imbalance_pct, struct sg_lb_stats *sgs)
>  			(sgs->group_util * imbalance_pct))
>  		return true;
>  
> +	if ((sgs->group_capacity * imbalance_pct) <
> +			(sgs->group_runnable * 100))
> +		return true;
> +

Ditto on the group_runnable >= group_util - we could get rid of the check
above this one.

>  	return false;
>  }
>  
> @@ -8030,6 +8039,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  
>  		sgs->group_load += cpu_load(rq);
>  		sgs->group_util += cpu_util(i);
> +		sgs->group_runnable += cpu_runnable(rq);
>  		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
>  
>  		nr_running = rq->nr_running;
> 
