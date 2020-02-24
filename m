Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A63C3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8478720836
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:16:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6wocfw0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgBXKQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:16:21 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49296 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727334AbgBXKQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:16:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582539379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Kq4++O1nJ2xbhxsH0Y7rUDiDzBqxZ2OnckPwbRx7g5E=;
        b=O6wocfw0rUK8Pqif5andAdYaHVG/UqI9IzHU4hoGmbZlYil2+fFkmeuyMjmlixR8wCDo9E
        mUmwXiuySf8SZrPnEFPPlTBoy82CJQrj4GjgdINJrKA6wjRRzo0dvbQTIG6RnJT/b0yd4R
        q6ll6MlwI8l9MDNHTtu+IeFnRBsgoHU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-SoJmaJCqN02FwFh-j890Kg-1; Mon, 24 Feb 2020 05:16:18 -0500
X-MC-Unique: SoJmaJCqN02FwFh-j890Kg-1
Received: by mail-wr1-f71.google.com with SMTP id u18so5349527wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 02:16:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Kq4++O1nJ2xbhxsH0Y7rUDiDzBqxZ2OnckPwbRx7g5E=;
        b=TfByO3PkRxJA9AMyBK+6Xlzr+ZmkhIBqmbmQV1vBZaPhASm0YuQdaHBWKLyrGm64nn
         LxQ487D6CJjobqz9DbcLMvHPFcuzRsMKcGbYOE9rhGTOcRixkbccvnVH06Im+XzjF8CZ
         Bv2vExVRRJv+YgX3Tx/qm7bmraRODPXkQE6YtTV2eMKFP3qlay+tkhCUeHm41wMkbtQo
         rB9vjVY0yMETwlQzgfXuBMF0uGO7Rm9oG5mBc+C9FWM82Q0gLLIoPovg/1vhkR+YQYIA
         t0jFq7dkjt09T8qZTN1AEF4RCp8U0Xhzdp+d4pK15VFMyEEfH66o3RwQ8huySVSZpa2Z
         yfpg==
X-Gm-Message-State: APjAAAWqq0PioNPYNY50g/lcKvA28OhMdVMEG28ln+vfsqJ84Yb2n8u6
        IZli25py1Win0EVNg8W8Kj3sqHU+WIsQJKUuyZaQ47MUkg3HIxhLr5SnQNfQqKp6+76WjonVf0y
        Vsha4nj+8LG3qFdmzKzguYiNU
X-Received: by 2002:a7b:ce18:: with SMTP id m24mr21399640wmc.123.1582539377203;
        Mon, 24 Feb 2020 02:16:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqylCJRWBb/luxHzmUReSOd7BP3O1InOwzmiN9oYW3EoUUuEEXUyy8MuXGpPFhPtU41epPYTJg==
X-Received: by 2002:a7b:ce18:: with SMTP id m24mr21399612wmc.123.1582539376905;
        Mon, 24 Feb 2020 02:16:16 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f207sm18350559wme.9.2020.02.24.02.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 02:16:16 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] kvm: vmx: Use basic exit reason to check if it's the specific VM EXIT
In-Reply-To: <20200224020751.1469-2-xiaoyao.li@intel.com>
References: <20200224020751.1469-1-xiaoyao.li@intel.com> <20200224020751.1469-2-xiaoyao.li@intel.com>
Date:   Mon, 24 Feb 2020 11:16:15 +0100
Message-ID: <87lfosp9xs.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> Current kvm uses the 32-bit exit reason to check if it's any specific VM
> EXIT, however only the low 16-bit of VM EXIT REASON acts as the basic
> exit reason.
>
> Introduce Macro basic(exit_reaso)

"exit_reason"

