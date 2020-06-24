Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6F9C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F08472078E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 18:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NIvLFzPd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405368AbgFXSDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 14:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405002AbgFXSDp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 14:03:45 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22129C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:03:45 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id 190so1913273vsr.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 11:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1afIoMWdCnvusBXYOP0bLDijIEbS3RXa7POt+hB0Fw4=;
        b=NIvLFzPdL7brFmgZZkBrbdWRKXdLJFpTc5UrQsQv36JzAjt5rgikCgbvE3QMUKnGnE
         XmscnvcyB6kOBbwAB9EM3UKYCChDSNkbHupnPDtPxvQl4G9Pkjeos5Bm8DytaGshVhkI
         Wo0SjMea+tb5BRtArI4g7vOejKn3Bk1LWCfvYE35MNxDHJcERtqloa5n2CZ1SrIIx8bm
         YK/AkO1/4Hy6i2WGMLXiglHFykEwg6EQOGtIIgxX031RuNUNxq2xMB2ksEDoenn8Y8bU
         iD9NiUMhdvwEe//mgBzdOdNd/Ms7sdzY4jUCZ6n8jQuF1Ki0JZ+lDgl+XLDRN7uvlvHF
         RwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1afIoMWdCnvusBXYOP0bLDijIEbS3RXa7POt+hB0Fw4=;
        b=rRhJy1z5GDUTmA1gaxSrPEJgBoXGtq6FZYZaG2/gDJPSrj8Y9U8oo4jcG5r8KglzVp
         14VnTRjOwjGJ9YC7l9libfneRs46F81J5MMtQl88V7KIF5mwiRy+LLa2U6q8bf+XluoM
         ywkmL+of8C6RqRhodwaP5mLd5E0DiNZ4tsCx44TL4fc6YK3CpMit0fMblg/gHj40/cLx
         ch+tOQ8D3TJxCGSFH9PJGFng58BqcX+96E++DJddhubITYh6WglM2TADl5vkXF1jFydd
         YNI0vOLWxKj9pdRRJST2wKbSpUPJxoPjlzFfNtN89od+5cewfVIN3l3vOdYr4ugG0OWV
         PWwQ==
X-Gm-Message-State: AOAM530X5Ai48FVYkRYoyNOPvApeUi/B5FHEnFnrXFGPWthAnsVyK/NO
        HVauaX576dAdDENdTLHu+eAcE6saOG4M3Iwtv6wWLQ==
X-Google-Smtp-Source: ABdhPJyROW49kmTunW4kDbGXG/w9lVbn8C5Y1zvlBdo1nQXevJIjGNe/9OCUS4ZCNkHdvkWYXzv5+RUYU0APu1AbpCE=
X-Received: by 2002:a67:f785:: with SMTP id j5mr2788080vso.17.1593021823822;
 Wed, 24 Jun 2020 11:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200622200822.4426-1-sean.j.christopherson@intel.com> <20200622200822.4426-6-sean.j.christopherson@intel.com>
In-Reply-To: <20200622200822.4426-6-sean.j.christopherson@intel.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 24 Jun 2020 11:03:32 -0700
Message-ID: <CANgfPd8gYX1Fm1vEcfnEBXn_MjRxLHdgQAS=TAHQiOMNMrhFGA@mail.gmail.com>
Subject: Re: [PATCH v2 05/21] KVM: x86/mmu: Try to avoid crashing KVM if a MMU
 memory cache is empty
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Marc Zyngier <maz@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Feiner <pfeiner@google.com>,
        Peter Shier <pshier@google.com>,
        Junaid Shahid <junaids@google.com>,
        Christoffer Dall <christoffer.dall@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 1:09 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Attempt to allocate a new object instead of crashing KVM (and likely the
> kernel) if a memory cache is unexpectedly empty.  Use GFP_ATOMIC for the
> allocation as the caches are used while holding mmu_lock.  The immediate
> BUG_ON() makes the code unnecessarily explosive and led to confusing
> minimums being used in the past, e.g. allocating 4 objects where 1 would
> suffice.
>
Reviewed-by: Ben Gardon <bgardon@google.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 21 +++++++++++++++------
>  1 file changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index ba70de24a5b0..5e773564ab20 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1060,6 +1060,15 @@ static void walk_shadow_page_lockless_end(struct kvm_vcpu *vcpu)
>         local_irq_enable();
>  }
>
> +static inline void *mmu_memory_cache_alloc_obj(struct kvm_mmu_memory_cache *mc,
> +                                              gfp_t gfp_flags)
> +{
> +       if (mc->kmem_cache)
> +               return kmem_cache_zalloc(mc->kmem_cache, gfp_flags);
> +       else
> +               return (void *)__get_free_page(gfp_flags);
> +}
> +
>  static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min)
>  {
>         void *obj;
> @@ -1067,10 +1076,7 @@ static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *mc, int min)
>         if (mc->nobjs >= min)
>                 return 0;
>         while (mc->nobjs < ARRAY_SIZE(mc->objects)) {
> -               if (mc->kmem_cache)
> -                       obj = kmem_cache_zalloc(mc->kmem_cache, GFP_KERNEL_ACCOUNT);
> -               else
> -                       obj = (void *)__get_free_page(GFP_KERNEL_ACCOUNT);
> +               obj = mmu_memory_cache_alloc_obj(mc, GFP_KERNEL_ACCOUNT);
>                 if (!obj)
>                         return mc->nobjs >= min ? 0 : -ENOMEM;
>                 mc->objects[mc->nobjs++] = obj;
> @@ -1118,8 +1124,11 @@ static void *mmu_memory_cache_alloc(struct kvm_mmu_memory_cache *mc)
>  {
>         void *p;
>
> -       BUG_ON(!mc->nobjs);
> -       p = mc->objects[--mc->nobjs];
> +       if (WARN_ON(!mc->nobjs))
> +               p = mmu_memory_cache_alloc_obj(mc, GFP_ATOMIC | __GFP_ACCOUNT);
> +       else
> +               p = mc->objects[--mc->nobjs];
> +       BUG_ON(!p);
>         return p;
>  }
>
> --
> 2.26.0
>
