Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D6D9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 06:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C68D82087E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 06:38:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vjn+dT6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDJGiS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 02:38:18 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38361 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgDJGiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 02:38:17 -0400
Received: by mail-wm1-f65.google.com with SMTP id f20so1682017wmh.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 23:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=3YosXBMphFBPTyrYk/RdbHSh5tz3MJefldr296tJxNs=;
        b=Vjn+dT6RSkP4SXd4EAigedogTETClRN5OUv8bPPBIdh3k1J0oiDsg0cz7QCHWAh/Fk
         lmpV4KJ7By7X5jZ3FJ/ZBogm50ty6/nQCi5cpzEYS9zqMVlHmUhpbzOszrDmo0wiqg39
         kA/tdHzXAT2K8D001TWOM0KwkXzuqhVxpz42PVyT4EUeH4bg4xQZCf/qtruPHfyecmJD
         Q7DX/s8q8+vzIoqqeyR+VgGCHTQulaPZRdhbq5m1FCXTc53Tu64NZdTdfoUekdXneCT9
         cLDM8Otykr7WH3dOeLe1xnBsgEcQ6eymvkLc/eNqSsnxNMGT7MOwQqMkbEqkwrJArnIp
         MYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=3YosXBMphFBPTyrYk/RdbHSh5tz3MJefldr296tJxNs=;
        b=Fl51SEi87QMIPgGT6tSnNmMCaeTOzaHlGT20vZLVfHP0Z7mHP756tcFBg8Ngh06AR7
         wpiHUvTKDZSVD6XC2CcJvKPhAkxR3yMZVsWMVjokGRqTUGfQvjlGt91RzM2sg5d2nuyb
         Jbi7yGyjnya9VjR/Tq053ljrfYTWklH/QkeDBf8fbqtUBHu6YpWzIauox4mEvhDBkxt7
         ohrz6ZumcGrTEwsnnm5EUozU5BAkhppQSHbHiRWdZQx/6N52BiYHxSLWWb5XWm4Izr5I
         qYtm2YHuiF5ZdyUJbx9e3V1tqKSt7P4Q/Mo6N2xI+KhT49lVCin3Mxrpm/eW/ESQ8rhu
         DFHg==
X-Gm-Message-State: AGi0PuYSXBBMKUav6EA7+8tkq8QOcgZT4If/PY65e05Rjohx13f9ZtOm
        kIv18e146Vo+8Wg6BAQ9NJJnjKwMbgDvd89ea+Y=
X-Google-Smtp-Source: APiQypK7Zxq5UBPk31xo9d8jf+3yx4C8bsSl2HgcWjrGBEEO+AUlS3/3ESSX5eYUN3CYt7w5oCzrd/i2IvAZbDw3zg4=
X-Received: by 2002:a7b:c927:: with SMTP id h7mr3520294wml.122.1586500696907;
 Thu, 09 Apr 2020 23:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com>
In-Reply-To: <20200409232728.231527-1-caij2003@gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 10 Apr 2020 08:38:05 +0200
Message-ID: <CA+icZUWJLGfp-UVhXDaCR=Xnce7phE1ffPHC4RzM8mXPhBaV9g@mail.gmail.com>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
To:     Jian Cai <caij2003@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, manojgupta@google.com,
        Peter.Smith@arm.com, stefan@agner.ch, samitolvanen@google.com,
        ilie.halip@gmail.com, jiancai@google.com,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Doug Anderson <armlinux@m.disordat.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        David Howells <dhowells@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 1:28 AM Jian Cai <caij2003@gmail.com> wrote:
>
> iwmmxt.S contains XScale instructions LLVM ARM backend does not support.
> Skip this file if LLVM integrated assemmbler or LLD is used to build ARM
> kernel.
>
> Signed-off-by: Jian Cai <caij2003@gmail.com>
> ---
>  arch/arm/Kconfig | 2 +-
>  init/Kconfig     | 6 ++++++
>  2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 66a04f6f4775..39de8fc64a73 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -804,7 +804,7 @@ source "arch/arm/mm/Kconfig"
>
>  config IWMMXT
>         bool "Enable iWMMXt support"
> -       depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU=
_PJ4B
> +       depends on !AS_IS_CLANG && !LD_IS_LLD && (CPU_XSCALE || CPU_XSC3 =
|| CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B)
>         default y if PXA27x || PXA3xx || ARCH_MMP || CPU_PJ4 || CPU_PJ4B
>         help
>           Enable support for iWMMXt context switching at run time if
> diff --git a/init/Kconfig b/init/Kconfig
> index 1c12059e0f7e..b0ab3271e900 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -19,6 +19,12 @@ config GCC_VERSION
>  config CC_IS_CLANG
>         def_bool $(success,$(CC) --version | head -n 1 | grep -q clang)
>
> +config AS_IS_CLANG
> +       def_bool $(success,$(AS) --version | head -n 1 | grep -q clang)
> +
> +config LD_IS_LLD
> +       def_bool $(success,$(LD) --version | head -n 1 | grep -q LLD)
> +
>  config CLANG_VERSION
>         int
>         default $(shell,$(srctree)/scripts/clang-version.sh $(CC))
> --
> 2.26.0.110.g2183baf09c-goog

Yesterday, when looking trough commits in Linus tree, I saw:

"init/kconfig: Add LD_VERSION Kconfig"

Nick had a patchset to distinguish LINKER via Kconfig (I cannot find
it right now).

So we should do all this the way CC_IS_XXX CC_VERSION handling is done.

I just want to point to [2] where we can rework (simplify) this
handling for CC and LD handling in a further step.
In one of Peter Z. tree someone started to do so (I was inspired by that).

Unfortunately, the hunk from [1] is IMHO a bit mis-placed and CC and
LD handling should stay together:

CC_IS_XXX where XXX is GCC or CLANG
CC_VERSION where CC is GCC or CLANG

LD_IS_XXX where XXX is BFD or GOLD or LLD
LD_VERSION

Just my =E2=82=AC0,02.

Regards,
- Sedat -

[1] https://git.kernel.org/linus/9553d16fa671b9621c5e2847d08bd90d3be3349c
[2] https://github.com/ClangBuiltLinux/linux/issues/941
