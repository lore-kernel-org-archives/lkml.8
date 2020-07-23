Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15673C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:07:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3DF5206D7
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 11:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORZkjnuY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgGWLHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 07:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgGWLHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 07:07:09 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE30DC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 04:07:09 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id s21so3963637ilk.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 04:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Sqy+aq4JnS7ssbugNgHH00morzlsP1wwcaAtIFalZkc=;
        b=ORZkjnuY8Z0xtkfXxe9CnO3Np+UDUPd40kn4wtoCEQ0VQsmGQjeSDTtWEQllViTezU
         Mo7PE7ej64BLKrTrtb8PYL0HD1JS7WjymRgT9mVKAePBkgmhav+zjMQ31LRqj9WpFDt6
         McxBnB9B87QM916dtunIVQXbnPRVmqrpxkmvYXKZ8HMBPBB2aItsqyElF8cRwYuKv3QZ
         iY6RlbpPQnseCTSemaOw/eZ89CbE+BDfRMtYCHYIFkluYhGrLU6xIXT8n3zl9ChXQ/uG
         7KjEJLzqCZFN6BS1dXERWw6lWefl0CsItJikuE8wbJRefR13rmmhHVRuhzTRFMTNCZwu
         iKZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Sqy+aq4JnS7ssbugNgHH00morzlsP1wwcaAtIFalZkc=;
        b=LzLh/d4vObB41DI5YrtgPVjBzzBvVfRp4vkjen7LxieeZTSrcZPSNvSOIioWC7VE4s
         3Z0zDFplP7tk5ucfoGPhv80sGDJr+/wljSqMrknu+J235Rq9ejJH097MFah+a1MpmDXh
         G3DBRFv45mj83ZM2d+YAlJ4/KFb0InToL5dLma3ClrEtax8RQQBXUi/uQxdd6gQ4g3VT
         YnZUVkCMo36h45MTDavjURP5y77zSsG4EdQbrZt3Fx/arfIS3MUfpl6gJq0FB/JP4pdv
         PYzxJd61ftjKF9/z2ykgHhAyn61t1njOXSMaSQpc4gLDMK1eaVm4I4EHxv2fOzgsTOms
         qccQ==
X-Gm-Message-State: AOAM531AXmYnyvtkrhKzY0LFH43xdYIjjM3YEAyJqfXTtZBsCYwGZAYb
        I0/MhktdV4C40gT+bmnjTZ+uY0ZkqXvm07C38v8=
X-Google-Smtp-Source: ABdhPJyTsmSpO5EVIvDQoXwdvAT5ZIclUtHlyK8pssdjZi8dEw1mWeHZduduROgWYye97mYjbAimhOAzcIB7c8i9Yi0=
X-Received: by 2002:a92:290a:: with SMTP id l10mr4696067ilg.204.1595502428893;
 Thu, 23 Jul 2020 04:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
 <20200720204925.3654302-12-ndesaulniers@google.com> <87365izj7i.fsf@nanos.tec.linutronix.de>
 <87zh7qy4i4.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87zh7qy4i4.fsf@nanos.tec.linutronix.de>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 23 Jul 2020 13:06:57 +0200
Message-ID: <CA+icZUVz0opOb0LihLvPvKM-t0Y=pcUWDyb+u-L_UVnnbPh1rQ@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] x86: support i386 with Clang
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        Dmitry Golovin <dima@golovin.in>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 11:17 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Thomas Gleixner <tglx@linutronix.de> writes:
> > Nick Desaulniers <ndesaulniers@google.com> writes:
> >
> > I'm glad I looked myself at this.
> >
> >> We also don't want to swap the use of "=q" with "=r". For 64b, it
> >> doesn't matter. For 32b, it's possible that a 32b register without a 8b
> >> lower alias (i.e. ESI, EDI, EBP) is selected which the assembler will
> >> then reject.
> >
> > The above is really garbage.
> >
> > We don't want? It's simply not possible to do so, because ...
> >
> > 64b,32b,8b. For heavens sake is it too much asked to write a changelog
> > with understandable wording instead of ambiguous abbreviations?
> >
> > There is no maximum character limit for changelogs.
>
> Gah. Hit send too fast.
>
> >> With this, Clang can finally build an i386 defconfig.
>
> With what? I can't find anything which explains the solution at the
> conceptual level. Sigh.
>

Hi,

I have applied this patch-series v3 but some basics of "i386" usage
are not clear to me when I wanted to test it and give some feedback.

[1] is the original place in CBL where this was reported and I have
commented on this.

Beyond some old cruft in i386_defconfig like non-existent
"CONFIG_CRYPTO_AES_586" I have some fundamental questions:

What means "ARCH=i386" and where it is used (for)?

I can do:

$ ARCH=x86 make V=1 -j3 $MAKE_OPTS i386_defconfig
$ make V=1 -j3 $MAKE_OPTS i386_defconfig

...which results in the same .config.

Whereas when I do:

$ ARCH=i386 make V=1 -j3 $MAKE_OPTS i386_defconfig

...drops CONFIG_64BIT line entirely.

But "# CONFIG_64BIT is not set" is explicitly set in
arch/x86/configs/i386_defconfig but gets dropped.

Unsure if above is the same like:
$ ARCH=i386 make V=1 -j3 $MAKE_OPTS defconfig

When generating via "make ... i386_defconfig" modern gcc-9 and and a
snapshot version of clang-11 build both with:

$ ARCH=x86 make V=1 -j3 $MAKE_OPTS
... -march=i686 -mtune=generic ...

Checking generated .config reveals:

CONFIG_M686=y

So, I guess modern compilers do at least support "i686" as lowest CPU?

Doing some grep+ping:

$ git grep "ARCH=i386"
Documentation/kbuild/headers_install.rst:  make headers_install
ARCH=i386 INSTALL_HDR_PATH=/usr
tools/testing/ktest/examples/crosstests.conf:MAKE_CMD = make ARCH=i386
tools/testing/ktest/sample.conf:#MAKE_CMD = CC=i386-gcc AS=i386-as
make ARCH=i386

i386-gcc / i386-as - someone uses that?

Again my question (I did not do a diff):

$ make headers_install ARCH=i386 INSTALL_HDR_PATH=/usr
$ make headers_install ARCH=x86 INSTALL_HDR_PATH=/usr

...should generate the same?

To come back to "i386" again:

$ git grep i386 | grep ARCH

...reveals in top-level Makefile [2]:

376: # Additional ARCH settings for x86
377: ifeq ($(ARCH),i386)
378:        SRCARCH := x86

For me this means:

ARCH=i386 make ...
ARCH=x86 make ...

...should result in the same .config, but for what reason CONFIG_64BIT
is dropped when "ARCH=i386" is used.

Coming to a conclusion:

Nick D. says:
> I usually test with make ... i386_defconfig.

Can you enlighten a bit?

Of course, I can send a patch to remove the "CONFIG_CRYPTO_AES_586=y"
line from i386_defconfig.

Thanks.

Regards,
- Sedat -

[1] https://github.com/ClangBuiltLinux/linux/issues/194
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Makefile#n376
