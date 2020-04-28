Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1ACCC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 903512076A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kZzhRSnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgD1WNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726274AbgD1WND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:13:03 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A6EC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:13:03 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id b12so33304ion.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gnQqjUvKpyMsis4oOApN0h3EDNNd+Azb0xcg4b/vjcs=;
        b=kZzhRSnrJxZwXhdOI/fI3lvLpC+7xIFWoXU2sU0jetTYkdbg3ZN2tuAPVvpCEOnD+s
         k+q4hXVwXGUUr/swaxDajYb47LkgdTB5QaJMLnl2EwE2RgCEG5RqTvNEPqRWnh+Jx7t3
         +917jYC8s46KZ93AckNQFVpwJHqtII8pvAN1FaqddsQq89DZPdNpQXBWi5Ju5ifm54Lx
         bvPHuAL7AayMLfXES/RPI8iRUQwa2mQSr0vUIBT4WfW/Qmoqc6fV1Rhw/pCUprVpXIBR
         VG9aaxQXD8l7PeXXSFwtacF0ew+l9QCgqZKiLO+RQHGrmiLzHwNT4EfPbclFYTf/OrZ0
         fsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gnQqjUvKpyMsis4oOApN0h3EDNNd+Azb0xcg4b/vjcs=;
        b=OvWDx2R0dtTRO9TEcbNZUkmvKMPCKEtkeSxtHobrI65NSyDjD9CIhCFw1N4xzEFIoI
         oLANIhb+dz1BMj7nIkY7582V8TRSjtHMY9uGBy5CBs8WTAcRBiggLuCMT6esxVDIitgT
         3hODMkfu2EdoCPvtbJchROnztP6zX+L2296+l27vC10xJIsRpFya+kdoYL/hPLE3wGxp
         eZJQacSHOYZS9HKkLbZztj/sK7j46utjTlDrYKOnSeE3M/8h9V7OGv/N2hzvJVtrm7cf
         u5bNrk/IfjV1Cbf57+qVlsc5DddP9tZl+sg5k4eAHIfQ3OJjDVpttOSPEKkfIegOKDa6
         yhWw==
X-Gm-Message-State: AGi0PuZsIgMpuzLqcmphLc+3Vu2mwgBX98yuZkOoP1vxRK1iZNOkdEVg
        owBG6ZWNDpAHJIhIdYUW/YiW8W7ZrlHGP9n8WEmSsg==
X-Google-Smtp-Source: APiQypJhmdycxi2l+Whpqz2kZ3PEyv15q3UtEQ45cUy224IkB+0AEj7mEygJg53jPGHTjn9MGzrpV3m8W4RY61/MgCY=
X-Received: by 2002:a02:b09:: with SMTP id 9mr27125656jad.24.1588111982671;
 Tue, 28 Apr 2020 15:13:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200423022550.15113-1-sean.j.christopherson@intel.com> <20200423022550.15113-13-sean.j.christopherson@intel.com>
