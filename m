Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD351C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:50:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B70D207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g5mZaB0H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgEKNua (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:50:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37225 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730236AbgEKNua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589205028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYIcn+3D286vkydQaVSkgnA5hSu+m3hsQi8qZsqHYj8=;
        b=g5mZaB0H8NtwhPwOEZf7PlBHsboJYDI3cwOeL3fqXw/s7TGANQRQB8cGTdA2lVXuvQ85/G
        gMlOb1s1nQ0Y7xOFQkRAXrNAZWqDhxLzX53OJg5gGnmnTlYhPrQneXGTvNvcym+r70ERXZ
        vm1KC2CcUTDWt8fzeiPXVuSqMaln9f4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-416-UiK0YUflNHm0UDWOXpvKkg-1; Mon, 11 May 2020 09:50:27 -0400
X-MC-Unique: UiK0YUflNHm0UDWOXpvKkg-1
Received: by mail-wm1-f71.google.com with SMTP id j5so8359613wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 06:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dYIcn+3D286vkydQaVSkgnA5hSu+m3hsQi8qZsqHYj8=;
        b=LGOTVcXQBHP4SOoofQgbWQsbrW2WQjE9fwvegmMPiyUy4RoblnHvtZM21DCYy/3Rds
         49cn/YL3z1wccFjHLgJg0i9/AtSmXUi41a56I00OnFW6Cqk8xrYmTny/cYNdpxNszRCd
         PWjlmGLoVzJfwmplBoM0uv+oCnEQL3jm6n2kxzAwvaG2kiJsYFIWm2jZq+OphsZ0CB3i
         9NNTtL4+VBrm6XtfCXbfZSJHKES/v5nVYEsGw5jNc3Jz02rZXjwAIjuphAw5NpcasyZt
         1arp+RG/ZBjEvo9ztc5RyC72LC2ONymqHiwxzV83LXKvbnYeH4d4dbB6oGA3yu3DR0LT
         QwuA==
X-Gm-Message-State: AGi0PuYCMzv2snHcgFTBqdQV/xTKgSTalBrrVL2L/vWjIg3PJeFKqM0x
        SNqB6xuSfP02C5rVosC/zOwOUc3zBVjMuobSUGECgU55qh3WYD3PEMVkD6TjcrQIUW8uyPYvaVR
        QIP48CRsn+mBqXjiZgMZ4uZj0
X-Received: by 2002:a1c:7213:: with SMTP id n19mr6013793wmc.88.1589205025671;
        Mon, 11 May 2020 06:50:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypISo3KIFEJ7LYAXA24Bc5EMlbCgV7DLtmc2WcZnpfaF2Wz6YDCNkPryNeTkCD/TXK9yqXQ6gA==
X-Received: by 2002:a1c:7213:: with SMTP id n19mr6013774wmc.88.1589205025409;
        Mon, 11 May 2020 06:50:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4c95:a679:8cf7:9fb6? ([2001:b07:6468:f312:4c95:a679:8cf7:9fb6])
        by smtp.gmail.com with ESMTPSA id k5sm16690003wrx.16.2020.05.11.06.50.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 06:50:24 -0700 (PDT)
Subject: Re: [PATCH] kvm/x86 : Remove redundant pic_in_kernel
To:     =?UTF-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <HKAPR02MB42914E8F73424BCF815DAC6CE0A10@HKAPR02MB4291.apcprd02.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <65b8f660-1d78-10f5-fe61-54de94cd5017@redhat.com>
Date:   Mon, 11 May 2020 15:50:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <HKAPR02MB42914E8F73424BCF815DAC6CE0A10@HKAPR02MB4291.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/05/20 13:21, ÅíºÆ(Richard) wrote:
> pic_in_kernel() and irqchip_kernel() have the same implementation.
> 
> Signed-off-by: Peng Hao <richard.peng@oppo.com>

Thanks for the patch, this is interesting!  And there is also
ioapic_in_kernel.  However, the three functions are used in different
cases, for example ioapic_in_kernel before accessing kvm->arch.vioapic.
 So the right thing to do would be to keep the functions, but change
them to just return irqchip_kernel(kvm).

Paolo

> ---
>  arch/x86/kvm/irq.h | 9 ---------
>  arch/x86/kvm/x86.c | 6 +++---
>  2 files changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
> index f173ab6..3ad07ca 100644
> --- a/arch/x86/kvm/irq.h
> +++ b/arch/x86/kvm/irq.h
> @@ -66,15 +66,6 @@ void kvm_pic_destroy(struct kvm *kvm);
>  int kvm_pic_read_irq(struct kvm *kvm);
>  void kvm_pic_update_irq(struct kvm_pic *s);
> 
> -static inline int pic_in_kernel(struct kvm *kvm)
> -{
> -int mode = kvm->arch.irqchip_mode;
> -
> -/* Matches smp_wmb() when setting irqchip_mode */
> -smp_rmb();
> -return mode == KVM_IRQCHIP_KERNEL;
> -}
> -
>  static inline int irqchip_split(struct kvm *kvm)
>  {
>  int mode = kvm->arch.irqchip_mode;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index d786c7d..559053f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3710,7 +3710,7 @@ static int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu,
>   * With in-kernel LAPIC, we only use this to inject EXTINT, so
>   * fail for in-kernel 8259.
>   */
> -if (pic_in_kernel(vcpu->kvm))
> +if (irqchip_kernel(vcpu->kvm))
>  return -ENXIO;
> 
>  if (vcpu->arch.pending_external_vector != -1)
> @@ -7622,7 +7622,7 @@ static int emulator_fix_hypercall(struct x86_emulate_ctxt *ctxt)
>  static int dm_request_for_irq_injection(struct kvm_vcpu *vcpu)
>  {
>  return vcpu->run->request_interrupt_window &&
> -likely(!pic_in_kernel(vcpu->kvm));
> +likely(!irqchip_kernel(vcpu->kvm));
>  }
> 
>  static void post_kvm_run_save(struct kvm_vcpu *vcpu)
> @@ -7634,7 +7634,7 @@ static void post_kvm_run_save(struct kvm_vcpu *vcpu)
>  kvm_run->cr8 = kvm_get_cr8(vcpu);
>  kvm_run->apic_base = kvm_get_apic_base(vcpu);
>  kvm_run->ready_for_interrupt_injection =
> -pic_in_kernel(vcpu->kvm) ||
> +irqchip_kernel(vcpu->kvm) ||
>  kvm_vcpu_ready_for_interrupt_injection(vcpu);
>  }
> 
> --
> 2.7.4

