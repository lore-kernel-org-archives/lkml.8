Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48B4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ADD72177B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 21:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yv3wn2cr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgHGVyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 17:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgHGVyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 17:54:53 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE3A8C061757
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 14:54:52 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t10so1795098plz.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 14:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvRGcDuizgzYHfGqKWM/eyvjCExelLzyI7VykszthhA=;
        b=Yv3wn2cry//B5ePdcUe9owHQplszhGtCIZLuMcKnhnRVcwYMr1OntJO+RwRDHkjzZm
         KVpZpKmvU9Px8Ov1zowsDGijOLGFq9U3ngiMz1FXua4PeJxyATVWA7wQ9meiQMnN+wTH
         ZjMHKPdnKSijRG7cXqJegeYTOzzK0aa3Bf/0HShMuyCLlOk6uYS6a2XTjfDiC79BiH5U
         ngfTPDWWlfeAJv8319CDUA4N0R6gsZUvmQavPMkpAZ5EiY80I7DaiNmAqCmnROpaHLfz
         wHW8a1oyqw4BWNbmXveSyNuAT/Yp6gLGN7xw7m+cxIOlEgA/CivLyyF7gHc+Fb7dEFXa
         sK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvRGcDuizgzYHfGqKWM/eyvjCExelLzyI7VykszthhA=;
        b=teGNUyZzTR1ZXehSWy5O8XWrLixH4LTo5apAIgujbyRILJWq1xfAiqjhcIyp+L1mki
         lBvkT9PtvfjxTQyHesOCPc7cDVnxTN9V0HaPMfh9N5gfm3WXAzFFWgpSLjNBY9djHxDs
         muaN4f0SDIetarqi5ND8DDjTg/f+VgZBfczEIycMMoXH9Eu2b4QNNae0OJhQxp+sZ/Wz
         w2heDBVDRM0OqcEPAJuo8c8PrkRpMYebb76OgJ9uMh7Y0L5bd8CPrRhrkxSFERhQcYcT
         Lgs6KPOTK4pOKCpUUSkYJBhgAoaeu7ZEcIOHjtvIbTT1UhERCebKozixLji6hVzMAZOs
         ebTw==
X-Gm-Message-State: AOAM533aY4XsmCL2sMWj9bfCOSbApaKBOG/mbLH6LGYaiPn3GlJJE587
        FOazsNum3S/o8U2t8TdnAzyeKyOu9h150WsqXTsObw==
X-Google-Smtp-Source: ABdhPJzYzSdsx+n9P0kp2GeRmYj7shzYBk4a0VXyG8ST4ZyHiaYDzwyfrycKmBUlViEzbP4u+TTdrHnQFoGrDccJGJs=
X-Received: by 2002:a17:90a:3ad1:: with SMTP id b75mr14470579pjc.25.1596837291969;
 Fri, 07 Aug 2020 14:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200807194100.3570838-1-ndesaulniers@google.com> <20200807212914.GB1454138@rani.riverdale.lan>
In-Reply-To: <20200807212914.GB1454138@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Aug 2020 14:54:39 -0700
Message-ID: <CAKwvOdmD1OMnYE55O+YUkAh+C4Der+2CqKd7JVzfr0+6hYx6jw@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: avoid relaxable symbols with Clang
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Fangrui Song <maskray@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        e5ten.arch@gmail.com, "# 3.4.x" <stable@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Dmitry Golovin <dima@golovin.in>,
        Marco Elver <elver@google.com>, Nick Terrell <terrelln@fb.com>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 2:29 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Fri, Aug 07, 2020 at 12:41:00PM -0700, Nick Desaulniers wrote:
> > A recent change to a default value of configuration variable
> > (ENABLE_X86_RELAX_RELOCATIONS OFF -> ON) in LLVM now causes Clang's
> > integrated assembler to emit R_X86_64_GOTPCRELX/R_X86_64_REX_GOTPCRELX
> > relocations. LLD will relax instructions with these relocations based on
> > whether the image is being linked as position independent or not.  When
> > not, then LLD will relax these instructions to use absolute addressing
> > mode (R_RELAX_GOT_PC_NOPIC). This causes kernels built with Clang
> > and linked with LLD to fail to boot.
>
> It could also cause kernels compiled with gcc and linked with LLD to
> fail in the same way, no? The gcc/gas combination will generate the
> relaxed relocations from I think gas-2.26 onward. Although the only
> troublesome symbol in the case of gcc/gas is trampoline_32bit_src,
> referenced from pgtable_64.c (gcc doesn't use a GOTPC reloc for _pgtable
> etc).

Thanks for taking a look, and the feedback. I appreciate it!

$ gcc --version | head -n 1
gcc (Debian 9.3.0-11) 9.3.0
$ make -j71 clean defconfig bzImage
$ llvm-readelf -r arch/x86/boot/compressed/*.o | grep -e
R_X86_64_GOTPCRELX -e R_X86_64_REX_GOTPCRELX
0000000000000114  000000120000002a R_X86_64_REX_GOTPCRELX
0000000000000000 trampoline_32bit_src - 4
$ llvm-readelf -r arch/x86/boot/compressed/vmlinux | grep -e
R_X86_64_GOTPCRELX -e R_X86_64_REX_GOTPCRELX
$

So it looks like yes.  I guess then we'd need to add a check for
CONFIG_LD_IS_LLD and CONFIG_CC_IS_GCC and binutils version is 2.26+?
I don't mind adding support for that combination, but I'd like to skip
it in this patch for the sake of backporting something small to stable
to get our CI green ASAP, since CONFIG_LD_IS_LLD probably doesn't
exist for those stable branches, which will complicate the backport of
such a patch.  So I'd do it in a follow up patch if we're cool with
that?

> I'm a bit surprised you were able to boot with just _pgtable fixed
> (looking at the CBL issue), there are quite a few more GOTPC relocs with
> clang -- maybe LLD isn't doing all the optimizations it could yet.

I am, too.  I didn't specify which symbol was problematic or put this
flag on just one object file, because it's likely that there's an
issue with multiple symbols in multiple object files, though it's just
_pgtable that causes observable boot failures.

> This potential issue was mentioned [0] in one of the earlier threads
> (see last paragraph).
>
> [0] https://lore.kernel.org/lkml/20200526191411.GA2380966@rani.riverdale.lan/

Oh, indeed.

> > Also, the LLVM commit notes that these relocation types aren't supported
> > until binutils 2.26. Since we support binutils 2.23+, avoid the
> > relocations regardless of linker.
>
> Note that the GNU assembler won't support the option to disable the
> relaxations until 2.26, when they were added.
>
> However, it turns out that clang always uses the integrated assembler
> for the decompressor (and the EFI stub) because the no-integrated-as
> option gets dropped when building these pieces, due to redefinition of
> KBUILD_CFLAGS. You might want to mention this in the commit log or a

That's why I was careful to note in the commit message that it was
Clang's integrated assembler (assembler job) vs Clang (compiler job)
itself that was producing these.  May I add precisely:

```
Note that the GNU assembler won't support the option to disable the
relaxations until 2.26, when they were added.

However, it turns out that clang always uses the integrated assembler
for the decompressor (and the EFI stub) because the no-integrated-as
option gets dropped when building these pieces, due to redefinition of
KBUILD_CFLAGS.
```
with your suggested-by tag for a v2?

> comment to explain why using the option unconditionally is safe. It
> might need to be made conditional if the CFLAGS ever gets fixed to
> maintain no-integrated-as.
>
> Thanks.



-- 
Thanks,
~Nick Desaulniers
