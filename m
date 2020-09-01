Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7038CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22BEF2065F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="kyzLsvsd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kwL7+qsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730746AbgIAPbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 11:31:49 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:32775 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729950AbgIAP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:27:13 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id 2B700F6C;
        Tue,  1 Sep 2020 11:26:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 01 Sep 2020 11:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=GuDHQ4jVsuyrASuXaWUaz8DMdSW
        QZztw33zChk93mxE=; b=kyzLsvsdDcacF8pFU86UmtFvk0MSWiTnlGA2qrn9RRJ
        zZNK8kyeZnU/mNCHRMCmKaQRGhs3/sv3CHWcnID2qv4wkgTeUidPTyhASJlx2+xV
        5zHYQq7NFT6mnLyO5Rqu6+4xI3w2aMdMebw9bSVA4WOklUqHIJnjrNJ9SQ0rUSxL
        LnTRsDm3mZxUBmJBE6/S6zersMgGr+d8e/NwBbTCcQss5+jWeU1JgfRVCZ2woVwO
        4w26sgIe1ZZvQcHF4A0mAB4OmJq9ITzi0h9wzlC65ESLIJs+HxnflGWloc7YVq95
        JR77/ENyhu9Q2VT8xHt4JGOyIOImTuBO2Elk3+HkS2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=GuDHQ4
        jVsuyrASuXaWUaz8DMdSWQZztw33zChk93mxE=; b=kwL7+qsYEGxJwMW3FdiHYY
        FXysChSQsgFK0Ntfy8NwvfRLP2sSqzwBG/n8eOpaTuzMeWuq+bU/nR5laLgw1wYq
        BKeOC4iMYJaPnWmEg/oMzN3zm64Rm4Y/H9E5nixgcRi84JmiH1VmsTTB/9vfNUmF
        /mAbe2t9iwJA6RAjS6GIoSIDysTB4Bwd3KvoEszpQ8H9sxNx3onuZDs+MVNsz1w/
        RnGE83NdwCHAa16FbLNmCIEeXztlziX2yaL7jcOn55UriOa7kQ/d0po4nEpcNoGT
        zZF+hP1jPUM8kXIo8lcgEhfz8VCGl2DQQoE8ySTyBSIgWStPtzViCBedf+e7Ar5w
        ==
X-ME-Sender: <xms:HWhOXwRXCfPFydy2HDYAjRIHz6QD7yrytrI5WYUinAlpejr1oxaMCQ>
    <xme:HWhOX9zAzdaATr6c5sbJEJLRS6DiwkzKOe6kOixbR--alw0zj_Dmet1gMgW1oJYRT
    a7CPyLDkjQjs56pZ1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefjedgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvffukfhfgggtuggj
    sehttdertddttddvnecuhfhrohhmpefvhigthhhoucetnhguvghrshgvnhcuoehthigthh
    hosehthigthhhordhpihiiiigrqeenucggtffrrghtthgvrhhnpeffieegtdfhudeiveef
    iedtveevgeevhfejfeduieeivedvveetgfeuveejkeffudenucffohhmrghinheprghpph
    hsphhothdrtghomhenucfkphepuddvkedruddtjedrvdeguddrudejtdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthh
    hordhpihiiiigr
X-ME-Proxy: <xmx:HWhOX90dEdvrJlff7A1MJXbguOWUbdn_T0dgHlqkld9T-LTE94v5TQ>
    <xmx:HWhOX0CxvRna2WuaZexG6M5eK367_FCMJnzFDuWkEPlHhN_nzMxjEw>
    <xmx:HWhOX5i8R4Z3BygA_mepAW7D78HEqBQ7msDoEjrQB15XDaBzm4_dmg>
    <xmx:HmhOX5e25I7IPFW8tpQkckqA_Plycmdzn56F3h7iKyBxdv_DRQLFG3j_zHrbmkYj>
