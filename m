Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA6FAC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:23:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B37AC206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:23:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RPTZMSvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404228AbgDCPXx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:23:53 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:34517 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404040AbgDCPXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:23:53 -0400
Received: by mail-ua1-f68.google.com with SMTP id d23so2861858uak.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 08:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cvwynjiCwSw46XyikhL7KgyzcNnPMcyNoDe/2pFYidU=;
        b=RPTZMSvo9LR/T9/++5ilFX/uLZ533I5y1z91cGHS8Vn3E7TwI5L0e5eeu7hmGaaXUf
         Kd13SVgV38zOdWw/Tk0kNInnzA8M+LBa07Fw1xXpycn89hWbk+Dw2xKcwhxk/uhB55rt
         LvrZNC8ww++TL8FYLHtexpJmpojcxYkV9QrnOwFmNEUcCB2elZPdbQQ9ct73iybhbCN1
         kUH3od4km8qxC20uZBzx7yKGs8UgnSU604QkzFW6HIBEgx96JNfiZjjb+ziRjZurtyU0
         hg0dEgMlz3Qx5NUxzBP4QzDYVTAVwmRa1ECGFC+1a3P6UcyTsqLT7pSOjDnEIpW++Reo
         WoPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cvwynjiCwSw46XyikhL7KgyzcNnPMcyNoDe/2pFYidU=;
        b=kJm4d9i5pJnSySx29LGC2wstFKk5GVZP7yEkIiSqTfzetW0hNjeaJRCF6pGZ3OCCMZ
         IGm47wFr5lQjvloXiRnZIQs04ywtyDOiVbYtxR0oTX+D6tv9ul3b8kbyCukSW4IWzy2x
         lyGKyCsYcZ+cagyOi/3nz7J8F7BfJTsuCWavIl2Ws2RTaj0p2dJs5LqWwX78FHamsv6N
         ShqmNbhlQFkmtpbhK8jH76IaHkjvncLd/dkiPArKXo9xdky2JvuttzZKATOKzDlHqGzZ
         glbOH6CjW3zZC66WV5YGwce34ZjWJxfTskPutRI6azI4rtdB1VdG70Zt0JLAssp0xFo7
         P2Yg==
X-Gm-Message-State: AGi0PuYqMCbyvMaecmcY5Fv1BaVbn530CTMut1u0rDEKRDToygjk3qLW
        bjku79IsZl5Qq0E5UkZQmNlFTk1+MmspnaJTqweuk3sX
X-Google-Smtp-Source: APiQypKUY1bin7vGdS6Iz2ghvaKSkf9NDV1Xa9iEOuG15xv6ubN4yR0IRWosM5qvSKIXCGOVlLyT5mocR/2pajgixxc=
X-Received: by 2002:a9f:35e6:: with SMTP id u35mr6857302uad.32.1585927430454;
 Fri, 03 Apr 2020 08:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000102ba005a2622624@google.com>
In-Reply-To: <000000000000102ba005a2622624@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Fri, 3 Apr 2020 08:23:38 -0700
Message-ID: <CAHRSSEyGn3vo6VdzHFPRafM=0Df7Ok9WZmEvAJgMZjH1Q-wQ3w@mail.gmail.com>
Subject: Re: KCSAN: data-race in binder_dec_node_nilocked / binder_state_show
To:     syzbot <syzbot+71f39766a98dddab97b5@syzkaller.appspotmail.com>
Cc:     =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        elver@google.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Todd Kjos <tkjos@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Hridya Valsaraju

On Fri, Apr 3, 2020 at 5:35 AM syzbot
<syzbot+71f39766a98dddab97b5@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    245a4300 Merge branch 'rcu/kcsan' into tip/locking/kcsan
> git tree:       https://github.com/google/ktsan.git kcsan
> console output: https://syzkaller.appspot.com/x/log.txt?x=106b67f1e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a4b9db179318d21f
> dashboard link: https://syzkaller.appspot.com/bug?extid=71f39766a98dddab97b5
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+71f39766a98dddab97b5@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KCSAN: data-race in binder_dec_node_nilocked / binder_state_show
>
> write to 0xffff88809f276954 of 4 bytes by task 1408 on cpu 0:
>  binder_state_show+0xd8/0x260 drivers/android/binder.c:5938
>  seq_read+0x350/0x9d0 fs/seq_file.c:229
>  full_proxy_read+0xbd/0x100 fs/debugfs/file.c:220
>  do_loop_readv_writev fs/read_write.c:714 [inline]
>  do_loop_readv_writev fs/read_write.c:701 [inline]
>  do_iter_read+0x357/0x3d0 fs/read_write.c:935
>  vfs_readv+0x9c/0xf0 fs/read_write.c:997
>  do_preadv+0x131/0x1d0 fs/read_write.c:1089
>  __do_sys_preadv fs/read_write.c:1139 [inline]
>  __se_sys_preadv fs/read_write.c:1134 [inline]
>  __x64_sys_preadv+0x61/0x80 fs/read_write.c:1134
>  do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> read to 0xffff88809f276954 of 4 bytes by task 1416 on cpu 1:
>  binder_dec_node_nilocked+0x382/0x610 drivers/android/binder.c:1261
>  binder_dec_node_tmpref+0xa3/0x120 drivers/android/binder.c:1379
>  binder_put_node drivers/android/binder.c:1387 [inline]
>  binder_state_show+0x1aa/0x260 drivers/android/binder.c:5950
>  seq_read+0x350/0x9d0 fs/seq_file.c:229
>  full_proxy_read+0xbd/0x100 fs/debugfs/file.c:220
>  do_loop_readv_writev fs/read_write.c:714 [inline]
>  do_loop_readv_writev fs/read_write.c:701 [inline]
>  do_iter_read+0x357/0x3d0 fs/read_write.c:935
>  vfs_readv+0x9c/0xf0 fs/read_write.c:997
>  do_preadv+0x131/0x1d0 fs/read_write.c:1089
>  __do_sys_preadv fs/read_write.c:1139 [inline]
>  __se_sys_preadv fs/read_write.c:1134 [inline]
>  __x64_sys_preadv+0x61/0x80 fs/read_write.c:1134
>  do_syscall_64+0xcc/0x3a0 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Reported by Kernel Concurrency Sanitizer on:
> CPU: 1 PID: 1416 Comm: syz-executor.1 Not tainted 5.5.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
