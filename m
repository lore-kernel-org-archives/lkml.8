Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E4CC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856DE2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyiKMduN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgGOCT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgGOCT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:19:26 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAC9C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:19:26 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 5so285471oty.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jUGDSqi69Akm05/pcLfGWY4X/8FfrjE00ft2xbB2QWc=;
        b=LyiKMduNZ8amiKsL4mV2djbji46jZdOVOhCtuuxnxYh2j8/R8NLmA3TJNQLsBkFYoX
         okplpVx4+6AukyRFBAISHPONayC/g0qbsj+iojklDReG+oS/dSbVtlrUhrSUpBFf1ps+
         zLnpl+1TX/6G54yUd9wXE0o8/GhEHCQS+LxDmYHceFVHmrzzWLjRl5Vhl4J+zg9K+e00
         LjvHCE8tvHakMGrVePDgw5UTjWC7FxXRgfb+Cfmj1mQmm1NTjpEGxaq1GIP0QldK8Y+8
         Psflpfpl4t0xVMKzPKygcBpsBGNb0FTT6DBRZPnLiRs80MS+f5u9ZNAmugEZVrZXj3un
         XXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jUGDSqi69Akm05/pcLfGWY4X/8FfrjE00ft2xbB2QWc=;
        b=nn9p6AuAWYrYw1Nvien5++ax3k4k284XyUO0CqHrODGYszoiZz+6ofTSzlIDiHsQk8
         x9LDQpF+ZntNJB2R6R5oR3oua2m3KSqjlJhR3dfglY4NjFAZQU8zzRHSSCDSLxn/WBMU
         Zv2KpofMBFVDE5SCF0CA6m3rHyAv7MPgXPyVKhvIV4WJwdJLegZCx+MuIjw+l1MQTqRl
         pat3yWumLtuEdT89uNeKZkerhzzcEAgROwD5IpSWpZF0SWL2X5n5+TVqiupbJJHwFHPj
         8Q+DJQgLtbNCffKS4dID0y6knF+gAL7aU/StumuNjMklNBHRvKAWEIb7Wikw4bgprja+
         7XIA==
X-Gm-Message-State: AOAM530kAgq+JG8vhBqjLGPER82W75Rqi0qShi6vg+8LezRve/9pvNtH
        +cxnU37GkAndjGAIA1wIniytollT8vBaHE4gDgPKHBYWpLY=
X-Google-Smtp-Source: ABdhPJxA3/h2hp+186jfFN98nqbXbToX4EPKX9nJpqjoSCVuMQkCDABArgMs3H6kAYlMXvfQTM4ZFAbL+ThF3/ADSYQ=
X-Received: by 2002:a9d:7f06:: with SMTP id j6mr6685899otq.51.1594779565671;
 Tue, 14 Jul 2020 19:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200708045046.135702-1-ravi.bangoria@linux.ibm.com> <20200708045046.135702-3-ravi.bangoria@linux.ibm.com>
In-Reply-To: <20200708045046.135702-3-ravi.bangoria@linux.ibm.com>
From:   Jordan Niethe <jniethe5@gmail.com>
Date:   Wed, 15 Jul 2020 12:19:14 +1000
Message-ID: <CACzsE9qSjWKWGDQPGSk-c5f5pxUyWWtUFW+AzzB5M76qFcQ-Cw@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] powerpc/watchpoint: Fix DAWR exception constraint
To:     Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org,
        apopple@linux.ibm.com, Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        naveen.n.rao@linux.vnet.ibm.com, peterz@infradead.org,
        jolsa@kernel.org, oleg@redhat.com, fweisbec@gmail.com,
        mingo@kernel.org, pedromfc@br.ibm.com, miltonm@us.ibm.com,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 2:52 PM Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
