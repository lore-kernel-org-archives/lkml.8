Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC78C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:34:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0422020CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 19:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jr2iMjqi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbgBYTeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 14:34:03 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37175 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730539AbgBYTdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 14:33:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id l5so47159wrx.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 11:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Pm9mKzisBXffRenDjzc076HpmcDb6sC4Riuk402uBGE=;
        b=jr2iMjqiejBKhDq5xjvmyFjljYq3lwqKBrpHOAjCtsrFl6i9NZ+7uR8rwXJajAaVWM
         SvzFIMNZxAYa5mOzSq8Y8Lx53XifXhNWDaQsmhlFr4a2vQwk7cOx2hb5Gzi2TFVQ2j3l
         JLv/R02zcCkjC0GqcR8a9PF+OtQuK2ir792RrAPY8GnZz3aMzTF4A4h8Qo+j+HepT4Xs
         /3DoZ07Boevr9AClCLzy29EwKRoo2a4KyvLILHKWZCOpTYLC5XdzOgdRxQZP0PtwB+nw
         Nwzc+WPHsYIk2FVsN1qleTc1HIwVEaJzRg12FugLELMVDKrxvHDJr5jy0TKXM1WtbUQE
         68lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Pm9mKzisBXffRenDjzc076HpmcDb6sC4Riuk402uBGE=;
        b=TWzJ08xDEyccGfcMwsxEI4KcGFXS8IYHSZmC02SVXX6RdMy6FOFrDj8bFVPM0t+8vR
         jWa6XYuIBmHu25w3Wah9x/Hb1uX0gkHhXgW0OVbhnZm4AUE6p9N7+D2sTA4F3GL+QNG8
         EoirXjRSGn+M3MqmWQrTp1wogmIabnBRNoC/j6T1RvMy4gqN8DZWVC3VloEpTc0rveh4
         kR0n3e4lrWw9C57aukvOip5w9aqTYwf2AXGwzVkxQJxCiAI9XXaJ7YZYViCQOUpJevai
         zZLyvVMzmgVtoyTucEn9A0AawrqJ1B9y2xL7FKXHX28+6wJByhqea3tPMgAFvzWHduaO
         13gw==
X-Gm-Message-State: APjAAAX4nKgn0W4R5SFjdouanpojSe+lY9cBqC23LUtwJESNX9PS4uc0
        45gcD9rcsnJk0jdaGt13pa1bfxKaG7RH079Sg0J80w==
X-Google-Smtp-Source: APXvYqxrxYeyZvodeEJ9iVUbqY7GqA354m0m1zT131nsQCFY1tmU8J/9AtNy0njbTfrfES0Z6kSPd1IFhJnhghT2o2E=
X-Received: by 2002:adf:e742:: with SMTP id c2mr691012wrn.262.1582659225078;
 Tue, 25 Feb 2020 11:33:45 -0800 (PST)
MIME-Version: 1.0
References: <8bb16ac4b15a7e28a8e819ef9aae20bfc3f75fbc.1582266841.git.stefan@agner.ch>
 <CAKwvOdmV80xgvBnhB6ZpqYaqkxKi-_p+StnMojwNnf3kdxTT1A@mail.gmail.com>
