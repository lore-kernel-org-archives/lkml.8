Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B2D3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBA62065D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728132AbgGHJnl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:43:41 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:37332 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgGHJnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:43:40 -0400
Received: by mail-yb1-f194.google.com with SMTP id x9so9147297ybd.4;
        Wed, 08 Jul 2020 02:43:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZX9BkEKAW8TV+Ga/zDhp6Z2rB0/YjEWIuTVx8NxsBuY=;
        b=tTXXg/AvMTUxBlpeXLKyXXcORtI1ZrY8GJWggwLi/bJat11rQyGS8FIwVD4u/VV4Uo
         lBfuhCEPFxMXW+70/ntglblOR/gWVZka3ccyg68jBRe0rEzrTJvnUVwrdDSDo1Hu2lpW
         ZBdNS1Uq92JJi0x3WjhocGXSFEuA3suomffOyseGMChJfFLQJBdRemjM1Lmn6P2L2OSe
         HL/6E01URHKL/p0rVUSQ55tRP9WtNk2IqEl+LLXzGJFtzkpsNU+3EAtORmPwQOl2Ib7i
         LGuRgCnUwbCkWwQ13n0UqK7R4YXbULNS85XO93FTLQ44Y4XoTjpGOQ4/yWvnhR6yVWCj
         IMoQ==
X-Gm-Message-State: AOAM532txPjAE8gsbnf2bU5p5yTiVuxbiCJn6LHuLpSHXCcmrAFhqLKW
        xqfVr0x/IYhXMQPXUQjNEFRgr4w+TGYKoaZjscSjplDT6PU=
X-Google-Smtp-Source: ABdhPJzvHpBSk9p3hA84xFGwkC2BfGMVbo+A8H5nJwbHAeADBX/tXMZ29tM8cEKm3DpucsiWx86z8VyqrrmN/9SGHJM=
X-Received: by 2002:a5b:347:: with SMTP id q7mr88714795ybp.509.1594201418441;
 Wed, 08 Jul 2020 02:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200707150748.14651-1-kernel@esmil.dk> <CAJ+HfNjAXQCGwQqqbJorQMEx6JT9H-4CQD6iY9MHJJLNnvMaGg@mail.gmail.com>
