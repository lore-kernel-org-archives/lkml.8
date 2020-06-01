Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83445C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60681206E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591002749;
	bh=XaBczYYm0dgNg26+7OPpYAKLtWaTtsU2jNmMocGEg+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=wvU/zq3gIOMlMfRpymsjeeFmOmNjzTw21qDFL9DQu0z3y0sZNtrunjRWs8N+6TJ4z
	 XWOvFo6Z4hB21ntog+ALu+NFGIvtP1olAd8igWPr/5H2VdrnAkGZcF8S6dlyFwXs+4
	 MOwpNajaadqpdMEWfRLNBrrGqkNr2jDmEKM3mT3s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgFAJM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:12:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725831AbgFAJM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:12:28 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCDD320734
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591002747;
        bh=XaBczYYm0dgNg26+7OPpYAKLtWaTtsU2jNmMocGEg+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zPG/R4YQGgMcVD1vDVWgtCV6QgaMzR7FnaRYsF325VamsGjd6hUptzQFJ5t+J9v6t
         A4jgXaEWazhwka1vJ93/bzXgMABKduro30GhnDn4XmcykSuTx6Z0uyFoD07N2YrIrc
         ILfCZYzXqFrw4NYe+aRK6RFOVRbSOpCiEkfbe6QM=
Received: by mail-lj1-f174.google.com with SMTP id z6so7146691ljm.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 02:12:26 -0700 (PDT)
X-Gm-Message-State: AOAM532sQ61JioB496KCQluir0hsTOen0TTL4qMXqrwVNjLGsR47N6X9
        SDCN/5zQuN3wr/EVCBoOX6UEVzY/+GiqyO+oYws=
X-Google-Smtp-Source: ABdhPJwNN0gMX/urhnLnrniACiL2yZ/7oMTw3RyS/24I8Z1lmMyfh4PcjnoeMU6EeZpM2LSQDbPzd3egOk/2x79mNUo=
X-Received: by 2002:a2e:9c95:: with SMTP id x21mr10387218lji.441.1591002745078;
 Mon, 01 Jun 2020 02:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1590474856.git.greentime.hu@sifive.com> <1f20f778318bf18e47eace08e54983fed23ba019.1590474856.git.greentime.hu@sifive.com>
In-Reply-To: <1f20f778318bf18e47eace08e54983fed23ba019.1590474856.git.greentime.hu@sifive.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 1 Jun 2020 17:12:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRu63t7Ftv_V1ZLAEu4Vi57Q6uvp+sZjYBROkuJXX0=mg@mail.gmail.com>
Message-ID: <CAJF2gTRu63t7Ftv_V1ZLAEu4Vi57Q6uvp+sZjYBROkuJXX0=mg@mail.gmail.com>
Subject: Re: [RFC PATCH v4 09/13] riscv: Add vector struct and assembler definitions
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
> Add vector state context struct in struct thread and asm-offsets.c
> definitions.
>
> The vector registers will be saved in datap pointer of __riscv_v_state. It
> will be dynamically allocated in kernel space. It will be put right after
> the __riscv_v_state data structure in user space.
>
> [greentime.hu@sifive.com: add support for dynamic vlen, add vcsr and remove
> vxsat, vxrm because these data can be get in vcsr, add new macros for
> _riscv_v_state elements offset and remove unused ones]
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/include/asm/processor.h   |  1 +
>  arch/riscv/include/uapi/asm/ptrace.h | 13 +++++++++++++
>  arch/riscv/kernel/asm-offsets.c      |  8 ++++++++
>  3 files changed, 22 insertions(+)
>
> diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> index 3ddb798264f1..217273375cfb 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -32,6 +32,7 @@ struct thread_struct {
>         unsigned long sp;       /* Kernel mode stack */
>         unsigned long s[12];    /* s[0]: frame pointer */
>         struct __riscv_d_ext_state fstate;
> +       struct __riscv_v_state vstate;
>  };
>
>  #define INIT_THREAD {                                  \
> diff --git a/arch/riscv/include/uapi/asm/ptrace.h b/arch/riscv/include/uapi/asm/ptrace.h
> index 882547f6bd5c..661b0466b850 100644
> --- a/arch/riscv/include/uapi/asm/ptrace.h
> +++ b/arch/riscv/include/uapi/asm/ptrace.h
> @@ -77,6 +77,19 @@ union __riscv_fp_state {
>         struct __riscv_q_ext_state q;
>  };
>
> +struct __riscv_v_state {
> +       __u32 magic;
> +       __u32 size;
> +       unsigned long vstart;
> +       unsigned long vl;
> +       unsigned long vtype;
> +       unsigned long vcsr;
> +       void *datap;
> +#if __riscv_xlen == 32
> +       __u32 __padding;
> +#endif
> +} __attribute__((aligned(16)));
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _UAPI_ASM_RISCV_PTRACE_H */
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index 07cb9c10de4e..6627fde230b2 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -70,6 +70,14 @@ void asm_offsets(void)
>         OFFSET(TASK_THREAD_F31, task_struct, thread.fstate.f[31]);
>         OFFSET(TASK_THREAD_FCSR, task_struct, thread.fstate.fcsr);
>
> +       OFFSET(RISCV_V_STATE_MAGIC, __riscv_v_state, magic);
> +       OFFSET(RISCV_V_STATE_SIZE, __riscv_v_state, size);
> +       OFFSET(RISCV_V_STATE_VSTART, __riscv_v_state, vstart);
> +       OFFSET(RISCV_V_STATE_VL, __riscv_v_state, vl);
> +       OFFSET(RISCV_V_STATE_VTYPE, __riscv_v_state, vtype);
> +       OFFSET(RISCV_V_STATE_VCSR, __riscv_v_state, vcsr);
> +       OFFSET(RISCV_V_STATE_DATAP, __riscv_v_state, datap);
> +
>         DEFINE(PT_SIZE, sizeof(struct pt_regs));
>         OFFSET(PT_EPC, pt_regs, epc);
>         OFFSET(PT_RA, pt_regs, ra);
> --
> 2.26.2
>
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
