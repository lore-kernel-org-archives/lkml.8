Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E69A0C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B58022073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:02:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VZVTyq2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgCMOCY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:02:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35879 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726729AbgCMOCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584108143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3i7hBK/HmnhrILaRr2C1Odzb1IOSSspXK3muq9nJqKM=;
        b=VZVTyq2hDNqY5rVsUIjQSVMqrQDkX2nO1JdVYjnuGcPR8u1PwTUYWxqzQZtpQ+D5OGoQ40
        UjsBT+4cCCxs2QAOlhEmgZvT/4q58Os1CZZNvuUPbBP/yP0YkRDzaRmwc62bnaMH0h9vh4
        0KUJHAz9fei8Opc2p9V+/Zpc9iFilog=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-qBCd1uDPMV6Vk0QLYgzNyQ-1; Fri, 13 Mar 2020 10:02:19 -0400
X-MC-Unique: qBCd1uDPMV6Vk0QLYgzNyQ-1
Received: by mail-wm1-f72.google.com with SMTP id e26so2956612wmk.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 07:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3i7hBK/HmnhrILaRr2C1Odzb1IOSSspXK3muq9nJqKM=;
        b=Ugrv8uT6lvl4A2hm8yTO60cXj31hiua1PeAZKt2/+mb8BEO5eWxTL4TxtlSRo7A+7W
         alhPfgmxm0lDnRzGxdraWrjd8t/Wgq4hRZW2G4hZAxAQUiBTXBEzA1lfSuryBnlwygmw
         594AMxyIguQAkq/7o4W2+katMuy33V/Ngmqz99/THwintqj8mN5krvTgFIGe3Le3QF31
         wgqYMo0ID1XyKnFlJ4gUhyp73VMVkDZorvf+rJq2cF5qCTwDLoKBTZS5uRCWKQ/SzZUw
         va3YYeeuUW7bfASgxQC74qIzstDzqhvXYlQHbPc+KC538y7c/P/ONfNW1P0vyuG+WYRW
         Yk7A==
X-Gm-Message-State: ANhLgQ2NsiLRzLk6QbBm8KmILU/ZPctgajtzCJQiMvUVTVIbjReECj59
        2RYHHYgj2SwP2EYzuRC2Q6j+Q0SSlJLWZ8YH3bPUhA7NX8snZAs5SLAoKY5xypzrpeDCxpkgw7o
        6NVuUvZXbLP/oyq3jR/1wl0TN
X-Received: by 2002:a7b:c5da:: with SMTP id n26mr10667918wmk.138.1584108138406;
        Fri, 13 Mar 2020 07:02:18 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs+hDDOrm44+SR+aBz6r8AgrG8mz8l1qzVsX9PfsqZEyl51N/a1cTIyusInSsiP03l9NBZtNA==
X-Received: by 2002:a7b:c5da:: with SMTP id n26mr10667891wmk.138.1584108138098;
        Fri, 13 Mar 2020 07:02:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f15sm16977174wmj.25.2020.03.13.07.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 07:02:15 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH 08/10] KVM: nVMX: Rename exit_reason to vm_exit_reason for nested VM-Exit
In-Reply-To: <20200312184521.24579-9-sean.j.christopherson@intel.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com> <20200312184521.24579-9-sean.j.christopherson@intel.com>
Date:   Fri, 13 Mar 2020 15:01:55 +0100
Message-ID: <87k13onyjw.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Use "vm_exit_reason" when passing around the full exit reason for nested
> VM-Exits to make it clear that it's not just the basic exit reason.  The
> basic exit reason (bits 15:0 of vmcs.VM_EXIT_REASON) is colloquially
> referred to as simply "exit reason", e.g. vmx_handle_vmexit() tracks the
> basic exit reason in a local variable named "exit_reason".
>

Would it make sense to stop using 'exit_reason' without a prefix (full,
basic,...) completely?

> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 29 +++++++++++++++--------------
>  arch/x86/kvm/vmx/nested.h |  2 +-
>  2 files changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 86b12a2918c5..c775feca3eb0 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -328,19 +328,19 @@ static void nested_ept_inject_page_fault(struct kvm_vcpu *vcpu,
>  {
>  	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> -	u32 exit_reason;
> +	u32 vm_exit_reason;
>  	unsigned long exit_qualification = vcpu->arch.exit_qualification;
>  
>  	if (vmx->nested.pml_full) {
> -		exit_reason = EXIT_REASON_PML_FULL;
> +		vm_exit_reason = EXIT_REASON_PML_FULL;
>  		vmx->nested.pml_full = false;
>  		exit_qualification &= INTR_INFO_UNBLOCK_NMI;
>  	} else if (fault->error_code & PFERR_RSVD_MASK)
> -		exit_reason = EXIT_REASON_EPT_MISCONFIG;
> +		vm_exit_reason = EXIT_REASON_EPT_MISCONFIG;
>  	else
> -		exit_reason = EXIT_REASON_EPT_VIOLATION;
> +		vm_exit_reason = EXIT_REASON_EPT_VIOLATION;
>  
> -	nested_vmx_vmexit(vcpu, exit_reason, 0, exit_qualification);
> +	nested_vmx_vmexit(vcpu, vm_exit_reason, 0, exit_qualification);
>  	vmcs12->guest_physical_address = fault->address;
>  }
>  
> @@ -3919,11 +3919,11 @@ static void sync_vmcs02_to_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12)
>   * which already writes to vmcs12 directly.
>   */
>  static void prepare_vmcs12(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
> -			   u32 exit_reason, u32 exit_intr_info,
> +			   u32 vm_exit_reason, u32 exit_intr_info,
>  			   unsigned long exit_qualification)
>  {
>  	/* update exit information fields: */
> -	vmcs12->vm_exit_reason = exit_reason;
> +	vmcs12->vm_exit_reason = vm_exit_reason;
>  	vmcs12->exit_qualification = exit_qualification;
>  	vmcs12->vm_exit_intr_info = exit_intr_info;
>  
> @@ -4252,7 +4252,7 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
>   * and modify vmcs12 to make it see what it would expect to see there if
>   * L2 was its real guest. Must only be called when in L2 (is_guest_mode())
>   */
> -void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
> +void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
>  		       u32 exit_intr_info, unsigned long exit_qualification)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> @@ -4272,9 +4272,9 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
>  	if (likely(!vmx->fail)) {
>  		sync_vmcs02_to_vmcs12(vcpu, vmcs12);
>  
> -		if (exit_reason != -1)
> -			prepare_vmcs12(vcpu, vmcs12, exit_reason, exit_intr_info,
> -				       exit_qualification);
> +		if (vm_exit_reason != -1)
> +			prepare_vmcs12(vcpu, vmcs12, vm_exit_reason,
> +				       exit_intr_info, exit_qualification);
>  
>  		/*
>  		 * Must happen outside of sync_vmcs02_to_vmcs12() as it will
> @@ -4330,14 +4330,15 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
>  	 */
>  	kvm_make_request(KVM_REQ_APIC_PAGE_RELOAD, vcpu);
>  
> -	if ((exit_reason != -1) && (enable_shadow_vmcs || vmx->nested.hv_evmcs))
> +	if ((vm_exit_reason != -1) &&
> +	    (enable_shadow_vmcs || vmx->nested.hv_evmcs))
>  		vmx->nested.need_vmcs12_to_shadow_sync = true;
>  
>  	/* in case we halted in L2 */
>  	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
>  
>  	if (likely(!vmx->fail)) {
> -		if ((u16)exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT &&
> +		if ((u16)vm_exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT &&
>  		    nested_exit_intr_ack_set(vcpu)) {
>  			int irq = kvm_cpu_get_interrupt(vcpu);
>  			WARN_ON(irq < 0);
> @@ -4345,7 +4346,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
>  				INTR_INFO_VALID_MASK | INTR_TYPE_EXT_INTR;
>  		}
>  
> -		if (exit_reason != -1)
> +		if (vm_exit_reason != -1)
>  			trace_kvm_nested_vmexit_inject(vmcs12->vm_exit_reason,
>  						       vmcs12->exit_qualification,
>  						       vmcs12->idt_vectoring_info_field,
> diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
> index 569cb828b6ca..04584bcbcc8d 100644
> --- a/arch/x86/kvm/vmx/nested.h
> +++ b/arch/x86/kvm/vmx/nested.h
> @@ -25,7 +25,7 @@ void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu);
>  enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
>  						     bool from_vmentry);
>  bool nested_vmx_exit_reflected(struct kvm_vcpu *vcpu);
> -void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
> +void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
>  		       u32 exit_intr_info, unsigned long exit_qualification);
>  void nested_sync_vmcs12_to_shadow(struct kvm_vcpu *vcpu);
>  int vmx_set_vmx_msr(struct kvm_vcpu *vcpu, u32 msr_index, u64 data);

Reviewded-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

