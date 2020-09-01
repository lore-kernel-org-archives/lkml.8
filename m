Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32448C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBF212078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 00:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho-ws.20150623.gappssmtp.com header.i=@tycho-ws.20150623.gappssmtp.com header.b="0y36y1W1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgIAAJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 20:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbgIAAJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 20:09:20 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD522C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:09:19 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t11so4044479plr.5
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 17:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ID56tsGi8d/aVXCI/QG0v7vTZk+u+Uy6PtLMPMuFh/8=;
        b=0y36y1W1e2mrrl03dkt5VahZZ4o8JoScBpL0Okfw5w0yxu3Sm3tYfujXeQSPNk+7Dh
         1475PKWD0vbRLArPAwo0obUzMaZN6kQvD0TQsjXsmFuOgFQwvHMT6MUvHwxlTOmOrWkp
         c69G/Ptkw/UKF2//rABgQYiRuGw2S/NaFzS95d9iNFI+qF7a0KWGRCJcJhdw1XHmkaqS
         qt8E1+hfez6C3yXs9zFyP50aRqRs/mOa9E9VxRqEInOvePsoI5ozjG0VNVhoumkrxs5s
         oUxYy0T24N9lvn3CQ1OKTaIe1fFHwfKT0FuqvwQwc4IMXq/kVus7XgqZhjr7pAvcAZUb
         EGWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ID56tsGi8d/aVXCI/QG0v7vTZk+u+Uy6PtLMPMuFh/8=;
        b=M4pv0un+3aMfsPUrpddeAHisy6sk+swFTI9mu/OjbB/WyddrCkixskPzg1tWyFfmul
         XpHhoP4bikQVxorEEf4YrNzrYJXZMg815LnftWRrGlfO/CaW7TgrJUsuL/7ge+GFI/BX
         NyUHF7oM7AT5rVAOJgszQbkokxYc7KWa5JgxtMGW97mP3moAHZGHnW1wHbGR5HH7s0f2
         t8YqRmEv63zVM/hyvdjjajSZjPUgyLdJ5UP8MR4cWdmV5olyitRCMLsAN/NTVJGH7tzd
         LItJ7Q+8nZljiEPMftQvAb38XVmYNbGHsV/lyQ5oP6Stt9l0l/m75+SCWJXvonxR4ygD
         XAgg==
X-Gm-Message-State: AOAM531W85WKt6L+m2N209cnJww691nKsPlmk9Bu0SsCyN5kwyOfu/m4
        GHCn2Rt+hr5XdRFF+ZfNLbohgSDDSZ3ZMdKI
X-Google-Smtp-Source: ABdhPJyFhxIqhgT9hKnBerd7o0wCcQI0Zm9nr/izcQ+/gVZFgIWaE/czrlvJXR+nP8SFz4/vnNYZ7Q==
X-Received: by 2002:a17:90b:100a:: with SMTP id gm10mr1695773pjb.30.1598918959254;
        Mon, 31 Aug 2020 17:09:19 -0700 (PDT)
Received: from cisco ([2001:420:c0c8:1006::4a])
        by smtp.gmail.com with ESMTPSA id w5sm8837748pgk.20.2020.08.31.17.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 17:09:18 -0700 (PDT)
Date:   Mon, 31 Aug 2020 18:09:15 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Kees Cook <keescook@chromium.org>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, luto@amacapital.net,
        syzbot <syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, wad@chromium.org,
        Tycho Andersen <tycho@tycho.pizza>
Subject: Re: memory leak in do_seccomp
Message-ID: <20200901000915.GA564594@cisco>
References: <000000000000e5ea9e05ac9d16c1@google.com>
 <000000000000df80ae05ae244c2b@google.com>
 <202008311620.AC4A7047D@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008311620.AC4A7047D@keescook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 04:25:35PM -0700, Kees Cook wrote:
> On Sun, Aug 30, 2020 at 08:50:15PM -0700, syzbot wrote:
> > syzbot has found a reproducer for the following issue on:
> > 
> > HEAD commit:    dcc5c6f0 Merge tag 'x86-urgent-2020-08-30' of git://git.ke..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=10b297d5900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=903b9fecc3c6d231
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3ad9614a12f80994c32e
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14649561900000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118aacc1900000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com
> > 
> > executing program
> > executing program
> > executing program
> > executing program
> > executing program
> > BUG: memory leak
> > unreferenced object 0xffff88811ba93600 (size 64):
> >   comm "syz-executor680", pid 6503, jiffies 4294951104 (age 21.940s)
> >   hex dump (first 32 bytes):
> >     00 00 00 00 00 00 00 00 08 36 a9 1b 81 88 ff ff  .........6......
> >     08 36 a9 1b 81 88 ff ff 11 ce 98 89 3a d5 b4 8f  .6..........:...
> >   backtrace:
> >     [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
> >     [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
> >     [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
> >     [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
> >     [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
> >     [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >     [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> I haven't narrowed this down yet (and it *might* be a false positive),
> but it looks like this is filter->notif. The only way that's possible is
> if seccomp_notify_release() was never called *and* seccomp_filter_free()
> got called... which would imply a reference counting problem. The way
> there doesn't jump out at me yet, but I haven't yet decoded the C
> reproducer into the actual seccomp arguments, etc.

Looks like it's just a bunch of threads in the same thread group
trying to install a filter with TSYNC and NEW_LISTENER turned on. Does
the patch below look reasonable?

I didn't send it separately since I'm in the process of switching my
e-mail address to tycho@tycho.pizza; let this e-mail serve as proof
that that e-mail really is me too :). I can send it the normal way if
it looks good.


From d497e787e8e1b3e8b9230fdc4c9802616709c920 Mon Sep 17 00:00:00 2001
From: Tycho Andersen <tycho@tycho.pizza>
Date: Mon, 31 Aug 2020 17:55:07 -0600
Subject: [PATCH] seccomp: don't leak memory when filter install races

In seccomp_set_mode_filter() with TSYNC | NEW_LISTENER, we first initialize
the listener fd, then check to see if we can actually use it later in
seccomp_may_assign_mode(), which can fail if anyone else in our thread
group has installed a filter and caused some divergence. If we can't, we
partially clean up the newly allocated file: we put the fd, put the file,
but don't actually clean up the *memory* that was allocated at
filter->notif. Let's clean that up too.

Fixes: 51891498f2da ("seccomp: allow TSYNC and USER_NOTIF together")
Reported-by: syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com
Signed-off-by: Tycho Andersen <tycho@tycho.pizza>
---
 kernel/seccomp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 3ee59ce0a323..21a76127833f 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1581,6 +1581,8 @@ static long seccomp_set_mode_filter(unsigned int flags,
 			listener_f->private_data = NULL;
 			fput(listener_f);
 			put_unused_fd(listener);
+			kfree(filter->notif);
+			filter->notif = NULL;
 		} else {
 			fd_install(listener, listener_f);
 			ret = listener;

base-commit: b51594df17d0ce80b9f9f35394a1f42d7ac94472
-- 
2.25.1

