Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E09C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EA152065D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589394332;
	bh=VzKy7u07Uf/fuHCVHfQ/IG6dU+fbm2OYWdini0D7AFw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=reCOqsFfWYHeO+41u7pNTg8uEuhpg9XYBr01bWg9uhShYiYHpW2EMe1T5wRnZwde4
	 BNsSan+5rzynKN4HMWGlFuttCbjTNkfrFbyIdiQ5NN6HuOO6NvIdiXioChXBSZQZKe
	 qMkO3qvdG1QrE9Li9pPNCQ/rCAqAkZTTQHdnnZ9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390131AbgEMSZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:25:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:42864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389984AbgEMSZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:25:30 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93B19205ED;
        Wed, 13 May 2020 18:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589394330;
        bh=VzKy7u07Uf/fuHCVHfQ/IG6dU+fbm2OYWdini0D7AFw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XkQAh5J/y0ygVkBpzsA7qg7GGp4iRfUr/ESeYMv3d5+Ga8uWsRnXq5+QRQoTa59vp
         DfzV37e8/zY1EL7AYvT6BJ/pqlFFaZqNqpZm8vA0Er5gPGQPBRiMg/D/eFfwu+MZno
         g91pg19oJ5mFjZ9gyx+M4dLmoTmzjOt+rgtgj3Ds=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4F6CE352352C; Wed, 13 May 2020 11:25:27 -0700 (PDT)
Date:   Wed, 13 May 2020 11:25:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 07/10] rcu: Temporarily assume that nohz full CPUs might
 not be NOCB
Message-ID: <20200513182527.GU2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-8-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513164714.22557-8-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:47:11PM +0200, Frederic Weisbecker wrote:
> So far nohz_full CPUs had to be nocb. This requirement may change
> temporarily as we are working on preparing RCU to be able to toggle the
> nocb state of a CPU. Once that is done and nohz_full can be toggled as
> well dynamically, we'll restore that initial requirement.

Would it simplify anything to make the CPU exit nohz_full first and
then exit rcu_nocb and vice versa in the other direction?  That way the
assumption about nohz_full CPUs always being rcu_nocb could remain while
still allowing runtime changes to both states.

Of course, given that setup, it would not be possible to cause a CPU to
exit rcu_nocb state if it was still in nohz_full state.

My fear is that allowing a CPU to be in nohz_full state without also
being in rcu_nocb state will cause needless confusion and bug reports.

							Thanx, Paul

> Thus for now as a temporary state, make rcu_nohz_full_cpu() aware of
> nohz_full CPUs that are not nocb so that they can handle the callbacks
> locally.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c        | 2 +-
>  kernel/rcu/tree.h        | 2 +-
>  kernel/rcu/tree_plugin.h | 7 ++++---
>  3 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index cc95419f6491..74b6798309ef 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -3223,7 +3223,7 @@ static int rcu_pending(int user)
>  		return 1;
>  
>  	/* Is this a nohz_full CPU in userspace or idle?  (Ignore RCU if so.) */
> -	if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu())
> +	if ((user || rcu_is_cpu_rrupt_from_idle()) && rcu_nohz_full_cpu(rdp))
>  		return 0;
>  
>  	/* Is the RCU core waiting for a quiescent state from this CPU? */
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 9dc2ec021da5..4b9643d9f5e0 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -451,7 +451,7 @@ do {									\
>  #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
>  
>  static void rcu_bind_gp_kthread(void);
> -static bool rcu_nohz_full_cpu(void);
> +static bool rcu_nohz_full_cpu(struct rcu_data *rdp);
>  static void rcu_dynticks_task_enter(void);
>  static void rcu_dynticks_task_exit(void);
>  
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index 43ecc047af26..f19e81e0c691 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -2532,13 +2532,14 @@ static void show_rcu_nocb_state(struct rcu_data *rdp)
>   * The idea is to avoid waking up RCU core processing on such a
>   * CPU unless the grace period has extended for too long.
>   *
> - * This code relies on the fact that all NO_HZ_FULL CPUs are also
> - * CONFIG_RCU_NOCB_CPU CPUs.
> + * This code relies on the fact that NO_HZ_FULL CPUs might not
> + * be CONFIG_RCU_NOCB_CPU CPUs (temporary development state).
>   */
> -static bool rcu_nohz_full_cpu(void)
> +static bool rcu_nohz_full_cpu(struct rcu_data *rdp)
>  {
>  #ifdef CONFIG_NO_HZ_FULL
>  	if (tick_nohz_full_cpu(smp_processor_id()) &&
> +	    rcu_segcblist_is_offloaded(&rdp->cblist) &&
>  	    (!rcu_gp_in_progress() ||
>  	     ULONG_CMP_LT(jiffies, READ_ONCE(rcu_state.gp_start) + HZ)))
>  		return true;
> -- 
> 2.25.0
> 
