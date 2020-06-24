Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB2BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A23820823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405168AbgFXQcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:32:23 -0400
Received: from foss.arm.com ([217.140.110.172]:41130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404692AbgFXQcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:32:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DFEA81FB;
        Wed, 24 Jun 2020 09:32:18 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5932F3F73C;
        Wed, 24 Jun 2020 09:32:17 -0700 (PDT)
References: <20200624154422.29166-1-vincent.guittot@linaro.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        rong.a.chen@intel.com, pauld@redhat.com, hdanton@sina.com
Subject: Re: [PATCH] sched/cfs: change initial value of runnable_avg
In-reply-to: <20200624154422.29166-1-vincent.guittot@linaro.org>
Date:   Wed, 24 Jun 2020 17:32:12 +0100
Message-ID: <jhj8sgcs9v7.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/06/20 16:44, Vincent Guittot wrote:
> Some performance regression on reaim benchmark have been raised with
>   commit 070f5e860ee2 ("sched/fair: Take into account runnable_avg to classify group")
>
> The problem comes from the init value of runnable_avg which is initialized
> with max value. This can be a problem if the newly forked task is finally
> a short task because the group of CPUs is wrongly set to overloaded and
> tasks are pulled less agressively.
>
> Set initial value of runnable_avg equals to util_avg to reflect that there
> is no waiting time so far.
>
> Fixes: 070f5e860ee2 ("sched/fair: Take into account runnable_avg to classify group")
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0424a0af5f87..45e467bf42fc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -806,7 +806,7 @@ void post_init_entity_util_avg(struct task_struct *p)
>  		}
>  	}
>  
> -	sa->runnable_avg = cpu_scale;
> +	sa->runnable_avg = sa->util_avg;

IIRC we didn't go for this initially because hackbench behaved slightly
worse with it. Did we end up re-evaluating this? Also, how does this reaim
benchmark behave with it? I *think* the table from that regression thread
says it behaves better, but I had a hard time parsing it (seems like it got
damaged by line wrapping)

Conceptually I'm all for it, so as long as the tests back it up:
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

>  
>  	if (p->sched_class != &fair_sched_class) {
>  		/*

