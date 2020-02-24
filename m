Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A3EDC38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E656A2176D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="JKSwM3wh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgBXVqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:46:24 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43513 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXVqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:46:24 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so13714577edb.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mbks2n1OJmqw5AGOznijH9+PH3W9rleO/9kgzMTk5hI=;
        b=JKSwM3whhrlwPsFUIZCV7rj4Tn1qvPyMOASuCrI+m6Ij9p8367LDwx4wMjg2+KI5Mp
         xpHMcedMZlNw1Ngi3ZwMMwkFJxPVoI8/F8L9bhNiD5oLbUa66fRXy4d8LIJcMJFXck02
         EG9cNAs3DWLgrn+6RHs/lpWUD2cJarxdY3iVQS4SI9CzCxkz/g6pC1VhEW4Wk4OqYomq
         YUR4yZPxWtC9E7cuA8vj5bRHWOIn5ZLoAsUN4nmINLcJwyHYfkkSNuTHDJe176ThoRMW
         KTJ7j48WINCgGYXNnMvY0t1UxsJ93d0nioFXDHQbVWSYmXUOgze9eaOQx1TAkripleJZ
         hX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mbks2n1OJmqw5AGOznijH9+PH3W9rleO/9kgzMTk5hI=;
        b=YrvL6GJ1TgHO+ZPHxGic+TcFThyqeQcNKMz7AKW3t734kREJticrzFJi4picRPMRJJ
         8021qR1ynDkbningHjaKjtGMJkN3Ujm9o4IFdrpmI3xo+ZJieC2GowM5EUw3sR8OobaU
         6DkC7XGPfrW5xdmElYJzKKN+E9Yzcr0SWfQHiL2HvrBpCg9nvF1vwQSy8Nvil6qbDKOX
         +AXSsWJOLIHaHhoXm/fjIrim2rwZHndV5ulPzRhhKEDXhA1INS+xUE9XnqGojXfYaQuz
         NtGHabzuM0sFNIQlF6YGMKPTv4v15m/suo2OqfRs6qUmwfTfpOMgtf6uWDgNN6oDWHz7
         dFSg==
X-Gm-Message-State: APjAAAX+5+HFZRVajKYKdlFt0LVteEsz7LW2TujUENwdLjaNSud9PS0I
        1oFRD/7dTkmhTt61PszviQb+AOwyp5FLR6wDxwll
X-Google-Smtp-Source: APXvYqzXaLiMEGi5ggk+RJZ9dzJKfkf6BADqrs0/OlxsYIECdztYv9xliaJOFpyEn2sZX8VP/IsqCZAoksIaCA2YEJA=
X-Received: by 2002:a17:906:19d0:: with SMTP id h16mr50525241ejd.70.1582580782033;
 Mon, 24 Feb 2020 13:46:22 -0800 (PST)
MIME-Version: 1.0
References: <00000000000067c539059f4ddf1a@google.com>
In-Reply-To: <00000000000067c539059f4ddf1a@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Feb 2020 16:46:10 -0500
Message-ID: <CAHC9VhSm4iojreY4q5Lno1QMrwB8SuKfANJGv2LVdbcpFukHvw@mail.gmail.com>
Subject: Re: KMSAN: uninit-value in audit_receive
To:     linux-audit@redhat.com
Cc:     Eric Paris <eparis@redhat.com>, glider@google.com,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+399c44bf1f43b8747403@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 3:08 AM syzbot
<syzbot+399c44bf1f43b8747403@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    8bbbc5cf kmsan: don't compile memmove
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=15c21c81e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cd0e9a6b0e555cc3
> dashboard link: https://syzkaller.appspot.com/bug?extid=399c44bf1f43b8747403
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dbda7ee00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1721fe09e00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+399c44bf1f43b8747403@syzkaller.appspotmail.com
>
> =====================================================
> BUG: KMSAN: uninit-value in audit_set_feature kernel/audit.c:1119 [inline]
> BUG: KMSAN: uninit-value in audit_receive_msg kernel/audit.c:1318 [inline]
> BUG: KMSAN: uninit-value in audit_receive+0x2691/0x6be0 kernel/audit.c:1513

