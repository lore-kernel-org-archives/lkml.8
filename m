Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16ABAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7FB0207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irENL1vE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgG2XBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgG2XBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 19:01:31 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2DBC0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:01:31 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l1so26307337ioh.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AxOn0s4F9tBd3lu49mRGX5vA0ogVx2DmO4hN0QqsKW4=;
        b=irENL1vEumHF1CwGGjhWo0lgP/eeJykAmVVmrN92mcfKy/Twy8AdqmO7ImuVxyM4hz
         2wbV6N4WrY3nTaJVeX47BSZIa3JwcNrwe0rvDBDHScYqqVM9V/drLcLsrI6hJtRrnbIP
         9X/v278lSSS5LAgiTb32N3+REm7ESm6DSMNh7sybQvvVlOyxSv/zjhxtG8Q1D+VxsOfM
         4oir9yNXjgLIKve6u6qiXO8bYp/vOWTkHpePrUS6EJjs3kZJb83VKhYToRnVWxPvPhU8
         iDTs7vPaN1e6ybUYXO0efUVu1/0wXljS6mIqzlXGSVrp9uXxH3kDU0Q29UYHkdi/mCFu
         VQ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AxOn0s4F9tBd3lu49mRGX5vA0ogVx2DmO4hN0QqsKW4=;
        b=olJKmLKBc19hHCUvB7aUfk4uJRAdty8PsqMZv521udAQtd4MZsVjiQ3X37aAXaZdot
         EElJrU26M2+tNdR1L2iKC8ZrmF65mjInHcgznvWETG9F7VRTjIJcb83sgImKDP+lj6o5
         nKs3gvw8OYWRPGlKfeg92NRtc24j2KQKQ4r+ValDBQSI3umoan1edx5bPlsrs5d+4YYV
         P8k6sGZTGPHhsG+5Bckk89aY3g83sWFxjBa8BkYRaTX+/iJeyM4jc32wEvRz4mJBUHEu
         tHqKwiv+/X0VRzhkTgaTilj4YKzSxPO1dPOlrjK1MpPWQNiIKD4zW+porvUVVAcRzorh
         Zl+A==
X-Gm-Message-State: AOAM533vMPytUTVWyV6UkaM1tTtkNVj4w5ynG9A63H/unDoLAIDHZgp9
        Qt/mEyQuPQiLoB7SlMdwhRMEZR1pupGWkzR89JdsiA==
X-Google-Smtp-Source: ABdhPJz1szPVcngE2FAlU/FT8QKEvU/hC1cr2KngDiVCayUr2TLa8qiPTR+BT08/SfcZvuCdZGxXxnrtR8rwJOPSgAs=
X-Received: by 2002:a05:6638:250f:: with SMTP id v15mr346419jat.75.1596063690319;
 Wed, 29 Jul 2020 16:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu> <159597953941.12744.13644431147694358715.stgit@bmoger-ubuntu>
In-Reply-To: <159597953941.12744.13644431147694358715.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 29 Jul 2020 16:01:19 -0700
Message-ID: <CALMp9eT071cb37w1+i957EeZnXAUTZWm=0ZF-BEX4fpiBKo1dw@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] KVM:SVM: Enable INVPCID feature on AMD
To:     Babu Moger <babu.moger@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 4:39 PM Babu Moger <babu.moger@amd.com> wrote:
>
> The following intercept bit has been added to support VMEXIT
> for INVPCID instruction:
> Code    Name            Cause
> A2h     VMEXIT_INVPCID  INVPCID instruction
>
> The following bit has been added to the VMCB layout control area
> to control intercept of INVPCID:
> Byte Offset     Bit(s)    Function
> 14h             2         intercept INVPCID
>
> Enable the interceptions when the the guest is running with shadow
> page table enabled and handle the tlbflush based on the invpcid
> instruction type.
>
> For the guests with nested page table (NPT) support, the INVPCID
> feature works as running it natively. KVM does not need to do any
> special handling in this case.
>
> AMD documentation for INVPCID feature is available at "AMD64
> Architecture Programmer=E2=80=99s Manual Volume 2: System Programming,
> Pub. 24593 Rev. 3.34(or later)"
>
> The documentation can be obtained at the links below:
> Link: https://www.amd.com/system/files/TechDocs/24593.pdf
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/include/uapi/asm/svm.h |    2 +
>  arch/x86/kvm/svm/svm.c          |   64 +++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 66 insertions(+)
>
> diff --git a/arch/x86/include/uapi/asm/svm.h b/arch/x86/include/uapi/asm/=
svm.h
> index 2e8a30f06c74..522d42dfc28c 100644
> --- a/arch/x86/include/uapi/asm/svm.h
> +++ b/arch/x86/include/uapi/asm/svm.h
> @@ -76,6 +76,7 @@
>  #define SVM_EXIT_MWAIT_COND    0x08c
>  #define SVM_EXIT_XSETBV        0x08d
>  #define SVM_EXIT_RDPRU         0x08e
> +#define SVM_EXIT_INVPCID       0x0a2
>  #define SVM_EXIT_NPF           0x400
>  #define SVM_EXIT_AVIC_INCOMPLETE_IPI           0x401
>  #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS     0x402
> @@ -171,6 +172,7 @@
>         { SVM_EXIT_MONITOR,     "monitor" }, \
>         { SVM_EXIT_MWAIT,       "mwait" }, \
>         { SVM_EXIT_XSETBV,      "xsetbv" }, \
> +       { SVM_EXIT_INVPCID,     "invpcid" }, \
>         { SVM_EXIT_NPF,         "npf" }, \
>         { SVM_EXIT_AVIC_INCOMPLETE_IPI,         "avic_incomplete_ipi" }, =
\
>         { SVM_EXIT_AVIC_UNACCELERATED_ACCESS,   "avic_unaccelerated_acces=
s" }, \
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 99cc9c285fe6..6b099e0b28c0 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -813,6 +813,11 @@ static __init void svm_set_cpu_caps(void)
>         if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
>             boot_cpu_has(X86_FEATURE_AMD_SSBD))
>                 kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD);
> +
> +       /* Enable INVPCID if both PCID and INVPCID enabled */
> +       if (boot_cpu_has(X86_FEATURE_PCID) &&
> +           boot_cpu_has(X86_FEATURE_INVPCID))
> +               kvm_cpu_cap_set(X86_FEATURE_INVPCID);
>  }

