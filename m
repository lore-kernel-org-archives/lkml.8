Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89DFC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81F8221775
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 16:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NCqdoYQZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgCBQcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 11:32:07 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21254 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727142AbgCBQcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 11:32:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583166721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SV2DzgE7/GVCHxe1MyF7cvm3oaLFW5XDl1ckEgBzooo=;
        b=NCqdoYQZL20c7X1lccXyd9rFhgGzAs0YLSxhxoignPEdj8FVhm664oE5fcx8rCezfjvz2N
        QphHI+1iNCc5Hb3aaRQSb6IwPlw+40W0VSWAgfavI9wGC4/aqrkNcuLKrXTpK8qVo9u9NZ
        VgLmwmq235BoXIA9hGTjjbsfAe+ZP+w=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-S5q1sz_lN5Or8acYYFbJag-1; Mon, 02 Mar 2020 11:31:58 -0500
X-MC-Unique: S5q1sz_lN5Or8acYYFbJag-1
Received: by mail-wr1-f70.google.com with SMTP id d9so6017222wrv.21
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 08:31:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SV2DzgE7/GVCHxe1MyF7cvm3oaLFW5XDl1ckEgBzooo=;
        b=jZ7bCxMVeIUue5XKXdCeIN0jsorBDxjn6lfMFtBBZAywJpTc2GKthCTZ4X9/7Z/gRZ
         MpW4tSEQol2Jb+2PHXAH8ozEV/wdMdOW5FuTZEX+6amJwITcCBHKOniriD7vy27/2Ffm
         GxITL+DsjUPJTj4tW+fEHtf48Cdwfn8pqfzm+Qy8ohf8WIF0gwaL0z6txI/J4oIrgP92
         Jaoo1b42xOFYojBbOYykwB348StkRfu5k5q9+NwUNQRu8NgOg2Q/pCEdMF/jmzqOSY1n
         TzDfQO6mxdYUvNUlR4g8fvxH5lntSvIBGGGzM0i7YESQ3xgInYwYXUSP1lGYRZbpPEYc
         HzoQ==
X-Gm-Message-State: ANhLgQ1mScQvd/3qK/xMPXIl6McJqgXP29fhh1imkQ70dsZAA/a7THEM
        hlBIdgnefNfQX7wWOmo1c5GKbUe3wflfKKEqvDea7WxiT9nrh9q3Qv91FiHGndgSEfDNcxRqqxw
        ysdC3/YYe3mVuGDQjssuj/wY0
X-Received: by 2002:a1c:ba87:: with SMTP id k129mr244106wmf.102.1583166716825;
        Mon, 02 Mar 2020 08:31:56 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuwUWhJ3l7EnEnCkmDlth1oK52o+owEznQwr9Yr2mH+gmpSnrmjs+4wXh/972NER3NftmL04w==
X-Received: by 2002:a1c:ba87:: with SMTP id k129mr244074wmf.102.1583166716453;
        Mon, 02 Mar 2020 08:31:56 -0800 (PST)
Received: from [192.168.178.40] ([151.30.85.6])
        by smtp.gmail.com with ESMTPSA id i4sm16121618wmd.23.2020.03.02.08.31.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 08:31:55 -0800 (PST)
