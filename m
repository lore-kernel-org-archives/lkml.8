Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1597BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22B1205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589432622;
	bh=eSoIrXRq8CBrZKnRGrrnb3YbtxM3E6Mi7lADLDfKY5o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HeYol5tr5FtgpNZzN+X8IcknuQkBwWwCj+nqwyW8H2CeR7ZWcab0hI3XgRZX3yrBE
	 7+seCEkNJM2/4QSwW2cu3wIH6JMdvThX2y8zLQOCYuN8UONFFNNAJHpml0V1F3J91g
	 5UiNo1p4gPzUXfw7U0lR1ny3C4OOiCx38UHJjQ58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgENFDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:44368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbgENFD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:03:27 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8FA90206D8
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589432606;
        bh=eSoIrXRq8CBrZKnRGrrnb3YbtxM3E6Mi7lADLDfKY5o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=n0AzjKLk+8ZuHC2LzlCRrluFY3B1MQ0sRkehqYZrnRq1YAMdsSUKmFs8WxoWboQ6H
         Lrc6FlrQ5MbQtuv3O58k4xC5+ylMfMudxT0iBnUPIwiRxLX5Kuozu3soYIYgjIFXdh
         zVpW9aCchrOLVM7vMHTgaQv5fbtLVlfaXel/C6TY=
Received: by mail-wr1-f46.google.com with SMTP id y3so2172393wrt.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 22:03:26 -0700 (PDT)
X-Gm-Message-State: AOAM533d9KuqQykfJJtbQvGwNN+2xuyGqssmVowMfvNaYPDOVYfDNk6L
        VclhGDhfvbeTmpd9wRLM5aVIuF+7H6Xuxi73feNFow==
X-Google-Smtp-Source: ABdhPJwxTq7MCR4y6j0aJ7V+k/VS/cb9GOeV6aASuImrFvBrWMBXvhCQftHOU+JglHCGL4JMXSo02TwWzMaP5sza9oQ=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr3048318wrs.257.1589432604940;
 Wed, 13 May 2020 22:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135314.045220765@linutronix.de>
In-Reply-To: <20200505135314.045220765@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 22:03:13 -0700
X-Gmail-Original-Message-ID: <CALCETrUwwKG_JZH6NWP5WMT0B3YzhwviBxyDM5FWeMC86cNrQw@mail.gmail.com>
Message-ID: <CALCETrUwwKG_JZH6NWP5WMT0B3YzhwviBxyDM5FWeMC86cNrQw@mail.gmail.com>
Subject: Re: [patch V4 part 4 07/24] x86/traps: Split int3 handler up
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> For code simplicity split up the int3 handler into a kernel and user part
> which makes the code flow simpler to understand.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/kernel/traps.c |   67 +++++++++++++++++++++++++++---------------------
>  1 file changed, 39 insertions(+), 28 deletions(-)
>
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -564,6 +564,35 @@ DEFINE_IDTENTRY_ERRORCODE(exc_general_pr
>         cond_local_irq_disable(regs);
>  }
>
> +static bool do_int3(struct pt_regs *regs)
> +{
> +       int res;
> +
> +#ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
> +       if (kgdb_ll_trap(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
> +                        SIGTRAP) == NOTIFY_STOP)
> +               return true;
> +#endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */
> +
> +#ifdef CONFIG_KPROBES
> +       if (kprobe_int3_handler(regs))
> +               return true;
> +#endif
> +       res = notify_die(DIE_INT3, "int3", regs, 0, X86_TRAP_BP, SIGTRAP);
> +
> +       return res == NOTIFY_STOP;
> +}
> +
> +static void do_int3_user(struct pt_regs *regs)
> +{
> +       if (do_int3(regs))
> +               return;
> +
> +       cond_local_irq_enable(regs);
> +       do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, 0, 0, NULL);
> +       cond_local_irq_disable(regs);
> +}
> +
>  DEFINE_IDTENTRY_RAW(exc_int3)
>  {
>         /*
> @@ -581,37 +610,19 @@ DEFINE_IDTENTRY_RAW(exc_int3)
>          * because the INT3 could have been hit in any context including
>          * NMI.
>          */
> -       if (user_mode(regs))
> +       if (user_mode(regs)) {
>                 idtentry_enter(regs);
> -       else
> -               nmi_enter();
> -
> -       instr_begin();
> -#ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
> -       if (kgdb_ll_trap(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
> -                               SIGTRAP) == NOTIFY_STOP)
> -               goto exit;
> -#endif /* CONFIG_KGDB_LOW_LEVEL_TRAP */
> -
> -#ifdef CONFIG_KPROBES
> -       if (kprobe_int3_handler(regs))
> -               goto exit;
> -#endif
> -
> -       if (notify_die(DIE_INT3, "int3", regs, 0, X86_TRAP_BP,
> -                       SIGTRAP) == NOTIFY_STOP)
> -               goto exit;
> -
> -       cond_local_irq_enable(regs);
> -       do_trap(X86_TRAP_BP, SIGTRAP, "int3", regs, 0, 0, NULL);
> -       cond_local_irq_disable(regs);
> -
> -exit:
> -       instr_end();
> -       if (user_mode(regs))
> +               instr_begin();
> +               do_int3_user(regs);
> +               instr_end();
>                 idtentry_exit(regs);
> -       else
> +       } else {
> +               nmi_enter();
> +               instr_begin();
> +               do_int3(regs);

I think you should be checking the return value here.  Presumably this
should die() if it's not handled, since otherwise it will just
infinite loop.

> +               instr_end();
>                 nmi_exit();
> +       }
>  }
>
>  #ifdef CONFIG_X86_64
>
