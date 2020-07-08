Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D338EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A0920739
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HXOqb55a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgGHHmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHHma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:42:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F9DC08C5DC;
        Wed,  8 Jul 2020 00:42:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f2so19794693wrp.7;
        Wed, 08 Jul 2020 00:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=I+esrALfgueiBYwiCYi1Oxz8p+spIbm0u/P9Ty9TSHg=;
        b=HXOqb55a3dNxtd/7DKmjaEZ70PEUE6QCevEgtQ/pUMNV+xYSgX+DbjW3+uvlvNJpaE
         ZCSMWsljfe3QLN5eal0IuZLlDWxgx3fn1W6RO7mS2XrlvLxSVfBlJTTl5TCrekxZrghw
         lh8xL7SVP/Ak9ic4nn3KJ/wL8hb6P/x/NJTSyyLpLDCQhQYaz4WacygwREUrlCiSnzK2
         DamcYExw3yTwurZrf0IRF2zYsLkvlPUjKYlzcNPCZ764R0USB4hzjPA3zimA5Ao9oYZl
         ODBp+urqbOLVPxAdDdxRVasZzkCh3D6OOeE+Hi1RYWUnXs3pwmPyThCWxuaAKQ9bPS/H
         bHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=I+esrALfgueiBYwiCYi1Oxz8p+spIbm0u/P9Ty9TSHg=;
        b=jykESJX5Azp+XM08pvvyH5u7BB+SpemK+p3oaJondTFRKl1StjhzZgwUNQ8k2UOZxc
         43BPDSlr+JrpQWvXtqFJ036hspDjZ8FqKiWdiSBeHJddKkQPnvDU9sfs2e2ZyZteu26G
         f5ivkZ7ELmBDOt+VSAqGrhIol4tIh8FIyOM4yOGVYNKvThfRuHXiXAAhsGpLdilKqG9r
         snULol/V1UWDTL698kGpyZA3SeKGiiHMoRa8RT+d0GqQk25J3sWXmwoSuOfhpqsSx3Yf
         w2vFVPvK6jD3LyZfdj9JI4rEU+HqKK+bJM8t+ErdOGHPA+fbdOo45j0NK7y8E9LPLiMj
         vWIw==
X-Gm-Message-State: AOAM533ir5pLbBkRUmPtwWHOrwoTV8W23OJq81kTubndTB1OH2o137ij
        LIX5xDiR/CdBLvncsjAopHICQAZD0jHh/Pp2EdvGH+30NSk=
X-Google-Smtp-Source: ABdhPJxyamJipuVLqpSanYsj8UbYJS6ke6ncCj24fO3TSI4gqzURGfp08jhHRN5va9meP1FcpozNEhAisYtCehaAtaQ=
X-Received: by 2002:a5d:504b:: with SMTP id h11mr55934073wrt.160.1594194148739;
 Wed, 08 Jul 2020 00:42:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200707150748.14651-1-kernel@esmil.dk>
In-Reply-To: <20200707150748.14651-1-kernel@esmil.dk>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn.topel@gmail.com>
Date:   Wed, 8 Jul 2020 09:42:17 +0200
Message-ID: <CAJ+HfNhYPQByOPu+07v5vstADZPtqakuMeK79_1etJjbV1vBLw@mail.gmail.com>
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

I took your patch for a spin on qemu. The boot selftest
(CONFIG_STATIC_KEYS_SELFTEST=3Dy) passes, but the module test
(CONFIG_TEST_STATIC_KEYS=3Dm) does not.

When I run the in "test tools/testing/selftests/static_keys" (this
simply loads the test_static_key_base.ko and test_static_keys.ko
modules) I get:

[  134.090464] test_static_keys: Unknown relocation type 36

36 is the relocation type R_RISCV_ADD64, which is not handled in
arch/riscv/kernel/module.c.

If you dump the relocation entries for test_static_keys.ko
(riscv64-linux-gnu-objdump -r test_static_keys.ko), you'll see that:

RELOCATION RECORDS FOR [__jump_table]:
OFFSET           TYPE              VALUE
0000000000000000 R_RISCV_ADD32     .L1^B1
0000000000000000 R_RISCV_SUB32     .L0
0000000000000004 R_RISCV_ADD32     .L3
0000000000000004 R_RISCV_SUB32     .L0
0000000000000008 R_RISCV_ADD64     old_true_key+0x0000000000000001
0000000000000008 R_RISCV_SUB64     .L0
...

It would be great if you could add a patch for that as well (separate,
same series). R_RISCV_ADD64 *and* R_RISCV_SUB64 are currently
unhandled by module.c.


Cheers,
Bj=C3=B6rn

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
