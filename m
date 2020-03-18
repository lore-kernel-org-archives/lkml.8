Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F13AC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E724220773
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="dChiNCzE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgCRKbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:31:07 -0400
Received: from mail-40134.protonmail.ch ([185.70.40.134]:34180 "EHLO
        mail-40134.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCRKbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:31:07 -0400
Date:   Wed, 18 Mar 2020 10:31:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1584527465;
        bh=7jUCUS9rjM4uvvyyComE9uzYxPKhsWdaY7hfP//srZM=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=dChiNCzEC1a/RrVWO7I1puaF/xzXMYsqUPuF6VlpoIg6zeM+CYBlR+dDptveKeIxY
         vLZDlEtGJIVJgpMVhe5ftJSEu2d0YqK/3G79RnZQgFMm9zC8VZSZ4azoe9u83Kj5YV
         qkvsihB+U24AcNVQ8SznA7fbsv3SoUa88AcKd3Yk=
To:     "ebiederm@xmission.com" <ebiederm@xmission.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "oleg\\@redhat.com" <oleg@redhat.com>,
        "christian\\@brauner.io" <christian@brauner.io>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: SO_PEERCRED and pidfd
Message-ID: <1Q35NFfgidxjWwXdBPA4EBehI5cyiQ2g47PjP_twMt_AlhcwWIzFK45Dyaw0bKT1KHPsbUAOXbfpvZODuRSd19LVI0tPBPsVblfSYy_YZEg=@emersion.fr>
In-Reply-To: <87d09akduh.fsf@x220.int.ebiederm.org>
References: <go0RLOS7_DdxyAmfrDR38QPUloZuUtiFdXe2Ey3EkGGuvmW7z18Dvt4fY1qZ1k-Y75-YZSxqVWnZpWRGN7TZ6OPbDczfL7HI25bXLIYq1y4=@emersion.fr>
 <87d09akduh.fsf@x220.int.ebiederm.org>
Feedback-ID: FsVprHBOgyvh0T8bxcZ0CmvJCosWkwVUg658e_lOUQMnA9qynD8O1lGeniuBDfPSkDAUuhiKfOIXUZBfarMyvA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 17, 2020 7:58 PM, <ebiederm@xmission.com> wrote:

> Simon Ser contact@emersion.fr writes:
>
> > Hi all,
> > I'm a Wayland developer and I've been working on protocol security,
> > which involves identifying the process on the other end of a Unix
> > socket 1. This is already done by e.g. D-Bus via the PID, however
> > this is racy 2.
> > Getting the PID is done via SO_PEERCRED. Would there be interest in
> > adding a way to get a pidfd out of a Unix socket to fix the race?
>
> I think we are passing a struct pid through the socket metadata.
> So it should be technically feasible.
>
> However it does come with some long term mainteance costs.
>
> The big question is what is a pid being used for when being passed.
> Last I looked most of the justifications for using metadata like that
> with unix domain sockets led to patterns of trust that were also
> exploitable.
>
> Looking at the proposale in 1 even if you have race free access
> to /proc/<pid>/exe using pidfds it is possible to change /proc/<pid>/exe
> to be anything you can map so that seems to be an example of a problem.

/proc/<pid>/exe is a symlink. It doesn't seem like it's possible to
unlink it and re-link it to something else (fails with EPERM).

Is there a way to do this?

> So it would be very nice to see a use case spelled out where
> the pid reuse race mattered, and that trusting a pid makes sense.

The use-case is identifying which process is at the other end of the
socket. Once the process is identified, security rules can be applied.
For instance a Wayland compositor might give access to a
screen capture interface if the program is a trusted screen shooter.

Some want to get the full path to the executable, and read the
/proc/<pid>/exe symlink. Some want to read a special file created at
the root of the process' file system namespace, and access
/proc/<pid>/root.

> I have to dash but I will think about this and see if I can give a
> concrete example of using a capability model. Other than the current
> one that works (handing out trusted sockets at the logical beginning of
> time). Though frankly I am not certain there is anything much better
> than that.
