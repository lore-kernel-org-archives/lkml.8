Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81DCC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8E6920717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 23:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cAzTA5En"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgGQXql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 19:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGQXql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 19:46:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A03C0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:46:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id cv18so4491581pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 16:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZC3p+2XjLAm8XpuH3SiLqSVIr+Sho20/kQ8Al8jY7UU=;
        b=cAzTA5EniTJgKpW+A1LSJr2owM5C+0l2N7R1z8lRMH1v7hw+mz9DovO+nSefBpBa7U
         d6aUN0y4utYS8+7XcVP3eCejz4ubMff47Mid/REGHFh20L1rT8AqNQ5jELj32v2wMy0x
         6snKeJGMznnO4OTl2sOvhADK5Con69+A0bFXjl3g0W+/deGBRm9d4zhxgVJid7MG9aSj
         fPeOEf8AqbV8fqfthPt97O6xIgosjsu2cvOSOWNMFWmYnro9MdVAfQhEnenLtaQon0/B
         1bKWyIFJpGwCJuloffuyM6KZfDIo0OI7ZeZG5YNkYMq1Uzpis0PPgpTeOzlTg5y0DIVc
         lyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZC3p+2XjLAm8XpuH3SiLqSVIr+Sho20/kQ8Al8jY7UU=;
        b=hLng582zqfZD6JmjDVbvVSVF6hyBnnqg8G/mWUANLttHWX4B/E8avOKP9R0hj7lIOa
         v0cfEUA0W9SgMqNJwX+g+YgmCKGNcBDw9MP9lovhIAuzUTxb1o5MQ75uPyBM2ez8qulZ
         STXueSVKZBG/Oi149sremjuyTG4+iBNZZPBnRIRTt1mTkEaYcQGXH2lmEBRkEIBFRRlf
         wA21QObTBcYlthzke93D8vTWbQaDTAw7CBwq1zJGWaEMW+HB1heVnzVG0WuQe94lxVM+
         0Bk+zc5Dt1BCMLJseOLq/n+5EX6FyEv24lTwVeORxC1cvtOiBmnUHdoCcQdVaPPqbPce
         h28g==
X-Gm-Message-State: AOAM532j6qOpctoXH0B5ewkeVq8GUuDKi3x0eqrwIxEXqe1N/tAiZpv6
        tcZjlapqLxym9c46X+jAIBiWrhJBfPfotvc1t9HzTQ==
X-Google-Smtp-Source: ABdhPJy3AREhs9c+wuaJ4hp2xpIYuowyd1LkEKHsbONMkZNY/hYTLFZUvoAQCFcr8WdBhrDm8skpamLXxmtzlfmPV5Y=
X-Received: by 2002:a17:902:a50c:: with SMTP id s12mr9066703plq.119.1595029600035;
 Fri, 17 Jul 2020 16:46:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdnTbatx8VB-rJSzyFPwfYnkMYK28yLBn1G+hUu8dyfYRA@mail.gmail.com>
 <20200717201801.3661843-1-nivedita@alum.mit.edu>
In-Reply-To: <20200717201801.3661843-1-nivedita@alum.mit.edu>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 17 Jul 2020 16:46:27 -0700
Message-ID: <CAKwvOdkAYeQ6KQ4CUTmmnsBfP9h+YEz8oj25-p2ojYJDRuuBYw@mail.gmail.com>
Subject: Re: [PATCH-next v5 0/7] x86/boot: Remove run-time relocations from
 compressed kernel
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 1:18 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Same as v5 previously posted, but rebased onto next-20200717.
>
> v5: https://lore.kernel.org/lkml/20200715004133.1430068-1-nivedita@alum.mit.edu/
>
> Ard Biesheuvel (3):
>   x86/boot/compressed: Move .got.plt entries out of the .got section
>   x86/boot/compressed: Force hidden visibility for all symbol references
>   x86/boot/compressed: Get rid of GOT fixup code
>
> Arvind Sankar (4):
>   x86/boot: Add .text.* to setup.ld
>   x86/boot: Remove run-time relocations from .head.text code
>   x86/boot: Remove run-time relocations from head_{32,64}.S
>   x86/boot: Check that there are no run-time relocations

Thank you Arvind for the series.  I did quick build+boot tests of x86
defconfigs with `make LLVM=1` which look good.

Further, I was able to build+boot i386 defconfigs with `make LLVM=1`
with your series, Mr. Rothwell's proposed fixed for today's linux-next
breakage: https://lore.kernel.org/linux-next/20200717213127.3bd426e1@canb.auug.org.au/,
and Mr. Gerst's series for i386+clang support.  So that looks like
with this series, we can now link i386 defconfig with LLD! Nice!

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  arch/x86/boot/compressed/Makefile      |  39 +-----
>  arch/x86/boot/compressed/head_32.S     |  99 +++++----------
>  arch/x86/boot/compressed/head_64.S     | 165 ++++++++++---------------
>  arch/x86/boot/compressed/mkpiggy.c     |   6 +
>  arch/x86/boot/compressed/vmlinux.lds.S |  24 +++-
>  arch/x86/boot/setup.ld                 |   2 +-
>  drivers/firmware/efi/libstub/Makefile  |   2 +-
>  drivers/firmware/efi/libstub/hidden.h  |   6 -
>  include/linux/hidden.h                 |  19 +++
>  9 files changed, 153 insertions(+), 209 deletions(-)
>  delete mode 100644 drivers/firmware/efi/libstub/hidden.h
>  create mode 100644 include/linux/hidden.h
>
>
> base-commit: aab7ee9f8ff0110bfcd594b33dc33748dc1baf46
> --
> 2.26.2
>


-- 
Thanks,
~Nick Desaulniers
