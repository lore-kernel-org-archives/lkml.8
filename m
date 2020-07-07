Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27CAC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B0E206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594112057;
	bh=YJyMEZ2A+U1UidV3AD1xnh9RVRpXP5YCB7yYOYAAR58=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=uKjYqArkPtLy6u0lWPR9CoWOiWURzXlnaUV+oVmvHqLF1k08ziMrRvkHD0ZGgw7YK
	 QnVDPXzp6PIBheqoDiqHQAK8SWExbaLfBNm1jG6f1664IeYA11U07Tgd5PLj7bvjOl
	 kUBBROp+Ln1TCwQ0yjcodIFFnfNK+64vVKrTVRqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgGGIyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:54:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbgGGIyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:54:15 -0400
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD13320720;
        Tue,  7 Jul 2020 08:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594112054;
        bh=YJyMEZ2A+U1UidV3AD1xnh9RVRpXP5YCB7yYOYAAR58=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=xt8qQS0Lkm5pUrqloA0ST5B642nRAnEryfMkafbrdj8PPIeI9DsA+P9DwTCpi+Jjg
         TBborEE3pCTbeumGu4acD3cHGuVnaVtMpkuULNiCq1xPwUvqkCaBFgVAG87Ig35ufk
         EAc0jb//zy30KK/ixbeXiHf6IgQv9DC1woOJ5Q9U=
Received: by mail-lj1-f171.google.com with SMTP id 9so48937766ljv.5;
        Tue, 07 Jul 2020 01:54:13 -0700 (PDT)
X-Gm-Message-State: AOAM533y4KB1Uz/se/TMOpMRtioXM6yG86kKGKKJG9E/9K9vtQD/R3CA
        T+ePQG/M8Fyd9iAy7eumEktgjq6g1gy5O3LDgaw=
X-Google-Smtp-Source: ABdhPJwGhHbmhxdvMI2UtWihQPw4UHZKhESbHCeabSVBBH3DFDnWy5Xzin8DHcITGoEJ1gSWuUonDMJIMq7NA/Sk5lw=
X-Received: by 2002:a2e:7e08:: with SMTP id z8mr24843155ljc.66.1594112051780;
 Tue, 07 Jul 2020 01:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <1593833659-26224-1-git-send-email-guoren@kernel.org>
 <1593833659-26224-5-git-send-email-guoren@kernel.org> <20200706191156.ef63ba62d5d3e33f665997b7@kernel.org>
 <CANXhq0qdObAmSk2TJJPFJaPqCZTZ4O06VhFqmaQnVwZ6PNNoNA@mail.gmail.com>
In-Reply-To: <CANXhq0qdObAmSk2TJJPFJaPqCZTZ4O06VhFqmaQnVwZ6PNNoNA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 7 Jul 2020 16:53:59 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTWsUYQ-VkA7b02EgCe-e1HcSGuBXRjmeer8Hr3FvQqfw@mail.gmail.com>
Message-ID: <CAJF2gTTWsUYQ-VkA7b02EgCe-e1HcSGuBXRjmeer8Hr3FvQqfw@mail.gmail.com>
Subject: Re: [PATCH V1 4/5] riscv: Add kprobes supported
To:     Zong Li <zong.li@sifive.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 4:26 PM Zong Li <zong.li@sifive.com> wrote:
>
> On Mon, Jul 6, 2020 at 6:12 PM Masami Hiramatsu <mhiramat@kernel.org> wro=
te:
> >
> > Hi Guo,
> >
> > On Sat,  4 Jul 2020 03:34:18 +0000
> > guoren@kernel.org wrote:
> >
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > This patch enables "kprobe & kretprobe" to work with ftrace
> > > interface. It utilized software breakpoint as single-step
> > > mechanism.
> > >
> > > Some instructions which can't be single-step executed must be
> > > simulated in kernel execution slot, such as: branch, jal, auipc,
> > > la ...
> > >
> > > Some instructions should be rejected for probing and we use a
> > > blacklist to filter, such as: ecall, ebreak, ...
> > >
> > > We use ebreak & c.ebreak to replace origin instruction and the
> > > kprobe handler prepares an executable memory slot for out-of-line
> > > execution with a copy of the original instruction being probed.
> > > In execution slot we add ebreak behind original instruction to
> > > simulate a single-setp mechanism.
> > >
> > > The patch is based on packi's work [1] and csky's work [2].
> > >  - The kprobes_trampoline.S is all from packi's patch
> > >  - The single-step mechanism is new designed for riscv without hw
> > >    single-step trap
> > >  - The simulation codes are from csky
> > >  - Frankly, all codes refer to other archs' implementation
> > >
> > >  [1] https://lore.kernel.org/linux-riscv/20181113195804.22825-1-me@pa=
cki.ch/
> > >  [2] https://lore.kernel.org/linux-csky/20200403044150.20562-9-guoren=
@kernel.org/
> > >
> >
> > This looks good to me. Thanks for updating !
> >
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> >
> > Thank you,
> >
>
> It works to me. Thanks!
>
> Tested-by: Zong Li <zong.li@sifive.com>

Thank you!

