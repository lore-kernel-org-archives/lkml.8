Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39543C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0627A2146E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 06:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583390567;
	bh=3YdXoq6Ec8FspaUzhGgoHT2fxwCJoIlII0wK1m4Yv4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FtDjCIP0emOQqoGGd3kFx9S4uxE7GbJ04yd01Tq0Gr3qDQ8zb2AZ1hUGL4N59u0OJ
	 lYl6cKodqu61QPfrbc5+RdLgec8JALNkAgvfzArJlqEyBnqWd/hLXVM3ZP81ZjIt2G
	 zBydEiOlkLrwcon4saH1cizxEatOUe8trHUH6YBA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgCEGmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 01:42:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:43358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgCEGmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 01:42:45 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A96E208CD;
        Thu,  5 Mar 2020 06:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583390563;
        bh=3YdXoq6Ec8FspaUzhGgoHT2fxwCJoIlII0wK1m4Yv4U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NAdw4Iafb1sn7Sy5acXiv/iq5PWTnuquHGL7SnUFAnbzcOCKW3tlPKKTnwdZxXbyj
         2wjBWiq5RQ4JwRXuckx54KzBb4FluLGpO67e/QTu07QzvMJrWg0iEeT3dgkuqrIc60
         RxXRdsa/SRw1xaMOmHzt6G6m2LMobpGa8B5hM3Cg=
Date:   Thu, 5 Mar 2020 15:42:40 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     linux-kernel@vger.kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, rizzo@iet.unipi.it
Subject: Re: [PATCH v4] kretprobe: percpu support
Message-Id: <20200305154240.91406117aebe1f72103e5a9b@kernel.org>
In-Reply-To: <20200221211657.147250-1-lrizzo@google.com>
References: <20200221211657.147250-1-lrizzo@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luigi,

On Fri, 21 Feb 2020 13:16:57 -0800
Luigi Rizzo <lrizzo@google.com> wrote:

> kretprobe uses a list protected by a single lock to allocate a
> kretprobe_instance in pre_handler_kretprobe(). This works poorly with
> concurrent calls.
> 
> This patch offers a simplified fix: the percpu_instance flag indicates
> that kretprobe_instance's are per CPU, which makes allocation lock free.

I concern that your new percpu_instance flag silently hides the
maxactive parameter. At least we should return an error if maxactive
is some positive value but percpu_instance is true. Or, define
KRETPROBE_PERCPU_MAXACTIVE (< 0) and use it instead of new bool flag. 

> As part of this patch, we factor out the code to allocate instances in
> get_pcpu_rp_instance() and get_rp_instance().
> 
> At the moment we only allow one pending kretprobe per CPU. This can be
> extended to a small constant number of entries, but finding a free entry
> would either bring back the lock, or require scanning an array, which can
> be expensive (especially if callers block and migrate).

I think if you disables irq while scanning an array (that should be
a small array), you don't need to afraid of such racing (maybe we need
a pair of memory barriers).

Anyway, my concern is about introducing a new knob which conflict with
another knob. Implementation is good to me.

Thank you,


