Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C3BC2D0F6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05173206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgELQz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgELQz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:55:26 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FA7C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:55:26 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:45184)
        by eggs.gnu.org with esmtp (Exim 4.90_1)
        (envelope-from <psmith@gnu.org>)
        id 1jYYBe-0002bG-7Z; Tue, 12 May 2020 12:55:22 -0400
Received: from pool-98-118-0-140.bstnma.fios.verizon.net ([98.118.0.140]:55126 helo=pdslaptop.home)
        by fencepost.gnu.org with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.82)
        (envelope-from <psmith@gnu.org>)
        id 1jYYBc-0005EL-AV; Tue, 12 May 2020 12:55:20 -0400
Message-ID: <d743bd7bec25c939d7419a3512239b43b990af5a.camel@gnu.org>
Subject: Re: I disabled more compiler warnings..
From:   Paul Smith <psmith@gnu.org>
Reply-To: psmith@gnu.org
To:     David Laight <David.Laight@ACULAB.COM>,
        'Linus Torvalds' <torvalds@linux-foundation.org>
Cc:     'Arnd Bergmann' <arnd@arndb.de>,
        'Masahiro Yamada' <yamada.masahiro@socionext.com>,
        'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
Date:   Tue, 12 May 2020 12:55:19 -0400
In-Reply-To: <464ab7c2d9e144718e4a3135a41f3056@AcuMS.aculab.com>
References: <CAHk-=wjah-fkfzMdmCNN8v7uriJsGeYjHh18wkXDZa2sxuAXzA@mail.gmail.com>
         <8320f29ca61146fc985083621685ac95@AcuMS.aculab.com>
         <CAHk-=whLY8dXE6qMuPNE+Tjc6uXy+W2jACyWLxtRUH6GU2=PAA@mail.gmail.com>
         <0ff4860b4202a6ef3bb3b29912d083d471e1cc1d.camel@gnu.org>
         <90909f30775744b89d1a0c40265779d9@AcuMS.aculab.com>
         <5564c992dfeb40adbc3e6f6a29e43d2e@AcuMS.aculab.com>
         <73dace5aca21bee09ce12aa8dcfd50daa2cd6051.camel@gnu.org>
         <464ab7c2d9e144718e4a3135a41f3056@AcuMS.aculab.com>
Organization: GNU's Not UNIX!
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-12 at 15:04 +0000, David Laight wrote:
> I think there were some sub-makes that were started with make
> instead of $(MAKE) so ended up creating a new job pipe.

Oh, yes, that will do it.

> Doesn't it do blocking reads with SIGCHLD enabled?

No, because it's racy (by itself).

> (or hopefully ppoll() to avoid the race)

GNU make uses pselect(), on systems that support it.  On systems that
don't support pselect() it uses a trick I described in another email:
we dup() the FD, read() on the dup, then in the SIGCHLD handler we
close() the dup.

> Another option is for the 'parent' make to return (or not acquire)
> a job token for $(MAKE) commands.

It just feels cleaner to me to have the parent simply always take the
token, and leave it up to the child to put it back if appropriate,
rather than the parent putting it back.

Having the parent not acquire a token at all won't work; without
limiting sub-makes it means you might have 100's of them running at the
same time, even with -j2 or whatever.

> Or, require the sub-make acquire a token in order to exit.
> Then it can free the token when every job terminates.

I'm not sure I follow that?

