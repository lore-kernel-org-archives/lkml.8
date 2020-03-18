Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D41EC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B6CE2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="Do8Uytcv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCRKQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:16:19 -0400
Received: from mail2.protonmail.ch ([185.70.40.22]:35756 "EHLO
        mail2.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgCRKQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:16:18 -0400
Date:   Wed, 18 Mar 2020 10:16:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1584526575;
        bh=01MHuTHqNXmoKioUDGcRkUpZS1pvvS0nJPIk9ir/Q0Y=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=Do8UytcvmJJ8nANDCqp720vh0trtOLOccnZxDiiYcjdYwVY7VHb35kATIoegxJAOB
         q/m9/c9sSBh8waQIyHnmNZNQkI3C8bVg+CvoDVPdQOsFZ2PlRfziGvAHWiRGCCb0Qs
         G/Hzl5QJG+zYF6yuj5v0kslrUDUA52c7rIlw9CEA=
To:     Christian Brauner <christian.brauner@ubuntu.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "christian@brauner.io" <christian@brauner.io>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: SO_PEERCRED and pidfd
Message-ID: <WuCKXl7CWZrfvKTWuYiwL6tkPq2YgA_j1lyVVczFB48s8ozWz_setJou9JO-VqsL2kJtRV8r4yOvyQhI5LsdCdIaSKYZpY1_9Bf3DwpQIMg=@emersion.fr>
In-Reply-To: <20200317181843.iq3jaboqid2xfktv@wittgenstein>
References: <go0RLOS7_DdxyAmfrDR38QPUloZuUtiFdXe2Ey3EkGGuvmW7z18Dvt4fY1qZ1k-Y75-YZSxqVWnZpWRGN7TZ6OPbDczfL7HI25bXLIYq1y4=@emersion.fr>
 <20200317181843.iq3jaboqid2xfktv@wittgenstein>
Feedback-ID: FsVprHBOgyvh0T8bxcZ0CmvJCosWkwVUg658e_lOUQMnA9qynD8O1lGeniuBDfPSkDAUuhiKfOIXUZBfarMyvA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, March 17, 2020 7:18 PM, Christian Brauner <christian.brauner@ub=
untu.com> wrote:

> On Tue, Mar 17, 2020 at 05:54:47PM +0000, Simon Ser wrote:
>
> > Hi all,
> > I'm a Wayland developer and I've been working on protocol security,
> > which involves identifying the process on the other end of a Unix
> > socket [1]. This is already done by e.g. D-Bus via the PID, however
> > this is racy [2].
> > Getting the PID is done via SO_PEERCRED. Would there be interest in
> > adding a way to get a pidfd out of a Unix socket to fix the race?
>
> Puh, I knew this would happen. I've been asked to add this feature by
> the systemd people as well and also at a conference last year. And
> honestly, I don't know yet. pidfds right now are mostly about
> guaranteeing (stable) identity and they come with the necessary
> restrictions in place to prevent shenanigans (such as signaling across
> pid namespaces a restriction I'd like to lift at some point). But I
> have been thinking about attaching some capability like features to
> pidfds soon as that has been an even more frequent request. At that
> point having them receivable this way might be problematic unless we put
> restrictions in place.

Wouldn't this new mechanism just be an atomic getsockopt+pidfd_open?
(It would make sure the process is still alive of course.)

Can you elaborate wrt. capabilities? I'm not sure I understand what
that means.

> I would like to go through codepaths for SO_PEERCRED as I don't have
> them in my head and so can't really say something definitely about this
> just now.
> (From the top of my head it seems that if we were to do this it might
> need to be a separate SO_* flag? Mainly so people don't suddenly receive
> fds they didn't expect.)

Yeah, this would need to be either a separate SO_* flag or a completely
different thing to prevent surprises.