> 
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> ---
>  include/linux/kprobes.h |   8 +++-
>  kernel/kprobes.c        | 102 +++++++++++++++++++++++++++++++---------
>  kernel/test_kprobes.c   |  20 ++++++--
>  3 files changed, 101 insertions(+), 29 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 04bdaf01112cb..c5894f4c5c26c 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -142,6 +142,8 @@ static inline int kprobe_ftrace(struct kprobe *p)
>   * can be active concurrently.
>   * nmissed - tracks the number of times the probed function's return was
>   * ignored, due to maxactive being too low.
> + * percpu_instance - if set, uses one instance per cpu instead of allocating
> + * from the list protected by lock.
>   *
>   */
>  struct kretprobe {
> @@ -151,8 +153,12 @@ struct kretprobe {
>  	int maxactive;
>  	int nmissed;
>  	size_t data_size;
> -	struct hlist_head free_instances;
> +	union {
> +		struct kretprobe_instance __percpu *pcpu;
> +		struct hlist_head free_instances;
> +	};
>  	raw_spinlock_t lock;
> +	bool percpu_instance;
>  };
>  
>  struct kretprobe_instance {
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 2625c241ac00f..46018a4a76178 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1184,6 +1184,10 @@ void recycle_rp_inst(struct kretprobe_instance *ri,
>  	hlist_del(&ri->hlist);
>  	INIT_HLIST_NODE(&ri->hlist);
>  	if (likely(rp)) {
> +		if (rp->percpu_instance) {
> +			ri->rp = NULL;
> +			return;
> +		}
>  		raw_spin_lock(&rp->lock);
>  		hlist_add_head(&ri->hlist, &rp->free_instances);
>  		raw_spin_unlock(&rp->lock);
> @@ -1274,6 +1278,11 @@ static inline void free_rp_inst(struct kretprobe *rp)
>  	struct kretprobe_instance *ri;
>  	struct hlist_node *next;
>  
> +	if (rp->percpu_instance) {
> +		free_percpu(rp->pcpu);
> +		return;
> +	}
> +
>  	hlist_for_each_entry_safe(ri, next, &rp->free_instances, hlist) {
>  		hlist_del(&ri->hlist);
>  		kfree(ri);
> @@ -1851,6 +1860,46 @@ unsigned long __weak arch_deref_entry_point(void *entry)
>  }
>  
>  #ifdef CONFIG_KRETPROBES
> +struct kretprobe_instance *get_pcpu_rp_instance(struct kretprobe *rp)
> +{
> +	struct kretprobe_instance *ri;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	ri = this_cpu_ptr(rp->pcpu);
> +	if (!ri || ri->rp) { /* already in use */
> +		local_irq_restore(flags);
> +		rp->nmissed++;
> +		return NULL;
> +	}
> +	INIT_HLIST_NODE(&ri->hlist);
> +	ri->rp = rp;
> +	ri->task = current;
> +	local_irq_restore(flags);
> +	return ri;
> +}
> +
> +struct kretprobe_instance *get_rp_instance(struct kretprobe *rp)
> +{
> +	struct kretprobe_instance *ri;
> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&rp->lock, flags);
> +	if (hlist_empty(&rp->free_instances)) {
> +		rp->nmissed++;
> +		raw_spin_unlock_irqrestore(&rp->lock, flags);
> +		return NULL;
> +	}
> +	ri = hlist_entry(rp->free_instances.first, struct kretprobe_instance,
> +			 hlist);
> +	hlist_del(&ri->hlist);
> +	raw_spin_unlock_irqrestore(&rp->lock, flags);
> +
> +	ri->rp = rp;
> +	ri->task = current;
> +	return ri;
> +}
> +
>  /*
>   * This kprobe pre_handler is registered with every kretprobe. When probe
>   * hits it will set up the return probe.
> @@ -1873,35 +1922,32 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  	}
>  
>  	/* TODO: consider to only swap the RA after the last pre_handler fired */
> -	hash = hash_ptr(current, KPROBE_HASH_BITS);
> -	raw_spin_lock_irqsave(&rp->lock, flags);
> -	if (!hlist_empty(&rp->free_instances)) {
> -		ri = hlist_entry(rp->free_instances.first,
> -				struct kretprobe_instance, hlist);
> -		hlist_del(&ri->hlist);
> -		raw_spin_unlock_irqrestore(&rp->lock, flags);
> -
> -		ri->rp = rp;
> -		ri->task = current;
> -
> -		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
> +	if (rp->percpu_instance) {
> +		ri = get_pcpu_rp_instance(rp);
> +	} else {
> +		ri = get_rp_instance(rp);
> +	}
> +	if (!ri)
> +		return 0;
> +	if (rp->entry_handler && rp->entry_handler(ri, regs)) {
> +		if (rp->percpu_instance) {
> +			ri->rp = NULL;
> +		} else {
>  			raw_spin_lock_irqsave(&rp->lock, flags);
>  			hlist_add_head(&ri->hlist, &rp->free_instances);
>  			raw_spin_unlock_irqrestore(&rp->lock, flags);
> -			return 0;
>  		}
> +		return 0;
> +	}
> +	arch_prepare_kretprobe(ri, regs);
>  
> -		arch_prepare_kretprobe(ri, regs);
> +	/* XXX(hch): why is there no hlist_move_head? */
> +	INIT_HLIST_NODE(&ri->hlist);
> +	hash = hash_ptr(current, KPROBE_HASH_BITS);
> +	kretprobe_table_lock(hash, &flags);
> +	hlist_add_head(&ri->hlist, &kretprobe_inst_table[hash]);
> +	kretprobe_table_unlock(hash, &flags);
>  
> -		/* XXX(hch): why is there no hlist_move_head? */
> -		INIT_HLIST_NODE(&ri->hlist);
> -		kretprobe_table_lock(hash, &flags);
> -		hlist_add_head(&ri->hlist, &kretprobe_inst_table[hash]);
> -		kretprobe_table_unlock(hash, &flags);
> -	} else {
> -		rp->nmissed++;
> -		raw_spin_unlock_irqrestore(&rp->lock, flags);
> -	}
>  	return 0;
>  }
>  NOKPROBE_SYMBOL(pre_handler_kretprobe);
> @@ -1950,6 +1996,15 @@ int register_kretprobe(struct kretprobe *rp)
>  	rp->kp.post_handler = NULL;
>  	rp->kp.fault_handler = NULL;
>  
> +	if (rp->percpu_instance) {
> +		rp->pcpu = __alloc_percpu(sizeof(*rp->pcpu) + rp->data_size,
> +					  __alignof__(*rp->pcpu));
> +		if (rp->pcpu)
> +			goto finalize;
> +		free_rp_inst(rp);
> +		return -ENOMEM;
> +	}
> +
>  	/* Pre-allocate memory for max kretprobe instances */
>  	if (rp->maxactive <= 0) {
>  #ifdef CONFIG_PREEMPTION
> @@ -1971,6 +2026,7 @@ int register_kretprobe(struct kretprobe *rp)
>  		hlist_add_head(&inst->hlist, &rp->free_instances);
>  	}
>  
> +finalize:
>  	rp->nmissed = 0;
>  	/* Establish function entry probe point */
>  	ret = register_kprobe(&rp->kp);
> diff --git a/kernel/test_kprobes.c b/kernel/test_kprobes.c
> index 76c997fdbc9da..4ebe48301d743 100644
> --- a/kernel/test_kprobes.c
> +++ b/kernel/test_kprobes.c
> @@ -236,31 +236,36 @@ static struct kretprobe rp2 = {
>  	.kp.symbol_name = "kprobe_target2"
>  };
>  
> -static int test_kretprobes(void)
> +static int test_kretprobes(bool percpu_instance)
>  {
>  	int ret;
>  	struct kretprobe *rps[2] = {&rp, &rp2};
> +	const char *mode = percpu_instance ? "percpu " : "normal";
>  
>  	/* addr and flags should be cleard for reusing kprobe. */
>  	rp.kp.addr = NULL;
>  	rp.kp.flags = 0;
> +	rp.percpu_instance = percpu_instance;
> +	rp2.kp.addr = NULL;
> +	rp2.kp.flags = 0;
> +	rp2.percpu_instance = percpu_instance;
>  	ret = register_kretprobes(rps, 2);
>  	if (ret < 0) {
> -		pr_err("register_kretprobe returned %d\n", ret);
> +		pr_err("register_kretprobe mode %s returned %d\n", mode, ret);
>  		return ret;
>  	}
>  
>  	krph_val = 0;
>  	ret = target(rand1);
>  	if (krph_val != rand1) {
> -		pr_err("kretprobe handler not called\n");
> +		pr_err("kretprobe handler mode %s not called\n", mode);
>  		handler_errors++;
>  	}
>  
>  	krph_val = 0;
>  	ret = target2(rand1);
>  	if (krph_val != rand1) {
> -		pr_err("kretprobe handler2 not called\n");
> +		pr_err("kretprobe handler2 mode %s not called\n", mode);
>  		handler_errors++;
>  	}
>  	unregister_kretprobes(rps, 2);
> @@ -297,7 +302,12 @@ int init_test_probes(void)
>  		errors++;
>  
>  	num_tests++;
> -	ret = test_kretprobes();
> +	ret = test_kretprobes(false);
> +	if (ret < 0)
> +		errors++;
> +
> +	num_tests++;
> +	ret = test_kretprobes(true);
>  	if (ret < 0)
>  		errors++;
>  #endif /* CONFIG_KRETPROBES */
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
