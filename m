Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F761C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:00:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E02852082E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 07:00:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0e8bwrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgEFHAb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 03:00:31 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:28612 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727803AbgEFHA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 03:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588748424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DquTJdBZswdAPz+DIljCEMbcnV4u6ptNvtKGOCql2co=;
        b=A0e8bwrIwY/7DSLhrByWw/FRH9D3GScsY4kDj0WQI5L7/iQQUbri+A0va5YzU20oDQZab7
        jphe8DqytfdLuhkAy9nnInKehaK46FetT5IK7ifBZHZoa65qNFsS9Bn/q9fgWqQBVcvVom
        I8aXKRNnlh/LwycXqr77H0jCdz6ux64=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-evJv3EIiOuSqe2ial9KhLQ-1; Wed, 06 May 2020 03:00:23 -0400
X-MC-Unique: evJv3EIiOuSqe2ial9KhLQ-1
Received: by mail-wr1-f71.google.com with SMTP id s11so827836wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 00:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DquTJdBZswdAPz+DIljCEMbcnV4u6ptNvtKGOCql2co=;
        b=f0PWOgsd+Buj5OKT3STBxdI30U+dWrSeuNhUzQPru6x0BFMxfo8xRqZVNs69P4R/vE
         WUicB/3N6Th04Tbt6NWd13nPJDVTAOm1yuHn/OCfFcAwW9pjL0Foc/x5jyqkLHyVZKuP
         YxyZZMTuocOxoBHgBsyxi7O7UF3kuyfuEkzEiwxGm7QLirUZIsbvn00h0AbwOBmZ5X9X
         4cg+drzum1rXOaCh5WM0I0NKDfUINLJzYddDuKJPZwY+ODLZ2bkvoOGDmQKAslhQ/t0E
         5u7gemYg/X44IIgAaJp4E8jfEfMj02JHGOA1cUPyR4973ZgA4BeslQnnd127KcT16ICC
         ebxg==
X-Gm-Message-State: AGi0PuZ+9QLNm0a8OcaNpAoaV0NDl/29am9w5A6FxK4HKmgRMBy8j42c
        PWA7EI5zQLUPRzhSFSzzni5wiDVOTU/Qj1kGxF3VDZpUgP8qz4cUxpuVQhFWCQk6udjzfbvjyli
        ZCQ5TgsaA9AQcO7H573+uUmCm
X-Received: by 2002:a5d:42c1:: with SMTP id t1mr8047366wrr.18.1588748422015;
        Wed, 06 May 2020 00:00:22 -0700 (PDT)
X-Google-Smtp-Source: APiQypIBRURpjW07OeCBHY74hCRMRl6eWENfgnAfrcYOHpHT7MIylM8jJsoqW3mHRw4G0Ma12fTqwg==
X-Received: by 2002:a5d:42c1:: with SMTP id t1mr8047323wrr.18.1588748421605;
        Wed, 06 May 2020 00:00:21 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11d7:2f21:f38b:17e? ([2001:b07:6468:f312:11d7:2f21:f38b:17e])
        by smtp.gmail.com with ESMTPSA id d13sm1541789wmb.39.2020.05.06.00.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 00:00:21 -0700 (PDT)
Subject: Re: [patch V4 part 1 11/36] x86/kvm: Handle async page faults
 directly through do_page_fault()
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
 <20200505134059.169270470@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9f71f71e-af27-eaa0-6dc9-0981d357a7cb@redhat.com>
