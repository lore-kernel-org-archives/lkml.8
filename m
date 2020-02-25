Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D07C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:03:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ED382082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GH43+Gi2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbgBYPC7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:02:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26878 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730810AbgBYPC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582642977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QsUuUqLhrHe8PUYsgfmY/tzShcrlmSfcdDzSbxrzr9g=;
        b=GH43+Gi2soCzu5IBWmG4jViMShCNS+sDicbCvbMuGXGxalhs3DRAF7+no73SOu8xDAnwFM
        ZQl7UyXkk8hPesbwkK8RtYdOg0UQlC064OFsFF30kO9FC2xTvAH2MjM746qSyIou7V5eQt
        /UTWz/U6018QSKN2zOOjY0iT3S4i9pI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-qY627msGP0CZGKHOCf4IuA-1; Tue, 25 Feb 2020 10:02:56 -0500
X-MC-Unique: qY627msGP0CZGKHOCf4IuA-1
Received: by mail-wm1-f69.google.com with SMTP id z7so988288wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 07:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=QsUuUqLhrHe8PUYsgfmY/tzShcrlmSfcdDzSbxrzr9g=;
        b=X7D8gnS7ODzWRFrrCg0uLC9S3TXBwvagvX8CXHshOSKnhqoBA4MlyIQe7aZHND4BvD
         nJxb4HjSLypykTwOo7+TwmyG3sRthrdI3QOY1mIFy/ZqZF9D/87ja5H/vfFqtPANhQNt
         CsL9YsrZFmbvX73f5Casy66CFhwjpWin4eyI8pYZfkKZPkpSksbvnsePRU2L30yZ9S/j
         g22lpA5w6ISvVv5XntzmJ0xbiBe0YdwLmHoy78PdkUYLZQJCMOGeT/SZLCtBaH/5l1Y0
         31vSFvZMoqCD+WFdcbjsLEvMoU2Bg0bpvkQd4ZFj0L0GMzq+082WNeZ+PwuBk3QEt0Jr
         LROQ==
X-Gm-Message-State: APjAAAV6VdEb5ALv0AcLRuI9bIJvLpokXGmQCZ6aiSKttfvlqmhMDp6R
        +uUmCbYUL8G5v7gVmGARm1ZJSyaRxUoiVoY8L3u5K0A5b/q5qrL95O+1+5C6dTFf0OyL+orYDX5
        ZGLAGP5DVJAH6I/FtWnUI4ZXO
X-Received: by 2002:a5d:6191:: with SMTP id j17mr70305554wru.427.1582642974717;
        Tue, 25 Feb 2020 07:02:54 -0800 (PST)
X-Google-Smtp-Source: APXvYqzus9h6OKiJ36YQf4+GPEntJYdPgq2qYygP3Yinuve1nFXgN3mUnuND1RVVgpSgd5fqWu9wqQ==
X-Received: by 2002:a5d:6191:: with SMTP id j17mr70305526wru.427.1582642974464;
        Tue, 25 Feb 2020 07:02:54 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z8sm24250673wrv.74.2020.02.25.07.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 07:02:53 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 61/61] KVM: x86: Move VMX's host_efer to common x86 code
In-Reply-To: <20200201185218.24473-62-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-62-sean.j.christopherson@intel.com>
Date:   Tue, 25 Feb 2020 16:02:53 +0100
Message-ID: <8736aylnfm.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move host_efer to common x86 code and use it for CPUID's is_efer_nx() to
> avoid constantly re-reading the MSR.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 2 ++
>  arch/x86/kvm/cpuid.c            | 5 +----
>  arch/x86/kvm/vmx/vmx.c          | 3 ---
>  arch/x86/kvm/vmx/vmx.h          | 1 -
>  arch/x86/kvm/x86.c              | 5 +++++
>  5 files changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 4165d3ef11e4..a2a091d328c6 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1257,6 +1257,8 @@ struct kvm_arch_async_pf {
>  	bool direct_map;
>  };
>  
> +extern u64 __read_mostly host_efer;
> +

I'm surprised we don't actually cache MSR_EFER in some common x86 code
already.

>  extern struct kvm_x86_ops *kvm_x86_ops;
>  extern struct kmem_cache *x86_fpu_cache;
>  
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 3d287fc6eb6e..e8beb1e542a8 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -134,10 +134,7 @@ int kvm_update_cpuid(struct kvm_vcpu *vcpu)
>  
>  static int is_efer_nx(void)
>  {
> -	unsigned long long efer = 0;
> -
> -	rdmsrl_safe(MSR_EFER, &efer);
> -	return efer & EFER_NX;
> +	return host_efer & EFER_NX;
>  }
>  
>  static void cpuid_fix_nx_cap(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index e349689ac0cf..0009066e2009 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -433,7 +433,6 @@ static const struct kvm_vmx_segment_field {
>  	VMX_SEGMENT_FIELD(LDTR),
>  };
>  
> -u64 host_efer;
>  static unsigned long host_idt_base;
>  
>  /*
> @@ -7577,8 +7576,6 @@ static __init int hardware_setup(void)
>  	struct desc_ptr dt;
>  	int r, i, ept_lpage_level;
>  
> -	rdmsrl_safe(MSR_EFER, &host_efer);
> -
>  	store_idt(&dt);
>  	host_idt_base = dt.address;
>  
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 70eafa88876a..0e50fbcb8413 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -12,7 +12,6 @@
>  #include "vmcs.h"
>  
>  extern const u32 vmx_msr_index[];
> -extern u64 host_efer;
>  
>  extern u32 get_umwait_control_msr(void);
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index b40488fd2969..2103101eca78 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -185,6 +185,9 @@ static struct kvm_shared_msrs __percpu *shared_msrs;
>  				| XFEATURE_MASK_BNDCSR | XFEATURE_MASK_AVX512 \
>  				| XFEATURE_MASK_PKRU)
>  
> +u64 __read_mostly host_efer;
> +EXPORT_SYMBOL_GPL(host_efer);
> +
>  static u64 __read_mostly host_xss;
>  
>  struct kvm_stats_debugfs_item debugfs_entries[] = {
> @@ -9590,6 +9593,8 @@ int kvm_arch_hardware_setup(void)
>  {
>  	int r;
>  
> +	rdmsrl_safe(MSR_EFER, &host_efer);
> +
>  	kvm_set_cpu_caps();
>  
>  	r = kvm_x86_ops->hardware_setup();

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

