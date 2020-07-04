Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC96C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2247420890
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 11:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgGDLfF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 07:35:05 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:45322 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGDLfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 07:35:05 -0400
Received: by mail-yb1-f193.google.com with SMTP id y17so14577716ybm.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 04:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vk74MHPAeIvcMKYpspR75LMA91KoxGRB3f0LyIi3THo=;
        b=o1T+1IGfiaPWDGbDodtczndaETPQc8r5jkIItvbqW6h9DOjJ4EJpaJBo87C/QNYejk
         Ocru3POR0UjI35Nb0qPLpU5djo5mgoyRQ8LwWO+ykWnhe/RI9xVRPm3l+85ODIKjATxt
         /0imKFab+0MCj0ZB0MMuUs2d5EfBRLCaDTZWomUkoiuGPeq9c37F8UR8NuGUG5+y4ax0
         EdLnDD7nkJzBYVvSZ9mRzBDHzaor6edJmffg6modKHh3CABYZ++la5+e8EiiQsYWUfpB
         5u5E9D0lhQjhn3KMt99XhT36JEcvZ5QX6BrUPGwr/k4m09RjseH/RTb7qhU043zaon0v
         j7hg==
X-Gm-Message-State: AOAM533KUAxPpRrnPm4io/f0wmyRlnkRTBPE56C9BO/Abj3vHASy6w3z
        grqkPJ+K6/NxBfrKppa0Awtc9+GcDTvYP0KHpbI=
X-Google-Smtp-Source: ABdhPJzOFsKyaQDZNPAIfKfUsKapOR/mTd9zeC0qfmThSAs3pbINDR/xXeaSEBABTEiJRfz2zhNREPsO/8XJoEcPD3Y=
X-Received: by 2002:a25:3b4e:: with SMTP id i75mr16636329yba.231.1593862503546;
 Sat, 04 Jul 2020 04:35:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200702200727.239348-1-kernel@esmil.dk> <CANBLGczQ51LQCiubvu2HTYrdnW2q_6GY_dfVNrV6M+dnRh1KQw@mail.gmail.com>
 <CAJ+HfNh38DwrwKrDi-S_3rzyF+=B4N3kXfAOoMEnXOyoq3LkSg@mail.gmail.com>
