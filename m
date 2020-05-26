Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CCBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B696C207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:44:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4oVsmlS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbgEZMom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 08:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389265AbgEZMol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 08:44:41 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E853C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 05:44:41 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id l20so20147688ilj.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 05:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=192v8HLLXNUx+tzLmNUVYrYxDcyonvfeueAArNuXXsI=;
        b=d4oVsmlSAyr8eSxp3bZQn6iMXwXt9As6p8lp8pWw+ZfV4MJ+GOit/1KDMg26e5uKBO
         n7qmpMF2eyBRJ6DgSAq/ZbAJZAZC3Yfe8gUOnpgzE75HWZ9hEjRLp6kABtZwh1kYWAum
         zwE9Cb37lamzylUEcJ6O6SF9I48LxlXmmcWcXo2NKZHz4mmyu/5zY/WTfNAsg26qzut8
         QybUjo0eYL233a/cBrJOXOXhHY9cVqU0LoQZO67qrWZhugOJv2NB/KM3fJfRBqJhJfIW
         dnvbh/Qa6tiILM4AZ+SbvU/F45KoSHeRnr5LbpjcwlsprV+Z8fpxgyhW6rjgDDCbF99w
         jGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=192v8HLLXNUx+tzLmNUVYrYxDcyonvfeueAArNuXXsI=;
        b=k8h87MAjgu9hBiZc/5Vt8Bwcx9nUKDBbgdcT1uYScnyLXs4Yc9pemfB94UxoPzR6ue
         hVQBYMYbq7hpyiiAdhWSy4aUjb0lnu1K8YjJur0w7Nb3f8JPKcG5w1v26jSWV/923+mo
         OQZ4+5bwYU/PvoaU0XKAjkbUy4dRnUZxcULCYi6rCpy/TBdyUnYjTHrT1U0VHVBweHrl
         UC2M+DEzHZXwqbvbwzvDMDJ65+b0CVrHZdtH6YY/WKs6cwPDq7mPsXj1Ss9eUlbufJj4
         MJiCO6Fmq8XNe/eTLHDAgdzHBG9us2LknM+Vfy4SgxvAupEDQQ3gNm/L/xI+CsNSX/fC
         X0GQ==
X-Gm-Message-State: AOAM5325obqIP6T7PGjzSvm7XnaXJuv+p/EfwjD1enROxnLpoW6PdcQH
        SF1BUItXvx94gUabMAeonz/986Cz2cVDs7jN4dY=
X-Google-Smtp-Source: ABdhPJwdgN5kiESZs1KmJ2NKBxJ2BXz03Qx/L16bIcWrHQAa+xF5Go3ubIfVfYgz2sWkygjp8HDCUBdJODKWVurYiA0=
X-Received: by 2002:a92:6608:: with SMTP id a8mr934770ilc.204.1590497080697;
 Tue, 26 May 2020 05:44:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200524212816.243139-1-nivedita@alum.mit.edu>
 <20200525225918.1624470-1-nivedita@alum.mit.edu> <CA+icZUVa8FhhwHgXn1o_hFmgqFG6-KE1F+qvkdCzQjmSSSDWDw@mail.gmail.com>
 <CAMj1kXHVFgRsbssJQD2C0GZnOgG=rMYbPGJQtiKhSw6sZj5PaA@mail.gmail.com> <CA+icZUWyFDgieQswvfhWemzymDh_UiVqH2uH52a+0otcr2Pd4w@mail.gmail.com>
In-Reply-To: <CA+icZUWyFDgieQswvfhWemzymDh_UiVqH2uH52a+0otcr2Pd4w@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 26 May 2020 14:44:29 +0200
Message-ID: <CA+icZUVKRZPFX_Q8RRJnFsHrkM5VbiWUEam+6O5XSzgNaqAzPg@mail.gmail.com>
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

