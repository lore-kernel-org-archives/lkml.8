Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73CA4C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF1A2073A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 01:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="RJyg9Fa/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QOXH1VRq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgIABRU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 21:17:20 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:46375 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgIABPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 21:15:50 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.west.internal (Postfix) with ESMTP id A1C70E2F;
        Mon, 31 Aug 2020 21:15:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 31 Aug 2020 21:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=y7U4YcbylZBpyJ3yH6rFWdJSbPI
        nXbwLt1azlfiFuPY=; b=RJyg9Fa/m9dXWn7xAH4H6BdFRqPhj/UeUVcImUIGmg6
        F2wjTEspoU9IC0ivriSOPZ5cnkMpCLcB6oquJgp/PT8woAxBAEt69rlrP06Ke7Jr
        WeroN+VfKFnj9pwpDTkxrMpGIqa5APDgo8HFu91Rl8PeDasLtfBYAz7AYKpQyvhJ
        aO+iKqlRRfjI1kQpc2gzdNbGatVol/J9HdBpxaxrY8JqUxOh5v+FOaWOzjXoxnTJ
        8Jh8aIrRaqEXixsH+0Vs2TADrCJuMxUO0KBsyUo28UeMxh8dvAN87CwB5xWjVCye
        7R1qgUSiQ/x2bBAapCnKxtJHzgFeCDfkKK8drDxHcDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=y7U4Yc
        bylZBpyJ3yH6rFWdJSbPInXbwLt1azlfiFuPY=; b=QOXH1VRqSaB5EZV6qhgfTa
        Ti3ngCuTN+orkAc9TDnxwwWvKov7KhiKmR7iSTcNfEzkEC8oRvWdnq8EhaU9WT/A
        CXOu8ij6jUzrgOil2v5kObsmBbE3nRmG5CmMbOFlMmnfcRcKnDVHx1EeksPehl0w
        pNir7ibhO4Y8fXuM6Bof0zqU7xpk0n9OskI5Ehc+RURXBkhGJhzWKBkEU1Iz5D61
        waFhPum/blR4tKAEM8EKkiJlRoFocfQoBHdfIQVFuG+NP2U2KiBHVhB/HpWkWkrR
        rMXxxQOiMbzmabTJrGgOHmGdKDXmgAWkYVKHPdZFNx8+ZTgYKsBjPwC1pvwzoATA
        ==
X-ME-Sender: <xms:l6BNX6jKSwhcA-tuFMU_30bV1-ymaqC0EIJnzClxn5odu70H6asijQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrudefiedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvffukfhfgggtuggj
    sehttdertddttddvnecuhfhrohhmpefvhigthhhoucetnhguvghrshgvnhcuoehthigthh
    hosehthigthhhordhpihiiiigrqeenucggtffrrghtthgvrhhnpeffieegtdfhudeiveef
    iedtveevgeevhfejfeduieeivedvveetgfeuveejkeffudenucffohhmrghinheprghpph
    hsphhothdrtghomhenucfkphepuddvkedruddtjedrvdeguddrudekfeenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehthigthhhosehthigthh
    hordhpihiiiigr
X-ME-Proxy: <xmx:l6BNX7BVLmstGc1IMlennBLn1L8LF0oNzkhEYr6VDNfA_lZ-yStQHw>
    <xmx:l6BNXyH0VtlxQfADsRo4fzWxxamm0ENCMxvzwV5RhdoBnZI0t2FA9g>
    <xmx:l6BNXzQEq5o3EtW40DJnENh8yZDQEaCH1VRUEsi4NovIcR8xik2ggw>
    <xmx:l6BNX3_yYV6rZi1nvYVGNSqUcUJpBn8dyGhp4vqYJCMVh77J8uorHu0WpTGbbclE>
Received: from cisco (unknown [128.107.241.183])
        by mail.messagingengine.com (Postfix) with ESMTPA id 56FC83280064;
        Mon, 31 Aug 2020 21:15:01 -0400 (EDT)
