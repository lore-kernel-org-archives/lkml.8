Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673A5C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D7E220735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 17:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588701257;
	bh=s1JEBqE6VNIpb5qYmkUKiGKE2RDDUlcnSdjHUZ4llc0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=CieQ0Wsvlv8ViMn86IDjB2Ebm7lL2Vm7K+Jl4WTJHHELnKNlWMaxRsGF+4V4el8bY
	 3XqnQEyqRCOC+pDOGQJl7gN+3w4NDp1+SaOZSox0oOnQvGGl2jKzuwazWGiQiBRbpk
	 VqG69k1kD29usjYhu5gDOXc3jiiHn13cZknUIt6A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgEERyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 13:54:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:50618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729663AbgEERyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 13:54:15 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8DBF2206FA;
        Tue,  5 May 2020 17:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588701253;
        bh=s1JEBqE6VNIpb5qYmkUKiGKE2RDDUlcnSdjHUZ4llc0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=B+U7BrRU4hzWzkNGYcATbSNotR5xi41yB9uqewrJXNd9aoSKAd13zeXezhOy7Ulkz
         ZxcQLzDEwycpWacFGufeQJyXIzz6TdMck+USLUK/4zNO3e5j3X79vLLJ0dIbuRwA8i
         G/QwDJLZarEyFPsc0ZtBCdIibDVL0AWcuiRQfKaI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E97CF3523034; Tue,  5 May 2020 10:54:12 -0700 (PDT)
Date:   Tue, 5 May 2020 10:54:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 1 12/36] x86/kvm: Sanitize
 kvm_async_pf_task_wait()
Message-ID: <20200505175412.GG2869@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200505131602.633487962@linutronix.de>
 <20200505134059.262701431@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505134059.262701431@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:16:14PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> While working on the entry consolidation I stumbled over the KVM async page
> fault handler and kvm_async_pf_task_wait() in particular. It took me a
> while to realize that the randomly sprinkled around rcu_irq_enter()/exit()
> invocations are just cargo cult programming. Several patches "fixed" RCU
> splats by curing the symptoms without noticing that the code is flawed 
> from a design perspective.
> 
> The main problem is that this async injection is not based on a proper
> handshake mechanism and only respects the minimal requirement, i.e. the
> guest is not in a state where it has interrupts disabled.
> 
> Aside of that the actual code is a convoluted one fits it all swiss army
> knife. It is invoked from different places with different RCU constraints:
> 
>   1) Host side:
> 
>      vcpu_enter_guest()
>        kvm_x86_ops->handle_exit()
>          kvm_handle_page_fault()
>            kvm_async_pf_task_wait()
> 
>      The invocation happens from fully preemptible context.
> 
>   2) Guest side:
> 
>      The async page fault interrupted:
> 
>          a) user space
> 
> 	 b) preemptible kernel code which is not in a RCU read side
> 	    critical section
> 
>      	 c) non-preemtible kernel code or a RCU read side critical section
> 	    or kernel code with CONFIG_PREEMPTION=n which allows not to
> 	    differentiate between #2b and #2c.
> 
> RCU is watching for:
> 
>   #1  The vCPU exited and current is definitely not the idle task
> 
>   #2a The #PF entry code on the guest went through enter_from_user_mode()
>       which reactivates RCU

I have to double-check...  The NO_HZ_FULL case transitioning to/from
userspace is entirely non-preemptible, correct?  (After rcu_user_enter()
and before rcu_user_exit(), respectively.)

							Thanx, Paul

