Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD401C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6B82076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 11:56:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgCRL4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 07:56:41 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35424 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgCRL4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 07:56:41 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jEXJN-0008Cd-TD; Wed, 18 Mar 2020 11:56:38 +0000
Date:   Wed, 18 Mar 2020 12:56:37 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Simon Ser <contact@emersion.fr>
Cc:     "ebiederm@xmission.com" <ebiederm@xmission.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "oleg\\@redhat.com" <oleg@redhat.com>,
        "christian\\@brauner.io" <christian@brauner.io>
Subject: Re: SO_PEERCRED and pidfd
Message-ID: <20200318115637.qffmwvtr4uqanyvc@wittgenstein>
References: <go0RLOS7_DdxyAmfrDR38QPUloZuUtiFdXe2Ey3EkGGuvmW7z18Dvt4fY1qZ1k-Y75-YZSxqVWnZpWRGN7TZ6OPbDczfL7HI25bXLIYq1y4=@emersion.fr>
 <87d09akduh.fsf@x220.int.ebiederm.org>
 <1Q35NFfgidxjWwXdBPA4EBehI5cyiQ2g47PjP_twMt_AlhcwWIzFK45Dyaw0bKT1KHPsbUAOXbfpvZODuRSd19LVI0tPBPsVblfSYy_YZEg=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1Q35NFfgidxjWwXdBPA4EBehI5cyiQ2g47PjP_twMt_AlhcwWIzFK45Dyaw0bKT1KHPsbUAOXbfpvZODuRSd19LVI0tPBPsVblfSYy_YZEg=@emersion.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 10:31:00AM +0000, Simon Ser wrote:
> On Tuesday, March 17, 2020 7:58 PM, <ebiederm@xmission.com> wrote:
> 
> > Simon Ser contact@emersion.fr writes:
> >
> > > Hi all,
> > > I'm a Wayland developer and I've been working on protocol security,
> > > which involves identifying the process on the other end of a Unix
> > > socket 1. This is already done by e.g. D-Bus via the PID, however
> > > this is racy 2.
> > > Getting the PID is done via SO_PEERCRED. Would there be interest in
> > > adding a way to get a pidfd out of a Unix socket to fix the race?
> >
> > I think we are passing a struct pid through the socket metadata.
> > So it should be technically feasible.
> >
> > However it does come with some long term mainteance costs.
> >
> > The big question is what is a pid being used for when being passed.
> > Last I looked most of the justifications for using metadata like that
> > with unix domain sockets led to patterns of trust that were also
> > exploitable.
> >
> > Looking at the proposale in 1 even if you have race free access
> > to /proc/<pid>/exe using pidfds it is possible to change /proc/<pid>/exe
> > to be anything you can map so that seems to be an example of a problem.
> 
> /proc/<pid>/exe is a symlink. It doesn't seem like it's possible to
> unlink it and re-link it to something else (fails with EPERM).
> 
> Is there a way to do this?

Not while the process is running afaik. Given the right permission there
are some tricks you can do to overwrite the host binary and trick
someone into rexecuting itself and thus the ovewritten binary (There's
been an exploit in runC around this which Aleksa and I fixed a while
back.) but as long as the process is running you can't overwrite it
(unless there are bugs).

> 
> > So it would be very nice to see a use case spelled out where
> > the pid reuse race mattered, and that trusting a pid makes sense.
> 
> The use-case is identifying which process is at the other end of the
> socket. Once the process is identified, security rules can be applied.
> For instance a Wayland compositor might give access to a
> screen capture interface if the program is a trusted screen shooter.
> 
> Some want to get the full path to the executable, and read the
> /proc/<pid>/exe symlink. Some want to read a special file created at
> the root of the process' file system namespace, and access
> /proc/<pid>/root.

You can translate solely from a pidfd to a pid and then open /proc/<pid>
and verify that the directory you just opened referes to the same
process as the pidfd. That's illustrated in a sample program I wrote.
It's located in the kernel sources at:

samples/pidfd/pidfd_metadata.c

specifically the pidfd_metadata_fd() helper.

If you only have the pidfd and want to know the pid of the process you
can translate from the fd's fdinfo file to the pid. That's e.g. how
systemd is doing it too. See
https://github.com/systemd/systemd/blob/06ae8800d0bd9f8b01df7443daec37f90708bd84/src/basic/process-util.c#L1499
If the process has already exited _and_ been reaped fdinfo will show -1
as pid. The format of the fdinfo file matches the output for the Pid:
and NSpid: fields in the /prop/<pid>/status file.
