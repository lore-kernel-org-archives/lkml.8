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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B40C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 23:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C293207FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 23:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ecg8Nznt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbgG1X7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 19:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729819AbgG1X7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 19:59:32 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424C0C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 16:59:32 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z17so2715710ill.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 16:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9hvzkpxHmaQV6FHo9T7cZmNa5dzo/DUpG3/xaJGDxA=;
        b=ecg8Nznt1VsMuTjkHAY+9SNEwUNTzklupwTYqDIDX1Cd2+k8dfSB+XfINUqzleysg6
         0+8lMXMaDLY30DXfM7oR9hmSpWco87YoypTObtjfCAiCnMxmQByqBbKudxu3ipJg57l8
         YjqeA/jcdNA95dRxA7IVfl5VQvWTkB2lQR8EvcaMGfz8TkSBsqY9iawutOspBwJOkm0V
         cg2//lV50zp7u3I4teZDPq/nJtz6Jv4INYmTBl9p0Q33D3UGhVBz+HdAm+lTibj3P+HB
         M+FiODdHh8Rt83cpeLjzYFdP55ti+AD5oEeb5EFEucgbfAZWhXpTOinJNw3gFe6El1f1
         J7vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9hvzkpxHmaQV6FHo9T7cZmNa5dzo/DUpG3/xaJGDxA=;
        b=OTEY5T/W/p5XXpjjNbkubJmlfTyk0XFlaFMuvIrsTF+eSL6vXxmTGWv4zp5WbwFU4G
         sgjMfCpbnPLBphDD8DaLJXGT8saKzhMlq2IvFmv6VZUbOWv+xWlQyjuqrigv1vNE06WZ
         bK9+WjnhsO5RBtNykCPtFI/DrwhQvX0FrvIj/NiL7o5piTKV43bL51Wigq4HXuUmbhRz
         ONw+jBElShK1p7KgpumKNb0UOHy+oEeuwriGRpY7srbKxLyTy99Wcp4H9Bh5ARYpXbf2
         wtNFqa5e74zmmHqX6Xy87exSMMPdwjg57rds4PX2jDWJf3k2zOcP/Kc1aDexZRwEU9pf
         oNRA==
X-Gm-Message-State: AOAM5336al2F8QQIUterzypPjUrOyArn8LK8s6bEelfVH9aAFU9O493k
        tJSFtoY/dNbMY88GSQlxsUOatuQsrbuKu+uEAsyoIA==
X-Google-Smtp-Source: ABdhPJxMzp2Gl7/okRSvj7Xg43YM8yRT++R3SNarVL/vIHv7VyijUiVfb2ygRvrp40Raj6j6xHGHEhOErj6LpYvFhCk=
X-Received: by 2002:a92:b60a:: with SMTP id s10mr24335751ili.119.1595980771390;
 Tue, 28 Jul 2020 16:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu> <159597948692.12744.7037992839778140055.stgit@bmoger-ubuntu>