>   #2b There is no preemptible, interrupts enabled code in the kernel
>       which can run with RCU looking away. (The idle task is always
>       non preemptible).
> 
> I.e. all schedulable states (#1, #2a, #2b) do not need any of this RCU
> voodoo at all.
> 
> In #2c RCU is eventually not watching, but as that state cannot schedule
> anyway there is no point to worry about it so it has to invoke
> rcu_irq_enter() before running that code. This can be optimized, but this
> will be done as an extra step in course of the entry code consolidation
> work.
> 
> So the proper solution for this is to:
> 
>   - Split kvm_async_pf_task_wait() into schedule and halt based waiting
>     interfaces which share the enqueueing code.
> 
>   - Add comments (condensed form of this changelog) to spare others the
>     time waste and pain of reverse engineering all of this with the help of
>     uncomprehensible changelogs and code history.
> 
>   - Invoke kvm_async_pf_task_wait_schedule() from kvm_handle_page_fault(),
>     user mode and schedulable kernel side async page faults (#1, #2a, #2b)
> 
>   - Invoke kvm_async_pf_task_wait_halt() for the non schedulable kernel
>     case (#2c).
> 
>     For this case also remove the rcu_irq_exit()/enter() pair around the
>     halt as it is just a pointless exercise:
> 
>        - vCPUs can VMEXIT at any random point and can be scheduled out for
>          an arbitrary amount of time by the host and this is not any
>          different except that it voluntary triggers the exit via halt.
> 
>        - The interrupted context could have RCU watching already. So the
> 	 rcu_irq_exit() before the halt is not gaining anything aside of
> 	 confusing the reader. Claiming that this might prevent RCU stalls
> 	 is just an illusion.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2: Panic if async #PF is injected into an interrupt disabled region.
> ---
>  arch/x86/include/asm/kvm_para.h |    4 
>  arch/x86/kernel/kvm.c           |  201 ++++++++++++++++++++++++++++------------
>  arch/x86/kvm/mmu/mmu.c          |    2 
>  3 files changed, 144 insertions(+), 63 deletions(-)
> 
> --- a/arch/x86/include/asm/kvm_para.h
> +++ b/arch/x86/include/asm/kvm_para.h
> @@ -88,7 +88,7 @@ static inline long kvm_hypercall4(unsign
>  bool kvm_para_available(void);
>  unsigned int kvm_arch_para_features(void);
>  unsigned int kvm_arch_para_hints(void);
> -void kvm_async_pf_task_wait(u32 token, int interrupt_kernel);
> +void kvm_async_pf_task_wait_schedule(u32 token);
>  void kvm_async_pf_task_wake(u32 token);
>  u32 kvm_read_and_reset_pf_reason(void);
>  void kvm_disable_steal_time(void);
> @@ -113,7 +113,7 @@ static inline void kvm_spinlock_init(voi
>  #endif /* CONFIG_PARAVIRT_SPINLOCKS */
>  
>  #else /* CONFIG_KVM_GUEST */
> -#define kvm_async_pf_task_wait(T, I) do {} while(0)
> +#define kvm_async_pf_task_wait_schedule(T) do {} while(0)
>  #define kvm_async_pf_task_wake(T) do {} while(0)
>  
>  static inline bool kvm_para_available(void)
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -75,7 +75,7 @@ struct kvm_task_sleep_node {
>  	struct swait_queue_head wq;
>  	u32 token;
>  	int cpu;
> -	bool halted;
> +	bool use_halt;
>  };
>  
>  static struct kvm_task_sleep_head {
> @@ -98,75 +98,145 @@ static struct kvm_task_sleep_node *_find
>  	return NULL;
>  }
>  
> -/*
> - * @interrupt_kernel: Is this called from a routine which interrupts the kernel
> - * 		      (other than user space)?
> - */
> -void kvm_async_pf_task_wait(u32 token, int interrupt_kernel)
> +static bool kvm_async_pf_queue_task(u32 token, bool use_halt,
> +				    struct kvm_task_sleep_node *n)
>  {
>  	u32 key = hash_32(token, KVM_TASK_SLEEP_HASHBITS);
>  	struct kvm_task_sleep_head *b = &async_pf_sleepers[key];
> -	struct kvm_task_sleep_node n, *e;
> -	DECLARE_SWAITQUEUE(wait);
> -
> -	rcu_irq_enter();
> +	struct kvm_task_sleep_node *e;
>  
>  	raw_spin_lock(&b->lock);
>  	e = _find_apf_task(b, token);
>  	if (e) {
>  		/* dummy entry exist -> wake up was delivered ahead of PF */
>  		hlist_del(&e->link);
> -		kfree(e);
>  		raw_spin_unlock(&b->lock);
> +		kfree(e);
> +		return false;
> +	}
>  
> -		rcu_irq_exit();
> +	n->token = token;
> +	n->cpu = smp_processor_id();
> +	n->use_halt = use_halt;
> +	init_swait_queue_head(&n->wq);
> +	hlist_add_head(&n->link, &b->list);
> +	raw_spin_unlock(&b->lock);
> +	return true;
> +}
> +
> +/*
> + * kvm_async_pf_task_wait_schedule - Wait for pagefault to be handled
> + * @token:	Token to identify the sleep node entry
> + *
> + * Invoked from the async pagefault handling code or from the VM exit page
> + * fault handler. In both cases RCU is watching.
> + */
> +void kvm_async_pf_task_wait_schedule(u32 token)
> +{
> +	struct kvm_task_sleep_node n;
> +	DECLARE_SWAITQUEUE(wait);
> +
> +	lockdep_assert_irqs_disabled();
> +
> +	if (!kvm_async_pf_queue_task(token, false, &n))
>  		return;
> +
> +	for (;;) {
> +		prepare_to_swait_exclusive(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
> +		if (hlist_unhashed(&n.link))
> +			break;
> +
> +		local_irq_enable();
> +		schedule();
> +		local_irq_disable();
>  	}
> +	finish_swait(&n.wq, &wait);
> +}
> +EXPORT_SYMBOL_GPL(kvm_async_pf_task_wait_schedule);
>  
> -	n.token = token;
> -	n.cpu = smp_processor_id();
> -	n.halted = is_idle_task(current) ||
> -		   (IS_ENABLED(CONFIG_PREEMPT_COUNT)
> -		    ? preempt_count() > 1 || rcu_preempt_depth()
> -		    : interrupt_kernel);
> -	init_swait_queue_head(&n.wq);
> -	hlist_add_head(&n.link, &b->list);
> -	raw_spin_unlock(&b->lock);
> +/*
> + * Invoked from the async page fault handler.
> + */
> +static void kvm_async_pf_task_wait_halt(u32 token)
> +{
> +	struct kvm_task_sleep_node n;
> +
> +	if (!kvm_async_pf_queue_task(token, true, &n))
> +		return;
>  
>  	for (;;) {
> -		if (!n.halted)
> -			prepare_to_swait_exclusive(&n.wq, &wait, TASK_UNINTERRUPTIBLE);
>  		if (hlist_unhashed(&n.link))
>  			break;
> +		/*
> +		 * No point in doing anything about RCU here. Any RCU read
> +		 * side critical section or RCU watching section can be
> +		 * interrupted by VMEXITs and the host is free to keep the
> +		 * vCPU scheduled out as long as it sees fit. This is not
> +		 * any different just because of the halt induced voluntary
> +		 * VMEXIT.
> +		 *
> +		 * Also the async page fault could have interrupted any RCU
> +		 * watching context, so invoking rcu_irq_exit()/enter()
> +		 * around this is not gaining anything.
> +		 */
> +		native_safe_halt();
> +		local_irq_disable();
> +	}
> +}
>  
> -		rcu_irq_exit();
> +/* Invoked from the async page fault handler */
> +static void kvm_async_pf_task_wait(u32 token, bool usermode)
> +{
> +	bool can_schedule;
>  
> -		if (!n.halted) {
> -			local_irq_enable();
> -			schedule();
> -			local_irq_disable();
> -		} else {
> -			/*
> -			 * We cannot reschedule. So halt.
> -			 */
> -			native_safe_halt();
> -			local_irq_disable();
> -		}
> +	/*
> +	 * No need to check whether interrupts were disabled because the
> +	 * host will (hopefully) only inject an async page fault into
> +	 * interrupt enabled regions.
> +	 *
> +	 * If CONFIG_PREEMPTION is enabled then check whether the code
> +	 * which triggered the page fault is preemptible. This covers user
> +	 * mode as well because preempt_count() is obviously 0 there.
> +	 *
> +	 * The check for rcu_preempt_depth() is also required because
> +	 * voluntary scheduling inside a rcu read locked section is not
> +	 * allowed.
> +	 *
> +	 * The idle task is already covered by this because idle always
> +	 * has a preempt count > 0.
> +	 *
> +	 * If CONFIG_PREEMPTION is disabled only allow scheduling when
> +	 * coming from user mode as there is no indication whether the
> +	 * context which triggered the page fault could schedule or not.
> +	 */
> +	if (IS_ENABLED(CONFIG_PREEMPTION))
> +		can_schedule = preempt_count() + rcu_preempt_depth() == 0;
> +	else
> +		can_schedule = usermode;
>  
> +	/*
> +	 * If the kernel context is allowed to schedule then RCU is
> +	 * watching because no preemptible code in the kernel is inside RCU
> +	 * idle state. So it can be treated like user mode. User mode is
> +	 * safe because the #PF entry invoked enter_from_user_mode().
> +	 *
> +	 * For the non schedulable case invoke rcu_irq_enter() for
> +	 * now. This will be moved out to the pagefault entry code later
> +	 * and only invoked when really needed.
> +	 */
> +	if (can_schedule) {
> +		kvm_async_pf_task_wait_schedule(token);
> +	} else {
>  		rcu_irq_enter();
> +		kvm_async_pf_task_wait_halt(token);
> +		rcu_irq_exit();
>  	}
> -	if (!n.halted)
> -		finish_swait(&n.wq, &wait);
> -
> -	rcu_irq_exit();
> -	return;
>  }
> -EXPORT_SYMBOL_GPL(kvm_async_pf_task_wait);
>  
>  static void apf_task_wake_one(struct kvm_task_sleep_node *n)
>  {
>  	hlist_del_init(&n->link);
> -	if (n->halted)
> +	if (n->use_halt)
>  		smp_send_reschedule(n->cpu);
>  	else if (swq_has_sleeper(&n->wq))
>  		swake_up_one(&n->wq);
> @@ -177,12 +247,13 @@ static void apf_task_wake_all(void)
>  	int i;
>  
>  	for (i = 0; i < KVM_TASK_SLEEP_HASHSIZE; i++) {
> -		struct hlist_node *p, *next;
>  		struct kvm_task_sleep_head *b = &async_pf_sleepers[i];
> +		struct kvm_task_sleep_node *n;
> +		struct hlist_node *p, *next;
> +
>  		raw_spin_lock(&b->lock);
>  		hlist_for_each_safe(p, next, &b->list) {
> -			struct kvm_task_sleep_node *n =
> -				hlist_entry(p, typeof(*n), link);
> +			n = hlist_entry(p, typeof(*n), link);
>  			if (n->cpu == smp_processor_id())
>  				apf_task_wake_one(n);
>  		}
> @@ -223,8 +294,9 @@ void kvm_async_pf_task_wake(u32 token)
>  		n->cpu = smp_processor_id();
>  		init_swait_queue_head(&n->wq);
>  		hlist_add_head(&n->link, &b->list);
> -	} else
> +	} else {
>  		apf_task_wake_one(n);
> +	}
>  	raw_spin_unlock(&b->lock);
>  	return;
>  }
> @@ -246,23 +318,33 @@ NOKPROBE_SYMBOL(kvm_read_and_reset_pf_re
>  
>  bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
>  {
> -	/*
> -	 * If we get a page fault right here, the pf_reason seems likely
> -	 * to be clobbered.  Bummer.
> -	 */
> -	switch (kvm_read_and_reset_pf_reason()) {
> +	u32 reason = kvm_read_and_reset_pf_reason();
> +
> +	switch (reason) {
> +	case KVM_PV_REASON_PAGE_NOT_PRESENT:
> +	case KVM_PV_REASON_PAGE_READY:
> +		break;
>  	default:
>  		return false;
> -	case KVM_PV_REASON_PAGE_NOT_PRESENT:
> +	}
> +
> +	/*
> +	 * If the host managed to inject an async #PF into an interrupt
> +	 * disabled region, then die hard as this is not going to end well
> +	 * and the host side is seriously broken.
> +	 */
> +	if (unlikely(!(regs->flags & X86_EFLAGS_IF)))
> +		panic("Host injected async #PF in interrupt disabled region\n");
> +
> +	if (reason == KVM_PV_REASON_PAGE_NOT_PRESENT) {
>  		/* page is swapped out by the host. */
> -		kvm_async_pf_task_wait(token, !user_mode(regs));
> -		return true;
> -	case KVM_PV_REASON_PAGE_READY:
> +		kvm_async_pf_task_wait(token, user_mode(regs));
> +	} else {
>  		rcu_irq_enter();
>  		kvm_async_pf_task_wake(token);
>  		rcu_irq_exit();
> -		return true;
>  	}
> +	return true;
>  }
>  NOKPROBE_SYMBOL(__kvm_handle_async_pf);
>  
> @@ -326,12 +408,12 @@ static void kvm_guest_cpu_init(void)
>  
>  		wrmsrl(MSR_KVM_ASYNC_PF_EN, pa);
>  		__this_cpu_write(apf_reason.enabled, 1);
> -		printk(KERN_INFO"KVM setup async PF for cpu %d\n",
> -		       smp_processor_id());
> +		pr_info("KVM setup async PF for cpu %d\n", smp_processor_id());
>  	}
>  
>  	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI)) {
>  		unsigned long pa;
> +
>  		/* Size alignment is implied but just to make it explicit. */
>  		BUILD_BUG_ON(__alignof__(kvm_apic_eoi) < 4);
>  		__this_cpu_write(kvm_apic_eoi, 0);
> @@ -352,8 +434,7 @@ static void kvm_pv_disable_apf(void)
>  	wrmsrl(MSR_KVM_ASYNC_PF_EN, 0);
>  	__this_cpu_write(apf_reason.enabled, 0);
>  
> -	printk(KERN_INFO"Unregister pv shared memory for cpu %d\n",
> -	       smp_processor_id());
> +	pr_info("Unregister pv shared memory for cpu %d\n", smp_processor_id());
>  }
>  
>  static void kvm_pv_guest_cpu_reboot(void *unused)
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4198,7 +4198,7 @@ int kvm_handle_page_fault(struct kvm_vcp
>  	case KVM_PV_REASON_PAGE_NOT_PRESENT:
>  		vcpu->arch.apf.host_apf_reason = 0;
>  		local_irq_disable();
> -		kvm_async_pf_task_wait(fault_address, 0);
> +		kvm_async_pf_task_wait_schedule(fault_address);
>  		local_irq_enable();
>  		break;
>  	case KVM_PV_REASON_PAGE_READY:
> 
