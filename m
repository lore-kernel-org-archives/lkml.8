Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4C3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC2EC206CD
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 21:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgGCVDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 17:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbgGCVDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:03:03 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57B5C061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 14:03:02 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrSpS-004pJE-0P; Fri, 03 Jul 2020 21:02:38 +0000
Date:   Fri, 3 Jul 2020 22:02:37 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
Message-ID: <20200703210237.GS2786714@ZenIV.linux.org.uk>
References: <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
 <20200701195914.GK2786714@ZenIV.linux.org.uk>
 <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au>
 <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk>
 <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
 <20200702205902.GP2786714@ZenIV.linux.org.uk>
 <CAHk-=whm66UhcEQgXHr8hPkzyDTOdbGikLbSg0zJ4-b93aSg8w@mail.gmail.com>
 <20200703013328.GQ2786714@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703013328.GQ2786714@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 02:33:28AM +0100, Al Viro wrote:
> On Thu, Jul 02, 2020 at 02:55:19PM -0700, Linus Torvalds wrote:
> 
> > And while XSTATE_OP() is still disgusting, it's
> > 
> >  (a) slightly less disgusting than it used to be
> > 
> >  (b) now easily fixable if we do the "exceptions clear AC" thing.
> > 
> > so it's an improvement all around.
> > 
> > If it works, that is. As mentioned: IT HAS NO TESTING.
> 
> What about load_unaligned_zeropad()?  Normally the caller doesn't
> want to know about the exception on crossing into an unmapped
> page.  Blanket "clear #AC of fixup, don't go through user_access_end()
> in case of exception" would complicate the code that calls that sucker.

Actually, for more serious problem consider arch/x86/lib/copy_user_64.S

In case of an unhandled fault on attempt to read an (unaligned) word,
the damn thing falls back to this:
SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
        movl %edx,%ecx
1:      rep movsb
2:      mov %ecx,%eax
        ASM_CLAC 
        ret

        _ASM_EXTABLE_UA(1b, 2b)
SYM_CODE_END(.Lcopy_user_handle_tail)

We could do what alpha, sparc et.al. are doing - have both reads and
writes aligned, with every output word being a mix of two input ones.
But I would expect that to be considerably slower than the current
variants.  Sure, we can set AC in .Lcopy_user_handle_tail, but that
doesn't look right.

And while squeezing every byte on a short copy is not a hard requirement,
in situation when the source is one byte before the end of page and
destination is aligned, raw_copy_from_user() really must copy at least
one byte if it's readable.

So I suspect that we need a variant of extable entry that does not
clear AC, at least for these fallbacks.

PS: I'm still going through the _ASM_EXTABLE... users on x86, so there
might be more fun.  Will post when I'm done...
