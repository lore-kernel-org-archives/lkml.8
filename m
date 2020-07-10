Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0746BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68962072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 05:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgGJFg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 01:36:56 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:59423 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgGJFg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 01:36:56 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 44079FF803;
        Fri, 10 Jul 2020 05:36:44 +0000 (UTC)
Date:   Thu, 9 Jul 2020 22:36:42 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     alex.gaynor@gmail.com, geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: Linux kernel in-tree Rust support
Message-ID: <20200710053642.GA7282@localhost>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 11:41:47AM -0700, Nick Desaulniers wrote:
> Hello folks,
> I'm working on putting together an LLVM "Micro Conference" for the
> upcoming Linux Plumbers Conf
> (https://www.linuxplumbersconf.org/event/7/page/47-attend).  It's not
> solidified yet, but I would really like to run a session on support
> for Rust "in tree."  I suspect we could cover technical aspects of
> what that might look like (I have a prototype of that, was trivial to
> wire up KBuild support), but also a larger question of "should we do
> this?" or "how might we place limits on where this can be used?"
> 
> Question to folks explicitly in To:, are you planning on attending plumbers?
> 
> If so, would this be an interesting topic that you'd participate in?

I hadn't planned to attend the virtual event, but this sounds like a
topic I absolutely have to attend. Please follow up if this proposal
gets accepted.

I'd love to see a path to incorporating Rust into the kernel, as long as
we can ensure that:
- There are appropriate Rustic interfaces that are natural and safe to
  use (not just C FFI, and not *just* trivial transformations like
  slices instead of buffer+len pairs).
- Those Rustic interfaces are easy to maintain and evolve with the kernel.
- We provide compelling use cases that go beyond just basic safety, such
  as concurrency checking, or lifetimes for object ownership.
- We make Rust fit naturally into the kernel's norms and standards,
  while also introducing some of Rust's norms and standards where they
  make sense. (We want to fit into the kernel, and at the same time, we
  don't want to hastily saw off all the corners that don't immediately
  fit, because some of those corners provide value. Let's take our
  time.)
- We move slowly and carefully, making sure it's a gradual introduction,
  and give people time to incorporate the Rust toolchain into their
  kernel workflows.

Also, with my "Rust language team lead" hat on, I'd be happy to have the
Linux kernel feeding into Rust language development priorities. If
building Rustic interfaces within the kernel requires some additional
language features, we should see what enhancements to the language would
best serve those requirements. I've often seen the sentiment that
co-evolving Linux and a C compiler would be beneficial for both; I think
the same would be true of Linux and the Rust compiler.
