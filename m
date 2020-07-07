Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F0FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B7A9206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="QLRHVIIl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgGGIV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgGGIVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:21:55 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D21C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 01:21:55 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id l63so32807282oih.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 01:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QSZCfrc4mYP+zmBvPkDkBcNJCimqw2FCNTcH47+PlJk=;
        b=QLRHVIIlgGmTsTutye9yBOD4z2XcVDcAe+ds11Ku8Zj2A24scEWGX8hrtSLhXTG854
         7aXifSJyCBhbK3XV4K8C6+8lfkNDIS0v1wROPj+qb+1JEnDhURgUXYLm/KpC8/Crjlht
         6Wbf8gvHcAGxvNWgc3T+TVPLM7dgnBXXg/ii/xG3uTkFhipxJL4+FX208SkChyBr56/g
         DAr3bQvlz1M9ubu8uL35qq+ZYDYHVYO6kQvA/fEt/oMebuvS9RC/AQoHy07HmRfS1wjw
         XRC0sbJAhJbQn/Wiml0Jim0CsF8iw7fRemNVmALs7dCJy5Ns+Eoo5QFvLUC+wLVB+9G6
         lG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QSZCfrc4mYP+zmBvPkDkBcNJCimqw2FCNTcH47+PlJk=;
        b=IIhHYanfiscU2WstuLJ19G/9G9FpgcXFnuxh8DvjKe5zo+Iroa8MCSQAx/Wc1ICrQ5
         SxwBLYgg0vWMtciQrxuSc1T945/ElhtqXwfWOyRneHWKnpBPEjEZYjMW++JPlNAwvGNm
         +XNpIQ00vwIdaS3QwfmWnSt7E/icu2dC7OjG4pKvlpeJ21fWSg9pwon5Tt57NPBdO/QO
         IMvLJ7LGxAljnJaBEBSgncqz+lAVsPi5IP04JXwQxeN63qeGyDogcCeN9YcmcNljcMod
         XsibzRMF29dnOIXJs57PhWbDm8w452aoWOMwFSrcJNlwvB7ztN5pd6JpOzZRlJAsKUuL
         4Yzg==
X-Gm-Message-State: AOAM531v7wK0x+andJAa3oe6IInnEzVXIxuVA5tKwNtXBDB83gPWwlm1
        tRXSeYpZw5wZPfWtSPpsha3mnPFiEgnmoySdKyhtlA==
X-Google-Smtp-Source: ABdhPJzo6Ohp/iAsTynvaj2p1Nkybie7uw0cEI06MO1e7mWu/MMV3DjrDUY40HExYiCDPL/BdDq52wkD9adWEH0vD4w=
X-Received: by 2002:aca:1915:: with SMTP id l21mr2405742oii.91.1594110114852;
 Tue, 07 Jul 2020 01:21:54 -0700 (PDT)