On Tue, May 26, 2020 at 2:33 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Tue, May 26, 2020 at 2:30 PM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Tue, 26 May 2020 at 14:29, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Tue, May 26, 2020 at 12:59 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> > > >
> > > > The compressed kernel currently contains bogus runtime relocations in
> > > > the startup code in head_{32,64}.S, which are generated by the linker,
> > > > but must not actually be processed at runtime.
> > > >
> > > > This generates warnings when linking with the BFD linker, and errors
> > > > with LLD, which defaults to erroring on runtime relocations in read-only
> > > > sections. It also requires the -z noreloc-overflow hack for the 64-bit
> > > > kernel, which prevents us from linking it as -pie on an older BFD linker
> > > > (<= 2.26) or on LLD, because the locations that are to be apparently
> > > > relocated are only 32-bits in size and so cannot normally have
> > > > R_X86_64_RELATIVE relocations.
> > > >
> > > > This series aims to get rid of these relocations. It is based on
> > > > efi/next, where the latest patches touch the head code to eliminate the
> > > > global offset table.
> > > >
> > > > The first patch is an independent fix for LLD, to avoid an orphan
> > > > section in arch/x86/boot/setup.elf.
> > > >
> > > > The second patch gets rid of almost all the relocations. It uses
> > > > standard PIC addressing technique for 32-bit, i.e. loading a register
> > > > with the address of _GLOBAL_OFFSET_TABLE_ and then using GOTOFF
> > > > references to access variables. For 64-bit, there is 32-bit code that
> > > > cannot use RIP-relative addressing, and also cannot use the 32-bit
> > > > method, since GOTOFF references are 64-bit only. This is instead handled
> > > > using a macro to replace a reference like gdt with (gdt-startup_32)
> > > > instead. The assembler will generate a PC32 relocation entry, with
> > > > addend set to (.-startup_32), and these will be replaced with constants
> > > > at link time. This works as long as all the code using such references
> > > > lives in the same section as startup_32, i.e. in .head.text.
> > > >
> > > > The third patch addresses a remaining issue with the BFD linker, which
> > > > insists on generating runtime relocations for absolute symbols. We use
> > > > z_input_len and z_output_len, defined in the generated piggy.S file, as
> > > > symbols whose absolute "addresses" are actually the size of the
> > > > compressed payload and the size of the decompressed kernel image
> > > > respectively. LLD does not generate relocations for these two symbols,
> > > > but the BFD linker does, prior to the upcoming 2.35. To get around this,
> > > > piggy.S is extended to also define two u32 variables (in .rodata) with
> > > > the lengths, and the head code is modified to use those instead of the
> > > > symbol addresses.
> > > >
> > > > An alternative way to handle z_input_len/z_output_len would be to just
> > > > include piggy.S in head_{32,64}.S instead of as a separate object file,
> > > > since the GNU assembler doesn't generate relocations for symbols set to
> > > > constants.
> > > >
> > > > The last patch adds a check in the linker script to ensure that no
> > > > runtime relocations get reintroduced. Since the GOT has been eliminated
> > > > as well, the compressed kernel has no runtime relocations whatsoever any
> > > > more.
> > > >
> > > > Changes from v1:
> > > > - Add .text.* to setup.ld instead of just .text.startup
> > > > - Rename the la() macro introduced in the second patch for 64-bit to
> > > >   rva(), and rework the explanatory comment.
> > > > - In the last patch, check both .rel.dyn and .rela.dyn, instead of just
> > > >   one per arch.
> > > >
> > >
> > > Hi,
> > >
> > > I would like to test this patchset v2 on top of Linux v5.7-rc7 together with:
> > >
> > > [1] x86/boot: Discard .discard.unreachable for arch/x86/boot/compressed/vmlinux
> > > [2] x86/boot: Correct relocation destination on old linkers
> > >
> > > I tried to pull efi/next on top of Linux v5.7-rc7 and cleaned up the
> > > merge problems, but I am not sure I did it correctly.
> > > So, which patches are really relevant from efi/next?
> > >
> > > What's your suggestions?
> > >
> >
> > efi/next is here:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/?h=next
> >
> > You'll need the top 3 patches.
>
> Thanks /o\.
>
> - Sedat -

Are those diffs correct when using "x86/boot: Correct relocation
destination on old linkers"?

$ cat ../head_32_S.diff
diff --cc arch/x86/boot/compressed/head_32.S
index 064e895bad92,03557f2174bf..000000000000
--- a/arch/x86/boot/compressed/head_32.S
+++ b/arch/x86/boot/compressed/head_32.S
@@@ -49,13 -49,17 +49,14 @@@
   * Position Independent Executable (PIE) so that linker won't optimize
   * R_386_GOT32X relocation to its fixed symbol address.  Older
   * linkers generate R_386_32 relocations against locally defined symbols,
-  * _bss, _ebss, in PIE.  It isn't wrong, just suboptimal compared
 - * _bss, _ebss, _got, _egot and _end, in PIE.  It isn't wrong, just less
 - * optimal than R_386_RELATIVE.  But the x86 kernel fails to properly handle
++ * _bss, _ebss, _end in PIE.  It isn't wrong, just suboptimal compared
 + * to R_386_RELATIVE.  But the x86 kernel fails to properly handle
   * R_386_32 relocations when relocating the kernel.  To generate
-  * R_386_RELATIVE relocations, we mark _bss and _ebss as hidden:
 - * R_386_RELATIVE relocations, we mark _bss, _ebss, _got, _egot and _end as
 - * hidden:
++ * R_386_RELATIVE relocations, we mark _bss, _ebss and _end as hidden:
   */
        .hidden _bss
        .hidden _ebss
 -      .hidden _got
 -      .hidden _egot
+       .hidden _end

        __HEAD
  SYM_FUNC_START(startup_32)

$ cat ../head_64_S.diff
diff --cc arch/x86/boot/compressed/head_64.S
index 4b7ad1dfbea6,76d1d64d51e3..000000000000
--- a/arch/x86/boot/compressed/head_64.S
+++ b/arch/x86/boot/compressed/head_64.S
@@@ -40,34 -40,11 +40,35 @@@
   */
        .hidden _bss
        .hidden _ebss
 -      .hidden _got
 -      .hidden _egot
+       .hidden _end

        __HEAD
 +
 +/*
 + * This macro gives the relative virtual address of X, i.e. the offset of X
 + * from startup_32. This is the same as the link-time virtual address of X,
 + * since startup_32 is at 0, but defining it this way tells the
 + * assembler/linker that we do not want the actual run-time address of X. This
 + * prevents the linker from trying to create unwanted run-time relocation
 + * entries for the reference when the compressed kernel is linked as PIE.
 + *
 + * A reference X(%reg) will result in the link-time VA of X being stored with
 + * the instruction, and a run-time R_X86_64_RELATIVE relocation entry that
 + * adds the 64-bit base address where the kernel is loaded.
 + *
 + * Replacing it with (X-startup_32)(%reg) results in the offset being stored,
 + * and no run-time relocation.
 + *
 + * The macro should be used as a displacement with a base register containing
 + * the run-time address of startup_32 [i.e. rva(X)(%reg)], or as an immediate
 + * [$ rva(X)].
 + *
 + * This macro can only be used from within the .head.text section, since the
 + * expression requires startup_32 to be in the same section as the code being
 + * assembled.
 + */
 +#define rva(X) ((X) - startup_32)
 +
        .code32
  SYM_FUNC_START(startup_32)
        /*

Thanks.

- Sedat -
