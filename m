Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BABC2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95D4C20700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0acEGXd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgDXF4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725554AbgDXF4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 01:56:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA780C09B045
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 22:56:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id r26so9325164wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 22:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=RwEuL4PRU7ZiIXXogudBG/X0lEu1VFJ0M/eo+6J0PC4=;
        b=A0acEGXdemZZBZX4VGZXVfyllGprABCYm/+QvNCS9TMXbH1QS/PwyTFjU8LlHv7k20
         +UdhXH/UXb4SQyDB/GHv3k7mcdkkZisqezRBI+WtbCL53VdCGzHp2FdPQ0WGXYnshFRW
         0PLeBmvV4XZznHdK/5appfCFijdY7U+UxWCNgehXpJZ007d4Fpa2rWeX/XL1BlnstKkT
         hkBivZ3FVmolRG9sdf9TCBogm0DZJxx08XF3HLY6YYRqxCuycutvw/pINLM+oenLccDq
         v9hjmFwf37Sw4jfijv0Me023WmjL8V9NhS3T/JSLU8qsIO4VioDKUxMlwjronJBV58Ym
         Dwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=RwEuL4PRU7ZiIXXogudBG/X0lEu1VFJ0M/eo+6J0PC4=;
        b=PeaDxUjVUtC27L53FirmezHCu56GezxK/6w9h7KxdEpCJe/Ki1QwoGMz8TbqErt6X2
         xDuD6yOA1RtCAmFFqhbymwQnC3+gOaDa6eT6/aHJGa6RwxFjkjGrqCcYmMNFWmyPLenR
         X05xhY/xNGtb6j8dHR3rzxNZ37siO7CZDc4woagfFwzzY0n2gIxa/TLQUxz1Y3aJsobd
         bhTxBAXYIeqUBNzh7fBLxaWFeZv/ASZW5YT5IPzN2//e827tdv6JenMpedvA0Q/rXp1O
         hXrPThj6Gsjr+RB9MtpKHtNDiYAQ3vZuoW2Zp1YuUt8I5Fs/wXRgPrT90klbtu0OvsH5
         adTA==
X-Gm-Message-State: AGi0Pubta8BPvaoomg/db4MPRQ+K1LM2xWSU15GArqr3JL9vXN/3csDb
        NWchWqwkYdkWuu5lPj4Gus2L7eMnuh1+Z0yp2wRBEmW5hmQ=
X-Google-Smtp-Source: APiQypIrKLAkMsZVecmJEOp4wzNsurc947aIaadQ5oLy4jbf5MdN9I6ZaMih9JzO1KFccV1yqLJtSvQdwRkIYMrY3m4=
X-Received: by 2002:a7b:c927:: with SMTP id h7mr7970018wml.122.1587707794423;
 Thu, 23 Apr 2020 22:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200419131947.173685-1-sedat.dilek@gmail.com>
 <CAKwvOd=Rt0q0+nRJasc8GzOXSj1_-jZGNc2bAWJkmd7Vzr8FFw@mail.gmail.com>
 <CAK7LNAQzh8EajBkXSSgFh2=5iF38XvkADf1C7J0JnwTov=NmNQ@mail.gmail.com> <20200424051833.4om5dzimpnvegeab@google.com>
In-Reply-To: <20200424051833.4om5dzimpnvegeab@google.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 24 Apr 2020 07:56:27 +0200
Message-ID: <CA+icZUUf=3qMmPfqa2wgyVO8Ensnc-o8xaK9zcLxgoqui8eaZA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] kbuild: add CONFIG_LD_IS_BINUTILS
To:     Fangrui Song <maskray@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 7:18 AM Fangrui Song <maskray@google.com> wrote:
>
> On 2020-04-24, Masahiro Yamada wrote:
> >On Fri, Apr 24, 2020 at 3:44 AM Nick Desaulniers
> ><ndesaulniers@google.com> wrote:
> >>
> >> On Sun, Apr 19, 2020 at 6:19 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >> >
> >> > This patch is currently not mandatory but a prerequisites for the second one.
> >> >
> >> > Folks from ClangBuiltLinux project like the combination of Clang compiler
> >> > and LLD linker from LLVM project to build their Linux kernels.
> >> >
> >> > Sami Tolvanen <samitolvanen@google.com> has a patch for using LD_IS_LLD (see [1]).
> >> >
> >> > Documentation/process/changes.rst says and uses "binutils" that's why I called
> >> > it LD_IS_BINUTILS (see [2] and [3]).
> >> >
> >> > The second patch will rename existing LD_VERSION to BINUTILS_VERSION to have
> >> > a consistent naming convention like:
> >> >
> >> > 1. CC_IS_GCC and GCC_VERSION
> >> > 2. CC_IS_CLANG and CLANG_VERSION
> >> > 3. LD_IS_BINUTILS and BINUTILS_VERSION
> >> >
> >> > [1] https://github.com/samitolvanen/linux/commit/61889e01f0ed4f07a9d631f163bba6c6637bfa46
> >> > [2] https://git.kernel.org/linus/tree/Documentation/process/changes.rst#n34
> >> > [3] https://git.kernel.org/linus/tree/Documentation/process/changes.rst#n76
> >> >
> >> > Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>
> >>
> >> Just some background on Sami's patch.  Originally we were using
> >> ld.gold (for LTO for Pixel 3) before moving to ld.lld (for LTO for
> >> Pixel 4 and later).  Not sure if Kconfig would be a better place to
> >> check if gold is used, then warn?  I kind of prefer the distinction
> >> that binutils contains two different linkers, though if no one is
> >> supporting ld.gold, and it doesn't work for the kernel, then maybe
> >> that preference is moot?
> >
> >
> >I prefer LD_IS_BFD, like this patch:
> >https://lore.kernel.org/patchwork/patch/1039719/
> >
> >We do not need LD_IS_GOLD, though.
> >
> >--
> >Best Regards
> >Masahiro Yamada
>
> +1 for CONFIG_LD_IS_BFD
>
> Usually GNU ld is also installed as ld.bfd and can be referred to by -fuse-ld=bfd (GCC >= 9, or clang)
>
> The repository binutils-gdb includes two linkers: GNU ld and GNU gold, so CONFIG_LD_IS_BINUTILS would be ambiguous.

