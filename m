Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0935FC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3E722314
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U3wWQRl6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgAUMPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:15:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30135 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727817AbgAUMPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:15:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579608936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7uxOa/zMccI1hlwQjdK023gkBaUsZFJKD86fyOIwdY=;
        b=U3wWQRl6TMbLae1Hka2E+hBZA5DcnLwJDAFjL4Q+oq1KF52j5NQiK7y2NZqGapK0qzCgOd
        SUlBH83UrpqKp0gOCuyu6mNEpAww2bp9X9gtTlbgrcresstiyHcEn7mvQX+9TMvQgfA9jl
        jnHSGH+OgxBij3FcCB+Lz9HzojO1jvk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-cfi_UPHRMcSQIQFo28xfIA-1; Tue, 21 Jan 2020 07:15:35 -0500
X-MC-Unique: cfi_UPHRMcSQIQFo28xfIA-1
Received: by mail-wr1-f69.google.com with SMTP id f15so1243262wrr.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 04:15:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K7uxOa/zMccI1hlwQjdK023gkBaUsZFJKD86fyOIwdY=;
        b=lCrQxphGKz3GUCh29PPLUcyoOoRHx/1Rd/vHzme4cgBIAaw1fazrNiOniX3JKVjWY7
         rytNlYc7w5L1u3YcYURaSfPC89Fw/nBI+OSpa8Gzw3UkWXaEKw51xcgWBgsL/0vcRWXX
         91Ah9YkSDMPXS7kU01U08uqheD7+wMzH/BYdkhU63oiB4Qm4tIoDO5FcHYSiv7vxbJew
         ec/ftKsuuseLQK2dR8jSLlQXXcIBsi7QaRBJ0H6tsE1MYJ+AfKYJqodrBmhf7e0blbGe
         +rtnymE9iQi0fGazzKajbHMpNFdYOMmrxVl436mo0kfn8ZggI8g0OU9z7Xdv7+0IEBtX
         /zlQ==
X-Gm-Message-State: APjAAAUl9BYeRZLBIr7gYjZsySfSVJtMFDIBvFUSu+c6lgF4kihmdIAi
        751Jc3jZn6d8rNcVFZwpFbYIFZDIqyMt6rpah/Ve1TLBGEOwlhrxFJziYtvTI4emUEinAKF9ZfP
        DWgEvbcOIlbntBiStSN4suza9
X-Received: by 2002:a5d:6406:: with SMTP id z6mr4954845wru.294.1579608933894;
        Tue, 21 Jan 2020 04:15:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVbq65dVzapzaZwnuI8J74z85tvEX9mBSp5IwckHTxpR5vFcgnPbOoJoVjP/9/uvX9ZxZzMQ==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr4954809wru.294.1579608933585;
        Tue, 21 Jan 2020 04:15:33 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id g18sm3451669wmh.48.2020.01.21.04.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 04:15:33 -0800 (PST)
Subject: Re: [PATCH v2] KVM: Adding 'else' to reduce checking.
To:     Haiwei Li <lihaiwei.kernel@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>
References: <abea81a5-266f-7e0d-558a-b4b7aa49d3d4@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <68afcc3a-f32c-0e0e-5c2d-5fddfc98d1fd@redhat.com>
Date:   Tue, 21 Jan 2020 13:15:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <abea81a5-266f-7e0d-558a-b4b7aa49d3d4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/01/20 10:03, Haiwei Li wrote:
> From 009bfba9b6f6b41018708323d9ca651ae2075900 Mon Sep 17 00:00:00 2001
> From: Haiwei Li <lihaiwei@tencent.com>
> Date: Thu, 16 Jan 2020 16:50:21 +0800
> Subject: [PATCH] Adding 'else' to reduce checking.
> 
> These two conditions are in conflict, adding 'else' to reduce checking.
> 
> Signed-off-by: Haiwei Li <lihaiwei@tencent.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/lapic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 679692b..f1cfb94 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1571,9 +1571,9 @@ static void
> kvm_apic_inject_pending_timer_irqs(struct kvm_lapic *apic)
>         struct kvm_timer *ktimer = &apic->lapic_timer;
> 
>         kvm_apic_local_deliver(apic, APIC_LVTT);
> -       if (apic_lvtt_tscdeadline(apic))
> +       if (apic_lvtt_tscdeadline(apic)) {
>                 ktimer->tscdeadline = 0;
> -       if (apic_lvtt_oneshot(apic)) {
> +       } else if (apic_lvtt_oneshot(apic)) {
>                 ktimer->tscdeadline = 0;
>                 ktimer->target_expiration = 0;
>         }
> -- 
> 1.8.3.1
> 

Queued, thanks.

Paolo

