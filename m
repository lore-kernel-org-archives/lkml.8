Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF617C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEEB220853
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGJMuh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:50:37 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47066 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgGJMug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:50:36 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jtsTv-0005O8-3s; Fri, 10 Jul 2020 12:50:23 +0000
Date:   Fri, 10 Jul 2020 14:50:22 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     alex.gaynor@gmail.com, Greg KH <gregkh@linuxfoundation.org>,
        geofft@ldpreload.com, jbaublitz@redhat.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        keescook@chromium.org
Subject: Re: Linux kernel in-tree Rust support
Message-ID: <20200710125022.alry7wkymalmv3ge@wittgenstein>
References: <CAKwvOdmuYc8rW_H4aQG4DsJzho=F+djd68fp7mzmBp3-wY--Uw@mail.gmail.com>
 <20200710062803.GA1071395@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200710062803.GA1071395@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 08:28:03AM +0200, Greg KH wrote:
> On Thu, Jul 09, 2020 at 11:41:47AM -0700, Nick Desaulniers wrote:
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
> Yes, I'll be there.

We actually had this dicussion a while back and there were some more
people interested in this. I'd be interested to attend this and I've
spoken with Kees and a few others about this topic at last Plumbers (I
think Greg might have been around for this informal discussion as well.
But I might be imagining things.).

Christian