>
> Pedro Miraglia Franco de Carvalho noticed that on p8, DAR value is
> inconsistent with different type of load/store. Like for byte,word
> etc. load/stores, DAR is set to the address of the first byte of
> overlap between watch range and real access. But for quadword load/
> store it's set to the address of the first byte of real access. This
> issue has been fixed in p10. In p10(ISA 3.1), DAR is always set to
> the address of the first byte of overlap. Commit 27985b2a640e
> ("powerpc/watchpoint: Don't ignore extraneous exceptions blindly")
> wrongly assumes that DAR is set to the address of the first byte of
> overlap for all load/stores on p8 as well. Fix that. With the fix,
> we now rely on 'ea' provided by analyse_instr(). If analyse_instr()
> fails, generate event unconditionally on p8, and on p10 generate
> event only if DAR is within a DAWR range.
>
> Note: 8xx is not affected.
>
> Fixes: 27985b2a640e ("powerpc/watchpoint: Don't ignore extraneous exceptions blindly")
> Fixes: 74c6881019b7 ("powerpc/watchpoint: Prepare handler to handle more than one watchpoint")
> Reported-by: Pedro Miraglia Franco de Carvalho <pedromfc@br.ibm.com>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> ---
>  arch/powerpc/kernel/hw_breakpoint.c | 93 +++++++++++++++++++----------
>  1 file changed, 63 insertions(+), 30 deletions(-)
>
> diff --git a/arch/powerpc/kernel/hw_breakpoint.c b/arch/powerpc/kernel/hw_breakpoint.c
> index 031e6defc08e..7a66c370a105 100644
> --- a/arch/powerpc/kernel/hw_breakpoint.c
> +++ b/arch/powerpc/kernel/hw_breakpoint.c
> @@ -498,11 +498,11 @@ static bool dar_in_user_range(unsigned long dar, struct arch_hw_breakpoint *info
>         return ((info->address <= dar) && (dar - info->address < info->len));
>  }
>
> -static bool dar_user_range_overlaps(unsigned long dar, int size,
> -                                   struct arch_hw_breakpoint *info)
> +static bool ea_user_range_overlaps(unsigned long ea, int size,
> +                                  struct arch_hw_breakpoint *info)
>  {
> -       return ((dar < info->address + info->len) &&
> -               (dar + size > info->address));
> +       return ((ea < info->address + info->len) &&
> +               (ea + size > info->address));
>  }
>
>  static bool dar_in_hw_range(unsigned long dar, struct arch_hw_breakpoint *info)
> @@ -515,20 +515,22 @@ static bool dar_in_hw_range(unsigned long dar, struct arch_hw_breakpoint *info)
>         return ((hw_start_addr <= dar) && (hw_end_addr > dar));
>  }
>
> -static bool dar_hw_range_overlaps(unsigned long dar, int size,
> -                                 struct arch_hw_breakpoint *info)
> +static bool ea_hw_range_overlaps(unsigned long ea, int size,
> +                                struct arch_hw_breakpoint *info)
>  {
>         unsigned long hw_start_addr, hw_end_addr;
>
>         hw_start_addr = ALIGN_DOWN(info->address, HW_BREAKPOINT_SIZE);
>         hw_end_addr = ALIGN(info->address + info->len, HW_BREAKPOINT_SIZE);
>
> -       return ((dar < hw_end_addr) && (dar + size > hw_start_addr));
> +       return ((ea < hw_end_addr) && (ea + size > hw_start_addr));
>  }
>
>  /*
>   * If hw has multiple DAWR registers, we also need to check all
>   * dawrx constraint bits to confirm this is _really_ a valid event.
> + * If type is UNKNOWN, but privilege level matches, consider it as
> + * a positive match.
>   */
>  static bool check_dawrx_constraints(struct pt_regs *regs, int type,
>                                     struct arch_hw_breakpoint *info)
> @@ -536,7 +538,12 @@ static bool check_dawrx_constraints(struct pt_regs *regs, int type,
>         if (OP_IS_LOAD(type) && !(info->type & HW_BRK_TYPE_READ))
>                 return false;
>
> -       if (OP_IS_STORE(type) && !(info->type & HW_BRK_TYPE_WRITE))
> +       /*
> +        * The Cache Management instructions other than dcbz never
> +        * cause a match. i.e. if type is CACHEOP, the instruction
> +        * is dcbz, and dcbz is treated as Store.
> +        */
> +       if ((OP_IS_STORE(type) || type == CACHEOP) && !(info->type & HW_BRK_TYPE_WRITE))
>                 return false;
This change seems seperate to this commit?
>
>         if (is_kernel_addr(regs->nip) && !(info->type & HW_BRK_TYPE_KERNEL))
> @@ -553,7 +560,8 @@ static bool check_dawrx_constraints(struct pt_regs *regs, int type,
>   * including extraneous exception. Otherwise return false.
>   */
>  static bool check_constraints(struct pt_regs *regs, struct ppc_inst instr,
> -                             int type, int size, struct arch_hw_breakpoint *info)
> +                             unsigned long ea, int type, int size,
> +                             struct arch_hw_breakpoint *info)
>  {
>         bool in_user_range = dar_in_user_range(regs->dar, info);
>         bool dawrx_constraints;
> @@ -569,11 +577,10 @@ static bool check_constraints(struct pt_regs *regs, struct ppc_inst instr,
>         }
>
>         if (unlikely(ppc_inst_equal(instr, ppc_inst(0)))) {
> -               if (in_user_range)
> -                       return true;
> -
> -               if (dar_in_hw_range(regs->dar, info)) {
> -                       info->type |= HW_BRK_TYPE_EXTRANEOUS_IRQ;
> +               if (cpu_has_feature(CPU_FTR_ARCH_31)) {
> +                       if (dar_in_hw_range(regs->dar, info))
> +                               return true;
> +               } else {
>                         return true;
I think this would be clearer as:
        if (cpu_has_feature(CPU_FTR_ARCH_31) &&
!(dar_in_hw_range(regs->dar, info)))
            return false;
        else
            return true;

>                 }
>                 return false;
> @@ -581,10 +588,20 @@ static bool check_constraints(struct pt_regs *regs, struct ppc_inst instr,
>
>         dawrx_constraints = check_dawrx_constraints(regs, type, info);
>
> -       if (dar_user_range_overlaps(regs->dar, size, info))
> +       if (type == UNKNOWN) {
> +               if (cpu_has_feature(CPU_FTR_ARCH_31)) {
> +                       if (dar_in_hw_range(regs->dar, info))
> +                               return dawrx_constraints;
> +               } else {
> +                       return dawrx_constraints;
> +               }
> +               return false;
> +       }
Similar thing here, it could be:
        if ((cpu_has_feature(CPU_FTR_ARCH_31)) &&
!(dar_in_hw_range(regs->dar, info)))
            return false;
        else
            return dawrx_constraints;
> +
> +       if (ea_user_range_overlaps(ea, size, info))
>                 return dawrx_constraints;
>
> -       if (dar_hw_range_overlaps(regs->dar, size, info)) {
> +       if (ea_hw_range_overlaps(ea, size, info)) {
>                 if (dawrx_constraints) {
>                         info->type |= HW_BRK_TYPE_EXTRANEOUS_IRQ;
>                         return true;
> @@ -593,8 +610,17 @@ static bool check_constraints(struct pt_regs *regs, struct ppc_inst instr,
>         return false;
>  }
>
> +static int cache_op_size(void)
> +{
> +#ifdef __powerpc64__
> +       return ppc64_caches.l1d.block_size;
> +#else
> +       return L1_CACHE_BYTES;
> +#endif
> +}
> +
>  static void get_instr_detail(struct pt_regs *regs, struct ppc_inst *instr,
> -                            int *type, int *size, bool *larx_stcx)
> +                            int *type, int *size, unsigned long *ea)
>  {
>         struct instruction_op op;
>
> @@ -602,16 +628,23 @@ static void get_instr_detail(struct pt_regs *regs, struct ppc_inst *instr,
>                 return;
>
>         analyse_instr(&op, regs, *instr);
> -
> -       /*
> -        * Set size = 8 if analyse_instr() fails. If it's a userspace
> -        * watchpoint(valid or extraneous), we can notify user about it.
> -        * If it's a kernel watchpoint, instruction  emulation will fail
> -        * in stepping_handler() and watchpoint will be disabled.
> -        */
>         *type = GETTYPE(op.type);
> -       *size = !(*type == UNKNOWN) ? GETSIZE(op.type) : 8;
> -       *larx_stcx = (*type == LARX || *type == STCX);
> +       *ea = op.ea;
> +#ifdef __powerpc64__
> +       if (!(regs->msr & MSR_64BIT))
> +               *ea &= 0xffffffffUL;
> +#endif
> +
> +       *size = GETSIZE(op.type);
> +       if (*type == CACHEOP) {
> +               *size = cache_op_size();
> +               *ea &= ~(*size - 1);
> +       }
Again related to CACHEOP, should these changes be mentioned in the
commit message?
> +}
> +
> +static bool is_larx_stcx_instr(int type)
> +{
> +       return type == LARX || type == STCX;
>  }
>
>  /*
> @@ -678,7 +711,7 @@ int hw_breakpoint_handler(struct die_args *args)
>         struct ppc_inst instr = ppc_inst(0);
>         int type = 0;
>         int size = 0;
> -       bool larx_stcx = false;
> +       unsigned long ea;
>
>         /* Disable breakpoints during exception handling */
>         hw_breakpoint_disable();
> @@ -692,7 +725,7 @@ int hw_breakpoint_handler(struct die_args *args)
>         rcu_read_lock();
>
>         if (!IS_ENABLED(CONFIG_PPC_8xx))
> -               get_instr_detail(regs, &instr, &type, &size, &larx_stcx);
> +               get_instr_detail(regs, &instr, &type, &size, &ea);
>
>         for (i = 0; i < nr_wp_slots(); i++) {
>                 bp[i] = __this_cpu_read(bp_per_reg[i]);
> @@ -702,7 +735,7 @@ int hw_breakpoint_handler(struct die_args *args)
>                 info[i] = counter_arch_bp(bp[i]);
>                 info[i]->type &= ~HW_BRK_TYPE_EXTRANEOUS_IRQ;
>
> -               if (check_constraints(regs, instr, type, size, info[i])) {
> +               if (check_constraints(regs, instr, ea, type, size, info[i])) {
>                         if (!IS_ENABLED(CONFIG_PPC_8xx) &&
>                             ppc_inst_equal(instr, ppc_inst(0))) {
>                                 handler_error(bp[i], info[i]);
> @@ -744,7 +777,7 @@ int hw_breakpoint_handler(struct die_args *args)
>         }
>
>         if (!IS_ENABLED(CONFIG_PPC_8xx)) {
> -               if (larx_stcx) {
> +               if (is_larx_stcx_instr(type)) {
>                         for (i = 0; i < nr_wp_slots(); i++) {
>                                 if (!hit[i])
>                                         continue;
> --
> 2.26.2
>
