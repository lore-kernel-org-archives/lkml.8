Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C78EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36776207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kmztc0PZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389107AbgEZMeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 08:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389007AbgEZMeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 08:34:07 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB04C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 05:34:06 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id q8so20326497iow.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 05:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=dKMQLkfxGfTGmxyabfuv0+iSbqh28h3pHwoaw3c28Js=;
        b=Kmztc0PZHeE9GMnh+mwlwAKwSVOZM0qFkahHHiT4oXMnwmxdAc84Z55hM4XpZekikt
         yjZueHv8cSsjfF3oOSdK9BfSBr3ZkVUmQO5Fe47BHw7a43OJwJqX72qOsfFHIXPrN0Ux
         l/RouRFmj91hidG2L/LurQeeJSzvX5AJs3q0/+sFZT2ECOiSvz8YEdWlmu2QB9MCXGv5
         PTHOaTyE2u82FCyb3m4BEnITzt712SFrrBQ7SIaf4zwOjFU9agaGcyhI0i0UVoWczXGx
         CSr/6JTKLXRyZDBZlKcChrXkSpOtlIbK3DGvtvuhv3LWypi9O+eF4jKnRJsvH+ZH3Mbo
         U4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=dKMQLkfxGfTGmxyabfuv0+iSbqh28h3pHwoaw3c28Js=;
        b=RfCOXRjfjX6diW2U6V3QOSwDnt4CmN8sx7z2TCLCSCE/HCVWifrF2zF1fWgeeCJoig
         65Q07gIHAXb3F9sEpeG9lw3UH0ZuNBBIPyPxlZvwuLUAmHtA1nWA9rOb6m/y2Sr59LHT
         ODGXEfMYCvZx6eRUklRc3S5Lm7enEvQopqcFFuxmrSz0L1TQ91RP3JIzg8zYoStP+8A+
         2SQM/SOevSxuQIe6RvSIhCfTExi7GK6YjaScdtoPbVybC3Gq8zE05bABRBg4IlE+VzBD
         UGaYl/NM+oG7OMtc61gTg1txPEu+HYAgyWEjF1TRjpGlwuCwIvmEI1d20mGQq9Uvnx03
         /x3A==
X-Gm-Message-State: AOAM531WIHULKBgjc4I37K/Ke6NU5y0RLM6h6J4OSGpBrkyJ6lnaL/V2
        YdKxmtKXOoRJ/4faulpNU9Jy3q8ke5RUdg+RilY=
X-Google-Smtp-Source: ABdhPJyuM1Q8Q41Q9x5fahY7RImPuyJ7v5KqrUC9qphA29v7YRe+UbZ+AgPiUR2BFKQ28wSlv3DqMorPuhNHt3sDVxE=
X-Received: by 2002:a02:a408:: with SMTP id c8mr744385jal.125.1590496446177;
 Tue, 26 May 2020 05:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200524212816.243139-1-nivedita@alum.mit.edu>
 <20200525225918.1624470-1-nivedita@alum.mit.edu> <CA+icZUVa8FhhwHgXn1o_hFmgqFG6-KE1F+qvkdCzQjmSSSDWDw@mail.gmail.com>
 <CAMj1kXHVFgRsbssJQD2C0GZnOgG=rMYbPGJQtiKhSw6sZj5PaA@mail.gmail.com>
In-Reply-To: <CAMj1kXHVFgRsbssJQD2C0GZnOgG=rMYbPGJQtiKhSw6sZj5PaA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 26 May 2020 14:33:55 +0200
Message-ID: <CA+icZUWyFDgieQswvfhWemzymDh_UiVqH2uH52a+0otcr2Pd4w@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] x86/boot: Remove runtime relocations from
 compressed kernel
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 2:30 PM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Tue, 26 May 2020 at 14:29, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Tue, May 26, 2020 at 12:59 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > >
> > > The compressed kernel currently contains bogus runtime relocations in
> > > the startup code in head_{32,64}.S, which are generated by the linker,
> > > but must not actually be processed at runtime.
> > >
> > > This generates warnings when linking with the BFD linker, and errors
> > > with LLD, which defaults to erroring on runtime relocations in read-only
> > > sections. It also requires the -z noreloc-overflow hack for the 64-bit
> > > kernel, which prevents us from linking it as -pie on an older BFD linker
> > > (<= 2.26) or on LLD, because the locations that are to be apparently
> > > relocated are only 32-bits in size and so cannot normally have
> > > R_X86_64_RELATIVE relocations.
> > >
> > > This series aims to get rid of these relocations. It is based on
> > > efi/next, where the latest patches touch the head code to eliminate the
> > > global offset table.
> > >
> > > The first patch is an independent fix for LLD, to avoid an orphan
> > > section in arch/x86/boot/setup.elf.
> > >
> > > The second patch gets rid of almost all the relocations. It uses
> > > standard PIC addressing technique for 32-bit, i.e. loading a register
> > > with the address of _GLOBAL_OFFSET_TABLE_ and then using GOTOFF
> > > references to access variables. For 64-bit, there is 32-bit code that
> > > cannot use RIP-relative addressing, and also cannot use the 32-bit
> > > method, since GOTOFF references are 64-bit only. This is instead handled
> > > using a macro to replace a reference like gdt with (gdt-startup_32)
> > > instead. The assembler will generate a PC32 relocation entry, with
> > > addend set to (.-startup_32), and these will be replaced with constants
> > > at link time. This works as long as all the code using such references
> > > lives in the same section as startup_32, i.e. in .head.text.
> > >
> > > The third patch addresses a remaining issue with the BFD linker, which
> > > insists on generating runtime relocations for absolute symbols. We use
> > > z_input_len and z_output_len, defined in the generated piggy.S file, as
> > > symbols whose absolute "addresses" are actually the size of the
> > > compressed payload and the size of the decompressed kernel image
> > > respectively. LLD does not generate relocations for these two symbols,
> > > but the BFD linker does, prior to the upcoming 2.35. To get around this,
> > > piggy.S is extended to also define two u32 variables (in .rodata) with
> > > the lengths, and the head code is modified to use those instead of the
> > > symbol addresses.
> > >
> > > An alternative way to handle z_input_len/z_output_len would be to just
> > > include piggy.S in head_{32,64}.S instead of as a separate object file,
> > > since the GNU assembler doesn't generate relocations for symbols set to
> > > constants.
> > >
> > > The last patch adds a check in the linker script to ensure that no
> > > runtime relocations get reintroduced. Since the GOT has been eliminated
> > > as well, the compressed kernel has no runtime relocations whatsoever any
> > > more.
> > >
> > > Changes from v1:
> > > - Add .text.* to setup.ld instead of just .text.startup
> > > - Rename the la() macro introduced in the second patch for 64-bit to
> > >   rva(), and rework the explanatory comment.
> > > - In the last patch, check both .rel.dyn and .rela.dyn, instead of just
> > >   one per arch.
> > >
> >
> > Hi,
> >
> > I would like to test this patchset v2 on top of Linux v5.7-rc7 together with:
> >
> > [1] x86/boot: Discard .discard.unreachable for arch/x86/boot/compressed/vmlinux
> > [2] x86/boot: Correct relocation destination on old linkers
> >
> > I tried to pull efi/next on top of Linux v5.7-rc7 and cleaned up the
> > merge problems, but I am not sure I did it correctly.
> > So, which patches are really relevant from efi/next?
> >
> > What's your suggestions?
> >
>
> efi/next is here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next
>
> You'll need the top 3 patches.

Thanks /o\.

- Sedat -
