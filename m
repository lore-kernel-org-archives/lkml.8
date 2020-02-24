Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69DF9C38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 305DA227BF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qm7PM+pf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBXWNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:13:45 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44839 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726651AbgBXWNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:13:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582582423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iUc8WY+gnsCmYrkD/dUcGcDzuOer8ITJ6cRC9/JT5TY=;
        b=Qm7PM+pfMjHvRgmEWZsv+5PjcWqmexkBe5NFCtIJUI6ca/S18hYdkaxmcDYPYiTgfOzeHt
        TxFmHpHwJobVTCVOoxWjnEMI0QG+iuhToHPn8VCLebgvv+DJ0CvYYE+FcTLLgRM/+IvnGV
        /OdJXoJHuquA083VNyQBncpeV+e0tmE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-7CVOvCaLPH-JUKCddDI7Lg-1; Mon, 24 Feb 2020 17:13:41 -0500
X-MC-Unique: 7CVOvCaLPH-JUKCddDI7Lg-1
Received: by mail-wr1-f70.google.com with SMTP id y28so2657189wrd.23
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 14:13:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iUc8WY+gnsCmYrkD/dUcGcDzuOer8ITJ6cRC9/JT5TY=;
        b=QCIjpAu1NOQJylErZaDDrEdUsbV5di2H0J1nKiS7P0UUu8S1PC81wycg4u5NUXs2ew
         UdCRApeimHOscGJnYPV8Vv6kKaml3AeLac9BjroAUBppEYWCKivUQ6WsBUHgbFLO61Ip
         eXLhafhRyjxpi11bIIJiDzHywzaFQDvSTLqYmDdkdFwkfGhyHAZZ8CtKjVaGV9NLJQo/
         lr8Dzcima9peOxq58cLgtvc8e1NQ8iwrJQBAxpbQdKCUfkr63X1rMQla/UWFohwjDCcl
         KGeOX3CXLoDmRuGoFOAwT1VEo83JItcHjxGnQsEA/0dHxYZWBRazJs1Br8I70lRNycgn
         rx8g==
X-Gm-Message-State: APjAAAWA1dbdpSImetAuhOdtru322CjnELLB4RIM9J+SjJuOotRCpVtj
        FqphGhwYP6VoAbPKdPMst9mV1q6cJ63m3uwckg/x3C9tWcDXbl1zjKtn1jjmo7jsKjlNKR71pXd
        8SCaSgJhT/Hb4ZcV4LEZSrWMB
X-Received: by 2002:a1c:b603:: with SMTP id g3mr1085709wmf.130.1582582419964;
        Mon, 24 Feb 2020 14:13:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqzLFFJ7TXLWA9KtHwshX/lvtpNzok+t05kHS2aITtdvR9bhgqTzFRHcp9FRPyq3p4zar53dlA==
X-Received: by 2002:a1c:b603:: with SMTP id g3mr1085689wmf.130.1582582419689;
        Mon, 24 Feb 2020 14:13:39 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g2sm19989962wrw.76.2020.02.24.14.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:13:39 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 44/61] KVM: x86: Use KVM cpu caps to track UMIP emulation
In-Reply-To: <20200201185218.24473-45-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-45-sean.j.christopherson@intel.com>
Date:   Mon, 24 Feb 2020 23:13:37 +0100
Message-ID: <87zhd7my5q.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Set UMIP in kvm_cpu_caps when it is emulated by VMX, even though the
> bit will be effectively be dropped 

Redundant 'be'

> by do_host_cpuid().  This allows checking for UMIP emulation via
> kvm_cpu_caps instead of a dedicated kvm_x86_ops callback.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 1 -
>  arch/x86/kvm/svm.c              | 6 ------
>  arch/x86/kvm/vmx/vmx.c          | 8 +++++++-
>  arch/x86/kvm/x86.c              | 2 +-
>  4 files changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index dd690fb5ceca..113b138a0347 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1163,7 +1163,6 @@ struct kvm_x86_ops {
>  	void (*handle_exit_irqoff)(struct kvm_vcpu *vcpu,
>  		enum exit_fastpath_completion *exit_fastpath);
>  
> -	bool (*umip_emulated)(void);
>  	bool (*pt_supported)(void);
>  
>  	int (*check_nested_events)(struct kvm_vcpu *vcpu, bool external_intr);
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index defb2c0dbf8a..e1ed5726964c 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -6079,11 +6079,6 @@ static bool svm_rdtscp_supported(void)
>  	return boot_cpu_has(X86_FEATURE_RDTSCP);
>  }
>  
> -static bool svm_umip_emulated(void)
> -{
> -	return false;
> -}
> -
>  static bool svm_pt_supported(void)
>  {
>  	return false;
> @@ -7449,7 +7444,6 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
>  	.cpuid_update = svm_cpuid_update,
>  
>  	.rdtscp_supported = svm_rdtscp_supported,
> -	.umip_emulated = svm_umip_emulated,
>  	.pt_supported = svm_pt_supported,
>  
>  	.set_supported_cpuid = svm_set_supported_cpuid,
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index cecf59225136..cd5a624610c9 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7103,6 +7103,10 @@ static void vmx_set_supported_cpuid(struct kvm_cpuid_entry2 *entry)
>  {
>  	switch (entry->function) {
>  	case 0x7:
> +		/*
> +		 * UMIP needs to be manually set even though vmx_set_cpu_caps()
> +		 * also sets UMIP since do_host_cpuid() will drop it.
> +		 */
>  		if (vmx_umip_emulated())
>  			cpuid_entry_set(entry, X86_FEATURE_UMIP);
>  		break;
> @@ -7129,6 +7133,9 @@ static __init void vmx_set_cpu_caps(void)
>  	if (enable_ept && boot_cpu_has(X86_FEATURE_OSPKE))
>  		kvm_cpu_cap_check_and_set(X86_FEATURE_PKU);
>  
> +	if (vmx_umip_emulated())
> +		kvm_cpu_cap_set(X86_FEATURE_UMIP);
> +
>  	/* CPUID 0xD.1 */
>  	if (!vmx_xsaves_supported())
>  		kvm_cpu_cap_clear(X86_FEATURE_XSAVES);
> @@ -7888,7 +7895,6 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
>  
>  	.check_intercept = vmx_check_intercept,
>  	.handle_exit_irqoff = vmx_handle_exit_irqoff,
> -	.umip_emulated = vmx_umip_emulated,
>  	.pt_supported = vmx_pt_supported,
>  
>  	.request_immediate_exit = vmx_request_immediate_exit,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index cb40737187a1..a6d5f22c7ef6 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -915,7 +915,7 @@ static u64 kvm_host_cr4_reserved_bits(struct cpuinfo_x86 *c)
>  	if (kvm_cpu_cap_has(X86_FEATURE_LA57))
>  		reserved_bits &= ~X86_CR4_LA57;
>  
> -	if (kvm_x86_ops->umip_emulated())
> +	if (kvm_cpu_cap_has(X86_FEATURE_UMIP))
>  		reserved_bits &= ~X86_CR4_UMIP;
>  
>  	return reserved_bits;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

