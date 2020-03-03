Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAE1C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A7A020866
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgIPrcfF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbgCCPn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:43:59 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58916 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729751AbgCCPn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:43:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583250237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yAMnWRJ5vnc6TKSkmN2sROwH3cHSL3g+RIjwXJW2VbU=;
        b=JgIPrcfFz7PEAjvXlQGWEbtY3UqhaQxqb91VnLqOeEs6p2iQ7fpe1HNH9NL0/MgaYQAgKn
        W9/3rQlWpdDtbJmbf1UZ5YlDHXAEstcEfgeLvx+9tq+0tzBvjUN7omnMiOK9ZdogzcFGf9
        YTKx4I2Bj7Z40wMSq0Ojy609WZU039Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-yZxEFT8UOiq8SG2cNbktig-1; Tue, 03 Mar 2020 10:43:54 -0500
X-MC-Unique: yZxEFT8UOiq8SG2cNbktig-1
Received: by mail-wr1-f72.google.com with SMTP id p5so1373916wrj.17
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 07:43:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yAMnWRJ5vnc6TKSkmN2sROwH3cHSL3g+RIjwXJW2VbU=;
        b=jyJOtKB8PiujMREGuozLVOWj5G/XoK62QciM9IxmHurbtjKBeZt0oIki/19K6ETX5/
         I3wZzj3osyNVB+ipuDFk617BOueOw1kEcjj/B6vo/0q1+EM6v4bJd/MQaolqWrpCzOeQ
         edgm+AWiikmUjDCHk9dfLYkxGIOv906n3r74Y5EC6kbnZ20kkAispjZZUQ5h941up/Rv
         MNd9aRrYWYZL3joC6Z06A1i/dI1qSvgibJKQmS5DtSgqOop7hLGRIpu/JLI8IE8hN+7E
         H6Q/N5qxkTWyHuhk8mjn0f855OCxZodrb3StcxF/GPKDZyutwSGwnJ9cvjRpUMbp2IkZ
         GXgw==
X-Gm-Message-State: ANhLgQ2r9/qOSbe36pIr/3HNKzX+UighFz3dVKSMFoQRdWb1WLZmnciN
        s3XzaW8jYdE7yDzEhpI7KFn9qpW0ShKHXss9UjMG+Rcl43I4lvR6dtrDhDXfiNpYmZO5b13apln
        IHBCjzrPQckECISgRXji4SXvU
X-Received: by 2002:a5d:6604:: with SMTP id n4mr5757443wru.136.1583250233023;
        Tue, 03 Mar 2020 07:43:53 -0800 (PST)
X-Google-Smtp-Source: ADFU+vumqsR5rnOG00c9GaGZ2ofh5YCbObsW6EeH/JregSBt8pHYDCYHTiSCjQ5QkNnLlKN2Hw9ffg==
X-Received: by 2002:a5d:6604:: with SMTP id n4mr5757420wru.136.1583250232749;
        Tue, 03 Mar 2020 07:43:52 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id j20sm4826677wmj.46.2020.03.03.07.43.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 07:43:52 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v2 26/66] KVM: x86: Replace bare "unsigned" with "unsigned int" in cpuid helpers
In-Reply-To: <20200302235709.27467-27-sean.j.christopherson@intel.com>
References: <20200302235709.27467-1-sean.j.christopherson@intel.com> <20200302235709.27467-27-sean.j.christopherson@intel.com>
Date:   Tue, 03 Mar 2020 16:43:51 +0100
Message-ID: <87lfohfnpk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Replace "unsigned" with "unsigned int" to make checkpatch and people
> everywhere a little bit happier, and to avoid propagating the filth when
> future patches add more cpuid helpers that work with unsigned (ints).
>
> No functional change intended.
>
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.h | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index 72a79bdfed6b..46b4b61b6cf8 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -63,7 +63,7 @@ static const struct cpuid_reg reverse_cpuid[] = {
>   * and can't be used by KVM to query/control guest capabilities.  And obviously
>   * the leaf being queried must have an entry in the lookup table.
>   */
> -static __always_inline void reverse_cpuid_check(unsigned x86_leaf)
> +static __always_inline void reverse_cpuid_check(unsigned int x86_leaf)
>  {
>  	BUILD_BUG_ON(x86_leaf == CPUID_LNX_1);
>  	BUILD_BUG_ON(x86_leaf == CPUID_LNX_2);
> @@ -87,15 +87,16 @@ static __always_inline u32 __feature_bit(int x86_feature)
>  
>  #define feature_bit(name)  __feature_bit(X86_FEATURE_##name)
>  
> -static __always_inline struct cpuid_reg x86_feature_cpuid(unsigned x86_feature)
> +static __always_inline struct cpuid_reg x86_feature_cpuid(unsigned int x86_feature)
>  {
> -	unsigned x86_leaf = x86_feature / 32;
> +	unsigned int x86_leaf = x86_feature / 32;
>  
>  	reverse_cpuid_check(x86_leaf);
>  	return reverse_cpuid[x86_leaf];
>  }
>  
> -static __always_inline u32 *guest_cpuid_get_register(struct kvm_vcpu *vcpu, unsigned x86_feature)
> +static __always_inline u32 *guest_cpuid_get_register(struct kvm_vcpu *vcpu,
> +						     unsigned int x86_feature)
>  {
>  	struct kvm_cpuid_entry2 *entry;
>  	const struct cpuid_reg cpuid = x86_feature_cpuid(x86_feature);
> @@ -119,7 +120,8 @@ static __always_inline u32 *guest_cpuid_get_register(struct kvm_vcpu *vcpu, unsi
>  	}
>  }
>  
> -static __always_inline bool guest_cpuid_has(struct kvm_vcpu *vcpu, unsigned x86_feature)
> +static __always_inline bool guest_cpuid_has(struct kvm_vcpu *vcpu,
> +					    unsigned int x86_feature)
>  {
>  	u32 *reg;
>  
> @@ -130,7 +132,8 @@ static __always_inline bool guest_cpuid_has(struct kvm_vcpu *vcpu, unsigned x86_
>  	return *reg & __feature_bit(x86_feature);
>  }
>  
> -static __always_inline void guest_cpuid_clear(struct kvm_vcpu *vcpu, unsigned x86_feature)
> +static __always_inline void guest_cpuid_clear(struct kvm_vcpu *vcpu,
> +					      unsigned int x86_feature)
>  {
>  	u32 *reg;

I am a little bit happier indeed, thank you! We still have 170+ bare
unsigned-s in arch/x86/kvm but let's at least not add more.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