>
> >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Co-Developed-by: Patrick St=C3=A4hlin <me@packi.ch>
> > > Cc: Patrick St=C3=A4hlin <me@packi.ch>
> > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > > Cc: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>
> > > ---
> > >  arch/riscv/Kconfig                            |   2 +
> > >  arch/riscv/include/asm/kprobes.h              |  40 +++
> > >  arch/riscv/include/asm/probes.h               |  24 ++
> > >  arch/riscv/kernel/Makefile                    |   1 +
> > >  arch/riscv/kernel/probes/Makefile             |   4 +
> > >  arch/riscv/kernel/probes/decode-insn.c        |  48 +++
> > >  arch/riscv/kernel/probes/decode-insn.h        |  18 +
> > >  arch/riscv/kernel/probes/kprobes.c            | 471 ++++++++++++++++=
++++++++++
> > >  arch/riscv/kernel/probes/kprobes_trampoline.S |  93 +++++
> > >  arch/riscv/kernel/probes/simulate-insn.c      |  85 +++++
> > >  arch/riscv/kernel/probes/simulate-insn.h      |  47 +++
> > >  arch/riscv/kernel/traps.c                     |   9 +
> > >  arch/riscv/mm/fault.c                         |   4 +
> > >  13 files changed, 846 insertions(+)
> > >  create mode 100644 arch/riscv/include/asm/probes.h
> > >  create mode 100644 arch/riscv/kernel/probes/Makefile
> > >  create mode 100644 arch/riscv/kernel/probes/decode-insn.c
> > >  create mode 100644 arch/riscv/kernel/probes/decode-insn.h
> > >  create mode 100644 arch/riscv/kernel/probes/kprobes.c
> > >  create mode 100644 arch/riscv/kernel/probes/kprobes_trampoline.S
> > >  create mode 100644 arch/riscv/kernel/probes/simulate-insn.c
> > >  create mode 100644 arch/riscv/kernel/probes/simulate-insn.h
> > >
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index 58d6f66..a295f0b 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -57,6 +57,8 @@ config RISCV
> > >       select HAVE_EBPF_JIT if MMU
> > >       select HAVE_FUTEX_CMPXCHG if FUTEX
> > >       select HAVE_GENERIC_VDSO if MMU && 64BIT
> > > +     select HAVE_KPROBES
> > > +     select HAVE_KRETPROBES
> > >       select HAVE_PCI
> > >       select HAVE_PERF_EVENTS
> > >       select HAVE_PERF_REGS
> > > diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/as=
m/kprobes.h
> > > index 56a98ea3..4647d38 100644
> > > --- a/arch/riscv/include/asm/kprobes.h
> > > +++ b/arch/riscv/include/asm/kprobes.h
> > > @@ -11,4 +11,44 @@
> > >
> > >  #include <asm-generic/kprobes.h>
> > >
> > > +#ifdef CONFIG_KPROBES
> > > +#include <linux/types.h>
> > > +#include <linux/ptrace.h>
> > > +#include <linux/percpu.h>
> > > +
> > > +#define __ARCH_WANT_KPROBES_INSN_SLOT
> > > +#define MAX_INSN_SIZE                        2
> > > +
> > > +#define flush_insn_slot(p)           do { } while (0)
> > > +#define kretprobe_blacklist_size     0
> > > +
> > > +#include <asm/probes.h>
> > > +
> > > +struct prev_kprobe {
> > > +     struct kprobe *kp;
> > > +     unsigned int status;
> > > +};
> > > +
> > > +/* Single step context for kprobe */
> > > +struct kprobe_step_ctx {
> > > +     unsigned long ss_pending;
> > > +     unsigned long match_addr;
> > > +};
> > > +
> > > +/* per-cpu kprobe control block */
> > > +struct kprobe_ctlblk {
> > > +     unsigned int kprobe_status;
> > > +     unsigned long saved_status;
> > > +     struct prev_kprobe prev_kprobe;
> > > +     struct kprobe_step_ctx ss_ctx;
> > > +};
> > > +
> > > +void arch_remove_kprobe(struct kprobe *p);
> > > +int kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr);
> > > +bool kprobe_breakpoint_handler(struct pt_regs *regs);
> > > +bool kprobe_single_step_handler(struct pt_regs *regs);
> > > +void kretprobe_trampoline(void);
> > > +void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
> > > +
> > > +#endif /* CONFIG_KPROBES */
> > >  #endif /* _ASM_RISCV_KPROBES_H */
> > > diff --git a/arch/riscv/include/asm/probes.h b/arch/riscv/include/asm=
/probes.h
> > > new file mode 100644
> > > index 00000000..a787e6d
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/probes.h
> > > @@ -0,0 +1,24 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +
> > > +#ifndef _ASM_RISCV_PROBES_H
> > > +#define _ASM_RISCV_PROBES_H
> > > +
> > > +typedef u32 probe_opcode_t;
> > > +typedef bool (probes_handler_t) (u32 opcode, unsigned long addr, str=
uct pt_regs *);
> > > +
> > > +/* architecture specific copy of original instruction */
> > > +struct arch_probe_insn {
> > > +     probe_opcode_t *insn;
> > > +     probes_handler_t *handler;
> > > +     /* restore address after simulation */
> > > +     unsigned long restore;
> > > +};
> > > +
> > > +#ifdef CONFIG_KPROBES
> > > +typedef u32 kprobe_opcode_t;
> > > +struct arch_specific_insn {
> > > +     struct arch_probe_insn api;
> > > +};
> > > +#endif
> > > +
> > > +#endif /* _ASM_RISCV_PROBES_H */
> > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > index b355cf4..c3fff3e 100644
> > > --- a/arch/riscv/kernel/Makefile
> > > +++ b/arch/riscv/kernel/Makefile
> > > @@ -29,6 +29,7 @@ obj-y       +=3D riscv_ksyms.o
> > >  obj-y        +=3D stacktrace.o
> > >  obj-y        +=3D cacheinfo.o
> > >  obj-y        +=3D patch.o
> > > +obj-y        +=3D probes/
> > >  obj-$(CONFIG_MMU) +=3D vdso.o vdso/
> > >
> > >  obj-$(CONFIG_RISCV_M_MODE)   +=3D clint.o traps_misaligned.o
> > > diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/pr=
obes/Makefile
> > > new file mode 100644
> > > index 00000000..8a39507
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/probes/Makefile
> > > @@ -0,0 +1,4 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +obj-$(CONFIG_KPROBES)                +=3D kprobes.o decode-insn.o si=
mulate-insn.o
> > > +obj-$(CONFIG_KPROBES)                +=3D kprobes_trampoline.o
> > > +CFLAGS_REMOVE_simulate-insn.o =3D $(CC_FLAGS_FTRACE)
> > > diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kern=
el/probes/decode-insn.c
> > > new file mode 100644
> > > index 00000000..0876c30
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/probes/decode-insn.c
> > > @@ -0,0 +1,48 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/kprobes.h>
> > > +#include <linux/module.h>
> > > +#include <linux/kallsyms.h>
> > > +#include <asm/sections.h>
> > > +
> > > +#include "decode-insn.h"
> > > +#include "simulate-insn.h"
> > > +
> > > +/* Return:
> > > + *   INSN_REJECTED     If instruction is one not allowed to kprobe,
> > > + *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use i=
ts slot.
> > > + */
> > > +enum probe_insn __kprobes
> > > +riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn=
 *api)
