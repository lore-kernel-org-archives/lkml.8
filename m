Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C4EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA672072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 22:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ssJPmRj0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgFJWBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 18:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgFJWBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 18:01:02 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4A4C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:01:02 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id r1so1426780uam.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 15:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nR4rRNMXeXdrkwRNt5QUkb3PmbbCiqg+ykW9gq1PQDY=;
        b=ssJPmRj0DZMvwcNEm4rDMS1iQrTWKQ/CbrV5wUy4HLikCgt2cbVC/HDDuHwX2SXS34
         /J8wRq6CwydELAPYvYcbwrDRsMkJH2cXrp9p8LbG2wwj5rLX6heicwHC01b/RDYnbI2z
         WKvDdthm3zSW/suBOb+OllMNyyy9hLg5GcCuRmXJk2MArnFxKrNjxDQXng6qwvE2OXW3
         M63vgoCWkMbWKpR90U8Uq4o21HJsc/3BYhChAHeC7UpWQYUMofIIBtqHHBbXocUFsmb9
         aq3zx5lovFe4LSrej8YaDa1SAAckaY56q16hkEW5W4g3RTHhk1/l+KXZQ5nSmR2y9Sm4
         Lnig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nR4rRNMXeXdrkwRNt5QUkb3PmbbCiqg+ykW9gq1PQDY=;
        b=jt79zCgNVMQirOwEuzdmHw5pEGuFZb2NVfGWhIZVQZ7eZkm0QpnUL3Rbk43sAJGYqm
         0cLJjEGOHX2YaljAfbgBrbmbN6sY39ByAPdSJD6ufQEKkRJ/NxZ5XJxML5Tz/jxmNwbd
         iX7UJcwLpzgQ5eJTQWj2LFFuVPmPXnK8nr7q5x+YkFvoKsXzGdSvH9ER7vzUNrGlxVfp
         DGQbbVce6BbG17dwWrAmapMeYL7bpLVdBdzzK62Z9UCkCe3/4hsYIGoYOuKuv7t+8q6i
         sVURXYpzn+BM5/7MmHuaPi9z+U4p/mWE5DoYxqaeN762GCeCIMPCoTzeYLyWKY1B6NQs
         OSgA==
X-Gm-Message-State: AOAM533e2eOX2yEaW1o4BFwZPf1Z1WFDv7c1+9y+y5v/YqMtTfoxN4zx
        xpBZ5g4AtWZC/qq1LxBRQxxIl6B4+eenFkd48pTPhA==
X-Google-Smtp-Source: ABdhPJz7I64SKS5NtEWHj0e9pQtJJ4M+FXlIhms8qP48sFrPid4B2AZwfLYjGcLpBA0gvUju57nQ5kEx5xqguip91SM=
X-Received: by 2002:ab0:70c9:: with SMTP id r9mr4204376ual.15.1591826460956;
 Wed, 10 Jun 2020 15:01:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200605213853.14959-1-sean.j.christopherson@intel.com> <20200605213853.14959-17-sean.j.christopherson@intel.com>
In-Reply-To: <20200605213853.14959-17-sean.j.christopherson@intel.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 10 Jun 2020 15:00:47 -0700
Message-ID: <CANgfPd-x=Af6Wdn9Wz=9r5CiHDCbxEgQhS2swALUMQd00oQ3jg@mail.gmail.com>
Subject: Re: [PATCH 16/21] KVM: arm64: Drop @max param from mmu_topup_memory_cache()
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
> Replace the @max param in mmu_topup_memory_cache() and instead use
> ARRAY_SIZE() to terminate the loop to fill the cache.  This removes a
> BUG_ON() and sets the stage for moving arm64 to the common memory cache
> implementation.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/arm64/kvm/mmu.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
> index a1f6bc70c4e4..9398b66f8a87 100644
> --- a/arch/arm64/kvm/mmu.c
> +++ b/arch/arm64/kvm/mmu.c
> @@ -124,15 +124,13 @@ static void stage2_dissolve_pud(struct kvm *kvm, phys_addr_t addr, pud_t *pudp)
>         put_page(virt_to_page(pudp));
>  }
>
> -static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
> -                                 int min, int max)
> +static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache, int min)
>  {
>         void *page;
>
> -       BUG_ON(max > KVM_NR_MEM_OBJS);
KVM_NR_MEM_OBJS should be undefined as of patch 14 in this series. I'd
recommend changing this to use the new constant you defined in that
patch.
>         if (cache->nobjs >= min)
>                 return 0;
> -       while (cache->nobjs < max) {
> +       while (cache->nobjs < ARRAY_SIZE(cache->objects)) {
>                 page = (void *)__get_free_page(GFP_PGTABLE_USER);
>                 if (!page)
>                         return -ENOMEM;
> @@ -1356,8 +1354,7 @@ int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
>                         pte = kvm_s2pte_mkwrite(pte);
>
>                 ret = mmu_topup_memory_cache(&cache,
> -                                            kvm_mmu_cache_min_pages(kvm),
> -                                            KVM_NR_MEM_OBJS);
See above, KVM_NR_MEM_OBJS is undefined as of patch 14.
> +                                            kvm_mmu_cache_min_pages(kvm));
>                 if (ret)
>                         goto out;
>                 spin_lock(&kvm->mmu_lock);
> @@ -1737,8 +1734,7 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
>         up_read(&current->mm->mmap_sem);
>
>         /* We need minimum second+third level pages */
> -       ret = mmu_topup_memory_cache(memcache, kvm_mmu_cache_min_pages(kvm),
> -                                    KVM_NR_MEM_OBJS);
See above, KVM_NR_MEM_OBJS is undefined as of patch 14.
> +       ret = mmu_topup_memory_cache(memcache, kvm_mmu_cache_min_pages(kvm));
>         if (ret)
>                 return ret;
>
> --
> 2.26.0
>
