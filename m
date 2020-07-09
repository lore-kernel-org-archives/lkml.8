Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEA4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B53C9207F9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gSQofJDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgGIRND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727091AbgGIRNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:13:02 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 249C8C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 10:13:02 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id i18so2656296ilk.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 10:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QO9IvrvbdFbIKVhCbtd7ASpLnMxeM4m98MgJitQIbbM=;
        b=gSQofJDz/xtC3LY7CHzehbvYXFf8x2QKBUjKyVSTLKCjJLkgB0FkC7RWx2bpt7S9yF
         nZRhB1Sf/zjf4V4rI0AgecBncWsepMGOCtF2RkK7eYiTfmVY63TuujpmbHzfWwoC8K2Q
         slRXybq4eTpBGXaGeRP1mF/pKXKK4hCQby2KJYK51GTq8PxDflwr1419KwYCSL5R2M+t
         3BX73E/XD/fheLb7KhX9lvzGwqnPnoUXZXaFFmpHXA0VF+knCT9MlLeZBsPqRN0x4Wug
         FXzoGeD1e3r2Px6IoEhBniy9/bkBGVB01lLqKuLwb4iAd6s2JzmCfGel8wtU9H1GNGBQ
         0dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QO9IvrvbdFbIKVhCbtd7ASpLnMxeM4m98MgJitQIbbM=;
        b=XW2UrfL7l6RJ5lIf4bvxTmAom8SlF/1PLMubNI3iGpG30pvDeGovA2U90y6Y/x21BV
         /+4FLKzgOM3uWpZx58yMARV79ksSe5rlLOsPzgKYvnvcY79bQYYDX1e856gYKMBt3PB4
         VUMGHLbR79+C3nieRACOc7j80dA0SIwoYXW2hHQt7qpAYxdSpWLI+jL26Sb9SuOPxLMM
         H6p+KZ+WF3Dc2h0Eyg3tQ5LcURmph2Ljd/b3wM8H6TCmSowzyuVdsY1bufOq2cKvgygu
         /nlqv3Ey4a5S8ToibZozyqW/6dHwlxJyDkNAT7bBw5f9/sl52t5vI2DTARBo4M3RrnU0
         6YKg==
X-Gm-Message-State: AOAM53296NMdgb2U7lLvhgI1iaK6LE7180cN1p9rOjNLxbJyC/tZc/hn
        zpbUg7UV7OyDZ1yRuhWIyuiveL1KD2EHCnnXBSROMw==
X-Google-Smtp-Source: ABdhPJxa4dFEbhQpI8FUCI9c4RTZ/KqESl+J/S5E5+jrfkm0yt9foFGwK9W9gn7Ks2MUKg5pWO1OYTddy9xukrw/XGo=
X-Received: by 2002:a05:6e02:de6:: with SMTP id m6mr47104980ilj.296.1594314781244;
 Thu, 09 Jul 2020 10:13:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200709095525.907771-1-pbonzini@redhat.com>
In-Reply-To: <20200709095525.907771-1-pbonzini@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 9 Jul 2020 10:12:50 -0700
Message-ID: <CALMp9eREY4e7kb22CxReNV83HwR7D_tBkn2i5LUbGLGe_yw5nQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: vmentry ignores EFER.LMA and possibly RFLAGS.VM
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 2:55 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> AMD doesn't specify (unlike Intel) that EFER.LME, CR0.PG and
> EFER.LMA must be consistent, and for SMM state restore they say that
> "The EFER.LMA register bit is set to the value obtained by logically
> ANDing the SMRAM values of EFER.LME, CR0.PG, and CR4.PAE".  It turns
> out that this is also true for vmentry: the EFER.LMA value in the VMCB
> is completely ignored, and so is EFLAGS.VM if the processor is in
> long mode or real mode.
>
> Implement these quirks; the EFER.LMA part is needed because svm_set_efer
> looks at the LMA bit in order to support EFER.NX=0, while the EFLAGS.VM
> part is just because we can.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/svm/nested.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 402ea5b412f0..1c82a1789e0e 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -337,6 +337,24 @@ static void nested_vmcb_save_pending_event(struct vcpu_svm *svm,
>
>  static void nested_prepare_vmcb_save(struct vcpu_svm *svm, struct vmcb *nested_vmcb)
>  {
> +       u64 efer = nested_vmcb->save.efer;
> +
> +       /* The processor ignores EFER.LMA, but svm_set_efer needs it.  */
> +       efer &= ~EFER_LMA;
> +       if ((nested_vmcb->save.cr0 & X86_CR0_PG)
> +           && (nested_vmcb->save.cr4 & X86_CR4_PAE)
> +           && (efer & EFER_LME))
> +               efer |= EFER_LMA;

The CR4.PAE check is unnecessary, isn't it? The combination CR0.PG=1,
EFER.LMA=1, and CR4.PAE=0 is not a legal processor state.

According to the SDM,

* IA32_EFER.LME cannot be modified while paging is enabled (CR0.PG =
1). Attempts to do so using WRMSR cause a general-protection exception
(#GP(0)).
* Paging cannot be enabled (by setting CR0.PG to 1) while CR4.PAE = 0
and IA32_EFER.LME = 1. Attempts to do so using MOV to CR0 cause a
general-protection exception (#GP(0)).
* CR4.PAE and CR4.LA57 cannot be modified while either 4-level paging
or 5-level paging is in use (when CR0.PG = 1 and IA32_EFER.LME = 1).
Attempts to do so using MOV to CR4 cause a general-protection
exception (#GP(0)).

> +
> +       /*
> +        * Likewise RFLAGS.VM is cleared if inconsistent with other processor
> +        * state.  This is sort-of documented in "10.4 Leaving SMM" but applies
> +        * to SVM as well.
> +        */
> +       if (!(nested_vmcb->save.cr0 & X86_CR0_PE)
> +           || (efer & EFER_LMA))
> +               nested_vmcb->save.rflags &= ~X86_EFLAGS_VM;
> +
>         /* Load the nested guest state */
>         svm->vmcb->save.es = nested_vmcb->save.es;
>         svm->vmcb->save.cs = nested_vmcb->save.cs;
> @@ -345,7 +363,7 @@ static void nested_prepare_vmcb_save(struct vcpu_svm *svm, struct vmcb *nested_v
>         svm->vmcb->save.gdtr = nested_vmcb->save.gdtr;
>         svm->vmcb->save.idtr = nested_vmcb->save.idtr;
>         kvm_set_rflags(&svm->vcpu, nested_vmcb->save.rflags);
> -       svm_set_efer(&svm->vcpu, nested_vmcb->save.efer);
> +       svm_set_efer(&svm->vcpu, efer);
>         svm_set_cr0(&svm->vcpu, nested_vmcb->save.cr0);
>         svm_set_cr4(&svm->vcpu, nested_vmcb->save.cr4);
>         (void)kvm_set_cr3(&svm->vcpu, nested_vmcb->save.cr3);
> --
> 2.26.2
>
