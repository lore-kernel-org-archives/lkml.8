Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54167C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 10:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3223B2075E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 10:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgHVKfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 06:35:37 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:55743 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbgHVKfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 06:35:34 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1M9ZRc-1kEuVk0PNU-005csu for <linux-kernel@vger.kernel.org>; Sat, 22 Aug
 2020 12:35:32 +0200
Received: by mail-qk1-f179.google.com with SMTP id g26so3562227qka.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 03:35:31 -0700 (PDT)
X-Gm-Message-State: AOAM53183iKXKigtP9KCOFjBu9H28szEg8Yf4vjGVIhKAj5WlTfC/0Uz
        QMWElAAIJXiMFrO4oTw1nIHKZWm6flurd/5r2UU=
X-Google-Smtp-Source: ABdhPJxfOSbyHes4JbOJ50pcCa6e32q/bcIpNVdrdDO3DrVesAm8MO8Z++Sd7VBuHvoFpyIigRLJwM63DrH1Fxk3puQ=
X-Received: by 2002:ae9:f449:: with SMTP id z9mr6592119qkl.352.1598092530943;
 Sat, 22 Aug 2020 03:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <875z9dioll.fsf@nanos.tec.linutronix.de> <20200820130641.GA536306@rani.riverdale.lan>
 <87zh6ohm03.fsf@nanos.tec.linutronix.de> <20200821230435.GA56974@rani.riverdale.lan>
 <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
 <87eenzqzmr.fsf@nanos.tec.linutronix.de> <20200822035552.GA104886@rani.riverdale.lan>
 <20200822084133.GL28786@gate.crashing.org> <CA+icZUVf9a8LC2Mf0cFymYQfALWs6bVfR1v1nRbxKaLAyU6NkQ@mail.gmail.com>
 <CA+icZUWGHo3mkN4=ZYeU37p8KJhxTXS5QKcAvq_HaqTHmFkw2g@mail.gmail.com> <20200822102637.GM28786@gate.crashing.org>
In-Reply-To: <20200822102637.GM28786@gate.crashing.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 22 Aug 2020 12:35:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a031YiKxYYX5uaVf=y_MJZo-eNwOsbxsVnH0QdoZznNFA@mail.gmail.com>
Message-ID: <CAK8P3a031YiKxYYX5uaVf=y_MJZo-eNwOsbxsVnH0QdoZznNFA@mail.gmail.com>
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Sedat Dilek <sedat.dilek@gmail.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
X-Provags-ID: V03:K1:LDzWpBX2wbh2eX4DaBnZT6R1VRWJw20Qo93SRU2M+0ATQk/zTWM
 N1SKBMTaNLqYW5mIULTLzEfFsStnap4wQxHnWdK1QSRPTdCJWBb+yIV5WmeG606jy5ErXL8
 4uPG4CLbLGyMTF4g9rHGmv/pxyvWGy5LnVY4csHVwgPV3QeMgYSWAxkp7O19NbD6+MIZThs
 Z9CN7yRSVgYGO2RZWJdhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ujKyGxYqi5s=:l+5mYrv9/JL5V68hpxcsLI
 +ySgK1avJshH8cEbrC58UUuG9CnVDOHp4c+EOnR16vGveeAvOWuGe8xnTpjQSN4+6F8uCO4WZ
 uQPLm2piJj6JDpC5SCeHJvWdK5iacFbpQQeUP4qYAf48wVUVKKKkHxRyH/ZPK5mSPkOIGuwxk
 rhSkoaLUp/fuXXZb6k6uOPPtiLKc1nr7NHqM/56D5qt2XK5GhWk9iVUzarER5ByeZlVYFS6w9
 buGT0kpmk7k5TmME6bFMO8WmkTQnS5oL0cZlVK1f6Y4zeiyxVct24//saVYx2p2RlHerSlnZW
 vJIXHZe1B5JULGgRMhR/VoD1uPtRvVlbFBpmMwKCTiCxPYVq+p19RQR4CQMs+9HGVmKtrMe0M
 B3zHB9CtvE6V2QbVT6JYAXkZz8otXE55GrPOXM+r+2K9IMlkZDmno2dXKuZiKS4SZjGJSQf2X
 gaoM1FLOAreNqoMbUCeFfbc/yw0vHZ+2qoNslBWhfJYee4HQZffzT/aG7mUhLpWvz+ZjkdYL0
 uL1LelRpD5oK37f3xN81od59xyazZx9F+CCuzB0m3Sn+xo9Ur+2cLuO3WOXvXknsb46EQ0UZI
 LRcdINmskWc4hGtnjk3j9bXehPaYcgr7Iu9g7yl15VtQ/22jDyp/p3WwyYYej6NSYwp5FpksJ
 bJ7UljfJ5SFcxZnCQxQrpORNhndvhLS9hXPOe72owNfgkxN/YSHngRG4giY5+FYnV7vzIckyg
 VjjLKZQRh1eV7TH4mXnNgWN53GbfIP/00FzL8HyFd8rnLbACgmBoRLQotVyU7raGbEfEyMNjz
 8M3eAKNDkAOQmizHeA/Adz0k5TE10+RxrT2sgH24Q0bu4KXitDfRGVcnO1gCJGL5Zcd9RkJDd
 nskFNUtn8sWtQdMxbyX+53PF8acVrG8pOvcQkTgivH7r0IQeSufgjMFwXEn1xMlxNTk1fsOqP
 32w7bs87Wh+VMtyWzLXuLTNxFQRL3epitejUdfsc0oXoqyDhbgF47
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 12:26 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
> [ There is GCC 4.9.4, no one should use an older 4.9. ]
>
> I mentioned 5 for a reason: the whole function this patch is to did not
> exist before then!  That does not mean the bug existed or did not exist
> before GCC 5, but it does for example mean that a backport to 4.9 or
> older isn't trivial at all.
>
> > I am asking myself who is using such ancient compilers?
>
> Some distros have a GCC 4.8 as system compiler.  We allow building GCC
> itself with a compiler that far back, for various reasons as well (and
> this is very sharp already, the last mainline GCC 4.8 release is from
> June 2015, not all that long ago at all).
>
> But, one reason this works is because people actually test it.  Does
> anyone actually test the kernel with old compilers?  It isn't hard to
> build a new compiler (because we make sure building a newer compiler
> works with older compilers, etc. :-) ), and as you say, most distros
> have newer compilers available nowadays.

We only recently changed the minimum from 4.6 to 4.8, and
subsequently to 4.9. Most people have fairly recent compilers,
but there are a number of notable kernel developers that
intentionally stick to old versions because of compile speed.

Each major compiler release adds about 4% overhead in total time
to compile a kernel, so between gcc-4.6 and gcc-11 you add over
50% in build time.

      Arnd
