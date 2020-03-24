Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EC2AC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0120E2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:42:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgCXUm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:42:57 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:37086 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgCXUm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:42:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGqNq-001wyh-R6; Tue, 24 Mar 2020 20:42:46 +0000
Date:   Tue, 24 Mar 2020 20:42:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 5/7] x86: convert arch_futex_atomic_op_inuser() to
 user_access_begin/user_access_end()
Message-ID: <20200324204246.GH23230@ZenIV.linux.org.uk>
References: <20200323185057.GE23230@ZenIV.linux.org.uk>
 <20200323185127.252501-1-viro@ZenIV.linux.org.uk>
 <20200323185127.252501-5-viro@ZenIV.linux.org.uk>
 <CAHk-=wgMmmnQTFT7U9+q2BsyV6Ge+LAnnhPmv0SUtFBV1D4tVw@mail.gmail.com>
 <20200324020846.GG23230@ZenIV.linux.org.uk>
 <CAHk-=whTwaUZZ5Aj_Viapf2tdvcd65WdM4jjXJ3tdOTDmgkW0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whTwaUZZ5Aj_Viapf2tdvcd65WdM4jjXJ3tdOTDmgkW0g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 09:19:15AM -0700, Linus Torvalds wrote:
> On Mon, Mar 23, 2020 at 7:08 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > > And wouldn't it be lovely to get rid of the error return thing, and
> > > pass in a label instead, the way "usafe_get/put_user()" works too?
> > > That might be a separate patch from the "reorg" thing, though.
> >
> > OK, ret wouldn't be in the list of outputs that way and
> > *uaddr could become an input (we only care about the address,
> > same as for put_user), but oldval is a genuine output -
> 
> Yes, initially we'd have to do the "jump to label" inside the macro,
> because gcc doesn't support asm goto with outputs.
> 
> But that's no different from "unsafe_get_user()". We still pass it a
> label, even though we can't use it in the inline asm.
> 
> Yet.
> 
> I have patches to make it work with newer versions of clang, and I
> hope that gcc will eventually also accept the semantics of "asm goto
> with outputs only has the output on the fallthrough".
> 
> So _currently_ it would be only syntactic sugar: moving the error
> handling inside the macro, and making it syntactically match
> unsafe_get_user().
> 
> But long term is would allow us to generate better code too.

OK...  BTW, I'd been trying to recall the reasons for the way
__futex_atomic_op2() loop is done; ISTR some discussion along
the lines of cacheline ping-pong prevention, but I'd been unable
to reconstruct enough details to find it and I'm not sure it
hadn't been about some other code ;-/

What we have there (fault handling aside) is
loop:	eax = *uaddr;
	v = eax | oparg;
	lock cmpxchg v, *uaddr
	if (!zf)
		goto loop;
	oldval = eax;
Why do we bother with reload?  That cmpxchg is, after all,
	t = *uaddr;
	zf = (t == eax);
	*uaddr = zf ? v : t;
	eax = t;
so what would be wrong with doing
	eax = *uaddr;
loop:	v = eax | oparg;
	lock cmpxchg v, *uaddr
	if (!zf)
		goto loop;
	oldval = eax;
instead?
