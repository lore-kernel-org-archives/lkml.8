Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71862C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 415AE206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lb6jeYSk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbgFWJuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:50:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39397 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732011AbgFWJuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:50:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592905813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YUWKpAA/Hhk4UI8s/nEYBc1/Nwq36zCGzOCK051Tg9w=;
        b=Lb6jeYSkvpeUL2skWQyWgQ3AmbIgCM2pzyYm1OxtHOmuc6KMGZvpwWXLdkg4IHtbgA2Iac
        o7MJ2MNAXfBDRt6JKQyKM/ZqKT2HTixhnqInpWBkFQB6/OahYSOxpi6WG5v7A98RkHquxv
        nXc8sPt2mdAA8HidYt8IemuJZergvPc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-WIJBnkEXMRCxnAS8lyXExg-1; Tue, 23 Jun 2020 05:50:12 -0400
X-MC-Unique: WIJBnkEXMRCxnAS8lyXExg-1
Received: by mail-wr1-f69.google.com with SMTP id p9so14683834wrx.10
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YUWKpAA/Hhk4UI8s/nEYBc1/Nwq36zCGzOCK051Tg9w=;
        b=r5dQ6t4Wf1+DIAgNVaybJiGRihUFsQINQrXAjGhp9XVbfqc0yxjc8f5u2y2fNKBmQQ
         otu+zG1KzpSjR1eXyAZYbeNNrAKf0IBzbzCD6sNfRWddi3SSKVfQ4RlfoSOb1zzjcJ5c
         IOJqxY/Qpxoms7COIHE2r7BZkL/UlxZe3iedNm3bpMLAf8w3HocCcgvaLq8RvWTa2ZPy
         QZoHfMcHp7TqnkBe9A4mQ3m34BlJZSvUq/tWs8CwG/yazPuF+wYNe4wmtOEKuwm6+tNE
         Xj8bOxqtwmW4d4wWJiN/I3Nllm5ciCnks7LXzUvCKw7nxluUomky6pZPOn9ttRjXHFro
         aKDg==
X-Gm-Message-State: AOAM531dmBSrGErPkQjosTXH7ytEgmv3WbtUxU8g1PKlO90Oht2u47Ni
        qcMGT0bFJQGuFBsj79aR31VVx1fYStG1/XFXufPS1GzmlLtLXIrTrzMaV14EQK3+IbWTZd355EQ
        VGYelgRywaZZAlyalq+/lQP7i
X-Received: by 2002:a05:6000:18c:: with SMTP id p12mr25626927wrx.66.1592905810046;
        Tue, 23 Jun 2020 02:50:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxekMM2DbqF5WADhrGxqod6OIVEnPVOq+j2KwNGmFCSXAEV4K6MeVmfhgj8xr0dwyao5yUbmA==
X-Received: by 2002:a05:6000:18c:: with SMTP id p12mr25626902wrx.66.1592905809756;
        Tue, 23 Jun 2020 02:50:09 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:24f5:23b:4085:b879? ([2001:b07:6468:f312:24f5:23b:4085:b879])
        by smtp.gmail.com with ESMTPSA id 67sm22498925wrk.49.2020.06.23.02.50.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 02:50:09 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Fix MSR range of APIC registers in X2APIC mode
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200616073307.16440-1-xiaoyao.li@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <daf1fe8b-dcaf-5008-aa3f-ab8b1b538414@redhat.com>
Date:   Tue, 23 Jun 2020 11:50:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200616073307.16440-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/20 09:33, Xiaoyao Li wrote:
> Only MSR address range 0x800 through 0x8ff is architecturally reserved
> and dedicated for accessing APIC registers in x2APIC mode.
> 
> Fixes: 0105d1a52640 ("KVM: x2apic interface to lapic")
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  arch/x86/kvm/x86.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 00c88c2f34e4..29d9b078ce69 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2856,7 +2856,7 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		return kvm_mtrr_set_msr(vcpu, msr, data);
>  	case MSR_IA32_APICBASE:
>  		return kvm_set_apic_base(vcpu, msr_info);
> -	case APIC_BASE_MSR ... APIC_BASE_MSR + 0x3ff:
> +	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
>  		return kvm_x2apic_msr_write(vcpu, msr, data);
>  	case MSR_IA32_TSCDEADLINE:
>  		kvm_set_lapic_tscdeadline_msr(vcpu, data);
> @@ -3196,7 +3196,7 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_IA32_APICBASE:
>  		msr_info->data = kvm_get_apic_base(vcpu);
>  		break;
> -	case APIC_BASE_MSR ... APIC_BASE_MSR + 0x3ff:
> +	case APIC_BASE_MSR ... APIC_BASE_MSR + 0xff:
>  		return kvm_x2apic_msr_read(vcpu, msr_info->index, &msr_info->data);
>  	case MSR_IA32_TSCDEADLINE:
>  		msr_info->data = kvm_get_lapic_tscdeadline_msr(vcpu);
> 

Queued, thanks (with Cc to stable).

Paolo

