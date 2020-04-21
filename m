Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6CCC54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 846F9206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOlMFyvm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbgDULhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:37:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42022 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728316AbgDULhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:37:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587469033;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FlWyMKmK8DJ/XjEfN6eAlMmFQylnlmtlIQ1jfeEsF6I=;
        b=BOlMFyvmuh9ZIlMyQCJtsp5ZQ7NHaQChbkj3UF8gHuWmSvQVnTaoPX8QSp8QhT6lRbeeuk
        VuUvI+pQq8XmwwmeW80wmHx/I8L0TSHa5+i3cBUIt4B144cuG9Us+BegTV/N6gE1tGMtzF
        N0YpJ6UAKJ9i8LjYfu3FrywbDJ7VrpM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-2tH7AAwuOeqlrMy47WRYTw-1; Tue, 21 Apr 2020 07:37:11 -0400
X-MC-Unique: 2tH7AAwuOeqlrMy47WRYTw-1
Received: by mail-wr1-f69.google.com with SMTP id p16so7344868wro.16
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 04:37:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FlWyMKmK8DJ/XjEfN6eAlMmFQylnlmtlIQ1jfeEsF6I=;
        b=ktdIYyqRla2pKLKDVPYrJiahOw7zuWHQih9fRnWCoBW8oqscYy6cJoM6VP1wU4i2DS
         h5nz3dUmoajuGnGfl3JWeBfemdeKGnO0LrvJwL3Jo2HnYP0BLcXBQZXp/adE2QHnRNmV
         sY/gWK6KtJRaDVtVluQvzbdbjdOKAXeOVNxcCl8iPVw24406B4xrtn99q/MS7TQurTlO
         0ojIF1upjOZAJjEGFDCH96zoVFNiONiGGdP3UduWGQmBb9rzxZCOZ9SRS7KMC30Mty0S
         Ku11aplO6QmD0tIhBXIdBMAjXq2Rx+UYA6q7utwYH6NujWUBScocgLBeqTHgDy8D3aH6
         /VmA==
X-Gm-Message-State: AGi0PuZ+nQW/tFDWs2BzHmLFVD/8eQJs/09PeEKIvq297ahG3TmGbYwM
        w0Cw4DhZbS5gjrNkmFpKnV0LpTcEr3icAKcXip6wvSmZPORusV8rhw0GFf0Hd/4C+ManSSy66OZ
        um9S3kNZgnoHqYdNQya1sBA7h
X-Received: by 2002:a5d:5391:: with SMTP id d17mr22922992wrv.215.1587469030299;
        Tue, 21 Apr 2020 04:37:10 -0700 (PDT)
X-Google-Smtp-Source: APiQypKWNY9r98xan0U3xHxHOA6Pih53h+uF5U7j7kVuj+nZD49UjR2kIE/hhXq9rDo17LaNfEVxww==
X-Received: by 2002:a5d:5391:: with SMTP id d17mr22922978wrv.215.1587469030100;
        Tue, 21 Apr 2020 04:37:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f43b:97b2:4c89:7446? ([2001:b07:6468:f312:f43b:97b2:4c89:7446])
        by smtp.gmail.com with ESMTPSA id z18sm3197943wrw.41.2020.04.21.04.37.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 04:37:09 -0700 (PDT)
Subject: Re: [PATCH 1/2] KVM: X86: TSCDEADLINE MSR emulation fastpath
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
References: <1587468026-15753-1-git-send-email-wanpengli@tencent.com>
 <1587468026-15753-2-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ed968729-5d2a-a318-1d8f-db39e6ee72cb@redhat.com>
Date:   Tue, 21 Apr 2020 13:37:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587468026-15753-2-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/04/20 13:20, Wanpeng Li wrote:
> +	case MSR_IA32_TSCDEADLINE:
> +		if (!kvm_x86_ops.event_needs_reinjection(vcpu)) {
> +			data = kvm_read_edx_eax(vcpu);
> +			if (!handle_fastpath_set_tscdeadline(vcpu, data))
> +				ret = EXIT_FASTPATH_CONT_RUN;
> +		}
>  		break;

Can you explain the event_needs_reinjection case?  Also, does this break
AMD which does not implement the callback?

> +
> +	reg = kvm_lapic_get_reg(apic, APIC_LVTT);
> +	if (kvm_apic_hw_enabled(apic) && !(reg & APIC_LVT_MASKED)) {
> +		vector = reg & APIC_VECTOR_MASK;
> +		kvm_lapic_clear_vector(vector, apic->regs + APIC_TMR);
> +
> +		if (vcpu->arch.apicv_active) {
> +			if (pi_test_and_set_pir(vector, &vmx->pi_desc))
> +				return;
> +
> +			if (pi_test_and_set_on(&vmx->pi_desc))
> +				return;
> +
> +			vmx_sync_pir_to_irr(vcpu);
> +		} else {
> +			kvm_lapic_set_irr(vector, apic);
> +			kvm_queue_interrupt(vcpu, kvm_cpu_get_interrupt(vcpu), false);
> +			vmx_inject_irq(vcpu);
> +		}
> +	}

This is mostly a copy of

               if (kvm_x86_ops.deliver_posted_interrupt(vcpu, vector)) {
                        kvm_lapic_set_irr(vector, apic);
                        kvm_make_request(KVM_REQ_EVENT, vcpu);
                        kvm_vcpu_kick(vcpu);
                }
                break;

(is it required to do vmx_sync_pir_to_irr?).  So you should not special
case LVTT and move this code to lapic.c instead.  But even before that...

> 
> +
> +	if (kvm_start_hv_timer(apic)) {
> +		if (kvm_check_request(KVM_REQ_PENDING_TIMER, vcpu)) {
> +			if (kvm_x86_ops.interrupt_allowed(vcpu)) {
> +				kvm_clear_request(KVM_REQ_PENDING_TIMER, vcpu);
> +				kvm_x86_ops.fast_deliver_interrupt(vcpu);
> +				atomic_set(&apic->lapic_timer.pending, 0);
> +				apic->lapic_timer.tscdeadline = 0;
> +				return 0;
> +			}
> +			return 1;


Is it actually common that the timer is set back in time and therefore
this code is executed?

Paolo

