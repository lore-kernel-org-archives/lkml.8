Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FE3C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C8E24695
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dkU+tfuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726831AbgB1JfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:35:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36995 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726673AbgB1JfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582882511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DpY+KYD45ZukUr2uiluCWuyD5nGDLRfeur7I9dYkvWA=;
        b=dkU+tfuE10tfIrsv3AXDDuU3NFg/xeNTjBj0QmlQrxTRKA7un2HMeIFhcMoRYxRRmb4l9L
        Cx8cpC8vgrOjlq3S5RJ+FJtk1e0NecQJ8rokV1YQWut0f6xsuGTgFdmYM/+pObkwbncZ7T
        97zIMEmARgDtyvYC6lcH60kBYInvnXs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-QoqrWToSMdOwCeCKmHYcAw-1; Fri, 28 Feb 2020 04:35:08 -0500
X-MC-Unique: QoqrWToSMdOwCeCKmHYcAw-1
Received: by mail-wr1-f70.google.com with SMTP id j32so1060907wre.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 01:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DpY+KYD45ZukUr2uiluCWuyD5nGDLRfeur7I9dYkvWA=;
        b=kbuP7XiJ8jTuzsArVrZOjCT7kzhZVe4bNOu6XrRUVFzAy9pqy36HqAL/cGaMMhuIXy
         0hNzdnyT1QEnufOIDtsU3t4R5KC243u/6Vvl8WAbMFRyHNMKO8hlkMMbsLkuPqTl4X3x
         a1a3RYqvUhd1zNB89bXu/NxErVn9LPecIkHMQ/T+R9V4wgr2qIrcuxqqgZnAxmTxYPhb
         oFuKH4BxqBA9e8udWQQnjJw74twa1JQZHc4yMSPDgPWkcDvBYlC6i76Vq7wU2TrOUo18
         fCzehyD0HSln7NFzeALJmAo/3PySoMRp3AdJLnTUo62LoguYt8xyL4/12AqRf1Z0Xs1H
         uvEQ==
X-Gm-Message-State: APjAAAUTaYzNLKMJLSPCI3OWVkcLavOUfI2K3rJ9js6xX1rOlVGKtVXB
        TiLLOx9WtQkpTpnfBMlHMz4YKDjctAXn1GS2poqsduvqa6IvMAYHOGovagpHraUmxz1drQu5Udc
        C/rklVKD8rfNicI06mBSSZ9/3
X-Received: by 2002:adf:ecca:: with SMTP id s10mr4127725wro.255.1582882507328;
        Fri, 28 Feb 2020 01:35:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqxLt681oziTtUHptfVfOG5/Wyl8Pw19WPwf2OGhyjXablKk0sGkMRMSUkJ9cOne6UDNJR6m+Q==
X-Received: by 2002:adf:ecca:: with SMTP id s10mr4127691wro.255.1582882507036;
        Fri, 28 Feb 2020 01:35:07 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f? ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
        by smtp.gmail.com with ESMTPSA id q138sm590995wme.41.2020.02.28.01.35.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 01:35:06 -0800 (PST)
Subject: Re: [PATCH RESEND v2 2/2] KVM: Pre-allocate 1 cpumask variable per
 cpu for both pv tlb and pv ipis
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <1581988104-16628-1-git-send-email-wanpengli@tencent.com>
 <1581988104-16628-2-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a232d6bf-0a33-25a6-e76d-b197e677217b@redhat.com>
