Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8544C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716F320658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PfYV+zDd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbgA3TKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:10:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52797 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727448AbgA3TKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580411435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B7IGI24AigTwnXKXuKEDpYn2wUd7tYIh5QTDfOmmhr4=;
        b=PfYV+zDd9a124ZDy95fsdG7WWOwj2r2l4XYCxOyEfiFQh9zNbDZKU01pwgMh8oMgyhHAkE
        f71POgX6+kjgBvRhAiZr5DcLewkvnaSMKj1ZP0VYfh4bn1mQQ6BPiMCN98r2F6SQk9Qf5k
        UzAFPjxuY13vkM6/TKaI1F1h9ZslSng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-Fq1NOeeCNGq1EvxZg3dYOg-1; Thu, 30 Jan 2020 14:10:17 -0500
X-MC-Unique: Fq1NOeeCNGq1EvxZg3dYOg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FF9D800D4C;
        Thu, 30 Jan 2020 19:10:16 +0000 (UTC)
Received: from pauld.bos.csb (dhcp-17-51.bos.redhat.com [10.18.17.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81C4D5C1B2;
        Thu, 30 Jan 2020 19:10:15 +0000 (UTC)
Date:   Thu, 30 Jan 2020 14:10:13 -0500
From:   Phil Auld <pauld@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-tip-commits@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>
Subject: Re: [tip: sched/core] sched/rt: Optimize checking group RT scheduler
 constraints
Message-ID: <20200130191013.GA24632@pauld.bos.csb>
References: <157996383820.4651.11292439232549211693.stgit@buzz>
 <158029757654.396.14560704856092377008.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158029757654.396.14560704856092377008.tip-bot2@tip-bot2>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 11:32:56AM -0000 tip-bot2 for Konstantin Khlebnikov wrote:
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     b4fb015eeff7f3e5518a7dbe8061169a3e2f2bc7
> Gitweb:        https://git.kernel.org/tip/b4fb015eeff7f3e5518a7dbe8061169a3e2f2bc7
> Author:        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> AuthorDate:    Sat, 25 Jan 2020 17:50:38 +03:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Tue, 28 Jan 2020 21:37:09 +01:00
> 
> sched/rt: Optimize checking group RT scheduler constraints
> 
> Group RT scheduler contains protection against setting zero runtime for
> cgroup with RT tasks. Right now function tg_set_rt_bandwidth() iterates
> over all CPU cgroups and calls tg_has_rt_tasks() for any cgroup which
> runtime is zero (not only for changed one). Default RT runtime is zero,
> thus tg_has_rt_tasks() will is called for almost at CPU cgroups.
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
> 
>  # mkdir /sys/fs/cgroup/cpu/test{1..10000}
>  # echo 0 | tee /sys/fs/cgroup/cpu/test*/cpu.rt_runtime_us
> 
> At the same time without patch fork time will be >100ms:
> 
>  # perf trace -e clone --duration 100 stress-ng --fork 1
> 
> Also remote ping will show timings >100ms caused by irq latency.
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Link: https://lkml.kernel.org/r/157996383820.4651.11292439232549211693.stgit@buzz
> ---
>  kernel/sched/rt.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 4043abe..55a4a50 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2449,10 +2449,11 @@ const struct sched_class rt_sched_class = {
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
> @@ -2460,12 +2461,12 @@ static inline int tg_has_rt_tasks(struct task_group *tg)
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

Heh, I misread it the first time and didn't see the !ret condition. But I think 
it should be just "ret = ".

But thanks for getting this fixed.


Cheers,
Phil


> -	return 0;
> +	return ret;
>  }
>  
>  struct rt_schedulable_data {
> @@ -2496,9 +2497,10 @@ static int tg_rt_schedulable(struct task_group *tg, void *data)
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
> @@ -2564,7 +2566,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
>  		return -EINVAL;
>  
>  	mutex_lock(&rt_constraints_mutex);
> -	read_lock(&tasklist_lock);
>  	err = __rt_schedulable(tg, rt_period, rt_runtime);
>  	if (err)
>  		goto unlock;
> @@ -2582,7 +2583,6 @@ static int tg_set_rt_bandwidth(struct task_group *tg,
>  	}
>  	raw_spin_unlock_irq(&tg->rt_bandwidth.rt_runtime_lock);
>  unlock:
> -	read_unlock(&tasklist_lock);
>  	mutex_unlock(&rt_constraints_mutex);
>  
>  	return err;
> @@ -2641,9 +2641,7 @@ static int sched_rt_global_constraints(void)
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

-- 

