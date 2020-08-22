Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55568C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 304AA207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 09:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tpmBeUH9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbgHVJwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 05:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgHVJwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 05:52:12 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7ACC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 02:52:12 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id b9so296005oiy.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 02:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=ZljvoDAY1lVA2RNn8qAajI471ARnBIi+QOuwiJFiRIc=;
        b=tpmBeUH9h+1InEs5vb79W43gBkcvMjhaSS4yW7OyXm2LsW70u4wf1tJlRv1r0rDLin
         SytdVERvBmbPfxUQRqF6HrSpKd0iF3k4HNuQupflwkkuf2RmhgG1w4twoKiCtpKlSF82
         bxEmhL+zLmbuaidxD8jCxeG+ML5JMhax1gUNogLqLgICy2zhRLUyGj9mRgZT39OWX1SY
         xbnpw9naqOmqaUDVv4JSmDUuGgQZa9YPGevpPJJed/3l2Ua8L2KJWB3mNwZ7J7gJmwqP
         wOPB72poxnZ5uye8dLxTK3PvfvEx85rxxw4nE9BRwQNBMsX9cVyPvai2vbXBRwLL+JKv
         QZyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=ZljvoDAY1lVA2RNn8qAajI471ARnBIi+QOuwiJFiRIc=;
        b=s+NVTm7xLk2LAOiJ15k1o0KYwEoXRvGTJigItxfAEX8iXiT8rL0FA4Yzi0ULE4iKEx
         Zl4Pczy1Wwhi9afvtNx4F3Rt0lWxKn7bf3qwHu6IMyW8xG55L6OawkIK2NZ7CrZYVpf7
         NjVawqYU6oa+bucwvICrXkFAyto1OMIz27mi8JvcaPZlcKvO1rvWV8CDMbWr9/UQfSWT
         chjwFzl+SUdvDfMcT3URenjUFuF+vIjjIBtr3YaixrV8CIoW3b6Er4+HzQAOapIXXhGW
         Bcqc+NXTp2NLl+Y2X7Sn9dalogzFvP78xFDCeQsucHXfQ7d7oRsAsmTLppgLSQy66l/C
         CglA==
X-Gm-Message-State: AOAM531NTTLkjRbMftwCk/HmKs/TmocRqDWYOiZTqoh1GzMCn2BsWrSd
        pe3BposdYsEx3g3cu5YOmOqh4OcWiEWcM69JnAs=
X-Google-Smtp-Source: ABdhPJwaA0j4FMTxe4p0AINCftLYKDJoZfQT4qkp0zOAKCx2F4pFWbPttIRRYja9MRs//AfT8qC0mB2cPiufLNY6OmI=
X-Received: by 2002:aca:4e92:: with SMTP id c140mr4007319oib.70.1598089928170;
 Sat, 22 Aug 2020 02:52:08 -0700 (PDT)
MIME-Version: 1.0
References: <87h7t6tpye.fsf@nanos.tec.linutronix.de> <20200813173701.GC4295@paulmck-ThinkPad-P72>
 <20200813180933.GA532283@rani.riverdale.lan> <875z9dioll.fsf@nanos.tec.linutronix.de>
 <20200820130641.GA536306@rani.riverdale.lan> <87zh6ohm03.fsf@nanos.tec.linutronix.de>
 <20200821230435.GA56974@rani.riverdale.lan> <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
 <87eenzqzmr.fsf@nanos.tec.linutronix.de> <20200822035552.GA104886@rani.riverdale.lan>
 <20200822084133.GL28786@gate.crashing.org> <CA+icZUVf9a8LC2Mf0cFymYQfALWs6bVfR1v1nRbxKaLAyU6NkQ@mail.gmail.com>
In-Reply-To: <CA+icZUVf9a8LC2Mf0cFymYQfALWs6bVfR1v1nRbxKaLAyU6NkQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 22 Aug 2020 11:51:56 +0200
Message-ID: <CA+icZUWGHo3mkN4=ZYeU37p8KJhxTXS5QKcAvq_HaqTHmFkw2g@mail.gmail.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 11:23 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, Aug 22, 2020 at 10:42 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > Hi Arvind,
> >
> > On Fri, Aug 21, 2020 at 11:55:52PM -0400, Arvind Sankar wrote:
> > > Cc Segher.
> > >
> > > Segher, we were looking at gcc PR82602, where IRA could reorder volatile
> > > asm's (reported on ARM). The fix was backported to gcc-6.
> >
> > I know ;-)
> >
> > > Do you know if
> > > there is any reason the problem couldn't occur on x86 on older gcc
> > > without the fix?
> >
> > No, I see no particular reason, at least GCC 5 seems vulnerable.  (The
> > GCC 5 release branch was closed at the time this bug report was made,
> > already).  There is no reason I see why it would work on x86 but fail
> > elsewhere, either.
> >
>
> [1] says:
>
> Current Minimal Requirements
> ...
> ====================== ===============  ========================================
>         Program        Minimal version       Command to check the version
> ====================== ===============  ========================================
> GNU C                  4.9              gcc --version
>
> - Sedat -
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/changes.rst#n32

[ CC Miguel Ojeda (Compiler Attributes maintainer) ]

There exist gcc-4.8 and gcc-4.9 for Debian/jessie where EOL was June
30, 2020 (see [1] and [2]).

In the latest available version "4.9.2-10+deb8u1" I see no PR82602 was
backported (see [3] and [4]).

I am asking myself who is using such ancient compilers?
Recently, I threw away GCC-8 from my Debian system.

If this is a real problem with GCC version <= 5, so can this be moved
to a GCC specific include header-file?
Thinking of include/linux/compiler-gcc.h or
include/linux/compiler_types.h with a GCC-VERSION check?

Thoughts?

- Sedat -

P.S.: Yesterday, I built with dropping __force_order entirely and LLVM
toolchain v11.0.0-rc2 on Debian/unstable AMD64 on top of recent Linux
v5.9-rc1+.

[1] https://packages.debian.org/search?keywords=gcc-4
[2] https://wiki.debian.org/LTS
[3] https://sources.debian.org/src/gcc-4.9/
[4] https://sources.debian.org/src/gcc-4.9/4.9.2-10+deb8u1/debian/patches/
