Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455F5C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 102A6206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgIAKHs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:07:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42428 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgIAKHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:07:47 -0400
Received: from ip5f5af70b.dynamic.kabel-deutschland.de ([95.90.247.11] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kD3CX-0007Aq-NJ; Tue, 01 Sep 2020 10:07:41 +0000
Date:   Tue, 1 Sep 2020 12:07:41 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        syzbot <syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, wad@chromium.org
Subject: Re: memory leak in do_seccomp
Message-ID: <20200901100741.wx33nrfi5mrbxudd@wittgenstein>
References: <000000000000e5ea9e05ac9d16c1@google.com>
 <000000000000df80ae05ae244c2b@google.com>
 <202008311620.AC4A7047D@keescook>
 <20200901000915.GA564594@cisco>
 <20200901011459.GA583718@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200901011459.GA583718@cisco>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 07:14:59PM -0600, Tycho Andersen wrote:
> On Mon, Aug 31, 2020 at 06:09:15PM -0600, Tycho Andersen wrote:
> > On Mon, Aug 31, 2020 at 04:25:35PM -0700, Kees Cook wrote:
> > > On Sun, Aug 30, 2020 at 08:50:15PM -0700, syzbot wrote:
> > > > syzbot has found a reproducer for the following issue on:
> > > > 
> > > > HEAD commit:    dcc5c6f0 Merge tag 'x86-urgent-2020-08-30' of git://git.ke..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=10b297d5900000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=903b9fecc3c6d231
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3ad9614a12f80994c32e
> > > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14649561900000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118aacc1900000
> > > > 
> > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > Reported-by: syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com
> > > > 
> > > > executing program
> > > > executing program
> > > > executing program
> > > > executing program
> > > > executing program
> > > > BUG: memory leak
> > > > unreferenced object 0xffff88811ba93600 (size 64):
> > > >   comm "syz-executor680", pid 6503, jiffies 4294951104 (age 21.940s)
> > > >   hex dump (first 32 bytes):
> > > >     00 00 00 00 00 00 00 00 08 36 a9 1b 81 88 ff ff  .........6......
> > > >     08 36 a9 1b 81 88 ff ff 11 ce 98 89 3a d5 b4 8f  .6..........:...
> > > >   backtrace:
> > > >     [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
> > > >     [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
> > > >     [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
> > > >     [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
> > > >     [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
> > > >     [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> > > >     [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > 
> > > I haven't narrowed this down yet (and it *might* be a false positive),
> > > but it looks like this is filter->notif. The only way that's possible is
> > > if seccomp_notify_release() was never called *and* seccomp_filter_free()
> > > got called... which would imply a reference counting problem. The way
> > > there doesn't jump out at me yet, but I haven't yet decoded the C
> > > reproducer into the actual seccomp arguments, etc.
> > 
> > Looks like it's just a bunch of threads in the same thread group
> > trying to install a filter with TSYNC and NEW_LISTENER turned on. Does
> > the patch below look reasonable?
> > 
> > I didn't send it separately since I'm in the process of switching my
> > e-mail address to tycho@tycho.pizza; let this e-mail serve as proof
> > that that e-mail really is me too :). I can send it the normal way if
> > it looks good.
> > 
> > 
> > From d497e787e8e1b3e8b9230fdc4c9802616709c920 Mon Sep 17 00:00:00 2001
> > From: Tycho Andersen <tycho@tycho.pizza>
> > Date: Mon, 31 Aug 2020 17:55:07 -0600
> > Subject: [PATCH] seccomp: don't leak memory when filter install races
> > 
> > In seccomp_set_mode_filter() with TSYNC | NEW_LISTENER, we first initialize
> > the listener fd, then check to see if we can actually use it later in
> > seccomp_may_assign_mode(), which can fail if anyone else in our thread
> > group has installed a filter and caused some divergence. If we can't, we
> > partially clean up the newly allocated file: we put the fd, put the file,
> > but don't actually clean up the *memory* that was allocated at
> > filter->notif. Let's clean that up too.
> > 
> > Fixes: 51891498f2da ("seccomp: allow TSYNC and USER_NOTIF together")
> > Reported-by: syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com
> > Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
> > ---
> >  kernel/seccomp.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > index 3ee59ce0a323..21a76127833f 100644
> > --- a/kernel/seccomp.c
> > +++ b/kernel/seccomp.c
> > @@ -1581,6 +1581,8 @@ static long seccomp_set_mode_filter(unsigned int flags,
> >  			listener_f->private_data = NULL;
> >  			fput(listener_f);
> >  			put_unused_fd(listener);
> > +			kfree(filter->notif);
> > +			filter->notif = NULL;
> 
> Oof, actually this isn't quite right. It should be s/filter/prepared/g.
> I can fix that and send out a real patch that's actually tested at
> some point tomorrow.

Please do. :)
Do we have tests for this scenario in the selftests, Tycho?

Christian
