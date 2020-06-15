Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A91FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:46:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3751D2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 22:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592261176;
	bh=g+es2wRdd6OfsBGwlF+KXjC8dXEfPRX3KCkljPYj1kI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=d3b03Fx/MgMi4qy1JSXwvXdwUkpObwCCraBdXp/K4FpHAjulZT60wLctOZV6DV6zT
	 V/Md8NBbkKe8SGYlponI4S2zxrOW017cRj9fDPZNUIXSfxW6IAM4ekFN0Ec58nV92C
	 s59CoUhtFuxC8NUjzUoVjRgdTaovKZ+VIyvqpjj8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgFOWqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 18:46:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:58922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725960AbgFOWqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 18:46:14 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D16C2074D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 22:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592261173;
        bh=g+es2wRdd6OfsBGwlF+KXjC8dXEfPRX3KCkljPYj1kI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V5YcBOxoaOUp9WqtMqv9B6Q3WmllVWjXoPhzjEkHzCj7eBQA3GKLXrml6lyE8QPJo
         CaKmnMb/Dp1n5F06uLYYlXZRRZy2Dou97wH/3z0wrZ6I6tFI3amOce1Z1KDfScFRL5
         NF5AE0Vfc+oxIAV5V8w/Xsyig14nbexk+h5ANNLg=
Received: by mail-wr1-f44.google.com with SMTP id q11so18802850wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 15:46:13 -0700 (PDT)
X-Gm-Message-State: AOAM532cwN+mGWX/HvZzrjM0k/NWGyMree0H5nFrZQ9G2u199pbYxS+V
        SJbbGZJpTVI9BJEzD8hrL+cCaSA19XC75p9qysCLgg==
X-Google-Smtp-Source: ABdhPJzzK38Hhpi4cxwVUdqJm3iUGTYewgVcPhGh6vuIjTVr6IOtiVA7Zldem175jw8oZdcV0XlerTfMpGjp0AG4kpE=
X-Received: by 2002:adf:ea11:: with SMTP id q17mr30345939wrm.75.1592261172100;
 Mon, 15 Jun 2020 15:46:12 -0700 (PDT)
MIME-Version: 1.0
References: <f8fe40e0088749734b4435b554f73eee53dcf7a8.1591932307.git.luto@kernel.org>
 <159199140855.16989.18012912492179715507.tip-bot2@tip-bot2>
 <20200615145018.GU2531@hirez.programming.kicks-ass.net> <CALCETrWhbg_61CTo9_T6s1NDFvOgUx7ebSzhXj7O_m8htePwKA@mail.gmail.com>
 <20200615194458.GL2531@hirez.programming.kicks-ass.net> <CALCETrUbwwoYTzyntr=bUjJU44iyt+S8bRS04OxmByP3aD4A9g@mail.gmail.com>
 <20200615222330.GI2514@hirez.programming.kicks-ass.net>
In-Reply-To: <20200615222330.GI2514@hirez.programming.kicks-ass.net>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 15 Jun 2020 15:46:00 -0700
X-Gmail-Original-Message-ID: <CALCETrXisDDMb_eaPDq1DWrMuSqo1hDrOd14u7fSR4J_RxJu_A@mail.gmail.com>
Message-ID: <CALCETrXisDDMb_eaPDq1DWrMuSqo1hDrOd14u7fSR4J_RxJu_A@mail.gmail.com>
Subject: Re: [tip: x86/entry] x86/entry: Treat BUG/WARN as NMI-like entries
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 3:23 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jun 15, 2020 at 02:08:16PM -0700, Andy Lutomirski wrote:
>
> > > All !user exceptions really should be NMI-like. If you want to go
> > > overboard, I suppose you can look at IF and have them behave interrupt
> > > like when set, but why make things complicated.
> >
> > This entire rabbit hole opened because of #PF. So we at least need the
> > set of exceptions that are permitted to schedule if they came from
> > kernel mode to remain schedulable.
>
> What exception, other than #PF, actually needs to schedule from kernel?
>
> > Prior to the giant changes, all the non-IST *exceptions*, but not the
> > interrupts, were schedulable from kernel mode, assuming the original
> > context could schedule. Right now, interrupts can schedule, too, which
> > is nice if we ever want to fully clean up the Xen abomination. I
> > suppose we could make it so #PF opts in to special treatment again,
> > but we should decide that the result is simpler or otherwise better
> > before we do this.
> >
> > One possible justification would be that the schedulable entry variant
> > is more complicated, and most kernel exceptions except the ones with
> > fixups are bad news, and we want the oopses to succeed. But page
> > faults are probably the most common source of oopses, so this is a bit
> > weak, and we really want page faults to work even from nasty contexts.
>
> I think I'd prefer the argument of consistent failure.
>
> Do we ever want #UD to schedule? If not, then why allow it to sometimes
> schedule and sometimes fail, better to always fail.
>
> #DB is still a giant trainwreck in this regard as well.
>
> Something like this...
>
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -216,10 +216,25 @@ static inline void handle_invalid_op(str
>                       ILL_ILLOPN, error_get_trap_addr(regs));
>  }
>
> -DEFINE_IDTENTRY_RAW(exc_invalid_op)
> +static void handle_invalid_op_kernel(struct pt_regs *regs)
> +{
> +       if (is_valid_bugaddr(regs->ip) &&
> +           report_bug(regs->ip, regs) == BUG_TRAP_TYPE_WARN) {
> +               /* Skip the ud2. */
> +               regs->ip += LEN_UD2;
> +               return;
> +       }
> +
> +       handle_invalid_op(regs);
> +}
> +
> +static void handle_invalid_op_user(struct pt_regs *regs)
>  {
> -       bool rcu_exit;
> +       handle_invalid_op(regs);
> +}
>
> +DEFINE_IDTENTRY_RAW(exc_invalid_op)
> +{

Meh, I guess I'm okay with this.

In some sense, #UD and #PF are fundamentally different.  #PF wants to
be able to schedule in the kernel.  #UD wants to be as minimal as
possible in the kernel but probably still wants to do the nmi_enter()
dance in case it's an RCU warning and the warning handler code wants
to use RCU.

One solution would be to get rid of ud2 for warnings and replace it
with CALL warning_thunk :)  But I guess I'm okay with your patch.

--Andy
