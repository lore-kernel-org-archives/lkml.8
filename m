Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76652C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A63C206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 22:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgGJW7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 18:59:44 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:31475 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726578AbgGJW7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 18:59:43 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 5ED8E240002;
        Fri, 10 Jul 2020 22:59:35 +0000 (UTC)
Date:   Fri, 10 Jul 2020 15:59:34 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>, alex.gaynor@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>, geofft@ldpreload.com,
        jbaublitz@redhat.com, Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        keescook@chromium.org
Subject: Re: Linux kernel in-tree Rust support
Message-ID: <20200710225934.GA16881@localhost>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200710062803.GA1071395@kroah.com>
 <20200710125022.alry7wkymalmv3ge@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710125022.alry7wkymalmv3ge@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 02:50:22PM +0200, Christian Brauner wrote:
> On Fri, Jul 10, 2020 at 08:28:03AM +0200, Greg KH wrote:
> > On Thu, Jul 09, 2020 at 11:41:47AM -0700, Nick Desaulniers wrote:
> > > Hello folks,
> > > I'm working on putting together an LLVM "Micro Conference" for the
> > > upcoming Linux Plumbers Conf
> > > (https://www.linuxplumbersconf.org/event/7/page/47-attend).  It's not
> > > solidified yet, but I would really like to run a session on support
> > > for Rust "in tree."  I suspect we could cover technical aspects of
> > > what that might look like (I have a prototype of that, was trivial to
> > > wire up KBuild support), but also a larger question of "should we do
> > > this?" or "how might we place limits on where this can be used?"
> > > 
> > > Question to folks explicitly in To:, are you planning on attending plumbers?
> > > 
> > > If so, would this be an interesting topic that you'd participate in?
> > 
> > Yes, I'll be there.
> 
> We actually had this dicussion a while back and there were some more
> people interested in this. I'd be interested to attend this and I've
> spoken with Kees and a few others about this topic at last Plumbers (I
> think Greg might have been around for this informal discussion as well.
> But I might be imagining things.).

I was around for one of the informal conversations with Greg and Kees
and others.

As I recall, Greg's biggest condition for initial introduction of this
was to do the same kind of "turn this Kconfig option on and turn an
option under it off" trick that LTO uses, so that neither "make
allnoconfig" nor "make allyesconfig" would require Rust until we've had
plenty of time to experiment with it. And that seems entirely
reasonable to me too.

- Josh
