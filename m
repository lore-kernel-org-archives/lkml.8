Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B63C7619F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0884320718
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 08:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auCaW1VS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgBQI5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 03:57:45 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56695 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728654AbgBQI5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 03:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581929864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3kliMoTg8Lcr/Q7CgDewoOkhEDiCmvd3cNoaAkKHe/Y=;
        b=auCaW1VSjye6vuCMqNGupsLq8NZvDqMHsVofNwJmOvzSNDZ3RjbpO79gEM3E+p0fPh/MkA
        0+Qz1pKpyrKfutU8G/LTqUGQF6OPYOKcqDf5dargLPgWdf9zRm3p5IVjY9alsDCv9g88Gv
        CGMA6pbe9VsWDsdVRlwdsCWtq9tD2w4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-vHvbIeqVOMK5BTcuVGw8Xg-1; Mon, 17 Feb 2020 03:57:43 -0500
X-MC-Unique: vHvbIeqVOMK5BTcuVGw8Xg-1
Received: by mail-wm1-f70.google.com with SMTP id u11so5939763wmb.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 00:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=3kliMoTg8Lcr/Q7CgDewoOkhEDiCmvd3cNoaAkKHe/Y=;
        b=T4lGZ2q0NhzY53RLzdVDhm2hMaTOXzdDvByky2n3JCFmuVFZr5GOAf8DdrroM7OkOM
         Y8N0F8xpFUFXgr0d77hhvRzk80+u5Oslwugp/XznKsfOtGPp6af9p9tTLuGiGVb8tVpN
         /GkcwrWrijJrJaKLuUk3gdhJT7ERHZCzzkr4P5yhLmCjkloSOL4YV4o16pPMADh0CQY8
         R4Cbg5UK1y6+/HGjAuGG2FiNPoa9+cGAUYeOMNXPC+XikBLfYNZeK/Y96/P2Yz5TPO1Q
         MOha9kc8bFprPk6pU2dLt3jzGNJ3qlIOawU7iytRssbBjy7P1snhNtJdMAX6T6i7Fg7S
         S9Fg==
X-Gm-Message-State: APjAAAXScRawWzgjaAvcdYh87LdnO8/FdHwgqx25R0N2vttqE3cjAVHu
        NONdGfpC/mO/zwVI71scKycBQhjlnMjROoqlEVU8qMCeslphT+2oRwQ4RFNrwa6xQyu4dAomNn+
        WKBMEAXxs8V3G+Ips2cJ/GYwy
X-Received: by 2002:a1c:de55:: with SMTP id v82mr20900096wmg.48.1581929861734;
        Mon, 17 Feb 2020 00:57:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqxRwndD3XkbOjhzvAUd57i0vfL669NBYdxTAMC8FbfyAoZr0mnZXFUeHf/l3jE2cYXdPNgHLA==
X-Received: by 2002:a1c:de55:: with SMTP id v82mr20900070wmg.48.1581929861516;
        Mon, 17 Feb 2020 00:57:41 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t13sm19655105wrw.19.2020.02.17.00.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 00:57:40 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: x86: Fix print format and coding style
In-Reply-To: <1581734662-970-1-git-send-email-linmiaohe@huawei.com>
References: <1581734662-970-1-git-send-email-linmiaohe@huawei.com>
Date:   Mon, 17 Feb 2020 09:57:40 +0100
Message-ID: <87o8txbngb.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> Use %u to print u32 var and correct some coding style.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/i8254.c      | 2 +-
>  arch/x86/kvm/mmu/mmu.c    | 3 +--
>  arch/x86/kvm/vmx/nested.c | 2 +-
>  3 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
> index b24c606ac04b..febca334c320 100644
> --- a/arch/x86/kvm/i8254.c
> +++ b/arch/x86/kvm/i8254.c
> @@ -367,7 +367,7 @@ static void pit_load_count(struct kvm_pit *pit, int channel, u32 val)
>  {
>  	struct kvm_kpit_state *ps = &pit->pit_state;
>  
> -	pr_debug("load_count val is %d, channel is %d\n", val, channel);
> +	pr_debug("load_count val is %u, channel is %d\n", val, channel);
>  
>  	/*
>  	 * The largest possible initial count is 0; this is equivalent
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 7011a4e54866..9c228b9910b1 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3568,8 +3568,7 @@ static bool fast_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  		 * write-protected for dirty-logging or access tracking.
>  		 */
>  		if ((error_code & PFERR_WRITE_MASK) &&
> -		    spte_can_locklessly_be_made_writable(spte))
> -		{
> +		    spte_can_locklessly_be_made_writable(spte)) {
>  			new_spte |= PT_WRITABLE_MASK;
>  
>  			/*
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index f2d8cb68dce8..6f3e515f28fd 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4367,7 +4367,7 @@ int get_vmx_mem_address(struct kvm_vcpu *vcpu, unsigned long exit_qualification,
>  	if (base_is_valid)
>  		off += kvm_register_read(vcpu, base_reg);
>  	if (index_is_valid)
> -		off += kvm_register_read(vcpu, index_reg)<<scaling;
> +		off += kvm_register_read(vcpu, index_reg) << scaling;
>  	vmx_get_segment(vcpu, &s, seg_reg);
>  
>  	/*

I would've suggested we split such unrelated changes by source files in
the future to simplify (possible) stable backporting. Changes themselves
look good,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

