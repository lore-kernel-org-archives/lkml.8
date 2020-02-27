Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04254C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD03C24697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L28elOzc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729463AbgB0PkM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:40:12 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45330 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729207AbgB0PkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:40:12 -0500
Received: by mail-qt1-f195.google.com with SMTP id d9so2542159qte.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 07:40:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YuPLyDhTWi2Bq6nSA95EKicG53GpCu1nSTcjutGPCOc=;
        b=L28elOzcNxzeh0RY6gJgd3a7ooDHYwTHXYzorm0o3d6jxU0nBc924LYniOadP4x5Z1
         MKoRXEM0utLFjm/Z/cXJdbG70Xb+CcpuclDVnLF807Gjw4fCAHovqblmPxLLvjq3NjTR
         CzLXBfSDNKpB/KY0s8Ejc7KzUTf36yzOyELv8nkvynRKpx54tcMRM6ib7ystbhjO1xxn
         e9zOTXqrQcAT7EMVNDxurBaQ3LHFRY8DEcZstbPrJ6ukAz4w08mgf+UIPLJmhqW0ieVU
         EfbeQel0t9qfeXXvWMbzIdpKJ4o2rViJM+dBM3krMcBcIKbSp/RWnqDUJZe11jKiQ6/C
         83Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YuPLyDhTWi2Bq6nSA95EKicG53GpCu1nSTcjutGPCOc=;
        b=QkVWaoCphiPLdlYr0IUSJ7P1Lm4I5irS1R5e0JhKFA6hMUvaZ8/IfSStYM2gKxrfKG
         QUYNsUuNztaVM2hkSihgeP9T0lsNRbxV9b4LkdZLB+NR+3jfLWXLcXHwumZJuGk4zSbU
         Gg9p9cW7n3fWrgnHYzAwO4BcCKhYKUAIEL3pIYMl6H1lhZH8DrWxwMZqFNkzaGUKUGny
         wDQXII5mnsHWoyinO37rkSLw3QqD4NcRE2AxR4An/+QqkumaUEWzKMMk4aemrxFryLCx
         tdj1T7DyGlPkWFBXLD26Np/IfEdCVdqyuGUkxtgkrQMwrRhFwEGWItd7+Q/mOrH+d7nP
         ks+Q==
X-Gm-Message-State: APjAAAV1owx8/GaRYusdOhJ3/spViwU8d1sQzABD7LWuj/fg908kOLzJ
        q38id55oZMbmgnNBYrqc/lE197B+nW9tOYj5bNQMBQ==
X-Google-Smtp-Source: APXvYqzJBU3JruTy5AFiWf1AZSIF0LUAdG48QvebH07jhVoHgrzI7Cn26viLGIZvenVxLDjsLp+nxmCFVu1ATlRUqdY=
X-Received: by 2002:ac8:1b18:: with SMTP id y24mr5643500qtj.158.1582818010448;
 Thu, 27 Feb 2020 07:40:10 -0800 (PST)
MIME-Version: 1.0
References: <0000000000003cbb40059f4e0346@google.com> <CAHC9VhQVXk5ucd3=7OC=BxEkZGGLfXv9bESX67Mr-TRmTwxjEg@mail.gmail.com>
 <17916d0509978e14d9a5e9eb52d760fa57460542.camel@redhat.com> <CAHC9VhQnbdJprbdTa_XcgUJaiwhzbnGMWJqHczU54UMk0AFCtw@mail.gmail.com>
In-Reply-To: <CAHC9VhQnbdJprbdTa_XcgUJaiwhzbnGMWJqHczU54UMk0AFCtw@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 27 Feb 2020 16:39:59 +0100
Message-ID: <CACT4Y+azQXLcPqtJG9zbj8hxqw4jE3dcwUj5T06bdL3uMaZk+Q@mail.gmail.com>
Subject: Re: kernel panic: audit: backlog limit exceeded
To:     Paul Moore <paul@paul-moore.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Eric Paris <eparis@redhat.com>,
        syzbot <syzbot+9a5e789e4725b9ef1316@syzkaller.appspotmail.com>,
        a@unstable.cc, b.a.t.m.a.n@lists.open-mesh.org,
        Dan Carpenter <dan.carpenter@oracle.com>,
        David Miller <davem@davemloft.net>, fzago@cray.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        john.hammond@intel.com, linux-audit@redhat.com,
        LKML <linux-kernel@vger.kernel.org>, mareklindner@neomailbox.ch,
        netdev <netdev@vger.kernel.org>, sw@simonwunderlich.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 11:47 PM Paul Moore <paul@paul-moore.com> wrote:
>
> On Mon, Feb 24, 2020 at 5:43 PM Eric Paris <eparis@redhat.com> wrote:
> > https://syzkaller.appspot.com/x/repro.syz?x=151b1109e00000 (the
> > reproducer listed) looks like it is literally fuzzing the AUDIT_SET.
> > Which seems like this is working as designed if it is setting the
> > failure mode to 2.
>
> So it is, good catch :)  I saw the panic and instinctively chalked
> that up to a mistaken config, not expecting that it was what was being
> tested.

Yes, this audit failure mode is quite unpleasant for fuzzing. And
since this is not a top-level syscall argument value, it's effectively
impossible to filter out in the fuzzer. Maybe another use case for the
"fuzer lockdown" feature +Tetsuo proposed.
With the current state of the things, I think we only have an option
to disable fuzzing of audit. Which is pity because it has found 5 or
so real bugs in audit too.
But this happened anyway because audit is only reachable from init pid
namespace and syzkaller always unshares pid namespace for sandboxing
reasons, that was removed accidentally and that's how it managed to
find the bugs. But the unshare is restored now:
https://github.com/google/syzkaller/commit/5e0e1d1450d7c3497338082fc28912fdd7f93a3c

As a side effect all other real bugs in audit will be auto-obsoleted
in future if not fixed because they will stop happening.

#syz invalid