> > > +{
> > > +     probe_opcode_t insn =3D le32_to_cpu(*addr);
> > > +
> > > +     /*
> > > +      * Reject instructions list:
> > > +      */
> > > +     RISCV_INSN_REJECTED(system,             insn);
> > > +     RISCV_INSN_REJECTED(fence,              insn);
> > > +
> > > +     /*
> > > +      * Simulate instructions list:
> > > +      * TODO: the REJECTED ones below need to be implemented
> > > +      */
> > > +#ifdef CONFIG_RISCV_ISA_C
> > > +     RISCV_INSN_REJECTED(c_j,                insn);
> > > +     RISCV_INSN_REJECTED(c_jr,               insn);
> > > +     RISCV_INSN_REJECTED(c_jal,              insn);
> > > +     RISCV_INSN_REJECTED(c_jalr,             insn);
> > > +     RISCV_INSN_REJECTED(c_beqz,             insn);
> > > +     RISCV_INSN_REJECTED(c_bnez,             insn);
> > > +     RISCV_INSN_REJECTED(c_ebreak,           insn);
> > > +#endif
> > > +
> > > +     RISCV_INSN_REJECTED(auipc,              insn);
> > > +     RISCV_INSN_REJECTED(branch,             insn);
> > > +
> > > +     RISCV_INSN_SET_SIMULATE(jal,            insn);
> > > +     RISCV_INSN_SET_SIMULATE(jalr,           insn);
> > > +
> > > +     return INSN_GOOD;
> > > +}
> > > diff --git a/arch/riscv/kernel/probes/decode-insn.h b/arch/riscv/kern=
el/probes/decode-insn.h
> > > new file mode 100644
> > > index 00000000..42269a7
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/probes/decode-insn.h
> > > @@ -0,0 +1,18 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > +
> > > +#ifndef _RISCV_KERNEL_KPROBES_DECODE_INSN_H
> > > +#define _RISCV_KERNEL_KPROBES_DECODE_INSN_H
> > > +
> > > +#include <asm/sections.h>
> > > +#include <asm/kprobes.h>
> > > +
> > > +enum probe_insn {
> > > +     INSN_REJECTED,
> > > +     INSN_GOOD_NO_SLOT,
> > > +     INSN_GOOD,
> > > +};
> > > +
> > > +enum probe_insn __kprobes
> > > +riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn=
 *asi);
