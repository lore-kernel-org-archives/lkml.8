Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ABD7C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E83E420936
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:00:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b0KKpEYs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgEFHAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:00:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33535 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727803AbgEFHAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588748420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WFq/0yqRbKNXv/YBxVPlsC0lujmPDyxJNpEoG2AcP8w=;
        b=b0KKpEYsXRk2CES92M0xwFEA+Zast8+Rg8ORsc8XW6ib6UQv46Qfhj9G4x2tS/GWx1/y7w
        J/F7sBCjVLvheFGC1L3sNe5/r4dUgV3rwzgB+PfhSvlS2lj3h7DrzZC8tByhus7kxN14XL
        iFjbymsiw40EBDNJwk0Sb5U1I7Xo19A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-DFjrMKbuNKGrpDQ3jBz64g-1; Wed, 06 May 2020 03:00:18 -0400
X-MC-Unique: DFjrMKbuNKGrpDQ3jBz64g-1
Received: by mail-wr1-f70.google.com with SMTP id u4so823046wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 00:00:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WFq/0yqRbKNXv/YBxVPlsC0lujmPDyxJNpEoG2AcP8w=;
        b=L29j88nsCBZDvA+VEusg+BJVo39ZNxqZmTGyAM0UpfB/6+EaaGDAq6y/HXXbs0sI9V
         D8l30d0IKpftesgKRzjxzdo50lnZZgHwewf/tQiws6vRc9/Qjf8diuLBCdd52yEdaE1B
         9/RVdDTnmIKNI3Q18wWNFetWn2vsLa0uQyv7mDav2fybm03Hx/DdwJGsTUzv/4X1d+1R
         OfaZSwnVBHHsdsYbxIpKWUEpuBn3YjNajsPZvoWr4lQHaXH2zHxz7z8c5naO4SwRbGfT
         CWunxHSets3bu+nIe+hiv2mBxIm4ZyQDqDFcDprcMUq/ewmceOpfHqlsdIDXZ05TqyHu
         P97g==
X-Gm-Message-State: AGi0PuZGNWuQxueqzsAZLgIBowsWKHqtDQ6fu/36Th6UOOhPe4M0uOB8
        O6LtSJwgk/URPupgFdNwDiUbnooTaBc6Rfn6LMQKoU6rcvFRkYzwkFv6qBK/+Y6DCCqsYityBFb
        ri4+ZWkZJ0+JysywMjJqcI1XT
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr7688671wrn.325.1588748417400;
        Wed, 06 May 2020 00:00:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypLvuTZ3mOtVJTz+LZ76QaJsd2IW3Bp7IkeH7XH2An2xEV/4s/UH++MAOsNHvdu1xb6w7Qbljw==
X-Received: by 2002:adf:dfc8:: with SMTP id q8mr7688640wrn.325.1588748417113;
        Wed, 06 May 2020 00:00:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11d7:2f21:f38b:17e? ([2001:b07:6468:f312:11d7:2f21:f38b:17e])
        by smtp.gmail.com with ESMTPSA id o6sm1187423wrw.63.2020.05.06.00.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 00:00:16 -0700 (PDT)
Subject: Re: [patch V4 part 1 13/36] x86/kvm: Restrict ASYNC_PF to user space
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
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
References: <20200505131602.633487962@linutronix.de>
 <20200505134059.369802541@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea4525e3-ab52-0f94-2f27-43e83ea5b310@redhat.com>
