Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527B7C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23093206B9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fb1AEy/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbgEKSJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726891AbgEKSJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:09:14 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9A6C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:09:13 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so10813569iog.13
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 11:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E2lGnntoMcDte3ggNmclJo3GyMi8lXxS2V6uxJFiNqM=;
        b=Fb1AEy/a1/hVWMniX/dCkcTEkF32oJosRltD5mrxheCwnduFPqmsl0w6y56EH1b8hI
         GcbfWL8LyZsC9ivjvAK5LWqCiWcBklyPM1VmxL+0TgK1iS26xC58kJT3v8vEeSgCSij+
         I1XoVP6TKfWNUAwz619U9GGjRjfeThtSoC2+LbJkk3gHTdMOnZniY/XWYeEvkzewsAbX
         RBZ20Sg10RVcWAksY1ZIp6pH11CjP6OTriXbt9Fnc/LWl4xjVMtYCcV272nP+yAijtpS
         OKsfHn7+CWwJEYg4qEnbzubzqn9rYitiYJxs564K0SkWHTs8sQX5zEvlw6uYo8hhYdys
         nBBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E2lGnntoMcDte3ggNmclJo3GyMi8lXxS2V6uxJFiNqM=;
        b=Rd/Gm3UFV0LNMYxWPWUs//63XM8ITZ8q1BFN3NcG9974rUHHSMBb+jybDW6TwesW8s
         siJpcm+lbT2fFuySPU6OM/RsXv/bCfGeAbUvPH3vb3BJ3Kv9fab+5cLfidKNJTPrupBy
         V+ZW5Yy8UyMg4JYNrpiY0RNKKml7oJ/YfprucmAg1czwLAJ1dB4WnrImRqOfpPusy6R8
         Uu90/skzygxijkEP9jHKU1RD7dTK7eU9ARmXtwvvJ+icCziOLcaGMaaSYFMUxhxR0jvt
         xdbEBDkxCAm6dzHWFvwf8AiSZmKhF40jRLJzuW9vITrHErZOBE+vrnsHNRxAlfVtnS4n
         Bc7w==
X-Gm-Message-State: AGi0PubeHgdkP1M6qKTWmLK6OAj5Xd81x1o7tUuVnPeLyc30hN7mqY5k
        AJdjT1wf2+obcBsJMQWdF8MPOW0vEqdzcIVLig==
X-Google-Smtp-Source: APiQypJXs982Djs22EqStlps4XAsYKJ6uTdTrOxC8BewFP4yNucnYt6Odc5dpxsBu29LTsxgoI94VD1Shv8Dx8mB1TY=
X-Received: by 2002:a6b:b512:: with SMTP id e18mr16445980iof.168.1589220552319;
 Mon, 11 May 2020 11:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200504230309.237398-1-ndesaulniers@google.com> <CAKwvOdmspKUknbzDn9kY2jMgkFw=Ktvst0ZtwambDOfybqJGWw@mail.gmail.com>
