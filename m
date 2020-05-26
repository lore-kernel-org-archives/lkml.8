Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28ED1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E90BF20721
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:20:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="EBk/RQJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403934AbgEZVUT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403878AbgEZVUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:20:19 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA0FC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:20:19 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id ee19so10190129qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oNiXx/Rst2bunWP0qymph4x84pXDap/krcw7ycWwhWk=;
        b=EBk/RQJGWYC8b63gyMqJY+MkwQZiCc4OjA+jttHYX+gh4UxXZxCiaztlTt9i3g56bE
         EQPu6KcePO3fTR8qLPWENocXTFuNwGkuSCgMqNxlslGifFhUafi5DGek6gH7iYPro2AR
         3vRUqVZ0fHFLsZaxmS7Xh6WpRPagu+Dmv1JOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oNiXx/Rst2bunWP0qymph4x84pXDap/krcw7ycWwhWk=;
        b=hZJ4A7QdDtXELWjV1wXN7WmU1bH0CrbeoWuEGjkcgMxtDvBXpfw5Ka+/mbU8nYiFM5
         jZbhSiwWzi3D9p6EC4OtjgZFgUV/efWdZkl5Ga2mO6DyJ0UfhiZXNl6ba3tzgOwBG27N
         QGqhLEzrkg3RqruTU5C4C/cb/G2bnrB5YuMpAeYuoRNNOTcWWFgRiPfjx7WPbQeKrWeA
         9CKCbZ1rtp2BrZe1fbsxLncEvjS6HuVwPPh8cBP40sMlZwtx99E2jwR5sGNT4Ee1q2Da
         H95hV6oM+JJiAkVhv4/fXod8iN11XDcF0Jkra5NWyjf9e7jS5t4xwgsgMQOq5PvIOPOr
         Omtg==
X-Gm-Message-State: AOAM5307F/C/8gzrCEyYcZZXGYznml1GASWiA17XlD1RXTdM0vNXWdIi
        qRBK/zQ+3K4VY+AWZXFIlq231g==
X-Google-Smtp-Source: ABdhPJxaxaXchBngkG6fCeyv0NZ+oKalaZg4xCFyVEK0Od1epL9XdYEmgGjQoP9Z5S0eZhGTrvCpIg==
X-Received: by 2002:a05:6214:14a2:: with SMTP id bo2mr22149222qvb.106.1590528018306;
        Tue, 26 May 2020 14:20:18 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v4sm671977qkv.43.2020.05.26.14.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 14:20:17 -0700 (PDT)
Date:   Tue, 26 May 2020 17:20:17 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 08/10] rcu: Allow to deactivate nocb on a CPU
Message-ID: <20200526212017.GE76276@google.com>
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-9-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513164714.22557-9-frederic@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:47:12PM +0200, Frederic Weisbecker wrote:
> Allow a CPU's rdp to quit the callback offlined mode.

nit: s/offlined/offloaded/ ?

> The switch happens on the target with IRQs disabled and rdp->nocb_lock
> held to avoid races between local callbacks handling and kthread
> offloaded callbacks handling.
> nocb_cb kthread is first parked to avoid any future race with
> concurrent rcu_do_batch() executions. Then the cblist is set to offloaded
> so that the nocb_gp kthread ignores this rdp.

nit: you mean cblist is set to non-offloaded mode right?

Also, could you clarify better the rcu_barrier bits in the changelog. I know
there's some issue if the cblist has both offloaded and non-offloaded
callbacks, but it would be good to clarify this here better IMHO.

[...]
> diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> index d8ea2bef5574..4bed48da7702 100644
> --- a/kernel/rcu/rcu_segcblist.c
> +++ b/kernel/rcu/rcu_segcblist.c
> @@ -171,9 +171,9 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp)
>   * Mark the specified rcu_segcblist structure as offloaded.  This
>   * structure must be empty.
>   */
> -void rcu_segcblist_offload(struct rcu_segcblist *rsclp)
> +void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload)
>  {
> -	rsclp->offloaded = 1;
> +	rsclp->offloaded = offload;
>  }
>  #endif
>  
> diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> index 4c1503a82492..8f7c6c34cb1b 100644
> --- a/kernel/rcu/rcu_segcblist.h
> +++ b/kernel/rcu/rcu_segcblist.h
> @@ -83,7 +83,7 @@ void rcu_segcblist_inc_len(struct rcu_segcblist *rsclp);
>  void rcu_segcblist_init(struct rcu_segcblist *rsclp);
>  void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
>  #ifdef CONFIG_RCU_NOCB_CPU
> -void rcu_segcblist_offload(struct rcu_segcblist *rsclp);
> +void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload);
>  #endif
>  bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp);
>  bool rcu_segcblist_pend_cbs(struct rcu_segcblist *rsclp);
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index f19e81e0c691..c74a4df8d5f2 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -1943,6 +1943,10 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  	for (rdp = my_rdp; rdp; rdp = rdp->nocb_next_cb_rdp) {
>  		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
>  		raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> +		if (!rcu_segcblist_is_offloaded(&rdp->cblist)) {
> +			raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> +			continue;
> +		}
>  		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
>  		if (bypass_ncbs &&
>  		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
> @@ -2176,6 +2180,50 @@ static void do_nocb_deferred_wakeup(struct rcu_data *rdp)
>  		do_nocb_deferred_wakeup_common(rdp);
>  }
>  
> +static void __rcu_nocb_rdp_deoffload(struct rcu_data *rdp)
> +{
> +	unsigned long flags;
> +	struct rcu_node *rnp = rdp->mynode;
> +
> +	printk("De-offloading %d\n", rdp->cpu);

nit: s/printk/pr_debug/ ?

thanks,

 - Joel

> +	kthread_park(rdp->nocb_cb_kthread);
> +
> +	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> +	rcu_nocb_flush_bypass(rdp, NULL, jiffies);
> +	raw_spin_lock_rcu_node(rnp);
> +	rcu_segcblist_offload(&rdp->cblist, false);
> +	raw_spin_unlock_rcu_node(rnp);
> +	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> +}
> +
> +static long rcu_nocb_rdp_deoffload(void *arg)
> +{
> +	struct rcu_data *rdp = arg;
> +
> +	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
> +	__rcu_nocb_rdp_deoffload(rdp);
> +
> +	return 0;
> +}
> +
> +void rcu_nocb_cpu_deoffload(int cpu)
> +{
> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> +
> +	mutex_lock(&rcu_state.barrier_mutex);
> +	cpus_read_lock();
> +	if (rcu_segcblist_is_offloaded(&rdp->cblist)) {
> +		if (cpu_online(cpu)) {
> +			work_on_cpu(cpu, rcu_nocb_rdp_deoffload, rdp);
> +		} else {
> +			__rcu_nocb_rdp_deoffload(rdp);
> +		}
> +		cpumask_clear_cpu(cpu, rcu_nocb_mask);
> +	}
> +	cpus_read_unlock();
> +	mutex_unlock(&rcu_state.barrier_mutex);
> +}
> +
>  void __init rcu_init_nohz(void)
>  {
>  	int cpu;
> @@ -2218,7 +2266,7 @@ void __init rcu_init_nohz(void)
>  		rdp = per_cpu_ptr(&rcu_data, cpu);
>  		if (rcu_segcblist_empty(&rdp->cblist))
>  			rcu_segcblist_init(&rdp->cblist);
> -		rcu_segcblist_offload(&rdp->cblist);
> +		rcu_segcblist_offload(&rdp->cblist, true);
>  	}
>  	rcu_organize_nocb_kthreads();
>  }
> -- 
> 2.25.0
> 
