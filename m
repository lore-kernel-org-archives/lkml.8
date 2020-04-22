Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62A3C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1B0620781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AWNK0e4f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgDVVgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgDVVgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:36:47 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACC1C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:36:46 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id w4so4138463ioc.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D1Uf2oovzVOLF+H0FK/R7k1uZv64JouEaR0IvZuYAO0=;
        b=AWNK0e4f4ZtajDEbk2/zgMrdrjvYWreWbrmP+jYQoma+bpFMddRrYwLb1lVgenXMSN
         4Sg7vvm3HXmFG8vHJQvySKT+OxKKJNrsYx0LYzKhtW4UmKzNudfvBoYdW3pJRKFcLZBJ
         Oizuhv/uo5pdxctcnFPhmGVKBcMVBD+BryCGXprm2AQV8irqoaq5eyidRv90zd7bPwhS
         csCupTj9f2Z4PbtONJzny0DsRlds67mFNFa49bPLzVl4K5g4bXL4ZnoSl9dtZzg5rzGt
         A6OJbofuIsYGb8EBUZqhtGJlo7T9EUBb+15VDoJO/qBHBgWpijoSzAo0mK2OCqyDHL1q
         /+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D1Uf2oovzVOLF+H0FK/R7k1uZv64JouEaR0IvZuYAO0=;
        b=RDrU2Oa1XVcrF2rGJLzaKmVvOnK/vJD908kgC/tm35PRNe54qr59PzP4je3IK7Eb8F
         1nankMp/V/xaYIGv2PmH6mpWkUAi5MCswiX2lOC2Txn2cCMz5WlTkTA393NRWnAwkzQz
         cBKotKSEEyXTAF/t8TZO72UgwEouRQkrvbS7TSarPl91Eu7bjc20gEjiT2J7B/UbU2b+
         K2R9Obfv9OufmNGm77R+9YxFjxsYtyZQp5/Zfu+tAvwsU+uvAuSSwzBjaInwFiXZa4cE
         +NMvcPGQ0kiioPWQzgTQSYRUGdhWxSRq2yM7eLrhj6cnTu+ZlkieUFoWHKxxxQyWsJOS
         2zCg==
X-Gm-Message-State: AGi0PuZTpzKmiAWImHFrAmt7Cy4Zas2Fee3RgPbm5UhmuexfSgbl4wbm
        Hg4QxIZqOGzAdB/9IhIqpAsOiOD1R5lWWYl5KPq7Qg==
X-Google-Smtp-Source: APiQypJEe8pwxASOXnaq0f6ETsUIkVm4W9ywGv6vpECQoSEbZM2EQv87mkdBioXyZc1+2xxm2ivj7QJwlssdDDFXaBE=
X-Received: by 2002:a6b:91d4:: with SMTP id t203mr845837iod.70.1587591405906;
 Wed, 22 Apr 2020 14:36:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200417221446.108733-1-jcargill@google.com> <87d083td9f.fsf@vitty.brq.redhat.com>
In-Reply-To: <87d083td9f.fsf@vitty.brq.redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 22 Apr 2020 14:36:34 -0700
Message-ID: <CALMp9eREdS=nfdtvfNhW87G20Tfdwy69Phdbdmo=NzAw_tavzw@mail.gmail.com>
Subject: Re: [PATCH] kvm: add capability for halt polling
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Jon Cargille <jcargill@google.com>,
        David Matlack <dmatlack@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 19, 2020 at 1:46 PM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> Jon Cargille <jcargill@google.com> writes:
>
> > From: David Matlack <dmatlack@google.com>
> >
> > KVM_CAP_HALT_POLL is a per-VM capability that lets userspace
> > control the halt-polling time, allowing halt-polling to be tuned or
> > disabled on particular VMs.
> >
> > With dynamic halt-polling, a VM's VCPUs can poll from anywhere from
> > [0, halt_poll_ns] on each halt. KVM_CAP_HALT_POLL sets the
> > upper limit on the poll time.
>
> Out of pure curiosity, why is this a per-VM and not a per-VCPU property?

