Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2080C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FEC32065C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589394034;
	bh=wbAs4tHZl1UycvGcreBgD9ZPdNkWCmGB3prveLz95SQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=f5P0dHVhg2Tvg3XWgA3hRRf4rAORo7hPnhM3VG6KpbvmoOfvvFkESPhrslch/+JKe
	 YULZQQlrr4Fm+HiYryFu8WFlpnq3ucGao9Q1AK70JsEpBx5KFnsa7OVcIs2W4CM6uG
	 R4wSCrg7ns2GNpon8bLGe4P0liuIcljZ1SOFbeMk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390083AbgEMSUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:20:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:37288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732845AbgEMSUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:20:30 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88456205ED;
        Wed, 13 May 2020 18:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589394030;
        bh=wbAs4tHZl1UycvGcreBgD9ZPdNkWCmGB3prveLz95SQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=BrZvmDXtOMuBK6Lb6db0iRxczHBrn6waknh/4BDCiTAQPFIHpIg8owhXQpvaIpTU0
         VX4RDuDczmKgYM43LxnH6wN4zPq1tO5FgQAPmA/zLQpxf1v5e2BrS7CiLEZ2vy6VaS
         hALI1cyteYIRlycLtIZg79Iq+0GKpVUq86xMDCAM=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id AAC1A352352C; Wed, 13 May 2020 11:20:29 -0700 (PDT)
Date:   Wed, 13 May 2020 11:20:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 04/10] rcu: Implement rcu_segcblist_is_offloaded() config
 dependent
Message-ID: <20200513182029.GT2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-5-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513164714.22557-5-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:47:08PM +0200, Frederic Weisbecker wrote:
> This simplify the usage of this API and avoid checking the kernel
> config from the callers.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  include/linux/rcu_segcblist.h |  2 ++
>  kernel/rcu/rcu_segcblist.c    |  2 ++
>  kernel/rcu/rcu_segcblist.h    |  6 ++++++
>  kernel/rcu/tree.c             | 21 +++++++--------------
>  4 files changed, 17 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
> index b36afe7b22c9..0ced0a0ecbcf 100644
> --- a/include/linux/rcu_segcblist.h
> +++ b/include/linux/rcu_segcblist.h
> @@ -73,7 +73,9 @@ struct rcu_segcblist {
>  	long len;
>  #endif
>  	u8 enabled;
> +#ifdef CONFIG_RCU_NOCB_CPU
>  	u8 offloaded;
> +#endif

Given that this is only one byte and that removing it won't actually
save any memory on most architectures, why not just leave it and
adjust as shown below?

>  };
>  
>  #define RCU_SEGCBLIST_INITIALIZER(n) \
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index 9a0f66133b4b..d8ea2bef5574 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -166,6 +166,7 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
>  	rsclp->enabled = 0;
>  }
>  
> +#ifdef CONFIG_RCU_NOCB_CPU
>  /*
>   * Mark the specified rcu_segcblist structure as offloaded.  This
>   * structure must be empty.
> @@ -174,6 +175,7 @@ void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
>  {
>  	rsclp->offloaded = 1;
>  }
> +#endif

Leave this unconditional, as it is nowhere near a fastpath.

>  /*
>   * Does the specified rcu_segcblist structure contain callbacks that
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index 5c293afc07b8..4c1503a82492 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -62,7 +62,11 @@ static inline bool rcu_segcblist_is_enabled(struct rcu_segcblist *rsclp)
>  /* Is the specified rcu_segcblist offloaded?  */
>  static inline bool rcu_segcblist_is_offloaded(struct rcu_segcblist *rsclp)
>  {
> +#ifdef CONFIG_RCU_NOCB_CPU
>  	return rsclp->offloaded;
> +#else
> +	return false;
> +#endif
>  }

Then this can just be:

	return IS_ENABLED(CONFIG_RCU_NOCB_CPU) && rsclp->offloaded;

>  /*
> @@ -78,7 +82,9 @@ static inline bool rcu_segcblist_restempty(struct rcu_segcblist *rsclp, int seg)
>  void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
>  void rcu_segcblist_init(struct rcu_segcblist *rsclp);
>  void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
> +#ifdef CONFIG_RCU_NOCB_CPU
>  void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
> +#endif

This can then remain unconditional.

>  bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp);
>  bool rcu_segcblist_pend_cbs(struct rcu_segcblist *rsclp);
>  struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index d9a49cd6065a..804cf7dfff03 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1401,8 +1401,7 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
>  {
>  	bool ret = false;
>  	bool need_qs;
> -	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> -			       rcu_segcblist_is_offloaded(&rdp->cblist);
> +	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);

The adjustment to rcu_segcblist_is_offloaded() allows this (welcome!)
simplification to remain.

>  	raw_lockdep_assert_held_rcu_node(rnp);
>  
> @@ -1790,8 +1789,7 @@ static void rcu_gp_cleanup(void)
>  		needgp = true;
>  	}
>  	/* Advance CBs to reduce false positives below. */
> -	offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> -		    rcu_segcblist_is_offloaded(&rdp->cblist);
> +	offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);

And here as well.

>  	if ((offloaded || !rcu_accelerate_cbs(rnp, rdp)) && needgp) {
>  		WRITE_ONCE(rcu_state.gp_flags, RCU_GP_FLAG_INIT);
>  		WRITE_ONCE(rcu_state.gp_req_activity, jiffies);
> @@ -1985,8 +1983,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
>  	unsigned long flags;
>  	unsigned long mask;
>  	bool needwake = false;
> -	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> -			       rcu_segcblist_is_offloaded(&rdp->cblist);
> +	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);

Ditto.

>  	struct rcu_node *rnp;
>  
>  	rnp = rdp->mynode;
> @@ -2153,8 +2150,7 @@ int rcutree_dead_cpu(unsigned int cpu)
>  static void rcu_do_batch(struct rcu_data *rdp)
>  {
>  	unsigned long flags;
> -	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> -			       rcu_segcblist_is_offloaded(&rdp->cblist);
> +	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);

Ditto.

>  	struct rcu_head *rhp;
>  	struct rcu_cblist rcl = RCU_CBLIST_INITIALIZER(rcl);
>  	long bl, count;
> @@ -2397,8 +2393,7 @@ static __latent_entropy void rcu_core(void)
>  	unsigned long flags;
>  	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
>  	struct rcu_node *rnp = rdp->mynode;
> -	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> -			       rcu_segcblist_is_offloaded(&rdp->cblist);
> +	const bool offloaded = rcu_segcblist_is_offloaded(&rdp->cblist);

Ditto.

>  
>  	if (cpu_is_offline(smp_processor_id()))
>  		return;
> @@ -2695,8 +2690,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
>  				   rcu_segcblist_n_cbs(&rdp->cblist));
>  
>  	/* Go handle any RCU core processing required. */
> -	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
> -	    unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {
> +	if (unlikely(rcu_segcblist_is_offloaded(&rdp->cblist))) {

Ditto.

>  		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
>  	} else {
>  		__call_rcu_core(rdp, head, flags);
> @@ -3243,8 +3237,7 @@ static int rcu_pending(int user)
>  
>  	/* Has RCU gone idle with this CPU needing another grace period? */
>  	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
> -	    (!IS_ENABLED(CONFIG_RCU_NOCB_CPU) ||
> -	     !rcu_segcblist_is_offloaded(&rdp->cblist)) &&
> +	    !rcu_segcblist_is_offloaded(&rdp->cblist) &&

Ditto.

As in "Why didn't I do it that way to start with???"  ;-)

							Thanx, Paul

>  	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
>  		return 1;
>  
> -- 
> 2.25.0
> 
