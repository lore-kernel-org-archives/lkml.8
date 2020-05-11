Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA2DC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B70F206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sVHlcRMr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbgEKRX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729731AbgEKRX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:23:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3628BC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:23:59 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so5036355pfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=phVBp6KmJy0376W2ZnCHXhM1EWX39fhx0tVslAEftv4=;
        b=sVHlcRMrm0H9k/amUmVt+JHG81p8GP22soXU8TBNeMmQgqMl6LzzLYUPRijgJ4f1w+
         9jD7hpHNHRoaI3aBH+jFLbHDKpOA9cB2P8yNvPBD3IP5kQL1vtVBfH6xXqC89+7SWlgb
         gn+upm2Ku9fjVt6O7Q4xKL52II5J6iPF30b3KmPED5kr412HMOkQlztd2+9RPlt9Cj6J
         7S0LhJv5EpsYXS5AD1yPwE109vUuD1XclbySn1zu7XvZxHIIgSq3kPqsujD6TgpnEXZ4
         LFjSqLtD5rIvOvygpO1WfJiXM8vMKcS9jIKxp+v8jr4Cc9Csy4MFQMOI7Es1Ta2JHpgS
         UMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=phVBp6KmJy0376W2ZnCHXhM1EWX39fhx0tVslAEftv4=;
        b=QUgw8JPzNxG4HzReW4bLrvbgUyb4sClCJmneTfJhAdUmKrhSavGhGjHBCYybZiO5Ya
         MX2MtL3POpKUklh0Xq5Zg5cbGvPVUYdxZGKIVGjM280qdz0SC5gQc3JM+ZbcXHUxaTs5
         aaIMjJDsYDpL8H8QzPCDQq/zjkdBqU1/R4gt/l4KbG9sKzgBDcQZJwgrTS0Fy9PLdbTg
         zU03W9P5AuYifrQGDMLhpZdhfE2GMxbsohhlGelSMfTz7gcoewymGDITC6Oq2Ff4DIcn
         kiBZV0aoD6i6mcr4DnUniph5TdDpMkhkquplz2EShCEmnmhYoICCdAem6CnT4XXxFbdt
         GsPw==
X-Gm-Message-State: AGi0PubCVIdaGLL2N5KFtJ/FfbaE+Gl/se6XUetyrAh1tPrb2J5zmetk
        Tw1IDd3NBrMmkjH7oZYGdzdFZRpOHKV42R/NITT1cw==
X-Google-Smtp-Source: APiQypIiLFBK0OKhKj7DIaE8gPQC3sYq1tQ2wKGLUrQ5d5gpcyzNgq87mYzCCA2p1KHFZCUT1jCRv1H6pniR5nNDeOk=
X-Received: by 2002:a62:146:: with SMTP id 67mr17329716pfb.169.1589217838370;
 Mon, 11 May 2020 10:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200504230309.237398-1-ndesaulniers@google.com>
In-Reply-To: <20200504230309.237398-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 11 May 2020 10:23:45 -0700
Message-ID: <CAKwvOdmspKUknbzDn9kY2jMgkFw=Ktvst0ZtwambDOfybqJGWw@mail.gmail.com>
Subject: Re: [PATCH] x86: support i386 with Clang
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dmitry Golovin <dima@golovin.in>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bumping for comment+review.

