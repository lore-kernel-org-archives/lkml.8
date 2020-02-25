Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA08C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63CC2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Aglq1138"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbgBYTKg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:10:36 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52389 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgBYTKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:10:33 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep11so117917pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 11:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bY/V/GmjTMwSsbRxOp3cbtrLAwvSrthIWK239p8DTzE=;
        b=Aglq1138iS0WwGsnGj4iO2plS1JbUrLovS1ZRixzAwJERIoNzyYnl5R4Vo+KIBeiDV
         HhE6mxbJGYUuVrRfAh76ZfgRg6d6ZMlS19jH6oKNbTYvByroJBD33ZXJBwsMIzDGfsqR
         xnBwbORa/szJwZza3OHTWSQf0vnuKJITm5h3kzjAVTh1ijd7GFtpYjQG/XSVEHk+03hZ
         KBN0Ia0+s1aLmFibRSOpyAT2KYvn85gF5uunWXCykkhYZGMcpemyRFgnlo4euw5sUjQN
         TpoMHx5u/F3l7Gt9MgRaAZm1US7hI805gqNJBL6eFvYpcLCjYMyIq4qgOFloYQTD2RcF
         zXHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bY/V/GmjTMwSsbRxOp3cbtrLAwvSrthIWK239p8DTzE=;
        b=fY2SddBs7V989A4qvtrSgo3OsErLbDBpph6g/loDA4V0gToEvn4hjU9OiDUHyS/xGd
         3/g4FDwITunrgJQes6cfdDAJHQA+R/3UIi9IqMSgkS9eHKf9kP8qwxpyU0uA/e/uW2ta
         Isn0zFqvGZfCv/ToE1QsRjnw6kjyWNxgcrIaXGdI5/bNrLRCP7xEbI1nwVlBHzoOG5I6
         Au1d8C+s4GAyN2JTtH8Azn4ivOV4Kyb2AOUMlC5MwdEpqJIqnxSyq1dUAwVJq1caVrBe
         LIPxvtgMTUyxUYss0NkOIa5iFZrG02+l/Y02jlDfD8OFleLyyOklyeQ1m2n8DPXvS1cG
         Yx8g==
X-Gm-Message-State: APjAAAX7I7BnKGjmX0yLf3CatuO1fNCEgaLLDQEgzD4N+cK1ILGqik4E
        6oyOl9rvctMjT2taMYG0GbQalkkK0RW1xP4bulbCpQ==
X-Google-Smtp-Source: APXvYqw9+BzaxVxd2DUSSsXFL62z/QnSA7USFL10oM2Qj5OVLuJYfzZYIWeOtQv0bwvpDBrOXEPvm4eU1mGmc4LZDEQ=
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr55585012plt.223.1582657832765;
 Tue, 25 Feb 2020 11:10:32 -0800 (PST)
MIME-Version: 1.0
References: <8bb16ac4b15a7e28a8e819ef9aae20bfc3f75fbc.1582266841.git.stefan@agner.ch>
In-Reply-To: <8bb16ac4b15a7e28a8e819ef9aae20bfc3f75fbc.1582266841.git.stefan@agner.ch>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 25 Feb 2020 11:10:21 -0800
Message-ID: <CAKwvOdmV80xgvBnhB6ZpqYaqkxKi-_p+StnMojwNnf3kdxTT1A@mail.gmail.com>
Subject: Re: [PATCH] ARM: use assembly mnemonics for VFP register access
To:     Stefan Agner <stefan@agner.ch>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Manoj Gupta <manojgupta@google.com>,
        Jian Cai <jiancai@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 9:22 PM Stefan Agner <stefan@agner.ch> wrote:
>
> Clang's integrated assembler does not allow to to use the mcr
> instruction to access floating point co-processor registers:
> arch/arm/vfp/vfpmodule.c:342:2: error: invalid operand for instruction
>         fmxr(FPEXC, fpexc & ~(FPEXC_EX|FPEXC_DEX|FPEXC_FP2V|FPEXC_VV|FPEX=
C_TRAP_MASK));
>         ^
> arch/arm/vfp/vfpinstr.h:79:6: note: expanded from macro 'fmxr'
>         asm("mcr p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmxr   " #_vfp_ =
", %0" \
>             ^
> <inline asm>:1:6: note: instantiated into assembly here
>         mcr p10, 7, r0, cr8, cr0, 0 @ fmxr      FPEXC, r0
>             ^
>
> The GNU assembler supports the .fpu directive at least since 2.17 (when
> documentation has been added). Since Linux requires binutils 2.21 it is
> safe to use .fpu directive. Use the .fpu directive and mnemonics for VFP
> register access.
>
> This allows to build vfpmodule.c with Clang and its integrated assembler.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/905
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  arch/arm/vfp/vfpinstr.h | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
> index 38dc154e39ff..799ccf065406 100644
> --- a/arch/arm/vfp/vfpinstr.h
> +++ b/arch/arm/vfp/vfpinstr.h
> @@ -62,21 +62,17 @@
>  #define FPSCR_C (1 << 29)
>  #define FPSCR_V        (1 << 28)
>
> -/*
> - * Since we aren't building with -mfpu=3Dvfp, we need to code
> - * these instructions using their MRC/MCR equivalents.
> - */
> -#define vfpreg(_vfp_) #_vfp_
> -
>  #define fmrx(_vfp_) ({                 \
>         u32 __v;                        \
> -       asm("mrc p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmrx   %0, " #_v=
fp_    \
> +       asm(".fpu       vfpv2\n"        \
> +           "vmrs       %0, " #_vfp_    \
>             : "=3Dr" (__v) : : "cc");     \
>         __v;                            \
>   })
>
>  #define fmxr(_vfp_,_var_)              \
> -       asm("mcr p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmxr   " #_vfp_ =
", %0" \
> +       asm(".fpu       vfpv2\n"        \
> +           "vmsr       " #_vfp_ ", %0" \
>            : : "r" (_var_) : "cc")
>
>  u32 vfp_single_cpdo(u32 inst, u32 fpscr);
> --

Hi Stefan,
Thanks for the patch.  Reading through:
- FMRX, FMXR, and FMSTAT:
http://infocenter.arm.com/help/index.jsp?topic=3D/com.arm.doc.dui0068b/Bcfb=
dihi.html
- VMRS and VMSR:
http://infocenter.arm.com/help/index.jsp?topic=3D/com.arm.doc.dui0204h/Bcfb=
dihi.html

Should a macro called `fmrx` that had a comment about `fmrx` be using
`vmrs` in place of `fmrx`?

It looks like Clang treats them the same, but GCC keeps them separate:
https://godbolt.org/z/YKmSAs
Ah, this is only when streaming to assembly. Looks like they have the
same encoding, and produce the same disassembly. (Godbolt emits
assembly by default, and has the option to compile, then disassemble).
If I take my case from godbolt above:

=E2=9E=9C  /tmp arm-linux-gnueabihf-gcc -O2 -c x.c
=E2=9E=9C  /tmp llvm-objdump -dr x.o

x.o: file format elf32-arm-little


Disassembly of section .text:

00000000 bar:
       0: f1 ee 10 0a                  vmrs r0, fpscr
       4: 70 47                        bx lr
       6: 00 bf                        nop

00000008 baz:
       8: f1 ee 10 0a                  vmrs r0, fpscr
       c: 70 47                        bx lr
       e: 00 bf                        nop

So indeed a similar encoding exists for the two different assembler
instructions.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>


--=20
Thanks,
~Nick Desaulniers
