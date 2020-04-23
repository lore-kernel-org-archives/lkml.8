Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8542C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B12420704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 11:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zj2TUg4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgDWLAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 07:00:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47432 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727791AbgDWLAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 07:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587639618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=20mD5b4K8EOsmpKpysEvWUMgHRYlVlD/chD77TRrBwA=;
        b=Zj2TUg4t+Y2/cGfNPhdrpAO51oYcNThen8kM1l4y0RELhJTqrFz3F59ESjLocWxaZuC9yV
        RKRu4CgtfSZT9PMh5whHry6mrrIsh+vCVbVcI2nlsEwFDUGgCFWXWtUa5aLNXFuIk3yu1u
        oXFbW9WNVA6VsrcgldATV9KDMMryQfk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-2gQe5_CJNo62DqfLIpUzog-1; Thu, 23 Apr 2020 07:00:13 -0400
X-MC-Unique: 2gQe5_CJNo62DqfLIpUzog-1
Received: by mail-wr1-f71.google.com with SMTP id f2so2672172wrm.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 04:00:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=20mD5b4K8EOsmpKpysEvWUMgHRYlVlD/chD77TRrBwA=;
        b=YsYELky+Qp/CV0e/dcWxytqLPg7T3lsN9VyXAHauTTJLaiS4rC8iq+wN7tDunL9cbU
         XHGHfTNf4xiVHXZw+LnOiyHq1XAC066RLHNjxduYq3i8iixiaiaQ/OfZJ17Gm1VLAyao
         5tWO/XGVC5oeJ0HIcb9vgkEordpougLX2vrVxiMUzyNKlUvf6AX7n+MaGzwRi5UXtCVY
         /IAdOuPgO2J/S5c79EkU92pR4Sy2i8cpV+4Zr1PyJnByOc4HmyL84KOsj8ctfdk8aCJo
         NGZk+LH3iG7He41AkSTiJiH9e5TTndVWn8OtTsD557e0/YQeYsq63EY71Gu5wnUAtWd1
         G/og==
X-Gm-Message-State: AGi0PuZFgAh9dRTKAJzdaIQ+KpPpwecahH/q+Rx5VMtlJhh9huLsmz03
        ZFIMmMKbHe15GUDgKz1Zm/CKdweKfHsJADU8wdTLmmiNDp5TCIDrESg6XOUxKUbN8EKFVRDS4qb
        ncuFCTSWz0HHLgErI6HCkCtFt
X-Received: by 2002:adf:97d0:: with SMTP id t16mr4055800wrb.138.1587639611839;
        Thu, 23 Apr 2020 04:00:11 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ8SqSh9o6yckWbzkNCOCPSjoQm/m/ViZdLrbvlLCIMHDoLGQ8GJlTCvLpolt8yzkBiY2WRuQ==
X-Received: by 2002:adf:97d0:: with SMTP id t16mr4055767wrb.138.1587639611556;
        Thu, 23 Apr 2020 04:00:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d0a0:f143:e9e4:2926? ([2001:b07:6468:f312:d0a0:f143:e9e4:2926])
        by smtp.gmail.com with ESMTPSA id l19sm3348599wmj.14.2020.04.23.04.00.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 04:00:11 -0700 (PDT)
Subject: Re: [PATCH 12/13] KVM: x86: Replace late check_nested_events() hack
 with more precise fix
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
References: <20200423022550.15113-1-sean.j.christopherson@intel.com>
 <20200423022550.15113-13-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f766789e-7444-ab0d-4364-0c14ec7154b1@redhat.com>
