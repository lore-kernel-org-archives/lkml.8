Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2102C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC99C2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 20:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TiElAugI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgH1Ujz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 16:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgH1Ujw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 16:39:52 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D7CC06121B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:39:52 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k20so373099otr.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 13:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LoEnI6osRj6yag/7TgRddr4TWXVaho6xu2ojKmFndVs=;
        b=TiElAugIVvRoduQxZ8e0Ug49jkWVhXTEhvgxShz2TILmhyYd6887UvA4i908P2zVGL
         oBC+yeSxYh5ryXv3nuafaJQ3bFDs08Xk1cTzq9dYidvBvAAUiBfZcICepOssoo1bmPaA
         gVNaRDHNN8WHZ+PrEigLtPw04cI9HdST4dcC4YYIMeaCBziGVR3LDG5/BU9nzfAT+ZG2
         td5QJ+kyFugt4LACdOiIXA+Z0env1/KRqWP/Dt2gKj59tJ/MXArIKqpUWG/S94TLj38W
         9SL/JepY4yTrtbw41wghHxlr32fZb7Ulj3eJtvyavAt8ipOALUuzVkgG6itu3RS3HLJC
         XX+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LoEnI6osRj6yag/7TgRddr4TWXVaho6xu2ojKmFndVs=;
        b=ZOstuwThpfGY5TGYMF6hoZLqpCQkgFnRWj6pVHeR7dO1NKgUAkD6tmt8OeCdXUtwhc
         eUfeVwHI5Ec1+5bZfBBXyubA2T/FAYqClFmZmboO0rkL/duuK7DqhpjrcDPfGxyPjF1X
         UL/X+ld8XbVYjKcKNv0QPg9QxWnMqErtfGdpP4+7MuIhV2GdXIPbwCA7yQZqslxbvvoa
         bCK+aEUe2YHyvg6NnhIYjysixywYaIrqSHQkEM2dOCJmSO2frMt4/aP8XpznUP8/Th/m
         QwzY+i9grrEJfqC8Rp9EnLePe3MHsAQmU6oW9WgbN1dvFOqrgUBOwTCn3k6TFWv7vI69
         Qgdg==
X-Gm-Message-State: AOAM532iEJ2R5bHD31PeWoft7hF5kErudL+eFdSWPw1STwPsdV4ebSGS
        qv4Nq8304Wui5BFoO+YDQ+Ef+vNWWm9CMa+fDk+zCg==
X-Google-Smtp-Source: ABdhPJxYdLw7BXQXA24VIltH7C6XUh7pH1HLMLSyWcOc2TFZmVnQFgAM/7fnxZTmVHnDhy7J8INPrPSPHU83LIS1l74=
X-Received: by 2002:a9d:1c8f:: with SMTP id l15mr302546ota.241.1598647190949;
 Fri, 28 Aug 2020 13:39:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200828085622.8365-1-chenyi.qiang@intel.com> <20200828085622.8365-4-chenyi.qiang@intel.com>
In-Reply-To: <20200828085622.8365-4-chenyi.qiang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 28 Aug 2020 13:39:39 -0700
Message-ID: <CALMp9eT1makVq46TB-EtTPiz=Z_2DfhudJekrtheSsmwBc4pZA@mail.gmail.com>
Subject: Re: [PATCH 3/5] KVM: nVMX: Update VMX controls MSR according to guest
 CPUID after setting VMX MSRs
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 1:54 AM Chenyi Qiang <chenyi.qiang@intel.com> wrote:
>
> Update the fields (i.e. VM_{ENTRY_LOAD, EXIT_CLEAR}_BNDCFGS and
> VM_{ENTRY, EXIT}_LOAD_IA32_PERF_GLOBAL_CTRL) in
> nested MSR_IA32_VMX_TRUE_{ENTRY, EXIT}_CTLS according to guest CPUID
> when user space initializes the features MSRs. Regardless of the order
> of SET_CPUID and SET_MSRS from the user space, do the update to avoid
> MSR values overriding.
>
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 819c185adf09..f9664ccc003b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -345,6 +345,7 @@ static bool guest_state_valid(struct kvm_vcpu *vcpu);
>  static u32 vmx_segment_access_rights(struct kvm_segment *var);
>  static __always_inline void vmx_disable_intercept_for_msr(unsigned long *msr_bitmap,
>                                                           u32 msr, int type);
> +static void nested_vmx_entry_exit_ctls_update(struct kvm_vcpu *vcpu);
>
>  void vmx_vmexit(void);
>
> @@ -2161,7 +2162,10 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                         return 1; /* they are read-only */
>                 if (!nested_vmx_allowed(vcpu))
>                         return 1;
> -               return vmx_set_vmx_msr(vcpu, msr_index, data);
> +               ret = vmx_set_vmx_msr(vcpu, msr_index, data);
> +               nested_vmx_pmu_entry_exit_ctls_update(vcpu);
> +               nested_vmx_entry_exit_ctls_update(vcpu);
> +               break;

Now I see what you're doing. This commit should probably come before
the previous commit, so that at no point in the series can userspace
set VMX MSR bits that should be cleared based on the guest CPUID.

There's an ABI change here: userspace may no longer get -EINVAL if it
tries to set an illegal VMX MSR bit. Instead, some illegal bits are
silently cleared. Moreover, these functions will potentially set VMX
MSR bits that userspace has just asked to clear.

>         case MSR_IA32_RTIT_CTL:
>                 if (!vmx_pt_mode_is_host_guest() ||
>                         vmx_rtit_ctl_check(vcpu, data) ||
> --
> 2.17.1
>
