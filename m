Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3079DC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC38524656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 18:06:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKInHGSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgBSSGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 13:06:46 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:36137 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgBSSGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 13:06:45 -0500
Received: by mail-io1-f65.google.com with SMTP id d15so1591439iog.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 10:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lh9HDmiIL2+C6gKZFkkGaBll4E2H2sF+884fA79a3d4=;
        b=OKInHGSKvIkqurX1aNTcyJ5ZRSa99BcEVRAEw2dytl0WWVormMy+BNoYv2PhuWZg/J
         O+DlL7WwCVTj1WuJcoFPIQsDb6tKsiHotMHwQ4MYGMDjT9Mm2sxDCU7CTMFLeHQj3Ltq
         PfczyxtesAHl5KW7TobIH+e1VxayU21t97tT/V45NFJj2i3hdwBP/zEqLlgQEw+GMTDP
         fei14aYzXuov9cqupGB0xWLve/ofzYAAULe6TVWfjcDQiJvTiu5Y3LGXTWeHpqUeG1Ey
         kxkVbp7nPQuwN/lNspRFq8jHZq7tRJMdTAAInZhnhd38Uxc8fmN10h/zcNPJYAvFfAHw
         J5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lh9HDmiIL2+C6gKZFkkGaBll4E2H2sF+884fA79a3d4=;
        b=YtYUK5To7WDrjE1unt8A6xPtSRk++/7tEHhTkKMpINIqxuG+0Vo1sRgEV80h2PsFKj
         3l1Z/eGww6V4voGnMQgaVSGhSL5Ak0Vw8Jhzqc1mguc0+1ib0xpBIbqYjm04HqP1yil5
         yEaYamj8DoncnA7leIQGtWl2gX88YcwB4h2Fnd7EjQUz/lvQR1YkXF0nPuLRgU5k3QX4
         Ixxjq7RYXtJ5ADGnDcsKt3YSebuRAmkcEpft5+O9+iT8uD0zRMAo9t7GfBXI90qR97hS
         q9smRdVHhzNNntzaZJx6qdl3n7nMm5SRjM1GM4UwQBeiuxwsxMCdNi3J8vUi7Bn5hZew
         6+eA==
X-Gm-Message-State: APjAAAVm7Av3o4vtgjnJ/uWFA/C21pfPdUgjWdsWxpIWnWHEs0c246v4
        gxxQu/6wDr5RzKA1UP2zO2jaNS0TA+/oPTU/irYRjV1PyMhZ4A==
X-Google-Smtp-Source: APXvYqzqHSgJKe/YwJXPDuKTakGoCeik+JiiUjpLCGoFJgSHMe5t+EuCEAcw+2EL0ThP568dhesTAnpv2qdBsqcPE/4=
X-Received: by 2002:a6b:1781:: with SMTP id 123mr19791852iox.282.1582135604653;
 Wed, 19 Feb 2020 10:06:44 -0800 (PST)
MIME-Version: 1.0
References: <20200219171225.5547-1-idryomov@gmail.com> <CAHp75Vf24yNeLEweq_70AUzKwbdyurB6ze9739Qy9djA9dSefg@mail.gmail.com>
In-Reply-To: <CAHp75Vf24yNeLEweq_70AUzKwbdyurB6ze9739Qy9djA9dSefg@mail.gmail.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 19 Feb 2020 19:07:10 +0100
Message-ID: <CAOi1vP9gfMoU14Ax+VLksQ+_3yOO3m3bh0Uh02SUMfPFDDEW9g@mail.gmail.com>
Subject: Re: [PATCH v2] vsprintf: don't obfuscate NULL and error pointers
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 6:37 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Feb 19, 2020 at 7:13 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> >
> > I don't see what security concern is addressed by obfuscating NULL
> > and IS_ERR() error pointers, printed with %p/%pK.  Given the number
> > of sites where %p is used (over 10000) and the fact that NULL pointers
> > aren't uncommon, it probably wouldn't take long for an attacker to
> > find the hash that corresponds to 0.  Although harder, the same goes
> > for most common error values, such as -1, -2, -11, -14, etc.
> >
> > The NULL part actually fixes a regression: NULL pointers weren't
> > obfuscated until commit 3e5903eb9cff ("vsprintf: Prevent crash when
> > dereferencing invalid pointers") which went into 5.2.  I'm tacking
> > the IS_ERR() part on here because error pointers won't leak kernel
> > addresses and printing them as pointers shouldn't be any different
> > from e.g. %d with PTR_ERR_OR_ZERO().  Obfuscating them just makes
> > debugging based on existing pr_debug and friends excruciating.
> >
> > Note that the "always print 0's for %pK when kptr_restrict == 2"
> > behaviour which goes way back is left as is.
> >
> > Example output with the patch applied:
> >
> >                             ptr         error-ptr              NULL
> > %p:            0000000001f8cc5b  fffffffffffffff2  0000000000000000
> > %pK, kptr = 0: 0000000001f8cc5b  fffffffffffffff2  0000000000000000
> > %px:           ffff888048c04020  fffffffffffffff2  0000000000000000
> > %pK, kptr = 1: ffff888048c04020  fffffffffffffff2  0000000000000000
> > %pK, kptr = 2: 0000000000000000  0000000000000000  0000000000000000
>
> ...
>
> > +/*
> > + * NULL pointers aren't hashed.
> > + */
> >  static void __init
> >  null_pointer(void)
> >  {
> > -       test_hashed("%p", NULL);
> > +       test(ZEROS "00000000", "%p", NULL);
> >         test(ZEROS "00000000", "%px", NULL);
> >         test("(null)", "%pE", NULL);
> >  }
> >
> > +/*
> > + * Error pointers aren't hashed.
> > + */
> > +static void __init
> > +error_pointer(void)
> > +{
> > +       test(ONES "fffffff5", "%p", ERR_PTR(-EAGAIN));
> > +       test(ONES "fffffff5", "%px", ERR_PTR(-EAGAIN));
>
> > +       test("(efault)", "%pE", ERR_PTR(-EAGAIN));
>
> Hmm... Is capital E on purpose here?

Yes.  It shows that for %pE an error pointer is still invalid.
%pe is tested separately, in errptr(), and the output would have
been "-EAGAIN".

> Maybe we may use something else ('%ph'?) for sake of deviation?

If you look at the resulting file, you will see that null_pointer(),
error_pointer() and invalid_pointer() exercise the same three variants:
%p, %px and %pE.

This is somewhat confusing, but there seems to be some disagreement
between Pavel and Rasmus as to how the test suite should be structured
and I didn't want to attempt to restructure anything in this patch.

Thanks,

                Ilya
