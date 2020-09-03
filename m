Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFDE6C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D77420767
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQlAWZUa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgICKkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53260 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbgICKj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599129597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ijVYX0z6T27vxR7tJcyTqIs/JuL8BCy4xqW27sy9VD0=;
        b=EQlAWZUakqOmXIVbURaTip1A/ScsUIObiFLq+tMuo+rE3/nYTOL6EkxIBhrTz7lBLxokeH
        vXrnHXr8rxgAHL3ihAVCr/WDOvKyTsKPcOFMcNCi28UhvseOA8ViiTx8KbLfSYIOT/bqUD
        H6soe0WaN93KkUUBD4oMq028jxVnfAI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-KwSB_2fhNLaurU4U7H5IkQ-1; Thu, 03 Sep 2020 06:39:56 -0400
X-MC-Unique: KwSB_2fhNLaurU4U7H5IkQ-1
Received: by mail-wr1-f70.google.com with SMTP id b7so926673wrn.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 03:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ijVYX0z6T27vxR7tJcyTqIs/JuL8BCy4xqW27sy9VD0=;
        b=a6yh0ZkAyrgMWzCNL5OK0EQDN/rojzotEfzFZ5qgC4wmT+4x66wPJw4AF4SMZFKd9q
         boC0mTyYAyijVElU6D+uJ4lqy3Z/sgW71HMboOghLCbZrkTnmC0Svqx+3k10zKrIjyXT
         7ABK4aGhWXe36H47eRv7ysPIt2CTgn+QOxs5mPNYg30A5jVVGCA8vqHUVW3lswXFvS3i
         BZUVdZ5V5pUwGwmXYAvFfhIURcDFz0KIPx4BT3RLpdiT3RJu7dP/VzRgLZWFIqx2za5Z
         nLRmWvOX5zaTVMFp+LsLw5AfK7sTGDZ4FywHTe6hp12hCMv8mbUl5JIv2s5m/ZgqsxDr
         oV1w==
X-Gm-Message-State: AOAM530qsqFbORYLRPEPxPYrijxH5J5No9ijOkhoeoQ4V19rpIKBTXM5
        a3OreOLvlkKKgMQXibuEz5DPEiC6grcoPa3FKO1jC8h4QToPUCmS7ETrteXKB6fGXj8n8rNiR9B
        Q268MqMrOQnnd5HeA2pifrO/E
X-Received: by 2002:a1c:5a56:: with SMTP id o83mr1852714wmb.77.1599129595087;
        Thu, 03 Sep 2020 03:39:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyG+5x9gTe9dl+reW0WRwFROTb3hPD2uAj+jMHAJIAE/fjZBSDJ9NaJEz5fiA3rL7PHaZa4Ag==
X-Received: by 2002:a1c:5a56:: with SMTP id o83mr1852699wmb.77.1599129594857;
        Thu, 03 Sep 2020 03:39:54 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a83sm3608921wmh.48.2020.09.03.03.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 03:39:54 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Haiwei Li <lihaiwei.kernel@gmail.com>
Cc:     "pbonzini\@redhat.com" <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "wanpengli\@tencent.com" <wanpengli@tencent.com>,
        "jmattson\@google.com" <jmattson@google.com>,
        "joro\@8bytes.org" <joro@8bytes.org>, tglx@linutronix.de,
        mingo@redhat.com, "bp\@alien8.de" <bp@alien8.de>,
        "hpa\@zytor.com" <hpa@zytor.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v2] KVM: Check the allocation of pv cpu mask
In-Reply-To: <654d8c60-49f0-e398-be25-24aed352360d@gmail.com>
References: <654d8c60-49f0-e398-be25-24aed352360d@gmail.com>
Date:   Thu, 03 Sep 2020 12:39:52 +0200
Message-ID: <87y2lrnnyf.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Haiwei Li <lihaiwei.kernel@gmail.com> writes:

> From: Haiwei Li <lihaiwei@tencent.com>
>
> check the allocation of per-cpu __pv_cpu_mask. Initialize ops only when
> successful.
>
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
> ---
>   arch/x86/kernel/kvm.c | 24 ++++++++++++++++++++----
>   1 file changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 08320b0b2b27..d3c062e551d7 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -555,7 +555,6 @@ static void kvm_send_ipi_mask_allbutself(const 
> struct cpumask *mask, int vector)
>   static void kvm_setup_pv_ipi(void)
>   {
>   	apic->send_IPI_mask = kvm_send_ipi_mask;
> -	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
>   	pr_info("setup PV IPIs\n");
>   }
>
> @@ -654,7 +653,6 @@ static void __init kvm_guest_init(void)
>   	}
>
>   	if (pv_tlb_flush_supported()) {
> -		pv_ops.mmu.flush_tlb_others = kvm_flush_tlb_others;
>   		pv_ops.mmu.tlb_remove_table = tlb_remove_table;
>   		pr_info("KVM setup pv remote TLB flush\n");
>   	}
> @@ -767,6 +765,14 @@ static __init int activate_jump_labels(void)
>   }
>   arch_initcall(activate_jump_labels);
>
> +static void kvm_free_pv_cpu_mask(void)
> +{
> +	unsigned int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		free_cpumask_var(per_cpu(__pv_cpu_mask, cpu));
> +}
> +
>   static __init int kvm_alloc_cpumask(void)
>   {
>   	int cpu;
> @@ -785,11 +791,21 @@ static __init int kvm_alloc_cpumask(void)
>
>   	if (alloc)
>   		for_each_possible_cpu(cpu) {
> -			zalloc_cpumask_var_node(per_cpu_ptr(&__pv_cpu_mask, cpu),
> -				GFP_KERNEL, cpu_to_node(cpu));
> +			if (!zalloc_cpumask_var_node(
> +				per_cpu_ptr(&__pv_cpu_mask, cpu),
> +				GFP_KERNEL, cpu_to_node(cpu)))
> +				goto zalloc_cpumask_fail;
>   		}
>
> +#if defined(CONFIG_SMP)
> +	apic->send_IPI_mask_allbutself = kvm_send_ipi_mask_allbutself;
> +#endif
> +	pv_ops.mmu.flush_tlb_others = kvm_flush_tlb_others;

This is too late I'm afraid. If I'm not mistaken PV patching happens
earlier, so .init.guest_late_init (kvm_guest_init()) is good and
arch_initcall() is bad.

Have you checked that with this patch kvm_flush_tlb_others() is still
being called?

Actually, there is no need to assign kvm_flush_tlb_others() so late. We
can always check if __pv_cpu_mask was allocated and revert back to the
architectural path if not.

>   	return 0;
> +
> +zalloc_cpumask_fail:
> +	kvm_free_pv_cpu_mask();
> +	return -ENOMEM;
>   }
>   arch_initcall(kvm_alloc_cpumask);
>
> --
> 2.18.4
>

-- 
Vitaly

