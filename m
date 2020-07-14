Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4C5C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:21:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58E5C20674
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:21:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEvn4OQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGNJVJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgGNJVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:21:09 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35B6C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 02:21:08 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v6so16561944iob.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 02:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=C11Oho+jb/RAewyI2tPC4vl+z9j8D1ewX1ArPvL+1E8=;
        b=tEvn4OQxwUa/AnfyKQ7zrBWp93Qp1Ib98B+IaC3VDMOqbRzjjtpEMjZsWL29AgtsBC
         f8PuQ374JWWzyg5dXzuFTq6eq4pENL4HNq70vP2/pfBs+QtdETXj5SzcUbYi8L0UeqbI
         81+iungd2ZWjQhKBt7V40lgzabDRb2df6c8kE56Zme3bZBu4HHJVCTN+TK6mmZRVPgEe
         GNMIiNttXP79IKrNpJM6eKrNgJPI03jnVzyiWcEDCIZ8Icq+dqmv40Ttf4VN1dmT+wII
         q0qCh88D2Bv1Ap/IrFnHGlDURfjC7iZODGzHRdGBR6MUiNQNm/2qkwLOCJ8bGowBnmgj
         NYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=C11Oho+jb/RAewyI2tPC4vl+z9j8D1ewX1ArPvL+1E8=;
        b=mxQ7dJ8C4iWYHQshZkAibBaW4H0gjbUOCt+JKQvQjscYlB9BwKgmK6hsUtWD+gcmx6
         nyOg28pcjUkUliFV8ZcWMKEIxYjHfIDcYnOZSjQ7ME7uGVaIy5c7w9KAQ2i0wmpjBzHk
         JYae0yMt1RVNAxPTj9Ph8tf5EOCvyJkvypYXnMrUXGexhWVn5rdN5boWVVklpmR3OlOh
         ocMnkdPAA2ALP/cARAw22bIj7McsCb2jPbj33Cyh10NPbC0JtI7Yh3o236vTLQNBVio9
         HcG8o5hMAnSSYgNKZMCz3es0TRYMcpRCe6BTwNmAQrKt9HpSU0LmfDmB+ejVy5dwwUlW
         RxeA==
X-Gm-Message-State: AOAM531ChpMsHytnbwlJU7LaPLoG7ruqOb1KwPiITKVYqs4Ot+/8UoDT
        iXSb5mFJOjGwMbpM0II871V951KYcOjcT2KxUbI=
X-Google-Smtp-Source: ABdhPJyWkjyUsp9El69AxG6PyW6EvvYdrYKzfgAUB1ZkJmrUKE4fk22FTxZ4NC+VN1awEVUML6wTlmbwqhRH0TENZTE=
X-Received: by 2002:a05:6602:1555:: with SMTP id h21mr3908817iow.163.1594718468272;
 Tue, 14 Jul 2020 02:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140928.858507-1-nivedita@alum.mit.edu> <20200629140928.858507-3-nivedita@alum.mit.edu>
In-Reply-To: <20200629140928.858507-3-nivedita@alum.mit.edu>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 14 Jul 2020 11:20:57 +0200
Message-ID: <CA+icZUVPF9-0KysS14f9oV7py87BfkK1mMS6cUKuusaos2K7hg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] x86/boot/compressed: Force hidden visibility for
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

On Mon, Jun 29, 2020 at 4:09 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
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
> [Arvind: fixup -include hidden.h to -include $(srctree)/$(src)/hidden.h]
>

Thanks for your v3 patchset.

I tried your initial patchset and informed you about the <hidden.h>
include file handling.
Dropped your patchset against Linux v5.7 as I got no (satisfying) replies.
For me this one is missing a Reported-by of mine.

As I want to test the whole v3 series, I will report later.

- Sedat -

> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Arvind Sankar <nivedita@alum.mit.edu>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> From: Ard Biesheuvel <ardb@kernel.org>
> Link: https://lore.kernel.org/r/20200523120021.34996-3-ardb@kernel.org
> ---
>  arch/x86/boot/compressed/Makefile      |  1 +
>  arch/x86/boot/compressed/hidden.h      | 19 +++++++++++++++++++
>  arch/x86/boot/compressed/vmlinux.lds.S |  1 +
>  3 files changed, 21 insertions(+)
>  create mode 100644 arch/x86/boot/compressed/hidden.h
>
> diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> index 7619742f91c9..b01c8aed0f23 100644
> --- a/arch/x86/boot/compressed/Makefile
> +++ b/arch/x86/boot/compressed/Makefile
> @@ -42,6 +42,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
>  KBUILD_CFLAGS += -Wno-pointer-sign
>  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
>  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
> +KBUILD_CFLAGS += -include $(srctree)/$(src)/hidden.h
>
>  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  GCOV_PROFILE := n
> diff --git a/arch/x86/boot/compressed/hidden.h b/arch/x86/boot/compressed/hidden.h
> new file mode 100644
> index 000000000000..49a17b6b5962
> --- /dev/null
> +++ b/arch/x86/boot/compressed/hidden.h
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
> --
> 2.26.2
>
