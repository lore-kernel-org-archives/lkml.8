Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8377AC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F31820714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ky1k0yEl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgBXPVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:21:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:25651 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727689AbgBXPVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:21:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582557705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IopEsTUE5lI0cUR+880LPC7mmamlm8psrnpSr2ASOkM=;
        b=Ky1k0yElfVQ2sDSsP50Jy4r67xb1isuU9oMpdbc/pyzvCbIMXHo3XmMrcHt5Jok7aOv0Hq
        HyzpSgmPpAP+vkHvOwS49bzy7faFOeli/PAMk4tWoKnLLsNi5aGYZtD5axzUF4ldcq66cm
        z1rJutYVdXxv9Lt/uUUf4KRzthLmkEY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-xuUEZvpAOp28pOJ9K1T-PQ-1; Mon, 24 Feb 2020 10:21:44 -0500
X-MC-Unique: xuUEZvpAOp28pOJ9K1T-PQ-1
Received: by mail-wr1-f69.google.com with SMTP id t3so3965743wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:21:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=IopEsTUE5lI0cUR+880LPC7mmamlm8psrnpSr2ASOkM=;
        b=IWzLdwlv71lOX/1gVXHDOWHmoow0/n1Ijljjv0iUTMjRoHGWhtb2r2JCWScZ967IEx
         fvTxCO3HPHIWv9rUX3xpSgV30SxH3/+rsVRD2y+XPl38lfG+X2SmXTLCMDG4YjZ9zfYg
         /yIZeEBmmpd6gGwOEwEg0s5zCyjnyXFxeSmkIhQywSgkCTo7IN5ARUljdksCMFjdEypW
         5iRbwGh4dMEVVutOBts5pCaS8wP4g+eKYVMKCSqxvr3aqxRZzl8lDrIdsISDIqd4+HCt
         1lz8nVnANcXmFvIzdsslhwbgGJ+txYx57bdM94dtBapFqXunHtKuRgaP+eyANPazDr04
         6vTQ==
X-Gm-Message-State: APjAAAXzE+9z5yV2VECUfgbBMvTEzFI1tj8DrZDyKiY6hRLV1d/3rekt
        xD5V24/heoyKoZFiGSG0BUXizn7arwO82cSWToNzyV0LO8LmlABOLq1qtM/Zic/M14v46EbNP6Y
        p6N4N7LGgc7UrB/ZVZAspVA3c
X-Received: by 2002:a1c:6389:: with SMTP id x131mr23481540wmb.155.1582557703188;
        Mon, 24 Feb 2020 07:21:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYPhCx7IoeJSa2iQ/qLZj3RL6CoZ096gV1mztg+UbOH9RxjotR5udiQDnoBWE9fIOZLSaQqQ==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr23481524wmb.155.1582557702990;
        Mon, 24 Feb 2020 07:21:42 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h13sm18581924wrw.54.2020.02.24.07.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:21:42 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 32/61] KVM: x86: Handle UMIP emulation CPUID adjustment in VMX code
In-Reply-To: <20200201185218.24473-33-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-33-sean.j.christopherson@intel.com>
Date:   Mon, 24 Feb 2020 16:21:41 +0100
Message-ID: <87y2ssnh8a.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move the CPUID adjustment for UMIP emulation into VMX code to eliminate
> an instance of the undesirable "unsigned f_* = *_supported ? F(*) : 0"
> pattern in the common CPUID handling code.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c   | 2 --
>  arch/x86/kvm/vmx/vmx.c | 2 ++
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index a5f150204d73..202a6c0f1db8 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -339,7 +339,6 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
>  
>  static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry)
>  {
> -	unsigned f_umip = kvm_x86_ops->umip_emulated() ? F(UMIP) : 0;
>  	unsigned f_intel_pt = kvm_x86_ops->pt_supported() ? F(INTEL_PT) : 0;
>  	unsigned f_la57;
>  	unsigned f_pku = kvm_x86_ops->pku_supported() ? F(PKU) : 0;
> @@ -382,7 +381,6 @@ static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry)
>  		cpuid_entry_mask(entry, CPUID_7_ECX);
>  		/* Set LA57 based on hardware capability. */
>  		entry->ecx |= f_la57;
> -		entry->ecx |= f_umip;
>  		entry->ecx |= f_pku;
>  		/* PKU is not yet implemented for shadow paging. */
>  		if (!tdp_enabled || !boot_cpu_has(X86_FEATURE_OSPKE))
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 49ee4c600934..9d2e36a5ecb9 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7111,6 +7111,8 @@ static void vmx_set_supported_cpuid(struct kvm_cpuid_entry2 *entry)
>  			cpuid_entry_set(entry, X86_FEATURE_MPX);
>  		if (boot_cpu_has(X86_FEATURE_INVPCID) && cpu_has_vmx_invpcid())
>  			cpuid_entry_set(entry, X86_FEATURE_INVPCID);
> +		if (vmx_umip_emulated())
> +			cpuid_entry_set(entry, X86_FEATURE_UMIP);
>  		break;
>  	default:
>  		break;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

