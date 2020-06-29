Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D99C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49CDA2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 18:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgF2Sq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:46:57 -0400
Received: from verein.lst.de ([213.95.11.211]:58879 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729294AbgF2Sqf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:46:35 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0E55768C7B; Mon, 29 Jun 2020 20:07:31 +0200 (CEST)
Date:   Mon, 29 Jun 2020 20:07:30 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 03/11] fs: add new read_uptr and write_uptr file
 operations
Message-ID: <20200629180730.GA4600@lst.de>
References: <20200624162901.1814136-1-hch@lst.de> <20200624162901.1814136-4-hch@lst.de> <CAHk-=wit9enePELG=-HnLsr0nY5bucFNjqAqWoFTuYDGR1P4KA@mail.gmail.com> <20200624175548.GA25939@lst.de> <CAHk-=wi_51SPWQFhURtMBGh9xgdo74j1gMpuhdkddA2rDMrt1Q@mail.gmail.com> <f50b9afa5a2742babe0293d9910e6bf4@AcuMS.aculab.com> <CAHk-=wjxQczqZ96esvDrH5QZsLg6azXCGDgo+Bmm6r8t2ssasg@mail.gmail.com> <20200629152912.GA26172@lst.de> <CAHk-=wj_Br5dQt0GnMjHooSvBbVXwtGRVKQNkpCLwWjYko-4Zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj_Br5dQt0GnMjHooSvBbVXwtGRVKQNkpCLwWjYko-4Zw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:02:48AM -0700, Linus Torvalds wrote:
> That said, is there no practical limit on how big "optlen" can be?

There are some pretty huge ones, like the sctp one that can take
a basically unlimited list of sockaddr structures.

> Sure, I realize that a lot of setsockopt users may not use all of the
> data, but let's say that "optlen" is 128, but the actual low-level
> setsockopt operation only uses the first 16 bytes, maybe we could
> always just copy the 128 bytes from user space into kernel space, and
> just say "setsockopt() always gets a kernel pointer".

One issue is that a lot setsockopt calls are in the fast path, and
even have micro-optimizations like putting an int on stack for the
fast path to avoid the memory allocation.  While I don't know for
sure I fear that always doing a large allocation could end up having
a performance impact.  But otherwise I like that idea, and did in
fact start some prep work until I realized what I did was futile.

> Then the bpf use is even simpler. It would just pass the kernel
> pointer natively.
> 
> Because that seems to be what the BPF code really wants to do: it
> takes the user optval, and munges it into a kernel optval, and then
> (if that has been done) runs the low-level sock_setsockopt() under
> KERNEL_DS.
> 
> Couldn't we switch things around instead, and just *always* copy
> things from user space, and sock_setsockopt (and
> sock->ops->setsockopt) _always_ get a kernel buffer?
> 
> And avoid the set_fs(KERNEL_DS) games entirely that way?

I'd love to be able to do that.  And now that we want through this
whole mess than Nth time I have another idea:

 - we assume optlen is correct, which should cover about 90% of
   the protocols
 - but to override that a new setsockopt_len method is added that
   returns the correct length for all the messy ones.

Let me try if that works out.