On Mon, May 4, 2020 at 4:03 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> GCC and Clang are architecturally different, which leads to subtle
> issues for code that's invalid but clearly dead. This can happen with
> code that emulates polymorphism with the preprocessor and sizeof.
>
> GCC will perform semantic analysis after early inlining and dead code
> elimination, so it will not warn on invalid code that's dead. Clang
> strictly performs optimizations after semantic analysis, so it will warn
> for dead code.
>
> Neither Clang nor GCC like this very much with -m32:
>
> long long ret;
> asm ("movb $5, %0" : "=q" (ret));
>
> However, GCC can tolerate this variant:
>
> long long ret;
> switch (sizeof(ret)) {
> case 1:
>         asm ("movb $5, %0" : "=q" (ret));
>         break;
> case 8:;
> }
>
> Clang, on the other hand, won't accept that because it validates the
> inline asm for the '1' case *before* the optimisation phase where it
> realises that it wouldn't have to emit it anyway.
>
> If LLVM (Clang's "back end") fails such as during instruction selection
> or register allocation, it cannot provide accurate diagnostics
> (warnings/errors) that contain line information, as the AST has been
> discarded from memory at that point.
>
> While there have been early discussions about having C/C++ specific
> language optimizations in Clang via the use of MLIR, which would enable
> such earlier optimizations, such work is not scoped and likely a
> multi-year endeavor.
>
> We also don't want to swap the use of "=q" with "=r". For 64b, it
> doesn't matter. For 32b, it's possible that a 32b register without a 8b
> lower alias (i.e. ESI, EDI, EBP) is selected which the assembler will
> then reject.
>
> With this, Clang can finally build an i386 defconfig.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Reported-by: David Woodhouse <dwmw2@infradead.org>
> Reported-by: Dmitry Golovin <dima@golovin.in>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Link: https://bugs.llvm.org/show_bug.cgi?id=33587
> Link: https://github.com/ClangBuiltLinux/linux/issues/3
> Link: https://github.com/ClangBuiltLinux/linux/issues/194
> Link: https://github.com/ClangBuiltLinux/linux/issues/781
> Link: https://lore.kernel.org/lkml/20180209161833.4605-1-dwmw2@infradead.org/
> Link: https://lore.kernel.org/lkml/CAK8P3a1EBaWdbAEzirFDSgHVJMtWjuNt2HGG8z+vpXeNHwETFQ@mail.gmail.com/
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Note: this is a resend of:
> https://lore.kernel.org/lkml/20180209161833.4605-1-dwmw2@infradead.org/
> rebased on today's Linux next, and with the additional change to
> uaccess.h.
>
> I'm happy to resend with authorship and reported by tags changed to
> suggested by's or whatever, just let me know.
>
> Part of the commit message is stolen from David, and part from Linus.
> Shall I resend with David's authorship and
> [Nick: reworded]
> ???
>
> I don't really care, I just don't really want to carry this out of tree
> for our CI, which is green for i386 otherwise.
>
>
>  arch/x86/include/asm/percpu.h  | 12 ++++++++----
>  arch/x86/include/asm/uaccess.h |  4 +++-
>  2 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
> index 2278797c769d..826d086f71c9 100644
> --- a/arch/x86/include/asm/percpu.h
> +++ b/arch/x86/include/asm/percpu.h
> @@ -99,7 +99,7 @@ do {                                                  \
>         case 1:                                         \
>                 asm qual (op "b %1,"__percpu_arg(0)     \
>                     : "+m" (var)                        \
> -                   : "qi" ((pto_T__)(val)));           \
> +                   : "qi" ((unsigned char)(unsigned long)(val))); \
>                 break;                                  \
>         case 2:                                         \
>                 asm qual (op "w %1,"__percpu_arg(0)     \
> @@ -144,7 +144,7 @@ do {                                                                        \
>                 else                                                    \
>                         asm qual ("addb %1, "__percpu_arg(0)            \
>                             : "+m" (var)                                \
> -                           : "qi" ((pao_T__)(val)));                   \
> +                           : "qi" ((unsigned char)(unsigned long)(val))); \
>                 break;                                                  \
>         case 2:                                                         \
>                 if (pao_ID__ == 1)                                      \
> @@ -182,12 +182,14 @@ do {                                                                      \
>
>  #define percpu_from_op(qual, op, var)                  \
>  ({                                                     \
> +       unsigned char pfo_u8__;                         \
>         typeof(var) pfo_ret__;                          \
>         switch (sizeof(var)) {                          \
>         case 1:                                         \
>                 asm qual (op "b "__percpu_arg(1)",%0"   \
> -                   : "=q" (pfo_ret__)                  \
> +                   : "=q" (pfo_u8__)                   \
>                     : "m" (var));                       \
> +               pfo_ret__ = (typeof(var))(unsigned long)pfo_u8__;       \
>                 break;                                  \
>         case 2:                                         \
>                 asm qual (op "w "__percpu_arg(1)",%0"   \
> @@ -211,12 +213,14 @@ do {                                                                      \
>
>  #define percpu_stable_op(op, var)                      \
>  ({                                                     \
> +       unsigned char pfo_u8__;                         \
>         typeof(var) pfo_ret__;                          \
>         switch (sizeof(var)) {                          \
>         case 1:                                         \
>                 asm(op "b "__percpu_arg(P1)",%0"        \
> -                   : "=q" (pfo_ret__)                  \
> +                   : "=q" (pfo_u8__)                   \
>                     : "p" (&(var)));                    \
> +               pfo_ret__ = (typeof(var))(unsigned long)pfo_u8__;       \
>                 break;                                  \
>         case 2:                                         \
>                 asm(op "w "__percpu_arg(P1)",%0"        \
> diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
> index d8f283b9a569..cf8483cd80e1 100644
> --- a/arch/x86/include/asm/uaccess.h
> +++ b/arch/x86/include/asm/uaccess.h
> @@ -314,11 +314,13 @@ do {                                                                      \
>
>  #define __get_user_size(x, ptr, size, retval)                          \
>  do {                                                                   \
> +       unsigned char x_u8__;                                           \
>         retval = 0;                                                     \
>         __chk_user_ptr(ptr);                                            \
>         switch (size) {                                                 \
>         case 1:                                                         \
> -               __get_user_asm(x, ptr, retval, "b", "=q");              \
> +               __get_user_asm(x_u8__, ptr, retval, "b", "=q");         \
> +               (x) = x_u8__;                                           \
>                 break;                                                  \
>         case 2:                                                         \
>                 __get_user_asm(x, ptr, retval, "w", "=r");              \
> --
> 2.26.2.526.g744177e7f7-goog
>


-- 
Thanks,
~Nick Desaulniers
