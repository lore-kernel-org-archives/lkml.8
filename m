Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C47C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC03206CA
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ANVU5iHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgIKQKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:10:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38279 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbgIKPne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599838982;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FVvWuDRuisEBX+0Zn/CcIYXbEBhRKURBa9x/u41gEYU=;
        b=ANVU5iHKhyf3cJuvcaCaOCVlfTaBdcKdyELyCVVoQWQflWM6dWcCBoxQXLn93TetaaU3F2
        oO7tcuLP5+wBCXq3PR5Xs4E5wtSdu8qkVXwDpTacrqOQ6Jt8y3n5Ypf56oquwk8a8mi9+e
        CyF6NBmoIPK12UiEdVm1AmCoAqpda0w=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-OVWZSL8MNhykrqy_RnShCg-1; Fri, 11 Sep 2020 11:43:01 -0400
X-MC-Unique: OVWZSL8MNhykrqy_RnShCg-1
Received: by mail-wr1-f72.google.com with SMTP id l17so3609590wrw.11
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 08:43:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FVvWuDRuisEBX+0Zn/CcIYXbEBhRKURBa9x/u41gEYU=;
        b=eijB1b4JHHMQ76NuHityWBTrl8Y6BgvKFks1byUy5i9XKUFR5f1jPw9kV5tJdGZB8k
         7Sxu5De1NbmuybXxETQ72vyowOgFDb9rr4MtIbbSYe0z8JNVrfFsmC8xKggSaXtmqimu
         QeMCQbw42UvxwRSHXLFSvztuaOBS+iSA9zV+/OksJiwuO9eEmkRh7bTPKkFlLJ5akYvB
         n5ZL7jFtsQM75Li1bx9SyekMsurWA/UQ5t7kf17hMdAOXIX5vPpbC9d4eecK53Jq3TVW
         ao+6imch7YPTlYRQCttR1qnQEvT/fN42q7BwxO1MlcjTTWMhIOPlFAw/X4eUzofqnrrJ
         H83Q==
X-Gm-Message-State: AOAM530WWisGPLOgp/gAXbl5CXnxYHauMcl3tahpj8Y0sUJz4XO63xAJ
        oykCoDL4z0EaWgeZPoZPUZxdQsuCBNRxZTY+YG5rxWNzQBKkxRJ6H889ZAMoURyJ7U7QkC1bFpQ
        8vSj/wm6Z35v4XAp/Z8jPn2OW
X-Received: by 2002:a05:6000:124d:: with SMTP id j13mr2866220wrx.182.1599838979663;
        Fri, 11 Sep 2020 08:42:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwH4jkVUD6E8IpA1UAChk652kXQGIgRngAJxmNyGQnsNw/F6wpulBuvJswNO1yaVHdkevNdqg==
X-Received: by 2002:a05:6000:124d:: with SMTP id j13mr2866196wrx.182.1599838979395;
        Fri, 11 Sep 2020 08:42:59 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5568:7f99:4893:a5b6? ([2001:b07:6468:f312:5568:7f99:4893:a5b6])
        by smtp.gmail.com with ESMTPSA id v9sm5288411wru.37.2020.09.11.08.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 08:42:58 -0700 (PDT)
Subject: Re: [PATCH] KVM: Check the allocation of pv cpu mask
To:     Haiwei Li <lihaiwei.kernel@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     "hpa@zytor.com" <hpa@zytor.com>, "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>, tglx@linutronix.de,
        joro@8bytes.org, jmattson@google.com,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        vkuznets@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <d59f05df-e6d3-3d31-a036-cc25a2b2f33f@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0617b9ae-8ddb-dcb7-a345-9d629916d20d@redhat.com>
Date:   Fri, 11 Sep 2020 17:42:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d59f05df-e6d3-3d31-a036-cc25a2b2f33f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/20 13:41, Haiwei Li wrote:
> From: Haiwei Li <lihaiwei@tencent.com>
> 
> check the allocation of per-cpu __pv_cpu_mask. Initialize ops only when
> successful.
> 
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
> ---
>  arch/x86/kernel/kvm.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 08320b0b2b27..a64b894eaac0 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -555,7 +555,6 @@ static void kvm_send_ipi_mask_allbutself(const
> struct cpumask *mask, int vector)
>  static void kvm_setup_pv_ipi(void)
>  {
>      apic->send_IPI_mask = kvm_send_ipi_mask;
> -    apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
>      pr_info("setup PV IPIs\n");
>  }
> 
> @@ -654,7 +653,6 @@ static void __init kvm_guest_init(void)
>      }
> 
>      if (pv_tlb_flush_supported()) {
> -        pv_ops.mmu.flush_tlb_others = kvm_flush_tlb_others;
>          pv_ops.mmu.tlb_remove_table = tlb_remove_table;
>          pr_info("KVM setup pv remote TLB flush\n");
>      }
> @@ -767,6 +765,14 @@ static __init int activate_jump_labels(void)
>  }
>  arch_initcall(activate_jump_labels);
> 
> +static void kvm_free_pv_cpu_mask(void)
> +{
> +    unsigned int cpu;
> +
> +    for_each_possible_cpu(cpu)
> +        free_cpumask_var(per_cpu(__pv_cpu_mask, cpu));
> +}
> +
>  static __init int kvm_alloc_cpumask(void)
>  {
>      int cpu;
> @@ -785,11 +791,20 @@ static __init int kvm_alloc_cpumask(void)
> 
>      if (alloc)
>          for_each_possible_cpu(cpu) {
> -            zalloc_cpumask_var_node(per_cpu_ptr(&__pv_cpu_mask, cpu),
> -                GFP_KERNEL, cpu_to_node(cpu));
> +            if (!zalloc_cpumask_var_node(
> +                per_cpu_ptr(&__pv_cpu_mask, cpu),
> +                GFP_KERNEL, cpu_to_node(cpu))) {
> +                goto zalloc_cpumask_fail;
> +            }
>          }
> 
> +    apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
> +    pv_ops.mmu.flush_tlb_others = kvm_flush_tlb_others;
>      return 0;
> +
> +zalloc_cpumask_fail:
> +    kvm_free_pv_cpu_mask();
> +    return -ENOMEM;
>  }
>  arch_initcall(kvm_alloc_cpumask);
> 
> -- 
> 2.18.4
> 

Queued, thanks.

I am currently on leave so I am going through the patches and queuing
them, but I will only push kvm/next and kvm/queue next week.  kvm/master
patches will be sent to Linus for the next -rc though.

Paolo

