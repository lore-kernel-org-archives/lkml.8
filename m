Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055C7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE4072084C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RUDwiQ8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389012AbgEZM3m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 08:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728195AbgEZM3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 08:29:40 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21862C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 05:29:40 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id d7so21739831ioq.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 05:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=PHdiDb5Mr94WWWQ3Mnyn3fpsR2uXfxFeRBM2541NcjE=;
        b=RUDwiQ8S/8SJMjtICUN/A7+hhlOyeFxe4X2MJc6ughX1N2Mqe5tRaN2sstGPyfaZW8
         wOn8sOrmTMwEsWfWs7C6J03EKDFVg/6wSfSZ57LMIpZsDxRdLU6R4FVV7eiU1dt0PfM2
         YW61zSmNzmnpkAAf7GV0vOvFLGryVmQ0xkoE0Uor9rIlMFyjc9/MdBhOX9PeDfnvEEne
         En4ykExbAHKQ1EKQ/OAQshQu1XeGFP5e3BaiUxxHxtEWQ21burD+cFW/aKTHii2Aky9Y
         yOi3JsoYDLu4coL758Wyiwis3KJ2F1w5TRrQQftO0xLHwDOKzRSJpj+4XrcHOUaejNlL
         yHxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=PHdiDb5Mr94WWWQ3Mnyn3fpsR2uXfxFeRBM2541NcjE=;
        b=Q56dnG8JBM/QB8rfjHiBczaXeV9yaQLG26E3OkmHTLzE/1Q+9BRx0gUiu4JYdRsJ12
         QG7qruO8AsHkFyNVKuqw29SCYFwhoyO9vnxwTAxi4Oxz7tW5a7VJZJI8BFRYkdisJsvj
         Ciou94aKzusAerBYwi8wvhxiRGy8lXSX7K3PyBffJrME5B4TQoWYdhkDwPY3MKE/z0Ui
         qz9JQLR3QWzrgUVqKh96jOSoFgBgxLGZ3hNtrDmqiSxVy5B60SBLBnb44BNKVl4ysyJp
         Bn1vAs5i3/0RwBl0uRHt2qqJh7ow16j9qOZ4tbCBh0+Zl2HwG1eolw2NqecU7clcUomM
         dKRw==
X-Gm-Message-State: AOAM531P71uBlEw9IXQlTCG/jk+g5fpI1Y8tDFCpR5c3hFWvT8btq1LX
        JRJG4NWKJa3Tmb+Udb0m60GvrdUMsTtj/QzJ/qk=
X-Google-Smtp-Source: ABdhPJz092CIn1swlaEjty8qDGM37LW/qzCfFW8c6juBp/HbDtGs8w1WFdbgXt1AwenZDkdOvZUIHxM4oaePLV1NVAc=
X-Received: by 2002:a02:ca18:: with SMTP id i24mr742148jak.70.1590496177978;
 Tue, 26 May 2020 05:29:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200524212816.243139-1-nivedita@alum.mit.edu> <20200525225918.1624470-1-nivedita@alum.mit.edu>
