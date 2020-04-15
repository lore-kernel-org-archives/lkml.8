Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5C1C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64109208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GxDA6hmp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414641AbgDOPRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1414618AbgDOPRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:17:38 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A84C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:17:38 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i7so5364982edq.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AznA+h/3cK3KAncERuNAqxLwQ846WsMdLs+fjVSErA0=;
        b=GxDA6hmpKkfHchiJxVFamypNBy9Ctt62byY4TTPc1XlJ0qyqECgO+nsJJaVxTCfbzm
         GrhlgD0Q3Ubail7kT1oQFd+yI/ijySpO1QHMOpX0ldAJXCRMenSJgjoEWrCGq2dIv3Ue
         Xy4tJM1Or2hymiw/uLyEvbkbe1g2yYa+TOXtoP+Re2eLm8IdqqWXhPcnd9zyWQmtQveO
         LoI8Ru71oz00dJTMAH2pSZX68zD5IkDp+X/3d4bPz+tUGkIxTi9xlI1cU2iIv2M9PmHI
         3fnmacwk9yrP8xAZEqxpyGuf+XVv5sh/qcj6gJNnMyk4/WU2nOzHMrD1FMA1V0JRUSdG
         8fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AznA+h/3cK3KAncERuNAqxLwQ846WsMdLs+fjVSErA0=;
        b=r0foBWjfd2NjX9kxuXC+iszrOjqbb9xSQ8zFuhXUjwaptTJxRM/YT3B0yVckxdzrns
         W0ofMxE899imGK87iz2vfNRPwA+rGb+YqEPz146byW5nYIGXtop1qycYyOeF4i4HJgqP
         8o+ndoZU4IisY1zVGkHJ79WBjUkOB63BpzpWBwQBixiIZoDTpnASB/iRft+sqIcWAaY1
         cKxLWyCEABHkXMXAeFVPzUN0ttX/OCVMBRAh7wa3TOdM20w/MfAI+vdPodD9H0SGQHAm
         fxFN8fU8Uw3XUQNlJltxcasIG9IodCkLBg9X+jx4nBCA0LzkqliohPAWoNsht+/GXaGH
         vxxg==
X-Gm-Message-State: AGi0PuYN1xguWyHGZjWZlmmcgtb0AQWCCisE8jtG54fgrwtnsMqQ87+E
        AxOgV0DSdQF6epri7nP+h1z+lYgks7Z6y006EtbI/g==
X-Google-Smtp-Source: APiQypIyXYuD51TqYcp8Iz4snx+efQhAWjgyZlpjaMQAaR71QpFDNy43sXGGCLcgx7ucgW6/0l+z1HEcsfqXykBgiPw=
X-Received: by 2002:a17:906:f1c4:: with SMTP id gx4mr5284444ejb.171.1586963856720;
 Wed, 15 Apr 2020 08:17:36 -0700 (PDT)
MIME-Version: 1.0
References: <CADyq12wPW69ovpW4akDY5PGBbrvnwsLO86=sSKTU4CB3dNwG3Q@mail.gmail.com>
 <20200414214516.GA182757@xz-x1> <20200415031602.22348-1-hdanton@sina.com> <20200415142546.GO5100@ziepe.ca>
In-Reply-To: <20200415142546.GO5100@ziepe.ca>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 15 Apr 2020 08:16:59 -0700
Message-ID: <CADyq12w2ZG+VehAuS763Zb1xJB8SfEbOHkopMPhC2hVqhM5yzw@mail.gmail.com>
Subject: Re: Userfaultfd doesn't seem to break out of poll on fd close
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Hillf Danton <hdanton@sina.com>, Peter Xu <peterx@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Sonny Rao <sonnyrao@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks everyone for the insights!




On Wed, Apr 15, 2020 at 7:25 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Apr 15, 2020 at 11:16:02AM +0800, Hillf Danton wrote:
> >
> > On Tue, 14 Apr 2020 19:34:10 -0300 Jason Gunthorpe wrote:
> > >
> > > On Tue, Apr 14, 2020 at 05:45:16PM -0400, Peter Xu wrote:
> > > > On Sun, Apr 12, 2020 at 01:10:40PM -0700, Brian Geffon wrote:
> > > > > Hi,
> > > > > It seems that userfaultfd isn't woken from a poll when the file
> > > > > descriptor is closed. It seems that it should be from the code in
> > > > > userfault_ctx_release, but it appears that's not actually called
> > > > > immediately. I have a simple standalone example that shows this
> > > > > behavior. It's straight forward: one thread creates a userfaultfd and
> > > > > then closes it after a second thread has entered a poll syscall, some
> > > > > abbreviated strace output is below showing this and the code can be
> > > > > seen here: https://gist.github.com/bgaff/9a8fbbe8af79c0e18502430d416df77e
> > > > >
> > > > > Given that it's probably very common to have a dedicated thread remain
> > > > > blocked indefinitely in a poll(2) waiting for faults there must be a
> > > > > way to break it out early when it's closed. Am I missing something?
> > > >
> > > > Hi, Brian,
> > > >
> > > > I might be wrong below, just to share my understanding...
> > > >
> > > > IMHO a well-behaved userspace should not close() on a file descriptor
> > > > if it's still in use within another thread.  In this case, the poll()
> > > > thread is still using the userfaultfd handle
> > >
> > > I also don't think concurrant close() on a file descriptor that is
> > > under poll() is well defined, or should be relied upon.
> > >
> > > > IIUC userfaultfd_release() is only called when the file descriptor
> > > > destructs itself.  But shouldn't the poll() take a refcount of that
> > > > file descriptor too before waiting?  Not sure userfaultfd_release() is
> > > > the place to kick then, because if so, close() will only decrease the
> > > > fd refcount from 2->1, and I'm not sure userfaultfd_release() will be
> > > > triggered.
> > >
> > > This is most probably true.
> > >
> > > eventfd, epoll and pthread_join is the robust answer to these
> > > problems.
> > >
> >
> > See the difference EPOLLHUP makes.
>
> The whole idea is completely racey:
>
>           CPU1                            CPU2                  CPU3
>  fds[i]->fd = userfaultfd;
>  while()
>                                        close(userfaultfd)
>                                        pthread_join()
>                                                             someother_fd = open()
>                                                             userfaultfd == someother_fd
>      poll(fds)   // <- Still sleeps
>
> The kernel should not be trying to wake poll from fd release, and
> userspace should not close a FD that is currently under poll.
>
> Besides, it really does look like poll holds the fget while doing its
> work (see poll_freewait), so fops release() won't be called anyhow..
>
> Jason
