Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EBBC8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1C1320870
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5JQNmZI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgD3N24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:28:56 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20581 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727079AbgD3N2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588253334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VVwLcanbkWVkF6qlI7rC+oUg9XLivUoMR67GxaygdkY=;
        b=S5JQNmZITGtTGTLJJiF8oQQxSxtx+tlF6f5faPVP8DMv57fvScvO1Hv/jsgETMD9q+zKHo
        dNiIBSwcCJlk0nBz7B48wHHLREYIZJBTEVm6+ssba1pHKCEq0LTuDN76WN/adlq9t7Rl7u
        MohdPs7PjgP++gHTG2zZWRaNq2O/DCI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-EDpM4FQbNWCcvOJaHhGVIw-1; Thu, 30 Apr 2020 09:28:52 -0400
X-MC-Unique: EDpM4FQbNWCcvOJaHhGVIw-1
Received: by mail-wm1-f69.google.com with SMTP id j5so850362wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:28:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VVwLcanbkWVkF6qlI7rC+oUg9XLivUoMR67GxaygdkY=;
        b=ufskaCU7KJszmWAgrOuFim5eFLq5Xno8OUw+KvhO/zeg/nSFw6F2kdxyOvYfhnNDH6
         5nkqZf5HhTTJCTE1goaVsIh1UMvU9HcX4rZvTynTBYGnOvO8DRHBjvP7GZJ9d+1LmzE/
         Yd/1gZ17Vx4LAdavlfY/gleNozco9OwEhdL5Vqgk8VgdTgP0BELeoFBeuzo+RcCtsDoH
         hrI6i1HPfC9ZpAVhKapy6PQKJrwPihKrjINCQv2pzCrbAfHkPSt+WYx/sKcxVWXArlvZ
         /epD0Ggzsu90fivOpwFwXokx8PT5WAg/Z4ZkGjLO/udj6przWo7aP9zmxjffcKqvNx2Y
         B0NQ==
X-Gm-Message-State: AGi0PubJG7FIkjttaPaUjgP1/CYdxMC3aBjphaGj0jUCf2cidtj/bsJS
        9j085EpRvb3dVZA5yOsGl2Yt7Ea/+ZYCgVLeCbNagm/wyh0AHQBeTploESoGkritMbGAp9dubbt
        xLDstkE+R94fTy/WAUjlOmsNS
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr2897974wmh.47.1588253328324;
        Thu, 30 Apr 2020 06:28:48 -0700 (PDT)
X-Google-Smtp-Source: APiQypLHXE43WEEUcWxoJTXG/Jv5eHHkkREsDic3prcg6FMi61efPU1/eDH+n3AzPm5hqVof0AbtCg==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr2897954wmh.47.1588253328047;
        Thu, 30 Apr 2020 06:28:48 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n6sm11982145wmc.28.2020.04.30.06.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 06:28:47 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
Subject: Re: [PATCH v4 1/7] KVM: VMX: Introduce generic fastpath handler
In-Reply-To: <1588055009-12677-2-git-send-email-wanpengli@tencent.com>
References: <1588055009-12677-1-git-send-email-wanpengli@tencent.com> <1588055009-12677-2-git-send-email-wanpengli@tencent.com>
Date:   Thu, 30 Apr 2020 15:28:46 +0200
Message-ID: <87ees5f6gh.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> Introduce generic fastpath handler to handle MSR fastpath, VMX-preemption
> timer fastpath etc, move it after vmx_complete_interrupts() in order that
> later patch can catch the case vmexit occurred while another event was
> being delivered to guest. There is no obversed performance difference for
> IPI fastpath testing after this move.
>
> Tested-by: Haiwei Li <lihaiwei@tencent.com>
> Cc: Haiwei Li <lihaiwei@tencent.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 3ab6ca6..9b5adb4 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6583,6 +6583,20 @@ void vmx_update_host_rsp(struct vcpu_vmx *vmx, unsigned long host_rsp)
>  	}
>  }
>  
> +static enum exit_fastpath_completion vmx_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
> +{
> +	if (!is_guest_mode(vcpu)) {

Nitpick: do we actually expect to have any fastpath handlers anytime
soon? If not, we could've written this as

	if (is_guest_mode(vcpu))
		return EXIT_FASTPATH_NONE;

and save on identation)

> +		switch (to_vmx(vcpu)->exit_reason) {
> +		case EXIT_REASON_MSR_WRITE:
> +			return handle_fastpath_set_msr_irqoff(vcpu);
> +		default:
> +			return EXIT_FASTPATH_NONE;
> +		}
> +	}
> +
> +	return EXIT_FASTPATH_NONE;
> +}
> +
>  bool __vmx_vcpu_run(struct vcpu_vmx *vmx, unsigned long *regs, bool launched);
>  
>  static enum exit_fastpath_completion vmx_vcpu_run(struct kvm_vcpu *vcpu)
> @@ -6757,17 +6771,14 @@ static enum exit_fastpath_completion vmx_vcpu_run(struct kvm_vcpu *vcpu)
>  	if (unlikely(vmx->exit_reason & VMX_EXIT_REASONS_FAILED_VMENTRY))
>  		return EXIT_FASTPATH_NONE;
>  
> -	if (!is_guest_mode(vcpu) && vmx->exit_reason == EXIT_REASON_MSR_WRITE)
> -		exit_fastpath = handle_fastpath_set_msr_irqoff(vcpu);
> -	else
> -		exit_fastpath = EXIT_FASTPATH_NONE;
> -
>  	vmx->loaded_vmcs->launched = 1;
>  	vmx->idt_vectoring_info = vmcs_read32(IDT_VECTORING_INFO_FIELD);
>  
>  	vmx_recover_nmi_blocking(vmx);
>  	vmx_complete_interrupts(vmx);
>  
> +	exit_fastpath = vmx_exit_handlers_fastpath(vcpu);
> +
>  	return exit_fastpath;
>  }

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

