Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5880C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D4620857
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ezbIGLOF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393963AbgDOOZy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391955AbgDOOZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:25:48 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9753C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:25:48 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c16so7567616qtv.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 07:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KINPyzTZu6/Wo4CkiB3sGCQF2+FkTO2UpELVAZQ1Ibw=;
        b=ezbIGLOF202eT6JssXc4e/SfSxqOF5Ty120nUVGIetesb7hudRSCtLkZLiWe9uVW7O
         jGG88YRJ/ObP1OOQR/5d4ZQD622oydUN2pG4NfO9l+gXfOwnAvGmQPV10LnzEI1bCXZ3
         Y4bmSKW5UP3PxtD2dcIfmFRFh2bFBExV1vruB515fDrIZbq3JCQDyyo1MxDXCpcrleav
         zblTb8gNiq0C0VKlJLbnsj9728m2rWqj7jgqltbUzk5g71Lh1Pes7XiuMu5Md+oxDpNf
         I+XC42/7FoCfn04mnMf+qFUOUiPDJTvUSOh2LJBQs7QC0C8oK300eF8GC6n+GRzCMXds
         8ykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KINPyzTZu6/Wo4CkiB3sGCQF2+FkTO2UpELVAZQ1Ibw=;
        b=gcAIDcSoi8CmL+UPTmoUwhEj44TAOeCQ/g5jnbD3xlSAp7xrbkgyxdpK6sx/9XB5cm
         7+7o722sSqt9TG+T5LFJqRKU6g0JKcSPgCm42Mm+AZUY4BdMqIO2DyRDKIHnDlls5zMt
         mhAzu9XuqomdYwMEUJ/WI9CwPYkUMhzNGFetVjjATnpxk3f390CsaR8VGcqfXKQYMMlT
         LId9U1zCH/53ANO4iwniEOjxDILPCYRdyoaGxog6f2kZrIFWD79vh+Q+DUDk9lPjkcz7
         4ZbF9stWbCmqyKiZ1JK+YLHTjFgteH6cDmwAPzAXMn5b6QX9pSET+TSG62S6mAqlKnra
         HmlA==
X-Gm-Message-State: AGi0PuZNOw/qTatBj3nb1a0fgiEyZO2bitjpXffRAsSV9UuW5zTBPj/2
        P7GfMqtWi6mjLzmV9pbSXjQJFA==
X-Google-Smtp-Source: APiQypKUrzG0zoVzDZ24k+7SL5qBRAU0VWvjE3zrxyX9D2ozUTNqESbYJy0Nl8QIcNANUBok9oWnjw==
X-Received: by 2002:aed:208e:: with SMTP id 14mr21012568qtb.335.1586960747811;
        Wed, 15 Apr 2020 07:25:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n67sm13011905qte.79.2020.04.15.07.25.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 15 Apr 2020 07:25:46 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jOiz4-0005tF-GL; Wed, 15 Apr 2020 11:25:46 -0300
Date:   Wed, 15 Apr 2020 11:25:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Peter Xu <peterx@redhat.com>, Brian Geffon <bgeffon@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sonny Rao <sonnyrao@google.com>
Subject: Re: Userfaultfd doesn't seem to break out of poll on fd close
Message-ID: <20200415142546.GO5100@ziepe.ca>
References: <CADyq12wPW69ovpW4akDY5PGBbrvnwsLO86=sSKTU4CB3dNwG3Q@mail.gmail.com>
 <20200414214516.GA182757@xz-x1>
 <20200415031602.22348-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415031602.22348-1-hdanton@sina.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:16:02AM +0800, Hillf Danton wrote:
> 
> On Tue, 14 Apr 2020 19:34:10 -0300 Jason Gunthorpe wrote:
> > 
> > On Tue, Apr 14, 2020 at 05:45:16PM -0400, Peter Xu wrote:
> > > On Sun, Apr 12, 2020 at 01:10:40PM -0700, Brian Geffon wrote:
> > > > Hi,
> > > > It seems that userfaultfd isn't woken from a poll when the file
> > > > descriptor is closed. It seems that it should be from the code in
> > > > userfault_ctx_release, but it appears that's not actually called
> > > > immediately. I have a simple standalone example that shows this
> > > > behavior. It's straight forward: one thread creates a userfaultfd and
> > > > then closes it after a second thread has entered a poll syscall, some
> > > > abbreviated strace output is below showing this and the code can be
> > > > seen here: https://gist.github.com/bgaff/9a8fbbe8af79c0e18502430d416df77e
> > > > 
> > > > Given that it's probably very common to have a dedicated thread remain
> > > > blocked indefinitely in a poll(2) waiting for faults there must be a
> > > > way to break it out early when it's closed. Am I missing something?
> > > 
> > > Hi, Brian,
> > > 
> > > I might be wrong below, just to share my understanding...
> > > 
> > > IMHO a well-behaved userspace should not close() on a file descriptor
> > > if it's still in use within another thread.  In this case, the poll()
> > > thread is still using the userfaultfd handle
> > 
> > I also don't think concurrant close() on a file descriptor that is
> > under poll() is well defined, or should be relied upon.
> > 
> > > IIUC userfaultfd_release() is only called when the file descriptor
> > > destructs itself.  But shouldn't the poll() take a refcount of that
> > > file descriptor too before waiting?  Not sure userfaultfd_release() is
> > > the place to kick then, because if so, close() will only decrease the
> > > fd refcount from 2->1, and I'm not sure userfaultfd_release() will be
> > > triggered.
> > 
> > This is most probably true.
> > 
> > eventfd, epoll and pthread_join is the robust answer to these
> > problems.
> > 
> 
> See the difference EPOLLHUP makes.

The whole idea is completely racey:

          CPU1                            CPU2                  CPU3
 fds[i]->fd = userfaultfd;
 while()
                                       close(userfaultfd)
                                       pthread_join()
                                                            someother_fd = open()
                                                            userfaultfd == someother_fd
     poll(fds)   // <- Still sleeps

The kernel should not be trying to wake poll from fd release, and
userspace should not close a FD that is currently under poll.

Besides, it really does look like poll holds the fget while doing its
work (see poll_freewait), so fops release() won't be called anyhow..

Jason
