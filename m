Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9A5C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C275206FA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ihpQPims"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgCMMMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:12:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41840 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726495AbgCMMMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584101557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L3JO80ASy2k51/5bJXWTlXPpMuSoyvyJ+Z2PLLcwmQM=;
        b=ihpQPimsZVVr+7DUkEz09viQwK7lQIGlR8fUS35Nns50m6v8AgZT4kc76+Be6+c4DWRnpR
        LV59jNkZ4d+O3GdRJw3oagLrXOm+k5XqgWM9ytSn8r8rJdsoj1rGfIFjoeWJSdv4wZeu3z
        sE2HThFEmM3RqlQWI9Fzhe/IOwrzdic=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-463-uUYrw9s7Ms6ZrnNhsDBzPg-1; Fri, 13 Mar 2020 08:12:36 -0400
X-MC-Unique: uUYrw9s7Ms6ZrnNhsDBzPg-1
Received: by mail-wr1-f71.google.com with SMTP id t4so1232577wrv.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 05:12:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=L3JO80ASy2k51/5bJXWTlXPpMuSoyvyJ+Z2PLLcwmQM=;
        b=b6qlIV7YetYx9V04DnXhE4iGTIx4plo4z27jY2O3iM30ewscHIlt9R2/dMzLxrnQla
         eSttIDn+uhB4JR2xtdZ5bQGSic8SDzCgmowEazC1FSGm3HEF/6eO4yw1aOX6uxiHBBys
         GvR3c9HQhJ6D25hmvooal3o9dybJIyuV7JovDT4y5WspNFGxJ/SXQcRGJGBrnJFCTupG
         g34IYjO1anJtKiaP9fFtlNGCgWY9wbM9D6ejKt24Woroba4+ocKiHBK0un9izWbVVdzw
         rf2+BSlSIS2i+PId4Dp1OxbxJ7rYXt3o/t7eK17t8ez8Aycf9y18j0r0fWcgpCm5Gya2
         HvYw==
X-Gm-Message-State: ANhLgQ0WhsHHxbWnVxs2NRyuenvs1wimfEGnyV990MHgkJkRQfip9cMi
        2+wZYXdbOI7igLABhOvuXFctDdTML7gk2KJp0w1wD4IBUh9nM+iX/9CpjEWFAE7BUuDqt5EzPKH
        utg1XqDnnphZU6kfNjAxS28Xr
X-Received: by 2002:a1c:1fc9:: with SMTP id f192mr10936165wmf.4.1584101555224;
        Fri, 13 Mar 2020 05:12:35 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsUiG/bhRPhm9IKk8OaIP0Fi57Hoxb0VuHeMLXJFendIRAXnb5eBMnP10GuN8TrXXy+Su5iaQ==
X-Received: by 2002:a1c:1fc9:: with SMTP id f192mr10936142wmf.4.1584101554957;
        Fri, 13 Mar 2020 05:12:34 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q16sm65582545wrj.73.2020.03.13.05.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 05:12:34 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH 01/10] KVM: nVMX: Move reflection check into nested_vmx_reflect_vmexit()
In-Reply-To: <20200312184521.24579-2-sean.j.christopherson@intel.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com> <20200312184521.24579-2-sean.j.christopherson@intel.com>
Date:   Fri, 13 Mar 2020 13:12:33 +0100
Message-ID: <87k13opi6m.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move the call to nested_vmx_exit_reflected() from vmx_handle_exit() into
> nested_vmx_reflect_vmexit() and change the semantics of the return value
> for nested_vmx_reflect_vmexit() to indicate whether or not the exit was
> reflected into L1.  nested_vmx_exit_reflected() and
> nested_vmx_reflect_vmexit() are intrinsically tied together, calling one
> without simultaneously calling the other makes little sense.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.h | 16 +++++++++++-----
>  arch/x86/kvm/vmx/vmx.c    |  4 ++--
>  2 files changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.h b/arch/x86/kvm/vmx/nested.h
> index 21d36652f213..6bc379cf4755 100644
> --- a/arch/x86/kvm/vmx/nested.h
> +++ b/arch/x86/kvm/vmx/nested.h
> @@ -72,12 +72,16 @@ static inline bool nested_ept_ad_enabled(struct kvm_vcpu *vcpu)
>  }
>  
>  /*
> - * Reflect a VM Exit into L1.
> + * Conditionally reflect a VM-Exit into L1.  Returns %true if the VM-Exit was
> + * reflected into L1.
>   */
> -static inline int nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu,
> -					    u32 exit_reason)
> +static inline bool nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu,
> +					     u32 exit_reason)
>  {
> -	u32 exit_intr_info = vmcs_read32(VM_EXIT_INTR_INFO);
> +	u32 exit_intr_info;
> +
> +	if (!nested_vmx_exit_reflected(vcpu, exit_reason))
> +		return false;

(unrelated to your patch)

It's probably just me but 'nested_vmx_exit_reflected()' name always
makes me thinkg 'the vmexit WAS [already] reflected' and not 'the vmexit
NEEDS to be reflected'. 'nested_vmx_exit_needs_reflecting()' maybe?

>  
>  	/*
>  	 * At this point, the exit interruption info in exit_intr_info
> @@ -85,6 +89,8 @@ static inline int nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu,
>  	 * we need to query the in-kernel LAPIC.
>  	 */
>  	WARN_ON(exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT);
> +
> +	exit_intr_info = vmcs_read32(VM_EXIT_INTR_INFO);
>  	if ((exit_intr_info &
>  	     (INTR_INFO_VALID_MASK | INTR_INFO_DELIVER_CODE_MASK)) ==
>  	    (INTR_INFO_VALID_MASK | INTR_INFO_DELIVER_CODE_MASK)) {
> @@ -96,7 +102,7 @@ static inline int nested_vmx_reflect_vmexit(struct kvm_vcpu *vcpu,
>  
>  	nested_vmx_vmexit(vcpu, exit_reason, exit_intr_info,
>  			  vmcs_readl(EXIT_QUALIFICATION));
> -	return 1;
> +	return true;
>  }
>  
>  /*
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 57742ddfd854..c1caac7e8f57 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5863,8 +5863,8 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
>  	if (vmx->emulation_required)
>  		return handle_invalid_guest_state(vcpu);
>  
> -	if (is_guest_mode(vcpu) && nested_vmx_exit_reflected(vcpu, exit_reason))
> -		return nested_vmx_reflect_vmexit(vcpu, exit_reason);
> +	if (is_guest_mode(vcpu) && nested_vmx_reflect_vmexit(vcpu, exit_reason))
> +		return 1;
>  
>  	if (exit_reason & VMX_EXIT_REASONS_FAILED_VMENTRY) {
>  		dump_vmcs();

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

