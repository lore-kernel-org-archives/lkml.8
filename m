Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E2B1C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4D12098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587570640;
	bh=WojjijFm9uB3iamQIELJrRUUjEhnXoMUAOL97LbpWSE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=EmhIZicWaSTTkshh3I3owxRLULu+EqVi63Vm3KkvA7RRdVXA+ZwW1tx2klZ3s67t/
	 4N+8c9UCJ76560xcVGH+5Sfzub9bjj2aolAfJJ6RqnT8bTzSlcNXE3Z4nPhyhwtzMW
	 wXR57yuTw6c9S7wX/tVxwcbR1WTxgpYoYZfY5EsE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgDVPuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:50:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:55326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgDVPuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:50:39 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70AC620767;
        Wed, 22 Apr 2020 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587570638;
        bh=WojjijFm9uB3iamQIELJrRUUjEhnXoMUAOL97LbpWSE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=xDiHC3IhgJqEw0DG0viojmCLdwIyCkXwZRXqUlK9eTlJVMsN+W5y6fCs5jYAc3m9q
         5a8fafdrxGL2N9pr+l9negvrz+iE1a8ncaTSOLF9EtSMHXmkSFm1RqFkK+5CWBJqWm
         BXSKoHWHiPiC52vsrz84jlFzjLJndSEm9xD1EcII=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 5175935203BC; Wed, 22 Apr 2020 08:50:38 -0700 (PDT)
Date:   Wed, 22 Apr 2020 08:50:38 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, airlied@redhat.com,
        alexander.deucher@amd.com, awalls@md.metrocast.net,
        axboe@kernel.dk, broonie@kernel.org, daniel.lezcano@linaro.org,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org,
        herbert@gondor.apana.org.au, hverkuil@xs4all.nl,
        john.stultz@linaro.org, nico@fluxnic.net,
        rafael.j.wysocki@intel.com, rmk+kernel@arm.linux.org.uk,
        sudeep.holla@arm.com, ulf.hansson@linaro.org,
        wim@linux-watchdog.org
Subject: Re: [PATCH 01/23] sched: Provide sched_set_fifo()
Message-ID: <20200422155038.GS17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200422112719.826676174@infradead.org>
 <20200422112831.266499893@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422112831.266499893@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:27:20PM +0200, Peter Zijlstra wrote:
> SCHED_FIFO (or any static priority scheduler) is a broken scheduler
> model; it is fundamentally incapable of resource management, the one
> thing an OS is actually supposed to do.
> 
> It is impossible to compose static priority workloads. One cannot take
> two well designed and functional static priority workloads and mash
> them together and still expect them to work.
> 
> Therefore it doesn't make sense to expose the priority field; the
> kernel is fundamentally incapable of setting a sensible value, it
> needs systems knowledge that it doesn't have.
> 
> Take away sched_setschedule() / sched_setattr() from modules and
> replace them with:
> 
>   - sched_set_fifo(p); create a FIFO task (at prio 50)
>   - sched_set_fifo_low(p); create a task higher than NORMAL,
> 	which ends up being a FIFO task at prio 1.
>   - sched_set_normal(p, nice); (re)set the task to normal
> 
> This stops the proliferation of randomly chosen, and irrelevant, FIFO
> priorities that dont't really mean anything anyway.
> 
> The system administrator/integrator, whoever has insight into the
> actual system design and requirements (userspace) can set-up
> appropriate priorities if and when needed.
> 
> Cc: airlied@redhat.com
> Cc: alexander.deucher@amd.com
> Cc: awalls@md.metrocast.net
> Cc: axboe@kernel.dk
> Cc: broonie@kernel.org
> Cc: daniel.lezcano@linaro.org
> Cc: gregkh@linuxfoundation.org
> Cc: hannes@cmpxchg.org
> Cc: herbert@gondor.apana.org.au
> Cc: hverkuil@xs4all.nl
> Cc: john.stultz@linaro.org
> Cc: nico@fluxnic.net
> Cc: paulmck@kernel.org
> Cc: rafael.j.wysocki@intel.com
> Cc: rmk+kernel@arm.linux.org.uk
> Cc: sudeep.holla@arm.com
> Cc: tglx@linutronix.de
> Cc: ulf.hansson@linaro.org
> Cc: wim@linux-watchdog.org
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>

Tested-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  include/linux/sched.h |    3 +++
>  kernel/sched/core.c   |   47 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1631,6 +1631,9 @@ extern int idle_cpu(int cpu);
>  extern int available_idle_cpu(int cpu);
>  extern int sched_setscheduler(struct task_struct *, int, const struct sched_param *);
>  extern int sched_setscheduler_nocheck(struct task_struct *, int, const struct sched_param *);
> +extern int sched_set_fifo(struct task_struct *p);
> +extern int sched_set_fifo_low(struct task_struct *p);
> +extern int sched_set_normal(struct task_struct *p, int nice);
>  extern int sched_setattr(struct task_struct *, const struct sched_attr *);
>  extern int sched_setattr_nocheck(struct task_struct *, const struct sched_attr *);
>  extern struct task_struct *idle_task(int cpu);
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5055,6 +5055,8 @@ static int _sched_setscheduler(struct ta
>   * @policy: new policy.
>   * @param: structure containing the new RT priority.
>   *
> + * Use sched_set_fifo(), read its comment.
> + *
>   * Return: 0 on success. An error code otherwise.
>   *
>   * NOTE that the task may be already dead.
> @@ -5097,6 +5099,51 @@ int sched_setscheduler_nocheck(struct ta
>  }
>  EXPORT_SYMBOL_GPL(sched_setscheduler_nocheck);
>  
> +/*
> + * SCHED_FIFO is a broken scheduler model; that is, it is fundamentally
> + * incapable of resource management, which is the one thing an OS really should
> + * be doing.
> + *
> + * This is of course the reason it is limited to privileged users only.
> + *
> + * Worse still; it is fundamentally impossible to compose static priority
> + * workloads. You cannot take two correctly working static prio workloads
> + * and smash them together and still expect them to work.
> + *
> + * For this reason 'all' FIFO tasks the kernel creates are basically at:
> + *
> + *   MAX_RT_PRIO / 2
> + *
> + * The administrator _MUST_ configure the system, the kernel simply doesn't
> + * know enough information to make a sensible choice.
> + */
> +int sched_set_fifo(struct task_struct *p)
> +{
> +	struct sched_param sp = { .sched_priority = MAX_RT_PRIO / 2 };
> +	return sched_setscheduler_nocheck(p, SCHED_FIFO, &sp);
> +}
> +EXPORT_SYMBOL_GPL(sched_set_fifo);
> +
> +/*
> + * For when you don't much care about FIFO, but want to be above SCHED_NORMAL.
> + */
> +int sched_set_fifo_low(struct task_struct *p)
> +{
> +	struct sched_param sp = { .sched_priority = 1 };
> +	return sched_setscheduler_nocheck(p, SCHED_FIFO, &sp);
> +}
> +EXPORT_SYMBOL_GPL(sched_set_fifo_low);
> +
> +int sched_set_normal(struct task_struct *p, int nice)
> +{
> +	struct sched_attr attr = {
> +		.sched_policy = SCHED_NORMAL,
> +		.sched_nice = nice,
> +	};
> +	return sched_setattr_nocheck(p, &attr);
> +}
> +EXPORT_SYMBOL_GPL(sched_set_normal);
> +
>  static int
>  do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
>  {
> 
> 
