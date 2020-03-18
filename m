Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B44C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC7920724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbgCRMVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:21:47 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36686 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCRMVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:21:47 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jEXhh-00032O-1h; Wed, 18 Mar 2020 12:21:45 +0000
Date:   Wed, 18 Mar 2020 13:21:44 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Simon Ser <contact@emersion.fr>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "christian@brauner.io" <christian@brauner.io>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
Subject: Re: SO_PEERCRED and pidfd
Message-ID: <20200318122144.bzeb647w7ytloetn@wittgenstein>
References: <go0RLOS7_DdxyAmfrDR38QPUloZuUtiFdXe2Ey3EkGGuvmW7z18Dvt4fY1qZ1k-Y75-YZSxqVWnZpWRGN7TZ6OPbDczfL7HI25bXLIYq1y4=@emersion.fr>
 <20200317181843.iq3jaboqid2xfktv@wittgenstein>
 <WuCKXl7CWZrfvKTWuYiwL6tkPq2YgA_j1lyVVczFB48s8ozWz_setJou9JO-VqsL2kJtRV8r4yOvyQhI5LsdCdIaSKYZpY1_9Bf3DwpQIMg=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <WuCKXl7CWZrfvKTWuYiwL6tkPq2YgA_j1lyVVczFB48s8ozWz_setJou9JO-VqsL2kJtRV8r4yOvyQhI5LsdCdIaSKYZpY1_9Bf3DwpQIMg=@emersion.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 10:16:07AM +0000, Simon Ser wrote:
> On Tuesday, March 17, 2020 7:18 PM, Christian Brauner <christian.brauner@ubuntu.com> wrote:
> 
> > On Tue, Mar 17, 2020 at 05:54:47PM +0000, Simon Ser wrote:
> >
> > > Hi all,
> > > I'm a Wayland developer and I've been working on protocol security,
> > > which involves identifying the process on the other end of a Unix
> > > socket [1]. This is already done by e.g. D-Bus via the PID, however
> > > this is racy [2].
> > > Getting the PID is done via SO_PEERCRED. Would there be interest in
> > > adding a way to get a pidfd out of a Unix socket to fix the race?
> >
> > Puh, I knew this would happen. I've been asked to add this feature by
> > the systemd people as well and also at a conference last year. And
> > honestly, I don't know yet. pidfds right now are mostly about
> > guaranteeing (stable) identity and they come with the necessary
> > restrictions in place to prevent shenanigans (such as signaling across
> > pid namespaces a restriction I'd like to lift at some point). But I
> > have been thinking about attaching some capability like features to
> > pidfds soon as that has been an even more frequent request. At that
> > point having them receivable this way might be problematic unless we put
> > restrictions in place.
> 
> Wouldn't this new mechanism just be an atomic getsockopt+pidfd_open?
> (It would make sure the process is still alive of course.)

Yes, it would. My point was rather if pidfds mean something more than
identity at some point then we just need to make sure that you can only
get a getsockopt+pidfd_open(pid, 0) equivalent pidfd from it, i.e. one
without additional abilities (see below).

> 
> Can you elaborate wrt. capabilities? I'm not sure I understand what
> that means.

As a concrete example, think of it as root calling clone3() with e.g. an
additional flag PIDFD_GETFD which would stash the creds of the calling
process (in this example root) and when pidfd_getfd() is passed such a
pidfd it would use the creds of root instead of the calling threads
cred. This would e.g. allow a process to delegate the ability to
retrieve file descriptors from another task but nothing else.

> 
> > I would like to go through codepaths for SO_PEERCRED as I don't have
> > them in my head and so can't really say something definitely about this
> > just now.
> > (From the top of my head it seems that if we were to do this it might
> > need to be a separate SO_* flag? Mainly so people don't suddenly receive
> > fds they didn't expect.)
> 
> Yeah, this would need to be either a separate SO_* flag or a completely
> different thing to prevent surprises.
