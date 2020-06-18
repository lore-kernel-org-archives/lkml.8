Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E567C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025D7207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mg8xt2oO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729170AbgFRU3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgFRU3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:29:13 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D414EC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:29:13 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u8so3057645pje.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApmvY4NUh4oE4rGYTLrhVzjNJ6MG1aD54ijaoWc+qQQ=;
        b=Mg8xt2oOvSVJzdadsLPdjjKqP24SfmArTOufNfznQyUZcY1XPsLBbTgvCVJWSX23t1
         zlpTrHNr+laRY2ihyOiL5y0qWnyU7iOidLPFb/3RVtE/52HkV3ziLN6ooNxyhjYYMp2o
         ZYgnU5Uwv+1P8BufZc/VcW8TQCVa4h83/NtTx/fWssW0TjsgWTMlBq5/y7r9eRSjrACh
         MKajyjltSPlhfBv9mvwMLTAzBiGi1tA1bqWc5jNwv8QjQJHVZj9wOOXPVL5TN+rTEoJa
         LurVgqBnek49Ec5FNrnxuD74mbVSwh3av+KXedrr52YLkEdMb2Fe01DerkWmloglOOAc
         NH0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApmvY4NUh4oE4rGYTLrhVzjNJ6MG1aD54ijaoWc+qQQ=;
        b=Et3P8PuCuYStnDByaHRQSaCS2xjv9Xhrw94+wtGuQ2x8zQGsBzZFo6Op5TUBCsBNAd
         g2RWr59jBiC6ctIoEVe3/oNqrqQtw2TOgs4P+2aN59Akb3rh+qlhRpqZJ+YYX5efvjy0
         CdeaLLym+ay1QLgeDiXYWlSum3xT4Kz4fRphipOFK/b8PeGxRTGYATxZyq30PRNERoM6
         qAZAItMhTVQv5kGMmnp8aO+xEKKRBRdcIZN7YrSoq/8IVFt0Cha0UGSbE80+M9HdDQ3V
         /FdzZdrCgVFGfzfH4xsDdLQol2yGVcZcDHkjz0HNctSsrMLsN3jMUKSrn6+qrj6Lh4CG
         UxBg==
X-Gm-Message-State: AOAM530VgDZ4pnxJ9YopFh9Yr86GZJE9lCIV3nBNqISPMIp67WtLpyDA
        TZNYevCyicAJ++4o6ug9j25fl0RE0w7fnA0aWZnAGg==
X-Google-Smtp-Source: ABdhPJxn8QzmdoT0TNDCjswW3rDFhlLfydkfXBmvsim9YT+1fYy25hVUP+vlnFIOHcfQ9eYJZXNAFT0x7ZPJ/54NoE4=
X-Received: by 2002:a17:90a:e2c4:: with SMTP id fr4mr127063pjb.32.1592512153032;
 Thu, 18 Jun 2020 13:29:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200616223633.73971-1-nhuck@google.com> <CAKwvOdkibnsr+z8-pXG1RjOEcrGQ6HQ0=PM-B9p-i85_BKS0cQ@mail.gmail.com>
In-Reply-To: <CAKwvOdkibnsr+z8-pXG1RjOEcrGQ6HQ0=PM-B9p-i85_BKS0cQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 18 Jun 2020 13:29:01 -0700
Message-ID: <CAKwvOd=rTPS6xgfV7kLsuA-_=ghqE9HWu=6HyTFOMd_-THWaCg@mail.gmail.com>
Subject: Re: [PATCH] Fix unwind_frame for clang-built kernels
To:     Nathan Huckleberry <nhuck@google.com>,
        =?UTF-8?B?TWlsZXMgQ2hlbiAo6Zmz5rCR5qi6KQ==?= 
        <miles.chen@mediatek.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kristof Beyls <Kristof.Beyls@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 1:22 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Jun 16, 2020 at 3:36 PM 'Nathan Huckleberry' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > Since clang does not push pc and sp in function prologues, the current