In-Reply-To: <CAJ+HfNjAXQCGwQqqbJorQMEx6JT9H-4CQD6iY9MHJJLNnvMaGg@mail.gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Wed, 8 Jul 2020 11:43:27 +0200
Message-ID: <CANBLGcwHK_ge8ocNJ7b-MrZCkCxGR5Y+3mM1Po7iAUov+tKMUg@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: Add jump-label implementation
To:     =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 at 08:28, Björn Töpel <bjorn.topel@gmail.com> wrote:
> On Tue, 7 Jul 2020 at 17:08, Emil Renner Berthing <kernel@esmil.dk> wrote:
> >
> > Add jump-label implementation based on the ARM64 version.
> >
>
> Thanks for working on this!
>
> > Tested on the HiFive Unleashed board.
> >
> > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > ---
> >
> > Changes since RFC:
> > - Use RISCV_PTR and RISCV_LGPTR macros to match struct jump_table
> >   also in 32bit kernels.
> > - Remove unneeded branch ? 1 : 0, thanks Björn
> > - Fix \n\n instead of \n\t mistake
> >
> >  .../core/jump-labels/arch-support.txt         |  2 +-
> >  arch/riscv/Kconfig                            |  2 +
> >  arch/riscv/include/asm/jump_label.h           | 59 +++++++++++++++++++
> >  arch/riscv/kernel/Makefile                    |  2 +
> >  arch/riscv/kernel/jump_label.c                | 44 ++++++++++++++
> >  5 files changed, 108 insertions(+), 1 deletion(-)
> >  create mode 100644 arch/riscv/include/asm/jump_label.h
> >  create mode 100644 arch/riscv/kernel/jump_label.c
> >
> > diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/Documentation/features/core/jump-labels/arch-support.txt
> > index 632a1c7aefa2..760243d18ed7 100644
> > --- a/Documentation/features/core/jump-labels/arch-support.txt
> > +++ b/Documentation/features/core/jump-labels/arch-support.txt
> > @@ -23,7 +23,7 @@
> >      |    openrisc: | TODO |
> >      |      parisc: |  ok  |
> >      |     powerpc: |  ok  |
> > -    |       riscv: | TODO |
> > +    |       riscv: |  ok  |
> >      |        s390: |  ok  |
> >      |          sh: | TODO |
> >      |       sparc: |  ok  |
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index fd639937e251..d2f5c53fdc19 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -46,6 +46,8 @@ config RISCV
> >         select GENERIC_TIME_VSYSCALL if MMU && 64BIT
> >         select HANDLE_DOMAIN_IRQ
> >         select HAVE_ARCH_AUDITSYSCALL
> > +       select HAVE_ARCH_JUMP_LABEL
> > +       select HAVE_ARCH_JUMP_LABEL_RELATIVE
> >         select HAVE_ARCH_KASAN if MMU && 64BIT
> >         select HAVE_ARCH_KGDB
> >         select HAVE_ARCH_KGDB_QXFER_PKT
> > diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm/jump_label.h
> > new file mode 100644
> > index 000000000000..d5fb342bfccf
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/jump_label.h
> > @@ -0,0 +1,59 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2020 Emil Renner Berthing
> > + *
> > + * Based on arch/arm64/include/asm/jump_label.h
> > + */
> > +#ifndef __ASM_JUMP_LABEL_H
> > +#define __ASM_JUMP_LABEL_H
> > +
> > +#ifndef __ASSEMBLY__
> > +
> > +#include <linux/types.h>
> > +
> > +#define JUMP_LABEL_NOP_SIZE 4
> > +
> > +static __always_inline bool arch_static_branch(struct static_key *key,
> > +                                              bool branch)
> > +{
> > +       asm_volatile_goto(
> > +               "       .option push                            \n\t"
> > +               "       .option norelax                         \n\t"
> > +               "       .option norvc                           \n\t"
> > +               "1:     nop                                     \n\t"
> > +               "       .option pop                             \n\t"
> > +               "       .pushsection    __jump_table, \"aw\"    \n\t"
> > +               "       .align          " RISCV_LGPTR "         \n\t"
> > +               "       .long           1b - ., %l[label] - .   \n\t"
> > +               "       " RISCV_PTR "   %0 - .                  \n\t"
> > +               "       .popsection                             \n\t"
> > +               :  :  "i"(&((char *)key)[branch]) :  : label);
> > +
> > +       return false;
> > +label:
> > +       return true;
> > +}
> > +
> > +static __always_inline bool arch_static_branch_jump(struct static_key *key,
> > +                                                   bool branch)
> > +{
> > +       asm_volatile_goto(
> > +               "       .option push                            \n\t"
> > +               "       .option norelax                         \n\t"
> > +               "       .option norvc                           \n\t"
> > +               "1:     jal             zero, %l[label]         \n\t"
> > +               "       .option pop                             \n\t"
> > +               "       .pushsection    __jump_table, \"aw\"    \n\t"
> > +               "       .align          " RISCV_LGPTR "         \n\t"
> > +               "       .long           1b - ., %l[label] - .   \n\t"
> > +               "       " RISCV_PTR "   %0 - .                  \n\t"
> > +               "       .popsection                             \n\t"
> > +               :  :  "i"(&((char *)key)[branch]) :  : label);
> > +
> > +       return false;
> > +label:
> > +       return true;
> > +}
> > +
> > +#endif  /* __ASSEMBLY__ */
> > +#endif /* __ASM_JUMP_LABEL_H */
> > diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> > index b355cf485671..a5287ab9f7f2 100644
> > --- a/arch/riscv/kernel/Makefile
> > +++ b/arch/riscv/kernel/Makefile
> > @@ -53,4 +53,6 @@ endif
> >  obj-$(CONFIG_HOTPLUG_CPU)      += cpu-hotplug.o
> >  obj-$(CONFIG_KGDB)             += kgdb.o
> >
> > +obj-$(CONFIG_JUMP_LABEL)       += jump_label.o
> > +
> >  clean:
> > diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
> > new file mode 100644
> > index 000000000000..55b2d742efe1
> > --- /dev/null
> > +++ b/arch/riscv/kernel/jump_label.c
> > @@ -0,0 +1,44 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2020 Emil Renner Berthing
> > + *
> > + * Based on arch/arm64/kernel/jump_label.c
> > + */
> > +#include <linux/kernel.h>
> > +#include <linux/jump_label.h>
> > +#include <asm/patch.h>
> > +
> > +#define RISCV_INSN_NOP 0x00000013
> > +#define RISCV_INSN_JAL 0x0000006f
> > +
> > +void arch_jump_label_transform(struct jump_entry *entry,
> > +                              enum jump_label_type type)
> > +{
> > +       void *addr = (void *)jump_entry_code(entry);
> > +       u32 insn;
> > +
> > +       if (type == JUMP_LABEL_JMP) {
> > +               u32 offset = jump_entry_target(entry) - jump_entry_code(entry);
>
> The 20b jump offset of JAL is enough, but to catch future changes that
> might potentially break this, I would add a WARN to catch if offset
> >20b (or overkill fallback to JALR -- don't do that.).

You're right. Not all architectures have warnings, but all arch's but
parisc and xtensa supports offsets > 20b. I'll add a WARN.

> Somewhat related to that; The UNIX specification for RISC-V requires
> support for RVC. Would it make sense to use the C.-instructions C.J
> and C.NOP? Really a nit, or more of a question. I'm fine with this 32b
> version!

That would definitely be possible, but then we only get 11b of offset
available. That's even lower than the 17b of parisc and xtensa. That
would probably need a CONFIG flag unless someone can come up with a
way to estimate the offset at compile time.

Alternatively I can't see a way that two compressed instructions could
combine to a jump with more than the 20b of offset, and I can't
imagine two compressed nops would be better than one 32b nop, so
unless you're willing to live with 11b offsets I think we're better
off with the 32b instructions.

> > +
> > +               insn = RISCV_INSN_JAL |
> > +                       ((offset & GENMASK(19, 12)) << (12 - 12)) |
> > +                       ((offset & GENMASK(11, 11)) << (20 - 11)) |
> > +                       ((offset & GENMASK(10,  1)) << (21 -  1)) |
> > +                       ((offset & GENMASK(20, 20)) << (31 - 20));
> > +       } else
> > +               insn = RISCV_INSN_NOP;
>
> Since the if-statement needs {}, the else-clause should have one too.

Will fix.

> Feel free to add:
> Reviewed-by: Björn Töpel <bjorn.topel@gmail.com>

Thanks!

> Cheers,
> Björn
> > +
> > +       patch_text_nosync(addr, &insn, sizeof(insn));
> > +}
> > +
> > +void arch_jump_label_transform_static(struct jump_entry *entry,
> > +                                     enum jump_label_type type)
> > +{
> > +       /*
> > +        * We use the same instructions in the arch_static_branch and
> > +        * arch_static_branch_jump inline functions, so there's no
> > +        * need to patch them up here.
> > +        * The core will call arch_jump_label_transform  when those
> > +        * instructions need to be replaced.
> > +        */
> > +}
> > --
> > 2.27.0
> >
