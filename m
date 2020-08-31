Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8328C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 23:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955122078B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 23:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WLmlKkEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgHaXZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 19:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgHaXZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 19:25:38 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279F8C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 16:25:38 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m8so1580311pfh.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 16:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ryNxh31n4GLtr4wiLiu+HxZgOdeShQwzv0bbbDwyQqU=;
        b=WLmlKkEzXowd/E5iK8eqKrx/dsSzW1FdD3sz3nvMzEwWFyIYOl+Z3WEHAy8pOJUZDT
         BV+BFsZ63xjAX+7omPTfFQk+eN1bn8P+S+ZHad1snvOZUOxQ/SpVPcgvldI3hi+CpFgu
         FAbWUGEEYtqRX1NKbEa3rGa57dEwXGTBla5/c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ryNxh31n4GLtr4wiLiu+HxZgOdeShQwzv0bbbDwyQqU=;
        b=aKqKHK46zevad6Tv5J3bODiQtKapMEqaJo7+zVZYXOtr+9BUBCLpWXAxafaFESct13
         z3M0ULXMbVBbpt389BzcAUCZyFRMreIrBlS8USQFdrohr/8Hnrn3BFXf70Cy/YOdJ+7C
         k4muYQBicUjA9QEHOqhQtjEA4CqmgNRwV9yPEt01YbiG/qiAk7QZ4cCq7nugXHeEST/h
         6CusWO22XlYrfZfz0sGccRdzhtCRCDkdpGGCI1aQ9KUIwdZsk4FI6TjVlKF0cs9u7Cvj
         feDLdYVk1s16/8HLNVc94e6Mx5SZ/sapZ+TI6+w8JOpllea99dmXjmxAbJKweUJoU4DD
         huiQ==
X-Gm-Message-State: AOAM530Wdh0xJVCuvySUsLsF+CuTJSOC/hYkryhPsAA91o1pW8jP7ibg
        v1gk3ywetJmZ9WJbTaKF0LkegQ==
X-Google-Smtp-Source: ABdhPJxntmuzYlZmik+s//Jh+Y4ebRFhEs/9XwXQOMZCaG4JBbiXbJRRn+u11CA5ZaTbtYnnJSv17g==
X-Received: by 2002:aa7:924b:: with SMTP id 11mr3189196pfp.185.1598916337542;
        Mon, 31 Aug 2020 16:25:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v11sm8477459pgs.22.2020.08.31.16.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 16:25:36 -0700 (PDT)
Date:   Mon, 31 Aug 2020 16:25:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Tycho Andersen <tycho@tycho.ws>,
        Christian Brauner <christian@brauner.io>
Cc:     linux-kernel@vger.kernel.org, luto@amacapital.net,
        syzbot <syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, wad@chromium.org
Subject: Re: memory leak in do_seccomp
Message-ID: <202008311620.AC4A7047D@keescook>
References: <000000000000e5ea9e05ac9d16c1@google.com>
 <000000000000df80ae05ae244c2b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000df80ae05ae244c2b@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 08:50:15PM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    dcc5c6f0 Merge tag 'x86-urgent-2020-08-30' of git://git.ke..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b297d5900000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=903b9fecc3c6d231
> dashboard link: https://syzkaller.appspot.com/bug?extid=3ad9614a12f80994c32e
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14649561900000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118aacc1900000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3ad9614a12f80994c32e@syzkaller.appspotmail.com
> 
> executing program
> executing program
> executing program
> executing program
> executing program
> BUG: memory leak
> unreferenced object 0xffff88811ba93600 (size 64):
>   comm "syz-executor680", pid 6503, jiffies 4294951104 (age 21.940s)
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 08 36 a9 1b 81 88 ff ff  .........6......
>     08 36 a9 1b 81 88 ff ff 11 ce 98 89 3a d5 b4 8f  .6..........:...
>   backtrace:
>     [<00000000896418b0>] kmalloc include/linux/slab.h:554 [inline]
>     [<00000000896418b0>] kzalloc include/linux/slab.h:666 [inline]
>     [<00000000896418b0>] init_listener kernel/seccomp.c:1473 [inline]
>     [<00000000896418b0>] seccomp_set_mode_filter kernel/seccomp.c:1546 [inline]
>     [<00000000896418b0>] do_seccomp+0x8ce/0xd40 kernel/seccomp.c:1649
>     [<000000002b04976c>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>     [<00000000322b4126>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

I haven't narrowed this down yet (and it *might* be a false positive),
but it looks like this is filter->notif. The only way that's possible is
if seccomp_notify_release() was never called *and* seccomp_filter_free()
got called... which would imply a reference counting problem. The way
there doesn't jump out at me yet, but I haven't yet decoded the C
reproducer into the actual seccomp arguments, etc.

-- 
Kees Cook
