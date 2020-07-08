Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F8B6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB3C020772
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 11:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KA2YZHkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgGHLZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 07:25:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47279 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728730AbgGHLZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594207511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ouHANG20USBE2PCP33rRejZoUHD5MZlrUjWu6D42Tb4=;
        b=KA2YZHkGdCGN2YVpn6uMNpQb21kQvvRgz9owFiAu6GI2lSHYe8Z9e6EevlEqy2LNOiX+kI
        AGESEwt6yFq0E/2sMLhG41bFbBqJg0eDLYshM3u4ykkxXgEZ59eiIBlMGUrDZEoLZz1KLW
        y1LqipVmjyEbNr0YMW8kndh/oWDt3Oc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-GM8-KE1MPfGT2ffzZa3Dhw-1; Wed, 08 Jul 2020 07:25:09 -0400
X-MC-Unique: GM8-KE1MPfGT2ffzZa3Dhw-1
Received: by mail-wr1-f70.google.com with SMTP id e11so51772278wrs.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 04:25:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ouHANG20USBE2PCP33rRejZoUHD5MZlrUjWu6D42Tb4=;
        b=OCbx3udocBukofMWHuy6uGM7B9fZ+GzcjStwObxF1xexDjQ411QyplPCAFqtdspgnW
         NdAAcypL6S7d4AT8mdl7pMrHl2cLi7JPBprhjWXNAW6RummISD3kjAwUVvY9F6SQJpXT
         Gz8ebUrnhzx1XxAGO9mRcWwQrGfRIbjDhuYZks9xVxeVdzlZquEeSU0Y0mTnQ8lJZ3/P
         BjfCcCDAAiN4OLwvqZerLr9lZ7SLCOV2Ju22an0mjTm8Gr1QIGibxsG7LsCMaVZi+phn
         7ErUkWvl9N8NnO6mgYAbss7DBhDlwgYMdzPWC2U96u2oNxjmic9RE8xAdcIDIl4++Z++
         hVMg==
X-Gm-Message-State: AOAM532zoybpkpIRo3165IGcCNLLas6NQu5iTJeOr3Qa7phEmKwKvxyG
        Wl8gvDkOteZfpslzWWTwO35tahTPD0GBWZqvuwaPQXRDuVfv1FPqK1fIAcuE1mZ6Uwe6QUYx8vc
        TdStztoaP/VGZLjtJseXLnPOL
X-Received: by 2002:adf:91e1:: with SMTP id 88mr51187467wri.89.1594207508242;
        Wed, 08 Jul 2020 04:25:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXgz9j1sndzaJgOQXlSN4IivMaE3Sx1qi84w6Se+wj028onpholiatocyX5gSUkoL/o3ht2w==
X-Received: by 2002:adf:91e1:: with SMTP id 88mr51187436wri.89.1594207507992;
        Wed, 08 Jul 2020 04:25:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id m9sm5433915wml.45.2020.07.08.04.25.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 04:25:07 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] KVM: nSVM: split kvm_init_shadow_npt_mmu() from
 kvm_init_shadow_mmu()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
References: <20200708093611.1453618-1-vkuznets@redhat.com>
 <20200708093611.1453618-2-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <42d6eefa-2875-ff4d-c972-71fe405aec98@redhat.com>
Date:   Wed, 8 Jul 2020 13:25:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200708093611.1453618-2-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 11:36, Vitaly Kuznetsov wrote:
> @@ -4973,7 +4969,28 @@ void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efer)
>  	context->mmu_role.as_u64 = new_role.as_u64;
>  	reset_shadow_zero_bits_mask(vcpu, context);
>  }
> -EXPORT_SYMBOL_GPL(kvm_init_shadow_mmu);
> +
> +static void kvm_init_shadow_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efer)
> +{
> +	struct kvm_mmu *context = vcpu->arch.mmu;
> +	union kvm_mmu_role new_role =
> +		kvm_calc_shadow_mmu_root_page_role(vcpu, false);
> +
> +	if (new_role.as_u64 != context->mmu_role.as_u64)
> +		shadow_mmu_init_context(vcpu, cr0, cr4, efer, new_role);
> +}
> +
> +void kvm_init_shadow_npt_mmu(struct kvm_vcpu *vcpu, u32 cr0, u32 cr4, u32 efer,
> +			     gpa_t nested_cr3)
> +{
> +	struct kvm_mmu *context = vcpu->arch.mmu;
> +	union kvm_mmu_role new_role =
> +		kvm_calc_shadow_mmu_root_page_role(vcpu, false);
> +
> +	if (new_role.as_u64 != context->mmu_role.as_u64)
> +		shadow_mmu_init_context(vcpu, cr0, cr4, efer, new_role);
> +}
> +EXPORT_SYMBOL_GPL(kvm_init_shadow_npt_mmu);
>  
>  static union kvm_mmu_role

As a follow up, the assignments to context should stop using
vcpu->arch.mmu in favor of root_mmu/guest_mmu.

Paolo

