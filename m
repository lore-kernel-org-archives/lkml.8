Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9793EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73C9120888
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hb637UWk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404375AbgE1PXI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:23:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44445 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2404237AbgE1PXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:23:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590679381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZuC/L4LcDUQosJwmTOJaBouUsy+HI9M3EMosoVjkVI8=;
        b=Hb637UWkwxQAfxV5T2Sc8Wf7SlFJ5whVFpcFWaFyrWtS/jI8SYiZ4LMBm1H4FZhBz2ifu6
        tMNOyr7hhcsCd3ydCd8Z6csZO9qyzeH3qitpY+R7NRt4mRRYqKlExi9h62srFIT8i3jgwU
        +DiWrC4t8U4vWRQbf1JpKKKpLVC3YjY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-429-_JMtYzskPuewjT31wHQg0g-1; Thu, 28 May 2020 11:23:00 -0400
X-MC-Unique: _JMtYzskPuewjT31wHQg0g-1
Received: by mail-wr1-f70.google.com with SMTP id s7so6201237wrm.16
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 08:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZuC/L4LcDUQosJwmTOJaBouUsy+HI9M3EMosoVjkVI8=;
        b=oINqBzBItDl/L8L7gFGJ9lg3wLJQTUf6r51vxj2Y/FC0K9t30buWlDu0wFn6YcCkxW
         U8PZ+wZ4GgJvsbl20OVsDy6V+oE4/pSWHMKp0qTcaTKeUhillHrZDEHzNW/d6QPZbV7U
         Hoq/hugNAf9POm5/JY3qBTLZsTtEx0VhAdzZ6fHuby9NrXOlopwBt30V4izCqQOkh4yJ
         TujlygTASOnFmSiTMg56pjuxQWDRfD7zaDQxkifaL0Y689vqUKRF427QK/whbQYZVoV+
         oZJr+mHpDOA/lFuCFEH3mKdHsD9nXuN4AazUxEGvHYUg0xwyu+TeiKZpsB07GRx5QmI/
         dfrQ==
X-Gm-Message-State: AOAM531uNKDY/5fbxLgoVIKgowvtqKtT5p4/fkaRMiPeDFU4242G+BYP
        Lilc6jWawG0c5xWgaUWEwPyalmpOS+Mss7HH8MhOAIMTqBCYQYMNcnukdSciqFOCiafjbIMrk0v
        OIZXrQDAieFBcwnS8jg1pjO93
X-Received: by 2002:a7b:cc06:: with SMTP id f6mr3841204wmh.119.1590679378714;
        Thu, 28 May 2020 08:22:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTmSSMQgVYva8gWo2WxK+oGBmB8n1AVJ05WziwKhiiGjicjbvjOqXX3JnAd8Eg83WQtxqINA==
X-Received: by 2002:a7b:cc06:: with SMTP id f6mr3841178wmh.119.1590679378459;
        Thu, 28 May 2020 08:22:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:3c1c:ffba:c624:29b8? ([2001:b07:6468:f312:3c1c:ffba:c624:29b8])
        by smtp.gmail.com with ESMTPSA id o10sm3583419wrj.37.2020.05.28.08.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 08:22:58 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Call kvm_x86_ops.cpuid_update() after CPUIDs
 fully updated
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20200528151927.14346-1-xiaoyao.li@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b639a333-d7fe-74fd-ee11-6daede184676@redhat.com>
Date:   Thu, 28 May 2020 17:22:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200528151927.14346-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/20 17:19, Xiaoyao Li wrote:
> kvm_x86_ops.cpuid_update() is used to update vmx/svm settings based on
> updated CPUID settings. So it's supposed to be called after CPUIDs are
> fully updated, not in the middle stage.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Are you seeing anything bad happening from this?

Paolo

> ---
>  arch/x86/kvm/cpuid.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index cd708b0b460a..753739bc1bf0 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -208,8 +208,11 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
>  	vcpu->arch.cpuid_nent = cpuid->nent;
>  	cpuid_fix_nx_cap(vcpu);
>  	kvm_apic_set_version(vcpu);
> -	kvm_x86_ops.cpuid_update(vcpu);
>  	r = kvm_update_cpuid(vcpu);
> +	if (r)
> +		goto out;
> +
> +	kvm_x86_ops.cpuid_update(vcpu);
>  
>  out:
>  	vfree(cpuid_entries);
> @@ -231,8 +234,11 @@ int kvm_vcpu_ioctl_set_cpuid2(struct kvm_vcpu *vcpu,
>  		goto out;
>  	vcpu->arch.cpuid_nent = cpuid->nent;
>  	kvm_apic_set_version(vcpu);
> -	kvm_x86_ops.cpuid_update(vcpu);
>  	r = kvm_update_cpuid(vcpu);
> +	if (r)
> +		goto out;
> +
> +	kvm_x86_ops.cpuid_update(vcpu);
>  out:
>  	return r;
>  }
> 

