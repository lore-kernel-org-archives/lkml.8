Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7981EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533B5206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FyAfw76h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbgFIWyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgFIWyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:54:16 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5020FC08C5C3
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 15:54:16 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id k13so95938vsm.13
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 15:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uselWGWC3qoQQOxqWlrwlyYH4mqd92kQlOeG7RAljPU=;
        b=FyAfw76hywaz53lg/VPnGi9e8IgE5jPMksWxgn5Xkbqe/yhjElKv8fMDCl4QFtXQIt
         pSyJYqrnMJYgTyWBELqlUZa5CVrDBu1huuKU9dWbO6W+XR2+iweBUHxOBj0i2RvfGdFs
         8NiNQVMybZaYdmRyiKjkdD25LAg7GOjVAE2ahVKfo1TFfOTPVhQxv3vrhhJB1ZZYju2x
         Sdae+oKvdyfhBYlT1ObztTGi8b7ZlawE8tQkILK8OymFeQLH+QUknrl0lziOECLhGpgE
         9Z2h7cuvDa588K6R2CH8Tk7KwRtyK4jUdgDpy+UOvR8NULevc8eRomSXClkk9nY8gFC8
         7ASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uselWGWC3qoQQOxqWlrwlyYH4mqd92kQlOeG7RAljPU=;
        b=Iw5HD7YfLOBOM8+KE3r2B+wzRxBsgtx/N+e7mwZdOiNZa0BAMWMjcALvZyNeLODW+Z
         b+nC7gpCPgdvOnU3j8vriloqZ2EIj7lZkAK1oicAY0u1anYVSGmMpwOQUa3/f/qx5O8M
         DNn+X2DJApmcADb7nkikMP/rwuDl8mvfTuArFC0bSlkJacEoQxbIz1Ucye5/66ymHoX7
         6GSJ53iKGcv+qAkmO8xEac1GGP3pwhUe2j+bk9oEbQMSuHMFjnfbDlbhlSYrMQGtV+u/
         Hok30y71edI3snTnfIsok4fVubi+o9kvVpaJ9IIJwOH6+VmYYiFbZIdMF0O6//0JDGx0
         FagQ==
X-Gm-Message-State: AOAM533KiFkGDweANzTrs1JdQhpa0F+iuqtEZtJdDqe5CDuV17uqcULb
        fpIFuP4oyJBFGEn9E+TmmoxBeyGVATJZo2UFGhsQoA==
X-Google-Smtp-Source: ABdhPJx3dLS9VTThWqaFRDlqN1S9f5h0OrZVTBbY5/ftQgTD5GsCLfsUQ7mDqtAcQKwPK2rVrq3OTLOUBty+qRmGSEY=
X-Received: by 2002:a67:af10:: with SMTP id v16mr448564vsl.235.1591743255002;
 Tue, 09 Jun 2020 15:54:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200605213853.14959-1-sean.j.christopherson@intel.com> <20200605213853.14959-3-sean.j.christopherson@intel.com>
In-Reply-To: <20200605213853.14959-3-sean.j.christopherson@intel.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Tue, 9 Jun 2020 15:54:04 -0700
Message-ID: <CANgfPd-hDAUe188X4HNt7bQ=5_RxtOmpnEet3C3CwpJPxi4y4Q@mail.gmail.com>
Subject: Re: [PATCH 02/21] KVM: x86/mmu: Consolidate "page" variant of memory
 cache helpers
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
> Drop the "page" variants of the topup/free memory cache helpers, using
> the existence of an associated kmem_cache to select the correct alloc
> or free routine.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> Reviewed-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 37 +++++++++++--------------------------
>  1 file changed, 11 insertions(+), 26 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 0830c195c9ed..cbc101663a89 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1067,7 +1067,10 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache, int min)
>         if (cache->nobjs >= min)
>                 return 0;
>         while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
> -               obj = kmem_cache_zalloc(cache->kmem_cache, GFP_KERNEL_ACCOUNT);
> +               if (cache->kmem_cache)
> +                       obj = kmem_cache_zalloc(cache->kmem_cache, GFP_KERNEL_ACCOUNT);
> +               else
> +                       obj = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
>                 if (!obj)
>                         return cache->nobjs >= min ? 0 : -ENOMEM;
>                 cache->objects[cache->nobjs++] = obj;
> @@ -1082,30 +1085,12 @@ static int mmu_memory_cache_free_objects(struct kvm_mmu_memory_cache *cache)
>
>  static void mmu_free_memory_cache(struct kvm_mmu_memory_cache *mc)
>  {
> -       while (mc->nobjs)
> -               kmem_cache_free(mc->kmem_cache, mc->objects[--mc->nobjs]);
> -}
> -
> -static int mmu_topup_memory_cache_page(struct kvm_mmu_memory_cache *cache,
> -                                      int min)
> -{
> -       void *page;
> -
> -       if (cache->nobjs >= min)
> -               return 0;
> -       while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
> -               page = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
> -               if (!page)
> -                       return cache->nobjs >= min ? 0 : -ENOMEM;
> -               cache->objects[cache->nobjs++] = page;
> +       while (mc->nobjs) {
> +               if (mc->kmem_cache)
> +                       kmem_cache_free(mc->kmem_cache, mc->objects[--mc->nobjs]);
> +               else
> +                       free_page((unsigned long)mc->objects[--mc->nobjs]);
>         }
> -       return 0;
> -}
> -
> -static void mmu_free_memory_cache_page(struct kvm_mmu_memory_cache *mc)
> -{
> -       while (mc->nobjs)
> -               free_page((unsigned long)mc->objects[--mc->nobjs]);
>  }
>
>  static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
> @@ -1116,7 +1101,7 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
>                                    8 + PTE_PREFETCH_NUM);
>         if (r)
>                 goto out;
> -       r = mmu_topup_memory_cache_page(&vcpu->arch.mmu_page_cache, 8);
> +       r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_cache, 8);
>         if (r)
>                 goto out;
>         r = mmu_topup_memory_cache(&vcpu->arch.mmu_page_header_cache, 4);
> @@ -1127,7 +1112,7 @@ static int mmu_topup_memory_caches(struct kvm_vcpu *vcpu)
>  static void mmu_free_memory_caches(struct kvm_vcpu *vcpu)
>  {
>         mmu_free_memory_cache(&vcpu->arch.mmu_pte_list_desc_cache);
> -       mmu_free_memory_cache_page(&vcpu->arch.mmu_page_cache);
> +       mmu_free_memory_cache(&vcpu->arch.mmu_page_cache);
>         mmu_free_memory_cache(&vcpu->arch.mmu_page_header_cache);
>  }
>
> --
> 2.26.0
>
