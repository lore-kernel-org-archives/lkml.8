Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E790AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:14:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C13E3207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 13:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezgb8FZM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgGWNOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 09:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbgGWNOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 09:14:15 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E7FC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:14:15 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id a12so6130384ion.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 06:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=32lEAPZ/UL3cKAISqUdZsL9ffI08w61Ejr7d1duZqTc=;
        b=Ezgb8FZMVXOpoMijXt1qft0zJOhUWa1bXDnBvoMPOzuiuO0TLV4IDy4HlOifHZM29Y
         Xyj7XI7dGPpirUmwX74Da1425iGl7i5wwAErhRVwnbIS54EOpgeEaPGeSyiJWhkjSvPF
         FCXyh7rOAfBk7GNmaqwhUhbj/tS/rjaNTo2m/QYgvRNS2icFG09ZaSxcdoP6Wplw8MC6
         f2gK34zRbLATKH3SJMpTISHp7AYS4zZ/zz2x7S50grogE/xJTY3NaP/Dkkh/p6fCMGQS
         jPhTU/8LQ6BjdP4UMGveSjNJ/SRwMq+Xh17NY0aRSddG4GBGKy8vABttvzIZjKMbZlT9
         +4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=32lEAPZ/UL3cKAISqUdZsL9ffI08w61Ejr7d1duZqTc=;
        b=bg2KRSSkcuFdAOunBoyAGI8E6kr52ISl/m303RV2iyJoIrxvxuyrI528RrCq1Vqsir
         Y8snnZFr0IneET2PmqMUfTiC2TKkJiXZ4dpYTU1bRza8UD/Gxhh+hA3xDJHq3VQtR9UM
         kMK++zY/8B2pWdqSK6HHo7Kd/UUddzY2SOr4yufdZjimcEsY4uTCjpVIXOWEtQzhjCTL
         O5VptsqWfCLDZFR2YfjystGoJIWAf8HhCO3IDKML+E7NfotZDDFT5S10BukMoZ77c3mb
         SE5qg4r82Mceh9N+lZFJ/hsdm4BXjq+yBvPBLUUDv7N4+alsTeSmixQzAxJ2qPwQ3UR6
         +EFQ==
X-Gm-Message-State: AOAM532I5/HOQY2IZOOU5dzWPmbYDZvKPgnY3jmvoacDb3xn0eMwmQbs
        qRHqYKdqcjYqLys+LD4xWfoR/E7tw/9jJoZJuZI=
X-Google-Smtp-Source: ABdhPJwHjPH5NXM6/sxjQayIwc0b/PmyHUjBnsqMNqB5DQ3uzC3AEQgLp6omd6WZOKOcrg6aryn8mCdLwFlyKWhJ13o=
X-Received: by 2002:a05:6602:1555:: with SMTP id h21mr4813840iow.163.1595510054602;
 Thu, 23 Jul 2020 06:14:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200720204925.3654302-1-ndesaulniers@google.com>
 <20200720204925.3654302-12-ndesaulniers@google.com> <87365izj7i.fsf@nanos.tec.linutronix.de>
 <87zh7qy4i4.fsf@nanos.tec.linutronix.de> <CA+icZUVz0opOb0LihLvPvKM-t0Y=pcUWDyb+u-L_UVnnbPh1rQ@mail.gmail.com>
 <CAK8P3a3Ms1uvLcbhmbsU+-u11BCrXPaU5Dro=P9LjAG7CYm8ww@mail.gmail.com>
In-Reply-To: <CAK8P3a3Ms1uvLcbhmbsU+-u11BCrXPaU5Dro=P9LjAG7CYm8ww@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 23 Jul 2020 15:14:02 +0200
Message-ID: <CA+icZUXzjcQ7ekTg8LvwcaBZFn_HeDjif+rKaFAKy=0gUrx=Xg@mail.gmail.com>
Subject: Re: [PATCH v3 11/11] x86: support i386 with Clang
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Dmitry Golovin <dima@golovin.in>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 1:42 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Jul 23, 2020 at 1:07 PM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > On Thu, Jul 23, 2020 at 11:17 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > Thomas Gleixner <tglx@linutronix.de> writes:
> >
> > I have applied this patch-series v3 but some basics of "i386" usage
> > are not clear to me when I wanted to test it and give some feedback.
> >
> > [1] is the original place in CBL where this was reported and I have
> > commented on this.
> >
> > Beyond some old cruft in i386_defconfig like non-existent
> > "CONFIG_CRYPTO_AES_586" I have some fundamental questions:
> >
> > What means "ARCH=i386" and where it is used (for)?
> >
> > I can do:
> >
> > $ ARCH=x86 make V=1 -j3 $MAKE_OPTS i386_defconfig
> > $ make V=1 -j3 $MAKE_OPTS i386_defconfig
> >
> > ...which results in the same .config.
> >
> > Whereas when I do:
> >
> > $ ARCH=i386 make V=1 -j3 $MAKE_OPTS i386_defconfig
> >
> > ...drops CONFIG_64BIT line entirely.
> >
> > But "# CONFIG_64BIT is not set" is explicitly set in
> > arch/x86/configs/i386_defconfig but gets dropped.
> >
> > Unsure if above is the same like:
> > $ ARCH=i386 make V=1 -j3 $MAKE_OPTS defconfig
>
> The logic was introduced when arch/i386 and arch/x86_64 got
> merged into arch/x86, to stay compatible with the original behavior
> that would produce a 32-bit or 64-bit kernel depending on which
> machine you are running on.
>
> There are probably not a lot of people building kernels on 32-bit
> machines any more (real 32-bit machines are really slow compared
> to modern ones, and 64-bit machines running 32-bit distros usually
> want a 64-bit kernel), so it could in theory be changed.
>
> It will certainly break someone's workflow though, so nobody has
> proposed actually changing it so far.
>
> > When generating via "make ... i386_defconfig" modern gcc-9 and and a
> > snapshot version of clang-11 build both with:
> >
> > $ ARCH=x86 make V=1 -j3 $MAKE_OPTS
> > ... -march=i686 -mtune=generic ...
> >
> > Checking generated .config reveals:
> >
> > CONFIG_M686=y
> >
> > So, I guess modern compilers do at least support "i686" as lowest CPU?
>
> i686 compiler support goes back to the 1990s, and the kernel now
> requires at least gcc-4.9 from 2014, so yes.
>
> > Nick D. says:
> > > I usually test with make ... i386_defconfig.
> >
> > Can you enlighten a bit?
> >
> > Of course, I can send a patch to remove the "CONFIG_CRYPTO_AES_586=y"
> > line from i386_defconfig.
>
> The "i386" in i386_defconfig is just a synonym for x86-32, it does not
> imply a particular CPU generation. The original i386 is no longer supported,
> i486sx (barely) is and in practice most 32-bit Linux code gets compiled
> for some variant of i586 or i686 variant but run on 64-bit hardware.
>

Thanks a lot Arnd for all the detailed informations.

A change of i386_defconfig to x86_defconfig will cause a big cry from
all kernel-bot maintainers :-).

- Sedat -

P.S.: CONFIG_64BIT
What I dropped by accident in my previous mail:
What happens when there is no CONFIG_64BIT line?
There exist explicit checks for (and "inverse") of CONFIG_64BIT like
"ifdef" and "ifndef" or any "defined(...)" and its opposite?
I remember I have seen checks for it in x86 tree.

- EOT -
