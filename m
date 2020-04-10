Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7094DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 09:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D8B220801
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 09:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbgDJJ4f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 05:56:35 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:53153 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgDJJ4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 05:56:35 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MTiLj-1jqnSZ2iz7-00U6HF for <linux-kernel@vger.kernel.org>; Fri, 10 Apr
 2020 11:56:34 +0200
Received: by mail-qv1-f46.google.com with SMTP id q73so706294qvq.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 02:56:34 -0700 (PDT)
X-Gm-Message-State: AGi0PuYBcsuhhGiFyV0b3zM52lgqMhGjkfPJABoOB3v5TZflnswZFexa
        vzhoQ4Qba10YwDgyPQSSTLQ+5X8QP4P5HCh51ys=
X-Google-Smtp-Source: APiQypLw2PXwmHxk8QgHqeU3RcBbtV6euI1esOFx9zEJPY5o7F0Ij0rYCC5ouON3eLKeJevW89lM7yEDk3rY7mzaHVE=
X-Received: by 2002:a0c:fc03:: with SMTP id z3mr4142553qvo.210.1586512593511;
 Fri, 10 Apr 2020 02:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com>
In-Reply-To: <20200409232728.231527-1-caij2003@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Apr 2020 11:56:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
Message-ID: <CAK8P3a3uj7AHbAo4sNzr6KQx5Fk6v99k4ZixCgKo1tUuGoat9Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: do not assemble iwmmxt.S with LLVM toolchain
To:     Jian Cai <caij2003@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Manoj Gupta <manojgupta@google.com>, Peter.Smith@arm.com,
        Stefan Agner <stefan@agner.ch>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ilie Halip <ilie.halip@gmail.com>, jiancai@google.com,
        Russell King <linux@armlinux.org.uk>,
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
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:1Dxc3cpHZpOhCp274aTD5GzKXjubUve7Eh+PYVOqYWehQcDvLa2
 tQKllDt7QZVaGFwp27Zg2pkp+AaVPCibj8ggY2ERd3E7sZOD6kMtiGAxBor/ix0Q2vosc5F
 gtqtkLa9Be7JXxK1cmkk0WSwB3D6hDZOLBMOmBLAGe/x9KRNtJhjxp/No+oXnomsK/k4muo
 3Y/plueMV+7bSX0ADYVCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WsMgX1qVOp4=:bveoDfjzjuN06LRP63iTfC
 3okN6nIRfPjZCxpyXH2nhJjHj1HeCRYCdQSgAdI7s1Vf/KDuG9Mqv6MIK+X6BemXEfZ0SV2Yo
 AO7gkqPrPj81o7SgDON66kXiLGf1mBUhQ+i9NhI3B3VrxR0EFyCcKzueqps3YbbvZgr2h3PVc
 9CSLqUkYxTbahoTC8WqbHWYVXE8t2JJZe+o6QTvJH4aRoFAJAizWmdP7YvMB1lbQrmhg1gH7q
 uWpQ+M+1HJhEmwPngSyTnWbZ1BMOSGoZiImj8eougrBCZiEOsbKmEi6wtFUmalz1SQZavxrIg
 /FNUTvzFveR3fQA85v0J2kuQgxqPXvnlS7SZSbODUJqJrLLVZbfR1WRtmr9iqvBEp0im2MNzg
 WlEsHKRHEqv4OgHi/2fOphlJ+9MnFJ/7ZQqf+ElZt4vf5TEowlUidHZGYLiW6w0/Ko1Ou6lqk
 lHLh3oo/dorigj7HtCJTNCaFUDsR943dNffQD633dRTbVfk9KN7TOHjrFrFofnpV6ZIandXwP
 JCfB0Mn6m1eon0qjdvBDMCUngmgvnorYVVaVU97qs4m/7ZWamZT2Tm6N2ettQ2+3bN+lqvGPI
 Yqy7qqgKUIwzLs78UQ/OhTpn4n6fnAhw2stoBOOyc/XK0K1u5B8D/vtEaUoRAyGQk1lFHTIbS
 mAoE5+mPFpxUTcb+oaZ1/L9ayTq6ql56vdFtXPTpv0WwRHtpOQnWHFn/aSrPibtXBdxlaEyXn
 EpVzPVefpH66pxladF67ibSuHKJS/mSBr8D04iXcHefBJI0kdy3MiR+RTZQEIbL5CVqxazb38
 EvlrvVw88P5eX+7OYlOWWSA6pYFxlXQD08dEiK/hcBvcbSf1Uc=
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

It clearly makes sense to limit the Kconfig option to compilers that
can actually build it.
A few questions though:

- Given that Armada XP with its PJ4B was still marketed until fairly
recently[1],
  wouldn't it make sense to still add support for it? Is it a lot of work?

- Why does the linker have to understand it, rather than just the assembler?

> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index 66a04f6f4775..39de8fc64a73 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -804,7 +804,7 @@ source "arch/arm/mm/Kconfig"
>
>  config IWMMXT
>         bool "Enable iWMMXt support"
> -       depends on CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B
> +       depends on !AS_IS_CLANG && !LD_IS_LLD && (CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B)

I would suggest splitting it into two lines for readability:

       depends on  CPU_XSCALE || CPU_XSC3 || CPU_MOHAWK || CPU_PJ4 || CPU_PJ4B
       depends on !AS_IS_CLANG && !LD_IS_LLD

    Arnd

[1] http://web.archive.org/web/20191015165247/https://www.marvell.com/embedded-processors/armada/index.jsp
