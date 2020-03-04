Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FUZZY_XPILL,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B8EEC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F22EC214D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 07:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XNqtsFW7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgCDHX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 02:23:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23609 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727176AbgCDHX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 02:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583306606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YF/7RXvsc3v2wcmFzJKJrYQAa423BkAdC7akSOEWUJk=;
        b=XNqtsFW75I6TS8qJdR+Z0eFENrxA1VFGSLM9fYRK1bHlAkN/GJFHRNc/qDXjRk+bESvjf3
        +FAQVZJQ1KVkTvcL/OYYldBhqpRhiYxnSivlLoypxY0tKoBsjvaSjoquJdkXlxTqhGcw13
        VwRsnetv1Vi4bVeY/GeSxMKzNAz8O3Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-t5KmPQK5O-68PwbE0TAdYA-1; Wed, 04 Mar 2020 02:23:22 -0500
X-MC-Unique: t5KmPQK5O-68PwbE0TAdYA-1
Received: by mail-wm1-f71.google.com with SMTP id b67so205001wmb.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 23:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YF/7RXvsc3v2wcmFzJKJrYQAa423BkAdC7akSOEWUJk=;
        b=C++D/SYtmassDxkgRYq2zBpCnf013dISeb7y4OU32yCUiwgXg9QRLXmDzhPA1FypDn
         ROR6TkwRAETWjwMrS4OOhX+aS4vT5URkd2+NU0F7+k2lSqvO/ajVDPMmrgrN9yhMstQ+
         ysp27DIW8R5o4H1sngB55/pJ24H3+G7kRgMWMLs/RlwFcq1D0rhtqwCNUPn2vStjo4PY
         YvOtznu6qRyBKcTnSSM+j1kzZ7JM5blXuohqjWIzyJCexes2qsBWcDjhCmGk4C1Y1VKf
         F8QvUullVC3afhOZ/gVXTFNGA6uBMi0DKKaslGHwlB9oEKOcbjWVqSYNnCuV5wxZ/y6R
         CyOA==
X-Gm-Message-State: ANhLgQ2DdoTz8VWLLgj6R/9yecY/q6YfGCAodYFl76+cLQe14D8LEjku
        OTvJNCNJr/y/sLitUdjqurZBJBhetNpoQThj07dYlmIDRiI8BP3sKY7fK8viw2xi4h7kiOZTKla
        0UimgRD9CX/KuCWUG+TgezWdi
X-Received: by 2002:adf:e910:: with SMTP id f16mr2579723wrm.20.1583306601467;
        Tue, 03 Mar 2020 23:23:21 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvjxOGb9+U6wxwnM5YxR3PVSTFYcoT6C+DKM51yQbOCoaz/dp95huA26j8IVU8sIdOAyy19Ew==
X-Received: by 2002:adf:e910:: with SMTP id f16mr2579684wrm.20.1583306601089;
        Tue, 03 Mar 2020 23:23:21 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id g129sm3137600wmg.12.2020.03.03.23.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 23:23:20 -0800 (PST)
Subject: Re: [PATCH 5.5 111/176] KVM: nVMX: Emulate MTF when performing
 instruction emulation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Oliver Upton <oupton@google.com>
References: <20200303174304.593872177@linuxfoundation.org>
 <20200303174317.670749078@linuxfoundation.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8780cf08-374b-da06-0047-0fe8eeec0113@redhat.com>
