Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4FF2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3EB020849
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OwBEg7NZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389061AbgEZRys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728461AbgEZRyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:54:47 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B68C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 10:54:47 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x13so10464812pfn.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 10:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V3lZADPp9SjYFIWcTAtu85755s38LKZRcrVlQRimurw=;
        b=OwBEg7NZSK4qgdmj9428N/878QMZ+TGMSy++8CCAlmL8U67NCOTuCy5llqjJ8kTb9F
         lmzQmzXjyM62qKuE62bd4/59pszdN8TENdpA9k2Lq+IUcZyPzkXbXQaeFAF71CGyNHyf
         e4NLfgRkrPxYB0txc9ZmVljj/Bu94cg3gNV2akXT/9zbnbvHwB+Rm30paeuyC0PqouS/
         ZqOytlUhUZiQvhTJ19X7eKtkRzqBC1/B2CKEZqmn+I1z0AoztnHyEqcYCDcHEaqwSNEZ
         pn0gcy6visILeI/DoRo7Io5rvBLR7Lgsah3XRCYFnHElQNsUPNSrBXyfsYI2NERRP2Ag
         AD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V3lZADPp9SjYFIWcTAtu85755s38LKZRcrVlQRimurw=;
        b=hVFdJhrrXWoIrYQVPY929A5Xrrl0cpKxxPzOrL8T1Huf5CwacfwKUZNz8CAvL/8sug
         DX79D7HGRX0HQ/9QlUFzkfNTAaM8naCkFPx9I4VEm74wAlDwf0QQt2tkr8R1wW78Ooso
         60a1QopnSznghLeMHiu31gQ2fLx38+3NBqK82QiaZtZNl2ExMRv4F5i8AtkGu+mwFrmD
         OpF0rYZihrwaIVO5yHf2zmiDyHVJpTJlUXDts5Wf9jtLJu3Oj7F+c7cjc5nQqQlbl5R2
         v2UnDcHFuitlm8KER9KDbrY+qFJuzQqMczcy8kCnQea1wVBRhrNaD9mIc4Omexp8w8eN
         F4lg==
X-Gm-Message-State: AOAM531NmgiRtzxS2zX15rVchLAx4iqP2MuzePbuIA4BGQYYRPK/p8dN
        HSAMb8FPe8FvM/NKUUDdwAnxlFhBg5pVzs3hh1QOWg==
X-Google-Smtp-Source: ABdhPJwm/I8SD4ZHSJxkXvHTajdIbnAMWf57cs93ikbYz8PThpfjZWVjBiFMJO6J8awfU7CkCWp4lwVPKF0N4lJfwCI=
X-Received: by 2002:aa7:8dc7:: with SMTP id j7mr23429901pfr.169.1590515686611;
 Tue, 26 May 2020 10:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200517152916.3146539-1-brgerst@gmail.com> <20200517152916.3146539-3-brgerst@gmail.com>
 <CAKwvOdnCcpS_9A2y9tMqeiAg2NfcVx=gNeA2V=+zHknit7wGkg@mail.gmail.com>
 <CAMzpN2gGbZABjtLQyiTdtaL5LYW-cfVQZqj6w=oZNa9Fw9GdCQ@mail.gmail.com>
 <CAKwvOdmwh92BP2=-d4Apr07i6uKb21M15MAz-v4S5RfQ16-fPA@mail.gmail.com> <CAMzpN2hp3HYKriW6p-m3hLJ8v79Og9emu5xPQvb7aWqXq4wUbA@mail.gmail.com>
In-Reply-To: <CAMzpN2hp3HYKriW6p-m3hLJ8v79Og9emu5xPQvb7aWqXq4wUbA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 May 2020 10:54:35 -0700
Message-ID: <CAKwvOdn0q77vT8XCRwdgi5LU2yFVEqyhG1Se72gGNR4Tr173_w@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 6:06 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> On Wed, May 20, 2020 at 1:26 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Mon, May 18, 2020 at 8:38 PM Brian Gerst <brgerst@gmail.com> wrote:
> > >
> > > On Mon, May 18, 2020 at 5:15 PM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > >
> > > > On Sun, May 17, 2020 at 8:29 AM Brian Gerst <brgerst@gmail.com> wro=
te:
> > > > >
> > > > > The core percpu macros already have a switch on the data size, so=
 the switch
