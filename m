Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256E7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F35EC207EA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 23:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qbj5R20j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGaXgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 19:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgGaXgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 19:36:14 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC737C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:36:14 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id g19so21214731ioh.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 16:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vv+Z2Cuv66Dwau8D1pXdKQiSVasU/nFTOv5yZ+5Avwg=;
        b=qbj5R20jEi6JAB6CJhK03umV/v7g0jdgGLOxjMr3L/UDPeY3bno0grQX5eEwrWBuHr
         1M58IYnFGCKzAEzmDjezJJbKNnDw9sOxR7Cs/Ky0lmilbc0EjbZOMD1N+V1hIywKZq7m
         I8VYk1ILH0BXw9k7ddq264FF20gpEra5gVQuGgJArWYi0bB9TWQd7BXiZud8Qlg/n+v0
         6NQM8ZJwuQ54djIQQ8HxYUPBQEVQyrvFYWPVU4RNSE1VP4YaFGXkukhroTiT3RSGQj0T
         ZJbb3jEtfEm9PRUtVxBCPBoJdKuJADwv69mOMkIfCJBhXq060a8SZqaOv1EvYe/I7KJz
         e4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vv+Z2Cuv66Dwau8D1pXdKQiSVasU/nFTOv5yZ+5Avwg=;
        b=ohCsJAEEwyYGxEY0g8FK3YLOgO/ojLCG85zft1evP2UX+la2OMhMqKf+eeJjAFy7wK
         9zhQTcZ9r0L9zPBZKcLoZeuu42zrjis1TQxmDkDnKGTGrkppo+4t+SqNglPlWeC0nlJ8
         CGyw0SxGJevpHU2zoIn4bcglElNy6T5shlcwHiFVQEiiF+hOnj/c5Rc7HcVW48ie6Shc
         85hZZ8sLacKlNFUYdAlmJJFISzrs1BLcQNGh7+nAs1G6bKo733Xads5eyzNpiZmFekHn
         VvlMyIxLHBw61OWIZ7EZjJGcJ1nQ+hP2PVjj/1rsKi7UdRtMGXdbQQCLSu728myeKHXF
         FTgA==
X-Gm-Message-State: AOAM532gcxngXafJQI4OEUC965Ykj0Q8p7LVwYzzkTCTohz/nhX0BTm9
        ojgPYx0MEpd/cY423MlWIHlYj53iPuVgUbeStG3DOA==
X-Google-Smtp-Source: ABdhPJy/vrPfdcevym2GcHDdsPiMGj/R2iz92GHDcHRHLTErVHK3/I5Pom9ke7xJhxmBYBDC8+snCzBtw3vnsKt1jzg=
X-Received: by 2002:a6b:b4d1:: with SMTP id d200mr5973314iof.70.1596238573812;
 Fri, 31 Jul 2020 16:36:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200731214947.16885-1-graf@amazon.com> <20200731214947.16885-2-graf@amazon.com>
In-Reply-To: <20200731214947.16885-2-graf@amazon.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 31 Jul 2020 16:36:02 -0700
Message-ID: <CALMp9eQ4Cvh=071HcmFCHeLbSb0cxQaCr3SMmKYTFdkywMvoYQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] KVM: x86: Deflect unknown MSR accesses to user space
To:     Alexander Graf <graf@amazon.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        KarimAllah Raslan <karahmed@amazon.de>,
        Aaron Lewis <aaronlewis@google.com>,
        kvm list <kvm@vger.kernel.org>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 2:50 PM Alexander Graf <graf@amazon.com> wrote:
