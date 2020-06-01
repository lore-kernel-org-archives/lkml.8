Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21132C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA777206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591002803;
	bh=w1slmTZZ2876sYev0ELMlVITFxKpVczZEcUyQH8mdqE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yV2KUH60ewDjruic2JPEtbSozjdZ2dtSjC6ciXHh4EG8t84hJWOvOJ/RWSRYwv8XL
	 xn5VsqrasNObF0pTc/1syrEg30lTEOutx1dlqs498Hj1++lNVz/Ufb2zBZDsSuCRxG
	 vWpDCljwzFjUpIoFqxqR35fnGYCVG6Jj/OBa2hqM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgFAJNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:13:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgFAJNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:13:21 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DA6520734
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591002800;
        bh=w1slmTZZ2876sYev0ELMlVITFxKpVczZEcUyQH8mdqE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cDRie4a/jnxwrnbpGFeojoCrPqDBNUKUWE5vvo1CR+zCMWbeMQ02VsP3Q9pf7q++h
         AfWfVz8haNVuVZJYriWSarmdn2FMjprIHjniWV4OBHO+S0FmCdBVvaBpbl1xBjRYO0
         POg6pqPB0yeZWCUXg88uKqE5Mju5PU3fzdS1MhcU=
Received: by mail-lf1-f42.google.com with SMTP id c12so3483202lfc.10
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 02:13:20 -0700 (PDT)
X-Gm-Message-State: AOAM5309eB3Usg1CHPzYj5OppG0KBshJTF6Xv8UNssLhSIcaEoWiv/wC
        Oi/tA9iJ+8HfDICabd2uljX4wzizkFjct9ytL9o=
X-Google-Smtp-Source: ABdhPJz7eGyh5VsWr8t8LIfLMDwvO7lk89fQWhe5jtwj6TXEgrbTzrgWNF7maXhOQFWLeH+5CjECc64TPimaNfjr7vw=
X-Received: by 2002:a19:7fd6:: with SMTP id a205mr10631870lfd.70.1591002798508;
 Mon, 01 Jun 2020 02:13:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590474856.git.greentime.hu@sifive.com> <8dd3e441842d2b0fb63da82ecc04b08f99930e6a.1590474856.git.greentime.hu@sifive.com>
