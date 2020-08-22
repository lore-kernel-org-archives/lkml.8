Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D38C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 10:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79BAA204EC
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 10:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgHVK1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 06:27:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:55074 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726728AbgHVK1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 06:27:16 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 07MAQeoZ015812;
        Sat, 22 Aug 2020 05:26:40 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 07MAQb3f015811;
        Sat, 22 Aug 2020 05:26:37 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sat, 22 Aug 2020 05:26:37 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Sedat Dilek <sedat.dilek@gmail.com>
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
Subject: Re: [PATCH] x86: work around clang IAS bug referencing __force_order
Message-ID: <20200822102637.GM28786@gate.crashing.org>
References: <875z9dioll.fsf@nanos.tec.linutronix.de> <20200820130641.GA536306@rani.riverdale.lan> <87zh6ohm03.fsf@nanos.tec.linutronix.de> <20200821230435.GA56974@rani.riverdale.lan> <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com> <87eenzqzmr.fsf@nanos.tec.linutronix.de> <20200822035552.GA104886@rani.riverdale.lan> <20200822084133.GL28786@gate.crashing.org> <CA+icZUVf9a8LC2Mf0cFymYQfALWs6bVfR1v1nRbxKaLAyU6NkQ@mail.gmail.com> <CA+icZUWGHo3mkN4=ZYeU37p8KJhxTXS5QKcAvq_HaqTHmFkw2g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+icZUWGHo3mkN4=ZYeU37p8KJhxTXS5QKcAvq_HaqTHmFkw2g@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 11:51:56AM +0200, Sedat Dilek wrote:
> On Sat, Aug 22, 2020 at 11:23 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Sat, Aug 22, 2020 at 10:42 AM Segher Boessenkool
> > <segher@kernel.crashing.org> wrote:
> > >
> > > Hi Arvind,
> > >
> > > On Fri, Aug 21, 2020 at 11:55:52PM -0400, Arvind Sankar wrote:
> > > > Cc Segher.
> > > >
> > > > Segher, we were looking at gcc PR82602, where IRA could reorder volatile
> > > > asm's (reported on ARM). The fix was backported to gcc-6.
> > >
> > > I know ;-)
> > >
> > > > Do you know if
> > > > there is any reason the problem couldn't occur on x86 on older gcc
> > > > without the fix?
> > >
> > > No, I see no particular reason, at least GCC 5 seems vulnerable.  (The
> > > GCC 5 release branch was closed at the time this bug report was made,
> > > already).  There is no reason I see why it would work on x86 but fail
> > > elsewhere, either.

> There exist gcc-4.8 and gcc-4.9 for Debian/jessie where EOL was June
> 30, 2020 (see [1] and [2]).
> 
> In the latest available version "4.9.2-10+deb8u1" I see no PR82602 was
> backported (see [3] and [4]).

[ There is GCC 4.9.4, no one should use an older 4.9. ]

I mentioned 5 for a reason: the whole function this patch is to did not
exist before then!  That does not mean the bug existed or did not exist
before GCC 5, but it does for example mean that a backport to 4.9 or
older isn't trivial at all.

> I am asking myself who is using such ancient compilers?

Some distros have a GCC 4.8 as system compiler.  We allow building GCC
itself with a compiler that far back, for various reasons as well (and
this is very sharp already, the last mainline GCC 4.8 release is from
June 2015, not all that long ago at all).

But, one reason this works is because people actually test it.  Does
anyone actually test the kernel with old compilers?  It isn't hard to
build a new compiler (because we make sure building a newer compiler
works with older compilers, etc. :-) ), and as you say, most distros
have newer compilers available nowadays.


Segher
