Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25BFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B6492068D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:35:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rayp8W48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437247AbgE1Wf0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:35:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436945AbgE1WfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:35:19 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD62C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:35:19 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t8so74023ilm.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 15:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AOBQ1jNgjIrfLfnJROGoleGhOCiGe5bUYEj5pHpMPbU=;
        b=Rayp8W48zPkWTWgkVHu0kibRSBUFAaUfbva6sOoI5inJ1lBsLQsl0WMwy/C5g5dIDo
         NErPh5HRsDkPAMqGdAORY1x8fH2aUHik1ib4Xb8BJ9d8NplS2UxhU85YG+O4t+g6is18
         VH3RQSD2itMHWTFw76GraXfppy/DFP+G9GEy5w+8pHtYPGypML3ZhfO5M57e729zGbDj
         /Eh3AtUT3qp8iwVdAH8K2RBg48w2F3m+Pxs+FhEFjVxCQXgt7wAfCddylFLPcwErsRBS
         FcW4AmXgIHrSuRDyY1tskrd73OHepYDHF86tteF/wRxsnbqrHyrYb9PA9ZbH//PmNjwI
         x+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AOBQ1jNgjIrfLfnJROGoleGhOCiGe5bUYEj5pHpMPbU=;
        b=CM5zkeNskmFfOIq9kV/2Gy9OdmDmDsb4OlbhBLqYeD5ouQReHXqRs0WF/rA2BVpCfQ
         txN8pl0D1iAFPgi4sZzXYXrI7N7J7Ol5KnWEhL3i9EtocQh6vbomEaKi3SmNG5IhSZKw
         6sO5Vb51ybwjD2raewK0tumz26Ylk6X8Z/cs/sEsg52m7A5hGVq88wIYuIHEKE4hZIeY
         PniL+XaRoMo2DnAXKq6pCyNUzB/5vjzW60es/7JKGj+2+ze0p4UX7VkNPNwewi5YnVAt
         VAwV/rlgXZK7bCqJxn9snnN+sO4UuZxj5gCnl7k0DCbb+VLXSoWjhny7kxT2Vtr3Ln//
         +P3Q==
X-Gm-Message-State: AOAM532+Jc53hoH1eZ1vqxidkcvok45S1q2rIke/FRBPl/x2XUJDtO6h
        F4T/Xvfkgu2lL9kS6e7S2vAkBtRAGTBQEeODXVg=
X-Google-Smtp-Source: ABdhPJxl3VfQlWRzldYHCKdARgDz5BA13nWVpjbpACrsjetnbuSkdiGrNrS/bLLXgR4I1kH68Y/dBMtUSmyzbZiQAXE=
X-Received: by 2002:a92:c8d1:: with SMTP id c17mr4716419ilq.308.1590705318795;
 Thu, 28 May 2020 15:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200528201937.038455891@infradead.org> <20200528202328.708732152@infradead.org>
