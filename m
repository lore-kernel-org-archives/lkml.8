Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38F6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A73920792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 20:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T2N7776J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgFLUK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 16:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgFLUK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 16:10:57 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81761C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 13:10:56 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id b5so9927827iln.5
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 13:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F8ZSFjqtHoPIW103fSSUZVUH9zR6cxKoKrPNyMTvnjU=;
        b=T2N7776JWePfCRFF9+I3uw7xo3GpEZ24t+ZaZHmXW9LOtq4EuxW77hZzcjfIFPcj5L
         gdsVGLAkDUfFpbRVpaOUEGqo/gHDDFuHiLeX1pk4DUQE7lXWbHPv0iiqOIEZ8WztlvHO
         QXl6nS14vkzuGSWLwR/uiAeW+7L3YLnVjsEl4xtsZp6n8w1gasWq6YBpbm2/Vi4APKKi
         6rAiOyR4fEK5u4qzcwfxpJMoqhJ3LoqofC/C0Z8dlmRt7faGscpvFlwoUZLauizcwvgY
         BPl3cEe05iQWdEXX51iScoY8pxS0brKSJm8tNT8On6C2sziWNttmUebUbK9fkqJ23GEs
         N06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F8ZSFjqtHoPIW103fSSUZVUH9zR6cxKoKrPNyMTvnjU=;
        b=Zbwz5/mxoPkajjI0eAxukjiDwlTIxXnzy/ZFbZf7cUkCQ7tq/WzEix8dTqqTW+8UxQ
         xacieNsEPILWvs/cKNy15MZk34l4lGmUYLkJZg0+ywiCNPrzaoJmd/ku2yPUnhjG62YE
         ErSqwGXHYNtu+pTX2fR0T86L45B1RjMj5rYqaJpbd2BhlQYVL/xzmNjK1vzzubXWWRwf
         DcHZPZm5UodoZe/spQrKgMPNz/ksknPWKEFcfqq0TQ12cWIgLssk1coQXcsAFz9ApN6r
         2u2lW3opxxGoSeV3hS8aU2lPvx41kCSV/eicr3HzR0FcN1iMNEvKthA32qI1tTZYUTML
         iNAw==
X-Gm-Message-State: AOAM531Sk/A214pAU4/Rx9/8nCH3pP+u8fXqYqB6mznTwxJ0UleHkxgX
        3+2NjBqByOGWwd7AW629gGVjYYXRvL7b7wHYw6ZM1Q==
X-Google-Smtp-Source: ABdhPJxvKrVptbQlXd0bbQZSBtQgftUp4OTKOhDY0knzsRgODPz7N5pT9cf3ARauerQHMlmxh2Y7xyI3CPG5aT2u3Gw=
X-Received: by 2002:a05:6e02:1208:: with SMTP id a8mr14845190ilq.118.1591992653917;
 Fri, 12 Jun 2020 13:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <159191202523.31436.11959784252237488867.stgit@bmoger-ubuntu>
 <159191213022.31436.11150808867377936241.stgit@bmoger-ubuntu>
 <CALMp9eSC-wwP50gtprpakKjPYeZ5LdDSFS6i__csVCJwUKmqjA@mail.gmail.com> <d0b09992-eb87-651a-3b97-0787e07cc46d@amd.com>