Subject: Re: [PATCH v2] KVM: X86: deprecate obsolete KVM_GET_CPUID2 ioctl
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1582773688-4956-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d94a44f0-7fed-b5e4-49e8-6dd1b89185db@redhat.com>
Date:   Mon, 2 Mar 2020 17:31:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1582773688-4956-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/20 04:21, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> When kvm_vcpu_ioctl_get_cpuid2() fails, we set cpuid->nent to the value of
> vcpu->arch.cpuid_nent. But this is in vain as cpuid->nent is not copied to
> userspace by copy_to_user() from call site. Also cpuid->nent is not updated
> to indicate how many entries were retrieved on success case. So this ioctl
> is straight up broken. And in fact, it's not used anywhere. So it should be
> deprecated.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/cpuid.c           | 20 --------------------
>  arch/x86/kvm/cpuid.h           |  3 ---
>  arch/x86/kvm/x86.c             | 16 ++--------------
>  include/uapi/linux/kvm.h       |  1 +
>  tools/include/uapi/linux/kvm.h |  1 +
>  5 files changed, 4 insertions(+), 37 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index b1c469446b07..5e041a1282b8 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -261,26 +261,6 @@ int kvm_vcpu_ioctl_set_cpuid2(struct kvm_vcpu *vcpu,
>  	return r;
>  }
>  
> -int kvm_vcpu_ioctl_get_cpuid2(struct kvm_vcpu *vcpu,
> -			      struct kvm_cpuid2 *cpuid,
> -			      struct kvm_cpuid_entry2 __user *entries)
> -{
> -	int r;
> -
> -	r = -E2BIG;
> -	if (cpuid->nent < vcpu->arch.cpuid_nent)
> -		goto out;
> -	r = -EFAULT;
> -	if (copy_to_user(entries, &vcpu->arch.cpuid_entries,
> -			 vcpu->arch.cpuid_nent * sizeof(struct kvm_cpuid_entry2)))
> -		goto out;
> -	return 0;
> -
> -out:
> -	cpuid->nent = vcpu->arch.cpuid_nent;
> -	return r;
> -}
> -
>  static __always_inline void cpuid_mask(u32 *word, int wordnum)
>  {
>  	reverse_cpuid_check(wordnum);
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index 7366c618aa04..76555de38e1b 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -19,9 +19,6 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
>  int kvm_vcpu_ioctl_set_cpuid2(struct kvm_vcpu *vcpu,
>  			      struct kvm_cpuid2 *cpuid,
>  			      struct kvm_cpuid_entry2 __user *entries);
> -int kvm_vcpu_ioctl_get_cpuid2(struct kvm_vcpu *vcpu,
> -			      struct kvm_cpuid2 *cpuid,
> -			      struct kvm_cpuid_entry2 __user *entries);
>  bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
>  	       u32 *ecx, u32 *edx, bool check_limit);
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ddd1d296bd20..a6d99abedb2c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4295,21 +4295,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  					      cpuid_arg->entries);
>  		break;
>  	}
> +	/* KVM_GET_CPUID2 is deprecated, should not be used. */
>  	case KVM_GET_CPUID2: {
> -		struct kvm_cpuid2 __user *cpuid_arg = argp;
> -		struct kvm_cpuid2 cpuid;
> -
> -		r = -EFAULT;
> -		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
> -			goto out;
> -		r = kvm_vcpu_ioctl_get_cpuid2(vcpu, &cpuid,
> -					      cpuid_arg->entries);
> -		if (r)
> -			goto out;
> -		r = -EFAULT;
> -		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid)))
> -			goto out;
> -		r = 0;
> +		r = -EINVAL;
>  		break;
>  	}
>  	case KVM_GET_MSRS: {
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 4b95f9a31a2f..61524780603d 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -1380,6 +1380,7 @@ struct kvm_s390_ucas_mapping {
>  #define KVM_GET_LAPIC             _IOR(KVMIO,  0x8e, struct kvm_lapic_state)
>  #define KVM_SET_LAPIC             _IOW(KVMIO,  0x8f, struct kvm_lapic_state)
>  #define KVM_SET_CPUID2            _IOW(KVMIO,  0x90, struct kvm_cpuid2)
> +/* KVM_GET_CPUID2 is deprecated, should not be used. */
>  #define KVM_GET_CPUID2            _IOWR(KVMIO, 0x91, struct kvm_cpuid2)
>  /* Available with KVM_CAP_VAPIC */
>  #define KVM_TPR_ACCESS_REPORTING  _IOWR(KVMIO, 0x92, struct kvm_tpr_access_ctl)
> diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
> index f0a16b4adbbd..2ef719af4c57 100644
> --- a/tools/include/uapi/linux/kvm.h
> +++ b/tools/include/uapi/linux/kvm.h
> @@ -1379,6 +1379,7 @@ struct kvm_s390_ucas_mapping {
>  #define KVM_GET_LAPIC             _IOR(KVMIO,  0x8e, struct kvm_lapic_state)
>  #define KVM_SET_LAPIC             _IOW(KVMIO,  0x8f, struct kvm_lapic_state)
>  #define KVM_SET_CPUID2            _IOW(KVMIO,  0x90, struct kvm_cpuid2)
> +/* KVM_GET_CPUID2 is deprecated, should not be used. */
>  #define KVM_GET_CPUID2            _IOWR(KVMIO, 0x91, struct kvm_cpuid2)
>  /* Available with KVM_CAP_VAPIC */
>  #define KVM_TPR_ACCESS_REPORTING  _IOWR(KVMIO, 0x92, struct kvm_tpr_access_ctl)
> 

Queued, thanks.

Paolo

