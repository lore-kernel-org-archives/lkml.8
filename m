Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64086C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4767120643
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbgELOgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgELOgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:36:04 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A98C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:36:03 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:41908)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <psmith@gnu.org>)
        id 1jYW0m-0001BG-1K; Tue, 12 May 2020 10:36:00 -0400
Received: from pool-98-118-0-140.bstnma.fios.verizon.net ([98.118.0.140]:53680 helo=pdslaptop.home)
        by fencepost.gnu.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <psmith@gnu.org>)
        id 1jYW0k-00082Z-Ka; Tue, 12 May 2020 10:35:58 -0400
Message-ID: <73dace5aca21bee09ce12aa8dcfd50daa2cd6051.camel@gnu.org>
Subject: Re: I disabled more compiler warnings..
From:   Paul Smith <psmith@gnu.org>
Reply-To: psmith@gnu.org
To:     David Laight <David.Laight@ACULAB.COM>,
        'Linus Torvalds' <torvalds@linux-foundation.org>
Cc:     'Arnd Bergmann' <arnd@arndb.de>,
        'Masahiro Yamada' <yamada.masahiro@socionext.com>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
Date:   Tue, 12 May 2020 10:35:57 -0400
In-Reply-To: <5564c992dfeb40adbc3e6f6a29e43d2e@AcuMS.aculab.com>
References: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
         <8320f29ca61146fc985083621685ac95@AcuMS.aculab.com>
         <CAHk-=whLY8dXE6qMuPNE+Tjc6uXy+W2jACyWLxtRUH6GU2=PAA@mail.gmail.com>
         <0ff4860b4202a6ef3bb3b29912d083d471e1cc1d.camel@gnu.org>
         <90909f30775744b89d1a0c40265779d9@AcuMS.aculab.com>
         <5564c992dfeb40adbc3e6f6a29e43d2e@AcuMS.aculab.com>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-12 at 07:55 +0000, David Laight wrote:
> > One problem is ensuring that all the recursive makes actually
> > use the same token queue.
> > The Linux kernel build acts as though the sub-makes have their
> > own queue - I certainly had to fix that as well.

I don't understand this... I guess I'm not familiar enough with the
kernel build system.

> I think I've remembered the obvious thing that made it work better.
> 
> When a job ends it is important to get a new token from the jobserver
> rather than reusing the one to hand.
> Otherwise you don't seen the 'abort' marker for ages.

If GNU make retrieved a token then it will always put that token back
into the jobserver pipe when the job ends, and get another one when the
next job is to start.  To do otherwise would mean that some makes could
hoard tokens.

However, the jobserver is implemented such that make itself is not
considered a job, even a sub-make.  The way it works is that when you
invoke a recursive make the parent make will obtain a jobserver token
for that recursive invocation (like it does for every job), then that
sub-make can "pass on" that token: in other words, the sub-make has a
free token that it can always use without querying the jobserver.

This way every invocation of recursive make can always make progress,
at least serially.

I can see that in the "fast fail" model this could be problematic, but
it should only ever be an issue in situations where a sub-make was
running serially for some reason: either the structure of the
prerequisites means it's naturally serial, or else someone added
.NOTPARALLEL to the makefile or something.  As soon as make wants to
run a second job in parallel it will go to the jobserver and discover
the "failure" token.

Changing this will require thought.  We can't just skip the free token
otherwise you can get into a state where all your tokens are used by
recursive makes and no make can get a new token to run a job.

I can see two possible solutions:

First, when a sub-make starts it could put back one token into the
jobserver, representing the token the parent make obtained for it, then
proceed to always get a token before every job (no free token).  This
means that sometimes a sub-make won't be able to run any jobs at all:
it can get locked out waiting for a token.  Maybe that's not a problem.

The other idea is to keep the free token but make it a last resort
rather than a first resort.  This has the nice properties that (a)
we'll see failures fast and (b) we still have a free token, but the
code is more complex: basically we'd need to perform a non-blocking
read on the jobserver FD and if we didn't get anything back, we'd use
our free token if it's still available: if not we'd do a blocking read
on the jobserver FD to wait for a new token.

