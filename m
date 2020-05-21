Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11CAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F9020721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uoQvM8t8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgEUNGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729197AbgEUNGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:06:25 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E23C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:06:23 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id j2so6996755ilr.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Nba/iQzCaQZaoQ9dfuHPIBatK3UepU1/Wzggh2dhaQ=;
        b=uoQvM8t8pCAi5A7WQf5EuOlVQSD2njRfV5FxYDsNigQBp0J766Cm69DVqjS7jxqNye
         vRIB7oh/lrU17H37lyC7VJH5xzn7CWhym+x3BgdomzJuMUbv7JyzXN9vEPuEsVvodBKX
         xUvkDkltprMtoQpMNUkucHJ8/RJ0Hd6GFFgyPMxiSHe1C/w8GVnSrP8Z8/fgabpYFeL8
         hwlU3aXBvq7k22p4lOvTFulmvEccTUwk5hL6lp1sUcT2CJ9iqnu9wdqHZ5omyUX/D4ad
         FCPpKud3fqogjtn/NW8rlzq5O2buxGycST2/xBXNm2kx76yL08lh5Lq5sdkUOaJyxGHK
         L24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Nba/iQzCaQZaoQ9dfuHPIBatK3UepU1/Wzggh2dhaQ=;
        b=HdXoGZDZu2F6d24tUboP295XWCC1MWDQs3lTzCbGDOURKpzZ6EdPaFTZvVJLH1XrWO
         y4aebJWvHX9U7fwYkUk/Lhh9nUe7ZMO6wgWWAP9zeNgun689VqkJ32HZj0zziIZGJ4Ce
         5unx1FJpWUcGAwftlsdbsPUmixrAd9q73K/zzC5Fpw9vx6pWXhGUOUJDIk0zAt0EPwDm
         pHwuQVpK8PeT14mtlWq/iG85z+CmPAKo1n3wTqhOZi8z9gHvmzC1KOfr2JsQk9mnUt8u
         xJ2CsFR5CM0ta5YwVteQQHsXm2C/LA/CeZSMmJ7ONp3GsZqGN1xJfpdGvEVi3KIiE8rl
         /KIw==
X-Gm-Message-State: AOAM532zsk/ko63ldugtn/5JTAPPqiFRlSXTDnOubpWR86LKHKe8UFZo
        xg3R/ue4sIKbQpM59s2gm/ubXbnFItQsTcAoq2jX6XR66Q==
X-Google-Smtp-Source: ABdhPJyu3EjZVcNJY1VmFqmg/K4QV9T3untcZqdj8mahG++KI35YWwW2RUhufOJF1tA5DbEO1gfMKZWPtssMRuX8v2g=
X-Received: by 2002:a92:4a09:: with SMTP id m9mr7897673ilf.27.1590066383167;
 Thu, 21 May 2020 06:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200517152916.3146539-1-brgerst@gmail.com> <20200517152916.3146539-3-brgerst@gmail.com>
 <CAKwvOdnCcpS_9A2y9tMqeiAg2NfcVx=gNeA2V=+zHknit7wGkg@mail.gmail.com>
 <CAMzpN2gGbZABjtLQyiTdtaL5LYW-cfVQZqj6w=oZNa9Fw9GdCQ@mail.gmail.com> <CAKwvOdmwh92BP2=-d4Apr07i6uKb21M15MAz-v4S5RfQ16-fPA@mail.gmail.com>
In-Reply-To: <CAKwvOdmwh92BP2=-d4Apr07i6uKb21M15MAz-v4S5RfQ16-fPA@mail.gmail.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 21 May 2020 09:06:12 -0400
Message-ID: <CAMzpN2hp3HYKriW6p-m3hLJ8v79Og9emu5xPQvb7aWqXq4wUbA@mail.gmail.com>
Subject: Re: [PATCH 2/7] x86/percpu: Clean up percpu_to_op()
To:     Nick Desaulniers <ndesaulniers@google.com>
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