In-Reply-To: <20200423022550.15113-13-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Apr 2020 15:12:51 -0700
Message-ID: <CALMp9eTiGdYPpejAOLNz7zzqP1wPXb_zSL02F27VMHeHGzANJg@mail.gmail.com>
Subject: Re: [PATCH 12/13] KVM: x86: Replace late check_nested_events() hack
 with more precise fix
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 7:26 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Add a separate hook for checking if interrupt injection is blocked and
> use the hook to handle the case where an interrupt arrives between
> check_nested_events() and the injection logic.  Drop the retry of
> check_nested_events() that hack-a-fixed the same condition.
>
> Blocking injection is also a bit of a hack, e.g. KVM should do exiting
> and non-exiting interrupt processing in a single pass, but it's a more
> precise hack.  The old comment is also misleading, e.g. KVM_REQ_EVENT is
> purely an optimization, setting it on every run loop (which KVM doesn't
> do) should not affect functionality, only performance.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 +
>  arch/x86/kvm/svm/svm.c          |  1 +
>  arch/x86/kvm/vmx/vmx.c          | 13 +++++++++++++
>  arch/x86/kvm/x86.c              | 22 ++++------------------
>  4 files changed, 19 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 787636acd648..16fdeddb4a65 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1140,6 +1140,7 @@ struct kvm_x86_ops {
>         void (*queue_exception)(struct kvm_vcpu *vcpu);
>         void (*cancel_injection)(struct kvm_vcpu *vcpu);
>         bool (*interrupt_allowed)(struct kvm_vcpu *vcpu);
> +       bool (*interrupt_injection_allowed)(struct kvm_vcpu *vcpu);
>         bool (*nmi_allowed)(struct kvm_vcpu *vcpu);
>         bool (*get_nmi_mask)(struct kvm_vcpu *vcpu);
>         void (*set_nmi_mask)(struct kvm_vcpu *vcpu, bool masked);
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index f21f734861dd..6d3ccbfc9e6a 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3993,6 +3993,7 @@ static struct kvm_x86_ops svm_x86_ops __initdata = {
>         .queue_exception = svm_queue_exception,
>         .cancel_injection = svm_cancel_injection,
>         .interrupt_allowed = svm_interrupt_allowed,
> +       .interrupt_injection_allowed = svm_interrupt_allowed,
>         .nmi_allowed = svm_nmi_allowed,
>         .get_nmi_mask = svm_get_nmi_mask,
>         .set_nmi_mask = svm_set_nmi_mask,
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 2f8cacb3aa9b..68b3748b5383 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4550,6 +4550,18 @@ static bool vmx_interrupt_allowed(struct kvm_vcpu *vcpu)
>         return !vmx_interrupt_blocked(vcpu);
>  }
>
> +static bool vmx_interrupt_injection_allowed(struct kvm_vcpu *vcpu)
> +{
> +       /*
> +        * An IRQ must not be injected into L2 if it's supposed to VM-Exit,
> +        * e.g. if the IRQ arrived asynchronously after checking nested events.
> +        */
> +       if (is_guest_mode(vcpu) && nested_exit_on_intr(vcpu))
> +               return false;
> +
> +       return vmx_interrupt_allowed(vcpu);
> +}
> +
>  static int vmx_set_tss_addr(struct kvm *kvm, unsigned int addr)
>  {
>         int ret;
> @@ -7823,6 +7835,7 @@ static struct kvm_x86_ops vmx_x86_ops __initdata = {
>         .queue_exception = vmx_queue_exception,
>         .cancel_injection = vmx_cancel_injection,
>         .interrupt_allowed = vmx_interrupt_allowed,
> +       .interrupt_injection_allowed = vmx_interrupt_injection_allowed,
>         .nmi_allowed = vmx_nmi_allowed,
>         .get_nmi_mask = vmx_get_nmi_mask,
>         .set_nmi_mask = vmx_set_nmi_mask,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7c49a7dc601f..d9d6028a77e0 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7755,24 +7755,10 @@ static int inject_pending_event(struct kvm_vcpu *vcpu)
>                 --vcpu->arch.nmi_pending;
>                 vcpu->arch.nmi_injected = true;
>                 kvm_x86_ops.set_nmi(vcpu);
> -       } else if (kvm_cpu_has_injectable_intr(vcpu)) {
> -               /*
> -                * Because interrupts can be injected asynchronously, we are
> -                * calling check_nested_events again here to avoid a race condition.
> -                * See https://lkml.org/lkml/2014/7/2/60 for discussion about this
> -                * proposal and current concerns.  Perhaps we should be setting
> -                * KVM_REQ_EVENT only on certain events and not unconditionally?
> -                */
> -               if (is_guest_mode(vcpu) && kvm_x86_ops.check_nested_events) {
> -                       r = kvm_x86_ops.check_nested_events(vcpu);
> -                       if (r != 0)
> -                               return r;
> -               }
> -               if (kvm_x86_ops.interrupt_allowed(vcpu)) {
> -                       kvm_queue_interrupt(vcpu, kvm_cpu_get_interrupt(vcpu),
> -                                           false);
> -                       kvm_x86_ops.set_irq(vcpu);
> -               }
> +       } else if (kvm_cpu_has_injectable_intr(vcpu) &&
> +                  kvm_x86_ops.interrupt_injection_allowed(vcpu)) {
> +               kvm_queue_interrupt(vcpu, kvm_cpu_get_interrupt(vcpu), false);
> +               kvm_x86_ops.set_irq(vcpu);
>         }
So, that's what this mess was all about! Well, this certainly looks better.

Reviewed-by: Jim Mattson <jmattson@google.com>
