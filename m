Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B01DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A35D82065C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 00:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ef/7kJ1O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733099AbgENAWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 20:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732847AbgENAWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 20:22:12 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E424C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:22:12 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id v26so856494vsa.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ar6IwW9xd9CUZqFR53TmmUgiYezSnsTH5c4aEJicFwY=;
        b=Ef/7kJ1OgQsBcYpqbjKZ80BhEPfGQ8T9NYpeCZF59s3/0hMpMXJml0o+s1v92bHvKY
         QDlxZ4CnYPvspa+kIKFiyrzrTdxHTL207udAMd/8wY3VIp6nrIh6R2lN3X1eDX2PeoVO
         qoJUGpC8qzQpxqEOhoWeJs6B7skgnSLpXzZKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ar6IwW9xd9CUZqFR53TmmUgiYezSnsTH5c4aEJicFwY=;
        b=n1SE/V8aBhLWavnZKS6qMBexVKKKE7tJ3CgJ0fc/4Wy2AMITyWG1+fReQHUDQak8XA
         xgIEPev+kkTGFlIJgh+wj/uDMVWELFb6FDjRH5QylzD0fM4lrSc3Nhl+ivSCzVzWLaeR
         n8ZVIzKsqsV7zzlSovSk6hPWLc5HIS0uhy/sgiPw1auyy/d27E9SesrI39XmMpkEAOaO
         dHuc6FJEvpDXToD2BjWErz1PCXcQSwN9dzwzbi5P3NUbCa/CPvTKxPx07gEqsU6TssAE
         Ugcsj7llC/M56v8JVk10si0AoOH4YIr/8mPm8zcbSa6A/7unYXAofUkpsiqu1itrdnHn
         9PpA==
X-Gm-Message-State: AOAM531y42RQQUmFn8N6+Dz8hbYGLc0V4SVk0AH36Slx8Lj1TErmTwpA
        CjFV/a9CuFnMz6oVPu2HgVGBfeDVG+Y=
X-Google-Smtp-Source: ABdhPJw2+qTjC58C6E/qn2v05o9KbCxHT6ICdyIfVH2H634Hl2EyhARc8w1aFDDaKw/5HtWPvdD16g==
X-Received: by 2002:a67:d81b:: with SMTP id e27mr1564953vsj.40.1589415730766;
        Wed, 13 May 2020 17:22:10 -0700 (PDT)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com. [209.85.217.44])
        by smtp.gmail.com with ESMTPSA id v16sm340442vsq.18.2020.05.13.17.22.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2020 17:22:09 -0700 (PDT)
Received: by mail-vs1-f44.google.com with SMTP id 62so963607vsi.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 17:22:09 -0700 (PDT)
X-Received: by 2002:a67:f5d6:: with SMTP id t22mr1506572vso.73.1589415729146;
 Wed, 13 May 2020 17:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200509214159.19680-1-liwei391@huawei.com> <20200509214159.19680-4-liwei391@huawei.com>