>
> MSRs are weird. Some of them are normal control registers, such as EFER.
> Some however are registers that really are model specific, not very
> interesting to virtualization workloads, and not performance critical.
> Others again are really just windows into package configuration.
>
> Out of these MSRs, only the first category is necessary to implement in
> kernel space. Rarely accessed MSRs, MSRs that should be fine tunes against
> certain CPU models and MSRs that contain information on the package level
> are much better suited for user space to process. However, over time we have
> accumulated a lot of MSRs that are not the first category, but still handled
> by in-kernel KVM code.
>
> This patch adds a generic interface to handle WRMSR and RDMSR from user
> space. With this, any future MSR that is part of the latter categories can
> be handled in user space.
>
> Furthermore, it allows us to replace the existing "ignore_msrs" logic with
> something that applies per-VM rather than on the full system. That way you
> can run productive VMs in parallel to experimental ones where you don't care
> about proper MSR handling.
>
> Signed-off-by: Alexander Graf <graf@amazon.com>
>
> ---
>
> v1 -> v2:
>
>   - s/ETRAP_TO_USER_SPACE/ENOENT/g
>   - deflect all #GP injection events to user space, not just unknown MSRs.
>     That was we can also deflect allowlist errors later
>   - fix emulator case
>
> v2 -> v3:
>
>   - return r if r == X86EMUL_IO_NEEDED
>   - s/KVM_EXIT_RDMSR/KVM_EXIT_X86_RDMSR/g
>   - s/KVM_EXIT_WRMSR/KVM_EXIT_X86_WRMSR/g
>   - Use complete_userspace_io logic instead of reply field
>   - Simplify trapping code
> ---
>  Documentation/virt/kvm/api.rst  |  62 +++++++++++++++++++
>  arch/x86/include/asm/kvm_host.h |   6 ++
>  arch/x86/kvm/emulate.c          |  18 +++++-
>  arch/x86/kvm/x86.c              | 106 ++++++++++++++++++++++++++++++--
>  include/trace/events/kvm.h      |   2 +-
>  include/uapi/linux/kvm.h        |  10 +++
>  6 files changed, 197 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> index 320788f81a05..79c3e2fdfae4 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst

The new exit reasons should probably be mentioned here (around line 4866):

.. note::

      For KVM_EXIT_IO, KVM_EXIT_MMIO, KVM_EXIT_OSI, KVM_EXIT_PAPR and
      KVM_EXIT_EPR the corresponding

operations are complete (and guest state is consistent) only after userspace
has re-entered the kernel with KVM_RUN.  The kernel side will first finish
incomplete operations and then check for pending signals.  Userspace
can re-enter the guest with an unmasked signal pending to complete
pending operations.

Other than that, my remaining comments are all nits. Feel free to ignore them.

> +static int kvm_get_msr_user_space(struct kvm_vcpu *vcpu, u32 index)

Return bool rather than int?

> +{
> +       if (!vcpu->kvm->arch.user_space_msr_enabled)
> +               return 0;
> +
> +       vcpu->run->exit_reason = KVM_EXIT_X86_RDMSR;
> +       vcpu->run->msr.error = 0;

Should we clear 'pad' in case anyone can think of a reason to use this
space to extend the API in the future?

> +       vcpu->run->msr.index = index;
> +       vcpu->arch.pending_user_msr = true;
> +       vcpu->arch.complete_userspace_io = complete_emulated_rdmsr;

complete_userspace_io could perhaps be renamed to
complete_userspace_emulation (in a separate commit).

> +
> +       return 1;
> +}
> +
> +static int kvm_set_msr_user_space(struct kvm_vcpu *vcpu, u32 index, u64 data)

Return bool rather than int?

> +{
> +       if (!vcpu->kvm->arch.user_space_msr_enabled)
> +               return 0;
> +
> +       vcpu->run->exit_reason = KVM_EXIT_X86_WRMSR;
> +       vcpu->run->msr.error = 0;

Same question about 'pad' as above.

> +       vcpu->run->msr.index = index;
> +       vcpu->run->msr.data = data;
> +       vcpu->arch.pending_user_msr = true;
> +       vcpu->arch.complete_userspace_io = complete_emulated_wrmsr;
> +
> +       return 1;
> +}
> +

Reviewed-by: Jim Mattson <jmattson@google.com>