Why is PCID required? Can't this just be
'kvm_cpu_cap_check_and_set(X86_FEATURE_INVPCID);'?

>  static __init int svm_hardware_setup(void)
> @@ -1099,6 +1104,18 @@ static void init_vmcb(struct vcpu_svm *svm)
>                 clr_intercept(svm, INTERCEPT_PAUSE);
>         }
>
> +       /*
> +        * Intercept INVPCID instruction only if shadow page table is
> +        * enabled. Interception is not required with nested page table
> +        * enabled.
> +        */
> +       if (boot_cpu_has(X86_FEATURE_INVPCID)) {

Shouldn't this be 'kvm_cpu_cap_has(X86_FEATURE_INVPCID),' so that it
is consistent with the code above?

> +               if (!npt_enabled)
> +                       set_intercept(svm, INTERCEPT_INVPCID);
> +               else
> +                       clr_intercept(svm, INTERCEPT_INVPCID);
> +       }
> +
>         if (kvm_vcpu_apicv_active(&svm->vcpu))
>                 avic_init_vmcb(svm);
>
> @@ -2715,6 +2732,43 @@ static int mwait_interception(struct vcpu_svm *svm=
)
>         return nop_interception(svm);
>  }
>
> +static int invpcid_interception(struct vcpu_svm *svm)
> +{
> +       struct kvm_vcpu *vcpu =3D &svm->vcpu;
> +       struct x86_exception e;
> +       unsigned long type;
> +       gva_t gva;
> +       struct {
> +               u64 pcid;
> +               u64 gla;
> +       } operand;
> +
> +       if (!guest_cpuid_has(vcpu, X86_FEATURE_INVPCID)) {
> +               kvm_queue_exception(vcpu, UD_VECTOR);
> +               return 1;
> +       }
> +
> +       /*
> +        * For an INVPCID intercept:
> +        * EXITINFO1 provides the linear address of the memory operand.
> +        * EXITINFO2 provides the contents of the register operand.
> +        */
> +       type =3D svm->vmcb->control.exit_info_2;
> +       gva =3D svm->vmcb->control.exit_info_1;
> +
> +       if (type > 3) {
> +               kvm_inject_gp(vcpu, 0);
> +               return 1;
> +       }
> +
> +       if (kvm_read_guest_virt(vcpu, gva, &operand, sizeof(operand), &e)=
) {
> +               kvm_inject_emulated_page_fault(vcpu, &e);
> +               return 1;
> +       }

The emulated page fault is not always correct. See commit
7a35e515a7055 ("KVM: VMX: Properly handle kvm_read/write_guest_virt*()
result"). I don't think the problems are only on the VMX side.

> +
> +       return kvm_handle_invpcid(vcpu, type, operand.pcid, operand.gla);
> +}
> +
>  static int (*const svm_exit_handlers[])(struct vcpu_svm *svm) =3D {
>         [SVM_EXIT_READ_CR0]                     =3D cr_interception,
>         [SVM_EXIT_READ_CR3]                     =3D cr_interception,
> @@ -2777,6 +2831,7 @@ static int (*const svm_exit_handlers[])(struct vcpu=
_svm *svm) =3D {
>         [SVM_EXIT_MWAIT]                        =3D mwait_interception,
>         [SVM_EXIT_XSETBV]                       =3D xsetbv_interception,
>         [SVM_EXIT_RDPRU]                        =3D rdpru_interception,
> +       [SVM_EXIT_INVPCID]                      =3D invpcid_interception,
>         [SVM_EXIT_NPF]                          =3D npf_interception,
>         [SVM_EXIT_RSM]                          =3D rsm_interception,
>         [SVM_EXIT_AVIC_INCOMPLETE_IPI]          =3D avic_incomplete_ipi_i=
nterception,
> @@ -3562,6 +3617,15 @@ static void svm_cpuid_update(struct kvm_vcpu *vcpu=
)
>         svm->nrips_enabled =3D kvm_cpu_cap_has(X86_FEATURE_NRIPS) &&
>                              guest_cpuid_has(&svm->vcpu, X86_FEATURE_NRIP=
S);
>
> +       /* Check again if INVPCID interception if required */
> +       if (boot_cpu_has(X86_FEATURE_INVPCID) &&

Again, shouldn't this be 'kvm_cpu_cap_has(X86_FEATURE_INVPCID)'?
(Better, perhaps, would be to extract this common block of code into a
separate function to be called from both places.)

> +           guest_cpuid_has(vcpu, X86_FEATURE_INVPCID)) {
> +               if (!npt_enabled)
> +                       set_intercept(svm, INTERCEPT_INVPCID);
> +               else
> +                       clr_intercept(svm, INTERCEPT_INVPCID);
> +       }
> +
>         if (!kvm_vcpu_apicv_active(vcpu))
>                 return;
>
>
