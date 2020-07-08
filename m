Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147BDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D7120720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PNQXh8fq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729612AbgGHOGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:06:24 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50542 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729493AbgGHOGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:06:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594217182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1QdAfsz6hOzCxXEuoKjy0120IGcwZSXG6p/fqOOsy0=;
        b=PNQXh8fq9s5hvQtKPw9D1nvpUvZNNn2fwvMn6Pl1Y2AjVfYwlC1qkiDHuNw1acMVhuQw5H
        No9CDfhDM1hTg/bajKNq8xVa2O5yKasJr3FX87Hq3kNLQ/V+xcgA8UgxLhMLFqTlrqjMhr
        Zipw5ytqqSK4ZucejiWJUn1qLdrX6yg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-F92jRHhyPVeLB_pmFMEnyA-1; Wed, 08 Jul 2020 10:06:12 -0400
X-MC-Unique: F92jRHhyPVeLB_pmFMEnyA-1
Received: by mail-wm1-f72.google.com with SMTP id b13so3070413wme.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 07:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g1QdAfsz6hOzCxXEuoKjy0120IGcwZSXG6p/fqOOsy0=;
        b=pjyfgldsNspsajcZcs0ZL/nh8yuruyIjhrEILphRhlRp7hFN6o0tJOye0RHLEQ7eAD
         Ias2rp6PRdbww7VNoTwtApZwyT39qwuhWoVgpgrsRQuQNI9kcjuEL0MXaA5MPCCICtlJ
         o6hcAiUnuQkmQiGMxjSLAoMrjjypl9sArvxxdKEQacpJv0cLB5ROM/bxc/4bV+AVnUop
         WndxzlKlb+gcGFia6D7H8I+xT9hVDxWNfzED3n4AhMqD5/SZoppRROPcoSxvw/V7ycjg
         9/thGKtcShiXG/u/8zF6jHYKDES5TUJbQ4gAvDnUYH00A/5ijJgWvKmDMEjqWYicCBYL
         Fqog==
X-Gm-Message-State: AOAM531l0CMRNWpO/GLxI3y+olkLV/xrlNx+6fwMsqWhVW9OtpMH4KtT
        XTJu7Be6B8nCyAH0UgUGwxW33WyrKXiNauCORpNEsoPWpBIriDCgcY4J4xIgIVHqH5sRAILue2V
        xAvMdq7c+xtviiv6Zp+siio7T
X-Received: by 2002:adf:828b:: with SMTP id 11mr63226497wrc.58.1594217170529;
        Wed, 08 Jul 2020 07:06:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb8D5gvP4RQNaXaJPCmtCzy9nqbwuEvAH6/tWvVOah83zyfRByzJN1GRzgbS9vv8tsP5Y4oA==
X-Received: by 2002:adf:828b:: with SMTP id 11mr63226478wrc.58.1594217170288;
        Wed, 08 Jul 2020 07:06:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id c20sm40034wrb.65.2020.07.08.07.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 07:06:09 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: take as_id into account when checking PGD
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20200708140023.1476020-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <88e517df-0887-2687-b3db-0892ac479211@redhat.com>
Date:   Wed, 8 Jul 2020 16:06:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200708140023.1476020-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/07/20 16:00, Vitaly Kuznetsov wrote:
> OVMF booted guest running on shadow pages crashes on TRIPLE FAULT after
> enabling paging from SMM. The crash is triggered from mmu_check_root() and
> is caused by kvm_is_visible_gfn() searching through memslots with as_id = 0
> while vCPU may be in a different context (address space).
> 
> Introduce kvm_vcpu_is_visible_gfn() and use it from mmu_check_root().
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/mmu/mmu.c   | 2 +-
>  include/linux/kvm_host.h | 1 +
>  virt/kvm/kvm_main.c      | 8 ++++++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 4fd4b5de8996..309024210a35 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3668,7 +3668,7 @@ static int mmu_check_root(struct kvm_vcpu *vcpu, gfn_t root_gfn)
>  {
>  	int ret = 0;
>  
> -	if (!kvm_is_visible_gfn(vcpu->kvm, root_gfn)) {
> +	if (!kvm_vcpu_is_visible_gfn(vcpu, root_gfn)) {
>  		kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
>  		ret = 1;
>  	}
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index d564855243d8..f74d2a5afc26 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -774,6 +774,7 @@ int kvm_clear_guest_page(struct kvm *kvm, gfn_t gfn, int offset, int len);
>  int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len);
>  struct kvm_memory_slot *gfn_to_memslot(struct kvm *kvm, gfn_t gfn);
>  bool kvm_is_visible_gfn(struct kvm *kvm, gfn_t gfn);
> +bool kvm_vcpu_is_visible_gfn(struct kvm_vcpu *vcpu, gfn_t gfn);
>  unsigned long kvm_host_page_size(struct kvm_vcpu *vcpu, gfn_t gfn);
>  void mark_page_dirty(struct kvm *kvm, gfn_t gfn);
>  
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index a852af5c3214..b131c7da1d12 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -1626,6 +1626,14 @@ bool kvm_is_visible_gfn(struct kvm *kvm, gfn_t gfn)
>  }
>  EXPORT_SYMBOL_GPL(kvm_is_visible_gfn);
>  
> +bool kvm_vcpu_is_visible_gfn(struct kvm_vcpu *vcpu, gfn_t gfn)
> +{
> +	struct kvm_memory_slot *memslot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
> +
> +	return kvm_is_visible_memslot(memslot);
> +}
> +EXPORT_SYMBOL_GPL(kvm_vcpu_is_visible_gfn);
> +
>  unsigned long kvm_host_page_size(struct kvm_vcpu *vcpu, gfn_t gfn)
>  {
>  	struct vm_area_struct *vma;
> 

Queued, thanks.

Paolo