In-Reply-To: <159597948692.12744.7037992839778140055.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Jul 2020 16:59:20 -0700
Message-ID: <CALMp9eRF-ScqaWG7vn2mxKmR4jWo7LYZiiicHksiZR9hh+G=-A@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] KVM: SVM: Change intercept_dr to generic intercepts
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
> Modify intercept_dr to generic intercepts in vmcb_control_area.
> Use generic __set_intercept, __clr_intercept and __is_intercept
> to set/clear/test the intercept_dr bits.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/include/asm/svm.h |   36 ++++++++++++++++++------------------
>  arch/x86/kvm/svm/nested.c  |    6 +-----
>  arch/x86/kvm/svm/svm.c     |    4 ++--
>  arch/x86/kvm/svm/svm.h     |   34 +++++++++++++++++-----------------
>  4 files changed, 38 insertions(+), 42 deletions(-)
>
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index d4739f4eae63..ffc89d8e4fcb 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -11,6 +11,7 @@
>
>  enum vector_offset {
>         CR_VECTOR = 0,
> +       DR_VECTOR,
>         MAX_VECTORS,
>  };
>
> @@ -34,6 +35,23 @@ enum {
>         INTERCEPT_CR6_WRITE,
>         INTERCEPT_CR7_WRITE,
>         INTERCEPT_CR8_WRITE,
> +       /* Byte offset 004h (Vector 1) */
> +       INTERCEPT_DR0_READ = 32,
> +       INTERCEPT_DR1_READ,
> +       INTERCEPT_DR2_READ,
> +       INTERCEPT_DR3_READ,
> +       INTERCEPT_DR4_READ,
> +       INTERCEPT_DR5_READ,
> +       INTERCEPT_DR6_READ,
> +       INTERCEPT_DR7_READ,
> +       INTERCEPT_DR0_WRITE = 48,
> +       INTERCEPT_DR1_WRITE,
> +       INTERCEPT_DR2_WRITE,
> +       INTERCEPT_DR3_WRITE,
> +       INTERCEPT_DR4_WRITE,
> +       INTERCEPT_DR5_WRITE,
> +       INTERCEPT_DR6_WRITE,
> +       INTERCEPT_DR7_WRITE,
>  };
>
>  enum {
> @@ -89,7 +107,6 @@ enum {
>
>  struct __attribute__ ((__packed__)) vmcb_control_area {
>         u32 intercepts[MAX_VECTORS];
> -       u32 intercept_dr;
>         u32 intercept_exceptions;
>         u64 intercept;
>         u8 reserved_1[40];
> @@ -271,23 +288,6 @@ struct __attribute__ ((__packed__)) vmcb {
>  #define SVM_SELECTOR_READ_MASK SVM_SELECTOR_WRITE_MASK
>  #define SVM_SELECTOR_CODE_MASK (1 << 3)
>
> -#define INTERCEPT_DR0_READ     0
> -#define INTERCEPT_DR1_READ     1
> -#define INTERCEPT_DR2_READ     2
> -#define INTERCEPT_DR3_READ     3
> -#define INTERCEPT_DR4_READ     4
> -#define INTERCEPT_DR5_READ     5
> -#define INTERCEPT_DR6_READ     6
> -#define INTERCEPT_DR7_READ     7
> -#define INTERCEPT_DR0_WRITE    (16 + 0)
> -#define INTERCEPT_DR1_WRITE    (16 + 1)
> -#define INTERCEPT_DR2_WRITE    (16 + 2)
> -#define INTERCEPT_DR3_WRITE    (16 + 3)
> -#define INTERCEPT_DR4_WRITE    (16 + 4)
> -#define INTERCEPT_DR5_WRITE    (16 + 5)
> -#define INTERCEPT_DR6_WRITE    (16 + 6)
> -#define INTERCEPT_DR7_WRITE    (16 + 7)
> -
>  #define SVM_EVTINJ_VEC_MASK 0xff
>
>  #define SVM_EVTINJ_TYPE_SHIFT 8
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index 46f5c82d9b45..71ca89afb2a3 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -121,7 +121,6 @@ void recalc_intercepts(struct vcpu_svm *svm)
>         for (i = 0; i < MAX_VECTORS; i++)
>                 c->intercepts[i] = h->intercepts[i];
>
> -       c->intercept_dr = h->intercept_dr;
>         c->intercept_exceptions = h->intercept_exceptions;
>         c->intercept = h->intercept;
>
> @@ -144,7 +143,6 @@ void recalc_intercepts(struct vcpu_svm *svm)
>         for (i = 0; i < MAX_VECTORS; i++)
>                 c->intercepts[i] |= g->intercepts[i];
>
> -       c->intercept_dr |= g->intercept_dr;
>         c->intercept_exceptions |= g->intercept_exceptions;
>         c->intercept |= g->intercept;
>  }
> @@ -157,7 +155,6 @@ static void copy_vmcb_control_area(struct vmcb_control_area *dst,
>         for (i = 0; i < MAX_VECTORS; i++)
>                 dst->intercepts[i] = from->intercepts[i];
>
> -       dst->intercept_dr         = from->intercept_dr;
>         dst->intercept_exceptions = from->intercept_exceptions;
>         dst->intercept            = from->intercept;
>         dst->iopm_base_pa         = from->iopm_base_pa;
> @@ -717,8 +714,7 @@ static int nested_svm_intercept(struct vcpu_svm *svm)
>                 break;
>         }
>         case SVM_EXIT_READ_DR0 ... SVM_EXIT_WRITE_DR7: {
> -               u32 bit = 1U << (exit_code - SVM_EXIT_READ_DR0);
> -               if (svm->nested.ctl.intercept_dr & bit)
> +               if (__is_intercept(&svm->nested.ctl.intercepts, exit_code))

Can I assume that all of these __<function> calls will become
<function> calls when the grand unification is done? (Maybe I should
just look ahead.)
