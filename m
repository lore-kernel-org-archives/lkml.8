Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 058F5C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 23:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7CCE207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 23:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bjlqAFcz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgG1X4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730005AbgG1X4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 19:56:35 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B7BC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 16:56:33 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id w12so9052921iom.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 16:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZRKIb/GV/uNfWatTktjwXdsyVxOencp6+U5KXe3/EM0=;
        b=bjlqAFcz1KzWHHX/Dy3ROA0rFYIm5tUUUIo9quDKeEDM2refG2OxElPIl+OkKKLLmy
         RVwmvLwRythbgzJPH9SJ3p5aWY69QYtTRSO2NH1RPR4VQ5Jh7Nfph1Y/zXm6VmngROFr
         KQgvDepKX9L3uwAgD+eiVyx/kLf6LnqCKCz7hpTQya1YOtyZUNajherBiHw/+Xnbx+37
         8BYbKAOq7POmB0wpQL4/GlCH/eo6+P7zuxJPla+/nAa9svXPYdwdzPaX/cbb8/csV+xV
         XpZXX6OXt0UwXsMJp+UvqrXAbmDCtt5fWJPpNmQm/tFAcYTiw5oF7CmpP3Xi67kkWaPA
         JQqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZRKIb/GV/uNfWatTktjwXdsyVxOencp6+U5KXe3/EM0=;
        b=tFG0xetnAHIcylTrAe+0na5l+9OHDvUUTwrNFncjTb4GvDwgL4VKlgCDZMebbX0nbt
         Ssngp40dDWAyZNGN4b3YEsHa6NVcnRi58ZH6j31nhX5N4PFapBh62XTT5DzfBk4aN43K
         zlUd0mewNz/08FOjx0F74K3XE01DADnk7gZSyuqh9v/FTrO0BypYSasSm0dSZiFlWBzU
         S3Mm9ydpXkAFKCJ35RxgtaJ+cWc0WhW/iFTGf5gp9U0lLu3pbuUNEUtnaZLEyK9dPtu8
         V6ligtjzVRUAs/71FC9PPOlDL6WPR2o1QttYDXOF9u8iE3+nLFnsS01Jt4HOHeMsWzi7
         +u5g==
X-Gm-Message-State: AOAM533ovii18I8zxBnQuoQlgy2+StRw921wgJZ+htooFdkpTPp30EpQ
        IQ3IOw1DU1iCqGBBjdYzTAllBnLPmaqJ5Dw7fY9LgA==
X-Google-Smtp-Source: ABdhPJygKGngxFZk3M4N8S/RnSBQAqiTzH26Kx5KsB/uPXk9dBCJEp8PoNiw3pf9j0qztcHp9otqdU7wLldqNCRPJuM=
X-Received: by 2002:a6b:c3cf:: with SMTP id t198mr30794629iof.164.1595980592882;
 Tue, 28 Jul 2020 16:56:32 -0700 (PDT)
