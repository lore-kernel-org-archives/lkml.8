Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F36C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F5520786
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597668459;
	bh=F6AeSzf4yODe5VfS/mOvvXXrmYEDiPf8ncHRYGsJH9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=yrzLsfqEhiNwH+9aOXovAH/Ish/1bBMXQbdqyUUkqpI6ScKYiSeL6CKtvQV9z6azc
	 SdzODf7Fw01j0TiEQbFx07rCh77abInJBFxY7F1bIMKUFL9rLyVsX8nHJnLsKNmhsP
	 SORGQ4TldlcFdbiiEo90UaKkJrH5BHgbGkiNMNlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgHQMri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:47:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbgHQMrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:47:37 -0400
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09A2A2078D;
        Mon, 17 Aug 2020 12:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597668456;
        bh=F6AeSzf4yODe5VfS/mOvvXXrmYEDiPf8ncHRYGsJH9o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WLGovId1pF0RtoS/pxVhAbmTDQxL+wlb/YPyjGm4gwU7EG0HpRde71z58372pAGUI
         Mk7gmvMtdYHyCuhuPVYr4Pyx7oBmnbh5hBitrBnQEaY0aHR0Q7DRVQHu/ZXD3RYk4h
         ZjAMCDf1SsweOIV20FDlQU218t5SISXQewIF1Xjo=
Received: by mail-lj1-f179.google.com with SMTP id h19so17298517ljg.13;
        Mon, 17 Aug 2020 05:47:35 -0700 (PDT)
X-Gm-Message-State: AOAM532oqzzG5LP9YEUrK2IZP8tpsDMZcUPpohezb42zbSVCSt0TzE4J
        Yr6UXzWlaMlVjN6FRh5PIq4hUnJAjDtwgDZCwss=
X-Google-Smtp-Source: ABdhPJw1v8JVnt2oJ6bSCPU4EmN7bm2mGdNOp7Vx6uxxuEJFPNSCeEfTKhQjsXzu5H3BmOMqhHgKjHmNPG6tmd7ZCYE=
X-Received: by 2002:a2e:9bc1:: with SMTP id w1mr6581503ljj.79.1597668454259;
 Mon, 17 Aug 2020 05:47:34 -0700 (PDT)
MIME-Version: 1.0
References: <1594683562-68149-4-git-send-email-guoren@kernel.org> <mhng-296dd63e-71de-4d30-acfb-df374d12388d@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-296dd63e-71de-4d30-acfb-df374d12388d@palmerdabbelt-glaptop1>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 17 Aug 2020 20:47:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTz_EFpzMoT3yBgCNTNme9_QbQ9b2dGZB3S0F5+O6Fpyw@mail.gmail.com>
Message-ID: <CAJF2gTTz_EFpzMoT3yBgCNTNme9_QbQ9b2dGZB3S0F5+O6Fpyw@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] riscv: Fixup kprobes handler couldn't change pc
To:     Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anup Patel <anup@brainfault.org>, linux-csky@vger.kernel.org,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        =?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>,
        Bjorn Topel <bjorn.topel@gmail.com>,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 15, 2020 at 6:36 AM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Mon, 13 Jul 2020 16:39:18 PDT (-0700), guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The "Changing Execution Path" section in the Documentation/kprobes.txt
> > said:
> >
> > Since kprobes can probe into a running kernel code, it can change the
> > register set, including instruction pointer.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > ---
> >  arch/riscv/kernel/mcount-dyn.S | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> > index 35a6ed7..4b58b54 100644
> > --- a/arch/riscv/kernel/mcount-dyn.S
> > +++ b/arch/riscv/kernel/mcount-dyn.S
> > @@ -123,6 +123,7 @@ ENDPROC(ftrace_caller)
> >       sd      ra, (PT_SIZE_ON_STACK+8)(sp)
> >       addi    s0, sp, (PT_SIZE_ON_STACK+16)
> >
> > +     sd ra,  PT_EPC(sp)
> >       sd x1,  PT_RA(sp)
> >       sd x2,  PT_SP(sp)
> >       sd x3,  PT_GP(sp)
>
> So that's definately not going to be EPC any more.  I'm not sure that field is
> sanely named, though, as it's really just the PC when it comes to other ptrace
> stuff.
>
> > @@ -157,6 +158,7 @@ ENDPROC(ftrace_caller)
> >       .endm
> >
> >       .macro RESTORE_ALL
> > +     ld ra,  PT_EPC(sp)
> >       ld x1,  PT_RA(sp)
>
> x1 is ra, so loading it twice doesn't seem reasonable.
>
> >       ld x2,  PT_SP(sp)
> >       ld x3,  PT_GP(sp)
> > @@ -190,7 +192,6 @@ ENDPROC(ftrace_caller)
> >       ld x31, PT_T6(sp)
> >
> >       ld      s0, (PT_SIZE_ON_STACK)(sp)
> > -     ld      ra, (PT_SIZE_ON_STACK+8)(sp)
> >       addi    sp, sp, (PT_SIZE_ON_STACK+16)
> >       .endm
>
> If you're dropping the load you should drop the store above as well.  In
> general this seems kind of mixed up, both before and after this patch.

This is a wrong patch, it should be:

diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index 35a6ed7..d82b8f0 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -120,10 +120,10 @@ ENDPROC(ftrace_caller)
        .macro SAVE_ALL
        addi    sp, sp, -(PT_SIZE_ON_STACK+16)
        sd      s0, (PT_SIZE_ON_STACK)(sp)
-       sd      ra, (PT_SIZE_ON_STACK+8)(sp)
        addi    s0, sp, (PT_SIZE_ON_STACK+16)

-       sd x1,  PT_RA(sp)
+       sd ra,  PT_EPC(sp)
+       sd ra,  PT_RA(sp)
        sd x2,  PT_SP(sp)
        sd x3,  PT_GP(sp)
        sd x4,  PT_TP(sp)
@@ -157,7 +157,7 @@ ENDPROC(ftrace_caller)
        .endm

        .macro RESTORE_ALL
-       ld x1,  PT_RA(sp)
+       ld ra,  PT_EPC(sp)
        ld x2,  PT_SP(sp)
        ld x3,  PT_GP(sp)
        ld x4,  PT_TP(sp)
@@ -190,7 +190,6 @@ ENDPROC(ftrace_caller)
        ld x31, PT_T6(sp)

        ld      s0, (PT_SIZE_ON_STACK)(sp)
-       ld      ra, (PT_SIZE_ON_STACK+8)(sp)
        addi    sp, sp, (PT_SIZE_ON_STACK+16)
        .endm

Now, I'm developing livepatch and they are so mixed features (kprobe,
livepatch, ftrace, optprobes, STACK_WALK, -fpatchable-function-entry
'no -pg'). I'll test this patch in the next version of the patchset.

Thx for the review.

-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
