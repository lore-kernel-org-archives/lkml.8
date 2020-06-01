Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEFFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DDD2206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591002912;
	bh=t4iJuc7lKTqRKb4YRQcfc6Zcc+0aiSP0tDeFpyVwAk8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=bEGQ3aUKA7pKMz7ySpAgzpl9Xmklel2kPyqYhjBCiV/Px51fZB+YNaELht1PM4EBP
	 s9xmPjBcJSBAjcgqNWhx5tcmaYeLrp7WkGuSl4OqQC+a2KFSTRC3J9/IhfMTqDPb5B
	 xO+248ZPVb4d3STqnqFW3uGcHteZX5MOK8YaZ7yI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726101AbgFAJPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:60592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgFAJPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:15:11 -0400
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8A76207BC
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591002910;
        bh=t4iJuc7lKTqRKb4YRQcfc6Zcc+0aiSP0tDeFpyVwAk8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HKFgbB9eKN6FHWyXv4WYSJgzDYUynL1c6V7nW+EZ4sm7vWmFlA+pmtrg07jeOPNE2
         xnJxAxkIMMN8IogoTTUCfPoMu3tFLxhhsmfSKPK0wNaF53wAdruwNYEA12Hnj6427C
         T+S1NPqiz5WsDeMGQz8sDWAQacg3EuqFC5KWd4n0=
Received: by mail-lf1-f45.google.com with SMTP id x22so3506786lfd.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 02:15:09 -0700 (PDT)
X-Gm-Message-State: AOAM533lILca3DWEoFplq5i0WDKscF8lrsJJUs4x3lnY4TSuMKS5uUEZ
        aYTxPCfEqacd1cd8Mczuj1iu2MI6yVoGYdbEPzQ=
X-Google-Smtp-Source: ABdhPJwyjnB2fm8dJBftZwzvtw+TL8eONFwas/ivCwyNJ++u9Y2LwhmZJJfTORveeAUOg1prXhytHPWy6qX6xQnYRfs=
X-Received: by 2002:a05:6512:3111:: with SMTP id n17mr10661419lfb.137.1591002907869;
 Mon, 01 Jun 2020 02:15:07 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590474856.git.greentime.hu@sifive.com> <fa27814191feb2498b396758447ac2b745fd1121.1590474856.git.greentime.hu@sifive.com>
In-Reply-To: <fa27814191feb2498b396758447ac2b745fd1121.1590474856.git.greentime.hu@sifive.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 1 Jun 2020 17:14:56 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT-2SKJ08oDCPcBqA9gYL_WZZHdWGBFuWS9NkOuwFc3gw@mail.gmail.com>
Message-ID: <CAJF2gTT-2SKJ08oDCPcBqA9gYL_WZZHdWGBFuWS9NkOuwFc3gw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 11/13] riscv: Add ptrace vector support
To:     Greentime Hu <greentime.hu@sifive.com>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since it has been redesigned with new version spec, please change the
first-author :)

And add me as Co-developed.

