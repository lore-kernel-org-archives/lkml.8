Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C2E5C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:32:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2F7206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 22:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A5gGDmYj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgHJWcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 18:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgHJWcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 18:32:46 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E256C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 15:32:46 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id f5so1894665plr.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 15:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XXQVV8QzuLxMQgNKr0LaFyD2ve8ZpOBor9lL6l9h4Ds=;
        b=A5gGDmYjWmpB699JIOK6on6qDu9uDtnkIil+iYYDbdyy6JwRwaleVNUog1nVfM3OCH
         J3eWA+s+RBIw3Nm0nAnt+irl8ws3IeWlT7CFAjBxQMTdTgaNP3mGZGI6/V+fQp4+sm+I
         j965e6vopsDobvVf4P4MoP1750zNWOihUzQXNNKi4USfnGKwC/5OrEuWGkXaCS8HDAQa
         LB9NVTF6Q0tmZAVyk3lnpOpyVDxqepVHhujQ/j8apT/UOrOLfoAoY3dQszUYKcC6Mgxe
         mpMRjF2aMavDkt32srSX0KzPl1do8fAVHcvkJ09gflS272e9XIeGmpKey+2bY1luqGjP
         xmmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XXQVV8QzuLxMQgNKr0LaFyD2ve8ZpOBor9lL6l9h4Ds=;
        b=OsfkRkdSjqnEpxqp4mXeBsvHLVLkdeMktrW9GkTsFCkZ9oBy4gjmYIySUWAgAiPoAN
         5xF2oFz3YbxS4xt38D86fLxBgBrefsVRRbkameeyAa9nYSPyZOtVN2zDDH8JFBhBMUaT
         +6pfiv/Lob1wanIDS5N7L4f7UikUyhsc8LCvOM5gtjWe6u2S7JRU2C773Yh4zyppe6Mu
         rrKBKhIr9i2TWPXyvky7bGCWC0FTpZQkUC7DTHd3ZzZWxmpUMJ5fMrXGBY8IyeaSQlDm
         pLJehIta/yueSl7e2aXiYUNEexhbhytKpStixUateeTWL50y/4H/vChby8lcdwHdNM4N
         fDwA==
X-Gm-Message-State: AOAM531Bkeu+erVyORVXn/eELnvw0YucMQeCWzXqYWJ2/Q4iesAtQ4Uy
        WHer06ABd/akBDXqx0U3awHs5WUOSmXH4Qc9RXiuhw==
X-Google-Smtp-Source: ABdhPJzDEd2QBFQmRufQF9FdKaFeqP55ESrnL6LWIXjGrIg3RjVKiIiVetNDyjpn7llpLrrv1LyQ7LDZ0bj4IzPw12E=
X-Received: by 2002:a17:902:8509:: with SMTP id bj9mr11421853plb.179.1597098763680;
 Mon, 10 Aug 2020 15:32:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200730205112.2099429-1-ndesaulniers@google.com>
 <20200730205112.2099429-4-ndesaulniers@google.com> <CAN=-RxstJBjJUcOf9iuAxEcxYUhJTdF9JhPVWwQuefnE+3s52w@mail.gmail.com>