On Wed, May 20, 2020 at 1:26 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, May 18, 2020 at 8:38 PM Brian Gerst <brgerst@gmail.com> wrote:
> >
> > On Mon, May 18, 2020 at 5:15 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Sun, May 17, 2020 at 8:29 AM Brian Gerst <brgerst@gmail.com> wrote=
:
> > > >
> > > > The core percpu macros already have a switch on the data size, so t=
he switch
> > > > in the x86 code is redundant and produces more dead code.
> > > >
> > > > Also use appropriate types for the width of the instructions.  This=
 avoids
> > > > errors when compiling with Clang.
> > > >
> > > > Signed-off-by: Brian Gerst <brgerst@gmail.com>
> > > > ---
> > > >  arch/x86/include/asm/percpu.h | 90 ++++++++++++++-----------------=
----
> > > >  1 file changed, 35 insertions(+), 55 deletions(-)
> > > >
> > > > diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/p=
ercpu.h
> > > > index 89f918a3e99b..233c7a78d1a6 100644
> > > > --- a/arch/x86/include/asm/percpu.h
> > > > +++ b/arch/x86/include/asm/percpu.h
> > > > @@ -117,37 +117,17 @@ extern void __bad_percpu_size(void);
> > > >  #define __pcpu_reg_imm_4(x) "ri" (x)
> > > >  #define __pcpu_reg_imm_8(x) "re" (x)
> > > >
> > > > -#define percpu_to_op(qual, op, var, val)               \
> > > > -do {                                                   \
> > > > -       typedef typeof(var) pto_T__;                    \
> > > > -       if (0) {                                        \
> > > > -               pto_T__ pto_tmp__;                      \
> > > > -               pto_tmp__ =3D (val);                      \
> > > > -               (void)pto_tmp__;                        \
> > > > -       }                                               \
> > > > -       switch (sizeof(var)) {                          \
> > > > -       case 1:                                         \
> > > > -               asm qual (op "b %1,"__percpu_arg(0)     \
> > > > -                   : "+m" (var)                        \
> > > > -                   : "qi" ((pto_T__)(val)));           \
> > > > -               break;                                  \
> > > > -       case 2:                                         \
> > > > -               asm qual (op "w %1,"__percpu_arg(0)     \
> > > > -                   : "+m" (var)                        \
> > > > -                   : "ri" ((pto_T__)(val)));           \
> > > > -               break;                                  \
> > > > -       case 4:                                         \
> > > > -               asm qual (op "l %1,"__percpu_arg(0)     \
> > > > -                   : "+m" (var)                        \
> > > > -                   : "ri" ((pto_T__)(val)));           \
> > > > -               break;                                  \
> > > > -       case 8:                                         \
> > > > -               asm qual (op "q %1,"__percpu_arg(0)     \
> > > > -                   : "+m" (var)                        \
> > > > -                   : "re" ((pto_T__)(val)));           \
> > > > -               break;                                  \
> > > > -       default: __bad_percpu_size();                   \
> > > > -       }                                               \
> > > > +#define percpu_to_op(size, qual, op, _var, _val)                  =
     \
> > > > +do {                                                              =
     \
> > > > +       __pcpu_type_##size pto_val__ =3D __pcpu_cast_##size(_val); =
       \
> > > > +       if (0) {                                                   =
     \
> > > > +               typeof(_var) pto_tmp__;                            =
     \
> > > > +               pto_tmp__ =3D (_val);                              =
       \
> > > > +               (void)pto_tmp__;                                   =
     \
> > > > +       }                                                          =
     \
> > >
> > > Please replace the whole `if (0)` block with:
> > > ```c
> > > __same_type(_var, _val);
> > > ```
> > > from include/linux/compiler.h.
> >
> > The problem with __builtin_types_compatible_p() is that it considers
> > unsigned long and u64 (aka unsigned long long) as different types even
> > though they are the same width on x86-64.  While this may be a good
> > cleanup to look at in the future, it's not a simple drop-in
> > replacement.
>
> Does it trigger errors in this case?

Yes, see boot_init_stack_canary().  That code looks a bit sketchy but
it's not wrong, for x86-64 at least.

It also doesn't seem to like "void *" compared to any other pointer type:

In function =E2=80=98fpregs_deactivate=E2=80=99,
    inlined from =E2=80=98fpu__drop=E2=80=99 at arch/x86/kernel/fpu/core.c:=
285:3:
./include/linux/compiler.h:379:38: error: call to
=E2=80=98__compiletime_assert_317=E2=80=99 declared with attribute error: B=
UILD_BUG_ON
failed: !__same_type((fpu_fpregs_owner_ctx), ((void *)0))
  379 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNT=
ER__)
      |                                      ^
./include/linux/compiler.h:360:4: note: in definition of macro
=E2=80=98__compiletime_assert=E2=80=99
  360 |    prefix ## suffix();    \
      |    ^~~~~~
./include/linux/compiler.h:379:2: note: in expansion of macro
=E2=80=98_compiletime_assert=E2=80=99
  379 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNT=
ER__)
      |  ^~~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:39:37: note: in expansion of macro
