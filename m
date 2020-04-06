Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B418C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D41612496D
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729521AbgDFQlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:41:15 -0400
Received: from nautica.notk.org ([91.121.71.147]:52404 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728962AbgDFQlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:41:15 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 6AB69C009; Mon,  6 Apr 2020 18:41:12 +0200 (CEST)
Date:   Mon, 6 Apr 2020 18:40:57 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Sergey Alirzaev <l29ah@cock.li>
Subject: Re: [GIT PULL] 9p update for 5.7
Message-ID: <20200406164057.GA18312@nautica>
References: <20200406110702.GA13469@nautica>
 <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote on Mon, Apr 06, 2020:
> On Mon, Apr 6, 2020 at 4:07 AM Dominique Martinet
> <asmadeus@codewreck.org> wrote:
> > - Fix read with O_NONBLOCK to allow incomplete read and return
> > immediately
> 
> Hmm. This is kind of special semantics (normally a POSIX filesystem
> ignores O_NONBLOCK), but I guess it makes sense for a network
> filesystem.
> 
> It might be worth a bti more documentation/commenting because of the
> special semantics. For example, since you don't have 'poll()',
> O_NONBLOCK doesn't really mean "nonblocking", it means "stop earlier"
> if I read that patch right. You can't just return -EAGAIN because
> there's no way to then avoid busy looping..

Yes, I think you got this right.

Basically there is no way to tell if the server will return immediately
or not, so even with O_NONBLOCK the read() will still be 'blocking' if
the server decides to wait for something before sending a reply.

This patch will just make the read stop after a single round-trip with
the server instead of looping to fill the buffer if O_NONBLOCK is set.

The use-case here is stuff like reading from synthetic files (think fake
pipes) where data comes in like a pipe and one would want read to return
as soon as data is available.
Just thinking out loud it might be possible to make pipes go through the
server and somewhat work, but this might bring its own share of other
problems and existing programs would need to be changed (e.g. wmii's
synthetic filesystem exposes this kind of files as well as regular
files, which works fine for their userspace client (wmiir) but can't
really be used with a linux client)
(Added Sergey in Cc for opinion)



Anyway, I agree looking at O_NONBLOCK for that isn't obvious.
I agree with the usecase here and posix allows short reads regardless of
the flag so the behaviour is legal either way ; the filesystem is
allowed to return whenever it wants on a whim - let's just add some docs
as you suggest unless Sergey has something to add.

I will add a few lines on that in Documentation/filesystems/9p.txt and
send another pull request in a couple of days to give whoever wants to
review time to comment on wording.

Cheers,
-- 
Dominique
