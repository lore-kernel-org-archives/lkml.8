Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FAEC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A82F20739
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgGCWEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 18:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgGCWEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 18:04:21 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01337C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 15:04:20 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTmx-004qwZ-UT; Fri, 03 Jul 2020 22:04:08 +0000
Date:   Fri, 3 Jul 2020 23:04:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
Message-ID: <20200703220407.GU2786714@ZenIV.linux.org.uk>
References: <87lfk26nx4.fsf@mpe.ellerman.id.au>
 <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk>
 <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
 <20200702205902.GP2786714@ZenIV.linux.org.uk>
 <CAHk-=whm66UhcEQgXHr8hPkzyDTOdbGikLbSg0zJ4-b93aSg8w@mail.gmail.com>
 <20200703013328.GQ2786714@ZenIV.linux.org.uk>
 <20200703210237.GS2786714@ZenIV.linux.org.uk>
 <CAHk-=wjmmTwdY22kc0+HAZ2AWFreqLE8_Jud9j7MbVzT2rs-fQ@mail.gmail.com>
 <20200703215922.GT2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703215922.GT2786714@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 10:59:22PM +0100, Al Viro wrote:
> On Fri, Jul 03, 2020 at 02:10:08PM -0700, Linus Torvalds wrote:
> > On Fri, Jul 3, 2020 at 2:02 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > > Actually, for more serious problem consider arch/x86/lib/copy_user_64.S
> > 
> > What? No.
> > 
> > > In case of an unhandled fault on attempt to read an (unaligned) word,
> > > the damn thing falls back to this:
> > > SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
> > >         movl %edx,%ecx
> > > 1:      rep movsb
> > > 2:      mov %ecx,%eax
> > >         ASM_CLAC
> > >         ret
> > >
> > >         _ASM_EXTABLE_UA(1b, 2b)
> > > SYM_CODE_END(.Lcopy_user_handle_tail)
> > 
> > In the case of "we did an unaligned word at the end of a page, we took
> > a fault, and now we have to start all over", the _least_ of our
> > problems is that part of "starting over" would now imply doing a
> > "stac" again.
> 
> What do you mean, start over?  It's picking a few remaining bytes out
> of that word, *not* redoing the entire thing.

I'm _not_ saying that it's a performance-critical place, in case that's not
obvious - just trying to head off potential confusion re what that code is
doing.