=E2=80=98compiletime_assert=E2=80=99
   39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg=
)
      |                                     ^~~~~~~~~~~~~~~~~~
./include/linux/build_bug.h:50:2: note: in expansion of macro =E2=80=98BUIL=
D_BUG_ON_MSG=E2=80=99
   50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
      |  ^~~~~~~~~~~~~~~~
./arch/x86/include/asm/percpu.h:105:2: note: in expansion of macro
=E2=80=98BUILD_BUG_ON=E2=80=99
  105 |  BUILD_BUG_ON(!__same_type(_var, _val));    \
      |  ^~~~~~~~~~~~
./arch/x86/include/asm/percpu.h:338:37: note: in expansion of macro
=E2=80=98percpu_to_op=E2=80=99
  338 | #define this_cpu_write_8(pcp, val)  percpu_to_op(8, volatile,
"mov", (pcp), val)
      |                                     ^~~~~~~~~~~~
./include/linux/percpu-defs.h:380:11: note: in expansion of macro
=E2=80=98this_cpu_write_8=E2=80=99
  380 |   case 8: stem##8(variable, __VA_ARGS__);break;  \
      |           ^~~~
./include/linux/percpu-defs.h:508:34: note: in expansion of macro
=E2=80=98__pcpu_size_call=E2=80=99
  508 | #define this_cpu_write(pcp, val)
__pcpu_size_call(this_cpu_write_, pcp, val)
      |                                  ^~~~~~~~~~~~~~~~
./arch/x86/include/asm/fpu/internal.h:525:2: note: in expansion of
macro =E2=80=98this_cpu_write=E2=80=99
  525 |  this_cpu_write(fpu_fpregs_owner_ctx, NULL);
      |  ^~~~~~~~~~~~~~

>
> It's interesting to know how this trick differs from
> __builtin_types_compatible_p().  Might even be helpful to wrap this
> pattern in a macro with a comment with the pros/cons of this approach
> vs __same_type.

I think the original code is more to catch a mismatch between pointers
and integers.  It doesn't seem to care about truncation

> On the other hand, the use of `long` seems tricky in x86 code as x86
> (32b) is ILP32 but x86_64 (64b) is LP64.  So the use of `long` is
> ambiguous in the sense that it's a different size depending on the
> target ABI.  Wouldn't it potentially be a bug for x86 kernel code to
> use `long` percpu variables (or rather mix `long` and `long long` in
> the same operation) in that case, since the sizes of the two would be
> different for i386?

Not necessarily.  Some things like registers are naturally 32-bit on a
32-bit kernel and 64-bit on a 64-bit kernel, so 'long' is appropriate
there.

--
Brian Gerst