> > On Mon, 2020-02-24 at 17:38 -0500, Paul Moore wrote:
> > > On Mon, Feb 24, 2020 at 3:18 AM syzbot
> > > <syzbot+9a5e789e4725b9ef1316@syzkaller.appspotmail.com> wrote:
> > > > Hello,
> > > >
> > > > syzbot found the following crash on:
> > > >
> > > > HEAD commit:    36a44bcd Merge branch 'bnxt_en-shutdown-and-kexec-
> > > > kdump-re..
> > > > git tree:       net
> > > > console output:
> > > > https://syzkaller.appspot.com/x/log.txt?x=148bfdd9e00000
> > > > kernel config:
> > > > https://syzkaller.appspot.com/x/.config?x=768cc3d3e277cc16
> > > > dashboard link:
> > > > https://syzkaller.appspot.com/bug?extid=9a5e789e4725b9ef1316
> > > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > > syz repro:
> > > > https://syzkaller.appspot.com/x/repro.syz?x=151b1109e00000
> > > > C reproducer:
> > > > https://syzkaller.appspot.com/x/repro.c?x=128bfdd9e00000
> > > >
> > > > The bug was bisected to:
> > > >
> > > > commit 0c1b9970ddd4cc41002321c3877e7f91aacb896d
> > > > Author: Dan Carpenter <dan.carpenter@oracle.com>
> > > > Date:   Fri Jul 28 14:42:27 2017 +0000
> > > >
> > > >     staging: lustre: lustre: Off by two in lmv_fid2path()
> > > >
> > > > bisection log:
> > > > https://syzkaller.appspot.com/x/bisect.txt?x=17e6c3e9e00000
> > > > final crash:
> > > > https://syzkaller.appspot.com/x/report.txt?x=1416c3e9e00000
> > > > console output:
> > > > https://syzkaller.appspot.com/x/log.txt?x=1016c3e9e00000
> > > >
> > > > IMPORTANT: if you fix the bug, please add the following tag to the
> > > > commit:
> > > > Reported-by: syzbot+9a5e789e4725b9ef1316@syzkaller.appspotmail.com
> > > > Fixes: 0c1b9970ddd4 ("staging: lustre: lustre: Off by two in
> > > > lmv_fid2path()")
> > > >
> > > > audit: audit_backlog=13 > audit_backlog_limit=7
> > > > audit: audit_lost=1 audit_rate_limit=0 audit_backlog_limit=7
> > > > Kernel panic - not syncing: audit: backlog limit exceeded
> > > > CPU: 1 PID: 9913 Comm: syz-executor024 Not tainted 5.6.0-rc1-
> > > > syzkaller #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine,
> > > > BIOS Google 01/01/2011
> > > > Call Trace:
> > > >  __dump_stack lib/dump_stack.c:77 [inline]
> > > >  dump_stack+0x197/0x210 lib/dump_stack.c:118
> > > >  panic+0x2e3/0x75c kernel/panic.c:221
> > > >  audit_panic.cold+0x32/0x32 kernel/audit.c:307
> > > >  audit_log_lost kernel/audit.c:377 [inline]
> > > >  audit_log_lost+0x8b/0x180 kernel/audit.c:349
> > > >  audit_log_start kernel/audit.c:1788 [inline]
> > > >  audit_log_start+0x70e/0x7c0 kernel/audit.c:1745
> > > >  audit_log+0x95/0x120 kernel/audit.c:2345
> > > >  xt_replace_table+0x61d/0x830 net/netfilter/x_tables.c:1413
> > > >  __do_replace+0x1da/0x950 net/ipv6/netfilter/ip6_tables.c:1084
> > > >  do_replace net/ipv6/netfilter/ip6_tables.c:1157 [inline]
> > > >  do_ip6t_set_ctl+0x33a/0x4c8 net/ipv6/netfilter/ip6_tables.c:1681
> > > >  nf_sockopt net/netfilter/nf_sockopt.c:106 [inline]
> > > >  nf_setsockopt+0x77/0xd0 net/netfilter/nf_sockopt.c:115
> > > >  ipv6_setsockopt net/ipv6/ipv6_sockglue.c:949 [inline]
> > > >  ipv6_setsockopt+0x147/0x180 net/ipv6/ipv6_sockglue.c:933
> > > >  tcp_setsockopt net/ipv4/tcp.c:3165 [inline]
> > > >  tcp_setsockopt+0x8f/0xe0 net/ipv4/tcp.c:3159
> > > >  sock_common_setsockopt+0x94/0xd0 net/core/sock.c:3149
> > > >  __sys_setsockopt+0x261/0x4c0 net/socket.c:2130
> > > >  __do_sys_setsockopt net/socket.c:2146 [inline]
> > > >  __se_sys_setsockopt net/socket.c:2143 [inline]
> > > >  __x64_sys_setsockopt+0xbe/0x150 net/socket.c:2143
> > > >  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
> > > >  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > > RIP: 0033:0x44720a
> > > > Code: 49 89 ca b8 37 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 1a e0
> > > > fb ff c3 66 0f 1f 84 00 00 00 00 00 49 89 ca b8 36 00 00 00 0f 05
> > > > <48> 3d 01 f0 ff ff 0f 83 fa df fb ff c3 66 0f 1f 84 00 00 00 00 00
> > > > RSP: 002b:00007ffd032dec78 EFLAGS: 00000286 ORIG_RAX:
> > > > 0000000000000036
> > > > RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000044720a
> > > > RDX: 0000000000000040 RSI: 0000000000000029 RDI: 0000000000000003
> > > > RBP: 00007ffd032deda0 R08: 00000000000003b8 R09: 0000000000004000
> > > > R10: 00000000006d7b40 R11: 0000000000000286 R12: 00007ffd032deca0
> > > > R13: 00000000006d9d60 R14: 0000000000000029 R15: 00000000006d7ba0
> > > > Kernel Offset: disabled
> > > > Rebooting in 86400 seconds..
> > > >
> > > >
> > > > ---
> > > > This bug is generated by a bot. It may contain errors.
> > > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > > >
> > > > syzbot will keep track of this bug report. See:
> > > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > > For information about bisection process see:
> > > > https://goo.gl/tpsmEJ#bisection
> > > > syzbot can test patches for this bug, for details see:
> > > > https://goo.gl/tpsmEJ#testing-patches
> > >
> > > Similar to syzbot report 72461ac44b36c98f58e5, see my comments there.