Date:   Wed, 6 May 2020 09:00:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134059.369802541@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 15:16, Thomas Gleixner wrote:
> The async page fault injection into kernel space creates more problems than
> it solves. The host has absolutely no knowledge about the state of the
> guest if the fault happens in CPL0. The only restriction for the host is
> interrupt disabled state. If interrupts are enabled in the guest then the
> exception can hit arbitrary code. The HALT based wait in non-preemotible
> code is a hacky replacement for a proper hypercall.
> 
> For the ongoing work to restrict instrumentation and make the RCU idle
> interaction well defined the required extra work for supporting async
> pagefault in CPL0 is just not justified and creates complexity for a
> dubious benefit.
> 
> The CPL3 injection is well defined and does not cause any issues as it is
> more or less the same as a regular page fault from CPL3.
> 
> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/kvm.c |  100 +++-----------------------------------------------
>  1 file changed, 7 insertions(+), 93 deletions(-)
> 
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -75,7 +75,6 @@ struct kvm_task_sleep_node {
>  	struct swait_queue_head wq;
>  	u32 token;
>  	int cpu;
> -	bool use_halt;
>  };
>  
>  static struct kvm_task_sleep_head {
> @@ -98,8 +97,7 @@ static struct kvm_task_sleep_node *_find
>  	return NULL;
>  }
>  
> -static bool kvm_async_pf_queue_task(u32 token, bool use_halt,
> -				    struct kvm_task_sleep_node *n)
> +static bool kvm_async_pf_queue_task(u32 token, struct kvm_task_sleep_node *n)
>  {
>  	u32 key = hash_32(token, KVM_TASK_SLEEP_HASHBITS);
>  	struct kvm_task_sleep_head *b = &async_pf_sleepers[key];
> @@ -117,7 +115,6 @@ static bool kvm_async_pf_queue_task(u32
>  
>  	n->token = token;
>  	n->cpu = smp_processor_id();
> -	n->use_halt = use_halt;
>  	init_swait_queue_head(&n->wq);
>  	hlist_add_head(&n->link, &b->list);
>  	raw_spin_unlock(&b->lock);
> @@ -138,7 +135,7 @@ void kvm_async_pf_task_wait_schedule(u32
>  
>  	lockdep_assert_irqs_disabled();
>  
> -	if (!kvm_async_pf_queue_task(token, false, &n))
> +	if (!kvm_async_pf_queue_task(token, &n))
>  		return;
>  
>  	for (;;) {
> @@ -154,91 +151,10 @@ void kvm_async_pf_task_wait_schedule(u32
>  }
>  EXPORT_SYMBOL_GPL(kvm_async_pf_task_wait_schedule);
>  
> -/*
> - * Invoked from the async page fault handler.
> - */
> -static void kvm_async_pf_task_wait_halt(u32 token)
> -{
> -	struct kvm_task_sleep_node n;
> -
> -	if (!kvm_async_pf_queue_task(token, true, &n))
> -		return;
> -
> -	for (;;) {
> -		if (hlist_unhashed(&n.link))
> -			break;
> -		/*
> -		 * No point in doing anything about RCU here. Any RCU read
> -		 * side critical section or RCU watching section can be
> -		 * interrupted by VMEXITs and the host is free to keep the
> -		 * vCPU scheduled out as long as it sees fit. This is not
> -		 * any different just because of the halt induced voluntary
> -		 * VMEXIT.
> -		 *
> -		 * Also the async page fault could have interrupted any RCU
> -		 * watching context, so invoking rcu_irq_exit()/enter()
> -		 * around this is not gaining anything.
> -		 */
> -		native_safe_halt();
> -		local_irq_disable();
> -	}
> -}
> -
> -/* Invoked from the async page fault handler */
> -static void kvm_async_pf_task_wait(u32 token, bool usermode)
> -{
> -	bool can_schedule;
> -
> -	/*
> -	 * No need to check whether interrupts were disabled because the
> -	 * host will (hopefully) only inject an async page fault into
> -	 * interrupt enabled regions.
> -	 *
> -	 * If CONFIG_PREEMPTION is enabled then check whether the code
> -	 * which triggered the page fault is preemptible. This covers user
> -	 * mode as well because preempt_count() is obviously 0 there.
> -	 *
> -	 * The check for rcu_preempt_depth() is also required because
> -	 * voluntary scheduling inside a rcu read locked section is not
> -	 * allowed.
> -	 *
> -	 * The idle task is already covered by this because idle always
> -	 * has a preempt count > 0.
> -	 *
> -	 * If CONFIG_PREEMPTION is disabled only allow scheduling when
> -	 * coming from user mode as there is no indication whether the
> -	 * context which triggered the page fault could schedule or not.
> -	 */
> -	if (IS_ENABLED(CONFIG_PREEMPTION))
> -		can_schedule = preempt_count() + rcu_preempt_depth() == 0;
> -	else
> -		can_schedule = usermode;
> -
> -	/*
> -	 * If the kernel context is allowed to schedule then RCU is
> -	 * watching because no preemptible code in the kernel is inside RCU
> -	 * idle state. So it can be treated like user mode. User mode is
> -	 * safe because the #PF entry invoked enter_from_user_mode().
> -	 *
> -	 * For the non schedulable case invoke rcu_irq_enter() for
> -	 * now. This will be moved out to the pagefault entry code later
> -	 * and only invoked when really needed.
> -	 */
> -	if (can_schedule) {
> -		kvm_async_pf_task_wait_schedule(token);
> -	} else {
> -		rcu_irq_enter();
> -		kvm_async_pf_task_wait_halt(token);
> -		rcu_irq_exit();
> -	}
> -}
> -
>  static void apf_task_wake_one(struct kvm_task_sleep_node *n)
>  {
>  	hlist_del_init(&n->link);
> -	if (n->use_halt)
> -		smp_send_reschedule(n->cpu);
> -	else if (swq_has_sleeper(&n->wq))
> +	if (swq_has_sleeper(&n->wq))
>  		swake_up_one(&n->wq);
>  }
>  
> @@ -337,8 +253,10 @@ bool __kvm_handle_async_pf(struct pt_reg
>  		panic("Host injected async #PF in interrupt disabled region\n");
>  
>  	if (reason == KVM_PV_REASON_PAGE_NOT_PRESENT) {
> -		/* page is swapped out by the host. */
> -		kvm_async_pf_task_wait(token, user_mode(regs));
> +		if (unlikely(!(user_mode(regs))))
> +			panic("Host injected async #PF in kernel mode\n");
> +		/* Page is swapped out by the host. */
> +		kvm_async_pf_task_wait_schedule(token);
>  	} else {
>  		rcu_irq_enter();
>  		kvm_async_pf_task_wake(token);
> @@ -397,10 +315,6 @@ static void kvm_guest_cpu_init(void)
>  		WARN_ON_ONCE(!static_branch_likely(&kvm_async_pf_enabled));
>  
>  		pa = slow_virt_to_phys(this_cpu_ptr(&apf_reason));
> -
> -#ifdef CONFIG_PREEMPTION
> -		pa |= KVM_ASYNC_PF_SEND_ALWAYS;
> -#endif
>  		pa |= KVM_ASYNC_PF_ENABLED;
>  
>  		if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_VMEXIT))
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

