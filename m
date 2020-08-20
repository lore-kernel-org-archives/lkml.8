Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60333C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 315CA20724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DSu7JXl3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgHTOpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgHTOpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:45:25 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA385C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:45:24 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id c6so1810868ilo.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tDfRK/hRb50SBa/YfwtS0QLSZRN8RYBkCqh1wYa24DE=;
        b=DSu7JXl3ojQR/Gb1WAviBwuEbFrWCclvIF09S10oTI8uKkqCXJx/DwZ7nFjbtUY52E
         6x13uGTCMKmajploAewFnPq/7PoYOJLcnW5CXfHF7Nd1m45h4kJ8l2nvtjg0rVE3OFE0
         9NV0oLGV+7a+OWlw5VMN7k4JiVmC5tCtRsKNiadxXPrmjid0Gn1/KaWdgrULzdHnX6lT
         Io4I7waHYhZobZhLatwhuEGaNoa6H0jQ9EWIpgZaHZiaYsLeVe4YjFaIQfc47VjgQcrY
         3fZjgbMAd8PK3PN9Jg1UX5JtLMMfiMQttkxMNdCrqcSTshR17w9aoMdWiP7I9rIV5bn/
         z5sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tDfRK/hRb50SBa/YfwtS0QLSZRN8RYBkCqh1wYa24DE=;
        b=CiWiJXtECFQWj5Tisu4LeXTPBy4HQPCj4AM+lkl4R/WOxmGBl0jPfFU92gqwmUNtV3
         QOwjL0SIlWv8RBoIYFDj135KWyxK8YgGL57zpCJ8njK4JdV33Rp+JBGhvc6U6ob+y2oU
         raKVmdg115vXgvTUGP4/EsDAZZVAXnZxc/82lwmucuZAwfIVXIGJC0HDg8KsqbIDAKOT
         Oe8NtHzDn3RYtnMIYACQpcRovML1vxcAW3zBF+S89JHqJdg5CPoRN88h2+QbkqzaOo5T
         emndqpWSTaAVp5XoAXM/YBnwgeZUBF7eKdRi8GjJL5BIfpSOr/hE5BEEZPmZMZkg62+c
         h/Yw==
X-Gm-Message-State: AOAM53095hfsbxghdsnAy6Xy5las4Hw2yCFSs+nuu5y+ELmVSUtCiz4B
        WU9y/0HCxYk8z/OO0ZqPX+Sgy4LhoThPWNcMDg==
X-Google-Smtp-Source: ABdhPJwxfrQ3sKYc6/szIJaqvGzef/q85eIYwBTNBXuy4AaXEEKX0hYL7wd4LpeZE5xM3g9qRK3+r5XXFGsO7X+7HN4=
X-Received: by 2002:a92:b611:: with SMTP id s17mr2777377ili.191.1597934724050;
 Thu, 20 Aug 2020 07:45:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200820103832.486877479@infradead.org> <20200820104905.294802764@infradead.org>
In-Reply-To: <20200820104905.294802764@infradead.org>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 20 Aug 2020 10:45:12 -0400
Message-ID: <CAMzpN2gmCu0q_8gLAOcSuLjpKF+rNj=wiCFsGZXgNwz000HCvg@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/7] x86/debug: Move historical SYSENTER junk into exc_debug_kernel()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 6:53 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/traps.c |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -820,18 +820,6 @@ static void handle_debug(struct pt_regs
>                 goto out;
>         }
>
> -       if (WARN_ON_ONCE((dr6 & DR_STEP) && !user_mode(regs))) {
> -               /*
> -                * Historical junk that used to handle SYSENTER single-stepping.
> -                * This should be unreachable now.  If we survive for a while
> -                * without anyone hitting this warning, we'll turn this into
> -                * an oops.
> -                */
> -               tsk->thread.debugreg6 &= ~DR_STEP;
> -               set_tsk_thread_flag(tsk, TIF_SINGLESTEP);
> -               regs->flags &= ~X86_EFLAGS_TF;
> -       }
> -
>         si_code = get_si_code(tsk->thread.debugreg6);
>         if (tsk->thread.debugreg6 & (DR_STEP | DR_TRAP_BITS) || user_icebp)
>                 send_sigtrap(regs, 0, si_code);
> @@ -874,6 +862,18 @@ static __always_inline void exc_debug_ke
>         if (kprobe_debug_handler(regs))
>                 goto out;
>
> +       if (WARN_ON_ONCE(dr6 & DR_STEP)) {
> +               /*
> +                * Historical junk that used to handle SYSENTER single-stepping.
> +                * This should be unreachable now.  If we survive for a while
> +                * without anyone hitting this warning, we'll turn this into
> +                * an oops.
> +                */
> +               dr6 &= ~DR_STEP;
> +               set_thread_flag(TIF_SINGLESTEP);
> +               regs->flags &= ~X86_EFLAGS_TF;
> +       }
> +
>         handle_debug(regs, dr6, false);
>
>  out:

Can this be removed or changed to a BUG()?  The warning has been there
since 2016 and nobody has apparently complained about it.

--
Brian Gerst
