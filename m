Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7082C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 22:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2032067C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 22:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729738AbgIHWZa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 18:25:30 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:59576 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728620AbgIHWZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 18:25:29 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id D96C01C0B87; Wed,  9 Sep 2020 00:25:25 +0200 (CEST)
Date:   Wed, 9 Sep 2020 00:25:24 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
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
Message-ID: <20200908222524.GE1005@bug>
References: <875z9dioll.fsf@nanos.tec.linutronix.de>
 <20200820130641.GA536306@rani.riverdale.lan>
 <87zh6ohm03.fsf@nanos.tec.linutronix.de>
 <20200821230435.GA56974@rani.riverdale.lan>
 <CAKwvOdkoB+fT9tt7vgg1R6J-NEr77EWP5X8nFat_L-HvEzWGzA@mail.gmail.com>
 <87eenzqzmr.fsf@nanos.tec.linutronix.de>
 <20200822035552.GA104886@rani.riverdale.lan>
 <20200822084133.GL28786@gate.crashing.org>
 <CA+icZUVf9a8LC2Mf0cFymYQfALWs6bVfR1v1nRbxKaLAyU6NkQ@mail.gmail.com>
 <CA+icZUWGHo3mkN4=ZYeU37p8KJhxTXS5QKcAvq_HaqTHmFkw2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CA+icZUWGHo3mkN4=ZYeU37p8KJhxTXS5QKcAvq_HaqTHmFkw2g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 2020-08-22 11:51:56, Sedat Dilek wrote:
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
> > >
> >
> > [1] says:
> >
> > Current Minimal Requirements
> > ...
> > ====================== ===============  ========================================
> >         Program        Minimal version       Command to check the version
> > ====================== ===============  ========================================
> > GNU C                  4.9              gcc --version
> >
> > - Sedat -
> >
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/changes.rst#n32
> 
> [ CC Miguel Ojeda (Compiler Attributes maintainer) ]
> 
> There exist gcc-4.8 and gcc-4.9 for Debian/jessie where EOL was June
> 30, 2020 (see [1] and [2]).
> 
> In the latest available version "4.9.2-10+deb8u1" I see no PR82602 was
> backported (see [3] and [4]).
> 
> I am asking myself who is using such ancient compilers?
> Recently, I threw away GCC-8 from my Debian system.

I do have 4.9.2 on some systems. They work well, and are likely to compile
significantly faster than newer ones.

Please don't break them.

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
