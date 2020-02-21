Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A06C35658
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F56206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:43:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HCAub9j4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgBUPnr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:43:47 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:49219 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728235AbgBUPnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:43:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582299825;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9hFApa4WnwgjLlt8qFRZkEDvrHl4A5ayxF4/D+craX4=;
        b=HCAub9j4uDstyv9fCWG6n2gOo7gINFU1Jpe1efobxH992q9pcbYlpMMopE8lqdU+ua3aAG
        z8bvKuM56wOP2FL2AZZK2zXXeM+06K2f4dQki0eNQvE8F+sgK8HOLQOwTsJuQeF2xOtu7e
        oHOJogMWxfuCbbb+ZoSWzUO8jqNmBgk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-SzTDsVOsMiK86VMsFAasfQ-1; Fri, 21 Feb 2020 10:43:44 -0500
X-MC-Unique: SzTDsVOsMiK86VMsFAasfQ-1
Received: by mail-wm1-f71.google.com with SMTP id p2so734705wma.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:43:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=9hFApa4WnwgjLlt8qFRZkEDvrHl4A5ayxF4/D+craX4=;
        b=OHmbFbhI6BDntxlbVTreWNi+erD8QugIkZ7MlyqG+TRg5S/H0v+d9Z6fyfvC2Yx/qN
         f65FyaU2crGjlHmMvvVNUxbnzXUZsEfmXSKL0CbvJWzlrOZVnG4rg01jqP3Ba7ePrQ+p
         Oc50JNXN9lPGz3CIla940OvIw+M1VKwb1Quvw4XgBZbPhy5/Clt2DikB/++wwpWAnXp0
         gbxtFapuixk5H8aQYN9pO8qJVxUgzxGbxq4pzxur9Dmle+ViaA1SevE2/lgd7HcAr3E7
         2bXt3CElV2FiQq0BOvSk6L0O6w8q3wZrULKEzzAYjTEQ1O0ujiKyxlFH4FIHb99M8WGe
         x7Gw==
X-Gm-Message-State: APjAAAXACv/owaB0to9DGHY74SFk5256QUOyJILIdLR9fa6Y7JBnwfe6
        X14pPdFTU3Ro3td53kAofBNSx5qHK6kdMqtQQJ6A6ftm4YKnixlR82D1YNPtpI2T3/GxQAmu3EN
        +fFM9JI6CmGPqz5CT1aDR/187
X-Received: by 2002:a5d:6646:: with SMTP id f6mr52594216wrw.276.1582299822619;
        Fri, 21 Feb 2020 07:43:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqwgLS/yqhalljwOZqZcOADqCDtfZeqLFsApuyQ44lfuvXa1CFlCcvGehaEzyXxYthKCMSpZ0A==
X-Received: by 2002:a5d:6646:: with SMTP id f6mr52594192wrw.276.1582299822418;
        Fri, 21 Feb 2020 07:43:42 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id x132sm7789284wmg.0.2020.02.21.07.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:43:41 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/61] KVM: x86: Use u32 for holding CPUID register value in helpers
In-Reply-To: <20200201185218.24473-26-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-26-sean.j.christopherson@intel.com>
Date:   Fri, 21 Feb 2020 16:43:41 +0100
Message-ID: <878skwq72q.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Change the intermediate CPUID output register values from "int" to "u32"
> to match both hardware and the storage type in struct cpuid_reg.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index c1ac0995843d..72a79bdfed6b 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -95,7 +95,7 @@ static __always_inline struct cpuid_reg x86_feature_cpuid(unsigned x86_feature)
>  	return reverse_cpuid[x86_leaf];
>  }
>  
> -static __always_inline int *guest_cpuid_get_register(struct kvm_vcpu *vcpu, unsigned x86_feature)
> +static __always_inline u32 *guest_cpuid_get_register(struct kvm_vcpu *vcpu, unsigned x86_feature)
>  {
>  	struct kvm_cpuid_entry2 *entry;
>  	const struct cpuid_reg cpuid = x86_feature_cpuid(x86_feature);
> @@ -121,7 +121,7 @@ static __always_inline int *guest_cpuid_get_register(struct kvm_vcpu *vcpu, unsi
>  
>  static __always_inline bool guest_cpuid_has(struct kvm_vcpu *vcpu, unsigned x86_feature)
>  {
> -	int *reg;
> +	u32 *reg;
>  
>  	reg = guest_cpuid_get_register(vcpu, x86_feature);
>  	if (!reg)
> @@ -132,7 +132,7 @@ static __always_inline bool guest_cpuid_has(struct kvm_vcpu *vcpu, unsigned x86_
>  
>  static __always_inline void guest_cpuid_clear(struct kvm_vcpu *vcpu, unsigned x86_feature)
>  {
> -	int *reg;
> +	u32 *reg;
>  
>  	reg = guest_cpuid_get_register(vcpu, x86_feature);
>  	if (reg)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

