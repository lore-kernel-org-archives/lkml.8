Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215ACC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E62112077B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 17:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FsWVacKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgAORvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 12:51:33 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49309 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726418AbgAORvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 12:51:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579110691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U601CLGCdVAs17IVbD0yyOLC6DlNZgQCJ18JOZ2iGUM=;
        b=FsWVacKaJz72U/uUUXZvJgXqhvhbknxhq2CHIadOl2dSb24LFLYID5pskoNxN7eSXWnbHM
        DdSXkkke063qSUzcMd8cwmdWtja0tSgNATBp4q40baZbYOvGkdCuK/COZO+yDjogQNzeG0
        Z85Uzhh07CtbZ9ypc6AIsW/ehc5I3Mg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-yrza67TzM5Oya09kSKkaIQ-1; Wed, 15 Jan 2020 12:51:30 -0500
X-MC-Unique: yrza67TzM5Oya09kSKkaIQ-1
Received: by mail-wr1-f71.google.com with SMTP id r2so8258522wrp.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 09:51:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=U601CLGCdVAs17IVbD0yyOLC6DlNZgQCJ18JOZ2iGUM=;
        b=WewMm3R7Mjd9ahkXkvQsjgN4tXGazbF4HHB9Ejl2nv87K3qzAugGr+o2ac7qqFDXWm
         Gqd/FLaNYIlkx0Sma1OqqAE5MWu8uSWGO0qAjJH+4h+KctTwv3DpCKWAsR2JGi52go4q
         vNSj0u2/hLWYxKCkbLA4IHuIHD12jO5asfI6PQKncXLZD6aI+fyCRbh8rt23oYOOMm4n
         ERkbzJGLScQidR3NeI2UB6CTQevvhVBpjnq8DZc2d2Sd+m3zN7v/gP8jnaNa3lYJvHIX
         B4Rwpph5n2n2yaNFelfNP8aPhO8MdMwqZhNp1pcLvdIofxUFgQrvbGRXCohfT0LSGAky
         LLHw==
X-Gm-Message-State: APjAAAUIZzkbp0ZFi33XuFAM90F4SyVTh07YDDRb63O1yvLVyXB/447K
        5qsr6rOHrjf4kCY+KFgnpoqU1YCMf5DQAOrNCG96e5gUWHaWf2nDeZ9ZNFOnq4a8zgl9sYO9NL2
        8+SMUkSsZGDvL/maHKR+u+jzo
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr1111316wmf.60.1579110689612;
        Wed, 15 Jan 2020 09:51:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqz37Fwd9FYw9yKIWeGLEnoGTzaMgIWhzdGN84AOR4oqqNRXqZpYEEEXJiwFaIUZKdj3bGR76Q==
X-Received: by 2002:a1c:1f51:: with SMTP id f78mr1111294wmf.60.1579110689384;
        Wed, 15 Jan 2020 09:51:29 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:436:e17d:1fd9:d92a? ([2001:b07:6468:f312:436:e17d:1fd9:d92a])
        by smtp.gmail.com with ESMTPSA id o15sm25943715wra.83.2020.01.15.09.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jan 2020 09:51:28 -0800 (PST)
Subject: Re: [PATCH v4 2/2] KVM: LAPIC: micro-optimize fixed mode ipi delivery
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1574306232-872-1-git-send-email-wanpengli@tencent.com>
 <1574306232-872-2-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b84594ae-5874-e006-7a9e-dfd30e1bbefd@redhat.com>
Date:   Wed, 15 Jan 2020 18:51:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1574306232-872-2-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/19 04:17, Wanpeng Li wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> This patch optimizes redundancy logic before fixed mode ipi is delivered
> in the fast path, broadcast handling needs to go slow path, so the delivery
> mode repair can be delayed to before slow path.
> 
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/irq_comm.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/irq_comm.c b/arch/x86/kvm/irq_comm.c
> index 8ecd48d..aa88156 100644
> --- a/arch/x86/kvm/irq_comm.c
> +++ b/arch/x86/kvm/irq_comm.c
> @@ -52,15 +52,15 @@ int kvm_irq_delivery_to_apic(struct kvm *kvm, struct kvm_lapic *src,
>  	unsigned long dest_vcpu_bitmap[BITS_TO_LONGS(KVM_MAX_VCPUS)];
>  	unsigned int dest_vcpus = 0;
>  
> +	if (kvm_irq_delivery_to_apic_fast(kvm, src, irq, &r, dest_map))
> +		return r;
> +
>  	if (irq->dest_mode == 0 && irq->dest_id == 0xff &&
>  			kvm_lowest_prio_delivery(irq)) {
>  		printk(KERN_INFO "kvm: apic: phys broadcast and lowest prio\n");
>  		irq->delivery_mode = APIC_DM_FIXED;
>  	}
>  
> -	if (kvm_irq_delivery_to_apic_fast(kvm, src, irq, &r, dest_map))
> -		return r;
> -
>  	memset(dest_vcpu_bitmap, 0, sizeof(dest_vcpu_bitmap));
>  
>  	kvm_for_each_vcpu(i, vcpu, kvm) {
> 

Applied.

Paolo

