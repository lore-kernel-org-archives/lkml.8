Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69898C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 02:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 429592051A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 02:08:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgCXCI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 22:08:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:52624 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgCXCI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 22:08:56 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGYzm-001Ii4-9m; Tue, 24 Mar 2020 02:08:46 +0000
Date:   Tue, 24 Mar 2020 02:08:46 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 5/7] x86: convert arch_futex_atomic_op_inuser() to
 user_access_begin/user_access_end()
Message-ID: <20200324020846.GG23230@ZenIV.linux.org.uk>
References: <20200323185057.GE23230@ZenIV.linux.org.uk>
 <20200323185127.252501-1-viro@ZenIV.linux.org.uk>
 <20200323185127.252501-5-viro@ZenIV.linux.org.uk>
 <CAHk-=wgMmmnQTFT7U9+q2BsyV6Ge+LAnnhPmv0SUtFBV1D4tVw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgMmmnQTFT7U9+q2BsyV6Ge+LAnnhPmv0SUtFBV1D4tVw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 12:06:39PM -0700, Linus Torvalds wrote:
> On Mon, Mar 23, 2020 at 11:53 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > From: Al Viro <viro@zeniv.linux.org.uk>
> >
> > Lift stac/clac pairs from __futex_atomic_op{1,2} into arch_futex_atomic_op_inuser(),
> > fold them with access_ok() in there.
> 
> So this is a deep internal macro and already has the double
> underscore, but I'm inclined to say "add the unsafe here too" for
> those __futex_atomic_opX() macros that are now called inside that
> user_access_begin/end region.
> 
> And wouldn't it be lovely to get rid of the error return thing, and
> pass in a label instead, the way "usafe_get/put_user()" works too?
> That might be a separate patch from the "reorg" thing, though.

Umm...
#define __futex_atomic_op1(insn, ret, oldval, uaddr, oparg)     \
        asm volatile("1:\t" insn "\n"                           \
                     "2:\n"                                     \
                     "\t.section .fixup,\"ax\"\n"               \
                     "3:\tmov\t%3, %1\n"                        \
                     "\tjmp\t2b\n"                              \
                     "\t.previous\n"                            \
                     _ASM_EXTABLE_UA(1b, 3b)                    \
                     : "=r" (oldval), "=r" (ret), "+m" (*uaddr) \
                     : "i" (-EFAULT), "0" (oparg), "1" (0))

OK, ret wouldn't be in the list of outputs that way and
*uaddr could become an input (we only care about the address,
same as for put_user), but oldval is a genuine output -
insn is xchgl or lock xaddl, and we obviously care about the
old value fetched by it.  The same goes for
#define __futex_atomic_op2(insn, ret, oldval, uaddr, oparg)     \
        asm volatile("1:\tmovl  %2, %0\n"                       \
                     "\tmovl\t%0, %3\n"                         \
                     "\t" insn "\n"                             \
                     "2:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"     \
                     "\tjnz\t1b\n"                              \
                     "3:\n"                                     \
                     "\t.section .fixup,\"ax\"\n"               \
                     "4:\tmov\t%5, %1\n"                        \
                     "\tjmp\t3b\n"                              \
                     "\t.previous\n"                            \
                     _ASM_EXTABLE_UA(1b, 4b)                    \
                     _ASM_EXTABLE_UA(2b, 4b)                    \
                     : "=&a" (oldval), "=&r" (ret),             \
                       "+m" (*uaddr), "=&r" (tem)               \
                     : "r" (oparg), "i" (-EFAULT), "1" (0))
- oldval is calculated by that thing and arch_futex_atomic_op_inuser()
ends up storing it in *oval.  And moving that assignment into
the inline asm will simply put *oval into the output list,
won't it?

How would you work around that?