In-Reply-To: <CAN=-RxstJBjJUcOf9iuAxEcxYUhJTdF9JhPVWwQuefnE+3s52w@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 10 Aug 2020 15:32:32 -0700
Message-ID: <CAKwvOdn+MGgYf8k9uAUT55vBL+ERTjv+jx+t8SD9HO98-h2c0w@mail.gmail.com>
Subject: Re: [PATCH 3/4] ARM: backtrace-clang: give labels more descriptive names
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
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 3:39 PM Nathan Huckleberry <nhuck15@gmail.com> wrote:
>
> The style cleanup looks great. I just have one extra thing that
> can probably be thrown into this patch.
>
> On Thu, Jul 30, 2020 at 3:51 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > Removes the 1004 label; it was neither a control flow target, nor an
> > instruction we expect to produce a fault.
> >
> > Gives the labels slightly more readable names. The `b` suffixes are
> > handy to disambiguate between labels of the same identifier when there's
> > more than one. Since these labels are unique, let's just give them
> > names.
> >
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> >  arch/arm/lib/backtrace-clang.S | 22 ++++++++++------------
> >  1 file changed, 10 insertions(+), 12 deletions(-)
> >
> > diff --git a/arch/arm/lib/backtrace-clang.S b/arch/arm/lib/backtrace-clang.S
> > index 40eb2215eaf4..7dad2a6843a5 100644
> > --- a/arch/arm/lib/backtrace-clang.S
> > +++ b/arch/arm/lib/backtrace-clang.S
> > @@ -121,8 +121,8 @@ for_each_frame:     tst     frame, mask             @ Check for address exceptions
> >   * start. This value gets updated to be the function start later if it is
> >   * possible.
> >   */
> > -1001:          ldr     sv_pc, [frame, #4]      @ get saved 'pc'
> > -1002:          ldr     sv_fp, [frame, #0]      @ get saved fp
> > +load_pc:       ldr     sv_pc, [frame, #4]      @ get saved 'pc'
> > +load_fp:       ldr     sv_fp, [frame, #0]      @ get saved fp
> >
> >                 teq     sv_fp, mask             @ make sure next frame exists
> >                 beq     no_frame
> > @@ -142,7 +142,7 @@ for_each_frame:     tst     frame, mask             @ Check for address exceptions
> >   * registers for the current function, but the stacktrace is still printed
> >   * properly.
> >   */
> > -1003:          ldr     sv_lr, [sv_fp, #4]      @ get saved lr from next frame
> > +load_lr:       ldr     sv_lr, [sv_fp, #4]      @ get saved lr from next frame
> >
> >                 tst     sv_lr, #0               @ If there's no previous lr,
> >                 beq     finished_setup          @ we're done.
> > @@ -166,8 +166,7 @@ finished_setup:
> >  /*
> >   * Print the function (sv_pc) and where it was called from (sv_lr).
> >   */
> > -1004:          mov     r0, sv_pc
> > -
> > +               mov     r0, sv_pc
> >                 mov     r1, sv_lr
> >                 mov     r2, frame
> >                 bic     r1, r1, mask            @ mask PC/LR for the mode
> > @@ -182,7 +181,7 @@ finished_setup:
> >   * pointer the comparison will fail and no registers will print. Unwinding will
> >   * continue as if there had been no registers stored in this frame.
> >   */
> > -1005:          ldr     r1, [sv_pc, #0]         @ if stmfd sp!, {..., fp, lr}
> > +load_stmfd:    ldr     r1, [sv_pc, #0]         @ if stmfd sp!, {..., fp, lr}
> >                 ldr     r3, .Lopcode            @ instruction exists,
> >                 teq     r3, r1, lsr #11
> >                 ldr     r0, [frame]             @ locals are stored in
> > @@ -201,7 +200,7 @@ finished_setup:
> >                 mov     frame, sv_fp            @ above the current frame
> >                 bhi     for_each_frame
> >
> > -1006:          adr     r0, .Lbad
> > +bad_frame:     adr     r0, .Lbad
> >                 mov     r1, loglvl
> >                 mov     r2, frame
> >                 bl      printk
> > @@ -216,11 +215,10 @@ bad_lr:           mov     sv_fp, #0
> >  ENDPROC(c_backtrace)
> >                 .pushsection __ex_table,"a"
> >                 .align  3
> > -               .long   1001b, 1006b
> > -               .long   1002b, 1006b
> > -               .long   1003b, 1006b
> > -               .long   1004b, 1006b
> > -               .long   1005b, 1006b
> > +               .long   load_pc, bad_frame
> > +               .long   load_fp, bad_frame
> > +               .long   load_lr, bad_frame
> > +               .long   load_stmfd, bad_frame
>
> Load_stmfd should get its own fixup
> handler since it should emit errors about a bad
> pc, not a bad frame pointer.

Yeah, I can add that.  It's a little orthogonal though to this patch
that renames labels. I'd consider more so a pre-existing bug.  Let me
add a patch to the series that gives it a new fixup handler, separate
from the label renaming, in a v2 of the series.

>
> >                 .long   prev_call, bad_lr
> >                 .popsection
> >
> > --
> > 2.28.0.163.g6104cc2f0b6-goog
> >



-- 
Thanks,
~Nick Desaulniers
