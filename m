Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C7EC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D4E620776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587572211;
	bh=q4sIZ434gRYsa4MVZ0EHr9+b2mhAqWALjgqLPz4MwYo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=KCFRW4AJNaycRorkB3JxGW2sgfHy0IrShjgGdxaAZgR1154+N6psCdqyruOH3Xt5k
	 +4G75syrohBetuMP38FMXjK5BpkKs/7kdc+FjGbJUnJpaYrM6/SXS0NSWpgFPYTR2C
	 23iwZm9xVUyzNJJkVlw15HPriegtT/7gdlSbSLlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgDVQQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:38202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgDVQQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:16:48 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9E252076E;
        Wed, 22 Apr 2020 16:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587572207;
        bh=q4sIZ434gRYsa4MVZ0EHr9+b2mhAqWALjgqLPz4MwYo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=q7ubKY92eg3IqiMPgPAY76RCtwImgrc4k006mLwE3q9fiSUkK5/2LDs7jOu8thL3Q
         48ua7UxpbtVY+0c9UBNJL+GH17M+TLbzaOCuqCLFWNkvynYHznOxqymhBT9O/4Gyjn
         zR/nBQ9ecD6tzHgwixxSVWECJnPM2brXEYjVdRTw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A6F9535203BC; Wed, 22 Apr 2020 09:16:47 -0700 (PDT)
Date:   Wed, 22 Apr 2020 09:16:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, qais.yousef@arm.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, axboe@kernel.dk,
        daniel.lezcano@linaro.org, sudeep.holla@arm.com,
        airlied@redhat.com, broonie@kernel.org
Subject: Re: [PATCH 23/23] sched: Remove sched_set_*() return value
Message-ID: <20200422161647.GW17661@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200422112719.826676174@infradead.org>
 <20200422112832.590341262@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422112832.590341262@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:27:42PM +0200, Peter Zijlstra wrote:
> Ingo suggested that since the new sched_set_*() functions are
> implemented using the 'nocheck' variants, they really shouldn't ever
> fail, so remove the return value.
> 
> Cc: axboe@kernel.dk
> Cc: daniel.lezcano@linaro.org
> Cc: sudeep.holla@arm.com
> Cc: airlied@redhat.com
> Cc: broonie@kernel.org
> Cc: paulmck@kernel.org
> Suggested-by: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/block/drbd/drbd_receiver.c    |    4 +---
>  drivers/firmware/psci/psci_checker.c  |    3 +--
>  drivers/gpu/drm/msm/msm_drv.c         |    5 +----
>  drivers/platform/chrome/cros_ec_spi.c |    7 +++----
>  include/linux/sched.h                 |    6 +++---
>  kernel/rcu/rcutorture.c               |    5 +----
>  kernel/sched/core.c                   |   12 ++++++------
>  7 files changed, 16 insertions(+), 26 deletions(-)

[ . . . ]

> --- a/kernel/rcu/rcutorture.c
> +++ b/kernel/rcu/rcutorture.c
> @@ -806,10 +806,7 @@ static int rcu_torture_boost(void *arg)
>  	VERBOSE_TOROUT_STRING("rcu_torture_boost started");
>  
>  	/* Set real-time priority. */
> -	if (sched_set_fifo_low(current) < 0) {
> -		VERBOSE_TOROUT_STRING("rcu_torture_boost RT prio failed!");
> -		n_rcu_torture_boost_rterror++;
> -	}
> +	sched_set_fifo_low(current);
>  
>  	init_rcu_head_on_stack(&rbi.rcu);
>  	/* Each pass through the following loop does one boost-test cycle. */

This is the only update of n_rcu_torture_boost_rterror, so it can
be eliminated entirely, for example as shown below.

Other than that, looks good to me!

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index ee27b57..61b0c4f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -171,7 +171,6 @@ static atomic_t n_rcu_torture_mberror;
 static atomic_t n_rcu_torture_error;
 static long n_rcu_torture_barrier_error;
 static long n_rcu_torture_boost_ktrerror;
-static long n_rcu_torture_boost_rterror;
 static long n_rcu_torture_boost_failure;
 static long n_rcu_torture_boosts;
 static atomic_long_t n_rcu_torture_timers;
@@ -893,10 +892,7 @@ static int rcu_torture_boost(void *arg)
 	VERBOSE_TOROUT_STRING("rcu_torture_boost started");
 
 	/* Set real-time priority. */
-	if (sched_set_fifo_low(current) < 0) {
-		VERBOSE_TOROUT_STRING("rcu_torture_boost RT prio failed!");
-		n_rcu_torture_boost_rterror++;
-	}
+	sched_set_fifo_low(current);
 
 	init_rcu_head_on_stack(&rbi.rcu);
 	/* Each pass through the following loop does one boost-test cycle. */
@@ -1527,11 +1523,10 @@ rcu_torture_stats_print(void)
 		atomic_read(&n_rcu_torture_alloc),
 		atomic_read(&n_rcu_torture_alloc_fail),
 		atomic_read(&n_rcu_torture_free));
-	pr_cont("rtmbe: %d rtbe: %ld rtbke: %ld rtbre: %ld ",
+	pr_cont("rtmbe: %d rtbe: %ld rtbke: %ld ",
 		atomic_read(&n_rcu_torture_mberror),
 		n_rcu_torture_barrier_error,
-		n_rcu_torture_boost_ktrerror,
-		n_rcu_torture_boost_rterror);
+		n_rcu_torture_boost_ktrerror);
 	pr_cont("rtbf: %ld rtb: %ld nt: %ld ",
 		n_rcu_torture_boost_failure,
 		n_rcu_torture_boosts,
@@ -1545,14 +1540,12 @@ rcu_torture_stats_print(void)
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
 	    n_rcu_torture_barrier_error || n_rcu_torture_boost_ktrerror ||
-	    n_rcu_torture_boost_rterror || n_rcu_torture_boost_failure ||
-	    i > 1) {
+	    n_rcu_torture_boost_failure || i > 1) {
 		pr_cont("%s", "!!! ");
 		atomic_inc(&n_rcu_torture_error);
 		WARN_ON_ONCE(atomic_read(&n_rcu_torture_mberror));
 		WARN_ON_ONCE(n_rcu_torture_barrier_error);  // rcu_barrier()
 		WARN_ON_ONCE(n_rcu_torture_boost_ktrerror); // no boost kthread
-		WARN_ON_ONCE(n_rcu_torture_boost_rterror); // can't set RT prio
 		WARN_ON_ONCE(n_rcu_torture_boost_failure); // RCU boost failed
 		WARN_ON_ONCE(i > 1); // Too-short grace period
 	}
@@ -2569,7 +2562,6 @@ rcu_torture_init(void)
 	atomic_set(&n_rcu_torture_error, 0);
 	n_rcu_torture_barrier_error = 0;
 	n_rcu_torture_boost_ktrerror = 0;
-	n_rcu_torture_boost_rterror = 0;
 	n_rcu_torture_boost_failure = 0;
 	n_rcu_torture_boosts = 0;
 	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++)
