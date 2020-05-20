Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D54BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23DBC207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V9JKluzt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgETR02 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgETR00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:26:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15384C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:26:26 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so1611584plo.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 10:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I4uDtSN00g/PyrhXYZzL0F8/NB4Tyo630ZwvvT8OLZg=;
        b=V9JKluztz6B+qth05Gg1jopFe/1IeJITinsjf/1HTM6jdqb+1xHzToPxVZXAPhpxQZ
         DGs/SHNa439w8dTEvwZGhheTRW64oya84qk1ve0BiKb60L+9f28maQdEN/dlHbMViSW3
         O8F9N3wXHpvC+N7cvSso2O+lJxKD6Np9VGJbs3Wi6o8usvYzr63LMm68/mM23PFrfA6/
         8R4pYKFxL4dKhIzLxTvIGRADMakVzJz86njTycSI3I3yAX/Zb7HTbDcVW3hkXSam5FiQ
         2aFoiV1O0c2sBsMeXxW7Imf2zGSsSG2MreMBdfzVmWNJCPqR44NctbfyurV1wlJC1Utg
         gtiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I4uDtSN00g/PyrhXYZzL0F8/NB4Tyo630ZwvvT8OLZg=;
        b=fOUYkxGiTZaHtA92ZbqtZFyGZEgAzHFpaxGYdwYO2vx6gGLom1WXD3/gq2EUb4IcQD
         sniZXrIxojkxUEF719x6HJv+rTGjFgqU2cctXea1302JXKnjDi7LWBEYYZFZSceWDY+3
         EV2nV39JdHjHHcctNDnJwdEB/vkAy9vQ0hIgcA8DZg8Q2n9semLIt7B0BFz0V3wfbmQs
         OqVF9poPkvAQifMyTqsjslzgukpqcXVX5XY/d/0HKMZZ+mHmLSl2xYaH5eTvqgRlUw0R
         Y5/qYi9rJLJVtwgnOk3GykkY/Bcd80Zmd8WG7/LmicmYGDb4GDAMSm0WVP7mPGJzIYoL
         is+A==
X-Gm-Message-State: AOAM532Ksx7B9d3I5vnPg4zlJcScNhthtQSCDp+lJdEg9jglG9pxwm6e
        Pcghv6lgL4JyX7kKABwb+SKgQkA3VzsuKZqOHSt19A==
X-Google-Smtp-Source: ABdhPJzserdUAX7/g6PG+l0rzhiWaxMxQ9S4toqd67Eo3lTorZLPdgksxSoaFzkYnSvPlNuN3J2N/PcyBLl+l0pTlF4=
X-Received: by 2002:a17:902:82c9:: with SMTP id u9mr5505686plz.179.1589995585260;
 Wed, 20 May 2020 10:26:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200517152916.3146539-1-brgerst@gmail.com> <20200517152916.3146539-3-brgerst@gmail.com>
 <CAKwvOdnCcpS_9A2y9tMqeiAg2NfcVx=gNeA2V=+zHknit7wGkg@mail.gmail.com> <CAMzpN2gGbZABjtLQyiTdtaL5LYW-cfVQZqj6w=oZNa9Fw9GdCQ@mail.gmail.com>
In-Reply-To: <CAMzpN2gGbZABjtLQyiTdtaL5LYW-cfVQZqj6w=oZNa9Fw9GdCQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 20 May 2020 10:26:13 -0700
Message-ID: <CAKwvOdmwh92BP2=-d4Apr07i6uKb21M15MAz-v4S5RfQ16-fPA@mail.gmail.com>
Subject: Re: [PATCH 2/7] x86/percpu: Clean up percpu_to_op()
To:     Brian Gerst <brgerst@gmail.com>
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

