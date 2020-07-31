Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53286C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 318222084D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBGvk/mV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731694AbgGaHSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:18:40 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59987 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731684AbgGaHSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596179918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FBeZiBi3rY5wwl7r2xHV4CjPc5IMTAH+aLjF+XSNGTI=;
        b=SBGvk/mV2OjIH3NbHUWThH+GQpLp2iEMtAHHnB7zQ0HY2orijgYvoVRPtOSV3w/WWPrx1s
        OvkTV/JNcdPdNTm8Uie9QFEpNMUfDFui1lkyU24j3zKNEYUA/8GYX/jKHBprC6yTKO0cBA
        h5CKd123SVMq17bIYg2y0WECIplfAWU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-g8Kddg34OjuLFk95EjtSUQ-1; Fri, 31 Jul 2020 03:18:36 -0400
X-MC-Unique: g8Kddg34OjuLFk95EjtSUQ-1
Received: by mail-wr1-f72.google.com with SMTP id j2so6202054wrr.14
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 00:18:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FBeZiBi3rY5wwl7r2xHV4CjPc5IMTAH+aLjF+XSNGTI=;
        b=PBfcSq4ABezgvnVvZDGKH0emKUDIXW0ZKxVB10/Zr9bvNmnmN9fEBzSMzWe5/78cX/
         BXt91sKQKda7BS4aRiRQTA6v0id5yVp1gI6sVGd1LrIjfADbk6PDkw792SOrHAu+uFU2
         2tUCHf+XsseHsQyx2Ugxfoh0LJeFDdvTEkPzj+xKOKPc6j2B+DTWaOzgEqJshrMtiC+Y
         6xec6KE7w62pIVffHE5mhDIY3wIq6PChr79mJ8JDhHdH9dGzUOb302lSoJ2I8Yiw82ta
         edPpjNuy26lzleCZdFiLZjUG/FDkfneqpUR+t4RTXTRI/r1HtGrEjAGZtGPsULOmKMGD
         Eb0A==
X-Gm-Message-State: AOAM530RQSJS1/7JieKFVJF9lENRy/pYyokVG157J0ZIIkK+mpK/HquD
        hqxQwGyzKo4RUVE9zuJiKmPjneYfJ9pQSbA2068IdLIojt77bqIq2FXnm1URo6rr/XQmzr3dWtV
        H/invM1kTXc5YQ3D3E4MkCP+X
X-Received: by 2002:a7b:c40a:: with SMTP id k10mr2454203wmi.127.1596179914866;
        Fri, 31 Jul 2020 00:18:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4jKCODk7T1VsBYriZd1g/iAJIFX62aV+2CqLzzD8PaXGWqc3wXNimK5Bl5W0qr0xLjLvzyA==
X-Received: by 2002:a7b:c40a:: with SMTP id k10mr2454188wmi.127.1596179914663;
        Fri, 31 Jul 2020 00:18:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:90a5:f767:5f9f:3445? ([2001:b07:6468:f312:90a5:f767:5f9f:3445])
        by smtp.gmail.com with ESMTPSA id s19sm14586327wrb.54.2020.07.31.00.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 00:18:34 -0700 (PDT)
Subject: Re: [PATCH v3 1/3] KVM: LAPIC: Prevent setting the tscdeadline timer
 if the lapic is hw disabled
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, stable@vger.kernel.org
References: <1596165141-28874-1-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f28c7ad5-ea17-382e-f61e-c48418e49363@redhat.com>
Date:   Fri, 31 Jul 2020 09:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1596165141-28874-1-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/07/20 05:12, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> Prevent setting the tscdeadline timer if the lapic is hw disabled.
> 
> Fixes: bce87cce88 (KVM: x86: consolidate different ways to test for in-kernel LAPIC)
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
> v1 -> v2:
>  * add Fixes tag and cc stable
> 
>  arch/x86/kvm/lapic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 5bf72fc..4ce2ddd 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2195,7 +2195,7 @@ void kvm_set_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu, u64 data)
>  {
>  	struct kvm_lapic *apic = vcpu->arch.apic;
>  
> -	if (!lapic_in_kernel(vcpu) || apic_lvtt_oneshot(apic) ||
> +	if (!kvm_apic_present(vcpu) || apic_lvtt_oneshot(apic) ||
>  			apic_lvtt_period(apic))
>  		return;
>  
> 

Testcase please.

Paolo