In-Reply-To: <CAKwvOdmV80xgvBnhB6ZpqYaqkxKi-_p+StnMojwNnf3kdxTT1A@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 25 Feb 2020 20:33:34 +0100
Message-ID: <CAKv+Gu881ZSwvuACmsbBnpfdeJpNYsEQxLSoepJBbZ=O6D6Rcg@mail.gmail.com>
Subject: Re: [PATCH] ARM: use assembly mnemonics for VFP register access
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Stefan Agner <stefan@agner.ch>, Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Jian Cai <jiancai@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Manoj Gupta <manojgupta@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 at 20:10, Nick Desaulniers <ndesaulniers@google.com> wr=
ote:
>
> On Mon, Feb 24, 2020 at 9:22 PM Stefan Agner <stefan@agner.ch> wrote:
> >
> > Clang's integrated assembler does not allow to to use the mcr
> > instruction to access floating point co-processor registers:
> > arch/arm/vfp/vfpmodule.c:342:2: error: invalid operand for instruction
> >         fmxr(FPEXC, fpexc & ~(FPEXC_EX|FPEXC_DEX|FPEXC_FP2V|FPEXC_VV|FP=
EXC_TRAP_MASK));
> >         ^
> > arch/arm/vfp/vfpinstr.h:79:6: note: expanded from macro 'fmxr'
> >         asm("mcr p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmxr   " #_vfp=
_ ", %0" \
> >             ^
> > <inline asm>:1:6: note: instantiated into assembly here
> >         mcr p10, 7, r0, cr8, cr0, 0 @ fmxr      FPEXC, r0
> >             ^
> >
> > The GNU assembler supports the .fpu directive at least since 2.17 (when
> > documentation has been added). Since Linux requires binutils 2.21 it is
> > safe to use .fpu directive. Use the .fpu directive and mnemonics for VF=
P
> > register access.
> >
> > This allows to build vfpmodule.c with Clang and its integrated assemble=
r.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/905
> > Signed-off-by: Stefan Agner <stefan@agner.ch>
> > ---
> >  arch/arm/vfp/vfpinstr.h | 12 ++++--------
> >  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > diff --git a/arch/arm/vfp/vfpinstr.h b/arch/arm/vfp/vfpinstr.h
> > index 38dc154e39ff..799ccf065406 100644
> > --- a/arch/arm/vfp/vfpinstr.h
> > +++ b/arch/arm/vfp/vfpinstr.h
> > @@ -62,21 +62,17 @@
> >  #define FPSCR_C (1 << 29)
> >  #define FPSCR_V        (1 << 28)
> >
> > -/*
> > - * Since we aren't building with -mfpu=3Dvfp, we need to code
> > - * these instructions using their MRC/MCR equivalents.
> > - */
> > -#define vfpreg(_vfp_) #_vfp_
> > -
> >  #define fmrx(_vfp_) ({                 \
> >         u32 __v;                        \
> > -       asm("mrc p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmrx   %0, " #=
_vfp_    \
> > +       asm(".fpu       vfpv2\n"        \
> > +           "vmrs       %0, " #_vfp_    \
> >             : "=3Dr" (__v) : : "cc");     \
> >         __v;                            \
> >   })
> >
> >  #define fmxr(_vfp_,_var_)              \
> > -       asm("mcr p10, 7, %0, " vfpreg(_vfp_) ", cr0, 0 @ fmxr   " #_vfp=
_ ", %0" \
> > +       asm(".fpu       vfpv2\n"        \
> > +           "vmsr       " #_vfp_ ", %0" \
> >            : : "r" (_var_) : "cc")
> >
> >  u32 vfp_single_cpdo(u32 inst, u32 fpscr);
> > --
>
> Hi Stefan,
> Thanks for the patch.  Reading through:
> - FMRX, FMXR, and FMSTAT:
> http://infocenter.arm.com/help/index.jsp?topic=3D/com.arm.doc.dui0068b/Bc=
fbdihi.html
> - VMRS and VMSR:
> http://infocenter.arm.com/help/index.jsp?topic=3D/com.arm.doc.dui0204h/Bc=
fbdihi.html
>
> Should a macro called `fmrx` that had a comment about `fmrx` be using
> `vmrs` in place of `fmrx`?
>
> It looks like Clang treats them the same, but GCC keeps them separate:
> https://godbolt.org/z/YKmSAs
> Ah, this is only when streaming to assembly. Looks like they have the
> same encoding, and produce the same disassembly. (Godbolt emits
> assembly by default, and has the option to compile, then disassemble).
> If I take my case from godbolt above:
>
> =E2=9E=9C  /tmp arm-linux-gnueabihf-gcc -O2 -c x.c
> =E2=9E=9C  /tmp llvm-objdump -dr x.o
>
> x.o: file format elf32-arm-little
>
>
> Disassembly of section .text:
>
> 00000000 bar:
>        0: f1 ee 10 0a                  vmrs r0, fpscr
>        4: 70 47                        bx lr
>        6: 00 bf                        nop
>
> 00000008 baz:
>        8: f1 ee 10 0a                  vmrs r0, fpscr
>        c: 70 47                        bx lr
>        e: 00 bf                        nop
>
> So indeed a similar encoding exists for the two different assembler
> instructions.

Does that hold for ARM (A32) instructions as well?
