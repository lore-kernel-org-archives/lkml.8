Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804C0C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7A1206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730973AbgEKR67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727051AbgEKR67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:58:59 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02005C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:58:59 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:42779)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <psmith@gnu.org>)
        id 1jYCha-00008Q-3v; Mon, 11 May 2020 13:58:54 -0400
Received: from pool-98-118-0-140.bstnma.fios.verizon.net ([98.118.0.140]:36660 helo=pdslaptop.home)
        by fencepost.gnu.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <psmith@gnu.org>)
        id 1jYChZ-0005XH-5Z; Mon, 11 May 2020 13:58:53 -0400
Message-ID: <0ff4860b4202a6ef3bb3b29912d083d471e1cc1d.camel@gnu.org>
Subject: Re: I disabled more compiler warnings..
From:   Paul Smith <psmith@gnu.org>
Reply-To: psmith@gnu.org
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Laight <David.Laight@aculab.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Mon, 11 May 2020 13:58:52 -0400
In-Reply-To: <CAHk-=whLY8dXE6qMuPNE+Tjc6uXy+W2jACyWLxtRUH6GU2=PAA@mail.gmail.com>
References: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
         <8320f29ca61146fc985083621685ac95@AcuMS.aculab.com>
         <CAHk-=whLY8dXE6qMuPNE+Tjc6uXy+W2jACyWLxtRUH6GU2=PAA@mail.gmail.com>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-11 at 10:41 -0700, Linus Torvalds wrote:
> On Mon, May 11, 2020 at 12:43 AM David Laight <
> David.Laight@aculab.com> wrote:
> > 
> > I've not looked inside gmake, but I fixed nmake so that it
> > properly used a single job token pipe for the entire (NetBSD)
> > build and then flushed and refilled it with 'abort' tokens
> > when any command failed.
> > That made the build stop almost immediately.
> 
> The GNU jobserver doesn't have anything like that, afaik.
> 
> I think it always writes a '+' character as a token, so I guess it
> could be extended to write something else for the "abort now"
> situation (presumably a '-' character).

That was exactly my plan.

> But at least for external jobserver clients (of which I am not aware
> of any, I think we only depend on the internal GNU make behavior),
> the documentation states that you should just write back the same
> token you read.

I wrote this text precisely because I intended to support using other
tokens to specify other situations, such as failure :).

As a note, the GCC project has a GSoC project approved for this summer,
for GCC and/or binutils to participate in the jobserver protocol when
they do multithreading in the compiler/linker.  I think they are
planning on creating a generic "jobserver library" but I'm not
mentoring (I don't have the bandwidth for GSoC mentoring).  I do hope
to stay abreast of their work and perhaps toss in suggestions however.

> Paul - the issue is that most of us build the kernel with a "make
> -j<bignum>" (in my case "-j32") and if an error happens during the
> make, it can take a _looong_ time for make to react. And if there are
> warnings in the build, they can hide the actual error fairly easily).

Yes, I believe I have an enhancement in Savannah about this.

> I can trivially see how to do it in the jobserver code itself (just
> see if the token we get was '-', and if it was, write it back for the
> next user and return error), but it's the downstream make code I'm
> entirely unfamiliar with.

That's necessary, but my thinking is that more could be done.  What I
was going to do was if we write back an error token then we would also
go into a loop trying to read all the tokens off the jobserver and
write back error tokens, until we read an error token, then we'd exit
(after writing it back obviously).

If you don't do that you'll have to go through an entire set of builds
after the failure before everyone notices the failure.  If every
instance of make does this then you can propogate the error to everyone
more quickly.

My current work on GNU make is fixing the atrocious mess it has with
signal handling: don't even look and if you do, remember I inherited
this code (yeah, yeah, a long time ago but still... :)).  Right now
it's not so hard (especially with large -j) to have make instances
hanging when ^C is used due to race conditions in the signal handling.

As with all single-threaded applications, though, the problem is the
difficulty (in a portable way) of handling both signals and wait*(2)
reliably...

Anyway, this shouldn't be too difficult.

