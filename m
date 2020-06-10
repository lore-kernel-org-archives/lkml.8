Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B797C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:57:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE9D2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 18:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sk96oRFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgFJS5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 14:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgFJS5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 14:57:44 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1980C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:57:44 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id b10so1245340uaf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 11:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vVAD935vzmk+zCqhrKriBW6qDeJ9UbWhrYXMFyoDNbk=;
        b=Sk96oRFzgKSljVnt+6mnQTGDFRR0sIInBe9XAnfxFeWo07PzQGUesvjTrqS2UETGbw
         33JxIrEdcR+6sHmE/xgF9BdVMMrsqGaNijoxzDMr0BORvnpqMlkboWl1jjWyay1ys7QO
         8bpz6ZhJVssu9zvLNYu2RNYv8V5b1aDXEFpmiTlxEmWvOQJ5IbaCgyZIBROKMbu9R0Ts
         Q+V8y6LeyXVnKp3TlABf8aS4jdt3me7MPjKJum7oyVYTDbJvsXQXN3qWMLzNS+UjFXec
         Q9ZEwZtxWUmmCPNxf8lT36jJYD1cIcpvnyeN9ijj5+wpG8wuuX1kDrzho+WryA2ZSCwZ
         pqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vVAD935vzmk+zCqhrKriBW6qDeJ9UbWhrYXMFyoDNbk=;
        b=CumNnE6lqU4fn/9Cr1V835OSVVDer85a2xRxiCJYUQrhYu9nRWeesC4HLVn/GcLl8U
         2/1LYyqoWteQ6/OsFRMo26kJzJaHXB+Fdt8s17ajTsZiqloQy3nPZwQktrPdjkoAviyc
         gNrHSpXW5ipcP1Z94tl9zMa4SLP59ugxdREmB/cnj9CqtWD2SpBGbgnOop1npShHi4r0
         CwoLiOii4FotS1ur0GlSVpg7lOxhxPWK4S7Vh59ET32e4DrKDijqB59blph+YJvFgKX3
         ara3/520dC/z6MRPVBwH9KtGbfdE2kwY4e+doPiD0HcaWVxIkuFBMNlVpdEu7EC4VN0o
         szug==
X-Gm-Message-State: AOAM532Nvm1RtXa8UZsomZb7v87f4RlY7kwMkyXvMHud2+6svVpfgZTr
        AgrJOFMaurfQYQiY/sTF0vhRfYiOBXyf+lHzoe6mXA==
X-Google-Smtp-Source: ABdhPJwqVgX0Mxv8PTZWgFn/z7rA1Vsp5KXwbMJOCDIJ24b73HyTMCwRupwGMFcz8Y6tomohXhbM0jt7mBqkr2VcMvI=
X-Received: by 2002:ab0:70c9:: with SMTP id r9mr3681310ual.15.1591815463735;
 Wed, 10 Jun 2020 11:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200605213853.14959-1-sean.j.christopherson@intel.com> <20200605213853.14959-11-sean.j.christopherson@intel.com>
In-Reply-To: <20200605213853.14959-11-sean.j.christopherson@intel.com>
From:   Ben Gardon <bgardon@google.com>
Date:   Wed, 10 Jun 2020 11:57:32 -0700
Message-ID: <CANgfPd9_BR_2NThfEs8faDxWeooZ6OeF2HAB5mUmted5sHwDPg@mail.gmail.com>
Subject: Re: [PATCH 10/21] KVM: x86/mmu: Make __GFP_ZERO a property of the
 memory cache
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
> Add a gfp_zero flag to 'struct kvm_mmu_memory_cache' and use it to
> control __GFP_ZERO instead of hardcoding a call to kmem_cache_zalloc().
> A future patch needs such a flag for the __get_free_page() path, as
> gfn arrays do not need/want the allocator to zero the memory.  Convert
> the kmem_cache paths to __GFP_ZERO now so as to avoid a weird and
> inconsistent API in the future.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 1 +
>  arch/x86/kvm/mmu/mmu.c          | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index e7a427547557..fb99e6776e27 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -251,6 +251,7 @@ struct kvm_kernel_irq_routing_entry;
>   */
>  struct kvm_mmu_memory_cache {
>         int nobjs;
> +       gfp_t gfp_zero;
This would make more sense to me if it could be used for general extra
gfp flags and was called gfp_flags or something, or it was a boolean
that was later translated into the flag being set. Storing the
gfp_zero flag here is a little counter-intuitive. Probably not worth
changing unless you're sending out a v2 for some other reason.

>         struct kmem_cache *kmem_cache;
>         void *objects[KVM_NR_MEM_OBJS];
>  };
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index d245acece3cd..6b0ec9060786 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -1063,8 +1063,10 @@ static void walk_shadow_page_lockless_end(struct kvm_vcpu *vcpu)
>  static inline void *mmu_memory_cache_alloc_obj(struct kvm_mmu_memory_cache *mc,
>                                                gfp_t gfp_flags)
>  {
> +       gfp_flags |= mc->gfp_zero;
> +
>         if (mc->kmem_cache)
> -               return kmem_cache_zalloc(mc->kmem_cache, gfp_flags);
> +               return kmem_cache_alloc(mc->kmem_cache, gfp_flags);
>         else
>                 return (void *)__get_free_page(gfp_flags);
>  }
> @@ -5680,7 +5682,10 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
>         int ret;
>
>         vcpu->arch.mmu_pte_list_desc_cache.kmem_cache = pte_list_desc_cache;
> +       vcpu->arch.mmu_pte_list_desc_cache.gfp_zero = __GFP_ZERO;
> +
>         vcpu->arch.mmu_page_header_cache.kmem_cache = mmu_page_header_cache;
> +       vcpu->arch.mmu_page_header_cache.gfp_zero = __GFP_ZERO;
>
>         vcpu->arch.mmu = &vcpu->arch.root_mmu;
>         vcpu->arch.walk_mmu = &vcpu->arch.root_mmu;
> --
> 2.26.0
>