In-Reply-To: <20200528202328.708732152@infradead.org>
From:   Lai Jiangshan <jiangshanlai+lkml@gmail.com>
Date:   Fri, 29 May 2020 06:35:07 +0800
Message-ID: <CAJhGHyBsFgDRGS+kihijgH2MbnULkkUS2xfDJsNF09F782EM5g@mail.gmail.com>
Subject: Re: [RFC][PATCH 6/6] x86/entry: Remove DBn stacks
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        andrew.cooper3@citrix.com, daniel.thompson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 4:26 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Both #DB itself, as all other IST users (NMI, #MC) now clear DR7 on
> entry. Combined with not allowing breakpoints on entry/noinstr/NOKPROBE
> text and no single step (EFLAGS.TF) inside the #DB handler should
> guarantee us no nested #DB.
>
> XXX depends on KGDB breakpoints not being stupid
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/entry/entry_64.S             |   13 -------------
>  arch/x86/include/asm/cpu_entry_area.h |    6 ------
>  arch/x86/kernel/asm-offsets_64.c      |    3 ---
>  arch/x86/kernel/dumpstack_64.c        |    3 ---
>  arch/x86/mm/cpu_entry_area.c          |    1 -
>  5 files changed, 26 deletions(-)
>
> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -396,11 +396,6 @@ SYM_CODE_END(\asmsym)
>         idtentry \vector asm_\cfunc \cfunc has_error_code=0
>  .endm
>
> -/*
> - * MCE and DB exceptions
> - */
> -#define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
> -
>  /**
>   * idtentry_mce_db - Macro to generate entry stubs for #MC and #DB
>   * @vector:            Vector number
> @@ -445,16 +440,8 @@ SYM_CODE_START(\asmsym)

There is some comment in the code above which need to be removed:
 * If the trap is #DB then the interrupt stack entry in the IST is
 * moved to the second stack, so a potential recursion will have a
 * fresh IST.

see:
https://lore.kernel.org/lkml/20200526014221.2119-6-laijs@linux.alibaba.com/

>
>         movq    %rsp, %rdi              /* pt_regs pointer */
>
> -       .if \vector == X86_TRAP_DB
> -               subq    $DB_STACK_OFFSET, CPU_TSS_IST(IST_INDEX_DB)
> -       .endif
> -
>         call    \cfunc
>
> -       .if \vector == X86_TRAP_DB
> -               addq    $DB_STACK_OFFSET, CPU_TSS_IST(IST_INDEX_DB)
> -       .endif
> -
>         jmp     paranoid_exit
>
>         /* Switch to the regular task stack and use the noist entry point */
> --- a/arch/x86/include/asm/cpu_entry_area.h
> +++ b/arch/x86/include/asm/cpu_entry_area.h
> @@ -16,10 +16,6 @@
>         char    DF_stack[EXCEPTION_STKSZ];      \
>         char    NMI_stack_guard[guardsize];     \
>         char    NMI_stack[EXCEPTION_STKSZ];     \
> -       char    DB2_stack_guard[guardsize];     \
> -       char    DB2_stack[db2_holesize];        \
> -       char    DB1_stack_guard[guardsize];     \
> -       char    DB1_stack[EXCEPTION_STKSZ];     \
>         char    DB_stack_guard[guardsize];      \
>         char    DB_stack[EXCEPTION_STKSZ];      \
>         char    MCE_stack_guard[guardsize];     \

argument db2_holesize should be removed

> @@ -42,8 +38,6 @@ struct cea_exception_stacks {
>  enum exception_stack_ordering {
>         ESTACK_DF,
>         ESTACK_NMI,
> -       ESTACK_DB2,
> -       ESTACK_DB1,
>         ESTACK_DB,
>         ESTACK_MCE,
>         N_EXCEPTION_STACKS



There will be a compile error about N_EXCEPTION_STACKS
in arch/x86/kernel/dumpstack_64.c. It should have

- BUILD_BUG_ON(N_EXCEPTION_STACKS != 6);
+ BUILD_BUG_ON(N_EXCEPTION_STACKS != 4);

see:
https://lore.kernel.org/lkml/20200526014221.2119-8-laijs@linux.alibaba.com/





> --- a/arch/x86/kernel/asm-offsets_64.c
> +++ b/arch/x86/kernel/asm-offsets_64.c
> @@ -57,9 +57,6 @@ int main(void)
>         BLANK();
>  #undef ENTRY
>
> -       OFFSET(TSS_ist, tss_struct, x86_tss.ist);
> -       DEFINE(DB_STACK_OFFSET, offsetof(struct cea_exception_stacks, DB_stack) -
> -              offsetof(struct cea_exception_stacks, DB1_stack));
>         BLANK();
>
>  #ifdef CONFIG_STACKPROTECTOR
> --- a/arch/x86/kernel/dumpstack_64.c
> +++ b/arch/x86/kernel/dumpstack_64.c
> @@ -22,8 +22,6 @@
>  static const char * const exception_stack_names[] = {
>                 [ ESTACK_DF     ]       = "#DF",
>                 [ ESTACK_NMI    ]       = "NMI",
> -               [ ESTACK_DB2    ]       = "#DB2",
> -               [ ESTACK_DB1    ]       = "#DB1",
>                 [ ESTACK_DB     ]       = "#DB",
>                 [ ESTACK_MCE    ]       = "#MC",
>  };
> @@ -79,7 +77,6 @@ static const
>  struct estack_pages estack_pages[CEA_ESTACK_PAGES] ____cacheline_aligned = {
>         EPAGERANGE(DF),
>         EPAGERANGE(NMI),
> -       EPAGERANGE(DB1),
>         EPAGERANGE(DB),
>         EPAGERANGE(MCE),
>  };
> --- a/arch/x86/mm/cpu_entry_area.c
> +++ b/arch/x86/mm/cpu_entry_area.c
> @@ -107,7 +107,6 @@ static void __init percpu_setup_exceptio
>          */
>         cea_map_stack(DF);
>         cea_map_stack(NMI);
> -       cea_map_stack(DB1);
>         cea_map_stack(DB);
>         cea_map_stack(MCE);
>  }
>
>
