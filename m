Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD1CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:21:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FB29206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CH3DXNhk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729059AbgC3QVC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:21:02 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46242 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbgC3QVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:21:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id q3so8797566pff.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 09:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rSae6Vewe/pKHx71bupn1zsciiuzANk0QhhWFPsLGxo=;
        b=CH3DXNhkiamE3xgHese3GbwPpKauxiSrqiFNgPQGy2CLyT2p0W+026JXQ9etIiFRmQ
         JCp/JjKX1pwU95Ziy5tV5U+S88N1wtdu+KbzL2rcF5OTDK5TiYk2ILK6CefvHq/Siw6Z
         AiqnEWVeI1fGXo9BQaUq1zyzHHUN6Utt7AFbq3eEOU61nlHbBzvLv74p6MC2cAAqn8cd
         1gRGIbIjDlaqzmSRyYkfeSIt1I37Hym9fFjYO/I73XQqQTjIIC+euazZee7wuWrW88K5
         XlQIEbXSOfjVT/KiYi47WH4hbaYsx+iHcjsilRxfgbRD48RI3MIMdQsvza+PrRoXXeKf
         07aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rSae6Vewe/pKHx71bupn1zsciiuzANk0QhhWFPsLGxo=;
        b=uX2bTK1VFKmaWfjQ1GyUpfNBDseUs8znVVYdtNUwr0AkzlaOtsh8HwOquCqGtn7zym
         VMU4cBAB5eW2w5IJJXf/c9dtq3f+G13qjy3j/aKjpSvOzoMYGmCbD29k67O2ry3VYTNl
         DwaKQVNpJzr+9OB3BfDJkirbngHSi4p3CLveSQK5JoFWn05LWlcySN7XvuRXm0Hc+aUu
         HF55odcedJCu4lAXKW06NoR66Ac1ciPNMkK/RR/+KnOyFRxOnySeI3KRcGa4e3++veOb
         MZhxq8b84aaiYkerGmuQL0+hTGO2GcA6gS6aAfrwnDw1KSDKsT9YBtova7xOiPBP24me
         0O0A==
X-Gm-Message-State: AGi0PuY7i3r3+fpUAuZIWSKO9JufOy/vz8FbjY71K+FBJZPofMToFnYi
        T7NH8zphC/ugFxiJ0smtOr/Vtx5STmSsN+YovIVseg==
X-Google-Smtp-Source: APiQypLuCzCsbkG5giznCGJJrHmX0Nt01re4K/iPIu/36KlIa1mVFCUVCpNIEc9Rp031yqlIuMSW4Np8rDwTZfTSRAg=
X-Received: by 2002:a63:f963:: with SMTP id q35mr6219088pgk.381.1585585258519;
 Mon, 30 Mar 2020 09:20:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200327100801.161671-1-courbet@google.com> <20200330080400.124803-1-courbet@google.com>
In-Reply-To: <20200330080400.124803-1-courbet@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 30 Mar 2020 09:20:47 -0700
Message-ID: <CAKwvOdmO_0yosb-k+UHenSa5W5HtZgPLFaHfapxD8WiDNpFJUA@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc: Make setjmp/longjmp signature standard
To:     Clement Courbet <courbet@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 1:04 AM Clement Courbet <courbet@google.com> wrote:
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
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
> Tested-by: Nathan Chancellor <natechancellor@gmail.com>
> Cc: stable@vger.kernel.org # v4.14+
> Fixes: c9029ef9c957 ("powerpc: Avoid clang warnings around setjmp and longjmp")

Third time's a charm (for patches that tackle this warning). Thanks
for following up on this cleanup!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

The extent of my testing was compile testing with Clang.

>
> ---
>
> v2:
> Use and array type as suggested by Segher Boessenkool
> Add fix tags.
>
> v3:
> Properly place tags.
> ---
>  arch/powerpc/include/asm/setjmp.h | 6 ++++--
>  arch/powerpc/kexec/Makefile       | 3 ---
>  arch/powerpc/xmon/Makefile        | 3 ---
>  3 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/setjmp.h b/arch/powerpc/include/asm/setjmp.h
> index e9f81bb3f83b..f798e80e4106 100644
> --- a/arch/powerpc/include/asm/setjmp.h
> +++ b/arch/powerpc/include/asm/setjmp.h
> @@ -7,7 +7,9 @@
>
>  #define JMP_BUF_LEN    23
>
> -extern long setjmp(long *) __attribute__((returns_twice));
> -extern void longjmp(long *, long) __attribute__((noreturn));
> +typedef long jmp_buf[JMP_BUF_LEN];
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
> diff --git a/arch/powerpc/xmon/Makefile b/arch/powerpc/xmon/Makefile
> index c3842dbeb1b7..6f9cccea54f3 100644
> --- a/arch/powerpc/xmon/Makefile
> +++ b/arch/powerpc/xmon/Makefile
> @@ -1,9 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Makefile for xmon
>
> -# Avoid clang warnings around longjmp/setjmp declarations
> -subdir-ccflags-y := -ffreestanding
> -
>  GCOV_PROFILE := n
>  KCOV_INSTRUMENT := n
>  UBSAN_SANITIZE := n
> --
> 2.26.0.rc2.310.g2932bb562d-goog
>


-- 
Thanks,
~Nick Desaulniers
