Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DDB6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:28:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2851820720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:28:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n7FMks2e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729312AbgGHG2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbgGHG2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:28:18 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1A0C061755;
        Tue,  7 Jul 2020 23:28:17 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g10so3227681wmc.1;
        Tue, 07 Jul 2020 23:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dXu5n7UnzXjSQFaGyAVNzz8SpkYn+2SFvXxbS6tYHK4=;
        b=n7FMks2eDBT0sZSszxaxkHERNXYjzdepd4DykLcFLuucJlSAUTZP6YEgBGMddMYLPx
         PgtXQQahLjvuceTYyxOdoYEqa7xT8IjclelC/YNzlbGfL3F14y7ntNxivVeF8+Rgrz6L
         dGP6Qfh+z7wkPSgm1tjWaJ48GvLKxUlefo5yEP1odCQbJvCMNYj2ZuGbYbnJnX6E8zdr
         WD3MuivHcz8wV+RRNm6CSR2qvRYbSbBU71YQr6hfDVxn/K876PY1S3t1RggFGoI8a18z
         iqWItu0Hr2IlWl8IekFZeOoBfAg8x+Gq96Jp0604cYSKsnnyWpulTk+jsCpXhoKPK9Fu
         Jflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dXu5n7UnzXjSQFaGyAVNzz8SpkYn+2SFvXxbS6tYHK4=;
        b=fk/xrk4couEBTZCVoHy1T5vvu1CAjMf7U9Yeb81yUc/7ShmsjETbD7cVqEgPajuj3y
         GhyEGT53IYDHEAUgf50SkZvbinzkK29J/fDloAhhKXetTVekA7ipOlt6a53CTZCZ1av+
         yh4q8AjBxanrFsCSA4oUHXChnqIbA5CNNYqucGtBXMXekRZiBN2PdGlUnZlcTQDlPUaA
         FoeHIhyhamSF7+HTwn68FEG5SQfRqTW039CEPWja0iq7OkYmFUlWht1AmSmAD3D3Axrk
         ObQnrWgDVOPubV2O4ZebZa6nn3PvzHIY0VR/f90abfvKpK1m+axUF5/RLPolfTl7ozVC
         TGjQ==
X-Gm-Message-State: AOAM533ShwWKDizRw0qkNQP/pXsE5MXKhAfr2L85h+GQ0XuCJeW285d1
        /YRwvEzO6bzOJa7QdIy2Z7tqX8pT8CkgNA9oYICYZXxf1sU=
X-Google-Smtp-Source: ABdhPJwQnZ/YDZ551wmVcNkJ9lN1l8ye5tkdNdKpJEhquxAs4nc2C6P5HnRfkfLAxpP5esyK00SXWhWX2i0AzeuUbP0=
X-Received: by 2002:a7b:c259:: with SMTP id b25mr7682358wmj.107.1594189696356;
 Tue, 07 Jul 2020 23:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200707150748.14651-1-kernel@esmil.dk>
In-Reply-To: <20200707150748.14651-1-kernel@esmil.dk>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Wed, 8 Jul 2020 08:28:04 +0200
Message-ID: <CAJ+HfNjAXQCGwQqqbJorQMEx6JT9H-4CQD6iY9MHJJLNnvMaGg@mail.gmail.com>
Subject: Re: [PATCH v1] riscv: Add jump-label implementation
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jul 2020 at 17:08, Emil Renner Berthing <kernel@esmil.dk> wrote:
>
> Add jump-label implementation based on the ARM64 version.
>

Thanks for working on this!

