Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8762C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:04:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1F17214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbgDTOEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:04:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:39096 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727919AbgDTOEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:04:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 16C32ABD7;
        Mon, 20 Apr 2020 14:04:07 +0000 (UTC)
Date:   Mon, 20 Apr 2020 14:04:06 +0000 (UTC)
From:   Michael Matz <matz@suse.de>
To:     Nick Desaulniers <ndesaulniers@google.com>
cc:     Jakub Jelinek <jakub@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH v2] x86: fix early boot crash on gcc-10
In-Reply-To: <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
Message-ID: <alpine.LSU.2.21.2004201401120.11688@wotan.suse.de>
References: <20200415074842.GA31016@zn.tnic> <alpine.LSU.2.21.2004151445520.11688@wotan.suse.de> <20200415231930.19755bc7@sf> <20200417075739.GA7322@zn.tnic> <20200417080726.GS2424@tucnak> <20200417084224.GB7322@zn.tnic> <20200417085859.GU2424@tucnak>
 <20200417090909.GC7322@zn.tnic> <CAKwvOdnFXPBJsAUD++HtYS5JiR2KmX73M5GAUe-tvX-JYV7DaA@mail.gmail.com> <CAKwvOdmNwNwa6rMC27-QZq8VDrYdTQeQqss-bAwF1EMmnAHxdw@mail.gmail.com> <20200417190607.GY2424@tucnak>
 <CAKwvOdkkbWgWmNthq5KijCdtatM9PEAaCknaq8US9w4qaDuwug@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 17 Apr 2020, Nick Desaulniers wrote:

> Ah seems we do have __attribute__((no_selector))
> (https://reviews.llvm.org/D46300,
> https://releases.llvm.org/7.0.0/tools/clang/docs/AttributeReference.html#no-stack-protector-clang-no-stack-protector-clang-no-stack-protector)
> which differs from GCC attribute name.

As you will discover upthread that was tried with GCC and found 
insufficient, as GCC is a bit surprising with optimize attributes: it 
resets every -f option from the command line and applies only the ones 
from the attributes.  Including a potential -fno-omit-frame-pointer, 
causing all kinds of itches :)

(The similar attribute in clang might work less surprising of course).


Ciao,
Michael.

> 
> I'm still catching up on the thread (and my cat is insistent about
> sleeping on my lap while I'm trying to use my laptop), but I like
> https://lore.kernel.org/lkml/20200417190607.GY2424@tucnak/T/#m23d197d3a66a6c7d04c5444af4f51d940895b412
> if it additionally defined __no_stack_protector for compiler-clang.h.
> 
> On Fri, Apr 17, 2020 at 12:06 PM Jakub Jelinek <jakub@redhat.com> wrote:
> >
> > On Fri, Apr 17, 2020 at 11:22:25AM -0700, Nick Desaulniers wrote:
> > > > Sorry, I don't quite follow.  The idea is that an empty asm statement
> > > > in foo() should prevent foo() from being inlined into bar()?
> > >
> > > s/inlined/tail called/
> >
> > Yeah.  The thing is, the caller changes the stack protector guard base
> > value, so at the start of the function it saves a different value then
> > it compares at the end.  But, the function that it calls at the end
> > actually doesn't return, so this isn't a problem.
> > If it is tail called though, the stack protector guard checking is done
> > before the tail call and it crashes.
> > If the called function is marked with noreturn attribute or _Noreturn,
> > at least GCC will also not tail call it and all is fine, but not sure
> > what LLVM does in that case.
> 
> Seems fine? https://godbolt.org/z/VEoEfw
> (try commenting out the __attribute__((noreturn)) to observe the tail calls.
> 
