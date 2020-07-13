Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6696DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4662A2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgGMVdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:33:38 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:59947 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgGMVdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 17:33:38 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 9F75F1C0002;
        Mon, 13 Jul 2020 21:33:30 +0000 (UTC)
Date:   Mon, 13 Jul 2020 14:33:26 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     ebiederm@xmission.com (Eric W. Biederman)
Cc:     Nick Desaulniers <ndesaulniers@google.com>, alex.gaynor@gmail.com,
        geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: Linux kernel in-tree Rust support
Message-ID: <20200713213326.GA16462@localhost>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <875zarb7zy.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zarb7zy.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 01:11:13PM -0500, Eric W. Biederman wrote:
> Nick Desaulniers <ndesaulniers@google.com> writes:
> 
> > Hello folks,
> > I'm working on putting together an LLVM "Micro Conference" for the
> > upcoming Linux Plumbers Conf
> > (https://www.linuxplumbersconf.org/event/7/page/47-attend).  It's not
> > solidified yet, but I would really like to run a session on support
> > for Rust "in tree."  I suspect we could cover technical aspects of
> > what that might look like (I have a prototype of that, was trivial to
> > wire up KBuild support), but also a larger question of "should we do
> > this?" or "how might we place limits on where this can be used?"
> >
> > Question to folks explicitly in To:, are you planning on attending plumbers?
> >
> > If so, would this be an interesting topic that you'd participate in?
> 
> I have two big concerns about actually using rust.
> 
> 1) How large is the rust language support, and will each rust module
>    need to duplicate it.  I seem to remember someone mentioning it is
>    noticable in size.

There should only be a single copy, which could either be in the kernel
(if there's Rust code compiled into the kernel) or be in a "rust.ko"
support module. As long as you use the same version of Rust for the
kernel and all modules, you can supply symbols dynamically.

There are a few other steps we can take to control code size, as well.
In particular, there are tradeoffs between performance and size, such as
the amount of code in generics vs non-generics. (We also need to get
some further optimizations into Rust on that front, such as tail
merging.)

As for the size overall, given that we'll just be providing the portions
of "core" and "alloc" that the built code actually uses, and likely not
providing "std" at all, I would expect the size to remain relatively
small.

I very much care about overall kernel size, and I'm happy to help make
sure it remains reasonable.

> 2) What is rust usable for?  The rust type system will not admit
>    doubly linked lists (or anything where two pointers point at the
>    same memory) unless you are using an unsafe block.

There are libraries like intrusive-collections which implement
kernel-style structures with potentially multiple nodes in the structure
that put them into multiple lists at once. I would expect us to use
those (or in some cases implement our own). They don't need to be
written in C, just unsafe Rust that's wrapped up in a safe interface.

Just as the kernel has a variety of higher-level interfaces and data
structures that make working in the kernel sometimes *easier* than the
average C program, I'd expect that we'll end up with common Rust
structures that do what people need, rather than people reimplementing
their own.

- Josh Triplett
