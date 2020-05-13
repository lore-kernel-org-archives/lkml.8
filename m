Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 854F7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27F1F205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 18:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589395281;
	bh=PeSVtBIAak8lYcAcQlkkBe2XTZFuiLIatdQDbrViano=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=lkYvCXU4oqhxMaw1J9fLtVGGjnWLwgPZ4p3zHj9K+9edqGQPE1HSgj6QEEuJGasRR
	 p+zIUJLKhMutMp/zjY/T5R6qW/0Z+VUOeknGAFjYCfOLKxc5hLxKdVsE6C0mayoun6
	 +okx4raPizGEE2OQyXzOnoLghGtM1XY75J8wliLk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbgEMSlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 14:41:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732825AbgEMSlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:41:19 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14F8C205CB;
        Wed, 13 May 2020 18:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589395279;
        bh=PeSVtBIAak8lYcAcQlkkBe2XTZFuiLIatdQDbrViano=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IdOlb1aspHlXI4U9vAYTo+/9E4chBGWCKMP4pBJna7HBJQsqc/HEduuIq2yOD0PHX
         s8wzFWe+I03cUDdl/CP/p4+03fJ5vck5IFov2ZcWC/HAOu2QDrmHANaWsz91NRVS+B
         IDm8g0ayqOVsrHZvMxdZ2Qbe/ZRNXCglRnmoqa0o=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 08BDF352352C; Wed, 13 May 2020 11:41:18 -0700 (PDT)
Date:   Wed, 13 May 2020 11:41:18 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>
Subject: Re: [PATCH 09/10] rcu: Allow to re-offload a CPU that used to be nocb
Message-ID: <20200513184117.GW2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200513164714.22557-1-frederic@kernel.org>
 <20200513164714.22557-10-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513164714.22557-10-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 06:47:13PM +0200, Frederic Weisbecker wrote:
> This is essentially the reverse operation of de-offloading. For now it's
> only supported on CPUs that used to be offloaded and therefore still have
> the relevant nocb_cb/nocb_gp kthreads around.

And I still believe that this is a good restriction to put in place,
especially to start with.  ;-)

> Inspired-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> ---
>  include/linux/rcupdate.h |  2 ++
>  kernel/rcu/tree_plugin.h | 44 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 46 insertions(+)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 1d3a4c37c3c1..ee95e49d675f 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -96,9 +96,11 @@ static inline void rcu_user_exit(void) { }
>  
>  #ifdef CONFIG_RCU_NOCB_CPU
>  void rcu_init_nohz(void);
> +void rcu_nocb_cpu_offload(int cpu);
>  void rcu_nocb_cpu_deoffload(int cpu);
>  #else /* #ifdef CONFIG_RCU_NOCB_CPU */
>  static inline void rcu_init_nohz(void) { }
> +static inline void rcu_nocb_cpu_offload(int cpu) { }
>  static inline void rcu_nocb_cpu_deoffload(int cpu) { }
>  #endif /* #else #ifdef CONFIG_RCU_NOCB_CPU */
>  
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index c74a4df8d5f2..ae4b5e9f2fc5 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -2224,6 +2224,50 @@ void rcu_nocb_cpu_deoffload(int cpu)
>  	mutex_unlock(&rcu_state.barrier_mutex);
>  }
>  
> +static void __rcu_nocb_rdp_offload(struct rcu_data *rdp)
> +{
> +	unsigned long flags;
> +	struct rcu_node *rnp = rdp->mynode;
> +
> +	printk("Offloading %d\n", rdp->cpu);
> +
> +	raw_spin_lock_irqsave(&rdp->nocb_lock, flags);
> +	raw_spin_lock_rcu_node(rnp);
> +	rcu_segcblist_offload(&rdp->cblist, true);
> +	raw_spin_unlock_rcu_node(rnp);
> +	raw_spin_unlock_irqrestore(&rdp->nocb_lock, flags);
> +
> +	kthread_unpark(rdp->nocb_cb_kthread);

And of course I have a similar set of questions here regarding
interruption of callback invocation.  ;-)

							Thanx, Paul

> +}
> +
> +static long rcu_nocb_rdp_offload(void *arg)
> +{
> +	struct rcu_data *rdp = arg;
> +
> +	WARN_ON_ONCE(rdp->cpu != raw_smp_processor_id());
> +	__rcu_nocb_rdp_offload(rdp);
> +
> +	return 0;
> +}
> +
> +void rcu_nocb_cpu_offload(int cpu)
> +{
> +	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
> +
> +	mutex_lock(&rcu_state.barrier_mutex);
> +	cpus_read_lock();
> +	if (!rcu_segcblist_is_offloaded(&rdp->cblist) && rdp->nocb_cb_kthread) {
> +		if (cpu_online(cpu)) {
> +			work_on_cpu(cpu, rcu_nocb_rdp_offload, rdp);
> +		} else {
> +			__rcu_nocb_rdp_offload(rdp);
> +		}
> +		cpumask_set_cpu(cpu, rcu_nocb_mask);
> +	}
> +	cpus_read_unlock();
> +	mutex_unlock(&rcu_state.barrier_mutex);
> +}
> +
>  void __init rcu_init_nohz(void)
>  {
>  	int cpu;
> -- 
> 2.25.0
> 
