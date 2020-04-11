Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232A6C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 03:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E149520708
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 03:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586576703;
	bh=OS2a3zaCRGwhNUfft3nAzcgG17YLWHOXyNtOi4N1dbg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=CQnTGeMnj+odq1SnTJ2oktv07tiehDgrPCSQv6Zjo5HGsEBpnDYxCCeBE0PH21Djr
	 V9KYV30z337Fo9m7s5l0XVbDa3RDRNlOvvpvaVxKlKats+8PyboW5k3f95aOaQpYqY
	 53mPObi1LxZMeF8VCAZicHMpSzh2jqkOp4XU1oPk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDKDou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 23:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:58934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbgDKDot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 23:44:49 -0400
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEC8620708
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 03:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586576689;
        bh=OS2a3zaCRGwhNUfft3nAzcgG17YLWHOXyNtOi4N1dbg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BkElBRyvAVAIX0BdvVGYTItGfcjjFA68k+yCMQklskkVFX7lfCyrF6Db6dJoq3DMr
         XLcaqZWxNiwbDGWaHhQgSgcLzkJa1g6lwNSk9YbIK/yZbZQFLEcCn5Z2uM6rtE9l6h
         7AGqdOCAvD9X0reRUIDbJLVmeGT9ToCJLsupLAYM=
Received: by mail-lf1-f46.google.com with SMTP id h6so2656327lfc.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 20:44:48 -0700 (PDT)
X-Gm-Message-State: AGi0PubZ1A3aI87EUwDqpCZlJdZGhZIikRfb6nWsje2PIaUyI4MlXnSD
        /i26JUPeyyInk6RxMlD6pWySZk3IJqizEHWcYDg=
X-Google-Smtp-Source: APiQypLnYrjuwRBpuq2OCZWZjJfBpzditT0smA9TJ2eF6UuYtIR3V6Q9QdAU05tJLyK3X/VoLTF8GkEMaG+OwZUWuN8=
X-Received: by 2002:ac2:5607:: with SMTP id v7mr4293181lfd.212.1586576686950;
 Fri, 10 Apr 2020 20:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200410032634.57511-1-zong.li@sifive.com>
In-Reply-To: <20200410032634.57511-1-zong.li@sifive.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 11 Apr 2020 11:44:35 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSAe_=0Eg12O-Sjc6897EOqwZOQFPc5utKWQ32gn6BFEA@mail.gmail.com>
Message-ID: <CAJF2gTSAe_=0Eg12O-Sjc6897EOqwZOQFPc5utKWQ32gn6BFEA@mail.gmail.com>
Subject: Re: [PATCH] riscv: remove the assert of lock for cpu_running
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Guo Ren <guoren@kernel.org>

Haha, are you working on lockdep ? Me too, here is my patch, not finished.

It's still warning at begin, I've no time to debug, and it's similar to csky's:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/csky?id=000591f1ca3312d9a29e15a9e3fe5c4171f75586

If you are working on LOCKDEP, I'll wait your patch :)

commit 096d7a4b26d21aa7c71c86f200241144569e697a (riscv-lockdep)
Author: Guo Ren <guoren@linux.alibaba.com>
Date:   Fri Apr 10 16:38:37 2020 +0800

    riscv: Enable LOCKDEP_SUPPORT

    Lockdep is needed by proving the spinlocks and rwlocks.

    Signed-off-by: Guo Ren <guoren@linux.alibaba.com>

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8672e77a5b7a..bfe76c76a107 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -163,6 +163,9 @@ config PGTABLE_LEVELS
        default 3 if 64BIT
        default 2

+config LOCKDEP_SUPPORT
+       def_bool y
+
 source "arch/riscv/Kconfig.socs"

 menu "Platform type"
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 208702d8c18e..41588ee74cb2 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -175,6 +175,24 @@ ENTRY(handle_exception)
 .option pop

        la ra, ret_from_exception
+#ifdef CONFIG_TRACE_IRQFLAGS
+       call trace_hardirqs_off
+       la ra, ret_from_exception
+       REG_L s0, PT_SP(sp)
+       REG_L s1, PT_STATUS(sp)
+       REG_L s2, PT_EPC(sp)
+       REG_L s3, PT_BADADDR(sp)
+       REG_L s4, PT_CAUSE(sp)
+       REG_L s5, PT_TP(sp)
+       REG_L a0, PT_A0(sp)
+       REG_L a1, PT_A1(sp)
+       REG_L a2, PT_A2(sp)
+       REG_L a3, PT_A3(sp)
+       REG_L a4, PT_A4(sp)
+       REG_L a5, PT_A5(sp)
+       REG_L a6, PT_A6(sp)
+       REG_L a7, PT_A7(sp)
+#endif
        /*
         * MSB of cause differentiates between
         * interrupts and exceptions
@@ -191,6 +209,24 @@ ENTRY(handle_exception)
         */
        andi t0, s1, SR_PIE
        beqz t0, 1f
