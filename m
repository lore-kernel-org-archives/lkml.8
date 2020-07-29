Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D5BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DCB5206D4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 06:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgG2Gz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 02:55:27 -0400
Received: from 4.mo179.mail-out.ovh.net ([46.105.36.149]:42408 "EHLO
        4.mo179.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2Gz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 02:55:26 -0400
Received: from player711.ha.ovh.net (unknown [10.108.42.75])
        by mo179.mail-out.ovh.net (Postfix) with ESMTP id 694B4173B78
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 08:38:32 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player711.ha.ovh.net (Postfix) with ESMTPSA id AB08514A1AD8F;
        Wed, 29 Jul 2020 06:38:23 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-105G006896df29f-f4f3-493b-ab9a-d0c6f23d8bcf,
                    A40F6FE0CFFE28C23AB4AFBB3D5D665E11D39731) smtp.auth=groug@kaod.org
Date:   Wed, 29 Jul 2020 08:38:22 +0200
From:   Greg Kurz <groug@kaod.org>
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>,
        v9fs-developer@lists.sourceforge.net,
        Latchesar Ionkov <lucho@ionkov.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [V9fs-developer] [PATCH kernel] 9p/trans_fd: Check file mode at
 opening
Message-ID: <20200729083822.66e165ed@bahia.lan>
In-Reply-To: <20200729061449.GA19682@nautica>
References: <20200728124129.130856-1-aik@ozlabs.ru>
        <20200728194235.52660c08@bahia.lan>
        <20200729061449.GA19682@nautica>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1830713248816142592
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrieefgddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveehieetvdettdfhiefhueetheekheejgfdtvddthfffuefgueduvefgveeijeegnecuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejuddurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Jul 2020 08:14:49 +0200
Dominique Martinet <asmadeus@codewreck.org> wrote:

> Greg Kurz wrote on Tue, Jul 28, 2020:
> > > The "fd" transport layer uses 2 file descriptors passed externally
> > > and calls kernel_write()/kernel_read() on these. If files were opened
> > > without FMODE_WRITE/FMODE_READ, WARN_ON_ONCE() will fire.
> 
> There already is a fix in linux-next as a39c46067c84 ("net/9p: validate
> fds in p9_fd_open")
> 
> > > This adds file mode checking in p9_fd_open; this returns -EBADF to
> > > preserve the original behavior.
> > 
> > So this would cause open() to fail with EBADF, which might look a bit

Oops... this seems to rather end up in mount(). :)

> > weird to userspace since it didn't pass an fd... Is this to have a
> > different error than -EIO that is returned when either rfd or wfd
> > doesn't point to an open file descriptor ? If yes, why do we care ?
> 
> FWIW the solution taken just returns EIO as it would if an invalid fd
> was given, but since it did pass an fd EBADF actually makes sense to me?
> 

POSIX says:

https://pubs.opengroup.org/onlinepubs/9699919799/functions/V2_chap02.html

[EBADF]
Bad file descriptor. A file descriptor argument is out of range, refers to
no open file, or a read (write) request is made to a file that is only open
for writing (reading).

It seems that EBADF would be appropriate for both the existing and the
new error path.

> However to the second question I'm not sure I care :)
> 
> > > Found by syzkaller.
> 
> I'm starting to understand where David comment came from the other day,
> I guess it's still time to change my mind and submit to linus now I've
> had time to test it...
> 

