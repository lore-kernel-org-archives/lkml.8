Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE68BC433F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:47:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFA621927
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594720072;
	bh=Q8/MTPkiNQDIl29cAWYRiBnVKbFpRJbp1QXArV8qECA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ikYS64fR9DSxHR2wXgJyreVKjggWWwFMAYlrJimI1efw7InzsTBpJGB79yQDfzyhF
	 r6wYzsJytnRsXGJ5K1hHZleSIidURLDrrMZtbNR8KHU5RrbUOCQv+JOmffosaoVzei
	 h91gwKVJkdlyPyFWYYt0NnPtoHLwBTKz3X3DkLg8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGNJrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:47:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgGNJru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:47:50 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87C63221EE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 09:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594720069;
        bh=Q8/MTPkiNQDIl29cAWYRiBnVKbFpRJbp1QXArV8qECA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TKihbRN9GyDAJYU7aabSNNmw+cwcRU6uA+fCvMM0MqgkEUL4LbJ6gS+yBolI63V54
         9hKRykdpE+y3S1bjCu7RHz6JTIXiBpTXppCuT/ETpK4CCukdkkM0f+cUIhRHZ8kq2O
         JJ66LANx3inJNONXh7Vv/cTSDIx3M8VPpNIu2mzo=
Received: by mail-ot1-f53.google.com with SMTP id e90so12603957ote.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 02:47:49 -0700 (PDT)
X-Gm-Message-State: AOAM533/9Hyf6Sobe09M1sxAPO4swakE6oz3Jj+JrHAeVZmo7vY9XzK8
        9A1JoSWpN0VStL3EgV+yALfq8HSIl0i52bSYWQU=
X-Google-Smtp-Source: ABdhPJzegTzgv6ccf1RDoh6uehGm2MUH8SnZSFP/1AfbNyYEOHlmNYjqch9NAPqw9RXs1zDjMsbDZ1IWMEwhj5Kzfss=
X-Received: by 2002:a9d:688:: with SMTP id 8mr3330059otx.108.1594720068773;
 Tue, 14 Jul 2020 02:47:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-3-nivedita@alum.mit.edu> <CA+icZUVPF9-0KysS14f9oV7py87BfkK1mMS6cUKuusaos2K7hg@mail.gmail.com>
In-Reply-To: <CA+icZUVPF9-0KysS14f9oV7py87BfkK1mMS6cUKuusaos2K7hg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Jul 2020 12:47:37 +0300
X-Gmail-Original-Message-ID: <CAMj1kXF9F+3nn4L3Gv0NWKEQXa+rTJmOK=rDZNB8qbUax3SM0Q@mail.gmail.com>
Message-ID: <CAMj1kXF9F+3nn4L3Gv0NWKEQXa+rTJmOK=rDZNB8qbUax3SM0Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] x86/boot/compressed: Force hidden visibility for
 all symbol references
To:     Sedat Dilek <sedat.dilek@gmail.com>
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
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 at 12:21, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Mon, Jun 29, 2020 at 4:09 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > From: Ard Biesheuvel <ardb@kernel.org>
> >
> > Eliminate all GOT entries in the decompressor binary, by forcing hidden
> > visibility for all symbol references, which informs the compiler that
> > such references will be resolved at link time without the need for
> > allocating GOT entries.
> >
> > To ensure that no GOT entries will creep back in, add an assertion to
> > the decompressor linker script that will fire if the .got section has
> > a non-zero size.
> >
> > [Arvind: fixup -include hidden.h to -include $(srctree)/$(src)/hidden.h]
> >
>
> Thanks for your v3 patchset.
>
> I tried your initial patchset and informed you about the <hidden.h>
> include file handling.
> Dropped your patchset against Linux v5.7 as I got no (satisfying) replies.

Dropped from where? This series should be taken through the -tip tree.

> For me this one is missing a Reported-by of mine.
>

We don't usually add reported-by lines for issues that were resolved
before the series was merged, given that the reported issue never
existed in mainline to begin with.

> As I want to test the whole v3 series, I will report later.
>

A tested-by is always appreciated.

> - Sedat -
>
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> > Acked-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > From: Ard Biesheuvel <ardb@kernel.org>
> > Link: https://lore.kernel.org/r/20200523120021.34996-3-ardb@kernel.org
> > ---
> >  arch/x86/boot/compressed/Makefile      |  1 +
> >  arch/x86/boot/compressed/hidden.h      | 19 +++++++++++++++++++
> >  arch/x86/boot/compressed/vmlinux.lds.S |  1 +
> >  3 files changed, 21 insertions(+)
> >  create mode 100644 arch/x86/boot/compressed/hidden.h
> >
> > diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
> > index 7619742f91c9..b01c8aed0f23 100644
> > --- a/arch/x86/boot/compressed/Makefile
> > +++ b/arch/x86/boot/compressed/Makefile
> > @@ -42,6 +42,7 @@ KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
> >  KBUILD_CFLAGS += -Wno-pointer-sign
> >  KBUILD_CFLAGS += $(call cc-option,-fmacro-prefix-map=$(srctree)/=)
> >  KBUILD_CFLAGS += -fno-asynchronous-unwind-tables
> > +KBUILD_CFLAGS += -include $(srctree)/$(src)/hidden.h
> >
> >  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
> >  GCOV_PROFILE := n
> > diff --git a/arch/x86/boot/compressed/hidden.h b/arch/x86/boot/compressed/hidden.h
> > new file mode 100644
> > index 000000000000..49a17b6b5962
> > --- /dev/null
> > +++ b/arch/x86/boot/compressed/hidden.h
> > @@ -0,0 +1,19 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * When building position independent code with GCC using the -fPIC option,
> > + * (or even the -fPIE one on older versions), it will assume that we are
> > + * building a dynamic object (either a shared library or an executable) that
> > + * may have symbol references that can only be resolved at load time. For a
> > + * variety of reasons (ELF symbol preemption, the CoW footprint of the section
> > + * that is modified by the loader), this results in all references to symbols
> > + * with external linkage to go via entries in the Global Offset Table (GOT),
> > + * which carries absolute addresses which need to be fixed up when the
> > + * executable image is loaded at an offset which is different from its link
> > + * time offset.
> > + *
> > + * Fortunately, there is a way to inform the compiler that such symbol
> > + * references will be satisfied at link time rather than at load time, by
> > + * giving them 'hidden' visibility.
> > + */
> > +
> > +#pragma GCC visibility push(hidden)
> > diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
> > index b17d218ccdf9..4bcc943842ab 100644
> > --- a/arch/x86/boot/compressed/vmlinux.lds.S
> > +++ b/arch/x86/boot/compressed/vmlinux.lds.S
> > @@ -81,6 +81,7 @@ SECTIONS
> >         DISCARDS
> >  }
> >
> > +ASSERT(SIZEOF(.got) == 0, "Unexpected GOT entries detected!")
> >  #ifdef CONFIG_X86_64
> >  ASSERT(SIZEOF(.got.plt) == 0 || SIZEOF(.got.plt) == 0x18, "Unexpected GOT/PLT entries detected!")
> >  #else
> > --
> > 2.26.2
> >
