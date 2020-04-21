Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF20C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8FB02064C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NGonbqJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgDULkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:40:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29183 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728335AbgDULkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587469211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WXGo5tMnmRN2aCytbsR/ONxLvJJwfyJk/gIIERFs1mw=;
        b=NGonbqJQiMhbLJVtcXEs2r8iI920rnwqYQHUFFo72qblv8L9CRH4U8UOGzLyeFq5MMpBST
        yh3P+THKjlt469vzMSIDlWMgfkihA1O5nN9u6sVvSABGibxDsz2WhexsZ4TzJlKr8E4l8V
        kNiYvWRMNBr0OL7s7rczqvTvQK4fVWo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-198-jQjw10mYP3eqesj1HDLelw-1; Tue, 21 Apr 2020 07:40:09 -0400
X-MC-Unique: jQjw10mYP3eqesj1HDLelw-1
Received: by mail-wm1-f69.google.com with SMTP id u11so1254686wmc.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 04:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WXGo5tMnmRN2aCytbsR/ONxLvJJwfyJk/gIIERFs1mw=;
        b=Ox/KpnWwFnpwQbXnF2RM0n6fRSpLxinTVjR8f6OHYFDudbf62MUzKwc2v9RxpQVweo
         h3P8EWzQiC2ybXmQbpBJHn8dO+Qq8nbvU6BR1/Itrq/lLBCbpmzUeHIAT86+zwEGb2lU
         ueRWTXsUXYZtyHMqWIH3T2VZrny4AnPgWGdv5oQ5hEyspTprjqg67IE2o0WBgBRhZi1X
         iRlWu5joy//cMm4pVUe/xtzJQgB4Kh72OpXj7gD4We+0hjlyO7tmKVAG5e8aYYHV1IY1
         Q+pcmfANet74DZuJik6xWgoxmECdELZGyXvcskfjg87pmJJQHCk7q2Itkc8tbPNDfTay
         EzDQ==
X-Gm-Message-State: AGi0PuY6WaxKEfYaAxAQoNum+ECCTN/JEtjP+usOd7JMrd1CnTuv1J4u
        xOGDlo9jUrJ2wSNKCTQj1rYmULiRoEElFdHUu4P0DTaQNRrcvfJpjw0+Uo6V3tC91DrtD44hSZ8
        ROlWALk0VHBFJuioRaG/JbrfT
X-Received: by 2002:a05:600c:214b:: with SMTP id v11mr4723221wml.151.1587469208312;
        Tue, 21 Apr 2020 04:40:08 -0700 (PDT)
X-Google-Smtp-Source: APiQypLy8DKo++cKyza5NC+5GJmV2GcubZ++IDuuWg27HnTf2+likrC++CmAj2XRFifBSyvGdjLx5w==
X-Received: by 2002:a05:600c:214b:: with SMTP id v11mr4723195wml.151.1587469208078;
        Tue, 21 Apr 2020 04:40:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id v7sm3846697wmg.3.2020.04.21.04.40.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 04:40:07 -0700 (PDT)
Subject: Re: [PATCH 2/2] KVM: VMX: Handle preemption timer fastpath
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
References: <1587468026-15753-1-git-send-email-wanpengli@tencent.com>
 <1587468026-15753-3-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <68eb0e46-4c2a-0292-3dfa-db2ae2b2b13d@redhat.com>
Date:   Tue, 21 Apr 2020 13:40:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587468026-15753-3-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/20 13:20, Wanpeng Li wrote:
> +
> +	if (!vmx->req_immediate_exit &&
> +		!unlikely(vmx->loaded_vmcs->hv_timer_soft_disabled)) {
> +		if (!vmx_interrupt_allowed(vcpu) ||
> +			!apic_lvtt_tscdeadline(apic) ||
> +			vmx->rmode.vm86_active ||
> +			is_smm(vcpu) ||
> +			!kvm_apic_hw_enabled(apic))
> +			return EXIT_FASTPATH_NONE;
> +
> +		if (!apic->lapic_timer.hv_timer_in_use)
> +			return EXIT_FASTPATH_CONT_RUN;
> +
> +		WARN_ON(swait_active(&vcpu->wq));
> +		vmx_cancel_hv_timer(vcpu);
> +		apic->lapic_timer.hv_timer_in_use = false;
> +
> +		if (atomic_read(&apic->lapic_timer.pending))
> +			return EXIT_FASTPATH_CONT_RUN;
> +
> +		ktimer->expired_tscdeadline = ktimer->tscdeadline;
> +		vmx_fast_deliver_interrupt(vcpu);
> +		ktimer->tscdeadline = 0;
> +		return EXIT_FASTPATH_CONT_RUN;
> +	}
> +

Can you explain all the checks you have here, and why you need something
more complex than apic_timer_expired (possibly by adding some
optimizations to kvm_apic_local_deliver)?  This code is impossible to
maintain.

Paolo