Received: from cisco (unknown [128.107.241.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id E8D82328005A;
        Tue,  1 Sep 2020 11:26:19 -0400 (EDT)
Date:   Tue, 1 Sep 2020 09:26:17 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        syzbot <syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, wad@chromium.org
Subject: Re: memory leak in do_seccomp
Message-ID: <20200901152617.GB583718@cisco>
References: <000000000000e5ea9e05ac9d16c1@google.com>
 <000000000000df80ae05ae244c2b@google.com>
 <202008311620.AC4A7047D@keescook>
 <20200901000915.GA564594@cisco>
 <20200901011459.GA583718@cisco>
 <202008311921.3D64C23D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008311921.3D64C23D@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 08:08:13AM -0700, Kees Cook wrote:
> On Mon, Aug 31, 2020 at 07:14:59PM -0600, Tycho Andersen wrote:
> > On Mon, Aug 31, 2020 at 06:09:15PM -0600, Tycho Andersen wrote:
> > > On Mon, Aug 31, 2020 at 04:25:35PM -0700, Kees Cook wrote:
> > > > On Sun, Aug 30, 2020 at 08:50:15PM -0700, syzbot wrote:
> > > > > syzbot has found a reproducer for the following issue on:
> > > > > 
> > > > > HEAD commit:    dcc5c6f0 Merge tag 'x86-urgent-2020-08-30' of git://git.ke..
> > > > > git tree:       upstream
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=10b297d5900000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=903b9fecc3c6d231
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3ad9614a12f80994c32e
> > > > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14649561900000
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118aacc1900000
> > > > > 
> > > > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > > > Reported-by: syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com
> > > > > 
> > > > > executing program
> > > > > executing program
> > > > > executing program
> > > > > executing program
> > > > > executing program
> > > > > BUG: memory leak
> > > > > unreferenced object 0xffff88811ba93600 (size 64):
> > > > >   comm "syz-executor680", pid 6503, jiffies 4294951104 (age 21.940s)
> > > > >   hex dump (first 32 bytes):
> > > > >     00 00 00 00 00 00 00 00 08 36 a9 1b 81 88 ff ff  .........6......
> > > > >     08 36 a9 1b 81 88 ff ff 11 ce 98 89 3a d5 b4 8f  .6..........:...
> > > > >   backtrace:
> > > > >     [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
> > > > >     [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
> > > > >     [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
> > > > >     [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
> > > > >     [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
> > > > >     [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> > > > >     [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > > 
> > > > I haven't narrowed this down yet (and it *might* be a false positive),
> > > > but it looks like this is filter->notif. The only way that's possible is
> > > > if seccomp_notify_release() was never called *and* seccomp_filter_free()
> > > > got called... which would imply a reference counting problem. The way
> > > > there doesn't jump out at me yet, but I haven't yet decoded the C
> > > > reproducer into the actual seccomp arguments, etc.
> > > 
> > > Looks like it's just a bunch of threads in the same thread group
> > > trying to install a filter with TSYNC and NEW_LISTENER turned on. Does
> > > the patch below look reasonable?
> > > 
> > > I didn't send it separately since I'm in the process of switching my
> > > e-mail address to tycho@tycho.pizza; let this e-mail serve as proof
> > > that that e-mail really is me too :). I can send it the normal way if
> > > it looks good.
> > > 
> > > 
> > > From d497e787e8e1b3e8b9230fdc4c9802616709c920 Mon Sep 17 00:00:00 2001
> > > From: Tycho Andersen <tycho@tycho.pizza>
> > > Date: Mon, 31 Aug 2020 17:55:07 -0600
> > > Subject: [PATCH] seccomp: don't leak memory when filter install races
> > > 
> > > In seccomp_set_mode_filter() with TSYNC | NEW_LISTENER, we first initialize
> > > the listener fd, then check to see if we can actually use it later in
> > > seccomp_may_assign_mode(), which can fail if anyone else in our thread
> > > group has installed a filter and caused some divergence. If we can't, we
> > > partially clean up the newly allocated file: we put the fd, put the file,
> > > but don't actually clean up the *memory* that was allocated at
> > > filter->notif. Let's clean that up too.
> > > 
> > > Fixes: 51891498f2da ("seccomp: allow TSYNC and USER_NOTIF together")
> > > Reported-by: syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com
> > > Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
> > > ---
> > >  kernel/seccomp.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> > > index 3ee59ce0a323..21a76127833f 100644
> > > --- a/kernel/seccomp.c
> > > +++ b/kernel/seccomp.c
> > > @@ -1581,6 +1581,8 @@ static long seccomp_set_mode_filter(unsigned int flags,
> > >  			listener_f->private_data = NULL;
> > >  			fput(listener_f);
> > >  			put_unused_fd(listener);
> > > +			kfree(filter->notif);
> > > +			filter->notif = NULL;
> > 
> > Oof, actually this isn't quite right. It should be s/filter/prepared/g.
> > I can fix that and send out a real patch that's actually tested at
> > some point tomorrow.
> 
> Ah! Yes, nice catch. I was staring at the wrong failure path. :)
> 
> I'm thinking the free/NULL pattern, since it's repeated in a few places,
> should likely be a short helper. I'll stare at this some more...

I think (?) it's just two, one here and one in
seccomp_notify_release() but agreed. Maybe something like (untested):

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 3b593b4caaa5..bb0dd9ae699a 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1109,13 +1109,12 @@ static long seccomp_set_mode_strict(void)
 }
 
 #ifdef CONFIG_SECCOMP_FILTER
-static int seccomp_notify_release(struct inode *inode, struct file *file)
+static void seccomp_notify_detach(struct seccomp_filter *filter)
 {
-	struct seccomp_filter *filter = file->private_data;
 	struct seccomp_knotif *knotif;
 
 	if (!filter)
-		return 0;
+		return;
 
 	mutex_lock(&filter->notify_lock);
 
@@ -1142,6 +1141,13 @@ static int seccomp_notify_release(struct inode *inode, struct file *file)
 	kfree(filter->notif);
 	filter->notif = NULL;
 	mutex_unlock(&filter->notify_lock);
+}
+
+static int seccomp_notify_release(struct inode *inode, struct file *file)
+{
+	struct seccomp_filter *filter = file->private_data;
+
+	seccomp_notify_detach(filter);
 	__put_seccomp_filter(filter);
 	return 0;
 }
@@ -1581,8 +1587,7 @@ static long seccomp_set_mode_filter(unsigned int flags,
 			listener_f->private_data = NULL;
 			fput(listener_f);
 			put_unused_fd(listener);
-			kfree(prepared->notif);
-			filter->notif = NULL;
+			seccomp_notify_detach(prepared);
 		} else {
 			fd_install(listener, listener_f);
 			ret = listener;
