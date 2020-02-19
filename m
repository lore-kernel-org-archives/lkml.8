Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AD8C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ABD8206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 11:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lqrMZzD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgBSLU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 06:20:27 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:38481 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgBSLU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 06:20:27 -0500
Received: by mail-il1-f193.google.com with SMTP id f5so20259332ilq.5;
        Wed, 19 Feb 2020 03:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wlG3nAa6BYD+iSp33UrqkLf/yy6E18oediW8a3IHWEE=;
        b=lqrMZzD75cIs1XvYxtvW/PfD/BoQl24mKjNsYCd6y/97XIQT6pJHdKQvlURlGAn5ji
         9Kng8T8BBQAVnuttwpOZEIB+rvcYhxrv4uUrX3xZd63KuUDvT90rqqugMLDgpHNfONVU
         LzTYhqlQ1dE53RZU0SAi18BpeklsaEI4VmogQl2Y+VhMaEKXnDkmDXlYMPJ9PH29lUZV
         WqQdiopEXJYdFpHqqHN41Q0dE6hiyh9f7I9/ssz80F0hEPTfwH+xu5orFtNJFMTSfPIV
         UNx0gmq06kljo9YkbVLDHDGC00zFrgpvQAi1Mc99Brv2BedjxjVa+/vjBSRKxhokYG73
         1sag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wlG3nAa6BYD+iSp33UrqkLf/yy6E18oediW8a3IHWEE=;
        b=fQkUud1ETtQymdXKcN8PvVl8USykAqN3/JlMvVXyOENishbfpR/yPC4gI9B1soboBf
         iZPpG1E4cotHyIlfKsOEBMiBnze7dyoze9rPJoI1nEV/ms2kU5MGAtnkF+4UQjjLZfe+
         wAMt+yodsjkjZFdBpimoo7czyUGMRwN+2gqlICJ77Bj7Ed6EUGMt7manR82evIHiSOn7
         Dp6+CQbfbZuR/tt8i1GWybEAw8UHTZq5zmau1HUloMAt1vX+ExezIpDP2Ly1j5ikGUH5
         BUFG0CPMQPrCPG8mNs0uvOuzYzae9a9P6QgpnedcJ6mLSrrSLUbw/AkGv5+S0gebOgUC
         sDnw==
X-Gm-Message-State: APjAAAWOrI/p+yuoqYjo/cgDoh2J8gxXjgqnj11xZRp61+0KfPa7W6yV
        P8xnf3JEhBMR8TLwhZS4aAvkej0mU6YjGOq1FYs=
X-Google-Smtp-Source: APXvYqxe3KWnktEfzpmKptdMszpnXSJm8A5UxsbKU39uxO1rNDKE7wgLIqdm+nZ9iVSSMOkm7yfbWcV56Fb0MZ54YQA=
X-Received: by 2002:a92:3a8d:: with SMTP id i13mr25028030ilf.112.1582111226499;
 Wed, 19 Feb 2020 03:20:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjEd-gZ1g52kgi_g8gq-QCF2E01TkQd5Hmj4W5aThLw3A@mail.gmail.com>
 <20200219082155.6787-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20200219082155.6787-1-linux@rasmusvillemoes.dk>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Wed, 19 Feb 2020 12:20:53 +0100
Message-ID: <CAOi1vP-4=QCSZ2A89g1po2p=6n_g09SXUCa0_r2SBJm2greRmw@mail.gmail.com>
Subject: Re: [PATCH] vsprintf: sanely handle NULL passed to %pe
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 9:21 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Extend %pe to pretty-print NULL in addition to ERR_PTRs,
> i.e. everything IS_ERR_OR_NULL().
>
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

FWIW I was about to post a patch that just special cases NULL here.

I think changing errname() to return "NULL" for 0 is overkill.
People will sooner or later discover that function and start using it
in contexts that don't have anything to do with pointers.  Returning
_some_ string for 0 (instead of NULL) makes it very close to standard
strerror(), and "NULL" for 0 (i.e. success) seems rather odd.

Thanks,

                Ilya
