Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 547A2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39DDB207D5
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KKkWH8Yu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbgFDSlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:41:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23856 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725601AbgFDSlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591296080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2XePoJNdNVmtKQsPI2i0zLtEeRswapNtM75dwkZ+u3s=;
        b=KKkWH8YuNAk0Ppzlc2fMysCQiUVybGKYGvPByViJxU6NETJCym4OHT7e9ICU3gQgP6Fnu3
        uVuqZ7TNjXOMKlK4DgkMgogcoFUN9kH+6P2CppK1OAvGT1W6CHbGwUvZGj6gyLwac6SI77
        6cf/ntBK0QQ1bmwbomOxeL9bmU2Ej0Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-XhihjCprO4KQst4QfZY6pg-1; Thu, 04 Jun 2020 14:41:15 -0400
X-MC-Unique: XhihjCprO4KQst4QfZY6pg-1
Received: by mail-wr1-f72.google.com with SMTP id w4so2774862wrl.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 11:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2XePoJNdNVmtKQsPI2i0zLtEeRswapNtM75dwkZ+u3s=;
        b=BqQZD0TghXRt9nntrnl37iRxlLT2feOGWo9w9UePGmGnIljWAbF5QPsOfv3zts+RsL
         7fh/TZkzlnMAnakcLysZI4ycWGYqV78FkxXLXMQrXjt0RaIPA2oBbZzD+2WMkDWWKdbx
         /j42aFfD+J2QrxoQs/Ivvjo+lUc1OnlW72lHypEc3zdLvmgpTvOL7Je2LD8gxrw89VAT
         c6WFUr7XVDARKBhkKkPwYudUI41TaEhUujtJalKemFcvUyp+ZB0siGafIWdKlZryyrPn
         0dJQd7H4gBwpEmPkg5vLoDwYAMQ/Rlr2JXzhCIxuediaMU+CflqUcETONXfXMMENV+Qk
         yTeA==
X-Gm-Message-State: AOAM532+t0GJm89D1F2QoGvMrHH1+P1ZMcyFrxKea7ig9zz170Pe+IXX
        TDxHrVTNxMgqraqN1nOGRQfqzFhup5Cnoz7Y34zQ7ITuwUP610NIXpm8HIsY0qwim8rWe268IkY
        jIC5eE7TrFgZWRLrDFJpR0dZp
X-Received: by 2002:a1c:6243:: with SMTP id w64mr5155628wmb.162.1591296073706;
        Thu, 04 Jun 2020 11:41:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy111L7niMul0OsF5rkmGw6PjdHJmyZd1HPbz5VmcAXHvsx/aKHzYnf+RRkcnww5nK/+ZgR+g==
X-Received: by 2002:a1c:6243:: with SMTP id w64mr5155610wmb.162.1591296073464;
        Thu, 04 Jun 2020 11:41:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb? ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
        by smtp.gmail.com with ESMTPSA id x8sm9042333wrs.43.2020.06.04.11.41.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 11:41:12 -0700 (PDT)
Subject: Re: [PATCH] KVM: Use vmemdup_user()
To:     Denis Efremov <efremov@linux.com>
Cc:     joe@perches.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0c00d96c46d34d69f5f459baebf3c89a507730fc.camel@perches.com>
 <20200603101131.2107303-1-efremov@linux.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <eb48b6d2-6189-945d-33e2-1f5b29338d96@redhat.com>
Date:   Thu, 4 Jun 2020 20:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200603101131.2107303-1-efremov@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/20 12:11, Denis Efremov wrote:
> Replace opencoded alloc and copy with vmemdup_user().
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
> Looks like these are the only places in KVM that are suitable for
> vmemdup_user().
> 
>  arch/x86/kvm/cpuid.c | 17 +++++++----------
>  virt/kvm/kvm_main.c  | 19 ++++++++-----------
>  2 files changed, 15 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 901cd1fdecd9..27438a2bdb62 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -182,17 +182,14 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
>  	r = -E2BIG;
>  	if (cpuid->nent > KVM_MAX_CPUID_ENTRIES)
>  		goto out;
> -	r = -ENOMEM;
>  	if (cpuid->nent) {
> -		cpuid_entries =
> -			vmalloc(array_size(sizeof(struct kvm_cpuid_entry),
> -					   cpuid->nent));
> -		if (!cpuid_entries)
> -			goto out;
> -		r = -EFAULT;
> -		if (copy_from_user(cpuid_entries, entries,
> -				   cpuid->nent * sizeof(struct kvm_cpuid_entry)))
> +		cpuid_entries = vmemdup_user(entries,
> +					     array_size(sizeof(struct kvm_cpuid_entry),
> +							cpuid->nent));
> +		if (IS_ERR(cpuid_entries)) {
> +			r = PTR_ERR(cpuid_entries);
>  			goto out;
> +		}
>  	}
>  	for (i = 0; i < cpuid->nent; i++) {
>  		vcpu->arch.cpuid_entries[i].function = cpuid_entries[i].function;
> @@ -212,8 +209,8 @@ int kvm_vcpu_ioctl_set_cpuid(struct kvm_vcpu *vcpu,
>  	kvm_x86_ops.cpuid_update(vcpu);
>  	r = kvm_update_cpuid(vcpu);
>  
> +	kvfree(cpuid_entries);
>  out:
> -	vfree(cpuid_entries);
>  	return r;
>  }
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 731c1e517716..46a3743e95ff 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3722,21 +3722,18 @@ static long kvm_vm_ioctl(struct file *filp,
>  		if (routing.flags)
>  			goto out;
>  		if (routing.nr) {
> -			r = -ENOMEM;
> -			entries = vmalloc(array_size(sizeof(*entries),
> -						     routing.nr));
> -			if (!entries)
> -				goto out;
> -			r = -EFAULT;
>  			urouting = argp;
> -			if (copy_from_user(entries, urouting->entries,
> -					   routing.nr * sizeof(*entries)))
> -				goto out_free_irq_routing;
> +			entries = vmemdup_user(urouting->entries,
> +					       array_size(sizeof(*entries),
> +							  routing.nr));
> +			if (IS_ERR(entries)) {
> +				r = PTR_ERR(entries);
> +				goto out;
> +			}
>  		}
>  		r = kvm_set_irq_routing(kvm, entries, routing.nr,
>  					routing.flags);
> -out_free_irq_routing:
> -		vfree(entries);
> +		kvfree(entries);
>  		break;
>  	}
>  #endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
> 

Queued, thanks.

Paolo

