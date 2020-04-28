Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15940C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 00:29:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8E632075E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 00:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ORd7/HnR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726398AbgD1A3H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 20:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726016AbgD1A3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 20:29:06 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90918C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 17:29:06 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id i16so18600959ils.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 17:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8Z3XKyHxAG7IUAvzD9JfBuXDfdRYbv9qqPO6eeYSrFk=;
        b=ORd7/HnRA28Oya0GJjq9fEZBcHElM84CebAGT4i17uPekgJx2dJnHcDe0AwBvb+NwJ
         BvxTMdG5eJHN2Arut0iXak3+TVVQqJZNkMADD5eTou0O/biFl0+XHSQu6YchIsvOdfPQ
         Qa6vAx0Zx4tx9ZNlgdiSSCrcDooIBRmJTN/4T7cwnMmBIT6c5uzfXDjkwAu3GXtFrFXc
         7/121vdRAmQ/izha0afgQbXyNncGbFsL79Zvd6Ncxp7hzKli0XC3Vv5abDouCS49QWDy
         tBwlGrb3lEgcEy4V8pJ9Q8s8kw1ox5zPvbzuTaA3xItOcGLUu42+DqABWJNOboJG3iNH
         glVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8Z3XKyHxAG7IUAvzD9JfBuXDfdRYbv9qqPO6eeYSrFk=;
        b=CEz99Cc0FJQ1r3Ej7WguxL2qvnBUv1jbcFOaERqp3W7OjGTsalz0GmwULnCbxv+Q2r
         V2xl1qvOdoOfo9S/FevH+nMRpCYrwmzXXxbMJpUJviqfDomC+uCcldpm4R0Gjfl/CL5+
         YAGLIMHo4+K/6LT5f+3YF+Su4N7roCgFEr/8COlJ12DzNBlEvHTF2IWRwXOkSBcRPQUH
         ez+V610EG2Lyk1MHvx2FqwQnMjQ1ZIQfef5ls1NV6hhT6ckDbo8L2D0rOnomAO3t9hK9
         2HpgoZ5eMQh//tsh534mPFyfEGre3WYEXmHgXVyUgR6ZXKynjXMl5yQYpndXNnEEorEk
         5bfw==
X-Gm-Message-State: AGi0PuYf+YTT73nOKCJaqojxTZOyDgaL0KfVc/m+KTwiDt/yWahLxBrb
        6brx+NYJSaDHF0oXZH/+vmAXPF9OJsvagGY+JPBKeQ==
X-Google-Smtp-Source: APiQypKNcYUgCo9BYCsRgOoS0qjiW7kuAUtuQNqf8nOHc8HFG6NxKxozTIoOpNtW1E0Z1daC2YmA8D+pFaUvVC9fUa0=
X-Received: by 2002:a92:d8ca:: with SMTP id l10mr23867156ilo.118.1588033745597;
 Mon, 27 Apr 2020 17:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200427165917.31799-1-pbonzini@redhat.com>
In-Reply-To: <20200427165917.31799-1-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 27 Apr 2020 17:28:54 -0700
Message-ID: <CALMp9eTBs=deSYu1=CMLwZcO8HTpGM2JsgDxvFR1Y220tdUQ3w@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: handle wrap around 32-bit address space
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Joerg Roedel <joro@8bytes.org>, everdox@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 9:59 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> KVM is not handling the case where EIP wraps around the 32-bit address
> space (that is, outside long mode).  This is needed both in vmx.c
> and in emulate.c.  SVM with NRIPS is okay, but it can still print
> an error to dmesg due to integer overflow.
>
> Reported-by: Nick Peterson <everdox@gmail.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/emulate.c |  2 ++
>  arch/x86/kvm/svm/svm.c |  3 ---
>  arch/x86/kvm/vmx/vmx.c | 15 ++++++++++++---
>  3 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
> index bddaba9c68dd..de5476f8683e 100644
> --- a/arch/x86/kvm/emulate.c
> +++ b/arch/x86/kvm/emulate.c
> @@ -5798,6 +5798,8 @@ int x86_emulate_insn(struct x86_emulate_ctxt *ctxt)
>         }
>
>         ctxt->eip = ctxt->_eip;
> +       if (ctxt->mode != X86EMUL_MODE_PROT64)
> +               ctxt->eip = (u32)ctxt->_eip;
>
>  done:
>         if (rc == X86EMUL_PROPAGATE_FAULT) {
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 8f8fc65bfa3e..d5e72b22bc87 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -319,9 +319,6 @@ static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
>                 if (!kvm_emulate_instruction(vcpu, EMULTYPE_SKIP))
>                         return 0;
>         } else {
> -               if (svm->next_rip - kvm_rip_read(vcpu) > MAX_INST_SIZE)
> -                       pr_err("%s: ip 0x%lx next 0x%llx\n",
> -                              __func__, kvm_rip_read(vcpu), svm->next_rip);
>                 kvm_rip_write(vcpu, svm->next_rip);
>         }
>         svm_set_interrupt_shadow(vcpu, 0);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 3ab6ca6062ce..ed1ffc8a727b 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1556,7 +1556,7 @@ static int vmx_rtit_ctl_check(struct kvm_vcpu *vcpu, u64 data)
>
>  static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
>  {
> -       unsigned long rip;
> +       unsigned long rip, orig_rip;
>
>         /*
>          * Using VMCS.VM_EXIT_INSTRUCTION_LEN on EPT misconfig depends on
> @@ -1568,8 +1568,17 @@ static int skip_emulated_instruction(struct kvm_vcpu *vcpu)
>          */
>         if (!static_cpu_has(X86_FEATURE_HYPERVISOR) ||
>             to_vmx(vcpu)->exit_reason != EXIT_REASON_EPT_MISCONFIG) {
> -               rip = kvm_rip_read(vcpu);
> -               rip += vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
> +               orig_rip = kvm_rip_read(vcpu);
> +               rip = orig_rip + vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
> +#ifdef CONFIG_X86_64
> +               /*
> +                * We need to mask out the high 32 bits of RIP if not in 64-bit
> +                * mode, but just finding out that we are in 64-bit mode is
> +                * quite expensive.  Only do it if there was a carry.
> +                */
> +               if (unlikely(((rip ^ orig_rip) >> 31) == 3) && !is_64_bit_mode(vcpu))

Is it actually possible to wrap around 0 without getting a segment
limit violation, or is it only possible to wrap *to* 0 (i.e. rip==1ull
<< 32)?

> +                       rip = (u32)rip;
> +#endif
>                 kvm_rip_write(vcpu, rip);
>         } else {
>                 if (!kvm_emulate_instruction(vcpu, EMULTYPE_SKIP))
> --
> 2.18.2
>