In-Reply-To: <8dd3e441842d2b0fb63da82ecc04b08f99930e6a.1590474856.git.greentime.hu@sifive.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 1 Jun 2020 17:13:07 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSaiymJOGGYqseQMzsnFb_zKeEKPF-Gvgyy2Et_KDbYCA@mail.gmail.com>
Message-ID: <CAJF2gTSaiymJOGGYqseQMzsnFb_zKeEKPF-Gvgyy2Et_KDbYCA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 12/13] riscv: Add sigcontext save/restore for vector
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
> This patch adds sigcontext save/restore for vector. The vector registers
> will be saved in datap pointer. The datap pointer will be allocaed
> dynamically when the task needs in kernel space. The datap pointer will
> be set right after the __riscv_v_state data structure to save all the
> vector registers in the signal handler stack.
>
> [greentime.hu@sifive.com: add support for dynamic vlen]
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/include/uapi/asm/sigcontext.h |  2 +
>  arch/riscv/kernel/signal.c               | 92 +++++++++++++++++++++++-
>  2 files changed, 91 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/include/uapi/asm/sigcontext.h b/arch/riscv/include/uapi/asm/sigcontext.h
> index 84f2dfcfdbce..4217f3f1c8ba 100644
> --- a/arch/riscv/include/uapi/asm/sigcontext.h
> +++ b/arch/riscv/include/uapi/asm/sigcontext.h
> @@ -8,6 +8,7 @@
>
>  #include <asm/ptrace.h>
>
> +#define RVV_MAGIC      0x53465457
>  /*
>   * Signal context structure
>   *
> @@ -17,6 +18,7 @@
>  struct sigcontext {
>         struct user_regs_struct sc_regs;
>         union __riscv_fp_state sc_fpregs;
> +       struct __riscv_v_state sc_vregs;
>  };
>
>  #endif /* _UAPI_ASM_RISCV_SIGCONTEXT_H */
> diff --git a/arch/riscv/kernel/signal.c b/arch/riscv/kernel/signal.c
> index 17ba190e84a5..9ada6f74bb95 100644
> --- a/arch/riscv/kernel/signal.c
> +++ b/arch/riscv/kernel/signal.c
> @@ -83,6 +83,80 @@ static long save_fp_state(struct pt_regs *regs,
>  #define restore_fp_state(task, regs) (0)
>  #endif
>
> +#ifdef CONFIG_VECTOR
> +static long restore_v_state(struct pt_regs *regs, struct sigcontext *sc)
> +{
> +       long err;
> +       struct __riscv_v_state __user *state = &sc->sc_vregs;
> +       void *datap;
> +       __u32 magic;
> +
> +       /* Get magic number and check it. */
> +       err = __get_user(magic, &state->magic);
> +       if (unlikely(err))
> +               return err;
> +
> +       if (magic != RVV_MAGIC)
> +               return -EINVAL;
> +
> +       /* Copy everything of __riscv_v_state except datap. */
> +       err = __copy_from_user(&current->thread.vstate, state,
> +                              RISCV_V_STATE_DATAP);
> +       if (unlikely(err))
> +               return err;
> +
> +       /* Copy the pointer datap itself. */
> +       err = __get_user(datap, &state->datap);
> +       if (unlikely(err))
> +               return err;
> +
> +
> +       /* Copy the whole vector content from user space datap. */
> +       err = __copy_from_user(current->thread.vstate.datap, datap,
> +                              current->thread.vstate.size);
> +       if (unlikely(err))
> +               return err;
> +
> +       vstate_restore(current, regs);
> +
> +       return err;
> +}
> +
> +static long save_v_state(struct pt_regs *regs, struct sigcontext *sc)
> +{
> +       long err;
> +       struct __riscv_v_state __user *state = &sc->sc_vregs;
> +       /* Set the datap right after the sigcntext structure. */
> +       void *datap = sc + 1;
> +
> +       vstate_save(current, regs);
> +       /* Copy everything of vstate but datap. */
> +       err = __copy_to_user(state, &current->thread.vstate,
> +                            RISCV_V_STATE_DATAP);
> +       if (unlikely(err))
> +               return err;
> +
> +       /* Copy the magic number. */
> +       err = __put_user(RVV_MAGIC, &state->magic);
> +       if (unlikely(err))
> +               return err;
> +
> +       /* Copy the pointer datap itself. */
> +       err = __put_user(datap, &state->datap);
> +       if (unlikely(err))
> +               return err;
> +
> +       /* Copy the whole vector content to user space datap. */
> +       err = __copy_to_user(datap, current->thread.vstate.datap,
> +                            current->thread.vstate.size);
> +
> +       return err;
> +}
> +#else
> +#define save_v_state(task, regs) (0)
> +#define restore_v_state(task, regs) (0)
> +#endif
> +
>  static long restore_sigcontext(struct pt_regs *regs,
>         struct sigcontext __user *sc)
>  {
> @@ -92,6 +166,9 @@ static long restore_sigcontext(struct pt_regs *regs,
>         /* Restore the floating-point state. */
>         if (has_fpu)
>                 err |= restore_fp_state(regs, &sc->sc_fpregs);
> +       /* Restore the vector state. */
> +       if (has_vector)
> +               err |= restore_v_state(regs, sc);
>         return err;
>  }
>
> @@ -101,13 +178,16 @@ SYSCALL_DEFINE0(rt_sigreturn)
>         struct rt_sigframe __user *frame;
>         struct task_struct *task;
>         sigset_t set;
> +       size_t frame_size = sizeof(*frame);
>
>         /* Always make any pending restarted system calls return -EINTR */
>         current->restart_block.fn = do_no_restart_syscall;
>
>         frame = (struct rt_sigframe __user *)regs->sp;
>
> -       if (!access_ok(frame, sizeof(*frame)))
> +       if (has_vector)
> +               frame_size += current->thread.vstate.size;
> +       if (!access_ok(frame, frame_size))
>                 goto badframe;
>
>         if (__copy_from_user(&set, &frame->uc.uc_sigmask, sizeof(set)))
> @@ -145,6 +225,9 @@ static long setup_sigcontext(struct rt_sigframe __user *frame,
>         /* Save the floating-point state. */
>         if (has_fpu)
>                 err |= save_fp_state(regs, &sc->sc_fpregs);
> +       /* Save the vector state. */
> +       if (has_vector)
> +               err |= save_v_state(regs, sc);
>         return err;
>  }
>
> @@ -176,9 +259,12 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
>  {
>         struct rt_sigframe __user *frame;
>         long err = 0;
> +       size_t frame_size = sizeof(*frame);
>
> -       frame = get_sigframe(ksig, regs, sizeof(*frame));
> -       if (!access_ok(frame, sizeof(*frame)))
> +       if (has_vector)
> +               frame_size += current->thread.vstate.size;
> +       frame = get_sigframe(ksig, regs, frame_size);
> +       if (!access_ok(frame, frame_size))
>                 return -EFAULT;
>
>         err |= copy_siginfo_to_user(&frame->info, &ksig->info);
> --
> 2.26.2
>
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
