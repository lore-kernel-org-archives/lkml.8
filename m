Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5380CC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21B3E20714
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 17:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MUofL7R+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgC0RLA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 13:11:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46121 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgC0RK7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 13:10:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id s23so3660889plq.13
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBCjAk0gvrWE6sWceslEiTTxRDFmFfcP2iFKJjO3ChU=;
        b=MUofL7R+c9y0EimApYtKI2cV7puewIhhm4xcuMre9PFcte34QvzRO3E+BjSqbxQq/W
         V4wOUffxoLqvTXH0xqIsvVYmK1n2lpBjQZHuC/j+A6nt6q8TCVEg+jiu7uwI2YSOon+A
         4vNrFtRo24tAfC6HmUvq7c/xyTv0Au9miX4lkYujg4uZ+KHbG0DG0xhYuKuhoPeI0Erj
         xB2bb/YyF37BPn7J9KBk+q0GHKfL3NI8gxpnZenBeX/gCWyLwfgPIMZww3IKxW3C5aSY
         QjuF5/Ibt767T3+70NfOHxqPw1+Nya6Ecq4e1J2Hh3IGPBh/w5rYEgS1yp8tb9ZKUD/F
         QhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBCjAk0gvrWE6sWceslEiTTxRDFmFfcP2iFKJjO3ChU=;
        b=VToeEln6IVimSyZzDqZNviy1V5fRKa9/pbh5TFdcnM6bYsFV8a6g8dBlcRounGcXez
         r3EGEVWzj5rpFFToDFjlGmkzngYsg8iswJ9msvjlVryz5baFi5JzCncp6QVPhSpgXnkO
         EnaxFctrjPtQ9887oYxErjiexS7xbmCFJINBoejZyjtEB3+z2e2CZ0m4AWLSO42RGUZY
         2J/h1zH3eHb7HRNjZniLhqkUtFQYNR9p1MEeDGGwxFI+XatBVHhenNfFeULKLxzCDGDM
         7MAN0+EDraeWEA9ZJITz62Emr5Uy1l18u+cs4MEppehwkV8Xu6CsThafUc2z/A8oObxU
         NwZg==
X-Gm-Message-State: ANhLgQ11nlV61Fbs6xnfbppS0Au0VnX6QqGVgjUxkbh9jGBdkoV9JrRz
        DBcg+hPi2eU/56r41As56X9JRzwV5nzCYpjFHScEDA==
X-Google-Smtp-Source: ADFU+vuNf59yIvIcvWQM3jTPYWY7cD1fCsAchiEpBFOwsOwNUxrvnq2kDqUq3c10YN7+V13dQ/6ztQG8dOldkp67IRE=
X-Received: by 2002:a17:902:820a:: with SMTP id x10mr62388pln.179.1585329056243;
 Fri, 27 Mar 2020 10:10:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200327100801.161671-1-courbet@google.com>
In-Reply-To: <20200327100801.161671-1-courbet@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 27 Mar 2020 10:10:44 -0700
Message-ID: <CAKwvOdmLmfJY4Uk-Atd9dT5+zQTPeoagjMZMcDqdVfKCU7_BuA@mail.gmail.com>
Subject: Re: [PATCH v1] powerpc: Make setjmp/longjump signature standard
To:     Clement Courbet <courbet@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 27, 2020 at 3:08 AM Clement Courbet <courbet@google.com> wrote:
>
> Declaring setjmp()/longjmp() as taking longs makes the signature
> non-standard, and makes clang complain. In the past, this has been
> worked around by adding -ffreestanding to the compile flags.
>
> The implementation looks like it only ever propagates the value
> (in longjmp) or sets it to 1 (in setjmp), and we only call longjmp
> with integer parameters.
>
> This allows removing -ffreestanding from the compilation flags.
>
> Context:
> https://lore.kernel.org/patchwork/patch/1214060
> https://lore.kernel.org/patchwork/patch/1216174
>
> Signed-off-by: Clement Courbet <courbet@google.com>

Hi Clement, thanks for the patch! Would you mind sending a V2 that
included a similar fix to arch/powerpc/xmon/Makefile?

For context, this was the original patch:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aea447141c7e7824b81b49acd1bc78
which was then modified to:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c9029ef9c95765e7b63c4d9aa780674447db1ec0

So on your V2, if you include in the commit message, the line:

Fixes c9029ef9c957 ("powerpc: Avoid clang warnings around setjmp and longjmp")

then that will help our LTS branch maintainers back port it to the
appropriate branches.

>
> ---
>  arch/powerpc/include/asm/setjmp.h | 6 ++++--
>  arch/powerpc/kexec/Makefile       | 3 ---
>  2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/setjmp.h b/arch/powerpc/include/asm/setjmp.h
> index e9f81bb3f83b..84bb0d140d59 100644
> --- a/arch/powerpc/include/asm/setjmp.h
> +++ b/arch/powerpc/include/asm/setjmp.h
> @@ -7,7 +7,9 @@
>
>  #define JMP_BUF_LEN    23
>
> -extern long setjmp(long *) __attribute__((returns_twice));
> -extern void longjmp(long *, long) __attribute__((noreturn));
> +typedef long *jmp_buf;
> +
> +extern int setjmp(jmp_buf env) __attribute__((returns_twice));
> +extern void longjmp(jmp_buf env, int val) __attribute__((noreturn));
>
>  #endif /* _ASM_POWERPC_SETJMP_H */
> diff --git a/arch/powerpc/kexec/Makefile b/arch/powerpc/kexec/Makefile
> index 378f6108a414..86380c69f5ce 100644
> --- a/arch/powerpc/kexec/Makefile
> +++ b/arch/powerpc/kexec/Makefile
> @@ -3,9 +3,6 @@
>  # Makefile for the linux kernel.
>  #
>
> -# Avoid clang warnings around longjmp/setjmp declarations
> -CFLAGS_crash.o += -ffreestanding
> -
>  obj-y                          += core.o crash.o core_$(BITS).o
>
>  obj-$(CONFIG_PPC32)            += relocate_32.o
> --
> 2.25.1.696.g5e7596f4ac-goog
>


-- 
Thanks,
~Nick Desaulniers