Date:   Wed, 6 May 2020 09:00:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134059.169270470@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 15:16, Thomas Gleixner wrote:
> From: Andy Lutomirski <luto@kernel.org>
> 
> KVM overloads #PF to indicate two types of not-actually-page-fault
> events.  Right now, the KVM guest code intercepts them by modifying
> the IDT and hooking the #PF vector.  This makes the already fragile
> fault code even harder to understand, and it also pollutes call
> traces with async_page_fault and do_async_page_fault for normal page
> faults.
> 
> Clean it up by moving the logic into do_page_fault() using a static
> branch.  This gets rid of the platform trap_init override mechanism
> completely.
> 
> [ tglx: Fixed up 32bit, removed error code from the async functions and
>   	massaged coding style ]
> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/entry/entry_32.S       |    8 --------
>  arch/x86/entry/entry_64.S       |    4 ----
>  arch/x86/include/asm/kvm_para.h |   19 +++++++++++++++++--
>  arch/x86/include/asm/x86_init.h |    2 --
>  arch/x86/kernel/kvm.c           |   39 +++++++++++++++++++++------------------
>  arch/x86/kernel/traps.c         |    2 --
>  arch/x86/kernel/x86_init.c      |    1 -
>  arch/x86/mm/fault.c             |   19 +++++++++++++++++++
>  8 files changed, 57 insertions(+), 37 deletions(-)
> 
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1693,14 +1693,6 @@ SYM_CODE_START(general_protection)
>  	jmp	common_exception
>  SYM_CODE_END(general_protection)
>  
> -#ifdef CONFIG_KVM_GUEST
> -SYM_CODE_START(async_page_fault)
> -	ASM_CLAC
> -	pushl	$do_async_page_fault
> -	jmp	common_exception_read_cr2
> -SYM_CODE_END(async_page_fault)
> -#endif
> -
>  SYM_CODE_START(rewind_stack_do_exit)
>  	/* Prevent any naive code from trying to unwind to our caller. */
>  	xorl	%ebp, %ebp
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -1204,10 +1204,6 @@ idtentry xendebug		do_debug		has_error_c
>  idtentry general_protection	do_general_protection	has_error_code=1
>  idtentry page_fault		do_page_fault		has_error_code=1	read_cr2=1
>  
> -#ifdef CONFIG_KVM_GUEST
> -idtentry async_page_fault	do_async_page_fault	has_error_code=1	read_cr2=1
> -#endif
> -
>  #ifdef CONFIG_X86_MCE
>  idtentry machine_check		do_mce			has_error_code=0	paranoid=1
>  #endif
> --- a/arch/x86/include/asm/kvm_para.h
> +++ b/arch/x86/include/asm/kvm_para.h
> @@ -91,8 +91,18 @@ unsigned int kvm_arch_para_hints(void);
>  void kvm_async_pf_task_wait(u32 token, int interrupt_kernel);
>  void kvm_async_pf_task_wake(u32 token);
>  u32 kvm_read_and_reset_pf_reason(void);
> -extern void kvm_disable_steal_time(void);
> -void do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address);
> +void kvm_disable_steal_time(void);
> +bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token);
> +
> +DECLARE_STATIC_KEY_FALSE(kvm_async_pf_enabled);
> +
> +static __always_inline bool kvm_handle_async_pf(struct pt_regs *regs, u32 token)
> +{
> +	if (static_branch_unlikely(&kvm_async_pf_enabled))
> +		return __kvm_handle_async_pf(regs, token);
> +	else
> +		return false;
> +}
>  
>  #ifdef CONFIG_PARAVIRT_SPINLOCKS
>  void __init kvm_spinlock_init(void);
> @@ -130,6 +140,11 @@ static inline void kvm_disable_steal_tim
>  {
>  	return;
>  }
> +
> +static inline bool kvm_handle_async_pf(struct pt_regs *regs, u32 token)
> +{
> +	return false;
> +}
>  #endif
>  
>  #endif /* _ASM_X86_KVM_PARA_H */
> --- a/arch/x86/include/asm/x86_init.h
> +++ b/arch/x86/include/asm/x86_init.h
> @@ -50,14 +50,12 @@ struct x86_init_resources {
>   * @pre_vector_init:		init code to run before interrupt vectors
>   *				are set up.
>   * @intr_init:			interrupt init code
> - * @trap_init:			platform specific trap setup
>   * @intr_mode_select:		interrupt delivery mode selection
>   * @intr_mode_init:		interrupt delivery mode setup
>   */
>  struct x86_init_irqs {
>  	void (*pre_vector_init)(void);
>  	void (*intr_init)(void);
> -	void (*trap_init)(void);
>  	void (*intr_mode_select)(void);
>  	void (*intr_mode_init)(void);
>  };
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -35,6 +35,8 @@
>  #include <asm/tlb.h>
>  #include <asm/cpuidle_haltpoll.h>
>  
> +DEFINE_STATIC_KEY_FALSE(kvm_async_pf_enabled);
> +
>  static int kvmapf = 1;
>  
>  static int __init parse_no_kvmapf(char *arg)
> @@ -242,25 +244,27 @@ u32 kvm_read_and_reset_pf_reason(void)
>  EXPORT_SYMBOL_GPL(kvm_read_and_reset_pf_reason);
>  NOKPROBE_SYMBOL(kvm_read_and_reset_pf_reason);
>  
> -dotraplinkage void
> -do_async_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address)
> +bool __kvm_handle_async_pf(struct pt_regs *regs, u32 token)
>  {
> +	/*
> +	 * If we get a page fault right here, the pf_reason seems likely
> +	 * to be clobbered.  Bummer.
> +	 */
>  	switch (kvm_read_and_reset_pf_reason()) {
>  	default:
> -		do_page_fault(regs, error_code, address);
> -		break;
> +		return false;
>  	case KVM_PV_REASON_PAGE_NOT_PRESENT:
>  		/* page is swapped out by the host. */
> -		kvm_async_pf_task_wait((u32)address, !user_mode(regs));
> -		break;
> +		kvm_async_pf_task_wait(token, !user_mode(regs));
> +		return true;
>  	case KVM_PV_REASON_PAGE_READY:
>  		rcu_irq_enter();
> -		kvm_async_pf_task_wake((u32)address);
> +		kvm_async_pf_task_wake(token);
>  		rcu_irq_exit();
> -		break;
> +		return true;
>  	}
>  }
> -NOKPROBE_SYMBOL(do_async_page_fault);
> +NOKPROBE_SYMBOL(__kvm_handle_async_pf);
>  
>  static void __init paravirt_ops_setup(void)
>  {
> @@ -306,7 +310,11 @@ static notrace void kvm_guest_apic_eoi_w
>  static void kvm_guest_cpu_init(void)
>  {
>  	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF) && kvmapf) {
> -		u64 pa = slow_virt_to_phys(this_cpu_ptr(&apf_reason));
> +		u64 pa;
> +
> +		WARN_ON_ONCE(!static_branch_likely(&kvm_async_pf_enabled));
> +
> +		pa = slow_virt_to_phys(this_cpu_ptr(&apf_reason));
>  
>  #ifdef CONFIG_PREEMPTION
>  		pa |= KVM_ASYNC_PF_SEND_ALWAYS;
> @@ -592,12 +600,6 @@ static int kvm_cpu_down_prepare(unsigned
>  }
>  #endif
>  
> -static void __init kvm_apf_trap_init(void)
> -{
> -	update_intr_gate(X86_TRAP_PF, async_page_fault);
> -}
> -
> -
>  static void kvm_flush_tlb_others(const struct cpumask *cpumask,
>  			const struct flush_tlb_info *info)
>  {
> @@ -632,8 +634,6 @@ static void __init kvm_guest_init(void)
>  	register_reboot_notifier(&kvm_pv_reboot_nb);
>  	for (i = 0; i < KVM_TASK_SLEEP_HASHSIZE; i++)
>  		raw_spin_lock_init(&async_pf_sleepers[i].lock);
> -	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF))
> -		x86_init.irqs.trap_init = kvm_apf_trap_init;
>  
>  	if (kvm_para_has_feature(KVM_FEATURE_STEAL_TIME)) {
>  		has_steal_clock = 1;
> @@ -649,6 +649,9 @@ static void __init kvm_guest_init(void)
>  	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
>  		apic_set_eoi_write(kvm_guest_apic_eoi_write);
>  
> +	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF) && kvmapf)
> +		static_branch_enable(&kvm_async_pf_enabled);
> +
>  #ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_cpus = kvm_smp_prepare_cpus;
>  	smp_ops.smp_prepare_boot_cpu = kvm_smp_prepare_boot_cpu;
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -988,7 +988,5 @@ void __init trap_init(void)
>  
>  	idt_setup_ist_traps();
>  
> -	x86_init.irqs.trap_init();
> -
>  	idt_setup_debugidt_traps();
>  }
> --- a/arch/x86/kernel/x86_init.c
> +++ b/arch/x86/kernel/x86_init.c
> @@ -79,7 +79,6 @@ struct x86_init_ops x86_init __initdata
>  	.irqs = {
>  		.pre_vector_init	= init_ISA_irqs,
>  		.intr_init		= native_init_IRQ,
> -		.trap_init		= x86_init_noop,
>  		.intr_mode_select	= apic_intr_mode_select,
>  		.intr_mode_init		= apic_intr_mode_init
>  	},
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c
> @@ -30,6 +30,7 @@
>  #include <asm/desc.h>			/* store_idt(), ...		*/
>  #include <asm/cpu_entry_area.h>		/* exception stack		*/
>  #include <asm/pgtable_areas.h>		/* VMALLOC_START, ...		*/
> +#include <asm/kvm_para.h>		/* kvm_handle_async_pf		*/
>  
>  #define CREATE_TRACE_POINTS
>  #include <asm/trace/exceptions.h>
> @@ -1523,6 +1524,24 @@ do_page_fault(struct pt_regs *regs, unsi
>  		unsigned long address)
>  {
>  	prefetchw(&current->mm->mmap_sem);
> +	/*
> +	 * KVM has two types of events that are, logically, interrupts, but
> +	 * are unfortunately delivered using the #PF vector.  These events are
> +	 * "you just accessed valid memory, but the host doesn't have it right
> +	 * now, so I'll put you to sleep if you continue" and "that memory
> +	 * you tried to access earlier is available now."
> +	 *
> +	 * We are relying on the interrupted context being sane (valid RSP,
> +	 * relevant locks not held, etc.), which is fine as long as the
> +	 * interrupted context had IF=1.  We are also relying on the KVM
> +	 * async pf type field and CR2 being read consistently instead of
> +	 * getting values from real and async page faults mixed up.
> +	 *
> +	 * Fingers crossed.
> +	 */
> +	if (kvm_handle_async_pf(regs, (u32)address))
> +		return;
> +
>  	trace_page_fault_entries(regs, hw_error_code, address);
>  
>  	if (unlikely(kmmio_fault(regs, address)))
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

