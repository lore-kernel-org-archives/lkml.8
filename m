Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DE8C34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B07BE21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582012544;
	bh=fj5RUzJmMIJH3SsuKj7SzywH9sWCRMRrLHPA3kXBFMU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=rmcEonppONnf2ZBFronVQ11fRfeBWeZFSW1Hp6vcBFIsK8M0iEAy7zAz/Y9e+amni
	 KdFdXEtZO+YrWw+2Nb/aQmVFaFBRl4yt9z27LiuuGIqC7ALqbz/OEj2mvvhr4STeoy
	 W7YmfWo9cLuUekAKPaTAQIgbVPenO3JTOeHgG4ZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgBRHze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:55:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:47100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgBRHze (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:55:34 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C89E72176D;
        Tue, 18 Feb 2020 07:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582012533;
        bh=fj5RUzJmMIJH3SsuKj7SzywH9sWCRMRrLHPA3kXBFMU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fsT6nsp9Ralp/l5S7MVGxllSKxpXsjtwQbz3OqDgJLKv1Gv6zZKHHQxGpOMUW1xMz
         r/QWyAgMFgxWjcd7zih/m2eC2AA9hKqVfYxwdnmXAxQoYSPenqzLSRMnqZM/BnKcTj
         ZCu696tANZ81lsqoXtoS23E2myC5bZPpIqyPtaG4=
Date:   Tue, 18 Feb 2020 16:55:29 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Luigi Rizzo <lrizzo@google.com>
Cc:     linux-kernel@vger.kernel.org, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3] kretprobe: percpu support
Message-Id: <20200218165529.39e761c4be828285cc060279@kernel.org>
In-Reply-To: <20200218005659.91318-1-lrizzo@google.com>
References: <20200218005659.91318-1-lrizzo@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luigi,

On Mon, 17 Feb 2020 16:56:59 -0800
Luigi Rizzo <lrizzo@google.com> wrote:

> kretprobe uses a list protected by a single lock to allocate a
> kretprobe_instance in pre_handler_kretprobe(). This works poorly with
> concurrent calls.

Yes, there are several potential performance issue and the recycle
instance is one of them. However, I think this spinlock is not so racy,
but noisy (especially on many core machine) right?

Racy lock is the kretprobe_hash_lock(), I would like to replace it
with ftrace's per-task shadow stack. But that will be available
only if CONFIG_FUNCTION_GRAPH_TRACER=y (and instance has no own
payload).

> This patch offers a simplified fix: the percpu_instance flag indicates
> that we allocate one instance per CPU, and the allocation is contention
> free, but we allow only have one pending entry per CPU (this could be
> extended to a small constant number without much trouble).

OK, the percpu instance idea is good to me, and I think it should be
default option. Unless user specifies the number of instances, it should
choose percpu instance by default.
Moreover, this makes things a bit complicated, can you add per-cpu
instance array? If it is there, we can remove the old recycle rp insn
code.

> 
> Signed-off-by: Luigi Rizzo <lrizzo@google.com>
> ---
>  include/linux/kprobes.h | 10 ++++++++--
>  kernel/kprobes.c        | 41 +++++++++++++++++++++++++++++++++++++++++
>  kernel/test_kprobes.c   | 18 +++++++++++++-----
>  3 files changed, 62 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 04bdaf01112cb..5c549d6a599b9 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -142,7 +142,8 @@ static inline int kprobe_ftrace(struct kprobe *p)
>   * can be active concurrently.
>   * nmissed - tracks the number of times the probed function's return was
>   * ignored, due to maxactive being too low.
> - *
> + * percpu_instance - if set, uses one instance per cpu instead of allocating
> + * from the list protected by lock.
>   */
>  struct kretprobe {
>  	struct kprobe kp;
> @@ -151,8 +152,13 @@ struct kretprobe {
>  	int maxactive;
>  	int nmissed;
>  	size_t data_size;
> -	struct hlist_head free_instances;
> +	union {
> +		struct kretprobe_instance __percpu *pcpu;
> +		struct hlist_head free_instances;
> +	};
>  	raw_spinlock_t lock;
> +	u32 percpu_instance:1;
> +	u32 unused:31;

Please use a bool for the flag.

>  };
>  
>  struct kretprobe_instance {
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 2625c241ac00f..12ca682083ffc 100644
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
> @@ -1874,6 +1883,27 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  
>  	/* TODO: consider to only swap the RA after the last pre_handler fired */
>  	hash = hash_ptr(current, KPROBE_HASH_BITS);

Hmm, this hash calculation position is also not optimized.
This should be done right before kretprobe_table_lock().

> +	if (rp->percpu_instance) {
> +		unsigned long flags;

We already have flags, right?

> +
> +		local_irq_save(flags);
> +		ri = this_cpu_ptr(rp->pcpu);
> +		if (!ri || ri->rp) { /* already in use */
> +			local_irq_restore(flags);
> +			rp->nmissed++;
> +			return 0;
> +		}
> +		INIT_HLIST_NODE(&ri->hlist);
> +		ri->rp = rp;
> +		ri->task = current;
> +		local_irq_restore(flags);
> +
> +		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
> +			ri->rp = NULL;	/* failed */
> +			return 0;
> +		}
> +		goto good;

Can't you make a new helper function for finding new free instance?
(note: don't forget to make it NOKPROBE)
What I would like to see is;

ri = get_free_rp_instance(rp);	/* If !ri, increment rp->nmissed */
if (ri) {
 	arch_prepare_kretprobe(ri, regs);
	...
}

> +	}
>  	raw_spin_lock_irqsave(&rp->lock, flags);
>  	if (!hlist_empty(&rp->free_instances)) {
>  		ri = hlist_entry(rp->free_instances.first,
> @@ -1891,6 +1921,7 @@ static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  			return 0;
>  		}
>  
> +good:
>  		arch_prepare_kretprobe(ri, regs);
>  
>  		/* XXX(hch): why is there no hlist_move_head? */
> @@ -1950,6 +1981,15 @@ int register_kretprobe(struct kretprobe *rp)
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

Above new code should be here, and set rp->percpu_instance = true. 

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
