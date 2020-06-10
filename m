Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D706C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91452070B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Uf3Tl88+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgFJStR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbgFJStQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:49:16 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE1FC08C5C2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:49:15 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id t26so1205135ual.13
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0A0qTEHL/4KHt4CSQ8r/67Dw7HuODJhcnw3jBL6/4J0=;
        b=Uf3Tl88+r0ZyuZCQWfWB4PKDaMKAKtTmR6Y9IRa+cZCE9Bel4uJmzIXjeKMF6RESzG
         LfRsF4qIQ0RgpqHmWzJlWqVEBTAqGpfp3uDaBvyS+7FpOH2I5TCz8Aup8cO5pEGd0SCa
         dZZRdSK4u8zEu43fSdct+eOH+fiK8d8XsddBgDh0+mFmO/treg7/Zgl5ppH2zXln/3rm
         aHbacx6sUYuvLvgSVcBokZ6/H9kJZ2LLodZG55RSeTYZ6S48Q6/WxuvmnbLN+rlClHkk
         xZgdZAOd7KqDVNt1dPiM0Ajs/2q3d6Fqn5vfCVRThl9/PLnPIFWioYOR1khnyt7cBCZC
         QdEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0A0qTEHL/4KHt4CSQ8r/67Dw7HuODJhcnw3jBL6/4J0=;
        b=K360zLxU2cqQTCZqbB6EnAah7/G6BM1y8Awm0cN7QcFWMqcgSRtyvIKzmq4zyOPyv/
         7jC1xCJrmUzPPFIHfXkEYsGLKSURq+5SBJTtbAe5+vkAEsmgRNOTPLgJDEle7k2xX6hb
         T6ykkVmZuF0dDJjRS2wFvhz2NTestvaTDxmibvn6xAnyXDgT5JhXPdgfWXuimBe9AHiY
         qgvbiZOrj0BSC/xVNILSk5qymGCdMqcf1bNZfS1PbK4M56E4tFCTdBkb6FWxlUJNnTXa
         Mo7Lnx+ce/wh1/KnmJtzY5AY7NwBYX0EA5tJOPJKRSMmNhNX1qKLFSzxtU7VeHaWiE35
         glZw==
X-Gm-Message-State: AOAM533IxRvBEdJAcM/CRR7ag9UP0QduubehHHTEKQ4UrMNDcPT0oRby
        RpGUEBBov+qBuN+zY2h0jdnYRVCCq5s6gQTIoS9XFg==
X-Google-Smtp-Source: ABdhPJx7n1Jzu9stxSW0B8Z2yESjtTjAbgEsU5PcOtsP0CIqXpGR8ePPHUya13zr/XKYKIv2ps3RYwappcy09FCWcjM=
X-Received: by 2002:ab0:70c9:: with SMTP id r9mr3658814ual.15.1591814953932;
 Wed, 10 Jun 2020 11:49:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200605213853.14959-1-sean.j.christopherson@intel.com> <20200605213853.14959-12-sean.j.christopherson@intel.com>
In-Reply-To: <20200605213853.14959-12-sean.j.christopherson@intel.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 10 Jun 2020 11:49:02 -0700
Message-ID: <CANgfPd9vBbX66RYWhW+Lpsrya8Q4SduDHzpbAhAqRyU3i-gHxA@mail.gmail.com>
Subject: Re: [PATCH 11/21] KVM: x86/mmu: Zero allocate shadow pages (outside
 of mmu_lock)
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Marc Zyngier <maz@kernel.org>, Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Feiner <pfeiner@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 2:39 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Set __GFP_ZERO for the shadow page memory cache and drop the explicit
> clear_page() from kvm_mmu_get_page().  This moves the cost of zeroing a
> page to the allocation time of the physical page, i.e. when topping up
> the memory caches, and thus avoids having to zero out an entire page
> while holding mmu_lock.
>
> Cc: Peter Feiner <pfeiner@google.com>
> Cc: Peter Shier <pshier@google.com>
> Cc: Junaid Shahid <junaids@google.com>
> Cc: Jim Mattson <jmattson@google.com>
> Suggested-by: Ben Gardon <bgardon@google.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 6b0ec9060786..a8f8eebf67df 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2545,7 +2545,6 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>                 if (level > PG_LEVEL_4K && need_sync)
>                         flush |= kvm_sync_pages(vcpu, gfn, &invalid_list);
>         }
> -       clear_page(sp->spt);
>         trace_kvm_mmu_get_page(sp, true);
>
>         kvm_mmu_flush_or_zap(vcpu, &invalid_list, false, flush);
> @@ -5687,6 +5686,8 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
>         vcpu->arch.mmu_page_header_cache.kmem_cache = mmu_page_header_cache;
>         vcpu->arch.mmu_page_header_cache.gfp_zero = __GFP_ZERO;
>
> +       vcpu->arch.mmu_shadow_page_cache.gfp_zero = __GFP_ZERO;
> +
>         vcpu->arch.mmu = &vcpu->arch.root_mmu;
>         vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
>
> --
> 2.26.0
>
