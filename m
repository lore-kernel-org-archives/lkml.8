Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559FEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A0D2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 22:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NkvpzUvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgHSWtr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 18:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgHSWtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 18:49:46 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C14C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 15:49:46 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id q9so20416865oth.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 15:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ds+P+VHRELlOlxwCcpje+JSh+rcyjYH+UGSM76wH/9E=;
        b=NkvpzUvyGrJIQ6ExDre3XeXzkd5E3jCipnWnngYwXMMC5zhk6lT/8CzBvZcaGTzSqJ
         C9qyl1mrN07B+1j4iDrTQXSRFS4jvOdFYXRzI0NQIDUw2T4wpjSDcYXp22KGObMYmCtb
         XitVqbVwrHuOcdqScdmFklF6h975vRjoaiWs/22Jl2umA+IvEZcB/VASfJuBFxzFYmhj
         IweDKQP7gjNoXG+sVohGL6xcnQ74hEckifqyPHvfWaGphHM82TvEIQ5XTflUPG9gvrB0
         3f7qNhR24pJucsLKVu9hIf/+BP0e45H/YvFQWt6G0RCoXAQMOrKeq19NbbtRBJrNdaAg
         l0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ds+P+VHRELlOlxwCcpje+JSh+rcyjYH+UGSM76wH/9E=;
        b=f9Cebrhh0CADpGlD6egwJ+pn+D/Ejfo6Wk/MltG04NMXBswpr0pFED0ATJ2dIaJuGH
         Sfe6jLkU57F/mUwxZKrkwQNAVnfeg1vnhfKwVkT6ijumCJqTrgD/8DxxLUVrj3zX2JmD
         BXTtamn41V6Zq2f+VZ1TNn8dvlDguUoVIfg6BU+Kk6X+cPCCcSQYFGCNPS4RsLIFlZzL
         8gfJVHBs4u3YGwJq0DllCw6oxdbpaFfOhrtPI3jI3vjQ0km0oHz8ZZNugnACQL3uxsvr
         aMf2FdnCbDLL7mRluZJlKOpbmSrrEjWdp9AGI/XrlkNDE9VzgEoYKiDKTIjmrXLdbb8R
         bFJQ==
X-Gm-Message-State: AOAM533X71epdeITIQvLuIYGs6qJTGVSjVuqSxuo34Xev/5WWPj2Q3YB
        mmUXzS2tEfKS/clLmFrxneA03STKpbh7QtCZe2Db6w==
X-Google-Smtp-Source: ABdhPJwb6yqXEEEEpisR2SPyN/wGvpBUVrove8z9LRQxEWLp1kan8BFylLm3VVXt3g2H6JMx961NCShr4ScSovIkwU0=
X-Received: by 2002:a9d:22ca:: with SMTP id y68mr133348ota.56.1597877385026;
 Wed, 19 Aug 2020 15:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200803211423.29398-1-graf@amazon.com> <20200803211423.29398-3-graf@amazon.com>
In-Reply-To: <20200803211423.29398-3-graf@amazon.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 19 Aug 2020 15:49:32 -0700
Message-ID: <CALMp9eS3Y845mPMD6H+5nmYDMvhPcDcFCWUXpLiscxo_9--EYQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] KVM: x86: Introduce allow list for MSR emulation
To:     Alexander Graf <graf@amazon.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        KarimAllah Raslan <karahmed@amazon.de>,
        Aaron Lewis <aaronlewis@google.com>,
        kvm list <kvm@vger.kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 2:14 PM Alexander Graf <graf@amazon.com> wrote:

> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -901,6 +901,13 @@ struct kvm_hv {
>         struct kvm_hv_syndbg hv_syndbg;
>  };
>
> +struct msr_bitmap_range {
> +       u32 flags;
> +       u32 nmsrs;
> +       u32 base;
> +       unsigned long *bitmap;
> +};
> +
>  enum kvm_irqchip_mode {
>         KVM_IRQCHIP_NONE,
>         KVM_IRQCHIP_KERNEL,       /* created with KVM_CREATE_IRQCHIP */
> @@ -1005,6 +1012,9 @@ struct kvm_arch {
>         /* Deflect RDMSR and WRMSR to user space when they trigger a #GP */
>         bool user_space_msr_enabled;
>
> +       struct msr_bitmap_range msr_allowlist_ranges[10];

Why 10? I think this is the only use of this constant, but a macro
would still be nice, especially since the number appears to be
arbitrary.

> diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
> index 0780f97c1850..c33fb1d72d52 100644
> --- a/arch/x86/include/uapi/asm/kvm.h
> +++ b/arch/x86/include/uapi/asm/kvm.h
> @@ -192,6 +192,21 @@ struct kvm_msr_list {
>         __u32 indices[0];
>  };
>
> +#define KVM_MSR_ALLOW_READ  (1 << 0)
> +#define KVM_MSR_ALLOW_WRITE (1 << 1)
> +
> +/* Maximum size of the of the bitmap in bytes */
> +#define KVM_MSR_ALLOWLIST_MAX_LEN 0x600

Wouldn't 0x400 be a more natural size, since both Intel and AMD MSR
permission bitmaps cover ranges of 8192 MSRs?

> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index e1139124350f..25e58ceb19de 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1472,6 +1472,38 @@ void kvm_enable_efer_bits(u64 mask)
>  }
>  EXPORT_SYMBOL_GPL(kvm_enable_efer_bits);
>
> +static bool kvm_msr_allowed(struct kvm_vcpu *vcpu, u32 index, u32 type)

In another thread, when I suggested that a function should return
bool, you said, "'I'm not a big fan of bool returning APIs unless they
have an "is" in their name.' This function doesn't have "is" in its
name. :-)

> +{
> +       struct kvm *kvm = vcpu->kvm;
> +       struct msr_bitmap_range *ranges = kvm->arch.msr_allowlist_ranges;
> +       u32 count = kvm->arch.msr_allowlist_ranges_count;

Shouldn't the read of kvm->arch.msr_allowlist_ranges_count be guarded
by the mutex, below?

> +       u32 i;
> +       bool r = false;
> +
> +       /* MSR allowlist not set up, allow everything */
> +       if (!count)
> +               return true;
> +
> +       /* Prevent collision with clear_msr_allowlist */
> +       mutex_lock(&kvm->lock);
> +
> +       for (i = 0; i < count; i++) {
> +               u32 start = ranges[i].base;
> +               u32 end = start + ranges[i].nmsrs;
> +               u32 flags = ranges[i].flags;
> +               unsigned long *bitmap = ranges[i].bitmap;
> +
> +               if ((index >= start) && (index < end) && (flags & type)) {
> +                       r = !!test_bit(index - start, bitmap);

The !! seems gratuitous, since r is of type bool.

> @@ -1483,6 +1515,9 @@ static int __kvm_set_msr(struct kvm_vcpu *vcpu, u32 index, u64 data,
>  {
>         struct msr_data msr;
>
> +       if (!host_initiated && !kvm_msr_allowed(vcpu, index, KVM_MSR_ALLOW_WRITE))
> +               return -ENOENT;

Perhaps -EPERM is more appropriate here?

>         switch (index) {
>         case MSR_FS_BASE:
>         case MSR_GS_BASE:
> @@ -1528,6 +1563,9 @@ int __kvm_get_msr(struct kvm_vcpu *vcpu, u32 index, u64 *data,
>         struct msr_data msr;
>         int ret;
>
> +       if (!host_initiated && !kvm_msr_allowed(vcpu, index, KVM_MSR_ALLOW_READ))
> +               return -ENOENT;

...and here?

> +static bool msr_range_overlaps(struct kvm *kvm, struct msr_bitmap_range *range)

Another bool function with no "is"? :-)

> +{
> +       struct msr_bitmap_range *ranges = kvm->arch.msr_allowlist_ranges;
> +       u32 i, count = kvm->arch.msr_allowlist_ranges_count;
> +       bool r = false;
> +
> +       for (i = 0; i < count; i++) {
> +               u32 start = max(range->base, ranges[i].base);
> +               u32 end = min(range->base + range->nmsrs,
> +                             ranges[i].base + ranges[i].nmsrs);
> +
> +               if ((start < end) && (range->flags & ranges[i].flags)) {
> +                       r = true;
> +                       break;
> +               }
> +       }
> +
> +       return r;
> +}

This seems like an awkward constraint. Would it be possible to allow
overlapping ranges as long as the access types don't clash? So, for
example, could I specify an allow list for READ of MSRs 0-0x1ffff and
an allow list for WRITE of MSRs 0-0x1ffff? Actually, I don't see why
you have to prohibit overlapping ranges at all.


> +static int kvm_vm_ioctl_clear_msr_allowlist(struct kvm *kvm)
> +{
> +       int i;

Nit: In earlier code, you use u32 for this index. (I'm actually a fan
of int, myself.)


> @@ -10086,6 +10235,8 @@ void kvm_arch_pre_destroy_vm(struct kvm *kvm)
>
>  void kvm_arch_destroy_vm(struct kvm *kvm)
>  {
> +       int i;

It's 50/50 now, u32 vs. int. :-)