In-Reply-To: <d0b09992-eb87-651a-3b97-0787e07cc46d@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 12 Jun 2020 13:10:42 -0700
Message-ID: <CALMp9eRZQXgJvt3MGreq47ApM5ObTU7YFQV_GcY5N+jozGK1Uw@mail.gmail.com>
Subject: Re: [PATCH 3/3] KVM:SVM: Enable INVPCID feature on AMD
To:     Babu Moger <babu.moger@amd.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>, Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:35 PM Babu Moger <babu.moger@amd.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Jim Mattson <jmattson@google.com>
> > Sent: Thursday, June 11, 2020 6:51 PM
> > To: Moger, Babu <Babu.Moger@amd.com>
> > Cc: Wanpeng Li <wanpengli@tencent.com>; Joerg Roedel <joro@8bytes.org>;
> > the arch/x86 maintainers <x86@kernel.org>; Sean Christopherson
> > <sean.j.christopherson@intel.com>; Ingo Molnar <mingo@redhat.com>;
> > Borislav Petkov <bp@alien8.de>; H . Peter Anvin <hpa@zytor.com>; Paolo
> > Bonzini <pbonzini@redhat.com>; Vitaly Kuznetsov <vkuznets@redhat.com>;
> > Thomas Gleixner <tglx@linutronix.de>; LKML <linux-kernel@vger.kernel.or=
g>;
> > kvm list <kvm@vger.kernel.org>
> > Subject: Re: [PATCH 3/3] KVM:SVM: Enable INVPCID feature on AMD
> >
> > On Thu, Jun 11, 2020 at 2:48 PM Babu Moger <babu.moger@amd.com> wrote:
> > >
> > > The following intercept is added for INVPCID instruction:
> > > Code    Name            Cause
> > > A2h     VMEXIT_INVPCID  INVPCID instruction
> > >
> > > The following bit is added to the VMCB layout control area
> > > to control intercept of INVPCID:
> > > Byte Offset     Bit(s)    Function
> > > 14h             2         intercept INVPCID
> > >
> > > For the guests with nested page table (NPT) support, the INVPCID
> > > feature works as running it natively. KVM does not need to do any
> > > special handling in this case.
> > >
> > > Interceptions are required in the following cases.
> > > 1. If the guest tries to disable the feature when the underlying
> > > hardware supports it. In this case hypervisor needs to report #UD.
> >
> > Per the AMD documentation, attempts to use INVPCID at CPL>0 will
> > result in a #GP, regardless of the intercept bit. If the guest CPUID
> > doesn't enumerate the feature, shouldn't the instruction raise #UD
> > regardless of CPL? This seems to imply that we should intercept #GP
> > and decode the instruction to see if we should synthesize #UD instead.
>
> Purpose here is to report UD when the guest CPUID doesn't enumerate the
> INVPCID feature When Bare-metal supports it. It seems to work fine for
> that purpose. You are right. The #GP for CPL>0 takes precedence over
> interception. No. I am not planning to intercept GP.

WIthout intercepting #GP, you fail to achieve your stated purpose.

> I will change the text. How about this?
>
> Interceptions are required in the following cases.
> 1. If the guest CPUID doesn't enumerate the INVPCID feature when the
> underlying hardware supports it,  hypervisor needs to report UD. However,
> #GP for CPL>0 takes precedence over interception.

This text is not internally consistent. In one sentence, you say that
"hypervisor needs to report #UD." In the next sentence, you are
essentially saying that the hypervisor doesn't need to report #UD.
Which is it?

