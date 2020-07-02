Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8925C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C686520890
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 20:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgGBUSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbgGBUSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 16:18:24 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936B5C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 13:18:24 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jr5ed-0049VK-MY; Thu, 02 Jul 2020 20:17:55 +0000
Date:   Thu, 2 Jul 2020 21:17:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
Message-ID: <20200702201755.GO2786714@ZenIV.linux.org.uk>
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com>
 <20200701184131.GI2786714@ZenIV.linux.org.uk>
 <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com>
 <20200701195914.GK2786714@ZenIV.linux.org.uk>
 <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au>
 <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 12:52:27PM -0700, Linus Torvalds wrote:
> On Thu, Jul 2, 2020 at 6:32 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > Probably the simplest option for us is to just handle it in our
> > unsafe_op_wrap(). I'll try and come up with something tomorrow.
> 
> IMy suggestion was to basically just always handle it in all exception cases.
> 
> And note that IU don't mean the fault handler: obviously page faults
> (or unaligned faults or whatever) can happen while in a user access
> region.
> 
> But I mean any time fixup_exception() triggers.
> 
> For x86, this is in fact particularly natural: it involves just always
> clearing the AC bit in the "struct pt_regs" that fixup_exception()
> gets anyway. We can do it without even bothering with checking for
> CLAC/STAC support, since without it, AC is meaningless in kernel mode
> anyway, but also because doing "user_access_end()" in the exception
> would be pointless: AC is restored by the exception routine, so on x86
> you *have* to do it by just modifying the return state.

What about

static inline int copy_xregs_to_user(struct xregs_state __user *buf)
{
[...]
        stac();
        XSTATE_OP(XSAVE, buf, -1, -1, err);
        clac();
where XSTATE_OP() is
#define XSTATE_OP(op, st, lmask, hmask, err)                            \
        asm volatile("1:" op "\n\t"                                     \
                     "xor %[err], %[err]\n"                             \
                     "2:\n\t"                                           \
                     ".pushsection .fixup,\"ax\"\n\t"                   \
                     "3: movl $-2,%[err]\n\t"                           \
                     "jmp 2b\n\t"                                       \
                     ".popsection\n\t"                                  \
                     _ASM_EXTABLE(1b, 3b)                               \
                     : [err] "=r" (err)                                 \
                     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)    \
                     : "memory")

Rely upon objtool not noticing that we have, in effect, clac() in a state
where AC is already cleared?  We could massage that thing to take a label,
but it wouldn't be pretty...
