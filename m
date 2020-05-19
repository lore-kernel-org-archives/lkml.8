Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242DAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1AFC20758
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgESK2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:28:36 -0400
Received: from foss.arm.com ([217.140.110.172]:58452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgESK2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:28:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 060C2101E;
        Tue, 19 May 2020 03:28:35 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7DA03F305;
        Tue, 19 May 2020 03:28:33 -0700 (PDT)
Subject: Re: [PATCH v2] sched/pelt: sync util/runnable_sum with PELT window
 when propagating
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
References: <20200506155301.14288-1-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <c1beb50b-d385-524b-56e0-eae16d3700df@arm.com>
Date:   Tue, 19 May 2020 12:28:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506155301.14288-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2020 17:53, Vincent Guittot wrote:

[...]

> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 02f323b85b6d..df3923a65162 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3441,52 +3441,46 @@ static inline void
>  update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
>  {
>  	long delta = gcfs_rq->avg.util_avg - se->avg.util_avg;
> +	/*
> +	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
> +	 * See ___update_load_avg() for details.
> +	 */
> +	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;

Why not doing the assignment (like in update_tg_cfs_load()) after the
next condition? Same question for update_tg_cfs_runnable().

[...]

>  static inline void
>  update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
>  {
>  	long delta = gcfs_rq->avg.runnable_avg - se->avg.runnable_avg;
> +	/*
> +	 * cfs_rq->avg.period_contrib can be used for both cfs_rq and se.
> +	 * See ___update_load_avg() for details.
> +	 */
> +	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;

We know have 6 assignments like this in fair.c and 1 in pelt.c. Could
this not be refactored by using something like this in pelt.h:

+static inline u32 get_divider(struct sched_avg *avg)
+{
+       return LOAD_AVG_MAX - 1024 + avg->period_contrib;
+}

[...]

> diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> index b647d04d9c8b..1feff80e7e45 100644
> --- a/kernel/sched/pelt.c
> +++ b/kernel/sched/pelt.c
> @@ -237,6 +237,30 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
>  	return 1;
>  }
>  
> +/*
> + * When syncing *_avg with *_sum, we must take into account the current
> + * position in the PELT segment otherwise the remaining part of the segment
> + * will be considered as idle time whereas it's not yet elapsed and this will
> + * generate unwanted oscillation in the range [1002..1024[.
> + *
> + * The max value of *_sum varies with the position in the time segment and is
> + * equals to :
> + *
> + *   LOAD_AVG_MAX*y + sa->period_contrib
> + *
> + * which can be simplified into:
> + *
> + *   LOAD_AVG_MAX - 1024 + sa->period_contrib
> + *
> + * because LOAD_AVG_MAX*y == LOAD_AVG_MAX-1024

Isn't this rather '~' instead of '==', even for y^32 = 0.5 ?

47742 * 0.5^(1/32) ~ 47742 - 1024


Apart from that, LGTM

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
