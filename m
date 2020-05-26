Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C75C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B957620888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXiRcXq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392344AbgEZTRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404340AbgEZTOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:14:15 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24202C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:14:15 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s1so21804360qkf.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AGRR8LANYx1vusOdI6o+XaJhETZ0bUiJLjthC+zTia0=;
        b=GXiRcXq7i/cErYLHCq2gWMPsKOylH2aGDJEIV7Uhwi9bH+Zw1q2xJ6HIHpg7h/RYh/
         fu/kV5ovtxbDpl9I1XJp5tPbvjLeV2hGQM3UIdn+rUbWyfVuqMABnPDAkzhL7KKaPhNr
         /Uy75wCN01T3pYMtm4uAe0pbK69uImIgaDZSXxIhGj3Wo+PhoqilcAjODsxCUYFudx2b
         +84U/xXoYyEIoH5OGgATjHTPgW1k9XsbK7que7w3YRpe3foCZWTn6Iqgf512r5kx8uJm
         e0sYKjbtoAbxTnhev2hHBDT5TYW49rjlI0WyFFghepBqpFE86ad5dolsngXk6lk0iR4P
         ulKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AGRR8LANYx1vusOdI6o+XaJhETZ0bUiJLjthC+zTia0=;
        b=DQ2pA96+ci6vJ9zeel+t2t0TnU+2eZd5lcjIJXwCOoUc93m5Ipyj0Y2hqQao68BOsI
         sdbJRSoJOUSv/8H0xJi5pHAS6C8zfG04BJBAYlSnx18s+J0h8odJwpqfAM2ubRWHRH2/
         J9hxVAc32wlgbmsIyEybGFx9Fg7JVqhTkA7pwwv2KDynV9jWyy1usRYjnCdbBFD29ccB
         kFQ23F+VC6aRYgQoarREXW3J6na0GVUZ29edk6BryxjS0UX+uI7Bpdcm6u+kuHunlSVl
         bNi13uhsG2MktiY2LXD+J6BFM+jE09oLnKkg2oJydt1Q3f9FKHcmxjHeZbawo//KBifx
         wesg==
X-Gm-Message-State: AOAM531JtrHt+5DtC97ogeVXl0le8oeCJoTVY2eFnRaJyrnijZ0q9GNK
        4XpVvdTTbn3tK1TrQf20Jf4PAgye
X-Google-Smtp-Source: ABdhPJwzeXg78GejYrTf1eOdhS3tJAa+GaOmeavhiqfI3uOa8H6+9ILy4CyT9+BISQsxZveAKj0Tmg==
X-Received: by 2002:a05:620a:1261:: with SMTP id b1mr288614qkl.377.1590520454251;
        Tue, 26 May 2020 12:14:14 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id c17sm454252qtw.48.2020.05.26.12.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:14:13 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 26 May 2020 15:14:11 -0400
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] x86/boot: Check that there are no runtime
 relocations
Message-ID: <20200526191411.GA2380966@rani.riverdale.lan>
References: <20200524212816.243139-1-nivedita@alum.mit.edu>
 <20200525225918.1624470-5-nivedita@alum.mit.edu>
 <CAMj1kXHc4o91VkaChoyVzr4w-HOaashMPtkCKLaszMGCxhR_2A@mail.gmail.com>
 <20200526151623.GB2190602@rani.riverdale.lan>
 <20200526171340.pdbautbix5ygdvgp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200526171340.pdbautbix5ygdvgp@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 10:13:40AM -0700, Fangrui Song wrote:
> 
> On 2020-05-26, Arvind Sankar wrote:
> >On Tue, May 26, 2020 at 08:11:56AM +0200, Ard Biesheuvel wrote:
> >> On Tue, 26 May 2020 at 00:59, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >> >  # Compressed kernel should be built as PIE since it may be loaded at any
> >> >  # address by the bootloader.
> >> > -KBUILD_LDFLAGS += $(call ld-option, -pie) $(call ld-option, --no-dynamic-linker)
> >> > +KBUILD_LDFLAGS += -pie $(call ld-option, --no-dynamic-linker)
> >>
> >> Do we still need -pie linking with these changes applied?
> >>
> >
> >I think it's currently not strictly necessary -- eg the 64bit kernel
> >doesn't get linked as pie right now with LLD or old binutils. However,
> >it is safer to do so to ensure that the result remains PIC with future
> >versions of the linker. There are linker optimizations that can convert
> >certain PIC instructions when PIE is disabled. While I think they
> >currently all focus on eliminating indirection through the GOT (and thus
> >wouldn't be applicable any more),
> 
> There are 3 forms described by x86-64 psABI B.2 Optimize GOTPCRELX Relocations
> 
> (1) movq foo@GOTPCREL(%rip), %reg -> leaq foo(%rip), %reg
> (2) call *foo@GOTPCREL(%rip) -> nop; call foo
> (3) jmp *foo@GOTPCREL(%rip) -> jmp foo; nop
> 
> ld.bfd and gold perform (1) even for R_X86_64_GOTPCREL. LLD requires R_X86_64_[REX_]GOTPCRELX

The psABI says (1) can be relaxed into mov $foo, %reg if PIC is disabled
and foo lives below 4Gb. Similarly for the "test and binop" cases. Such
a relaxation would produce code that's not PIC any more, and wouldn't
boot.

> 
> >it's easy to imagine that they could
> >get extended to, for eg, convert
> >	leaq	foo(%rip), %rax
> >to
> >	movl	$foo, %eax
> >with some nop padding, etc.
> 
> Not with NOP padding, but probably with instruction prefixes. It is
> unclear the rewriting will be beneficial. Rewriting instructions definitely requires a
> dedicated relocation type like R_X86_64_[REX_]GOTPCRELX.

It ought to be faster: according to Agner Fog's tables, upto 4x higher
throughput than the RIP-relative LEA, and movq $foo, %rax is actually
the same size.

To take a step back, there isn't any *point* in not specifying -pie
after these changes: it would be lying to the toolchain just for the
sake of lying. It is inherently fragile, and would work only because the
toolchain isn't sophisticated enough to do some optimizations.

Eg, consider that if you ask for the address of an external function,
the compiler will generate
	movq f@GOTPCREL(%rip), %reg
if f has default visibility, and
	leaq f(%rip), %reg
if f has hidden visibility.

If you then link without -pie, the former gets relaxed into the non-PIC
	movq $f, %reg
by the BFD linker, but the latter isn't relaxed. This is a missed
optimization, which happens because there's the GOTPCRELX to tell the
linker that the first form can be relaxed, and there's no special
relaxable relocation type for the second form.

The 64-bit kernel actually contains one of these relocations, prior to
Ard's patches to add hiddden visibility for everything. It currently
works with LLD (which can't use -pie) only because LLD doesn't appear to
perform the relaxation of
	movq f@GOTPCREL(%rip), %reg
all the way to
	movq $f, %reg
Binutils-2.34, which does do that relaxation, produces an unbootable
kernel if you leave out the -pie.

> 
> >Also, the relocation check that's being added here would only work with
> >PIE linking.
