Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6976C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98CD0206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cy/JLT8y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgCMNzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:55:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39953 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgCMNzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584107742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xi0c5/xKh2lOwqk3iSKY9ysFACGQ5dQDCkNJfPCK86k=;
        b=Cy/JLT8yE5NAb2ei5aej1kt2mGBHe3tqefVhPD0eZYvv8AIxZdIpJMPPoBj7kpMqYfjRUT
        UVVpfO+xgRT8Vw0AJ0aNg52YIHfYVAu37DLPDUZFCVCqPeFOcAnwSqUiyz8iu8e7KKM430
        PKEZ1xcMG451xbHPlPWI+JdwcfJzjnc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-Y5J4GKJ9OiWf7erE8tteuw-1; Fri, 13 Mar 2020 09:55:40 -0400
X-MC-Unique: Y5J4GKJ9OiWf7erE8tteuw-1
Received: by mail-wm1-f71.google.com with SMTP id e26so2949143wmk.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 06:55:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Xi0c5/xKh2lOwqk3iSKY9ysFACGQ5dQDCkNJfPCK86k=;
        b=McQUyKtMWCju+wbmMzh4J+gA3ydb44ML0ZbE6yW9OYXTQ6Xx4aeJ+fUs9K5gQQ6Zve
         NHebfID74hFElttDxlLekQqzNCpH6CY7eLEUKS66LbkuXTr+Mea+Il+K0n323VD08w4k
         deLxJ5+3m8I6S8pCtA2w4AqcldjBfsOzu4LuRUCBfSTvFDw9st8QWZb65/EYfbTWIrf7
         ihvyb556rIIExSj/T+C6iyfE9DbTGj88uNGyIX3lgIips7RB6q6MksbMuPEJu9MD+qNG
         NiibDRKhxjlHBWaVWR+Zj8vKfuiP5DAiQpzCgkmjc94s5ai4WOqw+6esOdA51Qa802Ow
         hStw==
X-Gm-Message-State: ANhLgQ1n4PFGCDYOTWyIZzOJvoOeZ9duS5hGPqjKjOfnxaReJfvPf/wp
        XapMhQPFKyRi23W5e0dFcFMw1xscR8+33Q6BuAkfoIFg0CPsvgEyh9gl9+LTX0SJriJGv3jsqST
        Ne2Pis1oUpFQipevuT236Lyy5
X-Received: by 2002:a5d:4a10:: with SMTP id m16mr17114327wrq.333.1584107739794;
        Fri, 13 Mar 2020 06:55:39 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsuGx0lAkADzqrLLgu38oyLxuCaYDewRJ90SQ/3hRvvYgCLDrdXurpYNhOT3R90fZ2urj4/qA==
X-Received: by 2002:a5d:4a10:: with SMTP id m16mr17114307wrq.333.1584107739616;
        Fri, 13 Mar 2020 06:55:39 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t81sm16712936wmb.15.2020.03.13.06.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 06:55:39 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH 06/10] KVM: nVMX: Convert local exit_reason to u16 in ...enter_non_root_mode()
In-Reply-To: <20200312184521.24579-7-sean.j.christopherson@intel.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com> <20200312184521.24579-7-sean.j.christopherson@intel.com>
Date:   Fri, 13 Mar 2020 14:55:38 +0100
Message-ID: <87pndgnyud.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Use a u16 for nested_vmx_enter_non_root_mode()'s local "exit_reason" to
> make it clear the intermediate code is only responsible for setting the
> basic exit reason, e.g. FAILED_VMENTRY is unconditionally OR'd in when
> emulating a failed VM-Entry.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 1848ca0116c0..8fbbe2152ab7 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3182,7 +3182,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  	struct vmcs12 *vmcs12 = get_vmcs12(vcpu);
>  	bool evaluate_pending_interrupts;
> -	u32 exit_reason = EXIT_REASON_INVALID_STATE;
> +	u16 exit_reason = EXIT_REASON_INVALID_STATE;
>  	u32 exit_qual;
>  
>  	evaluate_pending_interrupts = exec_controls_get(vmx) &
> @@ -3308,7 +3308,7 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
>  		return NVMX_VMENTRY_VMEXIT;
>  
>  	load_vmcs12_host_state(vcpu, vmcs12);
> -	vmcs12->vm_exit_reason = exit_reason | VMX_EXIT_REASONS_FAILED_VMENTRY;
> +	vmcs12->vm_exit_reason = VMX_EXIT_REASONS_FAILED_VMENTRY | exit_reason;

My personal preference would be to do
 (u32)exit_reason | VMX_EXIT_REASONS_FAILED_VMENTRY 
instead but maybe I'm just not in love with implicit type convertion in C.

>  	vmcs12->exit_qualification = exit_qual;
>  	if (enable_shadow_vmcs || vmx->nested.hv_evmcs)
>  		vmx->nested.need_vmcs12_to_shadow_sync = true;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

