Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCF1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAD80208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GMotdOBM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbgE1LEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:04:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47703 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388069AbgE1LED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590663841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRy14437cp9ISBnrfn3ilvupk4pbMx6RaKs8fLuEpHw=;
        b=GMotdOBMVoexbGrtMzvauCnvxSrg/Zs6rB1npgJ8Lc9LsFGcsyPfFtgGXEO1Z6PkB889c7
        E+RThIpa8VUrgkcgAc+v0s6MmKtjKhvkh82+b2vlOfxGbGYLSCoa06x56tJ8G79h7OHn4u
        HLn5XQT2lqhVlEGw8YeBORcgbTTbM8o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-303-rd2Tn8TPPKmUVPVjoPZcFQ-1; Thu, 28 May 2020 07:04:00 -0400
X-MC-Unique: rd2Tn8TPPKmUVPVjoPZcFQ-1
Received: by mail-ej1-f70.google.com with SMTP id u24so10080233ejg.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:03:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GRy14437cp9ISBnrfn3ilvupk4pbMx6RaKs8fLuEpHw=;
        b=lH9iJWb8Zyl7CVNweRoVuHKhc7i42oVwCFoHpAoTS22uyeeQ557E3bDzEtcxnKcDNd
         /vii1S6CLK39Rmq5PgyLiaBQd1uMfAGL0oSJNVC9p2l/w31czW79KwasW96lMXmFFvzT
         UF2WpEeK0n3qfKtBQYbioCGOOpAGnyutlprSAiZ7IlFH4ebuaoSpSaP65uGG1HYD+dKa
         hGxYukS4EnqPRMcUFiY4vNt/7kRKAuy69AYcy12H7xPcVr+Oy9llQvN/pxLskzb2l2Uv
         xnmvGVTFv+2ArHzEtCC90etZzvEqyNfY+LsaCD6YbHgdJajOAyEfwkiWHhhRjyfqh3vP
         popA==
X-Gm-Message-State: AOAM530nQM+Nr6jcuyiKchWC2LuCfLR5P+05lkfOrYdaqOUNNx3gKHBM
        kRYOrNEwnefxDXDn51JraDli/0vhRd0EQTLXMoq0Zxt8wpgGfxY2M1O9s9YvQ7gJjhaTxrUF41A
        kEzLdnY1Cta67uQNGNMkNFzbT
X-Received: by 2002:a17:906:724f:: with SMTP id n15mr2442454ejk.266.1590663838285;
        Thu, 28 May 2020 04:03:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyYjufK12BvJR8qFq0FJAIpZTPeIKs/85s7ALp7zqg/3rTBngQe/zbGulKmNchd11Z7/mf95g==
X-Received: by 2002:a17:906:724f:: with SMTP id n15mr2442419ejk.266.1590663837977;
        Thu, 28 May 2020 04:03:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id 93sm4588248edy.49.2020.05.28.04.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 04:03:57 -0700 (PDT)
Subject: Re: [PATCH v2 10/10] KVM: x86: deprecate KVM_ASYNC_PF_SEND_ALWAYS
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>,
        Vivek Goyal <vgoyal@redhat.com>, Gavin Shan <gshan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20200525144125.143875-1-vkuznets@redhat.com>
 <20200525144125.143875-11-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <551b75f7-b022-313d-fac4-8b3dd83fe76c@redhat.com>
Date:   Thu, 28 May 2020 13:03:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200525144125.143875-11-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/20 16:41, Vitaly Kuznetsov wrote:
> Concerns were expressed around APF events delivery when CPU is not
> in user mode (KVM_ASYNC_PF_SEND_ALWAYS), e.g.
> https://lore.kernel.org/kvm/ed71d0967113a35f670a9625a058b8e6e0b2f104.1583547991.git.luto@kernel.org/
> 
> 'Page ready' events are already free from '#PF abuse' but 'page not ready'
> notifications still go through #PF (to be changed in the future). Make the
> probability of running into issues when APF collides with regular #PF lower
> by deprecating KVM_ASYNC_PF_SEND_ALWAYS. The feature doesn't seem to be
> important enough for any particular workload to notice the difference.

This has been disabled already in guest code, but I don't see a
particular reason to deprecate it in the host too.  Supporting it on the
host is just one line of code; if it's a problem *for the guest*, you
just don't use KVM_ASYNC_PF_SEND_ALWAYS.

