Return-Path: <SRS0=4VRK=47=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C69AC10DCE
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2804E2074D
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Mar 2020 00:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584145807;
	bh=mytMbKcVo3G8GeSdyPgGXZoqLhztVzpu0+zOLIaooSQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=vsQmIYRb0KGfqZN40C6APEHgTsm9Yj3AOjFzG/zELleYHVdwx4ZbakSY6nngaznA0
	 wz3Ua0yfezZFvJXG179jAsCs4xlGaf48momcGDrs4kj1saqKx1H90dvb2fzJMoGlJZ
	 DkSsU+46Zz3FRZTqbqESqgAA/qD0pA3X+4r6eMqs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbgCNAaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 20:30:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbgCNAaF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 20:30:05 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C72662074C;
        Sat, 14 Mar 2020 00:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584145804;
        bh=mytMbKcVo3G8GeSdyPgGXZoqLhztVzpu0+zOLIaooSQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=JwQUJ3pz31wLbCTpybzMxA3FGgqXaqPr+AatA74o1RYdPWETxnrR5n4xEyJAZ6svj
         sShyWV3B+9aBiJ2ysYoH3FDJsqIri0Bp2zMiMwZ3XyDCfzPTv7yvT9MivZZhSlzsnc
         LBpy32IqmJ0dVNUvS3+9I99UQxRfFErgHBHDBE7o=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 9330135226C7; Fri, 13 Mar 2020 17:30:04 -0700 (PDT)
Date:   Fri, 13 Mar 2020 17:30:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, vpillai <vpillai@digitalocean.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, peterz@infradead.org,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched: Use RCU-sched in core-scheduling balancing logic
Message-ID: <20200314003004.GI3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200313232918.62303-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200313232918.62303-1-joel@joelfernandes.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 07:29:18PM -0400, Joel Fernandes (Google) wrote:
> rcu_read_unlock() can incur an infrequent deadlock in
> sched_core_balance(). Fix this by using the RCU-sched flavor instead.
> 
> This fixes the following spinlock recursion observed when testing the
> core scheduling patches on PREEMPT=y kernel on ChromeOS:
> 
> [    3.240891] BUG: spinlock recursion on CPU#2, swapper/2/0
> [    3.240900]  lock: 0xffff9cd1eeb28e40, .magic: dead4ead, .owner: swapper/2/0, .owner_cpu: 2
> [    3.240905] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 5.4.22htcore #4
> [    3.240908] Hardware name: Google Eve/Eve, BIOS Google_Eve.9584.174.0 05/29/2018
> [    3.240910] Call Trace:
> [    3.240919]  dump_stack+0x97/0xdb
> [    3.240924]  ? spin_bug+0xa4/0xb1
> [    3.240927]  do_raw_spin_lock+0x79/0x98
> [    3.240931]  try_to_wake_up+0x367/0x61b
> [    3.240935]  rcu_read_unlock_special+0xde/0x169
> [    3.240938]  ? sched_core_balance+0xd9/0x11e
> [    3.240941]  __rcu_read_unlock+0x48/0x4a
> [    3.240945]  __balance_callback+0x50/0xa1
> [    3.240949]  __schedule+0x55a/0x61e
> [    3.240952]  schedule_idle+0x21/0x2d
> [    3.240956]  do_idle+0x1d5/0x1f8
> [    3.240960]  cpu_startup_entry+0x1d/0x1f
> [    3.240964]  start_secondary+0x159/0x174
> [    3.240967]  secondary_startup_64+0xa4/0xb0
> [   14.998590] watchdog: BUG: soft lockup - CPU#0 stuck for 11s! [kworker/0:10:965]
> 
> Cc: vpillai <vpillai@digitalocean.com>
> Cc: Aaron Lu <aaron.lwe@gmail.com>
> Cc: Aubrey Li <aubrey.intel@gmail.com>
> Cc: peterz@infradead.org
> Cc: paulmck@kernel.org
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

The original could indeed deadlock, and this would avoid that deadlock.
(The commit to solve this deadlock is sadly not yet in mainline.)

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  kernel/sched/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3045bd50e249..037e8f2e2686 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4735,7 +4735,7 @@ static void sched_core_balance(struct rq *rq)
>  	struct sched_domain *sd;
>  	int cpu = cpu_of(rq);
>  
> -	rcu_read_lock();
> +	rcu_read_lock_sched();
>  	raw_spin_unlock_irq(rq_lockp(rq));
>  	for_each_domain(cpu, sd) {
>  		if (!(sd->flags & SD_LOAD_BALANCE))
> @@ -4748,7 +4748,7 @@ static void sched_core_balance(struct rq *rq)
>  			break;
>  	}
>  	raw_spin_lock_irq(rq_lockp(rq));
> -	rcu_read_unlock();
> +	rcu_read_unlock_sched();
>  }
>  
>  static DEFINE_PER_CPU(struct callback_head, core_balance_head);
> -- 
> 2.25.1.481.gfbce0eb801-goog
> 
