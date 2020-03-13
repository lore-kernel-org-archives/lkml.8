Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E53C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3172E20724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxWXma6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgCMNsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:48:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28585 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726526AbgCMNsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584107303;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+tkeFaJzDltOnHjHGhg5fmOjAp9pqNQD8e8oGnwV5c=;
        b=UxWXma6bdYGNg66gfWAl/vrImfbe1WL+piarqMtqXQBNyXXHbfevupb0U99EbhP7ya1gWu
        XXBO6lqQzfLM7Az1RjC8k0gw9qRI0KIK21+FaZs176UjdUl3AXWa1OuxDi5JJvkDNdJOgK
        acnIWYrEsGBj/HYZBYd/jrCwmIY5P1k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-u4Sj7zFhPLC04omhK2D-cA-1; Fri, 13 Mar 2020 09:48:21 -0400
X-MC-Unique: u4Sj7zFhPLC04omhK2D-cA-1
Received: by mail-wr1-f69.google.com with SMTP id b11so4274350wru.21
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 06:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=a+tkeFaJzDltOnHjHGhg5fmOjAp9pqNQD8e8oGnwV5c=;
        b=rIvf8tN8f/CrKNl6//ycIttFHmJuYbf7z0LivQbDf+9MTYL2oeEKUBJ4SvIIUDz73o
         RiJdOSHDhFy2NdU06tJmhg5iuFhSL8xbwiKF2tN/dApgG5GPBeeV30AlNBSayUbvXFWq
         DaC43I3vOaRK4KveFvBAChPUfXdXHPVDWsICsgVoZAjuhC1hHFnSb5lMJjtjVvZClP9r
         Xg9o7lF6IGLegQWzWQpN0NJcB1pzG19GetYYR10bDN2zmfrqbVeCJ82NGhzFq+2eR2zJ
         2P47lGUDNSOZ4Nboxe77b6vzeGT7fAs74kne7TG3K5Yz59Q8ePF46DGCY8SD3xDHS9ZP
         RldA==
X-Gm-Message-State: ANhLgQ0x10d0h69QAR+aifhAXI/BKFWOMn3ZbUf21uzLpazyFC9qSgtQ
        M5XIutEwg8l42KFjd3SMBs+yl5mvz48OcYT9YAirBrygEkvc9TxBMvzns9SwNvVpawZumUfYBJf
        4KLe41t2H5K4lZQtwJnr1fKiD
X-Received: by 2002:a05:6000:c:: with SMTP id h12mr12104482wrx.168.1584107300502;
        Fri, 13 Mar 2020 06:48:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtvFHYiIX+qqZaTg5JlaXiKvOxNSZE/k2VHVIKKE9W07xN2bk+oiotoTv/Jptmyy+/ASQfHJA==
X-Received: by 2002:a05:6000:c:: with SMTP id h12mr12104472wrx.168.1584107300318;
        Fri, 13 Mar 2020 06:48:20 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f127sm17333453wma.4.2020.03.13.06.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 06:48:19 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH 05/10] KVM: VMX: Convert local exit_reason to u16 in vmx_handle_exit()
In-Reply-To: <20200312184521.24579-6-sean.j.christopherson@intel.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com> <20200312184521.24579-6-sean.j.christopherson@intel.com>
Date:   Fri, 13 Mar 2020 14:48:18 +0100
Message-ID: <87sgicnz6l.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Convert the local "exit_reason" in vmx_handle_exit() from a u32 to a u16
> as most references expect to encounter only the basic exit reason.  Use
> vmx->exit_reason directly for paths that expect the full exit reason,
> i.e. to avoid having to figure out a decent name for a second local
> variable.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index c7715c880ea7..d43e1d28bb58 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5844,10 +5844,10 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
>  	enum exit_fastpath_completion exit_fastpath)
>  {
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
> -	u32 exit_reason = vmx->exit_reason;
>  	u32 vectoring_info = vmx->idt_vectoring_info;
> +	u16 exit_reason;
>  
> -	trace_kvm_exit(exit_reason, vcpu, KVM_ISA_VMX);
> +	trace_kvm_exit(vmx->exit_reason, vcpu, KVM_ISA_VMX);
>  
>  	/*
>  	 * Flush logged GPAs PML buffer, this will make dirty_bitmap more
> @@ -5866,11 +5866,11 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
>  	if (is_guest_mode(vcpu) && nested_vmx_reflect_vmexit(vcpu))
>  		return 1;
>  
> -	if (exit_reason & VMX_EXIT_REASONS_FAILED_VMENTRY) {
> +	if (vmx->exit_reason & VMX_EXIT_REASONS_FAILED_VMENTRY) {
>  		dump_vmcs();
>  		vcpu->run->exit_reason = KVM_EXIT_FAIL_ENTRY;
>  		vcpu->run->fail_entry.hardware_entry_failure_reason
> -			= exit_reason;
> +			= vmx->exit_reason;
>  		return 0;
>  	}
>  
> @@ -5882,6 +5882,8 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
>  		return 0;
>  	}
>  
> +	exit_reason = vmx->exit_reason;
> +
>  	/*
>  	 * Note:
>  	 * Do not try to fix EXIT_REASON_EPT_MISCONFIG if it caused by
> @@ -5898,7 +5900,7 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
>  		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_DELIVERY_EV;
>  		vcpu->run->internal.ndata = 3;
>  		vcpu->run->internal.data[0] = vectoring_info;
> -		vcpu->run->internal.data[1] = exit_reason;
> +		vcpu->run->internal.data[1] = vmx->exit_reason;
>  		vcpu->run->internal.data[2] = vcpu->arch.exit_qualification;
>  		if (exit_reason == EXIT_REASON_EPT_MISCONFIG) {
>  			vcpu->run->internal.ndata++;
> @@ -5957,13 +5959,14 @@ static int vmx_handle_exit(struct kvm_vcpu *vcpu,
>  	return kvm_vmx_exit_handlers[exit_reason](vcpu);
>  
>  unexpected_vmexit:
> -	vcpu_unimpl(vcpu, "vmx: unexpected exit reason 0x%x\n", exit_reason);
> +	vcpu_unimpl(vcpu, "vmx: unexpected exit reason 0x%x\n",
> +		    vmx->exit_reason);
>  	dump_vmcs();
>  	vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
>  	vcpu->run->internal.suberror =
>  			KVM_INTERNAL_ERROR_UNEXPECTED_EXIT_REASON;
>  	vcpu->run->internal.ndata = 1;
> -	vcpu->run->internal.data[0] = exit_reason;
> +	vcpu->run->internal.data[0] = vmx->exit_reason;
>  	return 0;
>  }

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