On Tue, May 26, 2020 at 3:03 PM Greentime Hu <greentime.hu@sifive.com> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> This patch adds ptrace support for riscv vector. The vector registers will
> be saved in datap pointer of __riscv_v_state. This pointer will be set
> right after the __riscv_v_state data structure then it will be put in ubuf
> for ptrace system call to get or set. It will check if the datap got from
> ubuf is set to the correct address or not when the ptrace system call is
> trying to set the vector registers.
>
> [greentime.hu@sifive.com: add support for dynamic vlen, fix vtype not
> saved bug]
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/include/uapi/asm/elf.h |   1 +
>  arch/riscv/kernel/ptrace.c        | 114 ++++++++++++++++++++++++++++++
>  include/uapi/linux/elf.h          |   1 +
>  3 files changed, 116 insertions(+)
>
> diff --git a/arch/riscv/include/uapi/asm/elf.h b/arch/riscv/include/uapi/asm/elf.h
> index d696d6610231..099434d075a7 100644
> --- a/arch/riscv/include/uapi/asm/elf.h
> +++ b/arch/riscv/include/uapi/asm/elf.h
> @@ -23,6 +23,7 @@ typedef struct user_regs_struct elf_gregset_t;
>  typedef __u64 elf_fpreg_t;
>  typedef union __riscv_fp_state elf_fpregset_t;
>  #define ELF_NFPREG (sizeof(struct __riscv_d_ext_state) / sizeof(elf_fpreg_t))
> +#define ELF_NVREG  (sizeof(struct __riscv_v_state) / sizeof(elf_greg_t))
>
>  #if __riscv_xlen == 64
>  #define ELF_RISCV_R_SYM(r_info)                ELF64_R_SYM(r_info)
> diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
> index 444dc7b0fd78..9b9bd1c02362 100644
> --- a/arch/riscv/kernel/ptrace.c
> +++ b/arch/riscv/kernel/ptrace.c
> @@ -10,6 +10,7 @@
>  #include <asm/ptrace.h>
>  #include <asm/syscall.h>
>  #include <asm/thread_info.h>
> +#include <asm/switch_to.h>
>  #include <linux/audit.h>
>  #include <linux/ptrace.h>
>  #include <linux/elf.h>
> @@ -26,6 +27,9 @@ enum riscv_regset {
>  #ifdef CONFIG_FPU
>         REGSET_F,
>  #endif
> +#ifdef CONFIG_VECTOR
> +       REGSET_V,
> +#endif
>  };
>
>  static int riscv_gpr_get(struct task_struct *target,
> @@ -92,6 +96,107 @@ static int riscv_fpr_set(struct task_struct *target,
>  }
>  #endif
>
> +#ifdef CONFIG_VECTOR
> +static int riscv_vr_get(struct task_struct *target,
> +                        const struct user_regset *regset,
> +                        unsigned int pos, unsigned int count,
> +                        void *kbuf, void __user *ubuf)
> +{
> +       int ret, size;
> +       struct __riscv_v_state *vstate = &target->thread.vstate;
> +       /* Set the datap right after the address of vstate. */
> +       void *datap = ubuf + sizeof(struct __riscv_v_state);
> +       u32 magic = RVV_MAGIC;
> +
> +       /* Copy the magic number. */
> +       ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &magic, 0,
> +                                 sizeof(u32));
> +       if (unlikely(ret))
> +               return ret;
> +
> +       /* Copy rest of vstate except datap. */
> +       ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, vstate, 0,
> +                                 RISCV_V_STATE_DATAP);
> +       if (unlikely(ret))
> +               return ret;
> +
> +       /* Copy the pointer datap itself. */
> +       pos = 0;
> +       ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf, &datap, 0,
> +                                 sizeof(vstate->datap));
> +       if (unlikely(ret))
> +               return ret;
> +
> +#if __riscv_xlen == 32
> +       /* Skip copy _padding. */
> +       size = sizeof(vstate->__padding);
> +       count -= size;
> +       ubuf += size;
> +#endif
> +
> +       /* Copy all the vector registers. */
> +       pos = 0;
> +       ret = user_regset_copyout(&pos, &count, &kbuf, &ubuf,
> +                                 vstate->datap, 0, vstate->size);
> +       return ret;
> +}
> +
> +static int riscv_vr_set(struct task_struct *target,
> +                        const struct user_regset *regset,
> +                        unsigned int pos, unsigned int count,
> +                        const void *kbuf, const void __user *ubuf)
> +{
> +       int ret, size;
> +       struct __riscv_v_state *vstate = &target->thread.vstate;
> +       const void *datap = ubuf + sizeof(struct __riscv_v_state);
> +       const void *datap_addr = ubuf + RISCV_V_STATE_DATAP;
> +       long val_datap;
> +
> +       /* Skip copy magic because kernel doesn't need to use it. */
> +       size = sizeof(vstate->magic);
> +       pos += size;
> +       count -= size;
> +       ubuf += size;
> +
> +       /* Copy rest of the vstate except datap and __padding. */
> +       ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, vstate, 0,
> +                                RISCV_V_STATE_DATAP);
> +       if (unlikely(ret))
> +               return ret;
> +
> +       /* Check if the datap is correct address of ubuf. */
> +       __get_user(val_datap, (long *)datap_addr);
> +       if (val_datap != (long)datap)
> +               return -EFAULT;
> +
> +       /* Skip copy datap. */
> +       size = sizeof(vstate->datap);
> +       count -= size;
> +       ubuf += size;
> +
> +#if __riscv_xlen == 32
> +       /* Skip copy _padding. */
> +       size = sizeof(vstate->__padding);
> +       count -= size;
> +       ubuf += size;
> +#endif
> +
> +       /* Copy all the vector registers. */
> +       pos = 0;
> +       ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, vstate->datap,
> +                                0, vstate->size);
> +       return ret;
> +}
> +static unsigned int riscv_vr_get_size(struct task_struct *target,
> +                                     const struct user_regset *regset)
> +{
> +       if (!has_vector)
> +               return 0;
> +
> +       return sizeof(struct __riscv_v_state) + riscv_vsize;
> +}
> +#endif
> +
>  static const struct user_regset riscv_user_regset[] = {
>         [REGSET_X] = {
>                 .core_note_type = NT_PRSTATUS,
> @@ -111,6 +216,15 @@ static const struct user_regset riscv_user_regset[] = {
>                 .set = &riscv_fpr_set,
>         },
>  #endif
> +#ifdef CONFIG_VECTOR
> +       [REGSET_V] = {
> +               .core_note_type = NT_RISCV_VECTOR,
> +               .align = 16,
> +               .get = riscv_vr_get,
> +               .set = riscv_vr_set,
> +               .get_size = riscv_vr_get_size,
> +       },
> +#endif
>  };
>
>  static const struct user_regset_view riscv_user_native_view = {
> diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
> index 34c02e4290fe..e428f9e8710a 100644
> --- a/include/uapi/linux/elf.h
> +++ b/include/uapi/linux/elf.h
> @@ -428,6 +428,7 @@ typedef struct elf64_shdr {
>  #define NT_MIPS_DSP    0x800           /* MIPS DSP ASE registers */
>  #define NT_MIPS_FP_MODE        0x801           /* MIPS floating-point mode */
>  #define NT_MIPS_MSA    0x802           /* MIPS SIMD registers */
> +#define NT_RISCV_VECTOR        0x900           /* RISC-V vector registers */
>
>  /* Note header in a PT_NOTE section */
>  typedef struct elf32_note {
> --
> 2.26.2
>
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
