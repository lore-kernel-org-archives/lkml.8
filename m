Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5B4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C01E4206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:33:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhtQBufT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgHJWdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgHJWde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:33:34 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177E0C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 15:33:34 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d188so6534256pfd.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 15:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i7ZfdynehOdybqijT/Iim3hOWf1+yvwIpK/H7v550UQ=;
        b=mhtQBufTPANHwJt2YnyJ/vLi8+sR6/jg0gf8krTkW7x+L/KIh2eF3Y25ypKQKj9eWQ
         tgbLDbBM6IE0m6FyEMSx9Lf8gKi71rjxKVxlh3QgXE0PD70t5TUELjSWWcr5FzHWft0p
         fWjKTYUFd1tCnYomCDpU5Yqyob35Egp5DlfkjDxCOKcqU60ZTJ0HqbJ5sfR2yQtWnyHy
         jKM+WiclhG925nM7/r3iiPEa8WPWjOP4ajTCyse9YDiMGVgHVi3YwcBU4yyPWBXUtBV6
         aC2kcORjgG0XDv3MmSZfNNvxhdZO+QvJ9aeXFO4p1uX7Dl+iIDUCvT1cLvyyyZdT/8IK
         KfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i7ZfdynehOdybqijT/Iim3hOWf1+yvwIpK/H7v550UQ=;
        b=s3PIZ/GjIkXUp5ww2f+1ecdnLcoCYoSjPDkQk7SKT8z6PHYB+slf/kQl/jPVU+KE4e
         h9OEWG3KG72fOXoSmvUc87zuc7PETsJbGk6CuX4OfOfww/4zG8Pu68uip9h+4WjWwRxm
         di2ctPKDDOyAq1+shKW8K2QDk6VlPmGDL6UkCmuFDT7Gj6DWFNih0SPFYfGzIjhMGOW7
         aekkEB+cihWNbiQ/3i3LLa2ogX+rFAjD50lXPl1N372xYOAUHUrMbd2o3NmAPkb6KZf5
         LxKsiCIGSbybhuEZQ0GPIIZJzLiY1KcVCVsau01v7HXV4Rnheeki3rQtkF0uB7Bnom0W
         j0zA==
X-Gm-Message-State: AOAM5321l8Ht/D3Q5BDqUax7XRmTEcZ7IMxaonIbo+dt7afyRLCKiwEk
        NKgU5rqkYlzAjp9t1FQvd2c+MPvhWC7Cgx5u2SRnlg==
X-Google-Smtp-Source: ABdhPJzXTvIZAHfH9jpUrtK3vUE/qI8VWhuaoQktb5lbMLN9zEI8agpeALqtVf0qPpZVQ0WKCLyimURi+ymlHxcwJLA=
X-Received: by 2002:a63:4e56:: with SMTP id o22mr8537935pgl.381.1597098813343;
 Mon, 10 Aug 2020 15:33:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200730205112.2099429-1-ndesaulniers@google.com>
 <20200730205112.2099429-3-ndesaulniers@google.com> <CAN=-Rxty=Ux5rj-VQSZH-ryj1RiNJvy7mRE7uyx_YAndGtcq7Q@mail.gmail.com>
In-Reply-To: <CAN=-Rxty=Ux5rj-VQSZH-ryj1RiNJvy7mRE7uyx_YAndGtcq7Q@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 10 Aug 2020 15:33:22 -0700
Message-ID: <CAKwvOdkNLK2cRfY+DA0u3KuY5PuEss5Qox6X3zzpL053pARfrA@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: backtrace-clang: add fixup for lr dereference
To:     Nathan Huckleberry <nhuck15@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Lvqiang Huang <lvqiang.huang@unisoc.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 3:39 PM Nathan Huckleberry <nhuck15@gmail.com> wrote:
>
> Mostly looks good to me. Just a minor nit.
>
> On Thu, Jul 30, 2020 at 3:51 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > If the value of the link register is not correct (tail call from asm
> > that didn't set it, stack corruption, memory no longer mapped), then
> > using it for an address calculation may trigger an exception.  Without a
> > fixup handler, this will lead to a panic, which will unwind, which will
> > trigger the fault repeatedly in an infinite loop.
> >
> > We don't observe such failures currently, but we have. Just to be safe,
> > add a fixup handler here so that at least we don't have an infinite
> > loop.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: commit 6dc5fd93b2f1 ("ARM: 8900/1: UNWINDER_FRAME_POINTER implementation for Clang")
> > Reported-by: Miles Chen <miles.chen@mediatek.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  arch/arm/lib/backtrace-clang.S | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm/lib/backtrace-clang.S b/arch/arm/lib/backtrace-clang.S
> > index 5388ac664c12..40eb2215eaf4 100644
> > --- a/arch/arm/lib/backtrace-clang.S
> > +++ b/arch/arm/lib/backtrace-clang.S
> > @@ -146,7 +146,7 @@ for_each_frame:     tst     frame, mask             @ Check for address exceptions
> >
> >                 tst     sv_lr, #0               @ If there's no previous lr,
> >                 beq     finished_setup          @ we're done.
> > -               ldr     r0, [sv_lr, #-4]        @ get call instruction
> > +prev_call:     ldr     r0, [sv_lr, #-4]        @ get call instruction
> >                 ldr     r3, .Lopcode+4
> >                 and     r2, r3, r0              @ is this a bl call
> >                 teq     r2, r3
> > @@ -206,6 +206,13 @@ finished_setup:
> >                 mov     r2, frame
> >                 bl      printk
> >  no_frame:      ldmfd   sp!, {r4 - r9, fp, pc}
> > +/*
> > + * Accessing the address pointed to by the link register triggered an
> > + * exception, don't try to unwind through it.
> > + */
> > +bad_lr:                mov     sv_fp, #0
>
> It might be nice to emit a warning here since we'll
> only hit this case if something fishy is going on
> with the saved lr.

Yeah, something fishy is going on if that ever happens.  Let me create
a V2 with an additional print.

>
> > +               mov     sv_lr, #0
> > +               b       finished_setup
> >  ENDPROC(c_backtrace)
> >                 .pushsection __ex_table,"a"
> >                 .align  3
> > @@ -214,6 +221,7 @@ ENDPROC(c_backtrace)
> >                 .long   1003b, 1006b
> >                 .long   1004b, 1006b
> >                 .long   1005b, 1006b
> > +               .long   prev_call, bad_lr
> >                 .popsection
> >
> >  .Lbad:         .asciz  "%sBacktrace aborted due to bad frame pointer <%p>\n"
> > --
> > 2.28.0.163.g6104cc2f0b6-goog
> >
>
> Thanks,
> Huck



-- 
Thanks,
~Nick Desaulniers
