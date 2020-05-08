Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB32C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0375B214D8
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 22:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MaaAO/4q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgEHWKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 18:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728119AbgEHWKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 18:10:05 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20041C05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 15:10:05 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id j8so3319213iog.13
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 15:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nusPb2sm/Fbi6nqwK3qRC9PSoAH5gZT7xMnD7K9FGgQ=;
        b=MaaAO/4qJiTJOKHvMWzmPN+i4TGOrwjJsVaHjxyRvihJnTLevtpZthc/Ed0uJRQ2Ix
         0zADAoLuJjD1TdyNpdVf4rcfu+dO722asWLDVzROvKaWnJj1XERmrBDOWO9MDRyTOztZ
         3UA7yLiCHEJO9GnXdRLMM1D65aLnaFPDh+0lNPESEuvJkfSmqrziLOGOhdQguTfZuUFz
         QjEewW3yH8/FvgNETo2xGqS6cv8Exkz0DQ/aIBxS/1NVl93cvXVIEbzmQzUgdHKyI5jb
         JJCP2PErWB9JXMnT6piuzfbylFU4qNHEsRPZaVgrbM7RwSoQkY3bUJAkOmCGL1/Tl456
         wvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nusPb2sm/Fbi6nqwK3qRC9PSoAH5gZT7xMnD7K9FGgQ=;
        b=uPyaGUBlpUuvq6Q8qzr0NgOG3inv8dxcIwB7iOyF++9V0aV+1qMUkFC+tVR/+iGuQa
         KTAZnCPwZUmQjjSx+/rkjvA3nYRa9Ms9/ok3pcg8sk9mm3B/l5LpioBRPtq2ogj3hkOK
         sm2U3oa/edoyrcpWxJJTd2jsnLyK51zM/Uv162iPMuDq7b2ve+rFndbXIcgBDhU8wKEN
         1/ENpcKHFTGspQS8FkWd+9RfPJ8GT2Uwac04zom8fYuJ56kzU4raJrt478sysyf64ETE
         sJ4w19vmmtFQFabsBahqazq0IvshJ6fN4Z4kwvST+iGaYEhdGPjAXNkmKQ1HzV/97WGR
         CfzA==
X-Gm-Message-State: AGi0PuZT37rX03N0AicZ7FySMv+ZSCytnDbvwjbasm4ykNhAzAXILnzW
        kBE3iMFcFEbU7Q4LqTF4hDoZWkmDCu7cpuJs1O8bRQ==
X-Google-Smtp-Source: APiQypJrpBPLPYZzL7+Fp9TRLRDmTC3LvcFRS7xPU6jJ42Dg0nsiTxXzKkTFj2AzTvq6quzZeXDUAn497afEP0713TU=
X-Received: by 2002:a6b:6318:: with SMTP id p24mr4862161iog.12.1588975803925;
 Fri, 08 May 2020 15:10:03 -0700 (PDT)
MIME-Version: 1.0
References: <158897190718.22378.3974700869904223395.stgit@naples-babu.amd.com> <158897219574.22378.9077333868984828038.stgit@naples-babu.amd.com>
In-Reply-To: <158897219574.22378.9077333868984828038.stgit@naples-babu.amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 8 May 2020 15:09:52 -0700
Message-ID: <CALMp9eQj_aFcqR+v9SvFjKFxVjaHHzU44udcczJVqOR5vLQbWQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] KVM: x86: Move pkru save/restore to x86.c
To:     Babu Moger <babu.moger@amd.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        mchehab+samsung@kernel.org, changbin.du@intel.com,
        Nadav Amit <namit@vmware.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        yang.shi@linux.alibaba.com, asteinhauser@google.com,
        anshuman.khandual@arm.com, Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        steven.price@arm.com, rppt@linux.vnet.ibm.com, peterx@redhat.com,
        Dan Williams <dan.j.williams@intel.com>, arjunroy@google.com,
        logang@deltatee.com, Thomas Hellstrom <thellstrom@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>, justin.he@arm.com,
        robin.murphy@arm.com, ira.weiny@intel.com,
        Kees Cook <keescook@chromium.org>,
        Juergen Gross <jgross@suse.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        pawan.kumar.gupta@linux.intel.com,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        vineela.tummalapalli@intel.com, yamada.masahiro@socionext.com,
        sam@ravnborg.org, acme@redhat.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 2:10 PM Babu Moger <babu.moger@amd.com> wrote:
>
> PKU feature is supported by both VMX and SVM. So we can
> safely move pkru state save/restore to common code.
> Also move all the pkru data structure to kvm_vcpu_arch.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/include/asm/kvm_host.h |    1 +
>  arch/x86/kvm/vmx/vmx.c          |   18 ------------------
>  arch/x86/kvm/x86.c              |   20 ++++++++++++++++++++
>  3 files changed, 21 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 42a2d0d3984a..afd8f3780ae0 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -578,6 +578,7 @@ struct kvm_vcpu_arch {
>         unsigned long cr4;
>         unsigned long cr4_guest_owned_bits;
>         unsigned long cr8;
> +       u32 host_pkru;
>         u32 pkru;
>         u32 hflags;
>         u64 efer;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index c2c6335a998c..46898a476ba7 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1372,7 +1372,6 @@ void vmx_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>
>         vmx_vcpu_pi_load(vcpu, cpu);
>
> -       vmx->host_pkru = read_pkru();
>         vmx->host_debugctlmsr = get_debugctlmsr();
>  }
>
> @@ -6577,11 +6576,6 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
>
>         kvm_load_guest_xsave_state(vcpu);
>
> -       if (static_cpu_has(X86_FEATURE_PKU) &&
> -           kvm_read_cr4_bits(vcpu, X86_CR4_PKE) &&
> -           vcpu->arch.pkru != vmx->host_pkru)
> -               __write_pkru(vcpu->arch.pkru);
> -
>         pt_guest_enter(vmx);
>
>         if (vcpu_to_pmu(vcpu)->version)
> @@ -6671,18 +6665,6 @@ static void vmx_vcpu_run(struct kvm_vcpu *vcpu)
>
>         pt_guest_exit(vmx);
>
> -       /*
> -        * eager fpu is enabled if PKEY is supported and CR4 is switched
> -        * back on host, so it is safe to read guest PKRU from current
> -        * XSAVE.
> -        */
> -       if (static_cpu_has(X86_FEATURE_PKU) &&
> -           kvm_read_cr4_bits(vcpu, X86_CR4_PKE)) {
> -               vcpu->arch.pkru = rdpkru();
> -               if (vcpu->arch.pkru != vmx->host_pkru)
> -                       __write_pkru(vmx->host_pkru);
> -       }
> -
>         kvm_load_host_xsave_state(vcpu);
>
>         vmx->nested.nested_run_pending = 0;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c5835f9cb9ad..1b27e78fb3c1 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -836,11 +836,28 @@ void kvm_load_guest_xsave_state(struct kvm_vcpu *vcpu)
>                     vcpu->arch.ia32_xss != host_xss)
>                         wrmsrl(MSR_IA32_XSS, vcpu->arch.ia32_xss);
>         }
> +
> +       if (static_cpu_has(X86_FEATURE_PKU) &&
> +           kvm_read_cr4_bits(vcpu, X86_CR4_PKE) &&
> +           vcpu->arch.pkru != vcpu->arch.host_pkru)
> +               __write_pkru(vcpu->arch.pkru);

This doesn't seem quite right to me. Though rdpkru and wrpkru are
contingent upon CR4.PKE, the PKRU resource isn't. It can be read with
XSAVE and written with XRSTOR. So, if we don't set the guest PKRU
value here, the guest can read the host value, which seems dodgy at
best.

Perhaps the second conjunct should be: (kvm_read_cr4_bits(vcpu,
X86_CR4_PKE) || (vcpu->arch.xcr0 & XFEATURE_MASK_PKRU)).

>  }
>  EXPORT_SYMBOL_GPL(kvm_load_guest_xsave_state);
>
>  void kvm_load_host_xsave_state(struct kvm_vcpu *vcpu)
>  {
> +       /*
> +        * eager fpu is enabled if PKEY is supported and CR4 is switched
> +        * back on host, so it is safe to read guest PKRU from current
> +        * XSAVE.
> +        */

I don't understand the relevance of this comment to the code below.

> +       if (static_cpu_has(X86_FEATURE_PKU) &&
> +           kvm_read_cr4_bits(vcpu, X86_CR4_PKE)) {
> +               vcpu->arch.pkru = rdpkru();
> +               if (vcpu->arch.pkru != vcpu->arch.host_pkru)
> +                       __write_pkru(vcpu->arch.host_pkru);
> +       }
> +

Same concern as above, but perhaps worse in this instance, since a
guest with CR4.PKE clear could potentially use XRSTOR to change the
host PKRU value.

>         if (kvm_read_cr4_bits(vcpu, X86_CR4_OSXSAVE)) {
>
>                 if (vcpu->arch.xcr0 != host_xcr0)
> @@ -3570,6 +3587,9 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>
>         kvm_x86_ops.vcpu_load(vcpu, cpu);
>
> +       /* Save host pkru register if supported */
> +       vcpu->arch.host_pkru = read_pkru();
> +
>         /* Apply any externally detected TSC adjustments (due to suspend) */
>         if (unlikely(vcpu->arch.tsc_offset_adjustment)) {
>                 adjust_tsc_offset_host(vcpu, vcpu->arch.tsc_offset_adjustment);
>
