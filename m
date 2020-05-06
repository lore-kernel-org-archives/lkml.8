Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC63C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40B8A206E6
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 08:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aCBq0sim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgEFIRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 04:17:14 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24140 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728217AbgEFIRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 04:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588753031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZgeBkhkqKFZWm7UrNBjp1kIugTDCBMTnDqHiAzL9SVE=;
        b=aCBq0sim5DvaqZVwubqLKiQUP7+4DylmyYBOLenVXT2mQncKv1hqm2SqocA6zRZ3l3eLaO
        1jS4p3Y5lRbTypQXDME2qSWoPWL72ab4KSpvY7offYvPmKS5VsptAfdo80W9I2zOUoKQEj
        TRFBk9QZ8A5xBAI7vbH3uQlpu206z0o=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-d7aqYCBnMlaYKpDfOY3Xxw-1; Wed, 06 May 2020 04:17:09 -0400
X-MC-Unique: d7aqYCBnMlaYKpDfOY3Xxw-1
Received: by mail-wm1-f69.google.com with SMTP id f128so800974wmf.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 01:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZgeBkhkqKFZWm7UrNBjp1kIugTDCBMTnDqHiAzL9SVE=;
        b=m+C8ZoNjSP2RN+gYh+vxbJ9r5GW3K/1/jrR7Ht7sEVaXk94Iu0AsWqk4pTuHIjPFBM
         oLxKf9ycDIgM/tdwvq6qGtaPK4lHaF6FCKbpBmcp/pqqD1QPqqit1T7ombCgR8fsoHvV
         eEbGlQ0S0z3c5SUWROo8iR2yu9S3a/Sg11YuTdpvzqYFVIcWpeWAzc41ld41FVmectkW
         chhmahLRoSsPC2Lz+O2Ge3eNprDR3I3xpR/pQXwaQ6TrQDxUEzPkgzsUxt/pKExLkH5c
         /asAoPzIlTKWQSteOBZ9YuPTDsS2+g4a1PmzqHijTvnkoh4WIjRQEEYtrmTThXof1vFd
         E+2Q==
X-Gm-Message-State: AGi0Pub1fPr9Bo5EeGoh7wzEr4gRsZRFWdCjhdDOkhOSvzJxmK8K9cGS
        qk7rr8b3xBIp23UsBKJ6ejFI2CfG5XP+njXvmFn8Dl0P0CuzL1KG3E5MwvmTh/oka5b+uKxgB4q
        hVw1ofXUPg3GDEZWUfl7FiHqi
X-Received: by 2002:a1c:f606:: with SMTP id w6mr2923970wmc.59.1588753028663;
        Wed, 06 May 2020 01:17:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypJyqB4LJzqMSttfWYtSx0d1SXRmZGSU5Do/SzD0f1w0x7UL1rUXX2/knGOa3JjhM4uYU6C4aQ==
X-Received: by 2002:a1c:f606:: with SMTP id w6mr2923940wmc.59.1588753028282;
        Wed, 06 May 2020 01:17:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:11d7:2f21:f38b:17e? ([2001:b07:6468:f312:11d7:2f21:f38b:17e])
        by smtp.gmail.com with ESMTPSA id s24sm1845388wmj.28.2020.05.06.01.17.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 01:17:07 -0700 (PDT)
Subject: Re: [patch V4 part 2 17/18] x86/kvm/vmx: Move guest enter/exit into
 .noinstr.text
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
References: <20200505134112.272268764@linutronix.de>
 <20200505134341.781667216@linutronix.de>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <414b554c-ba2c-c5b2-00bd-6c5222e54a82@redhat.com>
