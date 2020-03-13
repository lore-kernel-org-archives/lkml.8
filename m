Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD12C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C8520724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e5w/aaqt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgCMN5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:57:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31201 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726582AbgCMN5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:57:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584107820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EkZK0Yw0b3AmsS+1K+/HHxMBgsPW+vDT8ZosmzTnnFM=;
        b=e5w/aaqtpyWWws5hvUhjXJ8QfHdpWWV5i7ESTL5dlyJ8uXLFO+7KDwPpC0+dwhvflkSqvb
        R8ZbfDUu1lImL+8eM3qSIRSw/YkFV1Yk/4MH9VwyD9P0wNm3k3pX2PDC8fcWecOAb/bM7x
        TzQuZjMnx7ATYSzC6gISUD8IAiXyUz4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-320-MUcxqG1MMjG8ykts15VrOQ-1; Fri, 13 Mar 2020 09:56:58 -0400
X-MC-Unique: MUcxqG1MMjG8ykts15VrOQ-1
Received: by mail-wr1-f70.google.com with SMTP id u12so1853461wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 06:56:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=EkZK0Yw0b3AmsS+1K+/HHxMBgsPW+vDT8ZosmzTnnFM=;
        b=re+sHUO3fDpXX3/nJUr9gmlEHqmK6rHY5e0ok5+FImuX7xJyn4Xe7EwlOFLQAV0RAK
         5A1ri+i8nUZ1DU7r7+YEs+XGBzLxPkpaDARNQUNa85ghY5+dA4Mgv3EdoLrsNDwdx0Z2
         CRNOlVVE9JTG/x/I2xN8dytLGp9KdmxEnL8Bq4k/EG3NaFtQ0Xv+EWhOJSDkUdtu6ZDl
         D0yivL0cxhIuar93Llz4bt9j/aBIEtxVEP0cNDlMttJS/9uXkpywe7B3rDJT1U2ElbHL
         pVAyhkq91zvWxxVTF/EoFCqAvlrJt2iE8O0Av/LboRbVy6KMwUbxOYeSeIp7cOnPc8iP
         uyJQ==
X-Gm-Message-State: ANhLgQ0gTlWnJyimI+858QR4aYK5p5qzhBGPZa/Y7BjCcOmxR5A7WnUF
        6wobxuIYAo2Nx5foWmeRpeHTePgWQv5B/NUs7pwkpEup5Oqv3hO9aH3ufajhJEafr4jZf7jw8CL
        oZeCDKdv9CtE3OTmx4AcQCE09
X-Received: by 2002:a5d:6446:: with SMTP id d6mr17116232wrw.335.1584107817154;
        Fri, 13 Mar 2020 06:56:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsHnSokoI6DLr0MqcBliww9h/fQiT7vpU6EgENRVhdcolPrQmSdo+WdzskiBNYfgVvwjYhFqA==
X-Received: by 2002:a5d:6446:: with SMTP id d6mr17116218wrw.335.1584107816972;
        Fri, 13 Mar 2020 06:56:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a73sm1012706wme.47.2020.03.13.06.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 06:56:56 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH 07/10] KVM: nVMX: Cast exit_reason to u16 to check for nested EXTERNAL_INTERRUPT
In-Reply-To: <20200312184521.24579-8-sean.j.christopherson@intel.com>
References: <20200312184521.24579-1-sean.j.christopherson@intel.com> <20200312184521.24579-8-sean.j.christopherson@intel.com>
Date:   Fri, 13 Mar 2020 14:56:55 +0100
Message-ID: <87mu8knys8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Explicitly check only the basic exit reason when emulating an external
> interrupt VM-Exit in nested_vmx_vmexit().  Checking the full exit reason
> doesn't currently cause problems, but only because the only exit reason
> modifier support by KVM is FAILED_VMENTRY, which is mutually exclusive
> with EXTERNAL_INTERRUPT.  Future modifiers, e.g. ENCLAVE_MODE, will
> coexist with EXTERNAL_INTERRUPT.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 8fbbe2152ab7..86b12a2918c5 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -4337,7 +4337,7 @@ void nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 exit_reason,
>  	vcpu->arch.mp_state = KVM_MP_STATE_RUNNABLE;
>  
>  	if (likely(!vmx->fail)) {
> -		if (exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT &&
> +		if ((u16)exit_reason == EXIT_REASON_EXTERNAL_INTERRUPT &&
>  		    nested_exit_intr_ack_set(vcpu)) {
>  			int irq = kvm_cpu_get_interrupt(vcpu);
>  			WARN_ON(irq < 0);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

