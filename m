Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B4E8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01408206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:54:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrE2/4u2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729956AbgGOIyc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbgGOIyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:54:32 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13742C061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:54:32 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l1so1431423ioh.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 01:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=1k+VOrS3k+fDAx9V/lzvRFaKuobwwRq89CgWgY4l2xA=;
        b=ZrE2/4u2sh46AtpcdPlk+fEFVxq7lZTxmNHDVr06mBbPiRkgluZ2wWqEzlgAxExLhd
         0fFiA4AwRB+00MexfCJ6wrcMGft7oqa/w4mRjj9IhAf7Gm94ymaOyF9FTmmDl709oAiv
         H0ltiEX8OhLYrWcY2fe2XfNMOF61DvXIKhe2W098vox94LPbpl06/86z+oUasgqJmeFX
         h/pb3lUmdQFxJFfNgv4MyaImg58BDiQpAUNPA2VdMC+IqqFenHAjNE5M4YDq/6F8B8uG
         N5yj+yFYPMzLrK7OWSZq7baINiBFE/n7+6hl463kYA7yG/yU/61ZM1KezGrM+adda7Lr
         4cyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=1k+VOrS3k+fDAx9V/lzvRFaKuobwwRq89CgWgY4l2xA=;
        b=XZUHNzVZd3ZOPmhTj/Kit+xj6ID35f2PPDQbgPebd11Y4PJiYUD5ha1yVmGZcjb04X
         DO7ut/asHH/3sFt/mTReFEafQTK9qaOXAQYeh0Wqro8skpFCyk7X+lexHgLjG5VZ0qSi
         WJpCweNe5Fh02MhyEzfFeQ+XP8qbjttOjRGWf1IafRuo7GGjcA4+emeCo+sIBROJ/UTN
         I4G/WJX4pUiQoxx+csP64izLPRtwLzywPO+UEwWszHrSkNHWwLtKMKv8TkhgyqAtuS9w
         e+B0CKkIbrM2BprkixMkTqi/B3mrjUQ6qy55pPES+E1BtRddqSo2+9XPJExndvbniyy2
         +s+g==
X-Gm-Message-State: AOAM530s1u1n8KKNstAJB+rBEW4cAwxI7RjozRybjoNNjVN2qyEdii+r
        XQSQXbB22mGMjs5r8N5Ydax/seEXefzlUrlqAVE=
X-Google-Smtp-Source: ABdhPJyGZfMuIMjd5xSTPFS1L4yGLLghk2ZfNiko2/gBuJHgNHwG8MXr5RjAd6ep2uEBBEzMDmS4FyjxtuHSZF5rmCM=
X-Received: by 2002:a6b:c343:: with SMTP id t64mr9383464iof.66.1594803271042;
 Wed, 15 Jul 2020 01:54:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200714023836.2310569-1-nivedita@alum.mit.edu> <20200715004133.1430068-3-nivedita@alum.mit.edu>
In-Reply-To: <20200715004133.1430068-3-nivedita@alum.mit.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 15 Jul 2020 10:54:19 +0200
Message-ID: <CA+icZUUxn6qZhXEgr4jiBSUjSLqCw=wPLwmKZw6eViZ6ORLXdQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] x86/boot/compressed: Force hidden visibility for
 all symbol references
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
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 2:41 AM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> From: Ard Biesheuvel <ardb@kernel.org>
>
> Eliminate all GOT entries in the decompressor binary, by forcing hidden
> visibility for all symbol references, which informs the compiler that
> such references will be resolved at link time without the need for
> allocating GOT entries.
>
> To ensure that no GOT entries will creep back in, add an assertion to
> the decompressor linker script that will fire if the .got section has
> a non-zero size.
>
> [Arvind: move hidden.h to include/linux instead of making a copy]
>

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>
Reported-by: Sedat Dilek <sedat.dilek@gmail.com>

Reported hidden.h breakage and asked for a follow-up.

