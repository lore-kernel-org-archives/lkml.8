Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184F2C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6D4B2074B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 09:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V/Ge9cmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbgFIJ5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 05:57:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42283 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727098AbgFIJ5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 05:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591696668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ibKboGqiSHs1nijcwRb9DLkPlnX80F1iqE0itbybiSs=;
        b=V/Ge9cmXLiNd7Afe80JENERLux+bgroMzmJO1Rmd87xMNpzY5KI3n9uB6lXm8FfgmZPQK8
        OiSDWhoTFMth8KkX/7q+M90tXBACUB4aY7lZTvUubP3cLmcepxTyKy7a84G5mixYd73iqC
        DfEXX0Dsg0qPp+gDDbHwFlD0+ME0oL8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-X7nqIRilP9C3vTbKxQyEUg-1; Tue, 09 Jun 2020 05:57:46 -0400
X-MC-Unique: X7nqIRilP9C3vTbKxQyEUg-1
Received: by mail-wr1-f72.google.com with SMTP id f4so8400303wrp.21
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 02:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ibKboGqiSHs1nijcwRb9DLkPlnX80F1iqE0itbybiSs=;
        b=S7vIeKZjcxgXECP1gEVh63wUjd/RvfHAObLJo8ZYbRD5z3qP541damiWVetHqB5Nzi
         YPko9bOEMVF2gLDBUe2lChvuXjX66zwrkA+W3FT/H6pbx7UPQyfpE0qic57/rx6kfD8F
         IZndcoysooUwN/v1pEXDqnbP9QvHuN3C6HMJJ2gk1wJJ8FaYEXvKDDVs5xRpXkzON0Ay
         DmpsYD/vmAKA8xR1WJcX55nJVfdm2fsJrwIuTGTJKC1F2o0VOXbQHVaud5RQukkY1Q+s
         p6OmBdW4CBbAQNxmct3rpguJMauO56kHjVM3t0w3ZC/a76LCZm4Qqm0hz12uorqKfhw+
         ooUg==
X-Gm-Message-State: AOAM530BMplVrYbnl+Ncx6LZJAJblxK2pCj6ddK4UBdsVHiZVV/iNMkS
        WAGE/oUFflR+Guq4X62pc1aiY2z4929FwuxPOqmqyjxvZBc2CvhjHYaUV5JHDTgnszwliiyhEsV
        kb7RJHaREyWRz9EHhEibka0DC
X-Received: by 2002:adf:fe07:: with SMTP id n7mr3395312wrr.240.1591696665231;
        Tue, 09 Jun 2020 02:57:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtipR1s180DRqzHexaQK8/Pl5cmXEYzJQ9vM4Nx4WXQAdi8dM4n59u6aYCvm3glAXpAyFksA==
X-Received: by 2002:adf:fe07:: with SMTP id n7mr3395299wrr.240.1591696665042;
        Tue, 09 Jun 2020 02:57:45 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.172.168])
        by smtp.gmail.com with ESMTPSA id t14sm2849805wrb.94.2020.06.09.02.57.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 02:57:44 -0700 (PDT)
Subject: Re: [PATCH v2] KVM: x86: Unexport x86_fpu_cache and make it static
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200608180218.20946-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8f94b6f1-d7f8-60d8-1d2e-59706ec8c763@redhat.com>
Date:   Tue, 9 Jun 2020 11:57:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200608180218.20946-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/20 20:02, Sean Christopherson wrote:
> Make x86_fpu_cache static now that FPU allocation and destruction is
> handled entirely by common x86 code.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
> 
> v2: Rebased to kvm/queue, commit fb7333dfd812 ("KVM: SVM: fix calls ...").
> 
>  arch/x86/include/asm/kvm_host.h | 1 -
>  arch/x86/kvm/x86.c              | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 1da5858501ca..7030f2221259 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1306,7 +1306,6 @@ struct kvm_arch_async_pf {
>  extern u64 __read_mostly host_efer;
>  
>  extern struct kvm_x86_ops kvm_x86_ops;
> -extern struct kmem_cache *x86_fpu_cache;
>  
>  #define __KVM_HAVE_ARCH_VM_ALLOC
>  static inline struct kvm *kvm_arch_alloc_vm(void)
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c26dd1363151..e19f7c486d64 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -239,8 +239,7 @@ u64 __read_mostly host_xcr0;
>  u64 __read_mostly supported_xcr0;
>  EXPORT_SYMBOL_GPL(supported_xcr0);
>  
> -struct kmem_cache *x86_fpu_cache;
> -EXPORT_SYMBOL_GPL(x86_fpu_cache);
> +static struct kmem_cache *x86_fpu_cache;
>  
>  static struct kmem_cache *x86_emulator_cache;
>  
> 

Queued, thanks.

Paolo

