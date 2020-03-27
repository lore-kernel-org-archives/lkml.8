Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AB5C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BA1206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:50:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgC0DuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:50:11 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48978 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbgC0DuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:50:10 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jHg0T-003joh-Bh; Fri, 27 Mar 2020 03:50:05 +0000
Date:   Fri, 27 Mar 2020 03:50:05 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH v2 6/8] x86: don't reload after cmpxchg in
 unsafe_atomic_op2() loop
Message-ID: <20200327035005.GU23230@ZenIV.linux.org.uk>
References: <20200327022836.881203-1-viro@ZenIV.linux.org.uk>
 <20200327022836.881203-6-viro@ZenIV.linux.org.uk>
 <CAHk-=wga5Z9qk0Wa-Jpwb7x+4BG6C17cHfqX4KKqWm9jATpQUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wga5Z9qk0Wa-Jpwb7x+4BG6C17cHfqX4KKqWm9jATpQUw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 08:23:59PM -0700, Linus Torvalds wrote:
> On Thu, Mar 26, 2020 at 7:28 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > From: Al Viro <viro@zeniv.linux.org.uk>
> >
> > lock cmpxchg leaves the current value in eax; no need to reload it.
> 
> I think this one is buggy.
> 
> Patch edited to remove the "-" lines, so that you see the end result:
> 
> >         int oldval = 0, ret, tem;                               \
> >         asm volatile("1:\tmovl  %2, %0\n"                       \
> > +                    "2:\tmovl\t%0, %3\n"                       \
> >                      "\t" insn "\n"                             \
> > +                    "3:\t" LOCK_PREFIX "cmpxchgl %3, %2\n"     \
> > +                    "\tjnz\t2b\n"                              \
> > +                    "4:\n"                                     \
> >                      "\t.section .fixup,\"ax\"\n"               \
> > +                    "5:\tmov\t%5, %1\n"                        \
> >                      "\tjmp\t3b\n"                              \
> >                      "\t.previous\n"                            \
> > +                    _ASM_EXTABLE_UA(1b, 5b)                    \
> > +                    _ASM_EXTABLE_UA(3b, 5b)                    \
> >                      : "=&a" (oldval), "=&r" (ret),             \
> >                        "+m" (*uaddr), "=&r" (tem)               \
> >                      : "r" (oparg), "i" (-EFAULT), "1" (0));    \
> 
> I think that
> 
>                        "\tjmp\t3b\n"
> 
> line in the fixup section should be
> 
>                        "\tjmp\t4b\n"
> 
> because you don't want to jump to the cmpxchg instruction.
> 
> Maybe I'm misreading it.

You are not - I'd missed that one while renumbering the labels.  Fixed and
pushed.
