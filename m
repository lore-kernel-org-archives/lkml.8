Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E80AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D31D620760
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVEtrkM2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730237AbgGHHTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729972AbgGHHTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:19:38 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7C8C061755;
        Wed,  8 Jul 2020 00:19:38 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k6so47732730wrn.3;
        Wed, 08 Jul 2020 00:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+bENu48E3Xibja+rVmQV5HpKpq/BuWjmLHS6VhU2gVA=;
        b=DVEtrkM2Z/thFTtE+Z2m5dn42jOXTWGBE6+5jKVGC48OQJROm+i7uz5gg/efEAcq8d
         Cubh9LWnbap/1BndP7PUlVdMQ0UtNy/t256u9P9oPz9Vg2wnv7jnWVFkhVVe6Thu1oVu
         zbq1tEfNtqZdsdtTS/bZEZhMQgIjkca8smYcFkSHPbMep9vKYC2f3iKqzNxLu/6pKcNk
         kjI5IuRlO02tEshvAONg/T3F1PVaqqldDLdGhNmW2BGu60/8Q8rMWvZFqAOtZSVEzg/8
         EAr+/KrGY9Fiq9zNeoCPNyi7jwBqT91csMk1DSqdmyakbjmmRL+HzYYVphYOLKe93w9w
         am4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+bENu48E3Xibja+rVmQV5HpKpq/BuWjmLHS6VhU2gVA=;
        b=tWMZjYVamtkCWrPoKwoDUbXPHz08e8GI2liNbEN7mzvMgYwjxo82w3bii+9ZMRi04C
         8ieAvrpIAuu8Lr1aZEZ+7ygRA9P0kNW8W0XQk4+U1EDH2cdGOnzZ2ldj+12HmpQpc6a+
         RGQ/PZ0Z6iH+MjtV2hnVlcHnNrUcuqrKgwq19gzp7HlBI+n54mb65VpUMDEEz50wk444
         jRc44sfNvXuNgS3WF5H2Jdj0IGytvaCkatIpJ3euZBqpLigGLGJMkRzjbaB2jK28q5Cr
         AsBdtI/YeIzIaSSMyNpQc5EairM4XYF2bcTD6xm80TmQ3ZQriDRDKDe9A9U8GH6oGNo/
         3DOg==
X-Gm-Message-State: AOAM532lAPa19StfO9+C3fj/oAA5hIcVe2bT7wQY9qECiJ1Pm5s9hZul
        IfjSxdRBVcQZLTO6EV2D25jxeYDL5Vls6vWejiE=
X-Google-Smtp-Source: ABdhPJwCPsUkFL47H/1L0sSR5oZErfxC1rNDhEXbZMqQsUaadRg2SYJq9+Gc3rE+7onCVJm9hUhDhzaQc7mZQ+2s9J8=
X-Received: by 2002:adf:82b8:: with SMTP id 53mr61795092wrc.172.1594192777045;
 Wed, 08 Jul 2020 00:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200707150748.14651-1-kernel@esmil.dk>
In-Reply-To: <20200707150748.14651-1-kernel@esmil.dk>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Wed, 8 Jul 2020 09:19:25 +0200
Message-ID: <CAJ+HfNituS90bACFtMd=G95F0-7BibL9VCGuPQYkxesun_6HfA@mail.gmail.com>
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

Missed one thing in the last reply; Please update defconfig with
CONFIG_JUMP_LABEL=3Dy.


Bj=C3=B6rn

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
> +
> +               insn =3D RISCV_INSN_JAL |
> +                       ((offset & GENMASK(19, 12)) << (12 - 12)) |
> +                       ((offset & GENMASK(11, 11)) << (20 - 11)) |
> +                       ((offset & GENMASK(10,  1)) << (21 -  1)) |
> +                       ((offset & GENMASK(20, 20)) << (31 - 20));
> +       } else
> +               insn =3D RISCV_INSN_NOP;
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
