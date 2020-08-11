Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36AE0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12D7320756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgHKVOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:14:05 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:33687 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKVOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:14:05 -0400
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id DF780C0003;
        Tue, 11 Aug 2020 21:14:00 +0000 (UTC)
Date:   Tue, 11 Aug 2020 14:13:58 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-kernel@vger.kernel.org,
        Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-doc@vger.kernel.org
Subject: Re: pidfd and O_NONBLOCK
Message-ID: <20200811211358.GA24721@localhost>
References: <20200811181236.GA18763@localhost>
 <20200811201045.jw2bc3yegrgrvnpz@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811201045.jw2bc3yegrgrvnpz@wittgenstein>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:10:45PM +0200, Christian Brauner wrote:
> On Tue, Aug 11, 2020 at 11:12:36AM -0700, Josh Triplett wrote:
> > As far as I can tell, O_NONBLOCK has no effect on a pidfd. When calling
> > waitid on a pidfd for a running process, it always blocks unless you
> > provide WNOHANG.
> > 
> > I don't think anything depends on that behavior. Would it be possible to
> > make O_NONBLOCK on a pidfd cause waitid on a running process to return
> > EWOULDBLOCK?
> > 
> > This would make it easier to use pidfd in some non-blocking event loops.
> 
> Hey Josh,
> 
> Just to see I did a _horrible_ draft (cf. [1]) and it seems doable to me
> and if you can provide a good rationale and a use-case then I think that
> would be ok.

Rationale and use case: there are some non-blocking event loop
libraries, such as the Rust async-io library, that help build
epoll-based event loops around file descriptors. Those libraries
automatically set O_NONBLOCK on the file descriptors they manage, and
they treat EWOULDBLOCK errno codes specially, with semantics like "call
this function, if it returns EWOULDBLOCK then don't call it again until
epoll says the fd is ready". If setting O_NONBLOCK on pidfd caused
waitid to return EWOULDBLOCK, such libraries would Just Work with very
little effort.

Also, pidfd_open should accept O_NONBLOCK as a flag, which in addition
to saving a call to fcntl would allow userspace to detect if this works.
(Even if you want to use fcntl to set it later, you can always just open
your own PID with pidfd_open and check if you get EINVAL to know that
your kernel doesn't support this.)

Thanks,
Josh Triplett