> > implementation of unwind_frame does not work. By using the previous
> > frame's lr/fp instead of saved pc/sp we get valid unwinds on clang-built
> > kernels.
> >
> > The bounds check on next frame pointer must be changed as well since
> > there are 8 less bytes between frames.
> >
> > This fixes /proc/<pid>/stack.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/912
> > Signed-off-by: Nathan Huckleberry <nhuck@google.com>
>
> Thanks for the patch, Nathan!  When I looked into this, I found the
> latest ARM AAPCS [0] specifically says (with `it` referring to `a
> platform`: "It may permit the frame pointer register to be used as a
> general-purpose callee-saved register, but provide a platform-specific
> mechanism for external agents to reliably locate the chain of frame
> records."   While it's good that's acknowledged in the documentation,
> the current wording is relaxed in order to not force current
> implementations to converge.  This has the unfortunate side effect of
> making finding the frame pointer toolchain dependendent, hence this
> patch and your previous commit 6dc5fd93b2f1 ("ARM: 8900/1:
> UNWINDER_FRAME_POINTER implementation for Clang").  Being more
> specific in the documentation would force at least one implementation
> to change, and I think that would also imply an ABI break.  So I can
> see it both ways, though I still would prefer that the language pin
> this down, even if we had to change LLVM.  Just providing additional
> context for folks on the thread.
>
> This should also have a reported by tag from Miles, in v2.
>
> Reported-by: Miles Chen <Miles.Chen@mediatek.com>
>
> Miles mentioned to me that he tested it, but maybe Miles can confirm
> that publicly on-list via an explicit Tested-by: tag?
>
> This would be useful for us to have in stable; otherwise we'll have to
> carry out of tree in Android and CrOS, which I'd rather not do.  Via
> Documentation/process/stable-kernel-rules.rst, if you add this tag to
> V2, that will greatly simplify submitting this to stable:
> Cc: stable@vger.kernel.org
>
> Miles also showed me the behavior of this patch for different kernel

s/this patch/this function before this patch is applied/

> versions, which varies anywhere from empty or single entry traces to
> panics, so this is pretty important that this works for Clang builds.
>
> [0] https://static.docs.arm.com/ihi0042/i/aapcs32.pdf
>
> > ---
> >  arch/arm/kernel/stacktrace.c | 24 ++++++++++++++++++++++++
> >  1 file changed, 24 insertions(+)
> >
> > diff --git a/arch/arm/kernel/stacktrace.c b/arch/arm/kernel/stacktrace.c
> > index cc726afea023..76ea4178a55c 100644
> > --- a/arch/arm/kernel/stacktrace.c
> > +++ b/arch/arm/kernel/stacktrace.c
> > @@ -22,6 +22,19 @@
> >   * A simple function epilogue looks like this:
> >   *     ldm     sp, {fp, sp, pc}
> >   *
> > + * When compiled with clang, pc and sp are not pushed. A simple function
> > + * prologue looks like this when built with clang:
> > + *
> > + *     stmdb   {..., fp, lr}
> > + *     add     fp, sp, #x
> > + *     sub     sp, sp, #y
> > + *
> > + * A simple function epilogue looks like this when built with clang:
> > + *
> > + *     sub     sp, fp, #x
> > + *     ldm     {..., fp, pc}
> > + *
> > + *
> >   * Note that with framepointer enabled, even the leaf functions have the same
> >   * prologue and epilogue, therefore we can ignore the LR value in this case.
> >   */
> > @@ -34,6 +47,16 @@ int notrace unwind_frame(struct stackframe *frame)
> >         low = frame->sp;
> >         high = ALIGN(low, THREAD_SIZE);
> >
> > +#ifdef CONFIG_CC_IS_CLANG
> > +       /* check current frame pointer is within bounds */
> > +       if (fp < low + 4 || fp > high - 4)
>
> The patch LGTM; maybe Russell or Catalin could triple check this
> bounds check?  Assuming there's no issue, you can include on a v2 my
> reviewed by:
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> I'd probably wait the remainder of a week before sending a v2 to
> collect additional feedback.  Thank you again.
>
> > +               return -EINVAL;
> > +
> > +       frame->sp = frame->fp;
> > +       frame->fp = *(unsigned long *)(fp);
> > +       frame->pc = frame->lr;
> > +       frame->lr = *(unsigned long *)(fp + 4);
> > +#else
> >         /* check current frame pointer is within bounds */
> >         if (fp < low + 12 || fp > high - 4)
> >                 return -EINVAL;
> > @@ -42,6 +65,7 @@ int notrace unwind_frame(struct stackframe *frame)
> >         frame->fp = *(unsigned long *)(fp - 12);
> >         frame->sp = *(unsigned long *)(fp - 8);
> >         frame->pc = *(unsigned long *)(fp - 4);
> > +#endif
> >
> >         return 0;
> >  }
> > --
> > 2.27.0.290.gba653c62da-goog
> >
> > --
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
