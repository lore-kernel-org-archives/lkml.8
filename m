Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F95C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CCB2078B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NJB3JmEr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgCaOv7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:51:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49458 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730149AbgCaOv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585666317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDECw4Jp5diyRW+zp7XYY468nsqeU3iwo9Wu7xQsHVE=;
        b=NJB3JmEr+1RjW41SBCtJFHsiSGW8hNslv6Y2vJGOfDGCtKGbfggm+BkvUndgDqbYJD47tQ
        rntAFyzAiZ8tti6eifzqDJ6a6+CkH4HX4TSarz2y9lrP38hrsGcrM2obXKlV5s1JGtqFar
        hewcHu2Th1/53YDe0VOxIaWfYaFOXD0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-SO6u2TKEOsqynqWq63w3nQ-1; Tue, 31 Mar 2020 10:51:56 -0400
X-MC-Unique: SO6u2TKEOsqynqWq63w3nQ-1
Received: by mail-wm1-f71.google.com with SMTP id 2so1174914wmf.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:51:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BDECw4Jp5diyRW+zp7XYY468nsqeU3iwo9Wu7xQsHVE=;
        b=QhZF1ecTSyzC9s16G/I16GEYmOGfIYqa711rHfW1RH5T8jdFlc3NuEVdRQ/i5l87WW
         mJtYmzb8t92+lTv8d6cnWFGF8FONZWv3f6HwUgVZn2D88v0n9Q0JX78O5pvgY0z1km0D
         WJ/J8s1LRnLSB5csGNBNNkFhhTCIVi0nbHdqnPPBSlQ8xY5Q7xLq8Lmjv0bupUAucOrY
         XOvSZ2437R2XBlPMMNIb7eVSpqRZ9PVlGFfx7gZUhR67zQo9gekjik/vHA+aHGwtwpBA
         shQNeWN3er7PK+3zbI4h20vusHDjJkqwTGfnuPHh/ymJuszV8ARute89Rn0d1GAB2nyj
         8b2g==
X-Gm-Message-State: ANhLgQ0ZwoppMU5IGGlm5fTeEEtbE9OyzX78aDXQfQfy8lvpOpvnVf58
        LfAmGT1jVLxvWv6XMoMKvLftiILoxX7oj9BXD15v1EdZ8Zv52fPqNa6ARGGI2cw2T+eYh/Vw4hs
        vPV9XRqMuTjSsjmIYQ4nRAeSc
X-Received: by 2002:adf:de01:: with SMTP id b1mr19917334wrm.376.1585666315008;
        Tue, 31 Mar 2020 07:51:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vupXM5pQZMzUDS/XKpSKnf+xfUggsYlgWDrPztm8ckKXsUeZM/TnUcNGpHowo5uD4xx1p4Ydw==
X-Received: by 2002:adf:de01:: with SMTP id b1mr19917312wrm.376.1585666314721;
        Tue, 31 Mar 2020 07:51:54 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b55d:5ed2:8a41:41ea? ([2001:b07:6468:f312:b55d:5ed2:8a41:41ea])
        by smtp.gmail.com with ESMTPSA id a13sm19618574wrt.64.2020.03.31.07.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 07:51:54 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Fix BUILD_BUG() in __cpuid_entry_get_reg() w/
 CONFIG_UBSAN=y
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
References: <20200325191259.23559-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d2f9a3a5-5ade-c810-4c61-cf8e9c92c93d@redhat.com>
Date:   Tue, 31 Mar 2020 16:51:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200325191259.23559-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/03/20 20:12, Sean Christopherson wrote:
> Take the target reg in __cpuid_entry_get_reg() instead of a pointer to a
> struct cpuid_reg.  When building with -fsanitize=alignment (enabled by
> CONFIG_UBSAN=y), some versions of gcc get tripped up on the pointer and
> trigger the BUILD_BUG().
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: d8577a4c238f8 ("KVM: x86: Do host CPUID at load time to mask KVM cpu caps")
> Fixes: 4c61534aaae2a ("KVM: x86: Introduce cpuid_entry_{get,has}() accessors")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 2 +-
>  arch/x86/kvm/cpuid.h | 8 ++++----
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 08280d8a2ac9..16d3ae432420 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -269,7 +269,7 @@ static __always_inline void kvm_cpu_cap_mask(enum cpuid_leafs leaf, u32 mask)
>  	cpuid_count(cpuid.function, cpuid.index,
>  		    &entry.eax, &entry.ebx, &entry.ecx, &entry.edx);
>  
> -	kvm_cpu_caps[leaf] &= *__cpuid_entry_get_reg(&entry, &cpuid);
> +	kvm_cpu_caps[leaf] &= *__cpuid_entry_get_reg(&entry, cpuid.reg);
>  }
>  
>  void kvm_set_cpu_caps(void)
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index 23b4cd1ad986..63a70f6a3df3 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -99,9 +99,9 @@ static __always_inline struct cpuid_reg x86_feature_cpuid(unsigned int x86_featu
>  }
>  
>  static __always_inline u32 *__cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry,
> -						  const struct cpuid_reg *cpuid)
> +						  u32 reg)
>  {
> -	switch (cpuid->reg) {
> +	switch (reg) {
>  	case CPUID_EAX:
>  		return &entry->eax;
>  	case CPUID_EBX:
> @@ -121,7 +121,7 @@ static __always_inline u32 *cpuid_entry_get_reg(struct kvm_cpuid_entry2 *entry,
>  {
>  	const struct cpuid_reg cpuid = x86_feature_cpuid(x86_feature);
>  
> -	return __cpuid_entry_get_reg(entry, &cpuid);
> +	return __cpuid_entry_get_reg(entry, cpuid.reg);
>  }
>  
>  static __always_inline u32 cpuid_entry_get(struct kvm_cpuid_entry2 *entry,
> @@ -189,7 +189,7 @@ static __always_inline u32 *guest_cpuid_get_register(struct kvm_vcpu *vcpu,
>  	if (!entry)
>  		return NULL;
>  
> -	return __cpuid_entry_get_reg(entry, &cpuid);
> +	return __cpuid_entry_get_reg(entry, cpuid.reg);
>  }
>  
>  static __always_inline bool guest_cpuid_has(struct kvm_vcpu *vcpu,
> 

Queued, thanks.

Paolo

