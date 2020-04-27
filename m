Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E3EEC54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E77E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbgD0Qfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:35:46 -0400
Received: from foss.arm.com ([217.140.110.172]:38004 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgD0Qfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:35:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A53AB31B;
        Mon, 27 Apr 2020 09:35:45 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 21A963F68F;
        Mon, 27 Apr 2020 09:35:44 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:35:41 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, daniel.lezcano@linaro.org,
        sudeep.holla@arm.com
Subject: Re: [PATCH 06/23] sched,psci: Convert to sched_set_fifo*()
Message-ID: <20200427163540.45wrw5kaakxzrokj@e107158-lin>
References: <20200422112719.826676174@infradead.org>
 <20200422112831.574539982@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422112831.574539982@infradead.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/22/20 13:27, Peter Zijlstra wrote:
> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
> 
> Effectively changes prio from 99 to 50.
> 
> XXX this thing is horrific, it basically open-codes a stop-machine and
> idle.
> 
> Cc: daniel.lezcano@linaro.org
> Cc: sudeep.holla@arm.com
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>
> ---
>  drivers/firmware/psci/psci_checker.c |   11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
> 
> --- a/drivers/firmware/psci/psci_checker.c
> +++ b/drivers/firmware/psci/psci_checker.c
> @@ -272,7 +272,6 @@ static int suspend_test_thread(void *arg
>  {
>  	int cpu = (long)arg;
>  	int i, nb_suspend = 0, nb_shallow_sleep = 0, nb_err = 0;
> -	struct sched_param sched_priority = { .sched_priority = MAX_RT_PRIO-1 };
>  	struct cpuidle_device *dev;
>  	struct cpuidle_driver *drv;
>  	/* No need for an actual callback, we just want to wake up the CPU. */
> @@ -282,9 +281,8 @@ static int suspend_test_thread(void *arg
>  	wait_for_completion(&suspend_threads_started);
>  
>  	/* Set maximum priority to preempt all other threads on this CPU. */
> -	if (sched_setscheduler_nocheck(current, SCHED_FIFO, &sched_priority))
> -		pr_warn("Failed to set suspend thread scheduler on CPU %d\n",
> -			cpu);
> +	if (sched_set_fifo(current))
> +		pr_warn("Failed to set suspend thread scheduler on CPU %d\n", cpu);
>  
>  	dev = this_cpu_read(cpuidle_devices);
>  	drv = cpuidle_get_cpu_driver(dev);
> @@ -349,11 +347,6 @@ static int suspend_test_thread(void *arg
>  	if (atomic_dec_return_relaxed(&nb_active_threads) == 0)
>  		complete(&suspend_threads_done);
>  
> -	/* Give up on RT scheduling and wait for termination. */
> -	sched_priority.sched_priority = 0;
> -	if (sched_setscheduler_nocheck(current, SCHED_NORMAL, &sched_priority))
> -		pr_warn("Failed to set suspend thread scheduler on CPU %d\n",
> -			cpu);

No need for sched_set_normal() here before the busy loop?

Thanks

--
Qais Yousef

>  	for (;;) {
>  		/* Needs to be set first to avoid missing a wakeup. */
>  		set_current_state(TASK_INTERRUPTIBLE);
> 
> 
