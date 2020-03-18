Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6477CC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD4220774
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgCRNn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:43:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40435 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgCRNn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:43:26 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jEYya-0003l6-Pp; Wed, 18 Mar 2020 13:43:16 +0000
Date:   Wed, 18 Mar 2020 14:43:16 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Simon Ser <contact@emersion.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "christian@brauner.io" <christian@brauner.io>
Subject: Re: SO_PEERCRED and pidfd
Message-ID: <20200318134316.rtjyaxqmdkhwq4fi@wittgenstein>
References: <go0RLOS7_DdxyAmfrDR38QPUloZuUtiFdXe2Ey3EkGGuvmW7z18Dvt4fY1qZ1k-Y75-YZSxqVWnZpWRGN7TZ6OPbDczfL7HI25bXLIYq1y4=@emersion.fr>
 <87d09akduh.fsf@x220.int.ebiederm.org>
 <1Q35NFfgidxjWwXdBPA4EBehI5cyiQ2g47PjP_twMt_AlhcwWIzFK45Dyaw0bKT1KHPsbUAOXbfpvZODuRSd19LVI0tPBPsVblfSYy_YZEg=@emersion.fr>
 <87r1xplsku.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r1xplsku.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 08:07:29AM -0500, Eric W. Biederman wrote:
> Simon Ser <contact@emersion.fr> writes:
> 
> > On Tuesday, March 17, 2020 7:58 PM, <ebiederm@xmission.com> wrote:
> >
> >> Simon Ser contact@emersion.fr writes:
> >>
> >> > Hi all,
> >> > I'm a Wayland developer and I've been working on protocol security,
> >> > which involves identifying the process on the other end of a Unix
> >> > socket 1. This is already done by e.g. D-Bus via the PID, however
> >> > this is racy 2.
> >> > Getting the PID is done via SO_PEERCRED. Would there be interest in
> >> > adding a way to get a pidfd out of a Unix socket to fix the race?
> >>
> >> I think we are passing a struct pid through the socket metadata.
> >> So it should be technically feasible.
> >>
> >> However it does come with some long term mainteance costs.
> >>
> >> The big question is what is a pid being used for when being passed.
> >> Last I looked most of the justifications for using metadata like that
> >> with unix domain sockets led to patterns of trust that were also
> >> exploitable.
> >>
> >> Looking at the proposale in 1 even if you have race free access
> >> to /proc/<pid>/exe using pidfds it is possible to change /proc/<pid>/exe
> >> to be anything you can map so that seems to be an example of a problem.
> >
> > /proc/<pid>/exe is a symlink. It doesn't seem like it's possible to
> > unlink it and re-link it to something else (fails with EPERM).
> >
> > Is there a way to do this?
> 
> prctl(PR_SET_MM_MAP, ...);
> It is locked down a bit but not enough to trust it in general.

That at least requires CAP_SYS_ADMIN in the current user namespace. But
it seems potentially dangerous when you think about cross-user-namespace
interactions, e.g. execing a binary located on the host and doing
setns(mnt+user).

> 
> Further there are games I can play with ptrace where I can start an
> executable and control it, so that you think it is the expected
> executable calling the shots, when in fact it is the process acting
> as the debugger performing the work.
> 
> Plus there are the other million and ways known to hijack a setuid
> executable which also apply to this executable you would trust
> because of it's exe_link.
> 
> Even beyond that to have a trusted process it's entire life cycle needs
> to be trusted, so that you don't have the danger of someone unscrupulous
> hijacking the process with bad input.

Relying on /proc/<pid>/exe for anything has been a constant source of
bugs and is something we have warned against. The rexec trick we do for
both runC and lxc nowadays when attaching/running containers are
basically ways to ensure that you're executing an in-memory program that
has no attachment to the actual on-disk binary and is a result of
problems like this.

> 
> >> So it would be very nice to see a use case spelled out where
> >> the pid reuse race mattered, and that trusting a pid makes sense.
> >
> > The use-case is identifying which process is at the other end of the
> > socket. Once the process is identified, security rules can be applied.
> > For instance a Wayland compositor might give access to a
> > screen capture interface if the program is a trusted screen shooter.
> >
> > Some want to get the full path to the executable, and read the
> > /proc/<pid>/exe symlink. Some want to read a special file created at
> > the root of the process' file system namespace, and access
> > /proc/<pid>/root.
> 
> Once we reach the point of having a special file, it is much better
> to pass that special file.  Or possibly something derived from the
> special file in a zero knowledge proof sort of way, to prove you
> are a trusted process.
> 
> Passing a file descriptor as a token the process is the trusted
> process, is a perfectly fine way to provide proof and unix
> domains sockets have supported that from day one.

The use-case that e.g. comes from system daemons is that they need to
talk to e.g. glibc's syslog() api. And daemon loggers need to know who
they are talking to and that needs to be race-free. And they don't get
sent fds. Assuming we can patch glibc and all loggers to send a
pidfd and put a contract in place saying any message without a pidfd
sent along or a pidfd that is not referring to the SO_PEERCREDs uid
sent along will be rejected still feels wrong. In such cases the daemon
wants to be in control and requested the credentials be given to him. So
I can see the use for another SO_*
