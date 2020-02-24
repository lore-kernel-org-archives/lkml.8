Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A42ACC38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75A1C2084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVVt0vqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727896AbgBXWIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:08:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50513 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726687AbgBXWIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582582116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yiv6p60zYp+Qyy2Kc45wJ/cRh4L2UEHjFJ31xKlgI6M=;
        b=PVVt0vqqzAiL2cemQYd4yy1r3caITD0pJG9WuML306yupl1FpeZXDswKPKkbuKbBiMzpFq
        BzDGQmsAzM3FpuCx2Ts156jIdo0cur3Xw6hDRYq4dOIETj7a49vzamr6G+AnJ77713oRQ6
        9ec0eJx9EnlW6ulzX+TCnQW7eTCRxwc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-n70fpvRuPk2rXBZpjgBdzA-1; Mon, 24 Feb 2020 17:08:34 -0500
X-MC-Unique: n70fpvRuPk2rXBZpjgBdzA-1
Received: by mail-wr1-f71.google.com with SMTP id n23so6243477wra.20
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 14:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yiv6p60zYp+Qyy2Kc45wJ/cRh4L2UEHjFJ31xKlgI6M=;
        b=rPUj6OD7uu+cAymiPOMXdyJ1Z0YJegtuyDWoolkcA2RlGotAUvdX2TKiZafCyDfMnY
         jlC1pJ8he40zzZHV1L01b/F7GQ0gPWcngyaLchJjqffe3h1HJ1dBWtZJP1pwhLbTOHJN
         n/uZWzPQDSsmB/4wC1bBfQ5K3+kylSh6k41g72Vv7AK4VEqxrLMEPR0VeSceb/LrPpBz
         SdqcFKT6feEl2MYXBqfIbGHwGyY6Yc96cI/AUb5frTnGR5gUM2Bzsn9iudZ6gxO6UUtV
         iRJQcmCYf4gkF4kA+qeMq6l7+l6eh6BhLcjw8pFKpfxBAt/mNuIFKsD1aqongGmsZVck
         YtXw==
X-Gm-Message-State: APjAAAUsVZDUN9roK8UZtNfkQvBAGiwCQyBN/1YMPwC146vGcMkZbQGG
        yrTEo7DhC2AtSSWLYTltd2u0T4cJ2b9+qFrhUNTHKL8ul0/E0XFairvWsDK5wk3DFJSaDPMD+q6
        k8Zi0DTRZPqxUBBaOCCiG093V
X-Received: by 2002:a5d:6406:: with SMTP id z6mr68381189wru.294.1582582112741;
        Mon, 24 Feb 2020 14:08:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqzfFk7h1ch3NYlC+Q8VgeC+gtxfRrR33906xmlvcXnnYg09j3WXEMEzqudyeX8MUceimK3BTg==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr68381172wru.294.1582582112451;
        Mon, 24 Feb 2020 14:08:32 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id m68sm1081837wme.48.2020.02.24.14.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:08:31 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 43/61] KVM: x86: Use KVM cpu caps to mark CR4.LA57 as not-reserved
In-Reply-To: <20200201185218.24473-44-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-44-sean.j.christopherson@intel.com>
Date:   Mon, 24 Feb 2020 23:08:30 +0100
Message-ID: <8736azocyp.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Add accessor(s) for KVM cpu caps and use said accessor to detect
> hardware support for LA57 instead of manually querying CPUID.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.h | 13 +++++++++++++
>  arch/x86/kvm/x86.c   |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index 7b71ae0ca05e..5ce4219d465f 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -274,6 +274,19 @@ static __always_inline void kvm_cpu_cap_set(unsigned x86_feature)
>  	kvm_cpu_caps[x86_leaf] |= __feature_bit(x86_feature);
>  }
>  
> +static __always_inline u32 kvm_cpu_cap_get(unsigned x86_feature)
> +{
> +	unsigned x86_leaf = x86_feature / 32;
> +
> +	reverse_cpuid_check(x86_leaf);
> +	return kvm_cpu_caps[x86_leaf] & __feature_bit(x86_feature);
> +}
> +
> +static __always_inline bool kvm_cpu_cap_has(unsigned x86_feature)
> +{
> +	return kvm_cpu_cap_get(x86_feature);
> +}

I know this works (and I even checked C99 to make sure that it works not
by accident) but I have to admit that explicit '!!' conversion to bool
always makes me feel safer :-)

> +
>  static __always_inline void kvm_cpu_cap_check_and_set(unsigned x86_feature)
>  {
>  	if (boot_cpu_has(x86_feature))
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c5ed199d6cd9..cb40737187a1 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -912,7 +912,7 @@ static u64 kvm_host_cr4_reserved_bits(struct cpuinfo_x86 *c)
>  {
>  	u64 reserved_bits = __cr4_reserved_bits(cpu_has, c);
>  
> -	if (cpuid_ecx(0x7) & feature_bit(LA57))
> +	if (kvm_cpu_cap_has(X86_FEATURE_LA57))
>  		reserved_bits &= ~X86_CR4_LA57;
>  
>  	if (kvm_x86_ops->umip_emulated())

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