In-Reply-To: <20200525225918.1624470-1-nivedita@alum.mit.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 26 May 2020 14:29:27 +0200
Message-ID: <CA+icZUVa8FhhwHgXn1o_hFmgqFG6-KE1F+qvkdCzQjmSSSDWDw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] x86/boot: Remove runtime relocations from
 compressed kernel
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 12:59 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> The compressed kernel currently contains bogus runtime relocations in
> the startup code in head_{32,64}.S, which are generated by the linker,
> but must not actually be processed at runtime.
>
> This generates warnings when linking with the BFD linker, and errors
> with LLD, which defaults to erroring on runtime relocations in read-only
> sections. It also requires the -z noreloc-overflow hack for the 64-bit
> kernel, which prevents us from linking it as -pie on an older BFD linker
> (<= 2.26) or on LLD, because the locations that are to be apparently
> relocated are only 32-bits in size and so cannot normally have
> R_X86_64_RELATIVE relocations.
>
> This series aims to get rid of these relocations. It is based on
> efi/next, where the latest patches touch the head code to eliminate the
> global offset table.
>
> The first patch is an independent fix for LLD, to avoid an orphan
> section in arch/x86/boot/setup.elf.
>
> The second patch gets rid of almost all the relocations. It uses
> standard PIC addressing technique for 32-bit, i.e. loading a register
> with the address of _GLOBAL_OFFSET_TABLE_ and then using GOTOFF
> references to access variables. For 64-bit, there is 32-bit code that
> cannot use RIP-relative addressing, and also cannot use the 32-bit
> method, since GOTOFF references are 64-bit only. This is instead handled
> using a macro to replace a reference like gdt with (gdt-startup_32)
> instead. The assembler will generate a PC32 relocation entry, with
> addend set to (.-startup_32), and these will be replaced with constants
> at link time. This works as long as all the code using such references
> lives in the same section as startup_32, i.e. in .head.text.
>
> The third patch addresses a remaining issue with the BFD linker, which
> insists on generating runtime relocations for absolute symbols. We use
> z_input_len and z_output_len, defined in the generated piggy.S file, as
> symbols whose absolute "addresses" are actually the size of the
> compressed payload and the size of the decompressed kernel image
> respectively. LLD does not generate relocations for these two symbols,
> but the BFD linker does, prior to the upcoming 2.35. To get around this,
> piggy.S is extended to also define two u32 variables (in .rodata) with
> the lengths, and the head code is modified to use those instead of the
> symbol addresses.
>
> An alternative way to handle z_input_len/z_output_len would be to just
> include piggy.S in head_{32,64}.S instead of as a separate object file,
> since the GNU assembler doesn't generate relocations for symbols set to
> constants.
>
> The last patch adds a check in the linker script to ensure that no
> runtime relocations get reintroduced. Since the GOT has been eliminated
> as well, the compressed kernel has no runtime relocations whatsoever any
> more.
>
> Changes from v1:
> - Add .text.* to setup.ld instead of just .text.startup
> - Rename the la() macro introduced in the second patch for 64-bit to
>   rva(), and rework the explanatory comment.
> - In the last patch, check both .rel.dyn and .rela.dyn, instead of just
>   one per arch.
>

Hi,

I would like to test this patchset v2 on top of Linux v5.7-rc7 together with:

[1] x86/boot: Discard .discard.unreachable for arch/x86/boot/compressed/vmlinux
[2] x86/boot: Correct relocation destination on old linkers

I tried to pull efi/next on top of Linux v5.7-rc7 and cleaned up the
merge problems, but I am not sure I did it correctly.
So, which patches are really relevant from efi/next?

What's your suggestions?

Regards,
- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/patch/?id=d6ee6529436a15a0541aff6e1697989ee7dc2c44
[2] https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/patch/?id=5214028dd89e49ba27007c3ee475279e584261f0

> Arvind Sankar (4):
>   x86/boot: Add .text.* to setup.ld
>   x86/boot: Remove run-time relocations from .head.text code
>   x86/boot: Remove runtime relocations from head_{32,64}.S
>   x86/boot: Check that there are no runtime relocations
>
>  arch/x86/boot/compressed/Makefile      |  36 +--------
>  arch/x86/boot/compressed/head_32.S     |  59 +++++++-------
>  arch/x86/boot/compressed/head_64.S     | 108 +++++++++++++++----------
>  arch/x86/boot/compressed/mkpiggy.c     |   6 ++
>  arch/x86/boot/compressed/vmlinux.lds.S |   8 ++
>  arch/x86/boot/setup.ld                 |   2 +-
>  6 files changed, 115 insertions(+), 104 deletions(-)
>
> --
> 2.26.2
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200525225918.1624470-1-nivedita%40alum.mit.edu.
