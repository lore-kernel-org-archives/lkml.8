Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0831C04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4022246C3
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ijqx7MgM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBGPSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:18:31 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:33835 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGPSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:18:31 -0500
Received: by mail-yb1-f196.google.com with SMTP id w17so1412724ybm.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 07:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nFsoOSwL9YbwXaTDXlHQ5VoCRQV0nAn2vPNJKXbJcGU=;
        b=Ijqx7MgMTJgA2Zs0AZ9OYA7xm0i7YTRtbow5+VmzNbGcNc8adWDbkUIOTp9arzhY58
         BOB8I/6z2TQYHdmRB/RIe4WUY2xDd+p+lte9CinqmvkeJDbY7gVZ9aoYnlfxZxpQ1MMf
         m9ytl7/TkiFvkxx/xWl2zrdW13ZkFMMXtWV5aRz46dDbOv5y0whs7cmc/EBpvu4ZG+Q1
         5hnEo3tzAiK2sAkUHy7Yg5dNBapb8j8KSOBL9C7Ozmy4UiSsbLo5fzfs5xDoCL+weMtd
         9EAQxLDIIx4BsQhD3ULwgUslYNMWYJAX3RZ0lj+eJFCx6geNNfCJkdoYWFm0GhnvkgA9
         q/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nFsoOSwL9YbwXaTDXlHQ5VoCRQV0nAn2vPNJKXbJcGU=;
        b=N16HHuAXVrBfE/AYFnkZqjdB/nfeym5nGLnTVJ870ZJIl1T1BNUsn3rTwWMWk3AWDF
         WguO4UD3UZaMsjnz0jtfWkS0rCkftCcQ/PNRF3fcWZQfPW1yegnRSjbNfV1MOvaQb/49
         3x4xmnNDmXfQGmW8RerdxSF5PqxiVrHZU03k8yPV6luvVZd2SQ0p8vX4hfzTxJlepHWD
         p/Os7svTwfI5FcD6ZQCrJIgXR7pvkhjTN12GlyRHRMO9cYpxzevnbnLAWJr77BdOkMk9
         Ds/DoaQDuw7FIYMRfmKjEhrCZsKbR09q0+hKnuP2tAAvSaF/THlqf7Mm+Pd4FEhN7Dlw
         rf+Q==
X-Gm-Message-State: APjAAAUE26txBZiIshZFonSxtfHr2p9AUfStE2i8cMIZ9TGaCUrzeI/D
        t4GlF77aL86JPUydnfkrCK9wQkdlNFJnNXQCo4VqWw==
X-Google-Smtp-Source: APXvYqxNNa5WVr6tDVQ5+kY8QCx69tm+gnrj+/GdtvNWv1dsvL/OQIIdovJljB9ggBjXAxC+SpjJMphhUujpYgsgesw=
X-Received: by 2002:a25:d9d4:: with SMTP id q203mr9392649ybg.274.1581088709627;
 Fri, 07 Feb 2020 07:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20200207043836.106657-1-edumazet@google.com> <87tv42xxr5.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87tv42xxr5.fsf@nanos.tec.linutronix.de>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 7 Feb 2020 07:18:18 -0800
Message-ID: <CANn89i+mo08vK3ejvmn7DxvHEkAox4Xpm9Dm5hGc=9-+Xwxi4g@mail.gmail.com>
Subject: Re: [PATCH] x86/traps: do not hash pointers in handle_stack_overflow()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 7, 2020 at 6:44 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > Mangling stack pointers in handle_stack_overflow() is moot,
> > as registers (including RSP/RBP) are clear anyway.
> >
> > BUG: stack guard page was hit at 0000000063381e80 (stack is
> > 000000008edc5696..0000000012256c50)
>
> To illustrate your argument above it would be useful to provide the post
> patch output as well.

Unfortunately this KASAN report has no repro yet. I have no idea what
triggered the fault ;)

>
> > kernel stack overflow (double-fault): 0000 [#1] PREEMPT SMP KASAN
> > ...
> > RSP: 0018:ffffc90002c1ffc0 EFLAGS: 00010802
> > RAX: 1ffff11004a0094c RBX: ffff888025004180 RCX: c9d82d1007bb146c
> > RDX: dffffc0000000000 RSI: ffff888025004a40 RDI: ffff888025004180
> > RBP: ffffc90002c201c0 R08: dffffc0000000000 R09: fffffbfff1405915
> > R10: fffffbfff1405915 R11: 0000000000000000 R12: ffff888025004a60
> > R13: ffff888025004a10 R14: c9d82d1007bb146c R15: ffff888025004180
> > ...
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > ---
> >  arch/x86/kernel/traps.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 6ef00eb6fbb925e86109f86845e2b3ccef4023ec..44873df292bd3f9f77bb721c53cb8a1c40994cca 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -296,7 +296,7 @@ __visible void __noreturn handle_stack_overflow(const char *message,
> >                                               struct pt_regs *regs,
> >                                               unsigned long fault_address)
> >  {
> > -     printk(KERN_EMERG "BUG: stack guard page was hit at %p (stack is %p..%p)\n",
> > +     printk(KERN_EMERG "BUG: stack guard page was hit at %px (stack
> > is %px..%px)\n",
>
> While touching this, can you please switch it to pr_emerg() ?
>


Sure I will, thanks.