> > > > > in the x86 code is redundant and produces more dead code.
> > > > >
> > > > > Also use appropriate types for the width of the instructions.  Th=
is avoids
> > > > > errors when compiling with Clang.
> > > > >
> > > > > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > > > > ---
> > > > >  arch/x86/include/asm/percpu.h | 90 ++++++++++++++---------------=
------
> > > > >  1 file changed, 35 insertions(+), 55 deletions(-)
> > > > >
> > > > > diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm=
/percpu.h
> > > > > index 89f918a3e99b..233c7a78d1a6 100644
> > > > > --- a/arch/x86/include/asm/percpu.h
> > > > > +++ b/arch/x86/include/asm/percpu.h
> > > > > @@ -117,37 +117,17 @@ extern void __bad_percpu_size(void);
> > > > >  #define __pcpu_reg_imm_4(x) "ri" (x)
> > > > >  #define __pcpu_reg_imm_8(x) "re" (x)
> > > > >
> > > > > -#define percpu_to_op(qual, op, var, val)               \
> > > > > -do {                                                   \
> > > > > -       typedef typeof(var) pto_T__;                    \
> > > > > -       if (0) {                                        \
> > > > > -               pto_T__ pto_tmp__;                      \
> > > > > -               pto_tmp__ =3D (val);                      \
> > > > > -               (void)pto_tmp__;                        \
> > > > > -       }                                               \
> > > > > -       switch (sizeof(var)) {                          \
> > > > > -       case 1:                                         \
> > > > > -               asm qual (op "b %1,"__percpu_arg(0)     \
> > > > > -                   : "+m" (var)                        \
> > > > > -                   : "qi" ((pto_T__)(val)));           \
> > > > > -               break;                                  \
> > > > > -       case 2:                                         \
> > > > > -               asm qual (op "w %1,"__percpu_arg(0)     \
> > > > > -                   : "+m" (var)                        \
> > > > > -                   : "ri" ((pto_T__)(val)));           \
> > > > > -               break;                                  \
> > > > > -       case 4:                                         \
> > > > > -               asm qual (op "l %1,"__percpu_arg(0)     \
> > > > > -                   : "+m" (var)                        \
> > > > > -                   : "ri" ((pto_T__)(val)));           \
> > > > > -               break;                                  \
> > > > > -       case 8:                                         \
> > > > > -               asm qual (op "q %1,"__percpu_arg(0)     \
> > > > > -                   : "+m" (var)                        \
> > > > > -                   : "re" ((pto_T__)(val)));           \
> > > > > -               break;                                  \
> > > > > -       default: __bad_percpu_size();                   \
> > > > > -       }                                               \
> > > > > +#define percpu_to_op(size, qual, op, _var, _val)                =
       \
> > > > > +do {                                                            =
       \
> > > > > +       __pcpu_type_##size pto_val__ =3D __pcpu_cast_##size(_val)=
;        \
> > > > > +       if (0) {                                                 =
       \
> > > > > +               typeof(_var) pto_tmp__;                          =
       \
> > > > > +               pto_tmp__ =3D (_val);                            =
         \
> > > > > +               (void)pto_tmp__;                                 =
       \
> > > > > +       }                                                        =
       \
> > > >
> > > > Please replace the whole `if (0)` block with:
> > > > ```c
> > > > __same_type(_var, _val);
> > > > ```
> > > > from include/linux/compiler.h.
> > >
> > > The problem with __builtin_types_compatible_p() is that it considers
> > > unsigned long and u64 (aka unsigned long long) as different types eve=
n
> > > though they are the same width on x86-64.  While this may be a good
> > > cleanup to look at in the future, it's not a simple drop-in
> > > replacement.
> >
> > Does it trigger errors in this case?
>
> Yes, see boot_init_stack_canary().  That code looks a bit sketchy but
> it's not wrong, for x86-64 at least.
>
> It also doesn't seem to like "void *" compared to any other pointer type:
>
> In function =E2=80=98fpregs_deactivate=E2=80=99,
>     inlined from =E2=80=98fpu__drop=E2=80=99 at arch/x86/kernel/fpu/core.=
c:285:3:
> ./include/linux/compiler.h:379:38: error: call to
> =E2=80=98__compiletime_assert_317=E2=80=99 declared with attribute error:=
 BUILD_BUG_ON
> failed: !__same_type((fpu_fpregs_owner_ctx), ((void *)0))
>   379 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COU=
NTER__)
>       |                                      ^
> ./include/linux/compiler.h:360:4: note: in definition of macro
> =E2=80=98__compiletime_assert=E2=80=99
>   360 |    prefix ## suffix();    \
>       |    ^~~~~~
> ./include/linux/compiler.h:379:2: note: in expansion of macro
> =E2=80=98_compiletime_assert=E2=80=99
>   379 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COU=
NTER__)
>       |  ^~~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:39:37: note: in expansion of macro
> =E2=80=98compiletime_assert=E2=80=99
>    39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), m=
sg)
>       |                                     ^~~~~~~~~~~~~~~~~~
> ./include/linux/build_bug.h:50:2: note: in expansion of macro =E2=80=98BU=
ILD_BUG_ON_MSG=E2=80=99
>    50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
>       |  ^~~~~~~~~~~~~~~~
> ./arch/x86/include/asm/percpu.h:105:2: note: in expansion of macro
> =E2=80=98BUILD_BUG_ON=E2=80=99
>   105 |  BUILD_BUG_ON(!__same_type(_var, _val));    \
>       |  ^~~~~~~~~~~~
> ./arch/x86/include/asm/percpu.h:338:37: note: in expansion of macro
> =E2=80=98percpu_to_op=E2=80=99
>   338 | #define this_cpu_write_8(pcp, val)  percpu_to_op(8, volatile,
> "mov", (pcp), val)
>       |                                     ^~~~~~~~~~~~
> ./include/linux/percpu-defs.h:380:11: note: in expansion of macro
> =E2=80=98this_cpu_write_8=E2=80=99
>   380 |   case 8: stem##8(variable, __VA_ARGS__);break;  \
>       |           ^~~~
> ./include/linux/percpu-defs.h:508:34: note: in expansion of macro
> =E2=80=98__pcpu_size_call=E2=80=99
>   508 | #define this_cpu_write(pcp, val)
> __pcpu_size_call(this_cpu_write_, pcp, val)
>       |                                  ^~~~~~~~~~~~~~~~
> ./arch/x86/include/asm/fpu/internal.h:525:2: note: in expansion of
> macro =E2=80=98this_cpu_write=E2=80=99
>   525 |  this_cpu_write(fpu_fpregs_owner_ctx, NULL);
>       |  ^~~~~~~~~~~~~~
>
> >
> > It's interesting to know how this trick differs from
> > __builtin_types_compatible_p().  Might even be helpful to wrap this
> > pattern in a macro with a comment with the pros/cons of this approach
> > vs __same_type.
>
> I think the original code is more to catch a mismatch between pointers
> and integers.  It doesn't seem to care about truncation
>
> > On the other hand, the use of `long` seems tricky in x86 code as x86
> > (32b) is ILP32 but x86_64 (64b) is LP64.  So the use of `long` is
> > ambiguous in the sense that it's a different size depending on the
> > target ABI.  Wouldn't it potentially be a bug for x86 kernel code to
> > use `long` percpu variables (or rather mix `long` and `long long` in
> > the same operation) in that case, since the sizes of the two would be
> > different for i386?
>
> Not necessarily.  Some things like registers are naturally 32-bit on a
> 32-bit kernel and 64-bit on a 64-bit kernel, so 'long' is appropriate
> there.

Sorry for not getting back to this sooner, amazing how fast emails get
buried in an inbox.

Interesting findings.  Feels almost like a _Static_assert that the
sizeof these types match might be more straightforward, but I don't
need to nitpick pre-existing code that this patch simply carries
forward.  I realized I never signed off on this.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

It looks like there's still an outstanding issue with patch 4/7?
https://lore.kernel.org/lkml/CAKwvOdnVU3kZnGzkYjEFJWMPuVjOmAHuRSB8FJ-Ks+FWz=
X2M_Q@mail.gmail.com/
--=20
Thanks,
~Nick Desaulniers