Date:   Fri, 28 Feb 2020 10:35:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1581988104-16628-2-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/20 02:08, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Nick Desaulniers Reported:
> 
>   When building with:
>   $ make CC=clang arch/x86/ CFLAGS=-Wframe-larger-than=1000
>   The following warning is observed:
>   arch/x86/kernel/kvm.c:494:13: warning: stack frame size of 1064 bytes in
>   function 'kvm_send_ipi_mask_allbutself' [-Wframe-larger-than=]
>   static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, int
>   vector)
>               ^
>   Debugging with:
>   https://github.com/ClangBuiltLinux/frame-larger-than
>   via:
>   $ python3 frame_larger_than.py arch/x86/kernel/kvm.o \
>     kvm_send_ipi_mask_allbutself
>   points to the stack allocated `struct cpumask newmask` in
>   `kvm_send_ipi_mask_allbutself`. The size of a `struct cpumask` is
>   potentially large, as it's CONFIG_NR_CPUS divided by BITS_PER_LONG for
>   the target architecture. CONFIG_NR_CPUS for X86_64 can be as high as
>   8192, making a single instance of a `struct cpumask` 1024 B.
> 
> This patch fixes it by pre-allocate 1 cpumask variable per cpu and use it for 
> both pv tlb and pv ipis..
> 
> Reported-by: Nick Desaulniers <ndesaulniers@google.com>
> Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * remove '!alloc' check
>  * use new pv check helpers
> 
>  arch/x86/kernel/kvm.c | 33 +++++++++++++++++++++------------
>  1 file changed, 21 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 76ea8c4..377b224 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -432,6 +432,8 @@ static bool pv_tlb_flush_supported(void)
>  		kvm_para_has_feature(KVM_FEATURE_STEAL_TIME));
>  }
>  
> +static DEFINE_PER_CPU(cpumask_var_t, __pv_cpu_mask);
> +
>  #ifdef CONFIG_SMP
>  
>  static bool pv_ipi_supported(void)
> @@ -510,12 +512,12 @@ static void kvm_send_ipi_mask(const struct cpumask *mask, int vector)
>  static void kvm_send_ipi_mask_allbutself(const struct cpumask *mask, int vector)
>  {
>  	unsigned int this_cpu = smp_processor_id();
> -	struct cpumask new_mask;
> +	struct cpumask *new_mask = this_cpu_cpumask_var_ptr(__pv_cpu_mask);
>  	const struct cpumask *local_mask;
>  
> -	cpumask_copy(&new_mask, mask);
> -	cpumask_clear_cpu(this_cpu, &new_mask);
> -	local_mask = &new_mask;
> +	cpumask_copy(new_mask, mask);
> +	cpumask_clear_cpu(this_cpu, new_mask);
> +	local_mask = new_mask;
>  	__send_ipi_mask(local_mask, vector);
>  }
>  
> @@ -595,7 +597,6 @@ static void __init kvm_apf_trap_init(void)
>  	update_intr_gate(X86_TRAP_PF, async_page_fault);
>  }
>  
> -static DEFINE_PER_CPU(cpumask_var_t, __pv_tlb_mask);
>  
>  static void kvm_flush_tlb_others(const struct cpumask *cpumask,
>  			const struct flush_tlb_info *info)
> @@ -603,7 +604,7 @@ static void kvm_flush_tlb_others(const struct cpumask *cpumask,
>  	u8 state;
>  	int cpu;
>  	struct kvm_steal_time *src;
> -	struct cpumask *flushmask = this_cpu_cpumask_var_ptr(__pv_tlb_mask);
> +	struct cpumask *flushmask = this_cpu_cpumask_var_ptr(__pv_cpu_mask);
>  
>  	cpumask_copy(flushmask, cpumask);
>  	/*
> @@ -642,6 +643,7 @@ static void __init kvm_guest_init(void)
>  	if (pv_tlb_flush_supported()) {
>  		pv_ops.mmu.flush_tlb_others = kvm_flush_tlb_others;
>  		pv_ops.mmu.tlb_remove_table = tlb_remove_table;
> +		pr_info("KVM setup pv remote TLB flush\n");
>  	}
>  
>  	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
> @@ -748,24 +750,31 @@ static __init int activate_jump_labels(void)
>  }
>  arch_initcall(activate_jump_labels);
>  
> -static __init int kvm_setup_pv_tlb_flush(void)
> +static __init int kvm_alloc_cpumask(void)
>  {
>  	int cpu;
> +	bool alloc = false;
>  
>  	if (!kvm_para_available() || nopv)
>  		return 0;
>  
> -	if (pv_tlb_flush_supported()) {
> +	if (pv_tlb_flush_supported())
> +		alloc = true;
> +
> +#if defined(CONFIG_SMP)
> +	if (pv_ipi_supported())
> +		alloc = true;
> +#endif
> +
> +	if (alloc)
>  		for_each_possible_cpu(cpu) {
> -			zalloc_cpumask_var_node(per_cpu_ptr(&__pv_tlb_mask, cpu),
> +			zalloc_cpumask_var_node(per_cpu_ptr(&__pv_cpu_mask, cpu),
>  				GFP_KERNEL, cpu_to_node(cpu));
>  		}
> -		pr_info("KVM setup pv remote TLB flush\n");
> -	}
>  
>  	return 0;
>  }
> -arch_initcall(kvm_setup_pv_tlb_flush);
> +arch_initcall(kvm_alloc_cpumask);
>  
>  #ifdef CONFIG_PARAVIRT_SPINLOCKS
>  
> 

Queued now, thanks.

Paolo