Date:   Wed, 6 May 2020 10:17:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200505134341.781667216@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 15:41, Thomas Gleixner wrote:
> Move the functions which are inside the RCU off region into the
> non-instrumentable text section.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/hardirq.h  |    4 -
>  arch/x86/include/asm/kvm_host.h |    8 +++
>  arch/x86/kvm/vmx/ops.h          |    4 +
>  arch/x86/kvm/vmx/vmenter.S      |    5 +
>  arch/x86/kvm/vmx/vmx.c          |  105 ++++++++++++++++++++++------------------
>  arch/x86/kvm/x86.c              |    2 
>  6 files changed, 79 insertions(+), 49 deletions(-)
> 
> --- a/arch/x86/include/asm/hardirq.h
> +++ b/arch/x86/include/asm/hardirq.h
> @@ -67,12 +67,12 @@ static inline void kvm_set_cpu_l1tf_flus
>  	__this_cpu_write(irq_stat.kvm_cpu_l1tf_flush_l1d, 1);
>  }
>  
> -static inline void kvm_clear_cpu_l1tf_flush_l1d(void)
> +static __always_inline void kvm_clear_cpu_l1tf_flush_l1d(void)
>  {
>  	__this_cpu_write(irq_stat.kvm_cpu_l1tf_flush_l1d, 0);
>  }
>  
> -static inline bool kvm_get_cpu_l1tf_flush_l1d(void)
> +static __always_inline bool kvm_get_cpu_l1tf_flush_l1d(void)
>  {
>  	return __this_cpu_read(irq_stat.kvm_cpu_l1tf_flush_l1d);
>  }
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1601,7 +1601,15 @@ asmlinkage void kvm_spurious_fault(void)
>  	insn "\n\t"							\
>  	"jmp	668f \n\t"						\
>  	"667: \n\t"							\
> +	"1: \n\t"							\
> +	".pushsection .discard.instr_begin \n\t"			\
> +	".long 1b - . \n\t"						\
> +	".popsection \n\t"						\
>  	"call	kvm_spurious_fault \n\t"				\
> +	"1: \n\t"							\
> +	".pushsection .discard.instr_end \n\t"				\
> +	".long 1b - . \n\t"						\
> +	".popsection \n\t"						\
>  	"668: \n\t"							\
>  	_ASM_EXTABLE(666b, 667b)
>  
> --- a/arch/x86/kvm/vmx/ops.h
> +++ b/arch/x86/kvm/vmx/ops.h
> @@ -146,7 +146,9 @@ do {									\
>  			  : : op1 : "cc" : error, fault);		\
>  	return;								\
>  error:									\
> +	instr_begin();							\
>  	insn##_error(error_args);					\
> +	instr_end();							\
>  	return;								\
>  fault:									\
>  	kvm_spurious_fault();						\
> @@ -161,7 +163,9 @@ do {									\
>  			  : : op1, op2 : "cc" : error, fault);		\
>  	return;								\
>  error:									\
> +	instr_begin();							\
>  	insn##_error(error_args);					\
> +	instr_end();							\
>  	return;								\
>  fault:									\
>  	kvm_spurious_fault();						\
> --- a/arch/x86/kvm/vmx/vmenter.S
> +++ b/arch/x86/kvm/vmx/vmenter.S
> @@ -27,7 +27,7 @@
>  #define VCPU_R15	__VCPU_REGS_R15 * WORD_SIZE
>  #endif
>  
> -	.text
> +.section .noinstr.text, "ax"
>  
>  /**
>   * vmx_vmenter - VM-Enter the current loaded VMCS
> @@ -231,6 +231,9 @@ SYM_FUNC_START(__vmx_vcpu_run)
>  	jmp 1b
>  SYM_FUNC_END(__vmx_vcpu_run)
>  
> +
> +.section .text, "ax"
> +
>  /**
>   * vmread_error_trampoline - Trampoline from inline asm to vmread_error()
>   * @field:	VMCS field encoding that failed
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6000,7 +6000,7 @@ static int vmx_handle_exit(struct kvm_vc
>   * information but as all relevant affected CPUs have 32KiB L1D cache size
>   * there is no point in doing so.
>   */
> -static void vmx_l1d_flush(struct kvm_vcpu *vcpu)
> +static noinstr void vmx_l1d_flush(struct kvm_vcpu *vcpu)
>  {
>  	int size = PAGE_SIZE << L1D_CACHE_ORDER;
>  
> @@ -6033,7 +6033,7 @@ static void vmx_l1d_flush(struct kvm_vcp
>  	vcpu->stat.l1d_flush++;
>  
>  	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
> -		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
> +		native_wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
>  		return;
>  	}
>  
> @@ -6514,7 +6514,7 @@ static void vmx_update_hv_timer(struct k
>  	}
>  }
>  
> -void vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp)
> +void noinstr vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp)
>  {
>  	if (unlikely(host_rsp != vmx->loaded_vmcs->host_state.rsp)) {
>  		vmx->loaded_vmcs->host_state.rsp = host_rsp;
> @@ -6524,6 +6524,61 @@ void vmx_update_host_rsp(struct vcpu_vmx
>  
>  bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned long *regs, bool launched);
>  
> +static noinstr void vmx_vcpu_enter_exit(struct kvm_vcpu *vcpu,
> +					struct vcpu_vmx *vmx)
> +{
> +	instr_begin();
> +	/*
> +	 * VMENTER enables interrupts (host state), but the kernel state is
> +	 * interrupts disabled when this is invoked. Also tell RCU about
> +	 * it. This is the same logic as for exit_to_user_mode().
> +	 *
> +	 * 1) Trace interrupts on state
> +	 * 2) Prepare lockdep with RCU on
> +	 * 3) Invoke context tracking if enabled to adjust RCU state
> +	 * 4) Tell lockdep that interrupts are enabled
> +	 */
> +	trace_hardirqs_on_prepare();
> +	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
> +	instr_end();
> +
> +	guest_enter_irqoff();
> +	lockdep_hardirqs_on(CALLER_ADDR0);
> +
> +	/* L1D Flush includes CPU buffer clear to mitigate MDS */
> +	if (static_branch_unlikely(&vmx_l1d_should_flush))
> +		vmx_l1d_flush(vcpu);
> +	else if (static_branch_unlikely(&mds_user_clear))
> +		mds_clear_cpu_buffers();
> +
> +	if (vcpu->arch.cr2 != read_cr2())
> +		write_cr2(vcpu->arch.cr2);
> +
> +	vmx->fail = __vmx_vcpu_run(vmx, (unsigned long *)&vcpu->arch.regs,
> +				   vmx->loaded_vmcs->launched);
> +
> +	vcpu->arch.cr2 = read_cr2();
> +
> +	/*
> +	 * VMEXIT disables interrupts (host state), but tracing and lockdep
> +	 * have them in state 'on'. Same as enter_from_user_mode().
> +	 *
> +	 * 1) Tell lockdep that interrupts are disabled
> +	 * 2) Invoke context tracking if enabled to reactivate RCU
> +	 * 3) Trace interrupts off state
> +	 *
> +	 * This needs to be done before the below as native_read_msr()
> +	 * contains a tracepoint and x86_spec_ctrl_restore_host() calls
> +	 * into world and some more.
> +	 */
> +	lockdep_hardirqs_off(CALLER_ADDR0);
> +	guest_exit_irqoff();
> +
> +	instr_begin();
> +	trace_hardirqs_off_prepare();
> +	instr_end();
> +}
> +
>  static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> @@ -6604,49 +6659,9 @@ static void vmx_vcpu_run(struct kvm_vcpu
>  	x86_spec_ctrl_set_guest(vmx->spec_ctrl, 0);
>  
>  	/*
> -	 * VMENTER enables interrupts (host state), but the kernel state is
> -	 * interrupts disabled when this is invoked. Also tell RCU about
> -	 * it. This is the same logic as for exit_to_user_mode().
> -	 *
> -	 * 1) Trace interrupts on state
> -	 * 2) Prepare lockdep with RCU on
> -	 * 3) Invoke context tracking if enabled to adjust RCU state
> -	 * 4) Tell lockdep that interrupts are enabled
> +	 * The actual VMENTER/EXIT is in the .noinstr.text section.
>  	 */
> -	trace_hardirqs_on_prepare();
> -	lockdep_hardirqs_on_prepare(CALLER_ADDR0);
> -	guest_enter_irqoff();
> -	lockdep_hardirqs_on(CALLER_ADDR0);
> -
> -	/* L1D Flush includes CPU buffer clear to mitigate MDS */
> -	if (static_branch_unlikely(&vmx_l1d_should_flush))
> -		vmx_l1d_flush(vcpu);
> -	else if (static_branch_unlikely(&mds_user_clear))
> -		mds_clear_cpu_buffers();
> -
> -	if (vcpu->arch.cr2 != read_cr2())
> -		write_cr2(vcpu->arch.cr2);
> -
> -	vmx->fail = __vmx_vcpu_run(vmx, (unsigned long *)&vcpu->arch.regs,
> -				   vmx->loaded_vmcs->launched);
> -
> -	vcpu->arch.cr2 = read_cr2();
> -
> -	/*
> -	 * VMEXIT disables interrupts (host state), but tracing and lockdep
> -	 * have them in state 'on'. Same as enter_from_user_mode().
> -	 *
> -	 * 1) Tell lockdep that interrupts are disabled
> -	 * 2) Invoke context tracking if enabled to reactivate RCU
> -	 * 3) Trace interrupts off state
> -	 *
> -	 * This needs to be done before the below as native_read_msr()
> -	 * contains a tracepoint and x86_spec_ctrl_restore_host() calls
> -	 * into world and some more.
> -	 */
> -	lockdep_hardirqs_off(CALLER_ADDR0);
> -	guest_exit_irqoff();
> -	trace_hardirqs_off_prepare();
> +	vmx_vcpu_enter_exit(vcpu, vmx);
>  
>  	/*
>  	 * We do not use IBRS in the kernel. If this vCPU has used the
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -381,7 +381,7 @@ int kvm_set_apic_base(struct kvm_vcpu *v
>  }
>  EXPORT_SYMBOL_GPL(kvm_set_apic_base);
>  
> -asmlinkage __visible void kvm_spurious_fault(void)
> +asmlinkage __visible noinstr void kvm_spurious_fault(void)
>  {
>  	/* Fault while not rebooting.  We want the trace. */
>  	BUG_ON(!kvm_rebooting);
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