In-Reply-To: <CAKwvOdmspKUknbzDn9kY2jMgkFw=Ktvst0ZtwambDOfybqJGWw@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Mon, 11 May 2020 14:09:01 -0400
Message-ID: <CAMzpN2iDottAY3p=GS0A_7XX7bpmWsmSOEcztMXNEEvcwHirjg@mail.gmail.com>
Subject: Re: [PATCH] x86: support i386 with Clang
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Golovin <dima@golovin.in>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 1:26 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Bumping for comment+review.
>
> On Mon, May 4, 2020 at 4:03 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > GCC and Clang are architecturally different, which leads to subtle
> > issues for code that's invalid but clearly dead. This can happen with
> > code that emulates polymorphism with the preprocessor and sizeof.
> >
> > GCC will perform semantic analysis after early inlining and dead code
> > elimination, so it will not warn on invalid code that's dead. Clang
> > strictly performs optimizations after semantic analysis, so it will warn
> > for dead code.
> >
> > Neither Clang nor GCC like this very much with -m32:
> >
> > long long ret;
> > asm ("movb $5, %0" : "=q" (ret));
> >
> > However, GCC can tolerate this variant:
> >
> > long long ret;
> > switch (sizeof(ret)) {
> > case 1:
> >         asm ("movb $5, %0" : "=q" (ret));
> >         break;
> > case 8:;
> > }
> >
> > Clang, on the other hand, won't accept that because it validates the
> > inline asm for the '1' case *before* the optimisation phase where it
> > realises that it wouldn't have to emit it anyway.
> >
> > If LLVM (Clang's "back end") fails such as during instruction selection
> > or register allocation, it cannot provide accurate diagnostics
> > (warnings/errors) that contain line information, as the AST has been
> > discarded from memory at that point.
> >
> > While there have been early discussions about having C/C++ specific
> > language optimizations in Clang via the use of MLIR, which would enable
> > such earlier optimizations, such work is not scoped and likely a
> > multi-year endeavor.
> >
> > We also don't want to swap the use of "=q" with "=r". For 64b, it
> > doesn't matter. For 32b, it's possible that a 32b register without a 8b
> > lower alias (i.e. ESI, EDI, EBP) is selected which the assembler will
> > then reject.
> >
> > With this, Clang can finally build an i386 defconfig.
> >
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
> > Reported-by: David Woodhouse <dwmw2@infradead.org>
> > Reported-by: Dmitry Golovin <dima@golovin.in>
> > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Link: https://bugs.llvm.org/show_bug.cgi?id=33587
> > Link: https://github.com/ClangBuiltLinux/linux/issues/3
> > Link: https://github.com/ClangBuiltLinux/linux/issues/194
> > Link: https://github.com/ClangBuiltLinux/linux/issues/781
> > Link: https://lore.kernel.org/lkml/20180209161833.4605-1-dwmw2@infradead.org/
> > Link: https://lore.kernel.org/lkml/CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com/
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Note: this is a resend of:
> > https://lore.kernel.org/lkml/20180209161833.4605-1-dwmw2@infradead.org/
> > rebased on today's Linux next, and with the additional change to
> > uaccess.h.
> >
> > I'm happy to resend with authorship and reported by tags changed to
> > suggested by's or whatever, just let me know.
> >
> > Part of the commit message is stolen from David, and part from Linus.
> > Shall I resend with David's authorship and
> > [Nick: reworded]
> > ???
> >
> > I don't really care, I just don't really want to carry this out of tree
> > for our CI, which is green for i386 otherwise.
> >
> >
> >  arch/x86/include/asm/percpu.h  | 12 ++++++++----
> >  arch/x86/include/asm/uaccess.h |  4 +++-
> >  2 files changed, 11 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> > index 2278797c769d..826d086f71c9 100644
> > --- a/arch/x86/include/asm/percpu.h
> > +++ b/arch/x86/include/asm/percpu.h
> > @@ -99,7 +99,7 @@ do {                                                  \
> >         case 1:                                         \
> >                 asm qual (op "b %1,"__percpu_arg(0)     \
> >                     : "+m" (var)                        \
> > -                   : "qi" ((pto_T__)(val)));           \
> > +                   : "qi" ((unsigned char)(unsigned long)(val))); \
> >                 break;                                  \
> >         case 2:                                         \
> >                 asm qual (op "w %1,"__percpu_arg(0)     \
> > @@ -144,7 +144,7 @@ do {                                                                        \
> >                 else                                                    \
> >                         asm qual ("addb %1, "__percpu_arg(0)            \
> >                             : "+m" (var)                                \
> > -                           : "qi" ((pao_T__)(val)));                   \
> > +                           : "qi" ((unsigned char)(unsigned long)(val))); \
> >                 break;                                                  \
> >         case 2:                                                         \
> >                 if (pao_ID__ == 1)                                      \
> > @@ -182,12 +182,14 @@ do {                                                                      \
> >
> >  #define percpu_from_op(qual, op, var)                  \
> >  ({                                                     \
> > +       unsigned char pfo_u8__;                         \
> >         typeof(var) pfo_ret__;                          \
> >         switch (sizeof(var)) {                          \
> >         case 1:                                         \
> >                 asm qual (op "b "__percpu_arg(1)",%0"   \
> > -                   : "=q" (pfo_ret__)                  \
> > +                   : "=q" (pfo_u8__)                   \
> >                     : "m" (var));                       \
> > +               pfo_ret__ = (typeof(var))(unsigned long)pfo_u8__;       \
> >                 break;                                  \
> >         case 2:                                         \
> >                 asm qual (op "w "__percpu_arg(1)",%0"   \
> > @@ -211,12 +213,14 @@ do {                                                                      \
> >
> >  #define percpu_stable_op(op, var)                      \
> >  ({                                                     \
> > +       unsigned char pfo_u8__;                         \
> >         typeof(var) pfo_ret__;                          \
> >         switch (sizeof(var)) {                          \
> >         case 1:                                         \
> >                 asm(op "b "__percpu_arg(P1)",%0"        \
> > -                   : "=q" (pfo_ret__)                  \
> > +                   : "=q" (pfo_u8__)                   \
> >                     : "p" (&(var)));                    \
> > +               pfo_ret__ = (typeof(var))(unsigned long)pfo_u8__;       \
> >                 break;                                  \
> >         case 2:                                         \
> >                 asm(op "w "__percpu_arg(P1)",%0"        \
> > diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> > index d8f283b9a569..cf8483cd80e1 100644
> > --- a/arch/x86/include/asm/uaccess.h
> > +++ b/arch/x86/include/asm/uaccess.h
> > @@ -314,11 +314,13 @@ do {                                                                      \
> >
> >  #define __get_user_size(x, ptr, size, retval)                          \
> >  do {                                                                   \
> > +       unsigned char x_u8__;                                           \
> >         retval = 0;                                                     \
> >         __chk_user_ptr(ptr);                                            \
> >         switch (size) {                                                 \
> >         case 1:                                                         \
> > -               __get_user_asm(x, ptr, retval, "b", "=q");              \
> > +               __get_user_asm(x_u8__, ptr, retval, "b", "=q");         \
> > +               (x) = x_u8__;                                           \
> >                 break;                                                  \
> >         case 2:                                                         \
> >                 __get_user_asm(x, ptr, retval, "w", "=r");              \
> > --
> > 2.26.2.526.g744177e7f7-goog
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers

This looks like the same issue that we just discussed for bitops.h.
Add the "b" operand size modifier to force it to use the 8-bit
register names (and probably also needs the "w" modifier in the 16-bit
case).

--
Brian Gerst
