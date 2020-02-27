Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93B4C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D8462469D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582810452;
	bh=y4Ce5Fpaj9wED2Zd39vOowMDGd1WIxYyfhwEapjXrwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZKHvJ6S8TOBKPc+Qtjgv6lX7m4JT8h1f4jTb0Ta5YUpMOqTuJF0Nlmxb2lrcXQgrc
	 lZWSUYdKPqmpJdLSLQwpJH6CM/KrHjF7WClqZnyckucJDneLbyM718hFlrP8yUGLFt
	 GfwzD4++K7jQcRVK0wFUBae6SyUBeumnfYg3uiaE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgB0NeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:34:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:60914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729056AbgB0NeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:34:11 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BE0D24656;
        Thu, 27 Feb 2020 13:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582810450;
        bh=y4Ce5Fpaj9wED2Zd39vOowMDGd1WIxYyfhwEapjXrwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B2nfZRuA70QT5kczsBwXC2TaGs4BuGm6aw3J5C7gX5ypIG+funRGTkK+3YmvI/GDI
         QKlJ12iAky/U5qdZ5JADJJCLnPc/AgtCjzkbEP437Lx76wQwGciKX63kPLmRPD3uMO
         ohg0VXD/C6A3FvUZLaTZdUSntO99z6N30qR0FpiY=
Date:   Thu, 27 Feb 2020 14:34:08 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] sched/vtime: Prevent unstable evaluation of
 WARN(vtime->state)
Message-ID: <20200227133407.GA21795@lenoir>
References: <20200123180849.28486-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123180849.28486-1-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping (again)?


On Thu, Jan 23, 2020 at 07:08:49PM +0100, Frederic Weisbecker wrote:
> From: Chris Wilson <chris@chris-wilson.co.uk>
> 
> As the vtime is sampled under loose seqcount protection by kcpustat, the
> vtime fields may change as the code flows. Where logic dictates a field
> has a static value, use a READ_ONCE.
> 
> Fixes: 74722bb223d0 ("sched/vtime: Bring up complete kcpustat accessor")
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/sched/cputime.c | 41 ++++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 19 deletions(-)
> 
> diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
> index d43318a489f2..df3577149d2e 100644
> --- a/kernel/sched/cputime.c
> +++ b/kernel/sched/cputime.c
> @@ -912,8 +912,10 @@ void task_cputime(struct task_struct *t, u64 *utime, u64 *stime)
>  	} while (read_seqcount_retry(&vtime->seqcount, seq));
>  }
>  
> -static int vtime_state_check(struct vtime *vtime, int cpu)
> +static int vtime_state_fetch(struct vtime *vtime, int cpu)
>  {
> +	int state = READ_ONCE(vtime->state);
> +
>  	/*
>  	 * We raced against a context switch, fetch the
>  	 * kcpustat task again.
> @@ -930,10 +932,10 @@ static int vtime_state_check(struct vtime *vtime, int cpu)
>  	 *
>  	 * Case 1) is ok but 2) is not. So wait for a safe VTIME state.
>  	 */
> -	if (vtime->state == VTIME_INACTIVE)
> +	if (state == VTIME_INACTIVE)
>  		return -EAGAIN;
>  
> -	return 0;
> +	return state;
>  }
>  
>  static u64 kcpustat_user_vtime(struct vtime *vtime)
> @@ -952,14 +954,15 @@ static int kcpustat_field_vtime(u64 *cpustat,
>  {
>  	struct vtime *vtime = &tsk->vtime;
>  	unsigned int seq;
> -	int err;
>  
>  	do {
> +		int state;
> +
>  		seq = read_seqcount_begin(&vtime->seqcount);
>  
> -		err = vtime_state_check(vtime, cpu);
> -		if (err < 0)
> -			return err;
> +		state = vtime_state_fetch(vtime, cpu);
> +		if (state < 0)
> +			return state;
>  
>  		*val = cpustat[usage];
>  
> @@ -972,7 +975,7 @@ static int kcpustat_field_vtime(u64 *cpustat,
>  		 */
>  		switch (usage) {
>  		case CPUTIME_SYSTEM:
> -			if (vtime->state == VTIME_SYS)
> +			if (state == VTIME_SYS)
>  				*val += vtime->stime + vtime_delta(vtime);
>  			break;
>  		case CPUTIME_USER:
> @@ -984,11 +987,11 @@ static int kcpustat_field_vtime(u64 *cpustat,
>  				*val += kcpustat_user_vtime(vtime);
>  			break;
>  		case CPUTIME_GUEST:
> -			if (vtime->state == VTIME_GUEST && task_nice(tsk) <= 0)
> +			if (state == VTIME_GUEST && task_nice(tsk) <= 0)
>  				*val += vtime->gtime + vtime_delta(vtime);
>  			break;
>  		case CPUTIME_GUEST_NICE:
> -			if (vtime->state == VTIME_GUEST && task_nice(tsk) > 0)
> +			if (state == VTIME_GUEST && task_nice(tsk) > 0)
>  				*val += vtime->gtime + vtime_delta(vtime);
>  			break;
>  		default:
> @@ -1039,23 +1042,23 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
>  {
>  	struct vtime *vtime = &tsk->vtime;
>  	unsigned int seq;
> -	int err;
>  
>  	do {
>  		u64 *cpustat;
>  		u64 delta;
> +		int state;
>  
>  		seq = read_seqcount_begin(&vtime->seqcount);
>  
> -		err = vtime_state_check(vtime, cpu);
> -		if (err < 0)
> -			return err;
> +		state = vtime_state_fetch(vtime, cpu);
> +		if (state < 0)
> +			return state;
>  
>  		*dst = *src;
>  		cpustat = dst->cpustat;
>  
>  		/* Task is sleeping, dead or idle, nothing to add */
> -		if (vtime->state < VTIME_SYS)
> +		if (state < VTIME_SYS)
>  			continue;
>  
>  		delta = vtime_delta(vtime);
> @@ -1064,15 +1067,15 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
>  		 * Task runs either in user (including guest) or kernel space,
>  		 * add pending nohz time to the right place.
>  		 */
> -		if (vtime->state == VTIME_SYS) {
> +		if (state == VTIME_SYS) {
>  			cpustat[CPUTIME_SYSTEM] += vtime->stime + delta;
> -		} else if (vtime->state == VTIME_USER) {
> +		} else if (state == VTIME_USER) {
>  			if (task_nice(tsk) > 0)
>  				cpustat[CPUTIME_NICE] += vtime->utime + delta;
>  			else
>  				cpustat[CPUTIME_USER] += vtime->utime + delta;
>  		} else {
> -			WARN_ON_ONCE(vtime->state != VTIME_GUEST);
> +			WARN_ON_ONCE(state != VTIME_GUEST);
>  			if (task_nice(tsk) > 0) {
>  				cpustat[CPUTIME_GUEST_NICE] += vtime->gtime + delta;
>  				cpustat[CPUTIME_NICE] += vtime->gtime + delta;
> @@ -1083,7 +1086,7 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
>  		}
>  	} while (read_seqcount_retry(&vtime->seqcount, seq));
>  
> -	return err;
> +	return 0;
>  }
>  
>  void kcpustat_cpu_fetch(struct kernel_cpustat *dst, int cpu)
> -- 
> 2.25.0
> 
