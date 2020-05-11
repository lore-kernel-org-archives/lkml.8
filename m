Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35220C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16AF0206E6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbgEKUZZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgEKUZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:25:25 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D9CC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 13:25:25 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:46623)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <psmith@gnu.org>)
        id 1jYEzI-00071x-T2; Mon, 11 May 2020 16:25:20 -0400
Received: from pool-98-118-0-140.bstnma.fios.verizon.net ([98.118.0.140]:38080 helo=pdslaptop.home)
        by fencepost.gnu.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <psmith@gnu.org>)
        id 1jYEzA-0002IL-Kc; Mon, 11 May 2020 16:25:13 -0400
Message-ID: <7c5cedf6a5f522087b431e0a9f88b6ba66c21405.camel@gnu.org>
Subject: Re: I disabled more compiler warnings..
From:   Paul Smith <psmith@gnu.org>
Reply-To: psmith@gnu.org
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Laight <David.Laight@aculab.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 11 May 2020 16:25:11 -0400
In-Reply-To: <CAHk-=wi=SbaC20nRx5tmAZ2_tOpVOq7469V+KvZU9=4yvfvmnA@mail.gmail.com>
References: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
         <8320f29ca61146fc985083621685ac95@AcuMS.aculab.com>
         <CAHk-=whLY8dXE6qMuPNE+Tjc6uXy+W2jACyWLxtRUH6GU2=PAA@mail.gmail.com>
         <0ff4860b4202a6ef3bb3b29912d083d471e1cc1d.camel@gnu.org>
         <CAHk-=wi=SbaC20nRx5tmAZ2_tOpVOq7469V+KvZU9=4yvfvmnA@mail.gmail.com>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-11 at 12:33 -0700, Linus Torvalds wrote:
> I wonder if you could just have three different file descriptors:
> 
>  - the "current token file descriptor"
>  - a /dev/null file descriptor
>  - the jobserver pipe file descriptor. This is left blocking.

If I'm understanding your suggestion correctly, this is pretty much how
it worked originally.  Except I didn't use a /dev/null file descriptor:
I dup the jobserver FD, read() the dup, and then in the signal handler
I _closed_ the dup.

So, I can tell what happened by whether the read() returns EINTR vs.
EBADF.

This is still how things work on systems without pselect() support.

There's a blog page I wrote about this many (er... MANY) years ago:

http://make.mad-scientist.net/papers/jobserver-implementation/

You can skip the blather at the top: search down to "Then it gets
ugly..." and check the algorithm there to see if that's what you had in
mind.


The problem is that SA_RESTART works well in Linux but is not always
reliable on other OS's, and it's not always possible to catch EINTR
everywhere (for example, in third party libraries like libintl) so you
can't always automatically restart from a SIGCHLD.

See this bug reported on OS X for example:
  https://savannah.gnu.org/bugs/?func=detailitem&item_id=46261


But, the issue I have now is not related to SIGCHLD, it's related to
SIGINT/SIGTERM etc. handling.  Today, GNU make calls its die() function
directly from the SIGINT signal handler, and die() does A LOT of very
signal-unsafe stuff.  Gross, but it's worked like that for 30 years.

My idea was that since GNU make already uses an EINTRLOOP() macro to
check EINTR returns from system calls and restart, I would have the
SIGINT handler just set a variable, then install into the EINTRLOOP
macro a check of that variable, which would let me transition from
signal handler to user-space without dropping checks all over the code
(at least, not visibly :)).  Maybe I'd check directly in a few places,
where we may go for some time without a system call.

That worked but I do have to contend with the same issue as the
jobserver: any time I need to wait for something I have a race between
the last time I checked for an interrupt and the wait operation.

I have had to put this aside for a bit, so I haven't decided how to
address it but I'm sure it's doable.  The issue with GNU make is it has
to be as portable as possible: make is a foundational tool for any sort
of system bootstrap.  Of course, we could just not support parallel
builds on insufficient systems but...

If people feel this isn't an appropriate topic for lkml, I invite
anyone interested parties to post to bug-make@gnu.org :).

