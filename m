Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3D6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B01021D95
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgG2GPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbgG2GPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:15:08 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06BEC061794;
        Tue, 28 Jul 2020 23:15:07 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 31395C01F; Wed, 29 Jul 2020 08:15:04 +0200 (CEST)
Date:   Wed, 29 Jul 2020 08:14:49 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Greg Kurz <groug@kaod.org>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [V9fs-developer] [PATCH kernel] 9p/trans_fd: Check file mode at
 opening
Message-ID: <20200729061449.GA19682@nautica>
References: <20200728124129.130856-1-aik@ozlabs.ru>
 <20200728194235.52660c08@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728194235.52660c08@bahia.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kurz wrote on Tue, Jul 28, 2020:
> > The "fd" transport layer uses 2 file descriptors passed externally
> > and calls kernel_write()/kernel_read() on these. If files were opened
> > without FMODE_WRITE/FMODE_READ, WARN_ON_ONCE() will fire.

There already is a fix in linux-next as a39c46067c84 ("net/9p: validate
fds in p9_fd_open")

> > This adds file mode checking in p9_fd_open; this returns -EBADF to
> > preserve the original behavior.
> 
> So this would cause open() to fail with EBADF, which might look a bit
> weird to userspace since it didn't pass an fd... Is this to have a
> different error than -EIO that is returned when either rfd or wfd
> doesn't point to an open file descriptor ? If yes, why do we care ?

FWIW the solution taken just returns EIO as it would if an invalid fd
was given, but since it did pass an fd EBADF actually makes sense to me?

However to the second question I'm not sure I care :)

> > Found by syzkaller.

I'm starting to understand where David comment came from the other day,
I guess it's still time to change my mind and submit to linus now I've
had time to test it...

-- 
Dominique