Date:   Wed, 4 Mar 2020 08:23:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200303174317.670749078@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 18:42, Greg Kroah-Hartman wrote:
> From: Oliver Upton <oupton@google.com>
> 
> commit 5ef8acbdd687c9d72582e2c05c0b9756efb37863 upstream.
> 
> Since commit 5f3d45e7f282 ("kvm/x86: add support for
> MONITOR_TRAP_FLAG"), KVM has allowed an L1 guest to use the monitor trap
> flag processor-based execution control for its L2 guest. KVM simply
> forwards any MTF VM-exits to the L1 guest, which works for normal
> instruction execution.
> 
> However, when KVM needs to emulate an instruction on the behalf of an L2
> guest, the monitor trap flag is not emulated. Add the necessary logic to
> kvm_skip_emulated_instruction() to synthesize an MTF VM-exit to L1 upon
> instruction emulation for L2.
> 
> Fixes: 5f3d45e7f282 ("kvm/x86: add support for MONITOR_TRAP_FLAG")
> Signed-off-by: Oliver Upton <oupton@google.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Why is this included in a stable release?  It was part of a series of
four patches and the prerequisites as far as I can see are not part of 5.5.

I have already said half a dozen times that I don't want any of the
autopick stuff for KVM.  Is a Fixes tag sufficient to get patches into
stable now?

Paolo

> ---
>  arch/x86/include/asm/kvm_host.h |    1 +
>  arch/x86/include/uapi/asm/kvm.h |    1 +
>  arch/x86/kvm/svm.c              |    1 +
>  arch/x86/kvm/vmx/nested.c       |   35 ++++++++++++++++++++++++++++++++++-
>  arch/x86/kvm/vmx/nested.h       |    5 +++++
>  arch/x86/kvm/vmx/vmx.c          |   37 ++++++++++++++++++++++++++++++++++++-
>  arch/x86/kvm/vmx/vmx.h          |    3 +++
>  arch/x86/kvm/x86.c              |    2 ++
>  8 files changed, 83 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1092,6 +1092,7 @@ struct kvm_x86_ops {
>  	void (*run)(struct kvm_vcpu *vcpu);
>  	int (*handle_exit)(struct kvm_vcpu *vcpu);
>  	int (*skip_emulated_instruction)(struct kvm_vcpu *vcpu);
> +	void (*update_emulated_instruction)(struct kvm_vcpu *vcpu);
>  	void (*set_interrupt_shadow)(struct kvm_vcpu *vcpu, int mask);
>  	u32 (*get_interrupt_shadow)(struct kvm_vcpu *vcpu);
>  	void (*patch_hypercall)(struct kvm_vcpu *vcpu,
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -390,6 +390,7 @@ struct kvm_sync_regs {
>  #define KVM_STATE_NESTED_GUEST_MODE	0x00000001
>  #define KVM_STATE_NESTED_RUN_PENDING	0x00000002
>  #define KVM_STATE_NESTED_EVMCS		0x00000004
> +#define KVM_STATE_NESTED_MTF_PENDING	0x00000008
>  
>  #define KVM_STATE_NESTED_SMM_GUEST_MODE	0x00000001
>  #define KVM_STATE_NESTED_SMM_VMXON	0x00000002
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -7311,6 +7311,7 @@ static struct kvm_x86_ops svm_x86_ops __
>  	.run = svm_vcpu_run,
>  	.handle_exit = handle_exit,
>  	.skip_emulated_instruction = skip_emulated_instruction,
> +	.update_emulated_instruction = NULL,
>  	.set_interrupt_shadow = svm_set_interrupt_shadow,
>  	.get_interrupt_shadow = svm_get_interrupt_shadow,
>  	.patch_hypercall = svm_patch_hypercall,
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3616,8 +3616,15 @@ static int vmx_check_nested_events(struc
>  	unsigned long exit_qual;
>  	bool block_nested_events =
>  	    vmx->nested.nested_run_pending || kvm_event_needs_reinjection(vcpu);
> +	bool mtf_pending = vmx->nested.mtf_pending;
>  	struct kvm_lapic *apic = vcpu->arch.apic;
>  
> +	/*
> +	 * Clear the MTF state. If a higher priority VM-exit is delivered first,
> +	 * this state is discarded.
> +	 */
> +	vmx->nested.mtf_pending = false;
> +
>  	if (lapic_in_kernel(vcpu) &&
>  		test_bit(KVM_APIC_INIT, &apic->pending_events)) {
>  		if (block_nested_events)
> @@ -3628,8 +3635,28 @@ static int vmx_check_nested_events(struc
>  		return 0;
>  	}
>  
> +	/*
> +	 * Process any exceptions that are not debug traps before MTF.
> +	 */
> +	if (vcpu->arch.exception.pending &&
> +	    !vmx_pending_dbg_trap(vcpu) &&
> +	    nested_vmx_check_exception(vcpu, &exit_qual)) {
> +		if (block_nested_events)
> +			return -EBUSY;
> +		nested_vmx_inject_exception_vmexit(vcpu, exit_qual);
> +		return 0;
> +	}
> +
> +	if (mtf_pending) {
> +		if (block_nested_events)
> +			return -EBUSY;
> +		nested_vmx_update_pending_dbg(vcpu);
> +		nested_vmx_vmexit(vcpu, EXIT_REASON_MONITOR_TRAP_FLAG, 0, 0);
> +		return 0;
> +	}
> +
>  	if (vcpu->arch.exception.pending &&
> -		nested_vmx_check_exception(vcpu, &exit_qual)) {
> +	    nested_vmx_check_exception(vcpu, &exit_qual)) {
>  		if (block_nested_events)
>  			return -EBUSY;
>  		nested_vmx_inject_exception_vmexit(vcpu, exit_qual);
> @@ -5742,6 +5769,9 @@ static int vmx_get_nested_state(struct k
>  
>  			if (vmx->nested.nested_run_pending)
>  				kvm_state.flags |= KVM_STATE_NESTED_RUN_PENDING;
> +
> +			if (vmx->nested.mtf_pending)
> +				kvm_state.flags |= KVM_STATE_NESTED_MTF_PENDING;
>  		}
>  	}
>  
> @@ -5922,6 +5952,9 @@ static int vmx_set_nested_state(struct k
>  	vmx->nested.nested_run_pending =
>  		!!(kvm_state->flags & KVM_STATE_NESTED_RUN_PENDING);
>  
> +	vmx->nested.mtf_pending =
> +		!!(kvm_state->flags & KVM_STATE_NESTED_MTF_PENDING);
> +
>  	ret = -EINVAL;
>  	if (nested_cpu_has_shadow_vmcs(vmcs12) &&
>  	    vmcs12->vmcs_link_pointer != -1ull) {
> --- a/arch/x86/kvm/vmx/nested.h
> +++ b/arch/x86/kvm/vmx/nested.h
> @@ -176,6 +176,11 @@ static inline bool nested_cpu_has_virtua
>  	return vmcs12->pin_based_vm_exec_control & PIN_BASED_VIRTUAL_NMIS;
>  }
>  
> +static inline int nested_cpu_has_mtf(struct vmcs12 *vmcs12)
> +{
> +	return nested_cpu_has(vmcs12, CPU_BASED_MONITOR_TRAP_FLAG);
> +}
> +
>  static inline int nested_cpu_has_ept(struct vmcs12 *vmcs12)
>  {
>  	return nested_cpu_has2(vmcs12, SECONDARY_EXEC_ENABLE_EPT);
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1595,6 +1595,40 @@ static int skip_emulated_instruction(str
>  	return 1;
>  }
>  
> +
> +/*
> + * Recognizes a pending MTF VM-exit and records the nested state for later
> + * delivery.
> + */
> +static void vmx_update_emulated_instruction(struct kvm_vcpu *vcpu)
> +{
> +	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +
> +	if (!is_guest_mode(vcpu))
> +		return;
> +
> +	/*
> +	 * Per the SDM, MTF takes priority over debug-trap exceptions besides
> +	 * T-bit traps. As instruction emulation is completed (i.e. at the
> +	 * instruction boundary), any #DB exception pending delivery must be a
> +	 * debug-trap. Record the pending MTF state to be delivered in
> +	 * vmx_check_nested_events().
> +	 */
> +	if (nested_cpu_has_mtf(vmcs12) &&
> +	    (!vcpu->arch.exception.pending ||
> +	     vcpu->arch.exception.nr == DB_VECTOR))
> +		vmx->nested.mtf_pending = true;
> +	else
> +		vmx->nested.mtf_pending = false;
> +}
> +
> +static int vmx_skip_emulated_instruction(struct kvm_vcpu *vcpu)
> +{
> +	vmx_update_emulated_instruction(vcpu);
> +	return skip_emulated_instruction(vcpu);
> +}
> +
>  static void vmx_clear_hlt(struct kvm_vcpu *vcpu)
>  {
>  	/*
> @@ -7886,7 +7920,8 @@ static struct kvm_x86_ops vmx_x86_ops __
>  
>  	.run = vmx_vcpu_run,
>  	.handle_exit = vmx_handle_exit,
> -	.skip_emulated_instruction = skip_emulated_instruction,
> +	.skip_emulated_instruction = vmx_skip_emulated_instruction,
> +	.update_emulated_instruction = vmx_update_emulated_instruction,
>  	.set_interrupt_shadow = vmx_set_interrupt_shadow,
>  	.get_interrupt_shadow = vmx_get_interrupt_shadow,
>  	.patch_hypercall = vmx_patch_hypercall,
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -150,6 +150,9 @@ struct nested_vmx {
>  	/* L2 must run next, and mustn't decide to exit to L1. */
>  	bool nested_run_pending;
>  
> +	/* Pending MTF VM-exit into L1.  */
> +	bool mtf_pending;
> +
>  	struct loaded_vmcs vmcs02;
>  
>  	/*
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6838,6 +6838,8 @@ restart:
>  			kvm_rip_write(vcpu, ctxt->eip);
>  			if (r && ctxt->tf)
>  				r = kvm_vcpu_do_singlestep(vcpu);
> +			if (kvm_x86_ops->update_emulated_instruction)
> +				kvm_x86_ops->update_emulated_instruction(vcpu);
>  			__kvm_set_rflags(vcpu, ctxt->eflags);
>  		}
>  
> 
> 

