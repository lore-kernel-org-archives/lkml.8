Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B328FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA00207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 19:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cHuezSmh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgERTKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 15:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726703AbgERTKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 15:10:24 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ABFC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 12:10:24 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u35so5278259pgk.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 12:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B9WsWP6dnEY5vCfQiuvwQaqKnNQto5CQpnFS4KzI7DY=;
        b=cHuezSmhHKbWR5zfm6IDklGMDHYGApFLx8L38GBmK/KvWwczsIOz9r+mKvBfs74RJL
         BAdZjB2n9mgd6yvaDhrjqZ5OzERYPrwQRDjO4L5+8q4x+FBbqU90q7KDbMF84tMYo8UH
         A4MeUZpi6YBF/ipNi/Ecf5Yif0+t9MsPIyZGE+NxT+n1l+2thrQrMtx98GajwAdSOCDo
         WE5mm3O+JkATr0nxhhWtk6YUmP+nv6DlZVrEjkzyjT8ZzE/87cmXLsc6HPdCVmHmnV+J
         X2hEd+Htukvq2JyEZHSWZq9BBB3qEUG/cE5YgTgYcZyQMDrnwcEdrXpCGPYy29m2d//2
         4Y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B9WsWP6dnEY5vCfQiuvwQaqKnNQto5CQpnFS4KzI7DY=;
        b=BwkZqyQ+NVH0YHy9uUyTgQUgcEsuiGkRrm42VP9oWjPdO6LGiud3UzYhMHSO62MZ1c
         jYQvJzdlx81oDoKZUrQR7ihQJiFkdIcqt6r2KkX6uV+fRsnnhsA2G/VQwcHqT4Y6LIgX
         +mb6L+ssYJ4LIGqHTTbCD6mBMMOEljZ08c7nRqu3U0E51Of9zUK3sligHEL+zljwqr4A
         pwheYREjA/lLRbmXaizaJkOfaJ0nFbJuGZuMCQG51CHkg0SOAmKVmmnIgrlCyQdDE507
         t1hB2n+CaAABsfT4Ke5y7Nat/XcNE4ycX1QznWlf8yTSrGaTCSrkWjLIKtvPoeX63P2i
         nuag==
X-Gm-Message-State: AOAM533J4U652vtSiC0TdbzpPxJOmdWg143uLp2zKfs8mxY1/w56k+36
        mCNKxy3tBpxi1F7pymHS1U9ux3Xx9fo/p0F0Qr8XZw==
X-Google-Smtp-Source: ABdhPJwVs+bkA/SMoonauhT/XHbckONFweCmjLOjou4EBg9G3HuFvPZv0+B6H6ynL3uGpPCZh4nTajwUuK6Ghq7ZKJA=
X-Received: by 2002:a63:4f09:: with SMTP id d9mr3246799pgb.10.1589829023749;
 Mon, 18 May 2020 12:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200501084215.242-1-dima@golovin.in> <20200515185051.GC19017@zn.tnic>
 <602331589572661@mail.yandex.ru> <20200517194429.scwhfr4l4bv4h3ux@google.com> <20200517202527.GA2563549@rani.riverdale.lan>
In-Reply-To: <20200517202527.GA2563549@rani.riverdale.lan>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 May 2020 12:10:11 -0700
Message-ID: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: allow a relocatable kernel to be linked with lld
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Borislav Petkov <bp@alien8.de>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 17, 2020 at 1:25 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> On Sun, May 17, 2020 at 12:44:29PM -0700, Fangrui Song wrote:
> > On 2020-05-16, Dmitry Golovin wrote:
> > >15.05.2020, 21:50, "Borislav Petkov" <bp@alien8.de>:
> > >>
> > >> I need more info here about which segment is read-only?
> > >>
> > >> Is this something LLD does by default or what's happening?
> > >>
> > >
> > >Probably should have quoted the original error message:
> > >
> > >    ld.lld: error: can't create dynamic relocation R_386_32 against
> > >    symbol: _bss in readonly segment; recompile object files with -fPIC
> > >    or pass '-Wl,-z,notext' to allow text relocations in the output
> >
> > Do we know where do these R_386_32 come from?
> >
> > When linking in -shared mode, the linker assumes the image is a shared
> > object and has undetermined image base at runtime. An absolute
> > relocation needs a text relocation (a relocation against a readonly
> > segment).
> >
> > When neither -z notext nor -z text is specified, GNU ld is in an
> > indefinite state where it will enable text relocations (DT_TEXTREL
> > DF_TEXTREL) on demand. It is not considered a good practice for
> > userspace applications to do this.
> >
> > Of course the kernel is different....... I know little about the kernel,
> > but if there is a way to make the sections containing R_386_32
> > relocations writable (SHF_WRITE), that will be a better solution to me.
> > In LLD, -z notext is like making every section SHF_WRITE.
>
> The assembly files head_32.S and head_64.S in arch/x86/boot/compressed
> create bogus relocations in .head.text and .text.
>
> This is the source of the common warning when using the bfd linker, for
> eg on 64-bit:
>   LD      arch/x86/boot/compressed/vmlinux
>   ld: arch/x86/boot/compressed/head_64.o: warning: relocation in read-only section `.head.text'
>   ld: warning: creating a DT_TEXTREL in object
>
> These relocations are "bogus", i.e. they're unwanted and the kernel
> won't actually boot if anything were to perform those relocations before
> running it. They're also the cause of the 64-bit kernel requiring linker
> support for the -z noreloc-overflow option to link it as PIE.
>
> From arch/x86/boot/compressed/Makefile:
>
> # To build 64-bit compressed kernel as PIE, we disable relocation
> # overflow check to avoid relocation overflow error with a new linker
> # command-line option, -z noreloc-overflow.
> KBUILD_LDFLAGS += $(shell $(LD) --help 2>&1 | grep -q "\-z
> noreloc-overflow" \
>         && echo "-z noreloc-overflow -pie --no-dynamic-linker")
>
> The relocations come from code like
>         leal    gdt(%ebp), %eax
> which should really be
>         leal    (gdt-startup_32)(%ebp), %eax
> to be technically correct.
>
> I've played around with fixing the head code to avoid creating the
> relocations in the first place, but never got around to submitting
> anything: if there is interest in this, I can polish it up and send it
> around.

We'd be happy to help test and review. :)
-- 
Thanks,
~Nick Desaulniers
