Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9172C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:20:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799F720772
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WDh9T0Mz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgFBOUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbgFBOUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:20:03 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB4EC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 07:20:03 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id j8so10953038iog.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gTKrdi+FmTwitSR67MLzUCwXXUWMx4K0w1icK0dDzI4=;
        b=WDh9T0MzEQbVqOcDSnRU44nLaP+mu+XQvI2hYAlCUAyxVtbNZo/5OQhNcvN65+QOWS
         bSnMHUUgyLDptNAOss4k4qbRaA3E/XZqKJbcp+AEE8wJCd9TWWA9g+mn3TLBsNIuEYqr
         Lbzm19NRKORu88a0s7luHo9mCqEsbvBmwwc61no8zWSSjwWhNvxc7GChzWjQdTVGcJ+B
         xNqbbwHCTEPKDMSb927p2Ap/dfgiIxu07a84tvtf4B1HAazOI9BEq+OtmYpgOr8hC1J5
         IEy54LIdDbaY5V4XLiMDNfZ9uz8uYutCm3NKRETQQ1jsUroe+xKD2uQSwgGHNxSlwE7G
         hNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gTKrdi+FmTwitSR67MLzUCwXXUWMx4K0w1icK0dDzI4=;
        b=rqhMDVW4Lg8rsFXTVvA3qRw+m1JV/AeisKXA/WfH24cCK/OEdMhDSZhNasM6+TJOrR
         tY+sfHsQnUkleXyM2WWjdB04RjsTyaMGknD/cYMlycxCcVnWB5Hq3bAwwo50gBIoZp6A
         mXAcp8unBZMiFV2kJc8GqwUPJFRy4QNiL+OUfA616hp8fXypZfDlurE947z8Dfk1D8od
         FgNjL3X0GV4uDasteGr81oFyYKsmSI1a8YuZnGf9R4TdrBLlS+gJQ7dcM9z6vN+ppvzk
         BJzCUikSLN/1F4v21vw2P1uHuZo64MytWSOsMJp0JKyDRbfHL88m2tbLgh9oSLMD/6RK
         eMWw==
X-Gm-Message-State: AOAM530O0Xrv45AYiQuEXrTruICEf2px1OtAAntCZjRN7nd97V1/CqHI
        gvfwWMpjiZHm5DOJkAA3SbSMUFN7wires43OjkzdD14+Vg==
X-Google-Smtp-Source: ABdhPJzc4bzgbZaVWV+pFHhC1kGcZeS16HuZYexWvBmmcGb9tg+2mls85GGsK29DLByDSm0HmWcMZHheOI0oSGaC1ns=
X-Received: by 2002:a02:958e:: with SMTP id b14mr26155030jai.126.1591107602546;
 Tue, 02 Jun 2020 07:20:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com> <20200530221127.459704-10-brgerst@gmail.com>
 <CAKwvOdmgN7xra26_xBYCJo45OdOUHLNmw16ioLOE171f_HE0eA@mail.gmail.com>
In-Reply-To: <CAKwvOdmgN7xra26_xBYCJo45OdOUHLNmw16ioLOE171f_HE0eA@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 2 Jun 2020 10:19:51 -0400
Message-ID: <CAMzpN2hHSeN9Z3BO_Uo1-yCfh9YdEbkK0wb9E3D8rq6onQDZdg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] x86/percpu: Clean up percpu_stable_op()
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 4:43 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Sat, May 30, 2020 at 3:11 PM Brian Gerst <brgerst@gmail.com> wrote:
> >
> > Use __pcpu_size_call_return() to simplify this_cpu_read_stable().
>
> Clever! As in this_cpu_read() in include/linux/percpu-defs.h.  Could
> be its own patch before this, but it's fine.
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>
> > Also remove __bad_percpu_size() which is now unused.
> >
> > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > ---
> >  arch/x86/include/asm/percpu.h | 41 ++++++++++-------------------------
> >  1 file changed, 12 insertions(+), 29 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> > index 7efc0b5c4ff0..cf2b9c2a241e 100644
> > --- a/arch/x86/include/asm/percpu.h
> > +++ b/arch/x86/include/asm/percpu.h
> > @@ -85,7 +85,6 @@
> >
> >  /* For arch-specific code, we can use direct single-insn ops (they
> >   * don't give an lvalue though). */
> > -extern void __bad_percpu_size(void);
> >
> >  #define __pcpu_type_1 u8
> >  #define __pcpu_type_2 u16
> > @@ -167,33 +166,13 @@ do {                                                                      \
> >         (typeof(_var))(unsigned long) pfo_val__;                        \
> >  })
> >
> > -#define percpu_stable_op(op, var)                      \
> > -({                                                     \
> > -       typeof(var) pfo_ret__;                          \
> > -       switch (sizeof(var)) {                          \
> > -       case 1:                                         \
> > -               asm(op "b "__percpu_arg(P1)",%0"        \
>
> What does the `P` do here?
> https://gcc.gnu.org/onlinedocs/gcc/Simple-Constraints.html#Simple-Constraints
> says can be machine dependent integral literal in a certain range.
> https://gcc.gnu.org/onlinedocs/gcc/Machine-Constraints.html#Machine-Constraints
> doesn't document `P` for x86 though...

https://gcc.gnu.org/onlinedocs/gcc-10.1.0/gcc/Extended-Asm.html#x86-Operand-Modifiers

Removing the 'P' modifier results in this:
        movq %gs:$current_task, %rdx    #, pfo_val__

This is because the 'p' constraint treats a memory address as a
constant.  I tried replacing it with __this_cpu_read(), which since
commit 0b9ccc0a should have similar non-volatile semantics.  But the
compiler still reloaded it on every use, so I left the asm template
as-is for now until that can be resolved.

--
Brian Gerst