> > > +
> > > +#endif /* _RISCV_KERNEL_KPROBES_DECODE_INSN_H */
> > > diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/p=
robes/kprobes.c
> > > new file mode 100644
> > > index 00000000..31b6196
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/probes/kprobes.c
> > > @@ -0,0 +1,471 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +
> > > +#include <linux/kprobes.h>
> > > +#include <linux/extable.h>
> > > +#include <linux/slab.h>
> > > +#include <linux/stop_machine.h>
> > > +#include <asm/ptrace.h>
> > > +#include <linux/uaccess.h>
> > > +#include <asm/sections.h>
> > > +#include <asm/cacheflush.h>
> > > +#include <asm/bug.h>
> > > +#include <asm/patch.h>
> > > +
> > > +#include "decode-insn.h"
> > > +
> > > +DEFINE_PER_CPU(struct kprobe *, current_kprobe) =3D NULL;
> > > +DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> > > +
> > > +static void __kprobes
> > > +post_kprobe_handler(struct kprobe_ctlblk *, struct pt_regs *);
> > > +
> > > +static void __kprobes arch_prepare_ss_slot(struct kprobe *p)
> > > +{
> > > +     unsigned long offset =3D GET_INSN_LENGTH(p->opcode);
> > > +
> > > +     p->ainsn.api.restore =3D (unsigned long)p->addr + offset;
> > > +
> > > +     patch_text(p->ainsn.api.insn, p->opcode);
> > > +     patch_text((void *)((unsigned long)(p->ainsn.api.insn) + offset=
),
> > > +                __BUG_INSN_32);
> > > +}
> > > +
> > > +static void __kprobes arch_prepare_simulate(struct kprobe *p)
> > > +{
> > > +     p->ainsn.api.restore =3D 0;
> > > +}
> > > +
> > > +static void __kprobes arch_simulate_insn(struct kprobe *p, struct pt=
_regs *regs)
> > > +{
> > > +     struct kprobe_ctlblk *kcb =3D get_kprobe_ctlblk();
> > > +
> > > +     if (p->ainsn.api.handler)
> > > +             p->ainsn.api.handler((u32)p->opcode,
> > > +                                     (unsigned long)p->addr, regs);
> > > +
> > > +     post_kprobe_handler(kcb, regs);
> > > +}
> > > +
> > > +int __kprobes arch_prepare_kprobe(struct kprobe *p)
> > > +{
> > > +     unsigned long probe_addr =3D (unsigned long)p->addr;
> > > +
> > > +     if (probe_addr & 0x1) {
> > > +             pr_warn("Address not aligned.\n");
> > > +
> > > +             return -EINVAL;
> > > +     }
> > > +
> > > +     /* copy instruction */
> > > +     p->opcode =3D le32_to_cpu(*p->addr);
> > > +
> > > +     /* decode instruction */
> > > +     switch (riscv_probe_decode_insn(p->addr, &p->ainsn.api)) {
> > > +     case INSN_REJECTED:     /* insn not supported */
> > > +             return -EINVAL;
> > > +
> > > +     case INSN_GOOD_NO_SLOT: /* insn need simulation */
> > > +             p->ainsn.api.insn =3D NULL;
> > > +             break;
> > > +
> > > +     case INSN_GOOD: /* instruction uses slot */
> > > +             p->ainsn.api.insn =3D get_insn_slot();
> > > +             if (!p->ainsn.api.insn)
> > > +                     return -ENOMEM;
> > > +             break;
> > > +     }
> > > +
> > > +     /* prepare the instruction */
> > > +     if (p->ainsn.api.insn)
> > > +             arch_prepare_ss_slot(p);
> > > +     else
> > > +             arch_prepare_simulate(p);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +/* install breakpoint in text */
> > > +void __kprobes arch_arm_kprobe(struct kprobe *p)
> > > +{
> > > +     if ((p->opcode & __INSN_LENGTH_MASK) =3D=3D __INSN_LENGTH_32)
> > > +             patch_text(p->addr, __BUG_INSN_32);
> > > +     else
> > > +             patch_text(p->addr, __BUG_INSN_16);
> > > +}
> > > +
> > > +/* remove breakpoint from text */
> > > +void __kprobes arch_disarm_kprobe(struct kprobe *p)
> > > +{
> > > +     patch_text(p->addr, p->opcode);
> > > +}
> > > +
> > > +void __kprobes arch_remove_kprobe(struct kprobe *p)
> > > +{
> > > +}
> > > +
> > > +static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb=
)
> > > +{
> > > +     kcb->prev_kprobe.kp =3D kprobe_running();
> > > +     kcb->prev_kprobe.status =3D kcb->kprobe_status;
> > > +}
> > > +
> > > +static void __kprobes restore_previous_kprobe(struct kprobe_ctlblk *=
kcb)
> > > +{
> > > +     __this_cpu_write(current_kprobe, kcb->prev_kprobe.kp);
> > > +     kcb->kprobe_status =3D kcb->prev_kprobe.status;
> > > +}
> > > +
> > > +static void __kprobes set_current_kprobe(struct kprobe *p)
> > > +{
> > > +     __this_cpu_write(current_kprobe, p);
> > > +}
> > > +
> > > +/*
> > > + * Interrupts need to be disabled before single-step mode is set, an=
d not
> > > + * reenabled until after single-step mode ends.
> > > + * Without disabling interrupt on local CPU, there is a chance of
> > > + * interrupt occurrence in the period of exception return and  start=
 of
> > > + * out-of-line single-step, that result in wrongly single stepping
> > > + * into the interrupt handler.
> > > + */
> > > +static void __kprobes kprobes_save_local_irqflag(struct kprobe_ctlbl=
k *kcb,
> > > +                                             struct pt_regs *regs)
> > > +{
> > > +     kcb->saved_status =3D regs->status;
> > > +     regs->status &=3D ~SR_SPIE;
> > > +}
> > > +
> > > +static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ct=
lblk *kcb,
> > > +                                             struct pt_regs *regs)
> > > +{
> > > +     regs->status =3D kcb->saved_status;
> > > +}
> > > +
> > > +static void __kprobes
> > > +set_ss_context(struct kprobe_ctlblk *kcb, unsigned long addr, struct=
 kprobe *p)
