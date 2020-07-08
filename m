Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F52C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B58BF206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 09:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbgGHJpS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:45:18 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:41400 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgGHJpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 05:45:18 -0400
Received: by mail-yb1-f194.google.com with SMTP id a15so7145332ybs.8;
        Wed, 08 Jul 2020 02:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z+Hv0F2P4n1XVQheQtChcgxf0BXLLqGWuYKeMgWau8Q=;
        b=VsL9TocYv82BCKJIesnEwlQYhc8mop/AjwUKGxG3rlMcj/TKP5+NmB/9ZC1garq3IN
         N8jwUmjW2WRaXFt+9YSErT7PZYHgjhlN9t03DYRRgS3bI+IXVIij24TUvNqgZepC2tl8
         iWnDV07uBOh3pGI5gDPxhciXi3zWoezvrcvUOXbTwKwrBsIRBep1knHOynUHqYIaOFXn
         X2Q2Kt6rUHZgXhRaTyFVhNmvRW6g7VVz4gvwktl9RFpYMMZKm95wmxyAaCVdZ1oJglfC
         bo058XQ3jLVy+ZY6dyyuapzh5rfMCDHNQ5bU6MRLvG63skIpuUn/V60mxVqoz7Tb1Kw/
         mN2g==
X-Gm-Message-State: AOAM532HV6x1dt6V7WFRsaLJdkHAsTCS/A1i6ezEet4fLLp/FILp20dV
        Ck5F1RNgEJJXH2jbV1n8BfBUFaCixpQ5b4J5BMc=
X-Google-Smtp-Source: ABdhPJzOwfIqr+4z/7B9QDoGIw0IEy7189/mZtWkbnaPZC9pAhoY64cG82Pw+MExWaL250djHHLKXcKLhtQsvCLXlkg=
X-Received: by 2002:a25:4603:: with SMTP id t3mr85348810yba.471.1594201516575;
 Wed, 08 Jul 2020 02:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200707150748.14651-1-kernel@esmil.dk> <CAJ+HfNhYPQByOPu+07v5vstADZPtqakuMeK79_1etJjbV1vBLw@mail.gmail.com>
In-Reply-To: <CAJ+HfNhYPQByOPu+07v5vstADZPtqakuMeK79_1etJjbV1vBLw@mail.gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
Date:   Wed, 8 Jul 2020 11:45:05 +0200
Message-ID: <CANBLGcxXmZbK7eoa_M5U0vTOFFQQqiQPJOcXK70y0HdWPC+CqQ@mail.gmail.com>
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

On Wed, 8 Jul 2020 at 09:42, Björn Töpel <bjorn.topel@gmail.com> wrote:
>
> On Tue, 7 Jul 2020 at 17:08, Emil Renner Berthing <kernel@esmil.dk> wrote:
> >
> > Add jump-label implementation based on the ARM64 version.
> >
> > Tested on the HiFive Unleashed board.
> >
>
> I took your patch for a spin on qemu. The boot selftest
> (CONFIG_STATIC_KEYS_SELFTEST=y) passes, but the module test
> (CONFIG_TEST_STATIC_KEYS=m) does not.
>
> When I run the in "test tools/testing/selftests/static_keys" (this
> simply loads the test_static_key_base.ko and test_static_keys.ko
> modules) I get:
>
> [  134.090464] test_static_keys: Unknown relocation type 36
>
> 36 is the relocation type R_RISCV_ADD64, which is not handled in
> arch/riscv/kernel/module.c.
>
> If you dump the relocation entries for test_static_keys.ko
> (riscv64-linux-gnu-objdump -r test_static_keys.ko), you'll see that:
>
> RELOCATION RECORDS FOR [__jump_table]:
> OFFSET           TYPE              VALUE
> 0000000000000000 R_RISCV_ADD32     .L1^B1
> 0000000000000000 R_RISCV_SUB32     .L0
> 0000000000000004 R_RISCV_ADD32     .L3
> 0000000000000004 R_RISCV_SUB32     .L0
> 0000000000000008 R_RISCV_ADD64     old_true_key+0x0000000000000001
> 0000000000000008 R_RISCV_SUB64     .L0
> ...
>
> It would be great if you could add a patch for that as well (separate,
> same series). R_RISCV_ADD64 *and* R_RISCV_SUB64 are currently
> unhandled by module.c.

On it! I'll also add the CONFIG_JUMP_LABEL to defconfig to the next version.
>
> Cheers,
> Björn
>
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
> > +
> > +               insn = RISCV_INSN_JAL |
> > +                       ((offset & GENMASK(19, 12)) << (12 - 12)) |
> > +                       ((offset & GENMASK(11, 11)) << (20 - 11)) |
> > +                       ((offset & GENMASK(10,  1)) << (21 -  1)) |
> > +                       ((offset & GENMASK(20, 20)) << (31 - 20));
> > +       } else
> > +               insn = RISCV_INSN_NOP;
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