In-Reply-To: <CAJ+HfNh38DwrwKrDi-S_3rzyF+=B4N3kXfAOoMEnXOyoq3LkSg@mail.gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Sat, 4 Jul 2020 13:34:52 +0200
Message-ID: <CANBLGcxf_vZ6b75Nm52-p0W-1h+Yft77gW+j+U5Wa-9uUo=pxw@mail.gmail.com>
Subject: Re: [RFC] riscv: Add jump-label implementation
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Atish Patra <atish.patra@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jul 2020 at 13:23, Björn Töpel <bjorn.topel@gmail.com> wrote:
> On Fri, 3 Jul 2020 at 17:43, Emil Renner Berthing <kernel@esmil.dk> wrote:
> > On Thu, 2 Jul 2020 at 22:07, Emil Renner Berthing <kernel@esmil.dk> wrote:
> > >
> > > Add basic jump-label implementation heavily based
> > > on the ARM64 version.
> > >
> > > Tested on the HiFive Unleashed.
> > >
> > > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > > ---
> > >
> > > This seems to work on my HiFive Unleashed. At least boots, runs fine
> > > and the static key self-tests doesn't complain, but I'm sure I've missed
> > > something, so I'm sending this as an RFC.
> > >
> > > /Emil
> > >
> > >  .../core/jump-labels/arch-support.txt         |  2 +-
> > >  arch/riscv/Kconfig                            |  2 +
> > >  arch/riscv/include/asm/jump_label.h           | 59 +++++++++++++++++++
> > >  arch/riscv/kernel/Makefile                    |  2 +
> > >  arch/riscv/kernel/jump_label.c                | 44 ++++++++++++++
> > >  5 files changed, 108 insertions(+), 1 deletion(-)
> > >  create mode 100644 arch/riscv/include/asm/jump_label.h
> > >  create mode 100644 arch/riscv/kernel/jump_label.c
> > >
> > > diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
> > > index 632a1c7aefa2..760243d18ed7 100644
> > > --- a/Documentation/features/core/jump-labels/arch-support.txt
> > > +++ b/Documentation/features/core/jump-labels/arch-support.txt
> > > @@ -23,7 +23,7 @@
> > >      |    openrisc: | TODO |
> > >      |      parisc: |  ok  |
> > >      |     powerpc: |  ok  |
> > > -    |       riscv: | TODO |
> > > +    |       riscv: |  ok  |
> > >      |        s390: |  ok  |
> > >      |          sh: | TODO |
> > >      |       sparc: |  ok  |
> > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > index fd639937e251..d2f5c53fdc19 100644
> > > --- a/arch/riscv/Kconfig
> > > +++ b/arch/riscv/Kconfig
> > > @@ -46,6 +46,8 @@ config RISCV
> > >         select GENERIC_TIME_VSYSCALL if MMU && 64BIT
> > >         select HANDLE_DOMAIN_IRQ
> > >         select HAVE_ARCH_AUDITSYSCALL
> > > +       select HAVE_ARCH_JUMP_LABEL
> > > +       select HAVE_ARCH_JUMP_LABEL_RELATIVE
> > >         select HAVE_ARCH_KASAN if MMU && 64BIT
> > >         select HAVE_ARCH_KGDB
> > >         select HAVE_ARCH_KGDB_QXFER_PKT
> > > diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm/jump_label.h
> > > new file mode 100644
> > > index 000000000000..29be6d351866
> > > --- /dev/null
> > > +++ b/arch/riscv/include/asm/jump_label.h
> > > @@ -0,0 +1,59 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only */
> > > +/*
> > > + * Copyright (C) 2020 Emil Renner Berthing
> > > + *
> > > + * Based on arch/arm64/include/asm/jump_label.h
> > > + */
> > > +#ifndef __ASM_JUMP_LABEL_H
> > > +#define __ASM_JUMP_LABEL_H
> > > +
> > > +#ifndef __ASSEMBLY__
> > > +
> > > +#include <linux/types.h>
> > > +
> > > +#define JUMP_LABEL_NOP_SIZE 4
> > > +
> > > +static __always_inline bool arch_static_branch(struct static_key *key,
> > > +                                              bool branch)
> > > +{
> > > +       asm_volatile_goto(
> > > +               "       .option push                            \n\n"
> > > +               "       .option norelax                         \n\n"
> > > +               "       .option norvc                           \n\n"
> > > +               "1:     nop                                     \n\t"
> > > +               "       .option pop                             \n\n"
> > > +               "       .pushsection    __jump_table, \"aw\"    \n\t"
> > > +               "       .align          3                       \n\t"
> > > +               "       .long           1b - ., %l[l_yes] - .   \n\t"
> > > +               "       .quad           %0 - .                  \n\t"
> >
> > With HAVE_ARCH_JUMP_LABEL_RELATIVE we get
> > struct jump_entry {
> >   s32 code;
> >   s32 target;
> >   long key;
> > }
> > ..so this .quad and the one below should be replaced by the RISCV_PTR
> > macro to match the struct in 32bit kernels.
> >
>
> Indeed. And nice work! Can you respin the patch with the 32b fix
> above, and also without the RFC tag?

Yes, of course. If you don't mind I'll wait a bit and let this collect
a bit more comments.

> Curious; Why is [branch ? 1 : 0] needed when coding the boolean into
> the key pointer (arm64 is just [branch]). Different encoding of
> booleans (branch in this case)?

No, that was just me being unsure exactly how bool works when used as
an index. After reading up on it it seems the original code is right,
you can actually trust that _Bool is either 0 or 1. I'll fix it in the
next version. Thanks!

/Emil

>
>
> Cheers,
> Björn
>
> > > +               "       .popsection                             \n\t"
> > > +               :  :  "i"(&((char *)key)[branch ? 1 : 0]) :  : l_yes);
> > > +
> > > +       return false;
> > > +l_yes:
> > > +       return true;
> > > +}
> > > +
> > > +static __always_inline bool arch_static_branch_jump(struct static_key *key,
> > > +                                                   bool branch)
> > > +{
> > > +       asm_volatile_goto(
> > > +               "       .option push                            \n\n"
> > > +               "       .option norelax                         \n\n"
> > > +               "       .option norvc                           \n\n"
> > > +               "1:     jal             zero, %l[l_yes]         \n\t"
> > > +               "       .option pop                             \n\n"
> > > +               "       .pushsection    __jump_table, \"aw\"    \n\t"
> > > +               "       .align          3                       \n\t"
> > > +               "       .long           1b - ., %l[l_yes] - .   \n\t"
> > > +               "       .quad           %0 - .                  \n\t"
> > > +               "       .popsection                             \n\t"
> > > +               :  :  "i"(&((char *)key)[branch ? 1 : 0]) :  : l_yes);
> > > +
> > > +       return false;
> > > +l_yes:
> > > +       return true;
> > > +}
> > > +
> > > +#endif  /* __ASSEMBLY__ */
> > > +#endif /* __ASM_JUMP_LABEL_H */
> > > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > > index b355cf485671..a5287ab9f7f2 100644
> > > --- a/arch/riscv/kernel/Makefile
> > > +++ b/arch/riscv/kernel/Makefile
> > > @@ -53,4 +53,6 @@ endif
> > >  obj-$(CONFIG_HOTPLUG_CPU)      += cpu-hotplug.o
> > >  obj-$(CONFIG_KGDB)             += kgdb.o
> > >
> > > +obj-$(CONFIG_JUMP_LABEL)       += jump_label.o
> > > +
> > >  clean:
> > > diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
> > > new file mode 100644
> > > index 000000000000..55b2d742efe1
> > > --- /dev/null
> > > +++ b/arch/riscv/kernel/jump_label.c
> > > @@ -0,0 +1,44 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +/*
> > > + * Copyright (C) 2020 Emil Renner Berthing
> > > + *
> > > + * Based on arch/arm64/kernel/jump_label.c
> > > + */
> > > +#include <linux/kernel.h>
> > > +#include <linux/jump_label.h>
> > > +#include <asm/patch.h>
> > > +
> > > +#define RISCV_INSN_NOP 0x00000013
> > > +#define RISCV_INSN_JAL 0x0000006f
> > > +
> > > +void arch_jump_label_transform(struct jump_entry *entry,
> > > +                              enum jump_label_type type)
> > > +{
> > > +       void *addr = (void *)jump_entry_code(entry);
> > > +       u32 insn;
> > > +
> > > +       if (type == JUMP_LABEL_JMP) {
> > > +               u32 offset = jump_entry_target(entry) - jump_entry_code(entry);
> > > +
> > > +               insn = RISCV_INSN_JAL |
> > > +                       ((offset & GENMASK(19, 12)) << (12 - 12)) |
> > > +                       ((offset & GENMASK(11, 11)) << (20 - 11)) |
> > > +                       ((offset & GENMASK(10,  1)) << (21 -  1)) |
> > > +                       ((offset & GENMASK(20, 20)) << (31 - 20));
> > > +       } else
> > > +               insn = RISCV_INSN_NOP;
> > > +
> > > +       patch_text_nosync(addr, &insn, sizeof(insn));
> > > +}
> > > +
> > > +void arch_jump_label_transform_static(struct jump_entry *entry,
> > > +                                     enum jump_label_type type)
> > > +{
> > > +       /*
> > > +        * We use the same instructions in the arch_static_branch and
> > > +        * arch_static_branch_jump inline functions, so there's no
> > > +        * need to patch them up here.
> > > +        * The core will call arch_jump_label_transform  when those
> > > +        * instructions need to be replaced.
> > > +        */
> > > +}
> > > --
> > > 2.27.0
> > >