> > > +{
> > > +     unsigned long offset =3D GET_INSN_LENGTH(p->opcode);
> > > +
> > > +     kcb->ss_ctx.ss_pending =3D true;
> > > +     kcb->ss_ctx.match_addr =3D addr + offset;
> > > +}
> > > +
> > > +static void __kprobes clear_ss_context(struct kprobe_ctlblk *kcb)
> > > +{
> > > +     kcb->ss_ctx.ss_pending =3D false;
> > > +     kcb->ss_ctx.match_addr =3D 0;
> > > +}
> > > +
> > > +static void __kprobes setup_singlestep(struct kprobe *p,
> > > +                                    struct pt_regs *regs,
> > > +                                    struct kprobe_ctlblk *kcb, int r=
eenter)
> > > +{
> > > +     unsigned long slot;
> > > +
> > > +     if (reenter) {
> > > +             save_previous_kprobe(kcb);
> > > +             set_current_kprobe(p);
> > > +             kcb->kprobe_status =3D KPROBE_REENTER;
> > > +     } else {
> > > +             kcb->kprobe_status =3D KPROBE_HIT_SS;
> > > +     }
> > > +
> > > +     if (p->ainsn.api.insn) {
> > > +             /* prepare for single stepping */
> > > +             slot =3D (unsigned long)p->ainsn.api.insn;
> > > +
> > > +             set_ss_context(kcb, slot, p);   /* mark pending ss */
> > > +
> > > +             /* IRQs and single stepping do not mix well. */
> > > +             kprobes_save_local_irqflag(kcb, regs);
> > > +
> > > +             instruction_pointer_set(regs, slot);
> > > +     } else {
> > > +             /* insn simulation */
> > > +             arch_simulate_insn(p, regs);
> > > +     }
> > > +}
> > > +
> > > +static int __kprobes reenter_kprobe(struct kprobe *p,
> > > +                                 struct pt_regs *regs,
> > > +                                 struct kprobe_ctlblk *kcb)
> > > +{
> > > +     switch (kcb->kprobe_status) {
> > > +     case KPROBE_HIT_SSDONE:
> > > +     case KPROBE_HIT_ACTIVE:
> > > +             kprobes_inc_nmissed_count(p);
> > > +             setup_singlestep(p, regs, kcb, 1);
> > > +             break;
> > > +     case KPROBE_HIT_SS:
> > > +     case KPROBE_REENTER:
> > > +             pr_warn("Unrecoverable kprobe detected.\n");
> > > +             dump_kprobe(p);
> > > +             BUG();
> > > +             break;
> > > +     default:
> > > +             WARN_ON(1);
> > > +             return 0;
> > > +     }
> > > +
> > > +     return 1;
> > > +}
> > > +
> > > +static void __kprobes
> > > +post_kprobe_handler(struct kprobe_ctlblk *kcb, struct pt_regs *regs)
> > > +{
> > > +     struct kprobe *cur =3D kprobe_running();
> > > +
> > > +     if (!cur)
> > > +             return;
> > > +
> > > +     /* return addr restore if non-branching insn */
> > > +     if (cur->ainsn.api.restore !=3D 0)
> > > +             regs->epc =3D cur->ainsn.api.restore;
> > > +
> > > +     /* restore back original saved kprobe variables and continue */
> > > +     if (kcb->kprobe_status =3D=3D KPROBE_REENTER) {
> > > +             restore_previous_kprobe(kcb);
> > > +             return;
> > > +     }
> > > +
> > > +     /* call post handler */
> > > +     kcb->kprobe_status =3D KPROBE_HIT_SSDONE;
> > > +     if (cur->post_handler)  {
> > > +             /* post_handler can hit breakpoint and single step
> > > +              * again, so we enable D-flag for recursive exception.
> > > +              */
> > > +             cur->post_handler(cur, regs, 0);
> > > +     }
> > > +
> > > +     reset_current_kprobe();
> > > +}
> > > +
> > > +int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned in=
t trapnr)
> > > +{
> > > +     struct kprobe *cur =3D kprobe_running();
> > > +     struct kprobe_ctlblk *kcb =3D get_kprobe_ctlblk();
> > > +
> > > +     switch (kcb->kprobe_status) {
> > > +     case KPROBE_HIT_SS:
> > > +     case KPROBE_REENTER:
> > > +             /*
> > > +              * We are here because the instruction being single
> > > +              * stepped caused a page fault. We reset the current
> > > +              * kprobe and the ip points back to the probe address
> > > +              * and allow the page fault handler to continue as a
> > > +              * normal page fault.
> > > +              */
> > > +             regs->epc =3D (unsigned long) cur->addr;
> > > +             if (!instruction_pointer(regs))
> > > +                     BUG();
> > > +
> > > +             if (kcb->kprobe_status =3D=3D KPROBE_REENTER)
> > > +                     restore_previous_kprobe(kcb);
> > > +             else
> > > +                     reset_current_kprobe();
> > > +
> > > +             break;
> > > +     case KPROBE_HIT_ACTIVE:
> > > +     case KPROBE_HIT_SSDONE:
> > > +             /*
> > > +              * We increment the nmissed count for accounting,
> > > +              * we can also use npre/npostfault count for accounting
> > > +              * these specific fault cases.
> > > +              */
> > > +             kprobes_inc_nmissed_count(cur);
> > > +
> > > +             /*
> > > +              * We come here because instructions in the pre/post
> > > +              * handler caused the page_fault, this could happen
> > > +              * if handler tries to access user space by
> > > +              * copy_from_user(), get_user() etc. Let the
> > > +              * user-specified handler try to fix it first.
> > > +              */
> > > +             if (cur->fault_handler && cur->fault_handler(cur, regs,=
 trapnr))
> > > +                     return 1;
> > > +
> > > +             /*
> > > +              * In case the user-specified fault handler returned
> > > +              * zero, try to fix up.
> > > +              */
> > > +             if (fixup_exception(regs))
> > > +                     return 1;
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > > +bool __kprobes
> > > +kprobe_breakpoint_handler(struct pt_regs *regs)
> > > +{
> > > +     struct kprobe *p, *cur_kprobe;
> > > +     struct kprobe_ctlblk *kcb;
> > > +     unsigned long addr =3D instruction_pointer(regs);
> > > +
> > > +     kcb =3D get_kprobe_ctlblk();
> > > +     cur_kprobe =3D kprobe_running();
> > > +
> > > +     p =3D get_kprobe((kprobe_opcode_t *) addr);
> > > +
> > > +     if (p) {
> > > +             if (cur_kprobe) {
> > > +                     if (reenter_kprobe(p, regs, kcb))
> > > +                             return true;
> > > +             } else {
> > > +                     /* Probe hit */
> > > +                     set_current_kprobe(p);
> > > +                     kcb->kprobe_status =3D KPROBE_HIT_ACTIVE;
> > > +
> > > +                     /*
> > > +                      * If we have no pre-handler or it returned 0, =
we
> > > +                      * continue with normal processing.  If we have=
 a
> > > +                      * pre-handler and it returned non-zero, it wil=
l
> > > +                      * modify the execution path and no need to sin=
gle
> > > +                      * stepping. Let's just reset current kprobe an=
d exit.
> > > +                      *
> > > +                      * pre_handler can hit a breakpoint and can ste=
p thru
> > > +                      * before return.
> > > +                      */
> > > +                     if (!p->pre_handler || !p->pre_handler(p, regs)=
)
> > > +                             setup_singlestep(p, regs, kcb, 0);
> > > +                     else
> > > +                             reset_current_kprobe();
> > > +             }
> > > +             return true;
> > > +     }
> > > +
> > > +     /*
> > > +      * The breakpoint instruction was removed right
> > > +      * after we hit it.  Another cpu has removed
> > > +      * either a probepoint or a debugger breakpoint
> > > +      * at this address.  In either case, no further
> > > +      * handling of this interrupt is appropriate.
> > > +      * Return back to original instruction, and continue.
> > > +      */
> > > +     return false;
> > > +}
> > > +
> > > +bool __kprobes
> > > +kprobe_single_step_handler(struct pt_regs *regs)
> > > +{
> > > +     struct kprobe_ctlblk *kcb =3D get_kprobe_ctlblk();
> > > +
> > > +     if ((kcb->ss_ctx.ss_pending)
> > > +         && (kcb->ss_ctx.match_addr =3D=3D instruction_pointer(regs)=
)) {
> > > +             clear_ss_context(kcb);  /* clear pending ss */
> > > +
> > > +             kprobes_restore_local_irqflag(kcb, regs);
> > > +
> > > +             post_kprobe_handler(kcb, regs);
> > > +             return true;
> > > +     }
> > > +     return false;
> > > +}
> > > +
> > > +/*
> > > + * Provide a blacklist of symbols identifying ranges which cannot be=
 kprobed.
> > > + * This blacklist is exposed to userspace via debugfs (kprobes/black=
list).
> > > + */
> > > +int __init arch_populate_kprobe_blacklist(void)
> > > +{
> > > +     int ret;
> > > +
> > > +     ret =3D kprobe_add_area_blacklist((unsigned long)__irqentry_tex=
t_start,
> > > +                                     (unsigned long)__irqentry_text_=
end);
> > > +     return ret;
> > > +}
> > > +
> > > +void __kprobes __used *trampoline_probe_handler(struct pt_regs *regs=
)
> > > +{
> > > +     struct kretprobe_instance *ri =3D NULL;
> > > +     struct hlist_head *head, empty_rp;
> > > +     struct hlist_node *tmp;
> > > +     unsigned long flags, orig_ret_address =3D 0;
> > > +     unsigned long trampoline_address =3D
> > > +             (unsigned long)&kretprobe_trampoline;
> > > +     kprobe_opcode_t *correct_ret_addr =3D NULL;
> > > +
> > > +     INIT_HLIST_HEAD(&empty_rp);
> > > +     kretprobe_hash_lock(current, &head, &flags);
> > > +
> > > +     /*
> > > +      * It is possible to have multiple instances associated with a =
given
> > > +      * task either because multiple functions in the call path have
> > > +      * return probes installed on them, and/or more than one
> > > +      * return probe was registered for a target function.
> > > +      *
> > > +      * We can handle this because:
> > > +      *     - instances are always pushed into the head of the list
> > > +      *     - when multiple return probes are registered for the sam=
e
> > > +      *       function, the (chronologically) first instance's ret_a=
ddr
> > > +      *       will be the real return address, and all the rest will
> > > +      *       point to kretprobe_trampoline.
> > > +      */
> > > +     hlist_for_each_entry_safe(ri, tmp, head, hlist) {
> > > +             if (ri->task !=3D current)
> > > +                     /* another task is sharing our hash bucket */
> > > +                     continue;
> > > +
> > > +             orig_ret_address =3D (unsigned long)ri->ret_addr;
> > > +
> > > +             if (orig_ret_address !=3D trampoline_address)
> > > +                     /*
> > > +                      * This is the real return address. Any other
> > > +                      * instances associated with this task are for
> > > +                      * other calls deeper on the call stack
> > > +                      */
> > > +                     break;
> > > +     }
> > > +
> > > +     kretprobe_assert(ri, orig_ret_address, trampoline_address);
> > > +
> > > +     correct_ret_addr =3D ri->ret_addr;
> > > +     hlist_for_each_entry_safe(ri, tmp, head, hlist) {
> > > +             if (ri->task !=3D current)
> > > +                     /* another task is sharing our hash bucket */
> > > +                     continue;
> > > +
> > > +             orig_ret_address =3D (unsigned long)ri->ret_addr;
> > > +             if (ri->rp && ri->rp->handler) {
> > > +                     __this_cpu_write(current_kprobe, &ri->rp->kp);
> > > +                     get_kprobe_ctlblk()->kprobe_status =3D KPROBE_H=
IT_ACTIVE;
> > > +                     ri->ret_addr =3D correct_ret_addr;
> > > +                     ri->rp->handler(ri, regs);
> > > +                     __this_cpu_write(current_kprobe, NULL);
> > > +             }
> > > +
> > > +             recycle_rp_inst(ri, &empty_rp);
> > > +
> > > +             if (orig_ret_address !=3D trampoline_address)
> > > +                     /*
> > > +                      * This is the real return address. Any other
> > > +                      * instances associated with this task are for
> > > +                      * other calls deeper on the call stack
> > > +                      */
> > > +                     break;
> > > +     }
> > > +
> > > +     kretprobe_hash_unlock(current, &flags);
> > > +
> > > +     hlist_for_each_entry_safe(ri, tmp, &empty_rp, hlist) {
> > > +             hlist_del(&ri->hlist);
> > > +             kfree(ri);
> > > +     }
> > > +     return (void *)orig_ret_address;
> > > +}
> > > +
> > > +void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
> > > +                                   struct pt_regs *regs)
> > > +{
> > > +     ri->ret_addr =3D (kprobe_opcode_t *)regs->ra;
> > > +     regs->ra =3D (unsigned long) &kretprobe_trampoline;
> > > +}
> > > +
> > > +int __kprobes arch_trampoline_kprobe(struct kprobe *p)
> > > +{
> > > +     return 0;
> > > +}
> > > +
> > > +int __init arch_init_kprobes(void)
> > > +{
> > > +     return 0;
> > > +}
> > > diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/ris=
cv/kernel/probes/kprobes_trampoline.S
> > > new file mode 100644
> > > index 00000000..6e85d02
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/probes/kprobes_trampoline.S
> > > @@ -0,0 +1,93 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > +/*
> > > + * Author: Patrick St=C3=A4hlin <me@packi.ch>
> > > + */
> > > +#include <linux/linkage.h>
> > > +
> > > +#include <asm/asm.h>
> > > +#include <asm/asm-offsets.h>
> > > +
> > > +     .text
> > > +     .altmacro
> > > +
> > > +     .macro save_all_base_regs
> > > +     REG_S x1,  PT_RA(sp)
> > > +     REG_S x3,  PT_GP(sp)
> > > +     REG_S x4,  PT_TP(sp)
> > > +     REG_S x5,  PT_T0(sp)
> > > +     REG_S x6,  PT_T1(sp)
> > > +     REG_S x7,  PT_T2(sp)
> > > +     REG_S x8,  PT_S0(sp)
> > > +     REG_S x9,  PT_S1(sp)
> > > +     REG_S x10, PT_A0(sp)
> > > +     REG_S x11, PT_A1(sp)
> > > +     REG_S x12, PT_A2(sp)
> > > +     REG_S x13, PT_A3(sp)
> > > +     REG_S x14, PT_A4(sp)
> > > +     REG_S x15, PT_A5(sp)
> > > +     REG_S x16, PT_A6(sp)
> > > +     REG_S x17, PT_A7(sp)
> > > +     REG_S x18, PT_S2(sp)
> > > +     REG_S x19, PT_S3(sp)
> > > +     REG_S x20, PT_S4(sp)
> > > +     REG_S x21, PT_S5(sp)
> > > +     REG_S x22, PT_S6(sp)
> > > +     REG_S x23, PT_S7(sp)
> > > +     REG_S x24, PT_S8(sp)
> > > +     REG_S x25, PT_S9(sp)
> > > +     REG_S x26, PT_S10(sp)
> > > +     REG_S x27, PT_S11(sp)
> > > +     REG_S x28, PT_T3(sp)
> > > +     REG_S x29, PT_T4(sp)
> > > +     REG_S x30, PT_T5(sp)
> > > +     REG_S x31, PT_T6(sp)
> > > +     .endm
> > > +
> > > +     .macro restore_all_base_regs
> > > +     REG_L x3,  PT_GP(sp)
> > > +     REG_L x4,  PT_TP(sp)
> > > +     REG_L x5,  PT_T0(sp)
> > > +     REG_L x6,  PT_T1(sp)
> > > +     REG_L x7,  PT_T2(sp)
> > > +     REG_L x8,  PT_S0(sp)
> > > +     REG_L x9,  PT_S1(sp)
> > > +     REG_L x10, PT_A0(sp)
> > > +     REG_L x11, PT_A1(sp)
> > > +     REG_L x12, PT_A2(sp)
> > > +     REG_L x13, PT_A3(sp)
> > > +     REG_L x14, PT_A4(sp)
> > > +     REG_L x15, PT_A5(sp)
> > > +     REG_L x16, PT_A6(sp)
> > > +     REG_L x17, PT_A7(sp)
> > > +     REG_L x18, PT_S2(sp)
> > > +     REG_L x19, PT_S3(sp)
> > > +     REG_L x20, PT_S4(sp)
> > > +     REG_L x21, PT_S5(sp)
> > > +     REG_L x22, PT_S6(sp)
> > > +     REG_L x23, PT_S7(sp)
> > > +     REG_L x24, PT_S8(sp)
> > > +     REG_L x25, PT_S9(sp)
> > > +     REG_L x26, PT_S10(sp)
> > > +     REG_L x27, PT_S11(sp)
> > > +     REG_L x28, PT_T3(sp)
> > > +     REG_L x29, PT_T4(sp)
> > > +     REG_L x30, PT_T5(sp)
> > > +     REG_L x31, PT_T6(sp)
> > > +     .endm
> > > +
> > > +ENTRY(kretprobe_trampoline)
> > > +     addi sp, sp, -(PT_SIZE_ON_STACK)
> > > +     save_all_base_regs
> > > +
> > > +     move a0, sp /* pt_regs */
> > > +
> > > +     call trampoline_probe_handler
> > > +
> > > +     /* use the result as the return-address */
> > > +     move ra, a0
> > > +
> > > +     restore_all_base_regs
> > > +     addi sp, sp, PT_SIZE_ON_STACK
> > > +
> > > +     ret
> > > +ENDPROC(kretprobe_trampoline)
> > > diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/ke=
rnel/probes/simulate-insn.c
> > > new file mode 100644
> > > index 00000000..2519ce2
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/probes/simulate-insn.c
> > > @@ -0,0 +1,85 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +
> > > +#include <linux/bitops.h>
> > > +#include <linux/kernel.h>
> > > +#include <linux/kprobes.h>
> > > +
> > > +#include "decode-insn.h"
> > > +#include "simulate-insn.h"
> > > +
> > > +static inline bool rv_insn_reg_get_val(struct pt_regs *regs, u32 ind=
ex,
> > > +                                    unsigned long *ptr)
> > > +{
> > > +     if (index =3D=3D 0)
> > > +             *ptr =3D 0;
> > > +     else if (index <=3D 31)
> > > +             *ptr =3D *((unsigned long *)regs + index);
> > > +     else
> > > +             return false;
> > > +
> > > +     return true;
> > > +}
> > > +
> > > +static inline bool rv_insn_reg_set_val(struct pt_regs *regs, u32 ind=
ex,
> > > +                                    unsigned long val)
> > > +{
> > > +     if (index =3D=3D 0)
> > > +             return false;
> > > +     else if (index <=3D 31)
> > > +             *((unsigned long *)regs + index) =3D val;
> > > +     else
> > > +             return false;
> > > +
> > > +     return true;
> > > +}
> > > +
> > > +bool __kprobes simulate_jal(u32 opcode, unsigned long addr, struct p=
t_regs *regs)
> > > +{
> > > +     /*
> > > +      *     31    30       21    20     19        12 11 7 6      0
> > > +      * imm [20] | imm[10:1] | imm[11] | imm[19:12] | rd | opcode
> > > +      *     1         10          1           8       5    JAL/J
> > > +      */
> > > +     bool ret;
> > > +     u32 imm;
> > > +     u32 index =3D (opcode >> 7) & 0x1f;
> > > +
> > > +     ret =3D rv_insn_reg_set_val(regs, index, addr + 4);
> > > +     if (!ret)
> > > +             return ret;
> > > +
> > > +     imm  =3D ((opcode >> 21) & 0x3ff) << 1;
> > > +     imm |=3D ((opcode >> 20) & 0x1)   << 11;
> > > +     imm |=3D ((opcode >> 12) & 0xff)  << 12;
> > > +     imm |=3D ((opcode >> 31) & 0x1)   << 20;
> > > +
> > > +     instruction_pointer_set(regs, addr + sign_extend32((imm), 20));
> > > +
> > > +     return ret;
> > > +}
> > > +
> > > +bool __kprobes simulate_jalr(u32 opcode, unsigned long addr, struct =
pt_regs *regs)
> > > +{
> > > +     /*
> > > +      * 31          20 19 15 14 12 11 7 6      0
> > > +      *  offset[11:0] | rs1 | 010 | rd | opcode
> > > +      *      12         5      3    5    JALR/JR
> > > +      */
> > > +     bool ret;
> > > +     unsigned long base_addr;
> > > +     u32 imm =3D (opcode >> 20) & 0xfff;
> > > +     u32 rd_index =3D (opcode >> 7) & 0x1f;
> > > +     u32 rs1_index =3D (opcode >> 15) & 0x1f;
> > > +
> > > +     ret =3D rv_insn_reg_set_val(regs, rd_index, addr + 4);
> > > +     if (!ret)
> > > +             return ret;
> > > +
> > > +     ret =3D rv_insn_reg_get_val(regs, rs1_index, &base_addr);
> > > +     if (!ret)
> > > +             return ret;
> > > +
> > > +     instruction_pointer_set(regs, (base_addr + sign_extend32((imm),=
 11))&~1);
> > > +
> > > +     return ret;
> > > +}
> > > diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/ke=
rnel/probes/simulate-insn.h
> > > new file mode 100644
> > > index 00000000..a62d784
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/probes/simulate-insn.h
> > > @@ -0,0 +1,47 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > +
> > > +#ifndef _RISCV_KERNEL_PROBES_SIMULATE_INSN_H
> > > +#define _RISCV_KERNEL_PROBES_SIMULATE_INSN_H
> > > +
> > > +#define __RISCV_INSN_FUNCS(name, mask, val)                         =
 \
> > > +static __always_inline bool riscv_insn_is_##name(probe_opcode_t code=
)        \
> > > +{                                                                   =
 \
> > > +     BUILD_BUG_ON(~(mask) & (val));                                 =
 \
> > > +     return (code & (mask)) =3D=3D (val);                           =
     \
> > > +}                                                                   =
 \