Date:   Mon, 31 Aug 2020 19:14:59 -0600
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        syzbot <syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, wad@chromium.org
Subject: Re: memory leak in do_seccomp
Message-ID: <20200901011459.GA583718@cisco>
References: <000000000000e5ea9e05ac9d16c1@google.com>
 <000000000000df80ae05ae244c2b@google.com>
 <202008311620.AC4A7047D@keescook>
 <20200901000915.GA564594@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200901000915.GA564594@cisco>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 06:09:15PM -0600, Tycho Andersen wrote:
> On Mon, Aug 31, 2020 at 04:25:35PM -0700, Kees Cook wrote:
> > On Sun, Aug 30, 2020 at 08:50:15PM -0700, syzbot wrote:
> > > syzbot has found a reproducer for the following issue on:
> > > 
> > > HEAD commit:    dcc5c6f0 Merge tag 'x86-urgent-2020-08-30' of git://git.ke..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=10b297d5900000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=903b9fecc3c6d231
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3ad9614a12f80994c32e
> > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14649561900000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118aacc1900000
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com
> > > 
> > > executing program
> > > executing program
> > > executing program
> > > executing program
> > > executing program
> > > BUG: memory leak
> > > unreferenced object 0xffff88811ba93600 (size 64):
> > >   comm "syz-executor680", pid 6503, jiffies 4294951104 (age 21.940s)
> > >   hex dump (first 32 bytes):
> > >     00 00 00 00 00 00 00 00 08 36 a9 1b 81 88 ff ff  .........6......
> > >     08 36 a9 1b 81 88 ff ff 11 ce 98 89 3a d5 b4 8f  .6..........:...
> > >   backtrace:
> > >     [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
> > >     [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
> > >     [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
> > >     [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
> > >     [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
> > >     [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> > >     [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > 
> > I haven't narrowed this down yet (and it *might* be a false positive),
> > but it looks like this is filter->notif. The only way that's possible is
> > if seccomp_notify_release() was never called *and* seccomp_filter_free()
> > got called... which would imply a reference counting problem. The way
> > there doesn't jump out at me yet, but I haven't yet decoded the C
> > reproducer into the actual seccomp arguments, etc.
> 
> Looks like it's just a bunch of threads in the same thread group
> trying to install a filter with TSYNC and NEW_LISTENER turned on. Does
> the patch below look reasonable?
> 
> I didn't send it separately since I'm in the process of switching my
> e-mail address to tycho@tycho.pizza; let this e-mail serve as proof
> that that e-mail really is me too :). I can send it the normal way if
> it looks good.
> 
> 
> From d497e787e8e1b3e8b9230fdc4c9802616709c920 Mon Sep 17 00:00:00 2001
> From: Tycho Andersen <tycho@tycho.pizza>
> Date: Mon, 31 Aug 2020 17:55:07 -0600
> Subject: [PATCH] seccomp: don't leak memory when filter install races
> 
> In seccomp_set_mode_filter() with TSYNC | NEW_LISTENER, we first initialize
> the listener fd, then check to see if we can actually use it later in
> seccomp_may_assign_mode(), which can fail if anyone else in our thread
> group has installed a filter and caused some divergence. If we can't, we
> partially clean up the newly allocated file: we put the fd, put the file,
> but don't actually clean up the *memory* that was allocated at
> filter->notif. Let's clean that up too.
> 
> Fixes: 51891498f2da ("seccomp: allow TSYNC and USER_NOTIF together")
> Reported-by: syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com
> Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
> ---
>  kernel/seccomp.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 3ee59ce0a323..21a76127833f 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1581,6 +1581,8 @@ static long seccomp_set_mode_filter(unsigned int flags,
>  			listener_f->private_data = NULL;
>  			fput(listener_f);
>  			put_unused_fd(listener);
> +			kfree(filter->notif);
> +			filter->notif = NULL;

Oof, actually this isn't quite right. It should be s/filter/prepared/g.
I can fix that and send out a real patch that's actually tested at
some point tomorrow.

Tycho