It didn't seem to be worth doing the plumbing for an
architecture-agnostic per-vCPU property (which doesn't exist today).

> >
> > Signed-off-by: David Matlack <dmatlack@google.com>
> > Signed-off-by: Jon Cargille <jcargill@google.com>
> > Reviewed-by: Jim Mattson <jmattson@google.com>
> > ---
> >  Documentation/virt/kvm/api.rst | 17 +++++++++++++++++
> >  include/linux/kvm_host.h       |  1 +
> >  include/uapi/linux/kvm.h       |  1 +
> >  virt/kvm/kvm_main.c            | 19 +++++++++++++++----
> >  4 files changed, 34 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
> > index efbbe570aa9b7b..d871dacb984e98 100644
> > --- a/Documentation/virt/kvm/api.rst
> > +++ b/Documentation/virt/kvm/api.rst
> > @@ -5802,6 +5802,23 @@ If present, this capability can be enabled for a VM, meaning that KVM
> >  will allow the transition to secure guest mode.  Otherwise KVM will
> >  veto the transition.
> >
> > +7.20 KVM_CAP_HALT_POLL
> > +----------------------
> > +
> > +:Architectures: all
> > +:Target: VM
> > +:Parameters: args[0] is the maximum poll time in nanoseconds
> > +:Returns: 0 on success; -1 on error
> > +
> > +This capability overrides the kvm module parameter halt_poll_ns for the
> > +target VM.
> > +
> > +VCPU polling allows a VCPU to poll for wakeup events instead of immediately
> > +scheduling during guest halts. The maximum time a VCPU can spend polling is
> > +controlled by the kvm module parameter halt_poll_ns. This capability allows
> > +the maximum halt time to specified on a per-VM basis, effectively overriding
> > +the module parameter for the target VM.
> > +
> >  8. Other capabilities.
> >  ======================
> >
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 6d58beb65454f7..922b24ce5e7297 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -503,6 +503,7 @@ struct kvm {
> >       struct srcu_struct srcu;
> >       struct srcu_struct irq_srcu;
> >       pid_t userspace_pid;
> > +     unsigned int max_halt_poll_ns;
> >  };
> >
> >  #define kvm_err(fmt, ...) \
> > diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> > index 428c7dde6b4b37..ac9eba0289d1b6 100644
> > --- a/include/uapi/linux/kvm.h
> > +++ b/include/uapi/linux/kvm.h
> > @@ -1017,6 +1017,7 @@ struct kvm_ppc_resize_hpt {
> >  #define KVM_CAP_S390_VCPU_RESETS 179
> >  #define KVM_CAP_S390_PROTECTED 180
> >  #define KVM_CAP_PPC_SECURE_GUEST 181
> > +#define KVM_CAP_HALT_POLL 182
> >
> >  #ifdef KVM_CAP_IRQ_ROUTING
> >
> > diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> > index 74bdb7bf32952e..ec038a9e60a275 100644
> > --- a/virt/kvm/kvm_main.c
> > +++ b/virt/kvm/kvm_main.c
> > @@ -710,6 +710,8 @@ static struct kvm *kvm_create_vm(unsigned long type)
> >                       goto out_err_no_arch_destroy_vm;
> >       }
> >
> > +     kvm->max_halt_poll_ns = halt_poll_ns;
> > +
> >       r = kvm_arch_init_vm(kvm, type);
> >       if (r)
> >               goto out_err_no_arch_destroy_vm;
> > @@ -2716,15 +2718,16 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
> >       if (!kvm_arch_no_poll(vcpu)) {
> >               if (!vcpu_valid_wakeup(vcpu)) {
> >                       shrink_halt_poll_ns(vcpu);
> > -             } else if (halt_poll_ns) {
> > +             } else if (vcpu->kvm->max_halt_poll_ns) {
> >                       if (block_ns <= vcpu->halt_poll_ns)
> >                               ;
> >                       /* we had a long block, shrink polling */
> > -                     else if (vcpu->halt_poll_ns && block_ns > halt_poll_ns)
> > +                     else if (vcpu->halt_poll_ns &&
> > +                                     block_ns > vcpu->kvm->max_halt_poll_ns)
> >                               shrink_halt_poll_ns(vcpu);
> >                       /* we had a short halt and our poll time is too small */
> > -                     else if (vcpu->halt_poll_ns < halt_poll_ns &&
> > -                             block_ns < halt_poll_ns)
> > +                     else if (vcpu->halt_poll_ns < vcpu->kvm->max_halt_poll_ns &&
> > +                                     block_ns < vcpu->kvm->max_halt_poll_ns)
> >                               grow_halt_poll_ns(vcpu);
> >               } else {
> >                       vcpu->halt_poll_ns = 0;
> > @@ -3516,6 +3519,7 @@ static long kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
> >       case KVM_CAP_IOEVENTFD_ANY_LENGTH:
> >       case KVM_CAP_CHECK_EXTENSION_VM:
> >       case KVM_CAP_ENABLE_CAP_VM:
> > +     case KVM_CAP_HALT_POLL:
> >               return 1;
> >  #ifdef CONFIG_KVM_MMIO
> >       case KVM_CAP_COALESCED_MMIO:
> > @@ -3566,6 +3570,13 @@ static int kvm_vm_ioctl_enable_cap_generic(struct kvm *kvm,
> >               return 0;
> >       }
> >  #endif
> > +     case KVM_CAP_HALT_POLL: {
> > +             if (cap->flags || cap->args[0] != (unsigned int)cap->args[0])
> > +                     return -EINVAL;
> > +
> > +             kvm->max_halt_poll_ns = cap->args[0];
>
> Is it safe to allow any value from userspace here or would it maybe make
> sense to only allow [0, global halt_poll_ns]?

Would that restriction help to get this change accepted?

> > +             return 0;
> > +     }
> >       default:
> >               return kvm_vm_ioctl_enable_cap(kvm, cap);
> >       }
>
> --
> Vitaly
>