- Sedat -

[1] https://marc.info/?l=linux-kernel&m=159056070321982&w=2

> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Arvind Sankar <nivedita@alum.mit.edu>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> From: Ard Biesheuvel <ardb@kernel.org>
> Link: https://lore.kernel.org/r/20200523120021.34996-3-ardb@kernel.org
> ---
>  arch/x86/boot/compressed/Makefile      |  1 +
>  arch/x86/boot/compressed/vmlinux.lds.S |  1 +
>  drivers/firmware/efi/libstub/Makefile  |  2 +-
>  drivers/firmware/efi/libstub/hidden.h  |  6 ------
>  include/linux/hidden.h                 | 19 +++++++++++++++++++
>  5 files changed, 22 insertions(+), 7 deletions(-)
>  delete mode 100644 drivers/firmware/efi/libstub/hidden.h
>  create mode 100644 include/linux/hidden.h
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 7619742f91c9..c829d874dcac 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -42,6 +42,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>  KBUILD_CFLAGS += -Wno-pointer-sign
>  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
> +KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
>
>  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  GCOV_PROFILE := n
> diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> index b17d218ccdf9..4bcc943842ab 100644
> --- a/arch/x86/boot/compressed/vmlinux.lds.S
> +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> @@ -81,6 +81,7 @@ SECTIONS
>         DISCARDS
>  }
>
> +ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
>  #ifdef CONFIG_X86_64
>  ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
>  #else
> diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
> index 4cce372edaf4..609157a40493 100644
> --- a/drivers/firmware/efi/libstub/Makefile
> +++ b/drivers/firmware/efi/libstub/Makefile
> @@ -27,7 +27,7 @@ cflags-$(CONFIG_ARM)          := $(subst $(CC_FLAGS_FTRACE),,$(KBUILD_CFLAGS)) \
>  cflags-$(CONFIG_EFI_GENERIC_STUB) += -I$(srctree)/scripts/dtc/libfdt
>
>  KBUILD_CFLAGS                  := $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
> -                                  -include $(srctree)/drivers/firmware/efi/libstub/hidden.h \
> +                                  -include $(srctree)/include/linux/hidden.h \
>                                    -D__NO_FORTIFY \
>                                    $(call cc-option,-ffreestanding) \
>                                    $(call cc-option,-fno-stack-protector) \
> diff --git a/drivers/firmware/efi/libstub/hidden.h b/drivers/firmware/efi/libstub/hidden.h
> deleted file mode 100644
> index 3493b041f419..000000000000
> --- a/drivers/firmware/efi/libstub/hidden.h
> +++ /dev/null
> @@ -1,6 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -/*
> - * To prevent the compiler from emitting GOT-indirected (and thus absolute)
> - * references to any global symbols, override their visibility as 'hidden'
> - */
> -#pragma GCC visibility push(hidden)
> diff --git a/include/linux/hidden.h b/include/linux/hidden.h
> new file mode 100644
> index 000000000000..49a17b6b5962
> --- /dev/null
> +++ b/include/linux/hidden.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * When building position independent code with GCC using the -fPIC option,
> + * (or even the -fPIE one on older versions), it will assume that we are
> + * building a dynamic object (either a shared library or an executable) that
> + * may have symbol references that can only be resolved at load time. For a
> + * variety of reasons (ELF symbol preemption, the CoW footprint of the section
> + * that is modified by the loader), this results in all references to symbols
> + * with external linkage to go via entries in the Global Offset Table (GOT),
> + * which carries absolute addresses which need to be fixed up when the
> + * executable image is loaded at an offset which is different from its link
> + * time offset.
> + *
> + * Fortunately, there is a way to inform the compiler that such symbol
> + * references will be satisfied at link time rather than at load time, by
> + * giving them 'hidden' visibility.
> + */
> +
> +#pragma GCC visibility push(hidden)
> --
> 2.26.2
>