> > > 2. When the guest is running with shadow page table enabled, in
> > > this case the hypervisor needs to handle the tlbflush based on the
> > > type of invpcid instruction type.
> > >
> > > AMD documentation for INVPCID feature is available at "AMD64
> > > Architecture Programmer=E2=80=99s Manual Volume 2: System Programming=
,
> > > Pub. 24593 Rev. 3.34(or later)"
> > >
> > > The documentation can be obtained at the links below:
> > > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fwww=
.a
> > md.com%2Fsystem%2Ffiles%2FTechDocs%2F24593.pdf&amp;data=3D02%7C01%7
> > Cbabu.moger%40amd.com%7C36861b25f6d143e3b38e08d80e624472%7C3dd8
> > 961fe4884e608e11a82d994e183d%7C0%7C0%7C637275163374103811&amp;s
> > data=3DE%2Fdb6T%2BdO4nrtUoqhKidF6XyorsWrphj6O4WwNZpmYA%3D&amp;res
> > erved=3D0
> > > Link:
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fbug=
zilla.
> > kernel.org%2Fshow_bug.cgi%3Fid%3D206537&amp;data=3D02%7C01%7Cbabu.m
> > oger%40amd.com%7C36861b25f6d143e3b38e08d80e624472%7C3dd8961fe488
> > 4e608e11a82d994e183d%7C0%7C0%7C637275163374103811&amp;sdata=3Db81
> > 9W%2FhKS93%2BAp3QvcsR0BwTQpUVUFMbIaNaisgWHRY%3D&amp;reserved=3D
> > 0
> > >
> > > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > > ---
> > >  arch/x86/include/asm/svm.h      |    4 ++++
> > >  arch/x86/include/uapi/asm/svm.h |    2 ++
> > >  arch/x86/kvm/svm/svm.c          |   42
> > +++++++++++++++++++++++++++++++++++++++
> > >  3 files changed, 48 insertions(+)
> > >
> > > diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> > > index 62649fba8908..6488094f67fa 100644
> > > --- a/arch/x86/include/asm/svm.h
> > > +++ b/arch/x86/include/asm/svm.h
> > > @@ -55,6 +55,10 @@ enum {
> > >         INTERCEPT_RDPRU,
> > >  };
> > >
> > > +/* Extended Intercept bits */
> > > +enum {
> > > +       INTERCEPT_INVPCID =3D 2,
> > > +};
> > >
> > >  struct __attribute__ ((__packed__)) vmcb_control_area {
> > >         u32 intercept_cr;
> > > diff --git a/arch/x86/include/uapi/asm/svm.h
> > b/arch/x86/include/uapi/asm/svm.h
> > > index 2e8a30f06c74..522d42dfc28c 100644
> > > --- a/arch/x86/include/uapi/asm/svm.h
> > > +++ b/arch/x86/include/uapi/asm/svm.h
> > > @@ -76,6 +76,7 @@
> > >  #define SVM_EXIT_MWAIT_COND    0x08c
> > >  #define SVM_EXIT_XSETBV        0x08d
> > >  #define SVM_EXIT_RDPRU         0x08e
> > > +#define SVM_EXIT_INVPCID       0x0a2
> > >  #define SVM_EXIT_NPF           0x400
> > >  #define SVM_EXIT_AVIC_INCOMPLETE_IPI           0x401
> > >  #define SVM_EXIT_AVIC_UNACCELERATED_ACCESS     0x402
> > > @@ -171,6 +172,7 @@
> > >         { SVM_EXIT_MONITOR,     "monitor" }, \
> > >         { SVM_EXIT_MWAIT,       "mwait" }, \
> > >         { SVM_EXIT_XSETBV,      "xsetbv" }, \
> > > +       { SVM_EXIT_INVPCID,     "invpcid" }, \
> > >         { SVM_EXIT_NPF,         "npf" }, \
> > >         { SVM_EXIT_AVIC_INCOMPLETE_IPI,         "avic_incomplete_ipi"=
 }, \
> > >         { SVM_EXIT_AVIC_UNACCELERATED_ACCESS,
> > "avic_unaccelerated_access" }, \
> > > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > > index 285e5e1ff518..82d974338f68 100644
> > > --- a/arch/x86/kvm/svm/svm.c
> > > +++ b/arch/x86/kvm/svm/svm.c
> > > @@ -813,6 +813,11 @@ static __init void svm_set_cpu_caps(void)
> > >         if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
> > >             boot_cpu_has(X86_FEATURE_AMD_SSBD))
> > >                 kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD);
> > > +
> > > +       /* Enable INVPCID if both PCID and INVPCID enabled */
> > > +       if (boot_cpu_has(X86_FEATURE_PCID) &&
> > > +           boot_cpu_has(X86_FEATURE_INVPCID))
> > > +               kvm_cpu_cap_set(X86_FEATURE_INVPCID);
> > >  }
> > >
> > >  static __init int svm_hardware_setup(void)
> > > @@ -1099,6 +1104,17 @@ static void init_vmcb(struct vcpu_svm *svm)
> > >                 clr_intercept(svm, INTERCEPT_PAUSE);
> > >         }
> > >
> > > +       /*
> > > +        * Intercept INVPCID instruction only if shadow page table is
> > > +        * enabled. Interception is not required with nested page tab=
le.
> > > +        */
> > > +       if (boot_cpu_has(X86_FEATURE_INVPCID)) {
> > > +               if (!npt_enabled)
> > > +                       set_extended_intercept(svm, INTERCEPT_INVPCID=
);
> > > +               else
> > > +                       clr_extended_intercept(svm, INTERCEPT_INVPCID=
);
> > > +       }
> > > +
> > >         if (kvm_vcpu_apicv_active(&svm->vcpu))
> > >                 avic_init_vmcb(svm);
> > >
> > > @@ -2715,6 +2731,23 @@ static int mwait_interception(struct vcpu_svm
> > *svm)
> > >         return nop_interception(svm);
> > >  }
> > >
> > > +static int invpcid_interception(struct vcpu_svm *svm)
> > > +{
> > > +       struct kvm_vcpu *vcpu =3D &svm->vcpu;
> > > +       unsigned long type;
> > > +       gva_t gva;
> > > +
> > > +       /*
> > > +        * For an INVPCID intercept:
> > > +        * EXITINFO1 provides the linear address of the memory operan=
d.
> > > +        * EXITINFO2 provides the contents of the register operand.
> > > +        */
> > > +       type =3D svm->vmcb->control.exit_info_2;
> > > +       gva =3D svm->vmcb->control.exit_info_1;
> > > +
> > > +       return kvm_handle_invpcid_types(vcpu,  gva, type);
> > > +}
> > > +
> > >  static int (*const svm_exit_handlers[])(struct vcpu_svm *svm) =3D {
> > >         [SVM_EXIT_READ_CR0]                     =3D cr_interception,
> > >         [SVM_EXIT_READ_CR3]                     =3D cr_interception,
> > > @@ -2777,6 +2810,7 @@ static int (*const svm_exit_handlers[])(struct
> > vcpu_svm *svm) =3D {
> > >         [SVM_EXIT_MWAIT]                        =3D mwait_interceptio=
n,
> > >         [SVM_EXIT_XSETBV]                       =3D xsetbv_intercepti=
on,
> > >         [SVM_EXIT_RDPRU]                        =3D rdpru_interceptio=
n,
> > > +       [SVM_EXIT_INVPCID]                      =3D invpcid_intercept=
ion,
> > >         [SVM_EXIT_NPF]                          =3D npf_interception,
> > >         [SVM_EXIT_RSM]                          =3D rsm_interception,
> > >         [SVM_EXIT_AVIC_INCOMPLETE_IPI]          =3D
> > avic_incomplete_ipi_interception,
> > > @@ -3562,6 +3596,14 @@ static void svm_cpuid_update(struct kvm_vcpu
> > *vcpu)
> > >         svm->nrips_enabled =3D kvm_cpu_cap_has(X86_FEATURE_NRIPS) &&
> > >                              guest_cpuid_has(&svm->vcpu, X86_FEATURE_=
NRIPS);
> > >
> > > +       /*
> > > +        * Intercept INVPCID instruction if the baremetal has the sup=
port
> > > +        * but the guest doesn't claim the feature.
> > > +        */
> > > +       if (boot_cpu_has(X86_FEATURE_INVPCID) &&
> > > +           !guest_cpuid_has(vcpu, X86_FEATURE_INVPCID))
> > > +               set_extended_intercept(svm, INTERCEPT_INVPCID);
> > > +
> >
> > What if INVPCID is enabled in the guest CPUID later? Shouldn't we then
> > clear this intercept bit?
>
> I assume the feature enable comes in the same code path as this. I can ad=
d
> "if else" check here if that is what you are suggesting.

Yes, that's what I'm suggesting.

> >
> > >         if (!kvm_vcpu_apicv_active(vcpu))
> > >                 return;
> > >
> > >
