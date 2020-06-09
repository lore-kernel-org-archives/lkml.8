Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D58C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E671720725
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 23:56:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLpRcLXq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgFIX42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 19:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgFIX40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 19:56:26 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7958FC08C5C2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 16:56:26 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id r1so233899uam.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 16:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4sxWZx3UI6VKLDq8Qy1UYUg5vtAHPMsTevThfv39TWA=;
        b=WLpRcLXqwdVOvuMgwWkmR8Gr4lwaHRK/EF6daq2IMeFXYgWSJrphnkQvLEH+41LO0x
         pBkEeJfVAEq/uryeN4HHM4Hb3NfdIqrrZcULOeMuMtGfZEKTK0JPggE4ybLNYEuiV0pp
         hiSCdaRlAd+ayR3yLwkLqaPFRVUUau1KjcEyNNFF5lmfQTLhnmvgVGyA1JJV3qaW45Fh
         jEN3gjAjfZpQCTtGPfowcu+cTV09P9OWMskURcxzz2UEuwU2bgMY7NSPvwSFJYRc6/bv
         5cAINv0x9snM9p3flSgBPUFTJrC9TtnEnQ07K+dBbcgAeuIsCrM4zFy5fBTuIldM5yBs
         xNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4sxWZx3UI6VKLDq8Qy1UYUg5vtAHPMsTevThfv39TWA=;
        b=YnwcUPRQTE6DCjFiva3z0UbvDiMUT/K7kBQ07qf49ERpLJ5RikYoZTJcenQyYTde9i
         wlVYgp7mWAaZWrhyehYnThmOGaGH+QhM7TLWtXab18ORlUS4tLMUzkArtyThVW/A3hol
         LOrX5PVDXEQiyKj20/Z3grYJMFyO9f04ehe28wOJgCOqGt6bhf95/ViabC4sb8eDsohR
         aW3TmMpBOJp2kJSkCsjsesWnkJRBq1FUvQUn1IIa5oZPNlOwKHlr4iep8JBWJy+hKL2B
         bnN92enEaNhDC6DfW7Gnawni6PZ7rO9HtaKRgC5LWHVEPkrOlRT5k7HfaKAVZ1p6EaGl
         CnwA==
X-Gm-Message-State: AOAM533DZvL9FJGsCWwOfbFrgq9deMx8/44A/T0bhnoXIBmQbz2E8Tx0
        aqspIOtSJtbkoyX02JTHbFLX8CUOPyiU0Vcwd7uTSQ==
X-Google-Smtp-Source: ABdhPJyXAGLXljdkHhgQRDD2Vm3KO3b89VigddFLuju4QbS8KbKbayXYphsX76+lBqoc+5yPzGQnUDz7icYaQgNy+rs=
X-Received: by 2002:ab0:6012:: with SMTP id j18mr679163ual.69.1591746985111;
 Tue, 09 Jun 2020 16:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200605213853.14959-1-sean.j.christopherson@intel.com> <20200605213853.14959-10-sean.j.christopherson@intel.com>
In-Reply-To: <20200605213853.14959-10-sean.j.christopherson@intel.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 9 Jun 2020 16:56:13 -0700
Message-ID: <CANgfPd_ftZ_fC0EEt=1nOoyc6Yi6Xo3TB4woY=tkHzXbjHk4aA@mail.gmail.com>
Subject: Re: [PATCH 09/21] KVM: x86/mmu: Separate the memory caches for shadow
 pages and gfn arrays
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
> Use separate caches for allocating shadow pages versus gfn arrays.  This
> sets the stage for specifying __GFP_ZERO when allocating shadow pages
> without incurring extra cost for gfn arrays.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  3 ++-
>  arch/x86/kvm/mmu/mmu.c          | 15 ++++++++++-----
>  2 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 16347b050754..e7a427547557 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -636,7 +636,8 @@ struct kvm_vcpu_arch {
>         struct kvm_mmu *walk_mmu;
>
>         struct kvm_mmu_memory_cache mmu_pte_list_desc_cache;
> -       struct kvm_mmu_memory_cache mmu_page_cache;
> +       struct kvm_mmu_memory_cache mmu_shadow_page_cache;
> +       struct kvm_mmu_memory_cache mmu_gfn_array_cache;
>         struct kvm_mmu_memory_cache mmu_page_header_cache;
>
>         /*
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 451e0365e5dd..d245acece3cd 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1108,8 +1108,12 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
>                                    1 + PT64_ROOT_MAX_LEVEL + PTE_PREFETCH_NUM);
>         if (r)
>                 return r;
> -       r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_cache,
> -                                  2 * PT64_ROOT_MAX_LEVEL);
> +       r = mmu_topup_memory_cache(&vcpu->arch.mmu_shadow_page_cache,
> +                                  PT64_ROOT_MAX_LEVEL);
> +       if (r)
> +               return r;
> +       r = mmu_topup_memory_cache(&vcpu->arch.mmu_gfn_array_cache,
> +                                  PT64_ROOT_MAX_LEVEL);
>         if (r)
>                 return r;
>         return mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache,
> @@ -1119,7 +1123,8 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
>  static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
>  {
>         mmu_free_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache);
> -       mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
> +       mmu_free_memory_cache(&vcpu->arch.mmu_shadow_page_cache);
> +       mmu_free_memory_cache(&vcpu->arch.mmu_gfn_array_cache);
>         mmu_free_memory_cache(&vcpu->arch.mmu_page_header_cache);
>  }
>
> @@ -2096,9 +2101,9 @@ static struct kvm_mmu_page *kvm_mmu_alloc_page(struct kvm_vcpu *vcpu, int direct
>         struct kvm_mmu_page *sp;
>
>         sp = mmu_memory_cache_alloc(&vcpu->arch.mmu_page_header_cache);
> -       sp->spt = mmu_memory_cache_alloc(&vcpu->arch.mmu_page_cache);
> +       sp->spt = mmu_memory_cache_alloc(&vcpu->arch.mmu_shadow_page_cache);
>         if (!direct)
> -               sp->gfns = mmu_memory_cache_alloc(&vcpu->arch.mmu_page_cache);
> +               sp->gfns = mmu_memory_cache_alloc(&vcpu->arch.mmu_gfn_array_cache);
>         set_page_private(virt_to_page(sp->spt), (unsigned long)sp);
>
>         /*
> --
> 2.26.0
>