> Tested on the HiFive Unleashed board.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---
>
> Changes since RFC:
> - Use RISCV_PTR and RISCV_LGPTR macros to match struct jump_table
>   also in 32bit kernels.
> - Remove unneeded branch ? 1 : 0, thanks Bj=C3=B6rn
> - Fix \n\n instead of \n\t mistake
>
>  .../core/jump-labels/arch-support.txt         |  2 +-
>  arch/riscv/Kconfig                            |  2 +
>  arch/riscv/include/asm/jump_label.h           | 59 +++++++++++++++++++
>  arch/riscv/kernel/Makefile                    |  2 +
>  arch/riscv/kernel/jump_label.c                | 44 ++++++++++++++
>  5 files changed, 108 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/jump_label.h
>  create mode 100644 arch/riscv/kernel/jump_label.c
>
> diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/D=
ocumentation/features/core/jump-labels/arch-support.txt
> index 632a1c7aefa2..760243d18ed7 100644
> --- a/Documentation/features/core/jump-labels/arch-support.txt
> +++ b/Documentation/features/core/jump-labels/arch-support.txt
> @@ -23,7 +23,7 @@
>      |    openrisc: | TODO |
>      |      parisc: |  ok  |
>      |     powerpc: |  ok  |
> -    |       riscv: | TODO |
> +    |       riscv: |  ok  |
>      |        s390: |  ok  |
>      |          sh: | TODO |
>      |       sparc: |  ok  |
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index fd639937e251..d2f5c53fdc19 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -46,6 +46,8 @@ config RISCV
>         select GENERIC_TIME_VSYSCALL if MMU && 64BIT
>         select HANDLE_DOMAIN_IRQ
>         select HAVE_ARCH_AUDITSYSCALL
> +       select HAVE_ARCH_JUMP_LABEL
> +       select HAVE_ARCH_JUMP_LABEL_RELATIVE
>         select HAVE_ARCH_KASAN if MMU && 64BIT
>         select HAVE_ARCH_KGDB
>         select HAVE_ARCH_KGDB_QXFER_PKT
> diff --git a/arch/riscv/include/asm/jump_label.h b/arch/riscv/include/asm=
/jump_label.h
> new file mode 100644
> index 000000000000..d5fb342bfccf
> --- /dev/null
> +++ b/arch/riscv/include/asm/jump_label.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2020 Emil Renner Berthing
> + *
> + * Based on arch/arm64/include/asm/jump_label.h
> + */
> +#ifndef __ASM_JUMP_LABEL_H
> +#define __ASM_JUMP_LABEL_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/types.h>
> +
> +#define JUMP_LABEL_NOP_SIZE 4
> +
> +static __always_inline bool arch_static_branch(struct static_key *key,
> +                                              bool branch)
> +{
> +       asm_volatile_goto(
> +               "       .option push                            \n\t"
> +               "       .option norelax                         \n\t"
> +               "       .option norvc                           \n\t"
> +               "1:     nop                                     \n\t"
> +               "       .option pop                             \n\t"
> +               "       .pushsection    __jump_table, \"aw\"    \n\t"
> +               "       .align          " RISCV_LGPTR "         \n\t"
> +               "       .long           1b - ., %l[label] - .   \n\t"
> +               "       " RISCV_PTR "   %0 - .                  \n\t"
> +               "       .popsection                             \n\t"
> +               :  :  "i"(&((char *)key)[branch]) :  : label);
> +
> +       return false;
> +label:
> +       return true;
> +}
> +
> +static __always_inline bool arch_static_branch_jump(struct static_key *k=
ey,
> +                                                   bool branch)
> +{
> +       asm_volatile_goto(
> +               "       .option push                            \n\t"
> +               "       .option norelax                         \n\t"
> +               "       .option norvc                           \n\t"
> +               "1:     jal             zero, %l[label]         \n\t"
> +               "       .option pop                             \n\t"
> +               "       .pushsection    __jump_table, \"aw\"    \n\t"
> +               "       .align          " RISCV_LGPTR "         \n\t"
> +               "       .long           1b - ., %l[label] - .   \n\t"
> +               "       " RISCV_PTR "   %0 - .                  \n\t"
> +               "       .popsection                             \n\t"
> +               :  :  "i"(&((char *)key)[branch]) :  : label);
> +
> +       return false;
> +label:
> +       return true;
> +}
> +
> +#endif  /* __ASSEMBLY__ */
> +#endif /* __ASM_JUMP_LABEL_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index b355cf485671..a5287ab9f7f2 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -53,4 +53,6 @@ endif
>  obj-$(CONFIG_HOTPLUG_CPU)      +=3D cpu-hotplug.o
>  obj-$(CONFIG_KGDB)             +=3D kgdb.o
>
> +obj-$(CONFIG_JUMP_LABEL)       +=3D jump_label.o
> +
>  clean:
> diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_labe=
l.c
> new file mode 100644
> index 000000000000..55b2d742efe1
> --- /dev/null
> +++ b/arch/riscv/kernel/jump_label.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 Emil Renner Berthing
> + *
> + * Based on arch/arm64/kernel/jump_label.c
> + */
> +#include <linux/kernel.h>
> +#include <linux/jump_label.h>
> +#include <asm/patch.h>
> +
> +#define RISCV_INSN_NOP 0x00000013
> +#define RISCV_INSN_JAL 0x0000006f
> +
> +void arch_jump_label_transform(struct jump_entry *entry,
> +                              enum jump_label_type type)
> +{
> +       void *addr =3D (void *)jump_entry_code(entry);
> +       u32 insn;
> +
> +       if (type =3D=3D JUMP_LABEL_JMP) {
> +               u32 offset =3D jump_entry_target(entry) - jump_entry_code=
(entry);

The 20b jump offset of JAL is enough, but to catch future changes that
might potentially break this, I would add a WARN to catch if offset
>20b (or overkill fallback to JALR -- don't do that.).

Somewhat related to that; The UNIX specification for RISC-V requires
support for RVC. Would it make sense to use the C.-instructions C.J
and C.NOP? Really a nit, or more of a question. I'm fine with this 32b
version!

> +
> +               insn =3D RISCV_INSN_JAL |
> +                       ((offset & GENMASK(19, 12)) << (12 - 12)) |
> +                       ((offset & GENMASK(11, 11)) << (20 - 11)) |
> +                       ((offset & GENMASK(10,  1)) << (21 -  1)) |
> +                       ((offset & GENMASK(20, 20)) << (31 - 20));
> +       } else
> +               insn =3D RISCV_INSN_NOP;

Since the if-statement needs {}, the else-clause should have one too.

Feel free to add:
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>


Cheers,
Bj=C3=B6rn
> +
> +       patch_text_nosync(addr, &insn, sizeof(insn));
> +}
> +
> +void arch_jump_label_transform_static(struct jump_entry *entry,
> +                                     enum jump_label_type type)
> +{
> +       /*
> +        * We use the same instructions in the arch_static_branch and
> +        * arch_static_branch_jump inline functions, so there's no
> +        * need to patch them up here.
> +        * The core will call arch_jump_label_transform  when those
> +        * instructions need to be replaced.
> +        */
> +}
> --
> 2.27.0
>