MIME-Version: 1.0
References: <1593833659-26224-1-git-send-email-guoren@kernel.org> <1593833659-26224-3-git-send-email-guoren@kernel.org>
In-Reply-To: <1593833659-26224-3-git-send-email-guoren@kernel.org>
From:   Zong Li <zong.li@sifive.com>
Date:   Tue, 7 Jul 2020 16:21:44 +0800
Message-ID: <CANXhq0p2iRsJ1QmtDSV4hE5FJ34j3R5Kt1JZn2y74t8Bmtnc5A@mail.gmail.com>
Subject: Re: [PATCH V1 2/5] RISC-V: Implement ptrace regs and stack API
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        bjorn.topel@gmail.com, Atish Patra <atish.patra@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 4, 2020 at 11:34 AM <guoren@kernel.org> wrote:
>
> From: Patrick St=C3=A4hlin <me@packi.ch>
>
> Needed for kprobes support. Copied and adapted from arm64 code.
>
> Guo Ren fixup pt_regs type for linux-5.8-rc1.
>
> Signed-off-by: Patrick St=C3=A4hlin <me@packi.ch>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/ptrace.h | 29 ++++++++++++
>  arch/riscv/kernel/ptrace.c      | 99 +++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 129 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 128192e..58d6f66 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -76,6 +76,7 @@ config RISCV
>         select SPARSE_IRQ
>         select SYSCTL_EXCEPTION_TRACE
>         select THREAD_INFO_IN_TASK
> +       select HAVE_REGS_AND_STACK_ACCESS_API
>
>  config ARCH_MMAP_RND_BITS_MIN
>         default 18 if 64BIT
> diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptr=
ace.h
> index ee49f80..23372bb 100644
> --- a/arch/riscv/include/asm/ptrace.h
> +++ b/arch/riscv/include/asm/ptrace.h
> @@ -8,6 +8,7 @@
>
>  #include <uapi/asm/ptrace.h>
>  #include <asm/csr.h>
> +#include <linux/compiler.h>
>
>  #ifndef __ASSEMBLY__
>
> @@ -60,6 +61,7 @@ struct pt_regs {
>
>  #define user_mode(regs) (((regs)->status & SR_PP) =3D=3D 0)
>
> +#define MAX_REG_OFFSET offsetof(struct pt_regs, orig_a0)
>
>  /* Helpers for working with the instruction pointer */
>  static inline unsigned long instruction_pointer(struct pt_regs *regs)
> @@ -85,6 +87,12 @@ static inline void user_stack_pointer_set(struct pt_re=
gs *regs,
>         regs->sp =3D  val;
>  }
>
> +/* Valid only for Kernel mode traps. */
> +static inline unsigned long kernel_stack_pointer(struct pt_regs *regs)
> +{
> +       return regs->sp;
> +}
> +
>  /* Helpers for working with the frame pointer */
>  static inline unsigned long frame_pointer(struct pt_regs *regs)
>  {
> @@ -101,6 +109,27 @@ static inline unsigned long regs_return_value(struct=
 pt_regs *regs)
>         return regs->a0;
>  }
>
> +extern int regs_query_register_offset(const char *name);
> +extern unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs,
> +                                              unsigned int n);
> +
> +/**
> + * regs_get_register() - get register value from its offset
> + * @regs:      pt_regs from which register value is gotten
> + * @offset:    offset of the register.
> + *
> + * regs_get_register returns the value of a register whose offset from @=
regs.
> + * The @offset is the offset of the register in struct pt_regs.
> + * If @offset is bigger than MAX_REG_OFFSET, this returns 0.
> + */
> +static inline unsigned long regs_get_register(struct pt_regs *regs,
> +                                             unsigned int offset)
> +{
> +       if (unlikely(offset > MAX_REG_OFFSET))
> +               return 0;
> +
> +       return *(unsigned long *)((unsigned long)regs + offset);
> +}
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_RISCV_PTRACE_H */
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index 444dc7b..a11c692 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -125,6 +125,105 @@ const struct user_regset_view *task_user_regset_vie=
w(struct task_struct *task)
>         return &riscv_user_native_view;
>  }
>
> +struct pt_regs_offset {
> +       const char *name;
> +       int offset;
> +};
> +
> +#define REG_OFFSET_NAME(r) {.name =3D #r, .offset =3D offsetof(struct pt=
_regs, r)}
> +#define REG_OFFSET_END {.name =3D NULL, .offset =3D 0}
> +
> +static const struct pt_regs_offset regoffset_table[] =3D {
> +       REG_OFFSET_NAME(epc),
> +       REG_OFFSET_NAME(ra),
> +       REG_OFFSET_NAME(sp),
> +       REG_OFFSET_NAME(gp),
> +       REG_OFFSET_NAME(tp),
> +       REG_OFFSET_NAME(t0),
> +       REG_OFFSET_NAME(t1),
> +       REG_OFFSET_NAME(t2),
> +       REG_OFFSET_NAME(s0),
> +       REG_OFFSET_NAME(s1),
> +       REG_OFFSET_NAME(a0),
> +       REG_OFFSET_NAME(a1),
> +       REG_OFFSET_NAME(a2),
> +       REG_OFFSET_NAME(a3),
> +       REG_OFFSET_NAME(a4),
> +       REG_OFFSET_NAME(a5),
> +       REG_OFFSET_NAME(a6),
> +       REG_OFFSET_NAME(a7),
> +       REG_OFFSET_NAME(s2),
> +       REG_OFFSET_NAME(s3),
> +       REG_OFFSET_NAME(s4),
> +       REG_OFFSET_NAME(s5),
> +       REG_OFFSET_NAME(s6),
> +       REG_OFFSET_NAME(s7),
> +       REG_OFFSET_NAME(s8),
> +       REG_OFFSET_NAME(s9),
> +       REG_OFFSET_NAME(s10),
> +       REG_OFFSET_NAME(s11),
> +       REG_OFFSET_NAME(t3),
> +       REG_OFFSET_NAME(t4),
> +       REG_OFFSET_NAME(t5),
> +       REG_OFFSET_NAME(t6),
> +       REG_OFFSET_NAME(status),
> +       REG_OFFSET_NAME(badaddr),
> +       REG_OFFSET_NAME(cause),
> +       REG_OFFSET_NAME(orig_a0),
> +       REG_OFFSET_END,
> +};
> +
> +/**
> + * regs_query_register_offset() - query register offset from its name
> + * @name:      the name of a register
> + *
> + * regs_query_register_offset() returns the offset of a register in stru=
ct
> + * pt_regs from its name. If the name is invalid, this returns -EINVAL;
> + */
> +int regs_query_register_offset(const char *name)
> +{
> +       const struct pt_regs_offset *roff;
> +
> +       for (roff =3D regoffset_table; roff->name !=3D NULL; roff++)
> +               if (!strcmp(roff->name, name))
> +                       return roff->offset;
> +       return -EINVAL;
> +}
> +
> +/**
> + * regs_within_kernel_stack() - check the address in the stack
> + * @regs:      pt_regs which contains kernel stack pointer.
> + * @addr:      address which is checked.
> + *
> + * regs_within_kernel_stack() checks @addr is within the kernel stack pa=
ge(s).
> + * If @addr is within the kernel stack, it returns true. If not, returns=
 false.
> + */
> +static bool regs_within_kernel_stack(struct pt_regs *regs, unsigned long=
 addr)
> +{
> +       return (addr & ~(THREAD_SIZE - 1))  =3D=3D
> +               (kernel_stack_pointer(regs) & ~(THREAD_SIZE - 1));
> +}
> +
> +/**
> + * regs_get_kernel_stack_nth() - get Nth entry of the stack
> + * @regs:      pt_regs which contains kernel stack pointer.
> + * @n:         stack entry number.
> + *
> + * regs_get_kernel_stack_nth() returns @n th entry of the kernel stack w=
hich
> + * is specified by @regs. If the @n th entry is NOT in the kernel stack,
> + * this returns 0.
> + */
> +unsigned long regs_get_kernel_stack_nth(struct pt_regs *regs, unsigned i=
nt n)
> +{
> +       unsigned long *addr =3D (unsigned long *)kernel_stack_pointer(reg=
s);
> +
> +       addr +=3D n;
> +       if (regs_within_kernel_stack(regs, (unsigned long)addr))
> +               return *addr;
> +       else
> +               return 0;
> +}
> +
>  void ptrace_disable(struct task_struct *child)
>  {
>         clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
> --
> 2.7.4
>

Looks good to me.

Reviewed-by: Zong Li <zong.li@sifive.com>
