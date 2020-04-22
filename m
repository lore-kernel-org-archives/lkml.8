Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049E5C55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6282076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587570708;
	bh=V02bRyFh9S6guoFzWbPX7YTwGHVqKjU6RgP2Zwd0W5M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=kuC+hGx2+K+y3PStFKJxpdpF7IjscLxk9f3OqeDVLaYBHzlqqJVdPLppPi5gkWepV
	 KS3aKvLdV1UBmmrqD5E5dTCEVMEC1DVuNtVOkZuzZ4hNFfvUyIxl+5kgnj+jI8qL5R
	 qXhPEI0XOJviuOZT83qEVyjGlEyTD2l9LyyrJec0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgDVPvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:51:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:57100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726183AbgDVPvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:51:45 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C7C920776;
        Wed, 22 Apr 2020 15:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587570705;
        bh=V02bRyFh9S6guoFzWbPX7YTwGHVqKjU6RgP2Zwd0W5M=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=vl4AC7pb1CKdsSwRKneTEoz6KnrGcrXjTSm5tb2YHyvZi/rm5sweNtjQK8HggVwQk
         6eWhAP092SHqtHXT3I7scFr8AYSlwtB5NLWZrQ26Bp/jZZVFgf/u1Zgplwf/0biGad
         3Uc9OIISXA1EEoUrxbjyHVtDnnIA5MUK3gWj0nvk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E1A2A35203BC; Wed, 22 Apr 2020 08:51:44 -0700 (PDT)
Date:   Wed, 22 Apr 2020 08:51:44 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de
Subject: Re: [PATCH 19/23] sched,rcuperf: Convert to sched_set_fifo_low()
Message-ID: <20200422155144.GU17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200422112719.826676174@infradead.org>
 <20200422112832.343851342@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422112832.343851342@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:27:38PM +0200, Peter Zijlstra wrote:
> Because SCHED_FIFO is a broken scheduler model (see previous patches)
> take away the priority field, the kernel can't possibly make an
> informed decision.
> 
> Effectively no change.
> 
> Cc: paulmck@kernel.org
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Ingo Molnar <mingo@kernel.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/rcu/rcuperf.c |    8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
> 
> --- a/kernel/rcu/rcuperf.c
> +++ b/kernel/rcu/rcuperf.c
> @@ -353,7 +353,6 @@ rcu_perf_writer(void *arg)
>  	int i_max;
>  	long me = (long)arg;
>  	struct rcu_head *rhp = NULL;
> -	struct sched_param sp;
>  	bool started = false, done = false, alldone = false;
>  	u64 t;
>  	u64 *wdp;
> @@ -362,8 +361,7 @@ rcu_perf_writer(void *arg)
>  	VERBOSE_PERFOUT_STRING("rcu_perf_writer task started");
>  	WARN_ON(!wdpp);
>  	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
> -	sp.sched_priority = 1;
> -	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);
> +	sched_set_fifo_low(current);
>  
>  	if (holdoff)
>  		schedule_timeout_uninterruptible(holdoff * HZ);
> @@ -419,9 +417,7 @@ rcu_perf_writer(void *arg)
>  			started = true;
>  		if (!done && i >= MIN_MEAS) {
>  			done = true;
> -			sp.sched_priority = 0;
> -			sched_setscheduler_nocheck(current,
> -						   SCHED_NORMAL, &sp);
> +			sched_set_normal(current, 0);
>  			pr_alert("%s%s rcu_perf_writer %ld has %d measurements\n",
>  				 perf_type, PERF_FLAG, me, MIN_MEAS);
>  			if (atomic_inc_return(&n_rcu_perf_writer_finished) >=
> 
> 
