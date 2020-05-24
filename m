Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02113C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CB62076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi3rD4hd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbgEXXoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 19:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388104AbgEXXoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 19:44:06 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D687C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:44:06 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id p12so12708317qtn.13
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 16:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XTG0SWExg+vLcec58IdP3Bd5LBSmZq0uHWu9qm8rqMU=;
        b=Qi3rD4hd0OBupNHoTZO4aWnbg7YpMwp4NB1zX734grMLeHX2uU0x++AEYDffGrCrGu
         Iae7QGizqHLdEAPCV10UzmJq7R9NJn1plUcYopOWEdHRHeE908lj2hIXT+BUfSmTV3Sy
         4nGByrvZwbX7vlnPZ4soqnlkS7vmlhKaIhJVhYnqcEwOeczo+tHJN5/tt4cZVmvZ1Wom
         9gQg+8IZKN7JILU3dOPw3To99YczpDkp8SthdXNeXxLOe234rWK/507WcjaP6q1jm9tZ
         1qZgBlAmZbvdB2QvzOlR1WTCr+Z1nAdEkCjfp2CMRxFMcNg9n1MKp12fx6/aQEexwwhi
         T4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XTG0SWExg+vLcec58IdP3Bd5LBSmZq0uHWu9qm8rqMU=;
        b=F5iBde/cfIADFGGOWk2CZ0d4VJmNPMlMs/BqmTzWQJ2oWDDyyUofYrT9BhAY6dy5Up
         hkvKGk/1VJAXzeDDOaCZYpw8gZ2L8Y0nfiXkB9ldN0Xr6c1vMTjpSuh6nQdbTYEeYPQo
         Rkk2NV2mRrxadGuC//OIbHws3XwFxfOf0HkCM4ScuiQOI//pl2iIJ0Oy2MPw0zf0KBCU
         2g0R121Aoqv81MkdnIdKLr+oJBdKRtN1Tx5BHALkwyjf0F/vtxPm+ddWvxPKaUEqXfEp
         28qywzNnLdIunVOui29zM5UOC8bse8FTvpb4tO7AsGpZBu/Y5QAbJoW/uvwOPJyh6860
         TicQ==
X-Gm-Message-State: AOAM530A5RGDvWIjHTJBtn/rKvc3lJS7KN+X5/tqtPAcQV20CKdt0OZy
        QoyyUVB4NZcxv8pZo45wppM=
X-Google-Smtp-Source: ABdhPJxDZUs+AI+yRk2QVHuRCQahb7HasrZZtJQe3moXlNXCnMFvmIDOY4ky/1zjNgYsuevld1fidg==
X-Received: by 2002:ac8:2242:: with SMTP id p2mr16244141qtp.27.1590363845164;
        Sun, 24 May 2020 16:44:05 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q34sm3977676qtd.89.2020.05.24.16.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 16:44:04 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 24 May 2020 19:44:02 -0400
To:     Fangrui Song <maskray@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/boot: Remove runtime relocations from .head.text
 code
Message-ID: <20200524234402.GB280334@rani.riverdale.lan>
References: <CAKwvOd=qB+EoJwfAYUA9Hg7f9op4Q4W+TDnht8pLRG5bPX=29Q@mail.gmail.com>
 <20200524212816.243139-3-nivedita@alum.mit.edu>
 <20200524225359.wnc43jmh6rvfaezq@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200524225359.wnc43jmh6rvfaezq@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 03:53:59PM -0700, Fangrui Song wrote:
> On 2020-05-24, Arvind Sankar wrote:
> >The assembly code in head_{32,64}.S, while meant to be
> >position-independent, generates run-time relocations because it uses
> >instructions such as
> >	leal	gdt(%edx), %eax
> >which make the assembler and linker think that the code is using %edx as
> >an index into gdt, and hence gdt needs to be relocated to its run-time
> >address.
> >
> >With the BFD linker, this generates a warning during the build:
> >  LD      arch/x86/boot/compressed/vmlinux
> >ld: arch/x86/boot/compressed/head_32.o: warning: relocation in read-only section `.head.text'
> >ld: warning: creating a DT_TEXTREL in object
> 
> Interesting. How does the build generate a warning by default?
> Do you use Gentoo Linux which appears to ship a --warn-shared-textrel
> enabled-by-default patch? (https://bugs.gentoo.org/700488)

Ah, yes I am using gentoo. I didn't realize that was a distro
modification.

> >+
> >+/*
> >+ * This macro gives the link address of X. It's the same as X, since startup_32
> >+ * has link address 0, but defining it this way tells the assembler/linker that
> >+ * we want the link address, and not the run-time address of X. This prevents
> >+ * the linker from creating a run-time relocation entry for this reference.
> >+ * The macro should be used as a displacement with a base register containing
> >+ * the run-time address of startup_32 [i.e. la(X)(%reg)], or as an
> >+ * immediate [$ la(X)].
> >+ *
> >+ * This macro can only be used from within the .head.text section, since the
> >+ * expression requires startup_32 to be in the same section as the code being
> >+ * assembled.
> >+ */
> >+#define la(X) ((X) - startup_32)
> >+
> 
> IIRC, %ebp contains the address of startup_32. la(X) references X
> relative to startup_32. The fixup (in GNU as and clang integrated
> assembler's term) is a constant which is resolved by the assembler.
> 
> There is no R_386_32 or R_386_PC32 for the linker to resolve.

This is incorrect (or maybe I'm not understanding you correctly). X is a
symbol whose final location relative to startup_32 is in most cases not
known to the assembler (there are a couple of cases where X is a label
within .head.text which do get completely resolved by the assembler).

For example, taking the instruction loading the gdt address, this is
what we get from the assembler:
	lea	la(gdt)(%ebp), %eax
becomes in the object file:
  11:   8d 85 00 00 00 00       lea    0x0(%ebp),%eax
			13: R_X86_64_PC32       .data+0x23
or a cleaner example using a global symbol:
	subl	la(image_offset)(%ebp), %ebx
becomes
  41:   2b 9d 00 00 00 00       sub    0x0(%ebp),%ebx
			43: R_X86_64_PC32       image_offset+0x43

So in general you get PC32 relocations, with the addend being set by the
assembler to .-startup_32, modulo the adjustment for where within the
instruction the displacement needs to be. These relocations are resolved
by the static linker to produce constants in the final executable.


> 
> Not very sure stating that "since startup_32 has link address 0" is very
> appropriate here (probably because I did't see the term "link address"
> before). If my understanding above is correct, I think you can just
> reword the comment to express that X is referenced relative to
> startup_32, which is stored in %ebp.
> 

Yeah, the more standard term is virtual address/VMA, but that sounds
confusing to me with PIE code since the _actual_ virtual address at
which this code is going to run isn't 0, that's just the address assumed
for linking. I can reword it to avoid referencing "link address" but
then it's not obvious why the macro is named "la" :) I'm open to
suggestions on a better name, I could use offset but that's a bit
long-winded. I could just use vma() if nobody else finds it confusing.

Thanks.