MIME-Version: 1.0
References: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu> <159597948045.12744.16141020747986494741.stgit@bmoger-ubuntu>
In-Reply-To: <159597948045.12744.16141020747986494741.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Jul 2020 16:56:21 -0700
Message-ID: <CALMp9eTDKX7L0ntOo-hsirk2dET1ZG4tofgvQ4SX9kdwEQoPtw@mail.gmail.com>
Subject: Re: [PATCH v3 02/11] KVM: SVM: Change intercept_cr to generic intercepts
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 4:38 PM Babu Moger <babu.moger@amd.com> wrote:
>
> Change intercept_cr to generic intercepts in vmcb_control_area.
> Use the new __set_intercept, __clr_intercept and __is_intercept
> where applicable.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/include/asm/svm.h |   42 ++++++++++++++++++++++++++++++++----------
>  arch/x86/kvm/svm/nested.c  |   26 +++++++++++++++++---------
>  arch/x86/kvm/svm/svm.c     |    4 ++--
>  arch/x86/kvm/svm/svm.h     |    6 +++---
>  4 files changed, 54 insertions(+), 24 deletions(-)
>
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 8a1f5382a4ea..d4739f4eae63 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -4,6 +4,37 @@
>
>  #include <uapi/asm/svm.h>
>
> +/*
> + * VMCB Control Area intercept bits starting
> + * at Byte offset 000h (Vector 0).
> + */
> +
> +enum vector_offset {
> +       CR_VECTOR = 0,
> +       MAX_VECTORS,
> +};
> +
> +enum {
> +       /* Byte offset 000h (Vector 0) */
> +       INTERCEPT_CR0_READ = 0,
> +       INTERCEPT_CR1_READ,
> +       INTERCEPT_CR2_READ,
> +       INTERCEPT_CR3_READ,
> +       INTERCEPT_CR4_READ,
> +       INTERCEPT_CR5_READ,
> +       INTERCEPT_CR6_READ,
> +       INTERCEPT_CR7_READ,
> +       INTERCEPT_CR8_READ,
> +       INTERCEPT_CR0_WRITE = 16,
> +       INTERCEPT_CR1_WRITE,
> +       INTERCEPT_CR2_WRITE,
> +       INTERCEPT_CR3_WRITE,
> +       INTERCEPT_CR4_WRITE,
> +       INTERCEPT_CR5_WRITE,
> +       INTERCEPT_CR6_WRITE,
> +       INTERCEPT_CR7_WRITE,
> +       INTERCEPT_CR8_WRITE,
> +};
>
>  enum {
>         INTERCEPT_INTR,
> @@ -57,7 +88,7 @@ enum {
>
>
>  struct __attribute__ ((__packed__)) vmcb_control_area {
> -       u32 intercept_cr;
> +       u32 intercepts[MAX_VECTORS];
>         u32 intercept_dr;
>         u32 intercept_exceptions;
>         u64 intercept;
> @@ -240,15 +271,6 @@ struct __attribute__ ((__packed__)) vmcb {
>  #define SVM_SELECTOR_READ_MASK SVM_SELECTOR_WRITE_MASK
>  #define SVM_SELECTOR_CODE_MASK (1 << 3)
>
> -#define INTERCEPT_CR0_READ     0
> -#define INTERCEPT_CR3_READ     3
> -#define INTERCEPT_CR4_READ     4
> -#define INTERCEPT_CR8_READ     8
> -#define INTERCEPT_CR0_WRITE    (16 + 0)
> -#define INTERCEPT_CR3_WRITE    (16 + 3)
> -#define INTERCEPT_CR4_WRITE    (16 + 4)
> -#define INTERCEPT_CR8_WRITE    (16 + 8)
> -
>  #define INTERCEPT_DR0_READ     0
>  #define INTERCEPT_DR1_READ     1
>  #define INTERCEPT_DR2_READ     2
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 6bceafb19108..46f5c82d9b45 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -105,6 +105,7 @@ static void nested_svm_uninit_mmu_context(struct kvm_vcpu *vcpu)
>  void recalc_intercepts(struct vcpu_svm *svm)
>  {
>         struct vmcb_control_area *c, *h, *g;
> +       unsigned int i;
>
>         mark_dirty(svm->vmcb, VMCB_INTERCEPTS);
>
> @@ -117,15 +118,17 @@ void recalc_intercepts(struct vcpu_svm *svm)
>
>         svm->nested.host_intercept_exceptions = h->intercept_exceptions;
>
> -       c->intercept_cr = h->intercept_cr;
> +       for (i = 0; i < MAX_VECTORS; i++)
> +               c->intercepts[i] = h->intercepts[i];
> +
>         c->intercept_dr = h->intercept_dr;
>         c->intercept_exceptions = h->intercept_exceptions;
>         c->intercept = h->intercept;
>
>         if (g->int_ctl & V_INTR_MASKING_MASK) {
>                 /* We only want the cr8 intercept bits of L1 */
> -               c->intercept_cr &= ~(1U << INTERCEPT_CR8_READ);
> -               c->intercept_cr &= ~(1U << INTERCEPT_CR8_WRITE);
> +               __clr_intercept(&c->intercepts, INTERCEPT_CR8_READ);
> +               __clr_intercept(&c->intercepts, INTERCEPT_CR8_WRITE);

Why the direct calls to the __clr_intercept worker function? Can't
these be calls to clr_cr_intercept()?
Likewise throughout.