Hi,

The last days I was busy with job-hunting, so this is my prio #1.
Thus I was not very responsive.

And I am sorry to mixup different threads in ClangBuiltLinux and elsewhere.

WOW Huh ***Votings***!

Originally the patchset from Nick had LD_IS_BFD, LD_IS_GOLD and LD_IS_LLD.

As pointed out GOLD is no more suitable to link the kernel and thus
deactivated (AFAICS Thomas Gleixner did this).

Personally, I am OK with ***LD_IS_LD*** because we have now
***LD_VERSION*** which was introduced in Linux v5.7-rc1.
We have the pair LD_IS_LD and LD_VERSION like CC_IS_GCC and GCC_VERSION.
The only thing I would like to be changed is the comment in
***scripts/ld-version.sh*** to mention "GNU/ld (binutils)" if you
decide for LD_IS_LD or not.
But I am OK with LD_IS_BFD.
If you ask people what they come into mind when speaking of "ld" - 99%
of the answers of this people will point to GNU/ld from GNU/binutils.
This is simply a fact in the Linux-kernel world.

I am living in my x86 world and do not test with cross-compilation or
any other archs like ARM or MIPS or whatever.
So, I might not catch all corner-cases.

Some bots like kbuild-bot(?) already sent some warnings on my patchset.

My ***main interest*** is to have good support of ***LLD*** which is
my primary linker.

Why?
(Might be off-topic here in this thread)

"Numbers talk, bullshit walks." (Linus Torvalds)

Please, compile yourself (here: Debian/testing AMD64)...

#1: gcc 9.3 with GNU/ld (binutils)
#2: gcc 9.3 with ld.lld-10
#3: clang-10 and ld.lld-10

I have not the same code-base to compare, but first numbers:

Even the combo of gcc-9.3 and ld.lld-10 produces 5GiB more disc-space
in my linux-git.
The debug binaries and the resulting Debian debug packages are
significantly bigger

$ cd stats

$ cat 5.7.0-rc*/disc-usage.txt
23406   linux
1951    archives/5.7.0-rc1-2-amd64-gcc <--- XXX: gcc-9.3 + ld.lld-10
17958   linux
1365    5.7.0-rc2-1-amd64-clang <--- XXX: LLVM/Clang/LLD
10.0.1-git-92d5c1be9ee93850c0a8903f05f36a23ee835dc2

$ cd archives

$ du -m 5.7.0-rc*/linux-image-*-dbg*_amd64.deb
617     5.7.0-rc1-2-amd64-gcc/linux-image-5.7.0-rc1-2-amd64-gcc-dbg_5.7.0~rc1-2~bullseye+dileks1_amd64.deb
424     5.7.0-rc2-1-amd64-clang/linux-image-5.7.0-rc2-1-amd64-clang-dbg_5.7.0~rc2-1~bullseye+dileks1_amd64.deb

$ du -m 5.7.0-rc*/vmlinux*
603     5.7.0-rc1-2-amd64-gcc/vmlinux
7       5.7.0-rc1-2-amd64-gcc/vmlinux.compressed
597     5.7.0-rc1-2-amd64-gcc/vmlinux.o
409     5.7.0-rc2-1-amd64-clang/vmlinux
7       5.7.0-rc2-1-amd64-clang/vmlinux.compressed
404     5.7.0-rc2-1-amd64-clang/vmlinux.o

As said - not the same code and patch base!

This needs definitely to be investigated.

LLD seems to be - seen from the numbers - be a lot of "smarter".

Have more fun!

Regards and happy first day of Ramadan if you celebrate it,
- Sedat -

P.S.: A build of Linux v5.7-rcX with gcc-9.3 as compiler is much much
faster here.
