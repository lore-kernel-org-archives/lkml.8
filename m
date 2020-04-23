Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABFECC55186
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2FE2076C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 09:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ah0zGEyE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgDWJjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 05:39:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35227 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726343AbgDWJjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 05:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587634754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=krIKFQitEIQii4FaNTmzJRbDm53HYqI5kEcn11R/yc8=;
        b=ah0zGEyER/wPsOMZK65GDplax2qj+NrrIZI9L3v7sWdCGmhuna9qlGKUjV2F36sc0yTK0y
        wnnpcIu4okOjqi1fuNk0KmEOoYbZEoTVPYaBS3sefApPWWiwXuUcrSErGfyJJGEIvmFjca
        1vMOOvdkj6ReVPiiv4tMqQkTjUxlNAk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-eAn_C87qMC6VfnVCdiGEew-1; Thu, 23 Apr 2020 05:39:12 -0400
X-MC-Unique: eAn_C87qMC6VfnVCdiGEew-1
Received: by mail-wm1-f70.google.com with SMTP id h22so1858462wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 02:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=krIKFQitEIQii4FaNTmzJRbDm53HYqI5kEcn11R/yc8=;
        b=YfPJqtCKR5tUEqiDkMUcbmaIZoWM8UZsORKLWgoXCv6x0rp0hmE+Z1yCyTAkR9wDM3
         1SlP+K4fsf5jxehmxdikccU8poujYb8CBS52EKsLuNu5ULKGzN8+sibCIgcvqD76KWfQ
         9qhK7D+vuPI4HTaTbHIns4VjPEosWEAzYzvQbSNUx/decf95UW0HUU37eXpHfk8I21aS
         k8iXETlLB26hhbLkJQs6dN6hkuKvfmCiFGb8CFcoLAFOMOpXPGnVIS9CMRXeE8YIP43F
         MKGkxiQuQKcZEZF+aZQJC5zLGG3PJNxQRSfZVb0EC1g96PFWSZZsON2nd9kyg16gvRjr
         obBA==
X-Gm-Message-State: AGi0PuZGla0B4WCOjy3HVPWKHabyDYFas/5U4J34RdKLDFaJ0y35krCJ
        VcVtUvhdN9PtRC4YfMRh/YqmPngjuZLwnw/fpGCCoz5dvJD4NbTmN0IQAWjejkgRqwZOeHwfur6
        nyKK1eO/OKEF39AcpLq0glaFr
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr4010842wrx.185.1587634751408;
        Thu, 23 Apr 2020 02:39:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypI6uS0O6WE67lrL00XGzKt4Wxu+kI7s3/b8HBMChSVaLLepDiKCBydP7j8Im1fqRhH3NZ+mJw==
X-Received: by 2002:a05:6000:12c5:: with SMTP id l5mr4010807wrx.185.1587634751161;
        Thu, 23 Apr 2020 02:39:11 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id j13sm3015373wrq.24.2020.04.23.02.39.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 02:39:10 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] KVM: X86: TSCDEADLINE MSR emulation fastpath
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Haiwei Li <lihaiwei@tencent.com>
References: <1587632507-18997-1-git-send-email-wanpengli@tencent.com>
 <1587632507-18997-5-git-send-email-wanpengli@tencent.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1309372a-0dcf-cba6-9d65-e50139bbe46b@redhat.com>
Date:   Thu, 23 Apr 2020 11:37:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1587632507-18997-5-git-send-email-wanpengli@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/20 11:01, Wanpeng Li wrote:
> +
> +void kvm_set_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu, u64 data)
> +{
> +	if (__kvm_set_lapic_tscdeadline_msr(vcpu, data))
> +		start_apic_timer(vcpu->arch.apic);
> +}
> +
> +int kvm_set_lapic_tscdeadline_msr_fast(struct kvm_vcpu *vcpu, u64 data)
> +{
> +	struct kvm_lapic *apic = vcpu->arch.apic;
> +
> +	if (__kvm_set_lapic_tscdeadline_msr(vcpu, data)) {
> +		atomic_set(&apic->lapic_timer.pending, 0);
> +		if (start_hv_timer(apic))
> +			return tscdeadline_expired_timer_fast(vcpu);
> +	}
> +
> +	return 1;
>  }
>
> +static int tscdeadline_expired_timer_fast(struct kvm_vcpu *vcpu)
> +{
> +	if (kvm_check_request(KVM_REQ_PENDING_TIMER, vcpu)) {
> +		kvm_clear_request(KVM_REQ_PENDING_TIMER, vcpu);
> +		kvm_inject_apic_timer_irqs_fast(vcpu);
> +		atomic_set(&vcpu->arch.apic->lapic_timer.pending, 0);
> +	}
> +
> +	return 0;
> +}

This could also be handled in apic_timer_expired.  For example you can
add an argument from_timer_fn and do

	if (!from_timer_fn) {
		WARN_ON(kvm_get_running_vcpu() != vcpu);
		kvm_inject_apic_timer_irqs_fast(vcpu);
		return;
	}

        if (kvm_use_posted_timer_interrupt(apic->vcpu)) {
                ...
	}
	atomic_inc(&apic->lapic_timer.pending);
	kvm_set_pending_timer(vcpu);

and then you don't need kvm_set_lapic_tscdeadline_msr_fast and
everything else.  Anyway thanks, this is already much better.

Paoo

