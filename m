Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E6B8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4D9A208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 22:46:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+W2MNij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgFSWqG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 18:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgFSWqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 18:46:05 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A75EC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 15:46:05 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t85so1446423ili.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 15:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jH/dA5uUVqsNDjbuGLof+U+Gygv8PhIcTewwE4gKMYE=;
        b=h+W2MNijvEM9ot6E9WHNBXmS1ToD1hq5GjBBRg9FiDIAhdrq/U8LAdUUL2CrlbgzeI
         vbc+QmN6dbp+0pyOM1WCOwkQyX7M+yn+liam5gAXjt4KkD8xx/dY9tkHw3TvGNUQhnTW
         sPGQg7XfaqxRqI9oDp2tjWf77JjQ4+JybbF0TDWqI5V6oYr1gk5kD9XQnzwYxw9mwr5+
         dmSwxwZ/EaNn/QTZMHGYJjfnfJ6eLH9hnc1BOP31FwaxUS2kii1TGA6XoOpyqHDdo6sH
         6A09eecpEIY2xd4GHT0fxS6fPtrTNXxcg8jwf3br4icbG4TS1U2Sc8UDM5//s0htPwO/
         hQtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jH/dA5uUVqsNDjbuGLof+U+Gygv8PhIcTewwE4gKMYE=;
        b=eevbCV5utxEmyC0dkvMXBjYnmpbgZzTMMP5KRlm5lFZz7AFkZ71Z3hceBSHL9tXRGA
         20tvyNADSyd/bstN9oWT/EC8hEll+Th8fbc7n1zIqTHz0lOGAbmAz3lBQURDEx0Wz/Ey
         9i2RJa9o4SQTpnyG2Ew1UErETWWmxgenGIEpLGdLoNAy7Prf3PjuenVHpLw+4rzdaVio
         L4ga0K22hOArHPTA4sw4l72LMsNwjUWyoE1EdHfvKrYyBpE0Jhkmb9ZEEmhTj55m/2QI
         wFWdQV2SZ2VagGRMGW4rUBEKvRBOOvhJZESARf9oWkgrFNrJ5kF54fYEK/WP/TCMUjwN
         jVlw==
X-Gm-Message-State: AOAM533ENFHnP3p9csvMrZIJ9Iaj7QBDvEFhphqdR34Eo40Ni10fQ1an
        EwimJacrcZQUTIcdmF/2eF/wAq8aG3brIzU6cm8lkKcr
X-Google-Smtp-Source: ABdhPJxhACCnJ0xgIquosf8TXeeHudyVXlyxNNnw7oBChStulF96+S1xMUy85W5DNj7bpuInqTGdOwVHXFJpU40VcBc=
X-Received: by 2002:a05:6e02:11a5:: with SMTP id 5mr5978727ilj.108.1592606764363;
 Fri, 19 Jun 2020 15:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200619153925.79106-1-mgamal@redhat.com> <20200619153925.79106-7-mgamal@redhat.com>