> > > +bool simulate_##name(u32 opcode, unsigned long addr,                =
 \
> > > +                  struct pt_regs *regs);
> > > +
> > > +#define RISCV_INSN_REJECTED(name, code)                             =
         \
> > > +     do {                                                           =
 \
> > > +             if (riscv_insn_is_##name(code)) {                      =
 \
> > > +                     return INSN_REJECTED;                          =
 \
> > > +             }                                                      =
 \
> > > +     } while (0)
> > > +
> > > +__RISCV_INSN_FUNCS(system,   0x7f, 0x73)
> > > +__RISCV_INSN_FUNCS(fence,    0x7f, 0x0f)
> > > +
> > > +#define RISCV_INSN_SET_SIMULATE(name, code)                         =
 \
> > > +     do {                                                           =
 \
> > > +             if (riscv_insn_is_##name(code)) {                      =
 \
> > > +                     api->handler =3D simulate_##name;              =
   \
> > > +                     return INSN_GOOD_NO_SLOT;                      =
 \
> > > +             }                                                      =
 \
> > > +     } while (0)
> > > +
> > > +__RISCV_INSN_FUNCS(c_j,              0xe003, 0xa001)
> > > +__RISCV_INSN_FUNCS(c_jr,     0xf007, 0x8002)
> > > +__RISCV_INSN_FUNCS(c_jal,    0xe003, 0x2001)
> > > +__RISCV_INSN_FUNCS(c_jalr,   0xf007, 0x9002)
> > > +__RISCV_INSN_FUNCS(c_beqz,   0xe003, 0xc001)
> > > +__RISCV_INSN_FUNCS(c_bnez,   0xe003, 0xe001)
> > > +__RISCV_INSN_FUNCS(c_ebreak, 0xffff, 0x9002)
> > > +
> > > +__RISCV_INSN_FUNCS(auipc,    0x7f, 0x17)
> > > +__RISCV_INSN_FUNCS(branch,   0x7f, 0x63)
> > > +
> > > +__RISCV_INSN_FUNCS(jal,              0x7f, 0x6f)
> > > +__RISCV_INSN_FUNCS(jalr,     0x707f, 0x67)
> > > +
> > > +#endif /* _RISCV_KERNEL_PROBES_SIMULATE_INSN_H */
> > > diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> > > index ecec177..ac2e786 100644
> > > --- a/arch/riscv/kernel/traps.c
> > > +++ b/arch/riscv/kernel/traps.c
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/signal.h>
> > >  #include <linux/kdebug.h>
> > >  #include <linux/uaccess.h>
> > > +#include <linux/kprobes.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/module.h>
> > >  #include <linux/irq.h>
> > > @@ -145,6 +146,14 @@ static inline unsigned long get_break_insn_lengt=
h(unsigned long pc)
> > >
> > >  asmlinkage __visible void do_trap_break(struct pt_regs *regs)
> > >  {
> > > +#ifdef CONFIG_KPROBES
> > > +     if (kprobe_single_step_handler(regs))
> > > +             return;
> > > +
> > > +     if (kprobe_breakpoint_handler(regs))
> > > +             return;
> > > +#endif
> > > +
> > >       if (user_mode(regs))
> > >               force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)reg=
s->epc);
> > >  #ifdef CONFIG_KGDB
> > > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> > > index ae7b7fe..da0c08c 100644
> > > --- a/arch/riscv/mm/fault.c
> > > +++ b/arch/riscv/mm/fault.c
> > > @@ -13,6 +13,7 @@
> > >  #include <linux/perf_event.h>
> > >  #include <linux/signal.h>
> > >  #include <linux/uaccess.h>
> > > +#include <linux/kprobes.h>
> > >
> > >  #include <asm/pgalloc.h>
> > >  #include <asm/ptrace.h>
> > > @@ -40,6 +41,9 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
> > >       tsk =3D current;
> > >       mm =3D tsk->mm;
> > >
> > > +     if (kprobe_page_fault(regs, cause))
> > > +             return;
> > > +
> > >       /*
> > >        * Fault-in kernel-space virtual memory on-demand.
> > >        * The 'reference' page table is init_mm.pgd.
> > > --
> > > 2.7.4
> > >
> >
> >
> > --
> > Masami Hiramatsu <mhiramat@kernel.org>



--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
