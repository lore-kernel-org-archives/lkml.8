Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03663C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:24:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2A020663
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 06:24:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRVuh7Pf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgGIGYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 02:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGIGYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 02:24:01 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3129C061A0B;
        Wed,  8 Jul 2020 23:24:00 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w3so607842wmi.4;
        Wed, 08 Jul 2020 23:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tFTqYPC+kPkUAC+tSWU02vOW4V4WIwfRLYoGCz9Pl1c=;
        b=pRVuh7PfWzRAvv85NfqLsAE/Au4eUfXqam4WiDSvEkGnUyNqQUMk0ghioT3N2JWwVH
         w/0ETROU4FCNVbyezhRmKjCxorZ0c5i+8xrWGkvBTb3ChIdnGkSwrJlgpQfCJz76HxOE
         3nBDsOsYQDCifU4LhTAYHK7/Mt4YX1iZtsz+F7d6nwWZZmzxIPUj4JizUzyr3SUgnotQ
         kg4PV6nuCDWNmRtTXFmeYhRl2qUssjzh8DLaI51ygWg3bRhyQt2jFrVHvSbGca25OoQW
         1IIaAkIjM74uBzSCfdKB8kms3SQcOcLkoXMbwWRk63Hy3z4BB2T981xwHaXIEfYtVOeq
         80CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tFTqYPC+kPkUAC+tSWU02vOW4V4WIwfRLYoGCz9Pl1c=;
        b=m6/pRxo6AZ1ITB0tiepgMAOiKjPoVd8WUOz3CZhCCZVGQcnBXRKa4d8PwWmRmATWLC
         DcaCaO2hnFLGHqeHqwlDspmRmYUvwS3VYp776jgPADaJ96Iv9IakFe/7x1kwtzIV8dNd
         vmNpnyspkb9Yj/K1D9q/6wCUKaJ6T84H7j9sYeW80GkrlZBC+1CL/oUf5Yk48IMyOCPt
         9dQGEbmgEALwKAqWryNomHHZ0BYmFVpKI8WEqyPBbSonrs9zE46b7z9XRwRCT3NHiS/y
         ph8S6T6d6RteklFoKzJu255hcfcUxsM2063DADh4AzhG8S2Lxxqc917HAhD5gyIuZRAd
         agQQ==
X-Gm-Message-State: AOAM533x5OXeVOG5a5cJ44x3Zkm6r+tWCnfVxk+IQsr9n89VyUF8tvk8
        sA1HWl9Zs//CYcAA3wYKbb0seaMWbOujQ+ml2tYqyJQZ
X-Google-Smtp-Source: ABdhPJwQzZcAj1lID38/Bfm/YeBFZs3ZDVmZ+G5Cj66fG/+njnE9eU6z5YRvBInHSLQMapml1C28iA+tp3ijRRDYx/g=
X-Received: by 2002:a1c:e355:: with SMTP id a82mr13014188wmh.165.1594275839553;
 Wed, 08 Jul 2020 23:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200708210948.34197-1-kernel@esmil.dk> <20200708210948.34197-2-kernel@esmil.dk>
In-Reply-To: <20200708210948.34197-2-kernel@esmil.dk>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Thu, 9 Jul 2020 08:23:48 +0200
Message-ID: <CAJ+HfNiQgjW+GE4RLy3KufxyQm=6d34SPiUjvYWA3RukVX9URw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: Add jump-label implementation
To:     Emil Renner Berthing <kernel@esmil.dk>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jul 2020 at 23:10, Emil Renner Berthing <kernel@esmil.dk> wrote:
>
> Add jump-label implementation based on the ARM64 version
> and add CONFIG_JUMP_LABEL=3Dy to the defconfigs.
>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn.topel@gmail.com>

