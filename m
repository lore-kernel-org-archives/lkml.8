Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9B8C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A361C21D7D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 17:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C5nvWqFK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgBQRLt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 12:11:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45745 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726492AbgBQRLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 12:11:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581959508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=leoJMIVrujXHR+1B3Le9Ku9YRkCu9ED/B2eHIqy0AMM=;
        b=C5nvWqFKEZYCaP0LO7QQ0NOB/cCAzQvSreM8sKeE2udW3/3lWUbn0i+MUzFmX2j919qFll
        jYmqXAgeI4EJgpXM1NZ7Br7hNQrJIoephW1R84aj+V2CojblMb/3l4b2xbr0cq0xAZhu/F
        +A+v/chpAMgeJ+9cyD7LEneGOw77Jyg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-Dhc-CyKRM72V5Adb46TF7w-1; Mon, 17 Feb 2020 12:11:46 -0500
X-MC-Unique: Dhc-CyKRM72V5Adb46TF7w-1
Received: by mail-wr1-f72.google.com with SMTP id r1so9227316wrc.15
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 09:11:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=leoJMIVrujXHR+1B3Le9Ku9YRkCu9ED/B2eHIqy0AMM=;
        b=PC0pxHWqICzkf2N/z0Ehtx8sy72k1n3EcbFIrszq/XK1O1EG7nKBhW+S5flT6mEXGw
         D5VjPucs4R6JxMkyoZ2fDKorloWCQjaZw7QrejNoZf/m01RNkTR+q+Tcd7NWI45bHhIf
         xHjqQ3iuT+4/fg0dQWRObPFEWzk7hX7SeHFZgtQuO856oJMP1ngm45mVIOs0VTJRy4YY
         6I5OYUc9RLVcH+yaGvCDRr17xq35VSguFksE8bO1szRw61sF40bdXXZZkH7D+m7MZDeD
         sGN0O4uw4hKxhyOpNw3vaxXjmQ7Bc6TibN3m/0RzuKyVNlX2uPnIX57RnvXBJjgYgBg9
         98Ww==
X-Gm-Message-State: APjAAAUu2BnYXyyih6Ku21ezLPZfEytYzDkPB3gA5PlcK/X4jl7W7qEL
        CjekQ1eswM0+dLrDigAFx99xTWBpJDZIFMO/i3ZjbTEUPMlwj++fyV0ASt4GDqOIGfHkLKNtLLF
        bj+AEbhZms2jnHD01OCXIUUuw
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr53665wma.84.1581959505682;
        Mon, 17 Feb 2020 09:11:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyc3kAzEzp60v3wlpcZz3+V4nTnF88wgPHYMMKj2MdprBmNt1fNlvlTiF7mjwEkOVmMJb97RA==
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr53647wma.84.1581959505445;
        Mon, 17 Feb 2020 09:11:45 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4? ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
        by smtp.gmail.com with ESMTPSA id 133sm74730wme.32.2020.02.17.09.11.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2020 09:11:44 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: eliminate some unreachable code
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1581562405-30321-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <534d00dd-ca31-b0d1-d9be-1324a851005e@redhat.com>
Date:   Mon, 17 Feb 2020 18:11:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1581562405-30321-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/20 03:53, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> These code are unreachable, remove them.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 1 -
>  arch/x86/kvm/x86.c     | 3 ---
>  2 files changed, 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index bb5c33440af8..b6d4eafe01cf 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4505,7 +4505,6 @@ static bool rmode_exception(struct kvm_vcpu *vcpu, int vec)
>  	case GP_VECTOR:
>  	case MF_VECTOR:
>  		return true;
> -	break;
>  	}
>  	return false;
>  }
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fbabb2f06273..a597009aefd7 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3081,7 +3081,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		break;
>  	case APIC_BASE_MSR ... APIC_BASE_MSR + 0x3ff:
>  		return kvm_x2apic_msr_read(vcpu, msr_info->index, &msr_info->data);
> -		break;
>  	case MSR_IA32_TSCDEADLINE:
>  		msr_info->data = kvm_get_lapic_tscdeadline_msr(vcpu);
>  		break;
> @@ -3164,7 +3163,6 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		return kvm_hv_get_msr_common(vcpu,
>  					     msr_info->index, &msr_info->data,
>  					     msr_info->host_initiated);
> -		break;
>  	case MSR_IA32_BBL_CR_CTL3:
>  		/* This legacy MSR exists but isn't fully documented in current
>  		 * silicon.  It is however accessed by winxp in very narrow
> @@ -8471,7 +8469,6 @@ static inline int vcpu_block(struct kvm *kvm, struct kvm_vcpu *vcpu)
>  		break;
>  	default:
>  		return -EINTR;
> -		break;
>  	}
>  	return 1;
>  }
> 

Queued, thanks.

Paolo