Date:   Thu, 23 Apr 2020 13:00:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423022550.15113-13-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/20 04:25, Sean Christopherson wrote:
> Add a separate hook for checking if interrupt injection is blocked and
> use the hook to handle the case where an interrupt arrives between
> check_nested_events() and the injection logic.  Drop the retry of
> check_nested_events() that hack-a-fixed the same condition.
> 
> Blocking injection is also a bit of a hack, e.g. KVM should do exiting
> and non-exiting interrupt processing in a single pass, but it's a more
> precise hack.  The old comment is also misleading, e.g. KVM_REQ_EVENT is
> purely an optimization, setting it on every run loop (which KVM doesn't
> do) should not affect functionality, only performance.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/svm/svm.c          |  1 +
>  arch/x86/kvm/vmx/vmx.c          | 13 +++++++++++++
>  arch/x86/kvm/x86.c              | 22 ++++------------------
>  4 files changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 787636acd648..16fdeddb4a65 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1140,6 +1140,7 @@ struct kvm_x86_ops {
>  	void (*queue_exception)(struct kvm_vcpu *vcpu);
>  	void (*cancel_injection)(struct kvm_vcpu *vcpu);
>  	bool (*interrupt_allowed)(struct kvm_vcpu *vcpu);
> +	bool (*interrupt_injection_allowed)(struct kvm_vcpu *vcpu);
>  	bool (*nmi_allowed)(struct kvm_vcpu *vcpu);
>  	bool (*get_nmi_mask)(struct kvm_vcpu *vcpu);
>  	void (*set_nmi_mask)(struct kvm_vcpu *vcpu, bool masked);
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index f21f734861dd..6d3ccbfc9e6a 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3993,6 +3993,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
>  	.queue_exception = svm_queue_exception,
>  	.cancel_injection = svm_cancel_injection,
>  	.interrupt_allowed = svm_interrupt_allowed,
> +	.interrupt_injection_allowed = svm_interrupt_allowed,
>  	.nmi_allowed = svm_nmi_allowed,
>  	.get_nmi_mask = svm_get_nmi_mask,
>  	.set_nmi_mask = svm_set_nmi_mask,
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 2f8cacb3aa9b..68b3748b5383 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4550,6 +4550,18 @@ static bool vmx_interrupt_allowed(struct kvm_vcpu *vcpu)
>  	return !vmx_interrupt_blocked(vcpu);
>  }
>  
> +static bool vmx_interrupt_injection_allowed(struct kvm_vcpu *vcpu)
> +{
> +	/*
> +	 * An IRQ must not be injected into L2 if it's supposed to VM-Exit,
> +	 * e.g. if the IRQ arrived asynchronously after checking nested events.
> +	 */
> +	if (is_guest_mode(vcpu) && nested_exit_on_intr(vcpu))
> +		return false;
> +
> +	return vmx_interrupt_allowed(vcpu);
> +}
> +
>  static int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
>  {
>  	int ret;
> @@ -7823,6 +7835,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
>  	.queue_exception = vmx_queue_exception,
>  	.cancel_injection = vmx_cancel_injection,
>  	.interrupt_allowed = vmx_interrupt_allowed,
> +	.interrupt_injection_allowed = vmx_interrupt_injection_allowed,
>  	.nmi_allowed = vmx_nmi_allowed,
>  	.get_nmi_mask = vmx_get_nmi_mask,
>  	.set_nmi_mask = vmx_set_nmi_mask,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7c49a7dc601f..d9d6028a77e0 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7755,24 +7755,10 @@ static int inject_pending_event(struct kvm_vcpu *vcpu)
>  		--vcpu->arch.nmi_pending;
>  		vcpu->arch.nmi_injected = true;
>  		kvm_x86_ops.set_nmi(vcpu);
> -	} else if (kvm_cpu_has_injectable_intr(vcpu)) {
> -		/*
> -		 * Because interrupts can be injected asynchronously, we are
> -		 * calling check_nested_events again here to avoid a race condition.
> -		 * See https://lkml.org/lkml/2014/7/2/60 for discussion about this
> -		 * proposal and current concerns.  Perhaps we should be setting
> -		 * KVM_REQ_EVENT only on certain events and not unconditionally?
> -		 */
> -		if (is_guest_mode(vcpu) && kvm_x86_ops.check_nested_events) {
> -			r = kvm_x86_ops.check_nested_events(vcpu);
> -			if (r != 0)
> -				return r;
> -		}
> -		if (kvm_x86_ops.interrupt_allowed(vcpu)) {
> -			kvm_queue_interrupt(vcpu, kvm_cpu_get_interrupt(vcpu),
> -					    false);
> -			kvm_x86_ops.set_irq(vcpu);
> -		}
> +	} else if (kvm_cpu_has_injectable_intr(vcpu) &&
> +		   kvm_x86_ops.interrupt_injection_allowed(vcpu)) {
> +		kvm_queue_interrupt(vcpu, kvm_cpu_get_interrupt(vcpu), false);
> +		kvm_x86_ops.set_irq(vcpu);

Hmm I'm interested in how this can help with AMD introducing another
instance of the late random check_nested_events.  I'll play with it.

Paolo

