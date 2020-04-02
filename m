Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D91AC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA7120675
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cTvopqsv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388381AbgDBSWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:22:16 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:43490 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbgDBSWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:22:16 -0400
Received: by mail-vk1-f196.google.com with SMTP id v129so1212675vkf.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 11:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2UQRYNvKvusZq1CNM2OiULfI/O5UBgDCnpol3ajdzr4=;
        b=cTvopqsvlFzBQ+scHoLdph1rkaUo8FxIt1QUrO45XhpTdABgMZBP9BnDAt2/ZQFayT
         jm6Oe5z6AID5mB/EeVEZ4yNW7CwVhy7FX9Hl1K3JFriYoVkMkfwgy7+i3gKH1zuwAmSz
         Xbhav/9izB9kkbrnLANJWRLYP+u7+K55TThUwF7y2nYturX1C0ks9sEbNRmq3+hQTUee
         b5Hd4ySETzw6SKuBZqOGQScQbBfIHCXz4pyvtIR7H2wnyXhlSXRpIh0OLsNzIu4UazZd
         FL3E98+kKMQG6SmQ3QNUUTTwiW64oMewOZvKYnz6sfeQits6P4Yhp4fdFej/1tdDK/7u
         Gnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2UQRYNvKvusZq1CNM2OiULfI/O5UBgDCnpol3ajdzr4=;
        b=ixKXouwjYX6T4GrOO3SVy2s/NlOja7dVLOUlVjj3GGTcmY3jX5VHFT2k7NW62HppdD
         nRV/xJe8nDbapR57meXIZkHAbLl2SmcSKvge+WWrn0wgZ2Tp3vdlnOO4OYzLM7dcBxw/
         r8al+p4eIqLlMWj1cV8fVc9HD+vpPGoRq319e1L5X7YoqvJraMAt5PZZr3AoV5Sh3hL5
         nF1ARpo64EDgnF71AD1+2IX0uzM73Vg7q7lO5w/hPAPuRmQfh4s5RKaaRuI3PH2u0FPW
         Nzy7XGY2zK0J3nEkoSKNM9w55hjzP+GpZ92oV9+5RuyK8WICHw9TXuYn/OBsZjjJhiLq
         SBuA==
X-Gm-Message-State: AGi0PuaD0keic3N+HxCvZnxjSaqOgHk4mUhSUTW1sY43uHuwnGhqwZ2J
        aSE097Utw0VYAy8fQwjEdaUCwwUhRwKoxZ+H4PSPpg==
X-Google-Smtp-Source: APiQypJ/M3oQw7JsPNDJ+qCIC9xOjZVgvdI/Qjt+HJ5LAoB4q2sCQGSJdbewJQPfQOrwv8MFMy5guoxMEYu78gHFtSY=
X-Received: by 2002:a1f:5003:: with SMTP id e3mr3198682vkb.59.1585851733351;
 Thu, 02 Apr 2020 11:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <202004020117.6E434C035@keescook> <CAK7LNAQGTAgtADfY4H-k8X1J9nTMeOWvo8ZFfrUSHQUbhgcLKw@mail.gmail.com>
In-Reply-To: <CAK7LNAQGTAgtADfY4H-k8X1J9nTMeOWvo8ZFfrUSHQUbhgcLKw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 2 Apr 2020 11:22:02 -0700
Message-ID: <CAKwvOdnO_-jiQzCmy7pQNMGmZsgD9J=PYXVzOQ1NF1+u44MsOA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: mkcompile_h: Include $LD version in /proc/version
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sandeep Patil <sspatil@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 10:02 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi Kees,
>
> On Thu, Apr 2, 2020 at 5:18 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > When doing Clang builds of the kernel, it is possible to link with
> > either ld.bfd (binutils) or ld.lld (LLVM), but it is not possible to
> > discover this from a running kernel. Add the "$LD -v" output to
> > /proc/version.
> >
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  init/Makefile       | 2 +-
> >  scripts/mkcompile_h | 8 ++++++--
> >  2 files changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/init/Makefile b/init/Makefile
> > index 6246a06364d0..82c15bdb42d7 100644
> > --- a/init/Makefile
> > +++ b/init/Makefile
> > @@ -35,4 +35,4 @@ include/generated/compile.h: FORCE
> >         @$($(quiet)chk_compile.h)
> >         $(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@   \
> >         "$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT)"    \
> > -       "$(CONFIG_PREEMPT_RT)" "$(CC) $(KBUILD_CFLAGS)"
> > +       "$(CONFIG_PREEMPT_RT)" "$(LD)" "$(CC) $(KBUILD_CFLAGS)"
> > diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
> > index 3a5a4b210c86..f98c07709370 100755
> > --- a/scripts/mkcompile_h
> > +++ b/scripts/mkcompile_h
> > @@ -6,7 +6,8 @@ ARCH=$2
> >  SMP=$3
> >  PREEMPT=$4
> >  PREEMPT_RT=$5
> > -CC=$6
> > +LD=$6
> > +CC=$7
>
>
> Just a nit.
>
> If you just append 'LD',
> you do not need to touch the 'CC=$6' line.
>
>
> If you do not mind, I will fold the following
> on top of your patch.

With Kees patch + Masahiro's diff applied:
$ cat /proc/version
Linux version 5.6.0-rc7-next-20200330+ (ndesaulniers@<hostname
scrubbed>) (clang version 11.0.0 (git@github.com:llvm/llvm-project.git
6d71daed03ced011cd25f4e4f4122a368fdc757d), LLD 11.0.0
(git@github.com:llvm/llvm-project.git
6d71daed03ced011cd25f4e4f4122a368fdc757d)) #167 SMP Thu Apr 2 11:17:36
PDT 2020

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

We could actually use this in Android for a VTS test I've, uh, been
meaning to write.  Also, LOL at scrubbing the "compatible with" part,
reminds me of user agent strings in the browser, which are god awful.


> --- a/init/Makefile
> +++ b/init/Makefile
> @@ -35,4 +35,4 @@ include/generated/compile.h: FORCE
>         @$($(quiet)chk_compile.h)
>         $(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkcompile_h $@   \
>         "$(UTS_MACHINE)" "$(CONFIG_SMP)" "$(CONFIG_PREEMPT)"    \
> -       "$(CONFIG_PREEMPT_RT)" "$(LD)" "$(CC) $(KBUILD_CFLAGS)"
> +       "$(CONFIG_PREEMPT_RT)" "$(CC) $(KBUILD_CFLAGS)" "$(LD)"
> diff --git a/scripts/mkcompile_h b/scripts/mkcompile_h
> index 8b38a96163e2..5b80a4699740 100755
> --- a/scripts/mkcompile_h
> +++ b/scripts/mkcompile_h
> @@ -6,8 +6,8 @@ ARCH=$2
>  SMP=$3
>  PREEMPT=$4
>  PREEMPT_RT=$5
> -LD=$6
> -CC=$7
> +CC=$6
> +LD=$7


-- 
Thanks,
~Nick Desaulniers