In-Reply-To: <20200619153925.79106-7-mgamal@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 19 Jun 2020 15:45:52 -0700
Message-ID: <CALMp9eQYRoB5vmxL0U7Mn0rWqotxLpUAJD15YX0DDYop1ZmuEg@mail.gmail.com>
Subject: Re: [PATCH v2 06/11] KVM: VMX: introduce vmx_need_pf_intercept
To:     Mohammed Gamal <mgamal@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Moger, Babu" <babu.moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 8:40 AM Mohammed Gamal <mgamal@redhat.com> wrote:
>
> From: Paolo Bonzini <pbonzini@redhat.com>
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 28 +++++++++++++++++-----------
>  arch/x86/kvm/vmx/vmx.c    |  2 +-
>  arch/x86/kvm/vmx/vmx.h    |  5 +++++
>  3 files changed, 23 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index d1af20b050a8..328411919518 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2433,22 +2433,28 @@ static void prepare_vmcs02_rare(struct vcpu_vmx *vmx, struct vmcs12 *vmcs12)
>
>         /*
>          * Whether page-faults are trapped is determined by a combination of
> -        * 3 settings: PFEC_MASK, PFEC_MATCH and EXCEPTION_BITMAP.PF.
> -        * If enable_ept, L0 doesn't care about page faults and we should
> -        * set all of these to L1's desires. However, if !enable_ept, L0 does
> -        * care about (at least some) page faults, and because it is not easy
> -        * (if at all possible?) to merge L0 and L1's desires, we simply ask
> -        * to exit on each and every L2 page fault. This is done by setting
> -        * MASK=MATCH=0 and (see below) EB.PF=1.
> +        * 3 settings: PFEC_MASK, PFEC_MATCH and EXCEPTION_BITMAP.PF.  If L0
> +        * doesn't care about page faults then we should set all of these to
> +        * L1's desires. However, if L0 does care about (some) page faults, it
> +        * is not easy (if at all possible?) to merge L0 and L1's desires, we
> +        * simply ask to exit on each and every L2 page fault. This is done by
> +        * setting MASK=MATCH=0 and (see below) EB.PF=1.
>          * Note that below we don't need special code to set EB.PF beyond the
>          * "or"ing of the EB of vmcs01 and vmcs12, because when enable_ept,
>          * vmcs01's EB.PF is 0 so the "or" will take vmcs12's value, and when
>          * !enable_ept, EB.PF is 1, so the "or" will always be 1.
>          */
> -       vmcs_write32(PAGE_FAULT_ERROR_CODE_MASK,
> -               enable_ept ? vmcs12->page_fault_error_code_mask : 0);
> -       vmcs_write32(PAGE_FAULT_ERROR_CODE_MATCH,
> -               enable_ept ? vmcs12->page_fault_error_code_match : 0);
> +       if (vmx_need_pf_intercept(&vmx->vcpu)) {
> +               /*
> +                * TODO: if both L0 and L1 need the same MASK and MATCH,
> +                * go ahead and use it?
> +                */

I'm not sure there's much "TODO", since L0's MASK and MATCH are both
0. So, if L1's MASK and MATCH are also both 0, we would go ahead and
use 0's, which it seems we already do here:

> +               vmcs_write32(PAGE_FAULT_ERROR_CODE_MASK, 0);
> +               vmcs_write32(PAGE_FAULT_ERROR_CODE_MATCH, 0);
> +       } else {
> +               vmcs_write32(PAGE_FAULT_ERROR_CODE_MASK, vmcs12->page_fault_error_code_mask);
> +               vmcs_write32(PAGE_FAULT_ERROR_CODE_MATCH, vmcs12->page_fault_error_code_match);
> +       }
>
>         if (cpu_has_vmx_apicv()) {
>                 vmcs_write64(EOI_EXIT_BITMAP0, vmcs12->eoi_exit_bitmap0);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f82c42ac87f9..46d522ee5cb1 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -783,7 +783,7 @@ void update_exception_bitmap(struct kvm_vcpu *vcpu)
>                 eb |= 1u << BP_VECTOR;
>         if (to_vmx(vcpu)->rmode.vm86_active)
>                 eb = ~0;
> -       if (enable_ept)
> +       if (!vmx_need_pf_intercept(vcpu))
>                 eb &= ~(1u << PF_VECTOR);
>
>         /* When we are running a nested L2 guest and L1 specified for it a
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 8a83b5edc820..5e2da15fe94f 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -552,6 +552,11 @@ static inline bool vmx_has_waitpkg(struct vcpu_vmx *vmx)
>                 SECONDARY_EXEC_ENABLE_USR_WAIT_PAUSE;
>  }
>
> +static inline bool vmx_need_pf_intercept(struct kvm_vcpu *vcpu)
> +{
> +       return !enable_ept;
> +}
> +
>  void dump_vmcs(void);
>
>  #endif /* __KVM_X86_VMX_H */
> --
> 2.26.2
>
Reviewed-by: Jim Mattson <jmattson@google.com>
