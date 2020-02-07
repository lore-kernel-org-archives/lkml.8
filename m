Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D29C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64B6E20720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 16:25:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yu1t52xh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgBGQZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 11:25:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59687 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726874AbgBGQZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 11:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581092754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1A4AnPYG4QKudcgCccIbKk1UqeHiL89Ca/26LbtLNW0=;
        b=Yu1t52xhmgqcNOkbcDnVYq/Yo5+l6kS4PdgDXoSMGL0R3xh/JOYyASou34QPPFhjjlawQ2
        6WOFSH6bpnD5AJBkiGmzXb6UFNlZBj/YhgdROQqvmI4S57KVhyTNOsnXoKNZoWK9Mrk8OT
        03v8zSaPpHE62k5y0s0J3qu26Ao9gL8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-HDLDArgPPvaJhw02LQiD7A-1; Fri, 07 Feb 2020 11:25:52 -0500
X-MC-Unique: HDLDArgPPvaJhw02LQiD7A-1
Received: by mail-wm1-f70.google.com with SMTP id 205so956389wmc.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 08:25:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=1A4AnPYG4QKudcgCccIbKk1UqeHiL89Ca/26LbtLNW0=;
        b=EP6Yr4HpkOQGFcQmZMNoVLeJ0vdFycgo7LKMRWpa04BDn6xt6kodVSM69My2MQb8us
         UMuQaU/XE5F148FixpbRL2Qt1KA+AY3n3rNacgoaXmXE3wv0gN2/ojDQxcB9KEF3t7pg
         yseq3Erbo2hCS3FizpGr8WrYfMYxPc4xT1NfkF1ocVWGeXnxx6Zj7OPo6BisFoIlu7hx
         PqJY9lk3YsIklzL6AyB3wKqFkuuLB+B92qV6y9t1ggETf7VyWc0lelGiTC/mfQ3+0YzW
         OZ4uJ7w457b6hVL4qY5gcUx+QBEO8QpYcTS3A3k94tjl3nU30Xtwwu0W6QnrEsBEpBNc
         Le3w==
X-Gm-Message-State: APjAAAU2V1KXcVcepi6uZLrD01j5rrX9j244uZvY+rKV7NNRgDWR7r09
        yGfC7ytpW0ajfqappVgP0VmfLSdbrljA/e4hWrWMRBxVen+OphtXSjUZR88QzychhsB48EL9dJl
        Yyi0NLQO9hcNySieS1w2yc4G2
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr5161404wmi.35.1581092751587;
        Fri, 07 Feb 2020 08:25:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqw301M5FoKZ0/Wzsw2hrBkoIM94RmCmiNqrRJGjHwwSRYaykvhuKE/qTOXZAcTjqdr1tHov0w==
X-Received: by 2002:a7b:cbc8:: with SMTP id n8mr5161389wmi.35.1581092751345;
        Fri, 07 Feb 2020 08:25:51 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e22sm4044678wme.45.2020.02.07.08.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 08:25:50 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH v2] KVM: nVMX: Fix some comment typos and coding style
In-Reply-To: <1581088965-3334-1-git-send-email-linmiaohe@huawei.com>
References: <1581088965-3334-1-git-send-email-linmiaohe@huawei.com>
Date:   Fri, 07 Feb 2020 17:25:50 +0100
Message-ID: <87zhdupdo1.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> Fix some typos in the comments. Also fix coding style.
> [Sean Christopherson rewrites the comment of write_fault_to_shadow_pgtable
> field in struct kvm_vcpu_arch.]
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
> v1->v2:
> Use Sean Christopherson' comment for write_fault_to_shadow_pgtable
> ---
>  arch/x86/include/asm/kvm_host.h | 16 +++++++++++++---
>  arch/x86/kvm/vmx/nested.c       |  5 +++--
>  2 files changed, 16 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 4dffbc10d3f8..40a0c0fd95ca 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -781,9 +781,19 @@ struct kvm_vcpu_arch {
>  	u64 msr_kvm_poll_control;
>  
>  	/*
> -	 * Indicate whether the access faults on its page table in guest
> -	 * which is set when fix page fault and used to detect unhandeable
> -	 * instruction.
> +	 * Indicates the guest is trying to write a gfn that contains one or
> +	 * more of the PTEs used to translate the write itself, i.e. the access
> +	 * is changing its own translation in the guest page tables.  KVM exits
> +	 * to userspace if emulation of the faulting instruction fails and this
> +	 * flag is set, as KVM cannot make forward progress.
> +	 *
> +	 * If emulation fails for a write to guest page tables, KVM unprotects
> +	 * (zaps) the shadow page for the target gfn and resumes the guest to
> +	 * retry the non-emulatable instruction (on hardware).  Unprotecting the
> +	 * gfn doesn't allow forward progress for a self-changing access because
> +	 * doing so also zaps the translation for the gfn, i.e. retrying the
> +	 * instruction will hit a !PRESENT fault, which results in a new shadow
> +	 * page and sends KVM back to square one.
>  	 */
>  	bool write_fault_to_shadow_pgtable;
>  
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 657c2eda357c..e7faebccd733 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -544,7 +544,8 @@ static void nested_vmx_disable_intercept_for_msr(unsigned long *msr_bitmap_l1,
>  	}
>  }
>  
> -static inline void enable_x2apic_msr_intercepts(unsigned long *msr_bitmap) {
> +static inline void enable_x2apic_msr_intercepts(unsigned long *msr_bitmap)
> +{
>  	int msr;
>  
>  	for (msr = 0x800; msr <= 0x8ff; msr += BITS_PER_LONG) {
> @@ -1981,7 +1982,7 @@ static int nested_vmx_handle_enlightened_vmptrld(struct kvm_vcpu *vcpu,
>  	}
>  
>  	/*
> -	 * Clean fields data can't de used on VMLAUNCH and when we switch
> +	 * Clean fields data can't be used on VMLAUNCH and when we switch
>  	 * between different L2 guests as KVM keeps a single VMCS12 per L1.
>  	 */
>  	if (from_launch || evmcs_gpa_changed)

With Sean's comment added the subject of the patch is a bit unexpected
:-) But the change itself looks good (and thanks Sean for the great
explanation!).

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

