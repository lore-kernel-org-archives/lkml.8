Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A6AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 21:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C7C2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 21:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pR0+HwJS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgHLVWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 17:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgHLVWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 17:22:00 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5428C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 14:21:59 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id h16so3136361oti.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 14:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0BIXtxMs1uVpUMl8PYh5p25ogjLLyRQhhYVMx6Aoh8s=;
        b=pR0+HwJS/2QTypntnrIOKkTm9w0r/FJCWjbrEwwFI6w9bGdwxxZpiYPbK8ZMf6372B
         fM3m7D9Uz2DIa5l//c3UeFCLyKvFweCQ/gD1p+fDc3mH/5OyTB4hchr/6SoVkDSgN0it
         j/hV6PAVSwHRnnW96jx0IkThsj7SgOPgIUzul829mno7rhPeUJ537QfBMLk428mVNl2V
         vehXxqfhgRPsEM2CoPjUBq3/PAFd+Szcnupc6QBMzWCrAyvigmHgT1GQJ+Of/DVpUdq5
         0Z7sT71BU7LP/BabwrB6/9+QnW9iYdor6NmjZEFffL6xiq5TGW/U7GHEKrCEAho+kh0w
         EaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0BIXtxMs1uVpUMl8PYh5p25ogjLLyRQhhYVMx6Aoh8s=;
        b=UgdscPE6nv2hPVL2sTC1fySvVpNeHlIQXQLAN82AmrPFijE4LdPjeWfbPNZuzIL+xV
         wwUNc2VWQNeRdtLs31VortXfz0mIGDTGvBl9dztBhcHhH6zKJrIjFsRYpacT5r3Ku+HS
         Zs7HSL/1WUwlaH9i73wkJTgZ7LV+RvAVo3s3NlWMwSCosWImUOWKOJMkX8GyT3lvSRhV
         H8axhLgaatFTTRqmQo45bILLg1Fu5eyNnMvHvLXAqKXLQu7emsfc2foHqrlSiZgXsF+7
         mBxQ7VqR1i1qO9x6TN+yQtW4zUBrCjXVIfxUdkHRFyZCEfQBge9xSXyFPUkr7dXxE/wN
         PJdA==
X-Gm-Message-State: AOAM530koOPfMaaePVk0lROPSTuRdn4pwd6AADr/n3nzyI8J3uRpttF8
        eaTyrIhA4m6L5IxsuW0tbBRAqn2b7h/75N29BgqFRQ==
X-Google-Smtp-Source: ABdhPJwl8NAM3zLRfuNb9IBo7SE44CvbMl63n8/JNOZ46pw+YfzBgdWIbjs5rUI0Ga3ztQpX8hOEDwLsHRorJKCs04Y=
X-Received: by 2002:a9d:22ca:: with SMTP id y68mr1520144ota.56.1597267318690;
 Wed, 12 Aug 2020 14:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200807084841.7112-1-chenyi.qiang@intel.com> <20200807084841.7112-3-chenyi.qiang@intel.com>
In-Reply-To: <20200807084841.7112-3-chenyi.qiang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 12 Aug 2020 14:21:47 -0700
Message-ID: <CALMp9eQiyRxJ0jkvVi+fWMZcDQbvyCcuTwH1wrYV-u_E004Bhg@mail.gmail.com>
Subject: Re: [RFC 2/7] KVM: VMX: Expose IA32_PKRS MSR
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

On Fri, Aug 7, 2020 at 1:46 AM Chenyi Qiang <chenyi.qiang@intel.com> wrote:
>
> Protection Keys for Supervisor Pages (PKS) uses IA32_PKRS MSR (PKRS) at
> index 0x6E1 to allow software to manage supervisor protection key
> rights. For performance consideration, PKRS intercept will be disabled
> so that the guest can access the PKRS without VM exits.
> PKS introduces dedicated control fields in VMCS to switch PKRS, which
> only does the retore part. In addition, every VM exit saves PKRS into
> the guest-state area in VMCS, while VM enter won't save the host value
> due to the expectation that the host won't change the MSR often. Update
> the host's value in VMCS manually if the MSR has been changed by the
> kernel since the last time the VMCS was run.
> The function get_current_pkrs() in arch/x86/mm/pkeys.c exports the
> per-cpu variable pkrs_cache to avoid frequent rdmsr of PKRS.
>
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
> ---

> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 11e4df560018..df2c2e733549 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -289,6 +289,7 @@ static void vmx_sync_vmcs_host_state(struct vcpu_vmx *vmx,
>         dest->ds_sel = src->ds_sel;
>         dest->es_sel = src->es_sel;
>  #endif
> +       dest->pkrs = src->pkrs;

Why isn't this (and other PKRS code) inside the #ifdef CONFIG_X86_64?
PKRS isn't usable outside of long mode, is it?

>  }
>
>  static void vmx_switch_vmcs(struct kvm_vcpu *vcpu, struct loaded_vmcs *vmcs)
> diff --git a/arch/x86/kvm/vmx/vmcs.h b/arch/x86/kvm/vmx/vmcs.h
> index 7a3675fddec2..39ec3d0c844b 100644
> --- a/arch/x86/kvm/vmx/vmcs.h
> +++ b/arch/x86/kvm/vmx/vmcs.h
> @@ -40,6 +40,7 @@ struct vmcs_host_state {
>  #ifdef CONFIG_X86_64
>         u16           ds_sel, es_sel;
>  #endif
> +       u32           pkrs;

One thing that does seem odd throughout is that PKRS is a 64-bit
resource, but we store and pass around only 32-bits. Yes, the top 32
bits are currently reserved, but the same can be said of, say, cr4, a
few lines above this. Yet, we store and pass around cr4 as 64-bits.
How do we decide?

>  };
>
>  struct vmcs_controls_shadow {

> @@ -1163,6 +1164,20 @@ void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu)
>          */
>         host_state->ldt_sel = kvm_read_ldt();
>
> +       /*
> +        * Update the host pkrs vmcs field before vcpu runs.
> +        * The setting of VM_EXIT_LOAD_IA32_PKRS can ensure
> +        * kvm_cpu_cap_has(X86_FEATURE_PKS) &&
> +        * guest_cpuid_has(vcpu, X86_FEATURE_VMX).
> +        */
> +       if (vm_exit_controls_get(vmx) & VM_EXIT_LOAD_IA32_PKRS) {
> +               host_pkrs = get_current_pkrs();
> +               if (unlikely(host_pkrs != host_state->pkrs)) {
> +                       vmcs_write64(HOST_IA32_PKRS, host_pkrs);
> +                       host_state->pkrs = host_pkrs;
> +               }
> +       }
> +
>  #ifdef CONFIG_X86_64
>         savesegment(ds, host_state->ds_sel);
>         savesegment(es, host_state->es_sel);
> @@ -1951,6 +1966,13 @@ static int vmx_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>                 else
>                         msr_info->data = vmx->pt_desc.guest.addr_a[index / 2];
>                 break;
> +       case MSR_IA32_PKRS:
> +               if (!kvm_cpu_cap_has(X86_FEATURE_PKS) ||
> +                   (!msr_info->host_initiated &&
> +                   !guest_cpuid_has(vcpu, X86_FEATURE_PKS)))

Could this be simplified if we required
kvm_cpu_cap_has(X86_FEATURE_PKS) as a prerequisite for
guest_cpuid_has(vcpu, X86_FEATURE_PKS)? If not, what is the expected
behavior if guest_cpuid_has(vcpu, X86_FEATURE_PKS) is true and
kvm_cpu_cap_has(X86_FEATURE_PKS)  is false?

> +                       return 1;
> +               msr_info->data = vmcs_read64(GUEST_IA32_PKRS);
> +               break;
>         case MSR_TSC_AUX:
>                 if (!msr_info->host_initiated &&
>                     !guest_cpuid_has(vcpu, X86_FEATURE_RDTSCP))

> @@ -7230,6 +7267,26 @@ static void update_intel_pt_cfg(struct kvm_vcpu *vcpu)
>                 vmx->pt_desc.ctl_bitmask &= ~(0xfULL << (32 + i * 4));
>  }
>
> +static void vmx_update_pkrs_cfg(struct kvm_vcpu *vcpu)
> +{
> +       struct vcpu_vmx *vmx = to_vmx(vcpu);
> +       unsigned long *msr_bitmap = vmx->vmcs01.msr_bitmap;
> +       bool pks_supported = guest_cpuid_has(vcpu, X86_FEATURE_PKS);
> +
> +       /*
> +        * set intercept for PKRS when the guest doesn't support pks
> +        */
> +       vmx_set_intercept_for_msr(msr_bitmap, MSR_IA32_PKRS, MSR_TYPE_RW, !pks_supported);
> +
> +       if (pks_supported) {
> +               vm_entry_controls_setbit(vmx, VM_ENTRY_LOAD_IA32_PKRS);
> +               vm_exit_controls_setbit(vmx, VM_EXIT_LOAD_IA32_PKRS);
> +       } else {
> +               vm_entry_controls_clearbit(vmx, VM_ENTRY_LOAD_IA32_PKRS);
> +               vm_exit_controls_clearbit(vmx, VM_EXIT_LOAD_IA32_PKRS);
> +       }
> +}

Not just your change, but it is unclear to me what the expected
behavior is when CPUID bits are modified while the guest is running.
For example, it seems that this code results in immediate behavioral
changes for an L1 guest; however, if an L2 guest is active, then there
are no behavioral changes until the next emulated VM-entry from L1 to
L2. Is that right?

On a more general note, do you have any kvm-unit-tests that exercise
the new code?
