Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFCCC4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903FF21D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b2fyNM1g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgBZPZu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:25:50 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41534 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727311AbgBZPZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582730749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U+z6Jmk37TO/JaUjHTxF02ZLLvook79vbYaUXiu4fF8=;
        b=b2fyNM1gJ4a9dVWiShtsVGaZS+VipnWK4lU6bV+tQYuCHHnk3NmYGILoDoeoo69cN/DKQf
        +pmr0cdUR+AYTo2RU5esbuTZCJ6Xpk1qIg9wGNrIEZjbTFax9QjLfG9dZGzKoTydGtGs3A
        l6JvWeYRilFYllREtxal8BlDrEEWp4I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-J7zoXJUnN8SqOB_jQcbiog-1; Wed, 26 Feb 2020 10:25:36 -0500
X-MC-Unique: J7zoXJUnN8SqOB_jQcbiog-1
Received: by mail-wr1-f70.google.com with SMTP id c6so1603664wrm.18
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 07:25:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=U+z6Jmk37TO/JaUjHTxF02ZLLvook79vbYaUXiu4fF8=;
        b=WaIGj+Q6Go9nVayy/mMxYBPN/cJJ4wqDeRWBmY7ISGmVeqN4AEtkVzW76DP25uxfwo
         VrJI5jCwpk26FCatyFEqzdR2ibn8CDpmyP/rEmTLtnaJ8zlfoTBTgSGp0GdIYDdw/oZt
         G50lx9A7a8o/uRyO0wydMM8N8TEQ6/mM4Q46TBJaK70i4o8AAmU05jWjBgdfXNPvMZLG
         wpBkEksG3kjcEgTTGFriv027nIWsPMPUI+jwoLmqD0XqN1EmvZ0l0Nfw5iffHlZszo4c
         U02Ru4eBqgPHIplmxM66x6bq8nyr0OV3Zi4X5UJNx+33W5+6qrDz7qWzzy/OS3nV24vE
         DHpw==
X-Gm-Message-State: APjAAAWuW56qSNZ/2YXCBi4mFPfUYr/t8CsCF2jn4ZjmTBWjrGyH8ZA4
        2acuUbWAxGpnz1oyfFI1g7L7oTprjRxDk2OYWPl+aqvomcWpE8RrhE3Axi5/7z14FfXpsJu6rcl
        X1d9ApEbAOR0BScgmIVAZVcoI
X-Received: by 2002:a7b:c152:: with SMTP id z18mr6060545wmi.70.1582730735617;
        Wed, 26 Feb 2020 07:25:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqwow62T9Dz43AXGv3wZglGVVzoT5IckHTRkmaSdRsxu4S9ICwu8weBpiLeEjtXHZGEBc5XURw==
X-Received: by 2002:a7b:c152:: with SMTP id z18mr6060530wmi.70.1582730735411;
        Wed, 26 Feb 2020 07:25:35 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id n5sm3639043wrq.40.2020.02.26.07.25.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 07:25:34 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/13] KVM: x86: Refactor emulated exception injection to take the emul context
In-Reply-To: <20200218232953.5724-6-sean.j.christopherson@intel.com>
References: <20200218232953.5724-1-sean.j.christopherson@intel.com> <20200218232953.5724-6-sean.j.christopherson@intel.com>
Date:   Wed, 26 Feb 2020 16:25:34 +0100
Message-ID: <875zftjrpt.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Invert the vcpu->context derivation in inject_emulated_exception() in
> preparation for dynamically allocating the emulation context.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/x86.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 772e704e8083..79d1113ad6e7 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6399,9 +6399,10 @@ static void toggle_interruptibility(struct kvm_vcpu *vcpu, u32 mask)
>  	}
>  }
>  
> -static bool inject_emulated_exception(struct kvm_vcpu *vcpu)
> +static bool inject_emulated_exception(struct x86_emulate_ctxt *ctxt)
>  {
> -	struct x86_emulate_ctxt *ctxt = &vcpu->arch.emulate_ctxt;
> +	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
> +
>  	if (ctxt->exception.vector == PF_VECTOR)
>  		return kvm_propagate_fault(vcpu, &ctxt->exception);
>  
> @@ -6806,7 +6807,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  				 */
>  				WARN_ON_ONCE(ctxt->exception.vector == UD_VECTOR ||
>  					     exception_type(ctxt->exception.vector) == EXCPT_TRAP);
> -				inject_emulated_exception(vcpu);
> +				inject_emulated_exception(ctxt);
>  				return 1;
>  			}
>  			return handle_emulation_failure(vcpu, emulation_type);
> @@ -6860,7 +6861,7 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
>  
>  	if (ctxt->have_exception) {
>  		r = 1;
> -		if (inject_emulated_exception(vcpu))
> +		if (inject_emulated_exception(ctxt))
>  			return r;
>  	} else if (vcpu->arch.pio.count) {
>  		if (!vcpu->arch.pio.in) {

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