Also, note that #VE will always be delivered to the guest even at CPL0;
the decision on whether to do sync or async page fault at CPL0 will move
to the guest, but enabling #VE will probably _require_ the
KVM_ASYNC_PF_SEND_ALWAYS bit to be set (and KVM_ASYNC_PF_DELIVERY_AS_INT
as well).

Thanks,

Paolo

> Suggested-by: Andy Lutomirski <luto@kernel.org>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/include/asm/kvm_host.h      |  1 -
>  arch/x86/include/uapi/asm/kvm_para.h |  2 +-
>  arch/x86/kernel/kvm.c                |  3 ---
>  arch/x86/kvm/x86.c                   | 13 +++++++++----
>  4 files changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 356c02bfa587..f491214b7667 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -769,7 +769,6 @@ struct kvm_vcpu_arch {
>  		u64 msr_int_val; /* MSR_KVM_ASYNC_PF_INT */
>  		u16 vec;
>  		u32 id;
> -		bool send_user_only;
>  		u32 host_apf_flags;
>  		unsigned long nested_apf_token;
>  		bool delivery_as_pf_vmexit;
> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> index 812e9b4c1114..3cae0faac2b8 100644
> --- a/arch/x86/include/uapi/asm/kvm_para.h
> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -82,7 +82,7 @@ struct kvm_clock_pairing {
>  #define KVM_MAX_MMU_OP_BATCH           32
>  
>  #define KVM_ASYNC_PF_ENABLED			(1 << 0)
> -#define KVM_ASYNC_PF_SEND_ALWAYS		(1 << 1)
> +#define KVM_ASYNC_PF_SEND_ALWAYS		(1 << 1) /* deprecated */
>  #define KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT	(1 << 2)
>  #define KVM_ASYNC_PF_DELIVERY_AS_INT		(1 << 3)
>  
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 79730eaef1e1..add123302122 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -324,9 +324,6 @@ static void kvm_guest_cpu_init(void)
>  	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_INT) && kvmapf) {
>  		u64 pa = slow_virt_to_phys(this_cpu_ptr(&apf_reason));
>  
> -#ifdef CONFIG_PREEMPTION
> -		pa |= KVM_ASYNC_PF_SEND_ALWAYS;
> -#endif
>  		pa |= KVM_ASYNC_PF_ENABLED | KVM_ASYNC_PF_DELIVERY_AS_INT;
>  
>  		if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_VMEXIT))
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index cc1bf6cfc5e0..8222133bf5be 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2648,7 +2648,10 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
>  {
>  	gpa_t gpa = data & ~0x3f;
>  
> -	/* Bits 4:5 are reserved, Should be zero */
> +	/*
> +	 * Bits 4:5 are reserved and should be zero. Bit 1
> +	 * (KVM_ASYNC_PF_SEND_ALWAYS) was deprecated and is being ignored.
> +	 */
>  	if (data & 0x30)
>  		return 1;
>  
> @@ -2664,7 +2667,6 @@ static int kvm_pv_enable_async_pf(struct kvm_vcpu *vcpu, u64 data)
>  					sizeof(u64)))
>  		return 1;
>  
> -	vcpu->arch.apf.send_user_only = !(data & KVM_ASYNC_PF_SEND_ALWAYS);
>  	vcpu->arch.apf.delivery_as_pf_vmexit = data & KVM_ASYNC_PF_DELIVERY_AS_PF_VMEXIT;
>  
>  	kvm_async_pf_wakeup_all(vcpu);
> @@ -10433,8 +10435,11 @@ static bool kvm_can_deliver_async_pf(struct kvm_vcpu *vcpu)
>  	if (!vcpu->arch.apf.delivery_as_pf_vmexit && is_guest_mode(vcpu))
>  		return false;
>  
> -	if (!kvm_pv_async_pf_enabled(vcpu) ||
> -	    (vcpu->arch.apf.send_user_only && kvm_x86_ops.get_cpl(vcpu) == 0))
> +	/*
> +	 * 'Page not present' APF events are only delivered when CPU is in
> +	 * user mode and APF mechanism is enabled.
> +	 */
> +	if (!kvm_pv_async_pf_enabled(vcpu) || kvm_x86_ops.get_cpl(vcpu) == 0)
>  		return false;
>  
>  	return true;
> 