I'm guessing that the issue here is that we aren't checking to make
sure a properly formatted message is sent down to the kernel and if a
truncated AUDIT_SET_FEATURE message is sent would could end up looking
into an audit_features struct that isn't complete.

The fix should be relatively simple, verify that the netlink payload
is at least sizeof(audit_features) big before we inspect it.  Patch
coming shortly.

> CPU: 1 PID: 11583 Comm: syz-executor100 Not tainted 5.6.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x1c9/0x220 lib/dump_stack.c:118
>  kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
>  __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
>  audit_set_feature kernel/audit.c:1119 [inline]
>  audit_receive_msg kernel/audit.c:1318 [inline]
>  audit_receive+0x2691/0x6be0 kernel/audit.c:1513
>  netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
>  netlink_unicast+0xf9e/0x1100 net/netlink/af_netlink.c:1328
>  netlink_sendmsg+0x1246/0x14d0 net/netlink/af_netlink.c:1917
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg net/socket.c:672 [inline]
>  ____sys_sendmsg+0x12b6/0x1350 net/socket.c:2343
>  ___sys_sendmsg net/socket.c:2397 [inline]
>  __sys_sendmsg+0x451/0x5f0 net/socket.c:2430
>  __compat_sys_sendmsg net/compat.c:642 [inline]
>  __do_compat_sys_sendmsg net/compat.c:649 [inline]
>  __se_compat_sys_sendmsg net/compat.c:646 [inline]
>  __ia32_compat_sys_sendmsg+0xed/0x130 net/compat.c:646
>  do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
>  do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
>  entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
> RIP: 0023:0xf7fcbd99
> Code: 90 e8 0b 00 00 00 f3 90 0f ae e8 eb f9 8d 74 26 00 89 3c 24 c3 90 90 90 90 90 90 90 90 90 90 90 90 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 002b:00000000ff99b74c EFLAGS: 00000246 ORIG_RAX: 0000000000000172
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00000000200000c0
> RDX: 0000000000000000 RSI: 00000000080ea078 RDI: 00000000ff99b7a0
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>
> Uninit was created at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
>  kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
>  kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:82
>  slab_alloc_node mm/slub.c:2793 [inline]
>  __kmalloc_node_track_caller+0xb40/0x1200 mm/slub.c:4401
>  __kmalloc_reserve net/core/skbuff.c:142 [inline]
>  __alloc_skb+0x2fd/0xac0 net/core/skbuff.c:210
>  alloc_skb include/linux/skbuff.h:1051 [inline]
>  netlink_alloc_large_skb net/netlink/af_netlink.c:1174 [inline]
>  netlink_sendmsg+0x7d3/0x14d0 net/netlink/af_netlink.c:1892
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg net/socket.c:672 [inline]
>  ____sys_sendmsg+0x12b6/0x1350 net/socket.c:2343
>  ___sys_sendmsg net/socket.c:2397 [inline]
>  __sys_sendmsg+0x451/0x5f0 net/socket.c:2430
>  __compat_sys_sendmsg net/compat.c:642 [inline]
>  __do_compat_sys_sendmsg net/compat.c:649 [inline]
>  __se_compat_sys_sendmsg net/compat.c:646 [inline]
>  __ia32_compat_sys_sendmsg+0xed/0x130 net/compat.c:646
>  do_syscall_32_irqs_on arch/x86/entry/common.c:339 [inline]
>  do_fast_syscall_32+0x3c7/0x6e0 arch/x86/entry/common.c:410
>  entry_SYSENTER_compat+0x68/0x77 arch/x86/entry/entry_64_compat.S:139
> =====================================================



-- 
paul moore
www.paul-moore.com
