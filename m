Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16CFC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C9BE206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZnp/lua"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgBUPj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:39:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:48736 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727039AbgBUPj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:39:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582299567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o8eNL5pHSEEGDRXTPvdnZ+0kgLl4XLPDpXvj6Khj+a0=;
        b=XZnp/lua9xBAG7oXd9WtXB2BVVawZ7SP3tQ+RNi9REU3EBNNXBZEVIGtbco8IW24lkHv8J
        obxgBPfV3+eDHAZVyJ/VqZn5E1XRUHZIkm1LGX9a9flswMOODfZvinOcjoHiGLOT8cnsDG
        ZBqdKYxYz0FEd/oczES34Do9x0g/rfk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-139-9tMmr1BdMPGIIb260MCddw-1; Fri, 21 Feb 2020 10:39:25 -0500
X-MC-Unique: 9tMmr1BdMPGIIb260MCddw-1
Received: by mail-wr1-f71.google.com with SMTP id r1so1173554wrc.15
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=o8eNL5pHSEEGDRXTPvdnZ+0kgLl4XLPDpXvj6Khj+a0=;
        b=NRi+cqMHqMp1H3CndYsXXQe4q04RFfjDFCrrZGmpqQl8tyWY3xLD05we5sSrls8CGX
         b8P2BoSoTnPJyvGnjHre8HpaOnKmPZUeR0PVqHsYISBBa4+zwoGsAKBLAz3xixcsmpqN
         YTLazxe1x9UTOwlH8svVvXqwVJxjq3xbq/RyP2e/JcDaaZHqOaNse0NnkDqWjIi7O3Xt
         BXE9flKybcu5Bq9kphTmeliaZEwbPx6HIS8tHsudU0+3+yR1BMvuPoU+r2hEKU3HnAet
         171LxGiC8Kfl1GvcBoI41EyDo40J5bXrifQKmOU8vS6XbeX+o0nsrVRy42yPm39EN6l4
         6vGw==
X-Gm-Message-State: APjAAAWOZIJkMBnXoiNS0FzDRCToYIPhLjpmWT4ZOKwOEQ76B3X3oY/M
        6Ul1rOtstY08qkiYqApQuQCNI+BiVBOeN0DnHbBybG5G64x+IN2PvznG/m3PMGAfJ/zbRY2Yeaq
        egK3+QDt3ByD5aGftfV11sCdq
X-Received: by 2002:adf:cd91:: with SMTP id q17mr49975313wrj.306.1582299564409;
        Fri, 21 Feb 2020 07:39:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqzr4F9d46+i3gYzMKNjyyzFiTVMMNlK43Z08VINv7Bk6pLxSJAJ8bWgIQKaxG7GLSB02rXS9w==
X-Received: by 2002:adf:cd91:: with SMTP id q17mr49975298wrj.306.1582299564176;
        Fri, 21 Feb 2020 07:39:24 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a135sm3948958wme.47.2020.02.21.07.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:39:23 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 24/61] KVM: x86: Drop explicit @func param from ->set_supported_cpuid()
In-Reply-To: <20200201185218.24473-25-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-25-sean.j.christopherson@intel.com>
Date:   Fri, 21 Feb 2020 16:39:22 +0100
Message-ID: <87blpsq79x.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Drop the explicit @func param from ->set_supported_cpuid() and instead
> pull the CPUID function from the relevant entry.  This sets the stage
> for hardening guest CPUID updates in future patches, e.g. allows adding
> run-time assertions that the CPUID feature being changed is actually
> a bit in the referenced CPUID entry.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 2 +-
>  arch/x86/kvm/cpuid.c            | 2 +-
>  arch/x86/kvm/svm.c              | 4 ++--
>  arch/x86/kvm/vmx/vmx.c          | 4 ++--
>  4 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 85f0d96cfeb2..a61928d5435b 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1148,7 +1148,7 @@ struct kvm_x86_ops {
>  
>  	void (*set_tdp_cr3)(struct kvm_vcpu *vcpu, unsigned long cr3);
>  
> -	void (*set_supported_cpuid)(u32 func, struct kvm_cpuid_entry2 *entry);
> +	void (*set_supported_cpuid)(struct kvm_cpuid_entry2 *entry);
>  
>  	bool (*has_wbinvd_exit)(void);
>  
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 056faf27b14b..e3026fe638aa 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -784,7 +784,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		break;
>  	}
>  
> -	kvm_x86_ops->set_supported_cpuid(function, entry);
> +	kvm_x86_ops->set_supported_cpuid(entry);
>  
>  	r = 0;
>  
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 3c7ddaff405d..535eb746fb0f 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -6032,9 +6032,9 @@ static void svm_cpuid_update(struct kvm_vcpu *vcpu)
>  
>  #define F feature_bit
>  
> -static void svm_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
> +static void svm_set_supported_cpuid(struct kvm_cpuid_entry2 *entry)
>  {
> -	switch (func) {
> +	switch (entry->function) {
>  	case 0x1:
>  		if (avic)
>  			entry->ecx &= ~F(X2APIC);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 98fd651f7f7e..3ff830e2258e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7104,9 +7104,9 @@ static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
>  	}
>  }
>  
> -static void vmx_set_supported_cpuid(u32 func, struct kvm_cpuid_entry2 *entry)
> +static void vmx_set_supported_cpuid(struct kvm_cpuid_entry2 *entry)
>  {
> -	if (func == 1 && nested)
> +	if (entry->function == 1 && nested)
>  		entry->ecx |= feature_bit(VMX);
>  }

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

