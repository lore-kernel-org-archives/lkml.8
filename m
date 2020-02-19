Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C279C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5EF224656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vWlJsiND"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgBSJfe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:35:34 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36652 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgBSJfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:35:33 -0500
Received: by mail-pg1-f193.google.com with SMTP id d9so12442834pgu.3;
        Wed, 19 Feb 2020 01:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XHwhZR1aZjPYv0PmkX/Vd7zZe4RwwVtxuCpFzogn/FE=;
        b=vWlJsiNDnJ1GB/fTvfLeoH/hxZWTvy0Z4Eb/wS13XIb26me96HiX9MJtdhRRnZZoom
         5+4D+qomsSUUhE5gjGTkKyqCO8F+rHvGleSuCJiqcB5c8QDh7fndrlXR0wcK3JHcTjdP
         Zq7myTRAN5olGp4khMFesUmEo4gV7x9zVRDCGkp01J6lP2cOiCbVLAx6jQFHuevHutaK
         +kmXUsRRTvvI/G8JrFSy8sIqBUA0LcWZBC5Xi7noKn710QHg/FOtdhl0hdmuiQ9NsqfQ
         bFYbzSmoj3zOHc2ooOgDhYeGhW1H1r6nysEoMHv/fP/fWBFKT6q5nAzZUT0thTDPrtBz
         v5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XHwhZR1aZjPYv0PmkX/Vd7zZe4RwwVtxuCpFzogn/FE=;
        b=ehgrAcbANBGVhqrzauQtk8VroKkdagek62blWAM53h+By7vW+V+MZl1M2+ul1m7Ulk
         oP393TcB7nXVzXr2bO9ODm+BjiI+N8mntQ1QMyvrVsLrZ+GyUvhZG+L5ELSpwLUeUOtM
         e0x16hbo+rR2p3wz9om/4ZA4gp3ZPKDGAaSbGswLkXVii5TOB1YAzZlJhMFoosGqPNyU
         GDyS1UFRe887fyMRcGVuNrRObMHwrLiHZYwRY27yAC0PIF18hkOO4D5PhbbOMcdAWgcK
         c+8vnBdNI44QfjOmniFUWaP2rN+ettdoy8eY/ttwTqGi+fpAvLHASSY+7acOaCGfL/ap
         Y2/A==
X-Gm-Message-State: APjAAAW9H08QD0KEZ3p9s49S8vEScE6dWc5e/libhs3fYjysxBSC8Rtj
        jAeswY0dAjjpWa2Z8ckuDHehT0QRvAYLHAzb9OzoXkaJ93Y=
X-Google-Smtp-Source: APXvYqwHy4+ki6LvqfM1U6+wN/+xYkIf7WUyGmP+FmHfs0ItzrgZx8wPzNyYMXSycYZmCTL+L5N0/X9iKXgC1YFhgbM=
X-Received: by 2002:a62:52d0:: with SMTP id g199mr25197889pfb.241.1582104932745;
 Wed, 19 Feb 2020 01:35:32 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
 <20200219082155.6787-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20200219082155.6787-1-linux@rasmusvillemoes.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Feb 2020 11:35:25 +0200
Message-ID: <CAHp75Vd865FYQFUk56ej-vaDj2M-5=3XjQ3rKzoJQhZMsEZuyg@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: sanely handle NULL passed to %pe
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ilya Dryomov <idryomov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 10:24 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Extend %pe to pretty-print NULL in addition to ERR_PTRs,
> i.e. everything IS_ERR_OR_NULL().
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
One nit below, though.

> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> Something like this? The actual code change is +2,-1 with another +1
> for a test case.
>
>  Documentation/core-api/printk-formats.rst | 9 +++++----
>  lib/errname.c                             | 4 ++++
>  lib/test_printf.c                         | 1 +
>  lib/vsprintf.c                            | 4 ++--
>  4 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/core-api/printk-formats.rst b/Documentation/core-api/printk-formats.rst
> index 8ebe46b1af39..964b55291445 100644
> --- a/Documentation/core-api/printk-formats.rst
> +++ b/Documentation/core-api/printk-formats.rst
> @@ -86,10 +86,11 @@ Error Pointers
>
>         %pe     -ENOSPC
>
> -For printing error pointers (i.e. a pointer for which IS_ERR() is true)
> -as a symbolic error name. Error values for which no symbolic name is
> -known are printed in decimal, while a non-ERR_PTR passed as the
> -argument to %pe gets treated as ordinary %p.

> +For printing error pointers (i.e. a pointer for which IS_ERR() is
> +true) as a symbolic error name. Error values for which no symbolic

Why to reformat these lines?

> +name is known are printed in decimal. A NULL pointer is printed as
> +NULL. All other pointer values (i.e. anything !IS_ERR_OR_NULL()) get
> +treated as ordinary %p.
>
>  Symbols/Function Pointers
>  -------------------------
> diff --git a/lib/errname.c b/lib/errname.c
> index 0c4d3e66170e..7757bc00f564 100644
> --- a/lib/errname.c
> +++ b/lib/errname.c
> @@ -11,9 +11,13 @@
>   * allocated errnos (with EHWPOISON = 257 on parisc, and EDQUOT = 1133
>   * on mips), so this wastes a bit of space on those - though we
>   * special case the EDQUOT case.
> + *
> + * For the benefit of %pe being able to print any ERR_OR_NULL pointer
> + * symbolically, 0 is also treated specially.
>   */
>  #define E(err) [err + BUILD_BUG_ON_ZERO(err <= 0 || err > 300)] = "-" #err
>  static const char *names_0[] = {
> +       [0] = "NULL",
>         E(E2BIG),
>         E(EACCES),
>         E(EADDRINUSE),
> diff --git a/lib/test_printf.c b/lib/test_printf.c
> index 2d9f520d2f27..3a37d0e9e735 100644
> --- a/lib/test_printf.c
> +++ b/lib/test_printf.c
> @@ -641,6 +641,7 @@ errptr(void)
>         test("[-EIO    ]", "[%-8pe]", ERR_PTR(-EIO));
>         test("[    -EIO]", "[%8pe]", ERR_PTR(-EIO));
>         test("-EPROBE_DEFER", "%pe", ERR_PTR(-EPROBE_DEFER));
> +       test("[NULL]", "[%pe]", NULL);
>  #endif
>  }
>
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 7c488a1ce318..b7118d78eb20 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -2247,8 +2247,8 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
>         case 'x':
>                 return pointer_string(buf, end, ptr, spec);
>         case 'e':
> -               /* %pe with a non-ERR_PTR gets treated as plain %p */
> -               if (!IS_ERR(ptr))
> +               /* %pe with a non-ERR_OR_NULL ptr gets treated as plain %p */
> +               if (!IS_ERR_OR_NULL(ptr))
>                         break;
>                 return err_ptr(buf, end, ptr, spec);
>         }
> --
> 2.23.0
>


-- 
With Best Regards,
Andy Shevchenko
