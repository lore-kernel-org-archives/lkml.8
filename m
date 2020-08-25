Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A8EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB6C20639
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 13:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598361375;
	bh=au1UovlF6WY4xAqrvfcIx5wawYNh2WTQdz5mCtNoPV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=WJUTTWMb3LkVu2/vDc7u+Qv6tNBBZ7sOq4SCPZHduNcWyd+K6+x42NWQBOVxsRZlj
	 TpTWSFaBAbKBM0dIL8qDJmmnR0t3sjGb7YVovhP4UYdkZPiNiaGqIT7a6PCqHBEx2t
	 YtwS4FS91Z0CU+M4xN6NUz/opLT8vojROjx6WUbI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHYNQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 09:16:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:34376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYNQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 09:16:02 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4B7EE20639;
        Tue, 25 Aug 2020 13:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598361359;
        bh=au1UovlF6WY4xAqrvfcIx5wawYNh2WTQdz5mCtNoPV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wwXNsOeB09RnC/1edFDHGJKsP+gTrKBqoAAza1OQ4flMlDy6NZ52Gi5JA66VY41Sl
         /Tr+EpXKb+o7du9g8NUKp8WwLDgqDj1zeT2fBeqAQqNLfV3BmXnjEDMaR/HXDClm2d
         1Ya+oRQmicGEACZvkIdiC3iyRmgy3xnPJcRwNIps=
Date:   Tue, 25 Aug 2020 22:15:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     peterz@infradead.org
Cc:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-Id: <20200825221555.a2d72c9754284feced6a8536@kernel.org>
In-Reply-To: <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
        <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
        <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
        <20200825151538.f856d701a34f4e0561a64932@kernel.org>
        <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 14:09:11 +0200
peterz@infradead.org wrote:

> On Tue, Aug 25, 2020 at 03:15:38PM +0900, Masami Hiramatsu wrote:
> 
> > From 24390dffe6eb9a3e95f7d46a528a1dcfd716dc81 Mon Sep 17 00:00:00 2001
> > From: Masami Hiramatsu <mhiramat@kernel.org>
> > Date: Tue, 25 Aug 2020 01:37:00 +0900
> > Subject: [PATCH] kprobes/x86: Fixes NMI context check on x86
> > 
> > Since commit 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
> > made int3 as one of NMI, in_nmi() in kprobe handlers always returns !0.
> > Thus the kretprobe handlers always skipped the execution on x86 if it
> > is using int3. (CONFIG_KPROBES_ON_FTRACE=n and
> > echo 0 > /proc/sys/debug/kprobe_optimization)
> > 
> > To avoid this issue, introduce arch_kprobe_in_nmi() and check the
> > in_nmi() count is bigger than 1 << NMI_SHIFT on x86 if the handler
> > has been invoked from kprobe_int3_handler. By default, the
> > arch_kprobe_in_nmi() will be same as in_nmi().
> 
> So I still hate all of this, it feels like it's making a bad hack worse.
> 
> > Fixes: 0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()")
> 
> I think there's another problem, when you run this code with lockdep
> enabled it'll complain very loudly. Lockdep doesn't like using locks
> from NMI context much.
> 
> Can't we take one step back. Why are we taking locks from kprobe
> context? I was under the impression that kprobes were lockless (for good
> reasons), why does kretprobe need one? And can't we fix that?
> 
> Looking at the code it mucks about with with an hlist.
> 
> So on pre_handler is tries and take a kretprobe_instance from a list,
> and fails when there isn't one. This looks like per-task-per-retprobe
> data. Also, all of that is only returned when the task dies.
> 
> Surely we can do a lockless list for this. We have llist_add() and
> llist_del_first() to make a lockless LIFO/stack.

Ah, that's really nice!