+#ifdef CONFIG_TRACE_IRQFLAGS
+       call trace_hardirqs_on
+       la ra, ret_from_exception
+       REG_L s0, PT_SP(sp)
+       REG_L s1, PT_STATUS(sp)
+       REG_L s2, PT_EPC(sp)
+       REG_L s3, PT_BADADDR(sp)
+       REG_L s4, PT_CAUSE(sp)
+       REG_L s5, PT_TP(sp)
+       REG_L a0, PT_A0(sp)
+       REG_L a1, PT_A1(sp)
+       REG_L a2, PT_A2(sp)
+       REG_L a3, PT_A3(sp)
+       REG_L a4, PT_A4(sp)
+       REG_L a5, PT_A5(sp)
+       REG_L a6, PT_A6(sp)
+       REG_L a7, PT_A7(sp)
+#endif
        csrs CSR_STATUS, SR_IE

 1:
@@ -291,6 +327,31 @@ resume_userspace:
        csrw CSR_SCRATCH, tp

 restore_all:
+#ifdef CONFIG_TRACE_IRQFLAGS
+       REG_L s1, PT_STATUS(sp)
+       andi t0, s1, SR_PIE
+       beqz t0, 1f
+       call trace_hardirqs_on
+       j 2f
+1:
+       call trace_hardirqs_off
+2:
+       la ra, ret_from_exception
+       REG_L s0, PT_SP(sp)
+       REG_L s1, PT_STATUS(sp)
+       REG_L s2, PT_EPC(sp)
+       REG_L s3, PT_BADADDR(sp)
+       REG_L s4, PT_CAUSE(sp)
+       REG_L s5, PT_TP(sp)
+       REG_L a0, PT_A0(sp)
+       REG_L a1, PT_A1(sp)
+       REG_L a2, PT_A2(sp)
+       REG_L a3, PT_A3(sp)
+       REG_L a4, PT_A4(sp)
+       REG_L a5, PT_A5(sp)
+       REG_L a6, PT_A6(sp)
+       REG_L a7, PT_A7(sp)
+#endif
        RESTORE_ALL
 #ifdef CONFIG_RISCV_M_MODE
        mret
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 8bc01f0ca73b..54fd70eb50bd 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -115,7 +115,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
                  task_stack_page(tidle) + THREAD_SIZE);
        WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);

-       lockdep_assert_held(&cpu_running);
+//     lockdep_assert_held(&cpu_running);
        wait_for_completion_timeout(&cpu_running,
                                            msecs_to_jiffies(1000));

On Fri, Apr 10, 2020 at 11:26 AM Zong Li <zong.li@sifive.com> wrote:
>
> The cpu_running is not a lock-class, it lacks the dep_map member in
> completion. It causes the error as follow:
>
> arch/riscv/kernel/smpboot.c: In function '__cpu_up':
> ./include/linux/lockdep.h:364:52: error: 'struct completion' has no member named 'dep_map'
>   364 | #define lockdep_is_held(lock)  lock_is_held(&(lock)->dep_map)
>       |                                                    ^~
> ./include/asm-generic/bug.h:113:25: note: in definition of macro 'WARN_ON'
>   113 |  int __ret_warn_on = !!(condition);    \
>       |                         ^~~~~~~~~
> ./include/linux/lockdep.h:390:27: note: in expansion of macro 'lockdep_is_held'
>   390 |   WARN_ON(debug_locks && !lockdep_is_held(l)); \
>       |                           ^~~~~~~~~~~~~~~
> arch/riscv/kernel/smpboot.c:118:2: note: in expansion of macro 'lockdep_assert_held'
>   118 |  lockdep_assert_held(&cpu_running);
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/kernel/smpboot.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
> index 8bc01f0ca73b..bbc1baa2d90c 100644
> --- a/arch/riscv/kernel/smpboot.c
> +++ b/arch/riscv/kernel/smpboot.c
> @@ -115,7 +115,6 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>                   task_stack_page(tidle) + THREAD_SIZE);
>         WRITE_ONCE(__cpu_up_task_pointer[hartid], tidle);
>
> -       lockdep_assert_held(&cpu_running);
>         wait_for_completion_timeout(&cpu_running,
>                                             msecs_to_jiffies(1000));
>
> --
> 2.26.0
>
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
