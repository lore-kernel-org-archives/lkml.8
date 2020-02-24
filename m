Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 708DDC38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CCF20CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="RnptAsZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgBXWhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:37:53 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45952 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBXWhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:37:53 -0500
Received: by mail-ed1-f66.google.com with SMTP id v28so13843895edw.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 14:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3N90WFV/7sUeBc8APgoP9uPRrizY9mUfJVzn6+g48Ag=;
        b=RnptAsZpiayyvIAXUqxaa+Mp9sENeW4gWhcUAaYWZ/0y6PIJLD4tCDXz/8F2xC1dm2
         Vj//yQAVM42nPoEt8IXeKqHZJy/DEUvBUJ9owmdtLu+84A2+U1vC4vX98BUGZT1vI/pM
         eH86qqKX8OoW3d3hvI84n43dRl2UQeR9vC6vRkpboX6YO1qL4paPEwV8yOj62GCzAStT
         K7y8YJI/LTXhtDrk+THDnBsisRVycx0/YA3kdJbMoyos9xLHimMmwOPCVQYK+Gdf4VFK
         JWDwwAY7alzmBLtxvJzqT83F55hpjacogznJ2iC22vnag71qqO1xoC25Nv+04K++CxCk
         gEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3N90WFV/7sUeBc8APgoP9uPRrizY9mUfJVzn6+g48Ag=;
        b=RJizJ0om79CbiLdqeCbt0t6i05oVHryYklrfGk3bubdiWMirN6Jkz1n/Jt4k1AQuXW
         JGNQjbZr4KL54afELNFg9ZclPboVNfO/K/FKvcjVOiXOhytJIrl9QOA40ShH4x6/WxCt
         nzsGw3jFQEZs2GxcaUKxN0F3ykG2MXT3YcgDCqRBbr5yw1C3AekBMTn/loItwUvhwq+h
         HKETupVDzgjIWtrdOQ1YKaZoq6DCHMk3AxOmQh1LKdGjUsKF2/3mPLkkstvHNJqLO5y7
         9iqppz17XyrwIdxAhtRK1HHNuG53oiGUn2GR6hTergshvdFwg9Ju1Ts0ZKIPG9qHMj3/
         BY6g==
X-Gm-Message-State: APjAAAUtDWYi/nqMAciMXtwv8mQ/OwhosNNXuLNi6OKDxZ+lKw/UhKpV
        CUdgeiGPlyMXrwktvynh2OlnmD149gvBhJ7a1cVZ
X-Google-Smtp-Source: APXvYqzk5aWfHcxpccXcxPmfJlsCR1KQaNpOdP6b7V7BafO0b2WVftvp09WOF+osxKaxnSRtXQP0NYq7m3LuJkNHTGQ=
X-Received: by 2002:a50:ec1a:: with SMTP id g26mr46930820edr.164.1582583871720;
 Mon, 24 Feb 2020 14:37:51 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005fe204059f4ddf27@google.com>
In-Reply-To: <0000000000005fe204059f4ddf27@google.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 24 Feb 2020 17:37:40 -0500
Message-ID: <CAHC9VhRxnY8Zj9OvPcbkc0VkUsJKd7+khAz7MiGGs0SUoegg_g@mail.gmail.com>
Subject: Re: kernel panic: audit: rate limit exceeded
To:     syzbot <syzbot+72461ac44b36c98f58e5@syzkaller.appspotmail.com>
Cc:     Eric Paris <eparis@redhat.com>, kvalo@codeaurora.org,
        linux-audit@redhat.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, peter.senna@collabora.com,
        romain.perier@collabora.com, stas.yakovlev@gmail.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 3:08 AM syzbot
<syzbot+72461ac44b36c98f58e5@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    0c0ddd6a Merge tag 'linux-watchdog-5.6-rc3' of git://www.l..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=12c8a3d9e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3b8906eb6a7d6028
> dashboard link: https://syzkaller.appspot.com/bug?extid=72461ac44b36c98f58e5
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14c803ede00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17237de9e00000
>
> The bug was bisected to:
>
> commit 28b75415ad19fef232d8daab4d5de17d753f0b36
> Author: Romain Perier <romain.perier@collabora.com>
> Date:   Wed Aug 23 07:16:51 2017 +0000
>
>     wireless: ipw2200: Replace PCI pool old API
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12dbfe09e00000
> final crash:    https://syzkaller.appspot.com/x/report.txt?x=11dbfe09e00000
> console output: https://syzkaller.appspot.com/x/log.txt?x=16dbfe09e00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+72461ac44b36c98f58e5@syzkaller.appspotmail.com
> Fixes: 28b75415ad19 ("wireless: ipw2200: Replace PCI pool old API")
>
> audit: audit_lost=1 audit_rate_limit=2 audit_backlog_limit=0
> Kernel panic - not syncing: audit: rate limit exceeded
> CPU: 1 PID: 10031 Comm: syz-executor626 Not tainted 5.6.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x197/0x210 lib/dump_stack.c:118
>  panic+0x2e3/0x75c kernel/panic.c:221
>  audit_panic.cold+0x32/0x32 kernel/audit.c:307
>  audit_log_lost kernel/audit.c:377 [inline]
>  audit_log_lost+0x8b/0x180 kernel/audit.c:349
>  audit_log_end+0x23c/0x2b0 kernel/audit.c:2322
>  audit_log_config_change+0xcc/0xf0 kernel/audit.c:396
>  audit_receive_msg+0x2246/0x28b0 kernel/audit.c:1277
>  audit_receive+0x114/0x230 kernel/audit.c:1513
>  netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
>  netlink_unicast+0x59e/0x7e0 net/netlink/af_netlink.c:1329
>  netlink_sendmsg+0x91c/0xea0 net/netlink/af_netlink.c:1918
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg+0xd7/0x130 net/socket.c:672
>  ____sys_sendmsg+0x753/0x880 net/socket.c:2343
>  ___sys_sendmsg+0x100/0x170 net/socket.c:2397
>  __sys_sendmsg+0x105/0x1d0 net/socket.c:2430
>  __do_sys_sendmsg net/socket.c:2439 [inline]
>  __se_sys_sendmsg net/socket.c:2437 [inline]
>  __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2437
>  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x441239
> Code: e8 fc ab 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 9b 09 fc ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffd68c9df48 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000441239
> RDX: 0000000000000000 RSI: 00000000200006c0 RDI: 0000000000000003
> RBP: 0000000000018b16 R08: 00000000004002c8 R09: 00000000004002c8
> R10: 0000000000000004 R11: 0000000000000246 R12: 0000000000402060
> R13: 00000000004020f0 R14: 0000000000000000 R15: 0000000000000000
> Kernel Offset: disabled
> Rebooting in 86400 seconds..

Has the syzbot audit related configuration recently changed?  At the
very least it looks like you want to configure the system so that it
doesn't panic when an audit record is lost (printk/AUDIT_FAIL_PRINTK
or silent/AUDIT_FAIL_SILENT are better options); look at the
auditctl(8) manpage for some more information (hint: look at the "-f"
option).

-- 
paul moore
www.paul-moore.com
