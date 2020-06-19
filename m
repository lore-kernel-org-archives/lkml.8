Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E407AC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D60207FC
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 10:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbgFSKg1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 06:36:27 -0400
Received: from foss.arm.com ([217.140.110.172]:51180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729195AbgFSKgZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 06:36:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50909D6E;
        Fri, 19 Jun 2020 03:36:24 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0EB03F71F;
        Fri, 19 Jun 2020 03:36:22 -0700 (PDT)
References: <20200618195525.7889-1-qais.yousef@arm.com> <20200618195525.7889-2-qais.yousef@arm.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Fix initialization of strut uclamp_rq
In-reply-to: <20200618195525.7889-2-qais.yousef@arm.com>
Date:   Fri, 19 Jun 2020 11:36:17 +0100
Message-ID: <jhjy2ojcpge.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/06/20 20:55, Qais Yousef wrote:
> struct uclamp_rq was zeroed out entirely in assumption that in the first
> call to uclamp_rq_inc() they'd be initialized correctly in accordance to
> default settings.
>
> But when next patch introduces a static key to skip
> uclamp_rq_{inc,dec}() until userspace opts in to use uclamp, schedutil
> will fail to perform any frequency changes because the
> rq->uclamp[UCLAMP_MAX].value is zeroed at init and stays as such. Which
> means all rqs are capped to 0 by default.
>
> Fix it by making sure we do proper initialization at init without
> relying on uclamp_rq_inc() doing it later.
>
> Fixes: 69842cba9ace ("sched/uclamp: Add CPU's clamp buckets refcounting")
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> CC: Patrick Bellasi <patrick.bellasi@matbug.net>
> Cc: Chris Redpath <chrid.redpath@arm.com>
> Cc: Lukasz Luba <lukasz.luba@arm.com>
> Cc: linux-kernel@vger.kernel.org

Small nit below, otherwise:
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> ---
>  kernel/sched/core.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a43c84c27c6f..e19d2b915406 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1248,6 +1248,20 @@ static void uclamp_fork(struct task_struct *p)
>       }
>  }
>
> +static void __init init_uclamp_rq(struct rq *rq)
> +{
> +	enum uclamp_id clamp_id;
> +	struct uclamp_rq *uc_rq = rq->uclamp;
> +
> +	for_each_clamp_id(clamp_id) {
> +		memset(uc_rq[clamp_id].bucket,
> +		       0,
> +		       sizeof(struct uclamp_bucket)*UCLAMP_BUCKETS);
> +
> +		uc_rq[clamp_id].value = uclamp_none(clamp_id);
> +	}
> +}
> +
>  static void __init init_uclamp(void)
>  {
>       struct uclamp_se uc_max = {};
> @@ -1257,8 +1271,7 @@ static void __init init_uclamp(void)
>       mutex_init(&uclamp_mutex);
>
>       for_each_possible_cpu(cpu) {
> -		memset(&cpu_rq(cpu)->uclamp, 0,
> -				sizeof(struct uclamp_rq)*UCLAMP_CNT);
> +		init_uclamp_rq(cpu_rq(cpu));
>               cpu_rq(cpu)->uclamp_flags = 0;

That flags assignment ought to be squashed in the init function as well -
and actually you do that in patch 2, so I suppose that's a rebase accident.

>       }