> /me frobs code....
> 
> 
> Oooohh, another lock :-( kretprobe_table_lock
> 
> Bah bah bah, what a mess, surely we have a lockless hash-table
> somewhere? /me goes rummage around. Nope we don't.
> 
> Lightbulb!
> 
> That whole hash-table is nonsense, we don't need it. All it does is
> provide a per-task hlist. We can just stick a llist_head in task_struct
> itself and delete all that.

Yeah, at the first time kretprobe designed to not change the task struct,
but it seems odd restriction now. Per-task shadow stack should be implemented
as per-task.

> /me frobs more code...
> 
> argh, arch/ code uses this
> 
> 
> damn... one last problem is dangling instances.. so close.
> We can apparently unregister a kretprobe while there's still active
> kretprobe_instance's out referencing it.

Yeah, kretprobe already provided the per-instance data (as far as
I know, only systemtap depends on it). We need to provide it for
such users.
But if we only have one lock, we can avoid checking NMI because
we can check the recursion with trylock. It is needed only if the
kretprobe uses per-instance data. Or we can just pass a dummy
instance on the stack.

> 
> Ignoring that issue for the moment, the below seems to actually work.

OK, this looks good to me too.
I'll make a series to rewrite kretprobe based on this patch, OK?

Thanks,

> 
> ---
> Subject: kprobe: Rewrite kretprobe to not use locks
> 
> Use llist based atomic stack for rp->free_instances, and a llist based
> non-atomic stack for current->kretprobe_instances. The latter is only
> ever referenced from the task context and properly nests, so even if it
> gets interrupted, the interrupt should pop whatever it pushed on the
> stack before returning.
> 
> XXX unregister_kretprobe*() vs active instances is broken.
> XXX everything !x86 is broken
> 
> Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/kprobes/core.c      |  75 ++++++-------------
>  drivers/gpu/drm/i915/i915_request.c |   6 --
>  include/linux/kprobes.h             |   8 +-
>  include/linux/llist.h               |  15 ++++
>  include/linux/sched.h               |   4 +
>  kernel/fork.c                       |   4 +
>  kernel/kprobes.c                    | 145 +++++++++---------------------------
>  7 files changed, 87 insertions(+), 170 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 2ca10b770cff..311c26ef0fc2 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -772,14 +772,12 @@ STACK_FRAME_NON_STANDARD(kretprobe_trampoline);
>   */
>  __used __visible void *trampoline_handler(struct pt_regs *regs)
>  {
> -	struct kretprobe_instance *ri = NULL;
> -	struct hlist_head *head, empty_rp;
> -	struct hlist_node *tmp;
> -	unsigned long flags, orig_ret_address = 0;
>  	unsigned long trampoline_address = (unsigned long)&kretprobe_trampoline;
>  	kprobe_opcode_t *correct_ret_addr = NULL;
> +	struct kretprobe_instance *ri = NULL;
> +	struct llist_node *node, *first;
> +	unsigned long orig_ret_address;
>  	void *frame_pointer;
> -	bool skipped = false;
>  
>  	/*
>  	 * Set a dummy kprobe for avoiding kretprobe recursion.
> @@ -788,8 +786,6 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
>  	 */
>  	kprobe_busy_begin();
>  
> -	INIT_HLIST_HEAD(&empty_rp);
> -	kretprobe_hash_lock(current, &head, &flags);
>  	/* fixup registers */
>  	regs->cs = __KERNEL_CS;
>  #ifdef CONFIG_X86_32
> @@ -813,48 +809,37 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
>  	 *	 will be the real return address, and all the rest will
>  	 *	 point to kretprobe_trampoline.
>  	 */
> -	hlist_for_each_entry(ri, head, hlist) {
> -		if (ri->task != current)
> -			/* another task is sharing our hash bucket */
> -			continue;
> -		/*
> -		 * Return probes must be pushed on this hash list correct
> -		 * order (same as return order) so that it can be popped
> -		 * correctly. However, if we find it is pushed it incorrect
> -		 * order, this means we find a function which should not be
> -		 * probed, because the wrong order entry is pushed on the
> -		 * path of processing other kretprobe itself.
> -		 */
> -		if (ri->fp != frame_pointer) {
> -			if (!skipped)
> -				pr_warn("kretprobe is stacked incorrectly. Trying to fixup.\n");
> -			skipped = true;
> -			continue;
> -		}
>  
> -		orig_ret_address = (unsigned long)ri->ret_addr;
> -		if (skipped)
> -			pr_warn("%ps must be blacklisted because of incorrect kretprobe order\n",
> -				ri->rp->kp.addr);
> +	first = node = current->kretprobe_instances.first;
> +	while (node) {
> +		ri = container_of(node, struct kretprobe_instance, llist);
> +		node = node->next;
>  
> -		if (orig_ret_address != trampoline_address)
> +		BUG_ON(ri->fp != frame_pointer);
> +
> +		orig_ret_address = (unsigned long)ri->ret_addr;
> +		if (orig_ret_address != trampoline_address) {
>  			/*
>  			 * This is the real return address. Any other
>  			 * instances associated with this task are for
>  			 * other calls deeper on the call stack
>  			 */
>  			break;
> +		}
>  	}
>  
>  	kretprobe_assert(ri, orig_ret_address, trampoline_address);
> -
>  	correct_ret_addr = ri->ret_addr;
> -	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
> -		if (ri->task != current)
> -			/* another task is sharing our hash bucket */
> -			continue;
> -		if (ri->fp != frame_pointer)
> -			continue;
> +
> +	/*
> +	 * Per the above BUG_ON() we're guaranteed at least one ri.
> +	 *
> +	 * Delete all nodes for this frame_pointer.
> +	 */
> +	current->kretprobe_instances.first = node;
> +	while (first) {
> +		ri = container_of(first, struct kretprobe_instance, llist);
> +		node = first->next;
>  
>  		orig_ret_address = (unsigned long)ri->ret_addr;
>  		if (ri->rp && ri->rp->handler) {
> @@ -864,25 +849,13 @@ __used __visible void *trampoline_handler(struct pt_regs *regs)
>  			__this_cpu_write(current_kprobe, &kprobe_busy);
>  		}
>  
> -		recycle_rp_inst(ri, &empty_rp);
> +		recycle_rp_inst(ri, NULL);
>  
> -		if (orig_ret_address != trampoline_address)
> -			/*
> -			 * This is the real return address. Any other
> -			 * instances associated with this task are for
> -			 * other calls deeper on the call stack
> -			 */
> -			break;
> +		first = node;
>  	}
>  
> -	kretprobe_hash_unlock(current, &flags);
> -
>  	kprobe_busy_end();
>  
> -	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
> -		hlist_del(&ri->hlist);
> -		kfree(ri);
> -	}
>  	return (void *)orig_ret_address;
>  }
>  NOKPROBE_SYMBOL(trampoline_handler);
> diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
> index 0b2fe55e6194..0e851b925c8c 100644
> --- a/drivers/gpu/drm/i915/i915_request.c
> +++ b/drivers/gpu/drm/i915/i915_request.c
> @@ -357,12 +357,6 @@ void i915_request_retire_upto(struct i915_request *rq)
>  	} while (i915_request_retire(tmp) && tmp != rq);
>  }
>  
> -static void __llist_add(struct llist_node *node, struct llist_head *head)
> -{
> -	node->next = head->first;
> -	head->first = node;
> -}
> -
>  static struct i915_request * const *
>  __engine_active(struct intel_engine_cs *engine)
>  {
> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 9be1bff4f586..073c40ae2cdb 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -151,12 +151,14 @@ struct kretprobe {
>  	int maxactive;
>  	int nmissed;
>  	size_t data_size;
> -	struct hlist_head free_instances;
> -	raw_spinlock_t lock;
> +//	struct hlist_head free_instances;
> +//	raw_spinlock_t lock;
> +	struct llist_head free_instances;
>  };
>  
>  struct kretprobe_instance {
> -	struct hlist_node hlist;
> +//	struct hlist_node hlist;
> +	struct llist_node llist;
>  	struct kretprobe *rp;
>  	kprobe_opcode_t *ret_addr;
>  	struct task_struct *task;
> diff --git a/include/linux/llist.h b/include/linux/llist.h
> index 2e9c7215882b..c17893dcc591 100644
> --- a/include/linux/llist.h
> +++ b/include/linux/llist.h
> @@ -197,6 +197,16 @@ static inline struct llist_node *llist_next(struct llist_node *node)
>  extern bool llist_add_batch(struct llist_node *new_first,
>  			    struct llist_node *new_last,
>  			    struct llist_head *head);
> +
> +static inline bool __llist_add_batch(struct llist_node *new_first,
> +				     struct llist_node *new_last,
> +				     struct llist_head *head)
> +{
> +	new_last->next = head->first;
> +	head->first = new_first;
> +	return new_last->next == NULL;
> +}
> +
>  /**
>   * llist_add - add a new entry
>   * @new:	new entry to be added
> @@ -209,6 +219,11 @@ static inline bool llist_add(struct llist_node *new, struct llist_head *head)
>  	return llist_add_batch(new, new, head);
>  }
>  
> +static inline bool __llist_add(struct llist_node *new, struct llist_head *head)
> +{
> +	return __llist_add_batch(new, new, head);
> +}
> +
>  /**
>   * llist_del_all - delete all entries from lock-less list
>   * @head:	the head of lock-less list to delete all entries
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 93ecd930efd3..e53fd653cefa 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1315,6 +1315,10 @@ struct task_struct {
>  	struct callback_head		mce_kill_me;
>  #endif
>  
> +#ifdef CONFIG_KRETPROBES
> +	struct llist_head		kretprobe_instances;
> +#endif
> +
>  	/*
>  	 * New fields for task_struct should be added above here, so that
>  	 * they are included in the randomized portion of task_struct.
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 4d32190861bd..2ff5cceb0732 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2161,6 +2161,10 @@ static __latent_entropy struct task_struct *copy_process(
>  	INIT_LIST_HEAD(&p->thread_group);
>  	p->task_works = NULL;
>  
> +#ifdef CONFIG_KRETPROBES
> +	p->kretprobe_instances.first = NULL;
> +#endif
> +
>  	/*
>  	 * Ensure that the cgroup subsystem policies allow the new process to be
>  	 * forked. It should be noted the the new process's css_set can be changed
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 287b263c9cb9..e208ce6fa84d 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -53,7 +53,6 @@ static int kprobes_initialized;
>   * - RCU hlist traversal under disabling preempt (breakpoint handlers)
>   */
>  static struct hlist_head kprobe_table[KPROBE_TABLE_SIZE];
> -static struct hlist_head kretprobe_inst_table[KPROBE_TABLE_SIZE];
>  
>  /* NOTE: change this value only with kprobe_mutex held */
>  static bool kprobes_all_disarmed;
> @@ -61,9 +60,6 @@ static bool kprobes_all_disarmed;
>  /* This protects kprobe_table and optimizing_list */
>  static DEFINE_MUTEX(kprobe_mutex);
>  static DEFINE_PER_CPU(struct kprobe *, kprobe_instance) = NULL;
> -static struct {
> -	raw_spinlock_t lock ____cacheline_aligned_in_smp;
> -} kretprobe_table_locks[KPROBE_TABLE_SIZE];
>  
>  kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
>  					unsigned int __unused)
> @@ -71,11 +67,6 @@ kprobe_opcode_t * __weak kprobe_lookup_name(const char *name,
>  	return ((kprobe_opcode_t *)(kallsyms_lookup_name(name)));
>  }
>  
> -static raw_spinlock_t *kretprobe_table_lock_ptr(unsigned long hash)
> -{
> -	return &(kretprobe_table_locks[hash].lock);
> -}
> -
>  /* Blacklist -- list of struct kprobe_blacklist_entry */
>  static LIST_HEAD(kprobe_blacklist);
>  
> @@ -1228,62 +1219,22 @@ void recycle_rp_inst(struct kretprobe_instance *ri,
>  {
>  	struct kretprobe *rp = ri->rp;
>  
> -	/* remove rp inst off the rprobe_inst_table */
> -	hlist_del(&ri->hlist);
> -	INIT_HLIST_NODE(&ri->hlist);
> -	if (likely(rp)) {
> -		raw_spin_lock(&rp->lock);
> -		hlist_add_head(&ri->hlist, &rp->free_instances);
> -		raw_spin_unlock(&rp->lock);
> -	} else
> -		/* Unregistering */
> -		hlist_add_head(&ri->hlist, head);
> +	llist_add(&ri->llist, &rp->free_instances);
>  }
>  NOKPROBE_SYMBOL(recycle_rp_inst);
>  
>  void kretprobe_hash_lock(struct task_struct *tsk,
>  			 struct hlist_head **head, unsigned long *flags)
> -__acquires(hlist_lock)
>  {
> -	unsigned long hash = hash_ptr(tsk, KPROBE_HASH_BITS);
> -	raw_spinlock_t *hlist_lock;
> -
> -	*head = &kretprobe_inst_table[hash];
> -	hlist_lock = kretprobe_table_lock_ptr(hash);
> -	raw_spin_lock_irqsave(hlist_lock, *flags);
>  }
>  NOKPROBE_SYMBOL(kretprobe_hash_lock);
>  
> -static void kretprobe_table_lock(unsigned long hash,
> -				 unsigned long *flags)
> -__acquires(hlist_lock)
> -{
> -	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
> -	raw_spin_lock_irqsave(hlist_lock, *flags);
> -}
> -NOKPROBE_SYMBOL(kretprobe_table_lock);
> -
>  void kretprobe_hash_unlock(struct task_struct *tsk,
>  			   unsigned long *flags)
> -__releases(hlist_lock)
>  {
> -	unsigned long hash = hash_ptr(tsk, KPROBE_HASH_BITS);
> -	raw_spinlock_t *hlist_lock;
> -
> -	hlist_lock = kretprobe_table_lock_ptr(hash);
> -	raw_spin_unlock_irqrestore(hlist_lock, *flags);
>  }
>  NOKPROBE_SYMBOL(kretprobe_hash_unlock);
>  
> -static void kretprobe_table_unlock(unsigned long hash,
> -				   unsigned long *flags)
> -__releases(hlist_lock)
> -{
> -	raw_spinlock_t *hlist_lock = kretprobe_table_lock_ptr(hash);
> -	raw_spin_unlock_irqrestore(hlist_lock, *flags);
> -}
> -NOKPROBE_SYMBOL(kretprobe_table_unlock);
> -
>  struct kprobe kprobe_busy = {
>  	.addr = (void *) get_kprobe,
>  };
> @@ -1312,29 +1263,21 @@ void kprobe_busy_end(void)
>   */
>  void kprobe_flush_task(struct task_struct *tk)
>  {
> +	struct llist_node *next, *node;
>  	struct kretprobe_instance *ri;
> -	struct hlist_head *head, empty_rp;
> -	struct hlist_node *tmp;
> -	unsigned long hash, flags = 0;
>  
> +	/* Early boot, not yet initialized. */
>  	if (unlikely(!kprobes_initialized))
> -		/* Early boot.  kretprobe_table_locks not yet initialized. */
>  		return;
>  
>  	kprobe_busy_begin();
>  
> -	INIT_HLIST_HEAD(&empty_rp);
> -	hash = hash_ptr(tk, KPROBE_HASH_BITS);
> -	head = &kretprobe_inst_table[hash];
> -	kretprobe_table_lock(hash, &flags);
> -	hlist_for_each_entry_safe(ri, tmp, head, hlist) {
> -		if (ri->task == tk)
> -			recycle_rp_inst(ri, &empty_rp);
> -	}
> -	kretprobe_table_unlock(hash, &flags);
> -	hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
> -		hlist_del(&ri->hlist);
> +	node = llist_del_all(&current->kretprobe_instances);
> +	while (node) {
> +		next = node->next;
> +		ri = container_of(node, struct kretprobe_instance, llist);
>  		kfree(ri);
> +		node = next;
>  	}
>  
>  	kprobe_busy_end();
> @@ -1343,12 +1286,14 @@ NOKPROBE_SYMBOL(kprobe_flush_task);
>  
>  static inline void free_rp_inst(struct kretprobe *rp)
>  {
> +	struct llist_node *next, *node = llist_del_all(&rp->free_instances);
>  	struct kretprobe_instance *ri;
> -	struct hlist_node *next;
>  
> -	hlist_for_each_entry_safe(ri, next, &rp->free_instances, hlist) {
> -		hlist_del(&ri->hlist);
> +	while (node) {
> +		next = node->next;
> +		ri = container_of(node, struct kretprobe_instance, llist);
>  		kfree(ri);
> +		node = next;
>  	}
>  }
>  
> @@ -1359,6 +1304,10 @@ static void cleanup_rp_inst(struct kretprobe *rp)
>  	struct hlist_node *next;
>  	struct hlist_head *head;
>  
> +	/*
> +	 * XXX broken... 
> +	 */
> +#if 0
>  	/* No race here */
>  	for (hash = 0; hash < KPROBE_TABLE_SIZE; hash++) {
>  		kretprobe_table_lock(hash, &flags);
> @@ -1369,6 +1318,7 @@ static void cleanup_rp_inst(struct kretprobe *rp)
>  		}
>  		kretprobe_table_unlock(hash, &flags);
>  	}
> +#endif
>  	free_rp_inst(rp);
>  }
>  NOKPROBE_SYMBOL(cleanup_rp_inst);
> @@ -1934,50 +1884,28 @@ unsigned long __weak arch_deref_entry_point(void *entry)
>  static int pre_handler_kretprobe(struct kprobe *p, struct pt_regs *regs)
>  {
>  	struct kretprobe *rp = container_of(p, struct kretprobe, kp);
> -	unsigned long hash, flags = 0;
>  	struct kretprobe_instance *ri;
> +	struct llist_node *llist;
>  
> -	/*
> -	 * To avoid deadlocks, prohibit return probing in NMI contexts,
> -	 * just skip the probe and increase the (inexact) 'nmissed'
> -	 * statistical counter, so that the user is informed that
> -	 * something happened:
> -	 */
> -	if (unlikely(in_nmi())) {
> +	llist = llist_del_first(&rp->free_instances);
> +	if (!llist) {
>  		rp->nmissed++;
>  		return 0;
>  	}
>  
> -	/* TODO: consider to only swap the RA after the last pre_handler fired */
> -	hash = hash_ptr(current, KPROBE_HASH_BITS);
> -	raw_spin_lock_irqsave(&rp->lock, flags);
> -	if (!hlist_empty(&rp->free_instances)) {
> -		ri = hlist_entry(rp->free_instances.first,
> -				struct kretprobe_instance, hlist);
> -		hlist_del(&ri->hlist);
> -		raw_spin_unlock_irqrestore(&rp->lock, flags);
> +	ri = container_of(llist, struct kretprobe_instance, llist);
> +	ri->rp = rp;
> +	ri->task = current;
>  
> -		ri->rp = rp;
> -		ri->task = current;
> +	if (rp->entry_handler && rp->entry_handler(ri, regs)) {
> +		llist_add(llist, &rp->free_instances);
> +		return 0;
> +	}
>  
> -		if (rp->entry_handler && rp->entry_handler(ri, regs)) {
> -			raw_spin_lock_irqsave(&rp->lock, flags);
> -			hlist_add_head(&ri->hlist, &rp->free_instances);
> -			raw_spin_unlock_irqrestore(&rp->lock, flags);
> -			return 0;
> -		}
> +	arch_prepare_kretprobe(ri, regs);
>  
> -		arch_prepare_kretprobe(ri, regs);
> +	__llist_add(llist, &current->kretprobe_instances);
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
> @@ -2034,8 +1962,9 @@ int register_kretprobe(struct kretprobe *rp)
>  		rp->maxactive = num_possible_cpus();
>  #endif
>  	}
> -	raw_spin_lock_init(&rp->lock);
> -	INIT_HLIST_HEAD(&rp->free_instances);
> +
> +	rp->free_instances.first = NULL;
> +
>  	for (i = 0; i < rp->maxactive; i++) {
>  		inst = kmalloc(sizeof(struct kretprobe_instance) +
>  			       rp->data_size, GFP_KERNEL);
> @@ -2043,8 +1972,7 @@ int register_kretprobe(struct kretprobe *rp)
>  			free_rp_inst(rp);
>  			return -ENOMEM;
>  		}
> -		INIT_HLIST_NODE(&inst->hlist);
> -		hlist_add_head(&inst->hlist, &rp->free_instances);
> +		llist_add(&inst->llist, &rp->free_instances);
>  	}
>  
>  	rp->nmissed = 0;
> @@ -2458,11 +2386,8 @@ static int __init init_kprobes(void)
>  
>  	/* FIXME allocate the probe table, currently defined statically */
>  	/* initialize all list heads */
> -	for (i = 0; i < KPROBE_TABLE_SIZE; i++) {
> +	for (i = 0; i < KPROBE_TABLE_SIZE; i++)
>  		INIT_HLIST_HEAD(&kprobe_table[i]);
> -		INIT_HLIST_HEAD(&kretprobe_inst_table[i]);
> -		raw_spin_lock_init(&(kretprobe_table_locks[i].lock));
> -	}
>  
>  	err = populate_kprobe_blacklist(__start_kprobe_blacklist,
>  					__stop_kprobe_blacklist);


-- 
Masami Hiramatsu <mhiramat@kernel.org>