In-Reply-To: <20200509214159.19680-4-liwei391@huawei.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 May 2020 17:21:58 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xkhs6eivpp7+r0qyfgbBgpSiHpwNY8o=JDBwYSBWadJA@mail.gmail.com>
Message-ID: <CAD=FV=Xkhs6eivpp7+r0qyfgbBgpSiHpwNY8o=JDBwYSBWadJA@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: kgdb: Fix single-stepping into the irq handler wrongly
To:     Wei Li <liwei391@huawei.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Miller <davem@davemloft.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, liwei1412@163.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, May 9, 2020 at 6:49 AM Wei Li <liwei391@huawei.com> wrote:
>
> After the single-step exception handling oops is fixed, when we execute
> single-step in kdb/kgdb, we may see it jumps to the irq_handler (where
> PSTATE.D is cleared) instead of the next instruction.
>
> Add the prepare and cleanup work for single-step when enabling and
> disabling to maintain the PSTATE.I and PSTATE.D carefully.
>
> Before this patch:
> * kdb:
> Entering kdb (current=0xffff8000119e2dc0, pid 0) on processor 0 due to Keyboard Entry
> [0]kdb> bp printk
> Instruction(i) BP #0 at 0xffff8000101486cc (printk)
>     is enabled   addr at ffff8000101486cc, hardtype=0 installed=0
>
> [0]kdb> g
>
> / # echo h > /proc/sysrq-trigger
>
> Entering kdb (current=0xffff0000fada65c0, pid 267) on processor 0 due to Breakpoint @ 0xffff8000101486cc
> [0]kdb> ss
>
> Entering kdb (current=0xffff0000fada65c0, pid 267) on processor 0 due to SS trap @ 0xffff800010082ab8
> [0]kdb> 0xffff800010082ab8
> 0xffff800010082ab8 = 0xffff800010082ab8 (el1_irq+0x78)
> [0]kdb>
>
>    0xffff800010082ab0 <+112>:   nop
>    0xffff800010082ab4 <+116>:   msr     daifclr, #0xd
>    0xffff800010082ab8 <+120>:   adrp    x1, 0xffff8000113a7000 <cpu_ops+1288>
>    0xffff800010082abc <+124>:   ldr     x1, [x1, #1408]
>
> * kgdb:
> (gdb) target remote 127.1:23002
> Remote debugging using 127.1:23002
> arch_kgdb_breakpoint () at /home/liwei/main_code/linux/arch/arm64/include/asm/kgdb.h:21
> 21              asm ("brk %0" : : "I" (KGDB_COMPILED_DBG_BRK_IMM));
> (gdb) b printk
> Breakpoint 1 at 0xffff8000101486cc: file /home/liwei/main_code/linux/kernel/printk/printk.c, line 2076.
> (gdb) c
> Continuing.
> [New Thread 287]
> [Switching to Thread 283]
>
> Thread 177 hit Breakpoint 1, printk (fmt=0xffff80001130c9d8 "\001\066sysrq: HELP : ")
>     at /home/liwei/main_code/linux/kernel/printk/printk.c:2076
> 2076    {
> (gdb) stepi
> el1_irq () at /home/liwei/main_code/linux/arch/arm64/kernel/entry.S:608
> 608             irq_handler
> (gdb)
>
> After this patch:
> * kdb:
> Entering kdb (current=0xffff8000119d2dc0, pid 0) on processor 0 due to Keyboard Entry
> [0]kdb> bp printk
> Instruction(i) BP #0 at 0xffff80001014874c (printk)
>     is enabled   addr at ffff80001014874c, hardtype=0 installed=0
>
> [0]kdb> g
>
> / # echo h > /proc/sysrq-trigger
>
> Entering kdb (current=0xffff0000fa6948c0, pid 265) on processor 0 due to Breakpoint @ 0xffff80001014874c
> [0]kdb> ss
>
> Entering kdb (current=0xffff0000fa6948c0, pid 265) on processor 0 due to SS trap @ 0xffff800010148750
> [0]kdb>
>
> * kgdb:
> (gdb) target remote 127.1:23002
> Remote debugging using 127.1:23002
> arch_kgdb_breakpoint () at /home/liwei/main_code/linux/arch/arm64/include/asm/kgdb.h:21
> 21              asm ("brk %0" : : "I" (KGDB_COMPILED_DBG_BRK_IMM));
> (gdb) b printk
> Breakpoint 1 at 0xffff80001014874c: file /home/liwei/main_code/linux/kernel/printk/printk.c, line 2076.
> (gdb) c
> Continuing.
> [New Thread 277]
> [Switching to Thread 276]
>
> Thread 171 hit Breakpoint 1, printk (fmt=0xffff8000112fc130 "\001\066sysrq: HELP : ")
>     at /home/liwei/main_code/linux/kernel/printk/printk.c:2076
> 2076    {
> (gdb) stepi
> 0xffff800010148750      2076    {
> (gdb)
>
> Fixes: 44679a4f142b ("arm64: KGDB: Add step debugging support")
> Signed-off-by: Wei Li <liwei391@huawei.com>
> ---
>  arch/arm64/kernel/kgdb.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
> index 1a157ca33262..3910ac06c261 100644
> --- a/arch/arm64/kernel/kgdb.c
> +++ b/arch/arm64/kernel/kgdb.c
> @@ -100,6 +100,8 @@ struct dbg_reg_def_t dbg_reg_def[DBG_MAX_REG_NUM] = {
>         { "fpcr", 4, -1 },
>  };
>
> +static DEFINE_PER_CPU(unsigned long, kgdb_ss_flags);
> +
>  char *dbg_get_reg(int regno, void *mem, struct pt_regs *regs)
>  {
>         if (regno >= DBG_MAX_REG_NUM || regno < 0)
> @@ -200,8 +202,11 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
>                 /*
>                  * Received continue command, disable single step
>                  */
> -               if (kernel_active_single_step())
> +               if (kernel_active_single_step()) {
> +                       kernel_cleanup_single_step(per_cpu(kgdb_ss_flags,
> +                                       raw_smp_processor_id()), linux_regs);

I don't think you need the raw_ version of smp_processor_id(), do you?


-Doug
