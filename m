Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4FAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 04:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 944FC20792
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 04:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591935242;
	bh=iJITbY+DEttlSxTaUcGFjT9hSo+Icka2a08PNQZ0i+Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XXu76y3inDg7R2LL0aVKUf13Vc5rgoypj/Ah09FLqcTczQ3xr+GpyWOL4mzlwmhJ1
	 nfRJLhdVMT3qiiVxfciO+Rgb0ZzJWPC1YzMzt+Xiljm5USgRh8AxbHk48xxNsoNCKZ
	 ZeKpG7JfYLdYC39h2+v1rlYrzuXF+/86wuu9YBBU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgFLEOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 00:14:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:51520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgFLEOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 00:14:00 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A89A2078C
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 04:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591935239;
        bh=iJITbY+DEttlSxTaUcGFjT9hSo+Icka2a08PNQZ0i+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ch24rLAkQWnDW5bQJn04Yt2LiCiJBRyv4LN+M3ocxKjM/0JHdvnzxKWd2XJAyfW+Q
         QxT2EFDbyGRpIbAJs96v9wehB1TGdvdBVIlLb5uxAi5c2uezkVe6c7uEmjF7ixY+3Z
         /llFm7A8TZWBEGlcu8V5TxQQz2qQ+KkDPlRdaWDg=
Received: by mail-wr1-f46.google.com with SMTP id x6so8251823wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 21:13:59 -0700 (PDT)
X-Gm-Message-State: AOAM530+WiLpUyh6J45yRzYGtL6WsmaASD2WPt0HhH5wI755noYp+G2Z
        L+ejaIUjxbY+W2NtMycPwdfgQCp79MaOfScKZRMOYw==
X-Google-Smtp-Source: ABdhPJwGREheVp5xuWljvoGvBoJvs3IF9fw8nAejDtSxXaHVEH/6yQ4oasGQhUfxz7i2GVTI1XS7CtIE/7jl0eQUAhU=
X-Received: by 2002:adf:e387:: with SMTP id e7mr12559642wrm.70.1591935237960;
 Thu, 11 Jun 2020 21:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <f8fe40e0088749734b4435b554f73eee53dcf7a8.1591932307.git.luto@kernel.org>
In-Reply-To: <f8fe40e0088749734b4435b554f73eee53dcf7a8.1591932307.git.luto@kernel.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 11 Jun 2020 21:13:46 -0700
X-Gmail-Original-Message-ID: <CALCETrUE48wbHUoaha=oEZFooM3yrcCwiCYZZ0MnEBDK-JFJAw@mail.gmail.com>
Message-ID: <CALCETrUE48wbHUoaha=oEZFooM3yrcCwiCYZZ0MnEBDK-JFJAw@mail.gmail.com>
Subject: Re: [PATCH] x86/entry: Treat BUG/WARN as NMI-like entries
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 8:26 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> If we BUG or WARN in a funny RCU context, we cleverly optimize the
> BUG/WARN using the ud2 hack, which takes us through the
> idtentry_enter...() paths, which might helpfully WARN that the RCU
> context is invalid, which results in infinite recursion.
>
> Split the BUG/WARN handling into an nmi_enter()/nmi_exit() path in
> exc_invalid_op() to increase the chance that we survive the
> experience.
>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
>
> This is not as well tested as I would like, but it does cause the splat
> I'm chasing to display a nice warning instead of causing an undebuggable
> stack overflow.
>
> (It would have been debuggable on x86_64, but it's a 32-bit splat, and
> x86_32 doesn't have ORC.)
>
>  arch/x86/kernel/traps.c | 61 +++++++++++++++++++++++------------------
>  arch/x86/mm/extable.c   | 15 ++++++++--
>  2 files changed, 48 insertions(+), 28 deletions(-)
>
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index cb8c3d26cdf5..6340b12a6616 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -98,24 +98,6 @@ int is_valid_bugaddr(unsigned long addr)
>         return ud == INSN_UD0 || ud == INSN_UD2;
>  }
>
> -int fixup_bug(struct pt_regs *regs, int trapnr)
> -{
> -       if (trapnr != X86_TRAP_UD)
> -               return 0;
> -
> -       switch (report_bug(regs->ip, regs)) {
> -       case BUG_TRAP_TYPE_NONE:
> -       case BUG_TRAP_TYPE_BUG:
> -               break;
> -
> -       case BUG_TRAP_TYPE_WARN:
> -               regs->ip += LEN_UD2;
> -               return 1;
> -       }
> -
> -       return 0;
> -}
> -
>  static nokprobe_inline int
>  do_trap_no_signal(struct task_struct *tsk, int trapnr, const char *str,
>                   struct pt_regs *regs, long error_code)
> @@ -191,13 +173,6 @@ static void do_error_trap(struct pt_regs *regs, long error_code, char *str,
>  {
>         RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
>
> -       /*
> -        * WARN*()s end up here; fix them up before we call the
> -        * notifier chain.
> -        */
> -       if (!user_mode(regs) && fixup_bug(regs, trapnr))
> -               return;
> -
>         if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) !=
>                         NOTIFY_STOP) {
>                 cond_local_irq_enable(regs);
> @@ -242,9 +217,43 @@ static inline void handle_invalid_op(struct pt_regs *regs)
>                       ILL_ILLOPN, error_get_trap_addr(regs));
>  }
>
> -DEFINE_IDTENTRY(exc_invalid_op)
> +DEFINE_IDTENTRY_RAW(exc_invalid_op)
>  {
> +       bool rcu_exit;
> +
> +       /*
> +        * Handle BUG/WARN like NMIs instead of like normal idtentries:
> +        * if we bugged/warned in a bad RCU context, for example, the last
> +        * thing we want is to BUG/WARN again in the idtentry code, ad
> +        * infinitum.
> +        */
> +       if (!user_mode(regs) && is_valid_bugaddr(regs->ip)) {
> +               enum bug_trap_type type;
> +
> +               nmi_enter();
> +               instrumentation_begin();
> +               type = report_bug(regs->ip, regs);
> +               instrumentation_end();
> +               nmi_exit();

Hmm, maybe this should be:

        nmi_enter();
        instrumentation_begin();
        trace_hardirqs_off_finish();
        type = report_bug(regs->ip, regs);
        if (regs->flags & X86_EFLAGS_IF)
            trace_hardirqs_on_prepare();
        instrumentation_end();
        nmi_exit();

tglx or peterz, feel free to fix this up and apply it however you like.
