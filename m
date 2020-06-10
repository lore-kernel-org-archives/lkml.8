Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165C1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:52:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC88A207C3
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gEc2R+rV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729323AbgFJSwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFJSwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:52:49 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A839C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:52:49 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id d22so836629vkf.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ou/05hPwTWsJc4qPHUfA/rNqmKzeeLE9v7tAAiFJL6k=;
        b=gEc2R+rVmIe8RhTsWZBHBO23RbA0tr/u76/Es88LGQ/CPuIjId85GC2NsVm8kMoKgL
         xypuOsx9V+65XCavLo3ndTbi2lygTsd1FRAfHTRZ/ft4YFsvaQVS/90q3h6tRE9n54Mf
         xP6C42BDu/Xvcj+jMurPTuDkG8obmR20jvUI42vHwTjju14b7EiA89IQ+Io3L6jolyt7
         RP98ow/xYCC63pO16c+NjSTt4hjR/4a+L2b7Y5x1LoYmsGXUQEMAl+anxxVhRMjwEbfx
         c6Wfd+JbNHcTCTk0eLPkpkHtk69QBNuyxUainnJ40usnuLbLhv3qVR/McNQMZsJakaY8
         2yBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ou/05hPwTWsJc4qPHUfA/rNqmKzeeLE9v7tAAiFJL6k=;
        b=MBrKPG2tjvTuzbKUEJ9XLyVIC8mFM3VYY7LZYUjxlwKX91mI01qzdAOyRCI7NSGijk
         pH8cOvpXo5SyBOL2CgFsBcWy0ERYEyqB7ZZ5EHbLb8CRZ3KmMFVjs9rWnGBP7wiPzJrH
         9X3ikbMh0lR/+DQUX4LhHYcrVBRaoGJcEQbSOvHHE+h9hqMClaflR+Y06di8ve6cU6tV
         vR7yRX9d2A+Ns+Xk7At1NXWxzJciyPwqmBWj+m++7gGZAKA/hMPF0ihWqkk1auyDwDCq
         pfKt+Ykivq+yMC4ChsRXsggt9d+SvESgUnxMIPL97dTBN1V8QkzXbXi6Htu3SZcW4Oo2
         b38g==
X-Gm-Message-State: AOAM53327ebJB9WQl66hcwCITNWcRGHHhnc3Oqe6rXnD0peaGRTPexGY
        Al/ZdyY8tRgKqZXSOmOu/yVQ/7NoD1G9KRWClcPP/A==
X-Google-Smtp-Source: ABdhPJxdhrcI3GxwX+s2Z6W5dcJTIvbNz9DMjdWBqnMt5wpbMQTIwtRhtuhfggqhbSRYlsDnW4UACO8A1irmUlXnjZ8=
X-Received: by 2002:a05:6122:106f:: with SMTP id k15mr3512065vko.21.1591815167751;
 Wed, 10 Jun 2020 11:52:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200605213853.14959-1-sean.j.christopherson@intel.com> <20200605213853.14959-13-sean.j.christopherson@intel.com>
In-Reply-To: <20200605213853.14959-13-sean.j.christopherson@intel.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 10 Jun 2020 11:52:35 -0700
Message-ID: <CANgfPd9Kjb2QH+K3KwPZBFR3wv33tq7WSX=RoJjJHfkAad5TSg@mail.gmail.com>
Subject: Re: [PATCH 12/21] KVM: x86/mmu: Skip filling the gfn cache for
 guaranteed direct MMU topups
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
> Don't bother filling the gfn array cache when the caller is a fully
> direct MMU, i.e. won't need a gfn array for shadow pages.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c         | 18 ++++++++++--------
>  arch/x86/kvm/mmu/paging_tmpl.h |  4 ++--
>  2 files changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index a8f8eebf67df..8d66cf558f1b 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1101,7 +1101,7 @@ static void mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
>         }
>  }
>
> -static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
> +static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu, bool maybe_indirect)
>  {
>         int r;
>
> @@ -1114,10 +1114,12 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
>                                    PT64_ROOT_MAX_LEVEL);
>         if (r)
>                 return r;
> -       r = mmu_topup_memory_cache(&vcpu->arch.mmu_gfn_array_cache,
> -                                  PT64_ROOT_MAX_LEVEL);
> -       if (r)
> -               return r;
> +       if (maybe_indirect) {
> +               r = mmu_topup_memory_cache(&vcpu->arch.mmu_gfn_array_cache,
> +                                          PT64_ROOT_MAX_LEVEL);
> +               if (r)
> +                       return r;
> +       }
>         return mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache,
>                                       PT64_ROOT_MAX_LEVEL);
>  }
> @@ -4107,7 +4109,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
>         if (fast_page_fault(vcpu, gpa, error_code))
>                 return RET_PF_RETRY;
>
> -       r = mmu_topup_memory_caches(vcpu);
> +       r = mmu_topup_memory_caches(vcpu, false);
>         if (r)
>                 return r;
>
> @@ -5147,7 +5149,7 @@ int kvm_mmu_load(struct kvm_vcpu *vcpu)
>  {
>         int r;
>
> -       r = mmu_topup_memory_caches(vcpu);
> +       r = mmu_topup_memory_caches(vcpu, !vcpu->arch.mmu->direct_map);
>         if (r)
>                 goto out;
>         r = mmu_alloc_roots(vcpu);
> @@ -5341,7 +5343,7 @@ static void kvm_mmu_pte_write(struct kvm_vcpu *vcpu, gpa_t gpa,
>          * or not since pte prefetch is skiped if it does not have
>          * enough objects in the cache.
>          */
> -       mmu_topup_memory_caches(vcpu);
> +       mmu_topup_memory_caches(vcpu, true);
>
>         spin_lock(&vcpu->kvm->mmu_lock);
>
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> index 3de32122f601..ac39710d0594 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -818,7 +818,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
>                 return RET_PF_EMULATE;
>         }
>
> -       r = mmu_topup_memory_caches(vcpu);
> +       r = mmu_topup_memory_caches(vcpu, true);
>         if (r)
>                 return r;
>
> @@ -905,7 +905,7 @@ static void FNAME(invlpg)(struct kvm_vcpu *vcpu, gva_t gva, hpa_t root_hpa)
>          * No need to check return value here, rmap_can_add() can
>          * help us to skip pte prefetch later.
>          */
> -       mmu_topup_memory_caches(vcpu);
> +       mmu_topup_memory_caches(vcpu, true);
>
>         if (!VALID_PAGE(root_hpa)) {
>                 WARN_ON(1);
> --
> 2.26.0
>