> ---
>
> Tested on the HiFive Unleashed board.
>
> Changes since v1:
> - WARN and give up gracefully if the jump offset cannot be
>   represented in a JAL instruction.
> - Add missing braces.
> - Add CONFIG_JUMP_LABEL=3Dy to defconfigs.
>
> All suggested by Bj=C3=B6rn T=C3=B6pel.
>
> Changes since RFC:
> - Use RISCV_PTR and RISCV_LGPTR macros to match struct jump_table
>   also in 32bit kernels.
> - Remove unneeded branch ? 1 : 0, thanks Bj=C3=B6rn
> - Fix \n\n instead of \n\t mistake
>
>  .../core/jump-labels/arch-support.txt         |  2 +-
>  arch/riscv/Kconfig                            |  2 +
>  arch/riscv/configs/defconfig                  |  1 +
>  arch/riscv/configs/nommu_k210_defconfig       |  1 +
>  arch/riscv/configs/nommu_virt_defconfig       |  1 +
>  arch/riscv/configs/rv32_defconfig             |  1 +
>  arch/riscv/include/asm/jump_label.h           | 59 +++++++++++++++++++
>  arch/riscv/kernel/Makefile                    |  2 +
>  arch/riscv/kernel/jump_label.c                | 49 +++++++++++++++
>  9 files changed, 117 insertions(+), 1 deletion(-)
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
> diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
> index 4da4886246a4..d58c93efb603 100644
> --- a/arch/riscv/configs/defconfig
> +++ b/arch/riscv/configs/defconfig
> @@ -17,6 +17,7 @@ CONFIG_BPF_SYSCALL=3Dy
>  CONFIG_SOC_SIFIVE=3Dy
>  CONFIG_SOC_VIRT=3Dy
>  CONFIG_SMP=3Dy
> +CONFIG_JUMP_LABEL=3Dy
>  CONFIG_MODULES=3Dy
>  CONFIG_MODULE_UNLOAD=3Dy
>  CONFIG_NET=3Dy
> diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs=
/nommu_k210_defconfig
> index b48138e329ea..cd1df62b13c7 100644
> --- a/arch/riscv/configs/nommu_k210_defconfig
> +++ b/arch/riscv/configs/nommu_k210_defconfig
> @@ -33,6 +33,7 @@ CONFIG_SMP=3Dy
>  CONFIG_NR_CPUS=3D2
>  CONFIG_CMDLINE=3D"earlycon console=3DttySIF0"
>  CONFIG_CMDLINE_FORCE=3Dy
> +CONFIG_JUMP_LABEL=3Dy
>  # CONFIG_BLOCK is not set
>  CONFIG_BINFMT_FLAT=3Dy
>  # CONFIG_COREDUMP is not set
> diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs=
/nommu_virt_defconfig
> index cf74e179bf90..f27596e9663e 100644
> --- a/arch/riscv/configs/nommu_virt_defconfig
> +++ b/arch/riscv/configs/nommu_virt_defconfig
> @@ -30,6 +30,7 @@ CONFIG_MAXPHYSMEM_2GB=3Dy
>  CONFIG_SMP=3Dy
>  CONFIG_CMDLINE=3D"root=3D/dev/vda rw earlycon=3Duart8250,mmio,0x10000000=
,115200n8 console=3DttyS0"
>  CONFIG_CMDLINE_FORCE=3Dy
> +CONFIG_JUMP_LABEL=3Dy
>  # CONFIG_BLK_DEV_BSG is not set
>  CONFIG_PARTITION_ADVANCED=3Dy
>  # CONFIG_MSDOS_PARTITION is not set
> diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_=
defconfig
> index 05bbf5240569..3a55f0e00d6c 100644
> --- a/arch/riscv/configs/rv32_defconfig
> +++ b/arch/riscv/configs/rv32_defconfig
> @@ -17,6 +17,7 @@ CONFIG_BPF_SYSCALL=3Dy
>  CONFIG_SOC_VIRT=3Dy
>  CONFIG_ARCH_RV32I=3Dy
>  CONFIG_SMP=3Dy
> +CONFIG_JUMP_LABEL=3Dy
>  CONFIG_MODULES=3Dy
>  CONFIG_MODULE_UNLOAD=3Dy
>  CONFIG_NET=3Dy
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
> index 000000000000..1bab1abc1aa5
> --- /dev/null
> +++ b/arch/riscv/kernel/jump_label.c
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2020 Emil Renner Berthing
> + *
> + * Based on arch/arm64/kernel/jump_label.c
> + */
> +#include <linux/kernel.h>
> +#include <linux/jump_label.h>
> +#include <asm/bug.h>
> +#include <asm/patch.h>
> +
> +#define RISCV_INSN_NOP 0x00000013U
> +#define RISCV_INSN_JAL 0x0000006fU
> +
> +void arch_jump_label_transform(struct jump_entry *entry,
> +                              enum jump_label_type type)
> +{
> +       void *addr =3D (void *)jump_entry_code(entry);
> +       u32 insn;
> +
> +       if (type =3D=3D JUMP_LABEL_JMP) {
> +               long offset =3D jump_entry_target(entry) - jump_entry_cod=
e(entry);
> +
> +               if (WARN_ON(offset & 1 || offset < -524288 || offset >=3D=
 524288))
> +                       return;
> +
> +               insn =3D RISCV_INSN_JAL |
> +                       (((u32)offset & GENMASK(19, 12)) << (12 - 12)) |
> +                       (((u32)offset & GENMASK(11, 11)) << (20 - 11)) |
> +                       (((u32)offset & GENMASK(10,  1)) << (21 -  1)) |
> +                       (((u32)offset & GENMASK(20, 20)) << (31 - 20));
> +       } else {
> +               insn =3D RISCV_INSN_NOP;
> +       }
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
