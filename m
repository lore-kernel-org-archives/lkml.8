Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA9B5C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9077620746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dW9SFpX5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgCMMip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:38:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30193 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726636AbgCMMip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584103122;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=csF6v7e1b/VImX3TjVY+DMV4RBSRNtsLEqKn/tNdfec=;
        b=dW9SFpX5V8I5tl36nomQ0ZG7JmMItS7tzLRPK3i7X2pB0vIePKCMmXcwAN+UONxAMTqrYx
        IfYncXzz5usd5ZImKgSm3QWrkUQajjyogsOva7uPYF5ElzodDNgBVXI7iBLfc1C7WYBOVf
        c6ypmnL2uP1AonroAiOJnrBq26yw1IE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-ndBVpndxOZ67aFGCLLvTnQ-1; Fri, 13 Mar 2020 08:38:41 -0400
X-MC-Unique: ndBVpndxOZ67aFGCLLvTnQ-1
Received: by mail-wr1-f72.google.com with SMTP id b11so4197019wru.21
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 05:38:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=csF6v7e1b/VImX3TjVY+DMV4RBSRNtsLEqKn/tNdfec=;
        b=dwPiR0ZcxxIjE6p7my5XIEEpDw445AB3ZxJlb3SzvBfOGc2Xr5PWSw/jTfqUVmHVcZ
         2Gg1c3UonWWUq27aYT4C2magp+RDmzcrl+M4ympodpcyw93D/puaRuvVYIEEtTXRvU7T
         o78eE1C/MhS2Sw6IFpynBzKV98weruBk8fy+hR3e1GyTH1I3jkheYuwhRfnSN424felH
         5m8BjvX8OiX2mIFVQcXaiucd+XN0xueosDp5QGShY/42P3XY3UPFFe2yXaUh5kC4o4YV
         sJsngrNHWGQRNyXCa/P8KNzQzAscQVwKpMTXWxqcS9CTAEdag2p0q55TudJ90qFH0GVt
         a4qA==
X-Gm-Message-State: ANhLgQ3Up+gZBOzlkDSuqt75wBn9n9kvWeMeP4bZi3DGBbe9QRDt0vNJ
        Xds/COPXrqCR+cxlw520uEvHWjuEXV2xlHZQzT+WMW5U7uDMDx+bcqFa1Xu1p9kUC64oMM7couf
        sUag4ezC1P8nelQKxYrACOjro
X-Received: by 2002:a7b:c62a:: with SMTP id p10mr9170097wmk.46.1584103119946;
        Fri, 13 Mar 2020 05:38:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtUjiJc7OVTXqjb2sSMoRULX6haXnBMCg7bDfthIO+ovSZQU+4zCbd/eH5nt0CJJfH8h1xKVw==
X-Received: by 2002:a7b:c62a:: with SMTP id p10mr9170084wmk.46.1584103119716;
        Fri, 13 Mar 2020 05:38:39 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g127sm17418821wmf.10.2020.03.13.05.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 05:38:38 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH 03/10] KVM: nVMX: Pull exit_reason from vcpu_vmx in nested_vmx_exit_reflected()
In-Reply-To: <20200312184521.24579-4-sean.j.christopherson@intel.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com> <20200312184521.24579-4-sean.j.christopherson@intel.com>
Date:   Fri, 13 Mar 2020 13:38:37 +0100
Message-ID: <87d09gpgz6.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Grab the exit reason from the vcpu struct in nested_vmx_exit_reflected()
> instead of having the exit reason explicitly passed from the caller.
> This fixes a discrepancy between VM-Fail and VM-Exit handling, as the
> VM-Fail case is already handled by checking vcpu_vmx, e.g. the exit
> reason previously passed on the stack is bogus if vmx->fail is set.

It's 0xdead, not bogus :-)

>
> Not taking the exit reason on the stack also avoids having to document
> that nested_vmx_exit_reflected() requires the full exit reason, as
> opposed to just the basic exit reason, which is not at all obvious since
> the only usage of the full exit reason is for tracing.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 3 ++-
>  arch/x86/kvm/vmx/nested.h | 9 ++++-----
>  arch/x86/kvm/vmx/vmx.c    | 2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 79c7764c77b1..cb05bcbbfc4e 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -5518,11 +5518,12 @@ static bool nested_vmx_exit_handled_vmcs_access(struct kvm_vcpu *vcpu,
>   * should handle it ourselves in L0 (and then continue L2). Only call this
>   * when in is_guest_mode (L2).
>   */
> -bool nested_vmx_exit_reflected(struct kvm_vcpu *vcpu, u32 exit_reason)
> +bool nested_vmx_exit_reflected(struct kvm_vcpu *vcpu)
>  {
>  	u32 intr_info = vmcs_read32(VM_EXIT_INTR_INFO);
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
> +	u32 exit_reason = vmx->exit_reason;
>  
>  	if (vmx->nested.nested_run_pending)
>  		return false;
> diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
> index 8f5ff3e259c9..569cb828b6ca 100644
> --- a/arch/x86/kvm/vmx/nested.h
> +++ b/arch/x86/kvm/vmx/nested.h
> @@ -24,7 +24,7 @@ void nested_vmx_set_vmcs_shadowing_bitmap(void);
>  void nested_vmx_free_vcpu(struct kvm_vcpu *vcpu);
>  enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
>  						     bool from_vmentry);
> -bool nested_vmx_exit_reflected(struct kvm_vcpu *vcpu, u32 exit_reason);
> +bool nested_vmx_exit_reflected(struct kvm_vcpu *vcpu);
>  void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
>  		       u32 exit_intr_info, unsigned long exit_qualification);
>  void nested_sync_vmcs12_to_shadow(struct kvm_vcpu *vcpu);
> @@ -75,12 +75,11 @@ static inline bool nested_ept_ad_enabled(struct kvm_vcpu *vcpu)
>   * Conditionally reflect a VM-Exit into L1.  Returns %true if the VM-Exit was
>   * reflected into L1.
>   */
> -static inline bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu,
> -					     u32 exit_reason)
> +static inline bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu)
>  {
>  	u32 exit_intr_info;
>  
> -	if (!nested_vmx_exit_reflected(vcpu, exit_reason))
> +	if (!nested_vmx_exit_reflected(vcpu))
>  		return false;
>  
>  	/*
> @@ -99,7 +98,7 @@ static inline bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu,
>  			vmcs_read32(VM_EXIT_INTR_ERROR_CODE);
>  	}
>  
> -	nested_vmx_vmexit(vcpu, exit_reason, exit_intr_info,
> +	nested_vmx_vmexit(vcpu, to_vmx(vcpu)->exit_reason, exit_intr_info,
>  			  vmcs_readl(EXIT_QUALIFICATION));
>  	return true;
>  }
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index c1caac7e8f57..c7715c880ea7 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5863,7 +5863,7 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
>  	if (vmx->emulation_required)
>  		return handle_invalid_guest_state(vcpu);
>  
> -	if (is_guest_mode(vcpu) && nested_vmx_reflect_vmexit(vcpu, exit_reason))
> +	if (is_guest_mode(vcpu) && nested_vmx_reflect_vmexit(vcpu))
>  		return 1;
>  
>  	if (exit_reason & VMX_EXIT_REASONS_FAILED_VMENTRY) {

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

