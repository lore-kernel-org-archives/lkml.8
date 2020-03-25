Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31296C54FD3
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0967720771
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A594z0QU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbgCYLZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:25:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:43569 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726700AbgCYLZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585135514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=toouf1VcPqoKWzF0uloLZOST0OLlsiAbB9Xc6GTlTTc=;
        b=A594z0QU04LBy3nhaIJ/rn1Yj+LzQ/DR0BMWtuWXogG+cvI8ad9xxdFqGxZn6fAeFT5muX
        xNxxPxm+q//ZXssug64VU9l2hJFsdG24CFTt0JBJ5Gfb/K+G0JeAAw0e1/7W05/q6bDoq3
        v8FPqUYodtkkgbBo/5iaWuqD6Y243vc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-3QeIXRUcOeiSsic0o0RHyg-1; Wed, 25 Mar 2020 07:25:13 -0400
X-MC-Unique: 3QeIXRUcOeiSsic0o0RHyg-1
Received: by mail-wm1-f69.google.com with SMTP id f8so773032wmh.4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 04:25:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=toouf1VcPqoKWzF0uloLZOST0OLlsiAbB9Xc6GTlTTc=;
        b=G3eBYMoKa7IfXgRZBmxCh/6vmotaHoaQwexUql7pqvf5cJp1c4SJ+/QatlaZu2yiIK
         SL88SsvkksmMw7Xuzntt8ML/gfbNfIT6V0H7MoMBpCQSmDiLiaQE0jXgp+pLWxFDY5I9
         1R+4hwrWqoz0JuU9xbjDCTuVjqiF9GAwaPXJUqMJy3K58J1kSRYAPFCF2txc6RKwqsH7
         1TZLxqDyNV7GSygG02+1H9UbLK/2LIEw5e2+5s3uJTb/nc8yY8rflzyzV0BUTNaQHqoF
         ONE9bcMcSrLrFyE2pok0f38K2WlyKJQvZBcf3bgaj0kfCRt9zSEYPu9yC4u5rn41qFZW
         Hr+A==
X-Gm-Message-State: ANhLgQ1ekIrPcKwC+wOadNHiJPITiGIMVmfPB8Vu/RIfObzhAxbhIUee
        eH+RKYcqgDHqyHNM8ir6zbyZZHtU+1mxFInpU1p4xGjFrwbrtUvw0rc9QJA4iGtvfmbEUAieArk
        hHvj33XpVyB0wQbKRsCMOCRj1
X-Received: by 2002:a05:600c:257:: with SMTP id 23mr3070962wmj.155.1585135512017;
        Wed, 25 Mar 2020 04:25:12 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsJSQTRA98YX35iNWvD6a6KCjeDYNTNy8tWPfrPqFaCiOYjbOM2uTb5t1LUJ4AovLllT6FF0g==
X-Received: by 2002:a05:600c:257:: with SMTP id 23mr3070939wmj.155.1585135511814;
        Wed, 25 Mar 2020 04:25:11 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id d9sm5232553wmb.21.2020.03.25.04.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 04:25:11 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 18/37] KVM: VMX: Move vmx_flush_tlb() to vmx.c
In-Reply-To: <20200320212833.3507-19-sean.j.christopherson@intel.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com> <20200320212833.3507-19-sean.j.christopherson@intel.com>
Date:   Wed, 25 Mar 2020 12:25:09 +0100
Message-ID: <87tv2c65ii.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move vmx_flush_tlb() to vmx.c and make it non-inline static now that all
> its callers live in vmx.c.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 25 +++++++++++++++++++++++++
>  arch/x86/kvm/vmx/vmx.h | 25 -------------------------
>  2 files changed, 25 insertions(+), 25 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 477bdbc52ed0..c6affaaef138 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2849,6 +2849,31 @@ static void exit_lmode(struct kvm_vcpu *vcpu)
>  
>  #endif
>  
> +static void vmx_flush_tlb(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_vmx *vmx = to_vmx(vcpu);
> +
> +	/*
> +	 * Flush all EPTP/VPID contexts, as the TLB flush _may_ have been
> +	 * invoked via kvm_flush_remote_tlbs().  Flushing remote TLBs requires
> +	 * all contexts to be flushed, not just the active context.
> +	 *
> +	 * Note, this also ensures a deferred TLB flush with VPID enabled and
> +	 * EPT disabled invalidates the "correct" VPID, by nuking both L1 and
> +	 * L2's VPIDs.
> +	 */
> +	if (enable_ept) {
> +		ept_sync_global();
> +	} else if (enable_vpid) {
> +		if (cpu_has_vmx_invvpid_global()) {
> +			vpid_sync_vcpu_global();
> +		} else {
> +			vpid_sync_vcpu_single(vmx->vpid);
> +			vpid_sync_vcpu_single(vmx->nested.vpid02);
> +		}
> +	}
> +}
> +
>  static void vmx_flush_tlb_gva(struct kvm_vcpu *vcpu, gva_t addr)
>  {
>  	/*
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index bab5d62ad964..571249e18bb6 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -503,31 +503,6 @@ static inline struct vmcs *alloc_vmcs(bool shadow)
>  
>  u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa);
>  
> -static inline void vmx_flush_tlb(struct kvm_vcpu *vcpu)
> -{
> -	struct vcpu_vmx *vmx = to_vmx(vcpu);
> -
> -	/*
> -	 * Flush all EPTP/VPID contexts, as the TLB flush _may_ have been
> -	 * invoked via kvm_flush_remote_tlbs().  Flushing remote TLBs requires
> -	 * all contexts to be flushed, not just the active context.
> -	 *
> -	 * Note, this also ensures a deferred TLB flush with VPID enabled and
> -	 * EPT disabled invalidates the "correct" VPID, by nuking both L1 and
> -	 * L2's VPIDs.
> -	 */
> -	if (enable_ept) {
> -		ept_sync_global();
> -	} else if (enable_vpid) {
> -		if (cpu_has_vmx_invvpid_global()) {
> -			vpid_sync_vcpu_global();
> -		} else {
> -			vpid_sync_vcpu_single(vmx->vpid);
> -			vpid_sync_vcpu_single(vmx->nested.vpid02);
> -		}
> -	}
> -}
> -
>  static inline void decache_tsc_multiplier(struct vcpu_vmx *vmx)
>  {
>  	vmx->current_tsc_ratio = vmx->vcpu.arch.tsc_scaling_ratio;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