On Mon, May 18, 2020 at 8:38 PM Brian Gerst <brgerst@gmail.com> wrote:
>
> On Mon, May 18, 2020 at 5:15 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Sun, May 17, 2020 at 8:29 AM Brian Gerst <brgerst@gmail.com> wrote:
> > >
> > > The core percpu macros already have a switch on the data size, so the switch
> > > in the x86 code is redundant and produces more dead code.
> > >
> > > Also use appropriate types for the width of the instructions.  This avoids
> > > errors when compiling with Clang.
> > >
> > > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > > ---
> > >  arch/x86/include/asm/percpu.h | 90 ++++++++++++++---------------------
> > >  1 file changed, 35 insertions(+), 55 deletions(-)
> > >
> > > diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> > > index 89f918a3e99b..233c7a78d1a6 100644
> > > --- a/arch/x86/include/asm/percpu.h
> > > +++ b/arch/x86/include/asm/percpu.h
> > > @@ -117,37 +117,17 @@ extern void __bad_percpu_size(void);
> > >  #define __pcpu_reg_imm_4(x) "ri" (x)
> > >  #define __pcpu_reg_imm_8(x) "re" (x)
> > >
> > > -#define percpu_to_op(qual, op, var, val)               \
> > > -do {                                                   \
> > > -       typedef typeof(var) pto_T__;                    \
> > > -       if (0) {                                        \
> > > -               pto_T__ pto_tmp__;                      \
> > > -               pto_tmp__ = (val);                      \
> > > -               (void)pto_tmp__;                        \
> > > -       }                                               \
> > > -       switch (sizeof(var)) {                          \
> > > -       case 1:                                         \
> > > -               asm qual (op "b %1,"__percpu_arg(0)     \
> > > -                   : "+m" (var)                        \
> > > -                   : "qi" ((pto_T__)(val)));           \
> > > -               break;                                  \
> > > -       case 2:                                         \
> > > -               asm qual (op "w %1,"__percpu_arg(0)     \
> > > -                   : "+m" (var)                        \
> > > -                   : "ri" ((pto_T__)(val)));           \
> > > -               break;                                  \
> > > -       case 4:                                         \
> > > -               asm qual (op "l %1,"__percpu_arg(0)     \
> > > -                   : "+m" (var)                        \
> > > -                   : "ri" ((pto_T__)(val)));           \
> > > -               break;                                  \
> > > -       case 8:                                         \
> > > -               asm qual (op "q %1,"__percpu_arg(0)     \
> > > -                   : "+m" (var)                        \
> > > -                   : "re" ((pto_T__)(val)));           \
> > > -               break;                                  \
> > > -       default: __bad_percpu_size();                   \
> > > -       }                                               \
> > > +#define percpu_to_op(size, qual, op, _var, _val)                       \
> > > +do {                                                                   \
> > > +       __pcpu_type_##size pto_val__ = __pcpu_cast_##size(_val);        \
> > > +       if (0) {                                                        \
> > > +               typeof(_var) pto_tmp__;                                 \
> > > +               pto_tmp__ = (_val);                                     \
> > > +               (void)pto_tmp__;                                        \
> > > +       }                                                               \
> >
> > Please replace the whole `if (0)` block with:
> > ```c
> > __same_type(_var, _val);
> > ```
> > from include/linux/compiler.h.
>
> The problem with __builtin_types_compatible_p() is that it considers
> unsigned long and u64 (aka unsigned long long) as different types even
> though they are the same width on x86-64.  While this may be a good
> cleanup to look at in the future, it's not a simple drop-in
> replacement.

Does it trigger errors in this case?

It's interesting to know how this trick differs from
__builtin_types_compatible_p().  Might even be helpful to wrap this
pattern in a macro with a comment with the pros/cons of this approach
vs __same_type.

On the other hand, the use of `long` seems tricky in x86 code as x86
(32b) is ILP32 but x86_64 (64b) is LP64.  So the use of `long` is
ambiguous in the sense that it's a different size depending on the
target ABI.  Wouldn't it potentially be a bug for x86 kernel code to
use `long` percpu variables (or rather mix `long` and `long long` in
the same operation) in that case, since the sizes of the two would be
different for i386?
-- 
Thanks,
~Nick Desaulniers
