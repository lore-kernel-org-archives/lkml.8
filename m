Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4AC5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E834120690
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389211AbgEMPc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728678AbgEMPc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:32:58 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C40C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:32:58 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:39604)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <psmith@gnu.org>)
        id 1jYtNM-0002SM-79; Wed, 13 May 2020 11:32:52 -0400
Received: from pool-98-118-0-140.bstnma.fios.verizon.net ([98.118.0.140]:51596 helo=pdslaptop.home)
        by fencepost.gnu.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <psmith@gnu.org>)
        id 1jYtNL-0000Cx-Q6; Wed, 13 May 2020 11:32:52 -0400
Message-ID: <6a5a75043f697a130422fbc3a3f8464dc6d03e2f.camel@gnu.org>
Subject: Re: I disabled more compiler warnings..
From:   Paul Smith <psmith@gnu.org>
Reply-To: psmith@gnu.org
To:     David Laight <David.Laight@ACULAB.COM>,
        'Linus Torvalds' <torvalds@linux-foundation.org>
Cc:     'Arnd Bergmann' <arnd@arndb.de>,
        'Masahiro Yamada' <yamada.masahiro@socionext.com>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
Date:   Wed, 13 May 2020 11:32:50 -0400
In-Reply-To: <4a540a5d341c468bae131934b413e4ce@AcuMS.aculab.com>
References: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
         <8320f29ca61146fc985083621685ac95@AcuMS.aculab.com>
         <CAHk-=whLY8dXE6qMuPNE+Tjc6uXy+W2jACyWLxtRUH6GU2=PAA@mail.gmail.com>
         <0ff4860b4202a6ef3bb3b29912d083d471e1cc1d.camel@gnu.org>
         <90909f30775744b89d1a0c40265779d9@AcuMS.aculab.com>
         <5564c992dfeb40adbc3e6f6a29e43d2e@AcuMS.aculab.com>
         <73dace5aca21bee09ce12aa8dcfd50daa2cd6051.camel@gnu.org>
         <464ab7c2d9e144718e4a3135a41f3056@AcuMS.aculab.com>
         <d743bd7bec25c939d7419a3512239b43b990af5a.camel@gnu.org>
         <4a540a5d341c468bae131934b413e4ce@AcuMS.aculab.com>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-13 at 08:21 +0000, David Laight wrote:
> > GNU make uses pselect(), on systems that support it.  On systems
> > that don't support pselect() it uses a trick I described in another
> > email: we dup() the FD, read() on the dup, then in the SIGCHLD
> > handler we close() the dup.
> 
> Does that even work - seems like it requires close() to abort poll().
> Better is to just have the SIGCHLD handler write a byte into a pipe.

Sorry I guess I wasn't clear.

We use _either_ pselect(), _or_ the close()-the-dup trick.  Not both.

If we have pselect() we use that: no dup'ing or close'ing needed.

If we don't have pselect() we use the close() in the signal handler. 
In that case we're just waiting in the read(), we're not using select()
or poll() or whatever.  It's definitely the case that if we're waiting
in read() and someone closes the FD, we'll wake up! :)

> > Having the parent not acquire a token at all won't work; without
> > limiting sub-makes it means you might have 100's of them running at
> > the same time, even with -j2 or whatever.
> 
> Hmmm... 
> That means the sub-make must always hold one token.
> Otherwise the parent-make could use it to create a new sub-make.

Right, my first idea has this same problem so it won't work.

> Actually the token pipe can be opened NON_BLOCK because poll()
> can/will be used to wait for a token.

Again, that only works on systems where pselect() is available.

> So you always try to read a token - even when you have one 'in your
> hand' (either entry or because a job just finished).  If it isn't the
> 'abort' one, put it back.

Something like that would be needed, yes.

Note this is only needed in a rare situation where you're running with
parallelism enabled BUT you have a makefile which never actually tries
to run two or more jobs at the same time for some reason.

