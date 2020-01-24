Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D168FC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40432087E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389553AbgAXOHZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:07:25 -0500
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:52890 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387412AbgAXOHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:07:24 -0500
Received: from dalias by brightrain.aerifal.cx with local (Exim 3.15 #2)
        id 1iuzcH-0001sV-00; Fri, 24 Jan 2020 14:07:21 +0000
Date:   Fri, 24 Jan 2020 09:07:21 -0500
From:   Rich Felker <dalias@libc.org>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: Proposal to fix pwrite with O_APPEND via pwritev2 flag
Message-ID: <20200124140721.GV30412@brightrain.aerifal.cx>
References: <20200124000243.GA12112@brightrain.aerifal.cx>
 <87d0b942lp.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0b942lp.fsf@oldenburg2.str.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 10:37:22AM +0100, Florian Weimer wrote:
> * Rich Felker:
> 
> > There's a longstanding unfixable (due to API stability) bug in the
> > pwrite syscall:
> >
> > http://man7.org/linux/man-pages/man2/pwrite.2.html#BUGS
> >
> > whereby it wrongly honors O_APPEND if set, ignoring the caller-passed
> > offset. Now that there's a pwritev2 syscall that takes a flags
> > argument, it's possible to fix this without breaking stability by
> > adding a new RWF_NOAPPEND flag, which callers that want the fixed
> > behavior can then pass.
> >
> > I have a completely untested patch to add such a flag, but would like
> > to get a feel for whether the concept is acceptable before putting
> > time into testing it. If so, I'll submit this as a proper patch with
> > detailed commit message etc. Draft is below.
> 
> Has this come up before?

I'm not sure if there's an open glibc bug for it or not, but it's come
up in musl community before that the kernel is non-conforming here for
historical reasons (preserving the original bug in case any software
is depending on it) and we've always wanted to have a fix, but
couldn't find one short of just erroring out if O_APPEND is set when
pwrite is called. That's what the fallback will do (rather than
silently write data at the wrong place) if pwritev2+RWF_NOAPPEND is
not supported on the system at runtime.

> I had already written a test case and it turns out that an O_APPEND
> descriptor does not protect the previously written data in the file:
> 
> openat(AT_FDCWD, "/tmp/append-truncateuoRexJ", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
> write(3, "@", 1)                        = 1
> close(3)                                = 0
> openat(AT_FDCWD, "/tmp/append-truncateuoRexJ", O_WRONLY|O_APPEND) = 3
> ftruncate(3, 0)                         = 0
> 
> So at least it looks like there is no security issue in adding a
> RWF_NOAPPEND flag.

Indeed, if you have the file open you can just use fcntl to remove
O_APPEND (but of course using that in an emulation would be racy), so
it's not a security boundary. Someone could try to "make it into one"
with seccomp, blocking fcntl that would remove O_APPEND and blocking
ftruncate, mmap, and all other ways you could modify the existing part
of the file, but that sounds fragile, and if they really want to do
that they can block pwritev2 as well (or at least block it with
RWF_NOAPPEND or future/unknown flags).

Rich
