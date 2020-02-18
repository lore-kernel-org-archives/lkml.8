Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D95BC34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E34821D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IaQVxnR3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgBRS21 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:28:27 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:45528 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgBRS20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:28:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id 2so11052231pfg.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=d3KSdYVbADc8vhuPRBnMJ0Olj+WzBHR91Wg/nozFRYA=;
        b=IaQVxnR3uw31I9KunUQW5x8fXVHpy/6d/88oLvKBtPts2zAXC4WAIdJJWQN8rU7XFZ
         F9zes4nbRbK4WtDCM3SHBBblZhNRP6VwotM4uwx/Wy2m0TO6Ps/fsNWL3WO7Y8CmBYJV
         H4XDlwgzFvNsxnyzezcpPqGpDAbmOtjnpj8zYaDld/s2Z7y+qqodtC/Zefvx7tg/s80J
         2KYLk3CgN1goeYX3nnng1hDTQqCJk2NwClrXveS8dbtg4abUilguyuJcQA8wWr9l4kIQ
         pgaHPCredNAnrNtlgdUt4o3RF/s5wlfgY9h3wpZL0cbnXyK5ZGnkuJdxRduDs7pQqboV
         22Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=d3KSdYVbADc8vhuPRBnMJ0Olj+WzBHR91Wg/nozFRYA=;
        b=iOl2/Zpz5nhBm67hQ4tzH4jlPGTlWNKW032inHK3PbqUz2bqMHc2LeeaxzPGreX3zo
         ISaXeWc/jzMgvYueuZ9lDnAa4yX5sZ7YhCZ6ZbpouZlpDvZovHMcSfyKcmNaRz7fUB35
         QaLCJp5R/EweLpP4BAPmy9G/tVO06tschFy5xlXoUovadt8WO5wVsk/LCpcbUzmlqlxy
         cSZM9H/9IXBSFdnY9j1HI+oFKr8QFtf9n4unpvI2taVRpvENvmBwYEmggWS681PFDtXL
         uNRADq0FzIcv7JHWpsx68Q5sBxwZ2268StXx2ssMR2bQiJ1F4DBAZ+fT6UemV1nJ7amu
         g9kQ==
X-Gm-Message-State: APjAAAUBF5XjNHy8ZDKECLH4puuAz2YFquQTfL8fij/R5ns2BUmbKoy6
        6tBsZodZqdYaMPPDWe0UjjQBxExxAe0L/4hsyn4CFA==
X-Google-Smtp-Source: APXvYqzxsWCTzcp7XmEp9QyDTP0RELzLF7tqcKNPMkp2zhqxWNZwVbTFpSte6uGJE1AFtMU4DAqfxwEbLUnJyq5Bg/M=
X-Received: by 2002:a63:64c5:: with SMTP id y188mr23652916pgb.10.1582050506059;
 Tue, 18 Feb 2020 10:28:26 -0800 (PST)
MIME-Version: 1.0
References: <20200217211149.44132-1-natechancellor@gmail.com>
In-Reply-To: <20200217211149.44132-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 18 Feb 2020 10:28:15 -0800
Message-ID: <CAKwvOdnRbMrXNSMAA20UnoAUKBu5X7JO+DvNTb9pebuzQbRVcw@mail.gmail.com>
Subject: Re: [PATCH] MIPS: vdso: Wrap -mexplicit-relocs in cc-option
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paulburton@kernel.org>,
        linux-mips@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 1:11 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang does not support this option and errors out:
>
> clang-11: error: unknown argument: '-mexplicit-relocs'
>
> Clang does not appear to need this flag like GCC does because the jalr
> check that was added in commit 976c23af3ee5 ("mips: vdso: add build
> time check that no 'jalr t9' calls left") passes just fine with
>
> $ make ARCH=mips CC=clang CROSS_COMPILE=mipsel-linux-gnu- malta_defconfig arch/mips/vdso/
>
> even before commit d3f703c4359f ("mips: vdso: fix 'jalr t9' crash in
> vdso code").
>
> -mrelax-pic-calls has been supported since clang 9, which is the
> earliest version that could build a working MIPS kernel, and it is the
> default for clang so just leave it be.
>
> Fixes: d3f703c4359f ("mips: vdso: fix 'jalr t9' crash in vdso code")
> Link: https://github.com/ClangBuiltLinux/linux/issues/890
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for the patch, and detailed context.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

With this patch applied:
$ make ARCH=mips CC=clang CROSS_COMPILE=mipsel-linux-gnu-
malta_defconfig arch/mips/vdso/
$ lvm-objdump --disassemble arch/mips/vdso/vdso.so.dbg.raw | egrep -h "jarl.*t9"
$ llvm-objdump --disassemble arch/mips/vdso/vdso.so.dbg.raw | grep jarl
So jarl instructions aren't emitted.

Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/mips/vdso/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/mips/vdso/Makefile b/arch/mips/vdso/Makefile
> index 77374c1f0c77..d7fe8408603e 100644
> --- a/arch/mips/vdso/Makefile
> +++ b/arch/mips/vdso/Makefile
> @@ -33,7 +33,7 @@ endif
>  cflags-vdso := $(ccflags-vdso) \
>         $(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
>         -O3 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
> -       -mrelax-pic-calls -mexplicit-relocs \
> +       -mrelax-pic-calls $(call cc-option, -mexplicit-relocs) \
>         -fno-stack-protector -fno-jump-tables -DDISABLE_BRANCH_PROFILING \
>         $(call cc-option, -fno-asynchronous-unwind-tables) \
>         $(call cc-option, -fno-stack-protector)
> --

-- 
Thanks,
~Nick Desaulniers
