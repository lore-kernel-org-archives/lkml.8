Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF502C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97AA620702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:34:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CP6e4WSB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgBEOee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:34:34 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58473 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726455AbgBEOee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580913273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4x0zaVZqPalHfutXUGZSJjZwFi0uFd+sMxuDFEuloP8=;
        b=CP6e4WSB+on4xNyIk6cWwkb7uAFsdrfu4iP3cobUgv8WHLb2pjlfnO7hnCL4KsySANfn2C
        nOXgDYAKuk48jTqc1ivRsYAuiPqsiwN6v1GFJst1d8fMmkXT72YZr/rbtdtfWawl3845zl
        Bfu6t8uZ4gUBZridRRt3PWrGo+0/4Tg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-mYZGDUhcOQSiTa8xpmS75Q-1; Wed, 05 Feb 2020 09:34:32 -0500
X-MC-Unique: mYZGDUhcOQSiTa8xpmS75Q-1
Received: by mail-wm1-f72.google.com with SMTP id y125so2036057wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 06:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=4x0zaVZqPalHfutXUGZSJjZwFi0uFd+sMxuDFEuloP8=;
        b=tWFmi2glwy2Bw0VhE3Y9rRLRL2fsw3cWn8UHLpXU7CDiWt5iyZkCVqd9i6TocuZQSX
         JcIkwBYpQXR6l0aPJJfAeLBE2oWXeJ/Y5fgDi/5ttXC4Oz2CUskUqqw/IW1PfKx64px6
         xWntjun2tqQCm2cgWXggw9+ddliC31s1VHAzNmLEHCAr2yxvTBp1kVMFawMI5WutaoOl
         2QfdzH6DHNmZijzGaBpYlBITFHjy49mffpFLjrikvTljpzvATxSMNd33nGp++0O4q522
         92v3YTQw4ALv5zmXnHF/7jsEGvF4oSovdf4f1j1+/eJRUASgxmwHZ7AJ31dDEeu83+/8
         zNHg==
X-Gm-Message-State: APjAAAXx8ocSuslz0zwWncK+VeI9JiCOScaLJE9c2oS0Max1rjY976Yh
        bGhgdI0vmB/78bNpv51zIDYFLYJHsSRbe/HXazExarjaAYYaSy9KMK6MB6waxpx6lrQb1Iw3yiz
        93WcF6uogY/2F7LWbHleQkCGj
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr6024690wmf.60.1580913271054;
        Wed, 05 Feb 2020 06:34:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqwnqgbr3vr2dJbjqKzRwcMQz7mTDyE+gvwSB8VMka8mhy7hsXtCQZ6gBnjep2BPLAschDKzgQ==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr6024669wmf.60.1580913270829;
        Wed, 05 Feb 2020 06:34:30 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q14sm3149wrj.81.2020.02.05.06.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 06:34:30 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 04/26] KVM: x86: Add a kvm_x86_ops hook to query virtualized MSR support
In-Reply-To: <20200129234640.8147-5-sean.j.christopherson@intel.com>
References: <20200129234640.8147-1-sean.j.christopherson@intel.com> <20200129234640.8147-5-sean.j.christopherson@intel.com>
Date:   Wed, 05 Feb 2020 15:34:29 +0100
Message-ID: <87eev9ksqy.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Add a hook, ->has_virtualized_msr(), to allow moving vendor specific
> checks into SVM/VMX and ultimately facilitate the removal of the
> piecemeal ->*_supported() hooks.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 1 +
>  arch/x86/kvm/svm.c              | 6 ++++++
>  arch/x86/kvm/vmx/vmx.c          | 6 ++++++
>  arch/x86/kvm/x86.c              | 2 ++
>  4 files changed, 15 insertions(+)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 5c2ad3fa0980..8fb32c27fa44 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1050,6 +1050,7 @@ struct kvm_x86_ops {
>  	int (*hardware_setup)(void);               /* __init */
>  	void (*hardware_unsetup)(void);            /* __exit */
>  	bool (*cpu_has_accelerated_tpr)(void);
> +	bool (*has_virtualized_msr)(u32 index);
>  	bool (*has_emulated_msr)(u32 index);
>  	void (*cpuid_update)(struct kvm_vcpu *vcpu);
>  
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index a7b944a3a0e2..1f9323fbad81 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -5985,6 +5985,11 @@ static bool svm_cpu_has_accelerated_tpr(void)
>  	return false;
>  }
>  
> +static bool svm_has_virtualized_msr(u32 index)
> +{
> +	return true;
> +}
> +
>  static bool svm_has_emulated_msr(u32 index)
>  {
>  	switch (index) {
> @@ -7379,6 +7384,7 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
>  	.hardware_enable = svm_hardware_enable,
>  	.hardware_disable = svm_hardware_disable,
>  	.cpu_has_accelerated_tpr = svm_cpu_has_accelerated_tpr,
> +	.has_virtualized_msr = svm_has_virtualized_msr,
>  	.has_emulated_msr = svm_has_emulated_msr,
>  
>  	.vcpu_create = svm_create_vcpu,
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f5bb1ad2e9fa..3f2c094434e8 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6274,6 +6274,11 @@ static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu,
>  		*exit_fastpath = handle_fastpath_set_msr_irqoff(vcpu);
>  }
>  
> +static bool vmx_has_virtualized_msr(u32 index)
> +{
> +	return true;
> +}
> +
>  static bool vmx_has_emulated_msr(u32 index)
>  {
>  	switch (index) {
> @@ -7754,6 +7759,7 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
>  	.hardware_enable = hardware_enable,
>  	.hardware_disable = hardware_disable,
>  	.cpu_has_accelerated_tpr = report_flexpriority,
> +	.has_virtualized_msr = vmx_has_virtualized_msr,
>  	.has_emulated_msr = vmx_has_emulated_msr,
>  
>  	.vm_init = vmx_vm_init,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 3d4a5326d84e..94f90fe1c0de 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5279,6 +5279,8 @@ static void kvm_init_msr_list(void)
>  				continue;
>  			break;
>  		default:
> +			if (!kvm_x86_ops->has_virtualized_msr(msr_index))
> +				continue;
>  			break;
>  		}

Shouldn't break anything by itself, so

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

