Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2F4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5822E20723
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 22:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgGCWZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 18:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgGCWZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 18:25:25 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6471DC061794
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 15:25:25 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrU7Q-004rRg-6j; Fri, 03 Jul 2020 22:25:16 +0000
Date:   Fri, 3 Jul 2020 23:25:16 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
Message-ID: <20200703222516.GW2786714@ZenIV.linux.org.uk>
References: <87lfk26nx4.fsf@mpe.ellerman.id.au>
 <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk>
 <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
 <20200702205902.GP2786714@ZenIV.linux.org.uk>
 <CAHk-=whm66UhcEQgXHr8hPkzyDTOdbGikLbSg0zJ4-b93aSg8w@mail.gmail.com>
 <20200703013328.GQ2786714@ZenIV.linux.org.uk>
 <20200703210237.GS2786714@ZenIV.linux.org.uk>
 <CAHk-=wjmmTwdY22kc0+HAZ2AWFreqLE8_Jud9j7MbVzT2rs-fQ@mail.gmail.com>
 <CALCETrUpmTqHbZ_XtGhOqFQ4iWQ5bSqppXsHzaGVGdGqBCra0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUpmTqHbZ_XtGhOqFQ4iWQ5bSqppXsHzaGVGdGqBCra0Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 02:41:43PM -0700, Andy Lutomirski wrote:

> I still feel like the ex_handler-automatically-does-CLAC thing is an
> optimization that isn't worth it.  Once we pull our heads out of the
> giant pile of macros and inlined functions, we're talking about
> changing:

> clac; jmp.  But on the flip side, the jump folding pattern looks
> better like this:
> 
> unsafe_uaccess_begin();
> if (unsafe_get_user(...))
>   goto fail;
> if (unsafe_get_user(...))
>   goto fail;
> unsafe_uaccess_end();
> 
> fail:
>   unsafe_uaccess_end();
> 
> than like:
> 
> unsafe_uaccess_begin();
> if (unsafe_get_user(...))
>   goto fail;
> if (unsafe_get_user(...))
>   goto fail;
> unsafe_uaccess_end();
> 
> fail:
>   /* not unsafe_uaccess_end(); because unsafe_get_user() has
> conditional-CLAC semantics */

First of all, user_access_begin() itself can bloody well fail.  So you need
to handle that as well.  And then it becomes nowhere near as pretty.

We can pretend that it's normal C; however, that's not true at all - there
are shitloads of things you can't do in such areas, starting with "call anything
other than a very small list of functions".  It's not a normal C environment
at all.

My problem is not with having AC turned off in exception handler - it leads
to saner patterns, no arguments here.  I'm not happy with doing doing that
on *every* exception, with no way to specify whether it should or should not
be done.  It's not like it would've cost us anything to be able to specify
that - we have the third argument of _ASM_EXTABLE_HANDLE(), after all.
