Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FE5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73D4D21739
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XT2QGLXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgA0RsA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:48:00 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30236 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725893AbgA0RsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:48:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580147279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=31iVBbzxoKFa3vmCLPwBlFC8DSfbR6x7KEgzFsnk8bw=;
        b=XT2QGLXyqd9/0046EgbIsTiI7ErxZ3dc+VGg+Ubxe2Jhi9raFuu0jfEdNY1myvRr/rooRY
        N1jwZRy9fC7tG2rE9tpw5tk+p9zYlX0EaQHQbs+fils6gcTYYTKxbBzSMoIPP5N9bpgEJ4
        g4iFptZf9Us7gzeyVrX/xY4+S9VAq7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-oVGGT4H6OiGxVMvGW1OJdA-1; Mon, 27 Jan 2020 12:47:57 -0500
X-MC-Unique: oVGGT4H6OiGxVMvGW1OJdA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D25B3107ACC4;
        Mon, 27 Jan 2020 17:47:54 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3C37660BFB;
        Mon, 27 Jan 2020 17:47:50 +0000 (UTC)
Date:   Mon, 27 Jan 2020 12:47:49 -0500
From:   Phil Auld <pauld@redhat.com>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH] sched/rt: optimize checking group rt scheduler
 constraints
Message-ID: <20200127174748.GE1295@pauld.bos.csb>
References: <157996383820.4651.11292439232549211693.stgit@buzz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <157996383820.4651.11292439232549211693.stgit@buzz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konstantin,

On Sat, Jan 25, 2020 at 05:50:38PM +0300 Konstantin Khlebnikov wrote:
> Group RT scheduler contains protection against setting zero runtime for
> cgroup with rt tasks. Right now function tg_set_rt_bandwidth() iterates
> over all cpu cgroups and calls tg_has_rt_tasks() for any cgroup which
> runtime is zero (not only for changed one). Default rt runtime is zero,
> thus tg_has_rt_tasks() will is called for almost at cpu cgroups.
> 
> This protection already is slightly racy: runtime limit could be changed
> between cpu_cgroup_can_attach() and cpu_cgroup_attach() because changing
> cgroup attribute does not lock cgroup_mutex while attach does not lock
> rt_constraints_mutex. Changing task scheduler class also races with
> changing rt runtime: check in __sched_setscheduler() isn't protected.
> 
> Function tg_has_rt_tasks() iterates over all threads in the system.
> This gives NR_CGROUPS * NR_TASKS operations under single tasklist_lock
> locked for read tg_set_rt_bandwidth(). Any concurrent attempt of locking
> tasklist_lock for write (for example fork) will stuck with disabled irqs.
> 
> This patch makes two optimizations:
> 1) Remove locking tasklist_lock and iterate only tasks in cgroup
> 2) Call tg_has_rt_tasks() iff rt runtime changes from non-zero to zero
> 
> All changed code is under CONFIG_RT_GROUP_SCHED.
> 
> Testcase:
> # mkdir /sys/fs/cgroup/cpu/test{1..10000}
> # echo 0 | tee /sys/fs/cgroup/cpu/test*/cpu.rt_runtime_us
> 
> At the same time without patch fork time will be >100ms:
> # perf trace -e clone --duration 100 stress-ng --fork 1
> 
> Also remote ping will show timings >100ms caused by irq latency.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  kernel/sched/rt.c |   24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index e591d40fd645..95d1d7be84ef 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2396,10 +2396,11 @@ const struct sched_class rt_sched_class = {
>   */
>  static DEFINE_MUTEX(rt_constraints_mutex);
>  
> -/* Must be called with tasklist_lock held */
>  static inline int tg_has_rt_tasks(struct task_group *tg)
>  {
> -	struct task_struct *g, *p;
> +	struct task_struct *task;
> +	struct css_task_iter it;
> +	int ret = 0;
>  
>  	/*
>  	 * Autogroups do not have RT tasks; see autogroup_create().
> @@ -2407,12 +2408,12 @@ static inline int tg_has_rt_tasks(struct task_group *tg)
>  	if (task_group_is_autogroup(tg))
>  		return 0;
>  
> -	for_each_process_thread(g, p) {
> -		if (rt_task(p) && task_group(p) == tg)
> -			return 1;
> -	}
> +	css_task_iter_start(&tg->css, 0, &it);
> +	while (!ret && (task = css_task_iter_next(&it)))
> +		ret |= rt_task(task);
> +	css_task_iter_end(&it);
>  

Why not a break; in there alon with the change to "="?


> -	return 0;
> +	return ret;
>  }
>  
>  struct rt_schedulable_data {
> @@ -2443,9 +2444,10 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
>  		return -EINVAL;
>  
>  	/*
> -	 * Ensure we don't starve existing RT tasks.
> +	 * Ensure we don't starve existing RT tasks if runtime turns zero.
>  	 */
> -	if (rt_bandwidth_enabled() && !runtime && tg_has_rt_tasks(tg))
> +	if (rt_bandwidth_enabled() && !runtime &&
> +	    tg->rt_bandwidth.rt_runtime && tg_has_rt_tasks(tg))
>  		return -EBUSY;
>  
>  	total = to_ratio(period, runtime);
> @@ -2511,7 +2513,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
>  		return -EINVAL;
>  
>  	mutex_lock(&rt_constraints_mutex);
> -	read_lock(&tasklist_lock);
>  	err = __rt_schedulable(tg, rt_period, rt_runtime);
>  	if (err)
>  		goto unlock;
> @@ -2529,7 +2530,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
>  	}
>  	raw_spin_unlock_irq(&tg->rt_bandwidth.rt_runtime_lock);
>  unlock:
> -	read_unlock(&tasklist_lock);
>  	mutex_unlock(&rt_constraints_mutex);
>  
>  	return err;
> @@ -2588,9 +2588,7 @@ static int sched_rt_global_constraints(void)
>  	int ret = 0;
>  
>  	mutex_lock(&rt_constraints_mutex);
> -	read_lock(&tasklist_lock);
>  	ret = __rt_schedulable(NULL, 0, 0);
> -	read_unlock(&tasklist_lock);
>  	mutex_unlock(&rt_constraints_mutex);
>  
>  	return ret;
> 


Thanks,
Phil

-- 