>  to help retrieve the basic exit reason
> from VM EXIT REASON, and use the basic exit reason for checking and
> indexing the exit hanlder.
>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 44 ++++++++++++++++++++++--------------------
>  arch/x86/kvm/vmx/vmx.h |  2 ++
>  2 files changed, 25 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9a6664886f2e..85da72d4dc92 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1584,7 +1584,7 @@ static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
>  	 * i.e. we end up advancing IP with some random value.
>  	 */
>  	if (!static_cpu_has(X86_FEATURE_HYPERVISOR) ||
> -	    to_vmx(vcpu)->exit_reason != EXIT_REASON_EPT_MISCONFIG) {
> +	    basic(to_vmx(vcpu)->exit_reason) != EXIT_REASON_EPT_MISCONFIG) {

"basic" word is probably 'too basic' to be used for this purpose. Even
if we need a macro for it (I'm not really convinced it improves the
readability), I'd suggest we name it 'basic_exit_reason()' instead.

>  		rip = kvm_rip_read(vcpu);
>  		rip += vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
>  		kvm_rip_write(vcpu, rip);
> @@ -5797,6 +5797,7 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  	u32 exit_reason = vmx->exit_reason;
> +	u16 basic_exit_reason = basic(exit_reason);

I don't think renaming local variable is needed, let's just do

'u16 exit_reason = basic_exit_reason(vmx->exit_reason)' and keep the
rest of the code as-is.

>  	u32 vectoring_info = vmx->idt_vectoring_info;
>  
>  	trace_kvm_exit(exit_reason, vcpu, KVM_ISA_VMX);
> @@ -5842,17 +5843,17 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
>  	 * will cause infinite loop.
>  	 */
>  	if ((vectoring_info & VECTORING_INFO_VALID_MASK) &&
> -			(exit_reason != EXIT_REASON_EXCEPTION_NMI &&
> -			exit_reason != EXIT_REASON_EPT_VIOLATION &&
> -			exit_reason != EXIT_REASON_PML_FULL &&
> -			exit_reason != EXIT_REASON_TASK_SWITCH)) {
> +			(basic_exit_reason != EXIT_REASON_EXCEPTION_NMI &&
> +			 basic_exit_reason != EXIT_REASON_EPT_VIOLATION &&
> +			 basic_exit_reason != EXIT_REASON_PML_FULL &&
> +			 basic_exit_reason != EXIT_REASON_TASK_SWITCH)) {
>  		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
>  		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_DELIVERY_EV;
>  		vcpu->run->internal.ndata = 3;
>  		vcpu->run->internal.data[0] = vectoring_info;
>  		vcpu->run->internal.data[1] = exit_reason;
>  		vcpu->run->internal.data[2] = vcpu->arch.exit_qualification;
> -		if (exit_reason == EXIT_REASON_EPT_MISCONFIG) {
> +		if (basic_exit_reason == EXIT_REASON_EPT_MISCONFIG) {
>  			vcpu->run->internal.ndata++;
>  			vcpu->run->internal.data[3] =
>  				vmcs_read64(GUEST_PHYSICAL_ADDRESS);
> @@ -5884,32 +5885,32 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
>  		return 1;
>  	}
>  
> -	if (exit_reason >= kvm_vmx_max_exit_handlers)
> +	if (basic_exit_reason >= kvm_vmx_max_exit_handlers)
>  		goto unexpected_vmexit;
>  #ifdef CONFIG_RETPOLINE
> -	if (exit_reason == EXIT_REASON_MSR_WRITE)
> +	if (basic_exit_reason == EXIT_REASON_MSR_WRITE)
>  		return kvm_emulate_wrmsr(vcpu);
> -	else if (exit_reason == EXIT_REASON_PREEMPTION_TIMER)
> +	else if (basic_exit_reason == EXIT_REASON_PREEMPTION_TIMER)
>  		return handle_preemption_timer(vcpu);
> -	else if (exit_reason == EXIT_REASON_INTERRUPT_WINDOW)
> +	else if (basic_exit_reason == EXIT_REASON_INTERRUPT_WINDOW)
>  		return handle_interrupt_window(vcpu);
> -	else if (exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT)
> +	else if (basic_exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT)
>  		return handle_external_interrupt(vcpu);
> -	else if (exit_reason == EXIT_REASON_HLT)
> +	else if (basic_exit_reason == EXIT_REASON_HLT)
>  		return kvm_emulate_halt(vcpu);
> -	else if (exit_reason == EXIT_REASON_EPT_MISCONFIG)
> +	else if (basic_exit_reason == EXIT_REASON_EPT_MISCONFIG)
>  		return handle_ept_misconfig(vcpu);
>  #endif
>  
> -	exit_reason = array_index_nospec(exit_reason,
> +	basic_exit_reason = array_index_nospec(basic_exit_reason,
>  					 kvm_vmx_max_exit_handlers);
> -	if (!kvm_vmx_exit_handlers[exit_reason])
> +	if (!kvm_vmx_exit_handlers[basic_exit_reason])
>  		goto unexpected_vmexit;
>  
> -	return kvm_vmx_exit_handlers[exit_reason](vcpu);
> +	return kvm_vmx_exit_handlers[basic_exit_reason](vcpu);
>  
>  unexpected_vmexit:
> -	vcpu_unimpl(vcpu, "vmx: unexpected exit reason 0x%x\n", exit_reason);
> +	vcpu_unimpl(vcpu, "vmx: unexpected exit reason 0x%x\n", basic_exit_reason);
>  	dump_vmcs();
>  	vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
>  	vcpu->run->internal.suberror =
> @@ -6241,13 +6242,14 @@ static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu,
>  	enum exit_fastpath_completion *exit_fastpath)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +	u16 basic_exit_reason = basic(vmx->exit_reason);

Here I'd suggest we also use the same 

'u16 exit_reason = basic_exit_reason(vmx->exit_reason)'

as above.

>  
> -	if (vmx->exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT)
> +	if (basic_exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT)
>  		handle_external_interrupt_irqoff(vcpu);
> -	else if (vmx->exit_reason == EXIT_REASON_EXCEPTION_NMI)
> +	else if (basic_exit_reason == EXIT_REASON_EXCEPTION_NMI)
>  		handle_exception_nmi_irqoff(vmx);
>  	else if (!is_guest_mode(vcpu) &&
> -		vmx->exit_reason == EXIT_REASON_MSR_WRITE)
> +		 basic_exit_reason == EXIT_REASON_MSR_WRITE)
>  		*exit_fastpath = handle_fastpath_set_msr_irqoff(vcpu);
>  }
>  
> @@ -6621,7 +6623,7 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  	vmx->idt_vectoring_info = 0;
>  
>  	vmx->exit_reason = vmx->fail ? 0xdead : vmcs_read32(VM_EXIT_REASON);
> -	if ((u16)vmx->exit_reason == EXIT_REASON_MCE_DURING_VMENTRY)
> +	if (basic(vmx->exit_reason) == EXIT_REASON_MCE_DURING_VMENTRY)
>  		kvm_machine_check();
>  
>  	if (vmx->fail || (vmx->exit_reason & VMX_EXIT_REASONS_FAILED_VMENTRY))
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 7f42cf3dcd70..c6ba33eedb59 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -22,6 +22,8 @@ extern u32 get_umwait_control_msr(void);
>  
>  #define X2APIC_MSR(r) (APIC_BASE_MSR + ((r) >> 4))
>  
> +#define basic(exit_reason) ((u16)(exit_reason))
> +
>  #ifdef CONFIG_X86_64
>  #define NR_SHARED_MSRS	7
>  #else

-- 
Vitaly

