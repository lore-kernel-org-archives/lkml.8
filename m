Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A08C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 00:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F4F020720
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 00:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eboFhLVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgHXABX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 20:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgHXABW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 20:01:22 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07BFC061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 17:01:21 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so7612922ljg.13
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 17:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uz0KdTCCniS0o52VVCzrGMXm4hqB7aop4qmoNp1sJhQ=;
        b=eboFhLVZvOjSay5QbGG5OMBGuElovYgu0MzGpwTxXyrrkKb2jIGcJ6ThE0D+wKzlwo
         QXGqfHA1ecrKr2Rth+9zZR69ma2MaQhOLESBMYXCqxwpi7JNthndQdcbsRYgJsvjXjMT
         Mdx1dm621TxyGfzyULLeYYZcAHgNXn8o65guxsO1UXqz9XPL0A3whmahLJRTXR2/J/cd
         3GXpeWM/4cWoLW3VQG29PgFdMWktb9JYiborQyJQOXvkzq6sPv3BV8XF5nLh8mznnjIv
         uBv4FeJXHFBYolvo91BXYJGOEok+2m/ui8yU/bj48a07997jfsS+wI4FxAS1NoMGoAej
         ywsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uz0KdTCCniS0o52VVCzrGMXm4hqB7aop4qmoNp1sJhQ=;
        b=Rz9mSg03vBP0MmHWGh3ksMxdJlB9AfCmDwNiLeIG4x9jWdV/5bu5Rvi/UcRyzpvB78
         M4BcewauU6jgfFIdVuGV91GrKuTZGSGpDpFXY9U/wzC08JW1GfDD18zm/K89VESBpWQ+
         W0A1sCr9RngLAdCUXLdm/tCWesvICA4DcTlSggayEwC/q5kJWQ9Di1KlTS63VHdnf0cg
         VBx+lbiUi6lqSOo3XgzVc/SQ4r3yxxR/vQ66YOyAMzbc0/rlH9y0zFq5Y1DjANkxNXP/
         almyd3mvlPYSpMfGnGXHYkSw7sRwVKlBXDpxNGZTMMRKX7/b2CF5RBUXKn2XA7YNhxwi
         31QA==
X-Gm-Message-State: AOAM532hHYSl8QraYEexDa2n4Pfqft047MzgcgPVyQn2uqvgnx1SFEIB
        oh5bU9wxmLAP5TX2uBFVylvtyEBMh7owcyC9rp5mDQ==
X-Google-Smtp-Source: ABdhPJyY8ulx9DDSt4amXHtxe2lsCKj6n2Hz7qmxNAQ/GKOJnh5f1zcZ4+MPdSVtXAbjLvDzQKoJGXselq9jMnwDLxE=
X-Received: by 2002:a2e:9d8e:: with SMTP id c14mr1495978ljj.332.1598227279885;
 Sun, 23 Aug 2020 17:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000067ab705ac501e5f@google.com> <41cb418a-572e-80d7-214a-ad7131fdc0f2@infradead.org>
In-Reply-To: <41cb418a-572e-80d7-214a-ad7131fdc0f2@infradead.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Sun, 23 Aug 2020 17:01:08 -0700
Message-ID: <CALvZod77E-kGrPCb2syPFOpU4SF_FMHt-DzoTyG=u6YWHXzbuA@mail.gmail.com>
Subject: Re: kernel BUG at kernel/fork.c:LINE!
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     syzbot <syzbot+3776ecd80aac504e6085@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>, christian@kellner.me,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, luto@amacapital.net,
        Ingo Molnar <mingo@kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>, wad@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 23, 2020 at 10:34 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 8/7/20 2:16 PM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    fffe3ae0 Merge tag 'for-linus-hmm' of git://git.kernel.org..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1194d90a900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=18bb86f2e4ebfda2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3776ecd80aac504e6085
> > compiler:       gcc (GCC) 10.1.0-syz 20200507
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+3776ecd80aac504e6085@syzkaller.appspotmail.com
>
> Is this fixed by
>
> commit 991e7673859ed41e7ba83c8c4e57afe8cfebe314
> Author: Shakeel Butt <shakeelb@google.com>
> Date:   Thu Aug 6 23:21:37 2020 -0700
>
>     mm: memcontrol: account kernel stack per node
>
>
> since the BUG_ON() at line 390 is removed by this patch.
>

It's not really removed. The BUG_ON() has been moved to line 402. So,
this issue might still occur.

>
> > ------------[ cut here ]------------
> > kernel BUG at kernel/fork.c:390!
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 0 PID: 5239 Comm: syz-executor.1 Not tainted 5.8.0-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:account_kernel_stack+0x297/0x320 kernel/fork.c:390
> > Code: 89 e2 be 23 00 00 00 48 89 ef c1 e2 05 e8 81 9e 75 00 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f e9 ae c9 2f 00 e8 a9 c9 2f 00 <0f> 0b e8 f2 50 6f 00 e9 d2 fd ff ff e8 98 c9 2f 00 48 c7 c6 20 24
> > RSP: 0018:ffffc90015e4f850 EFLAGS: 00010216
> > RAX: 00000000000001f4 RBX: 0000000000000000 RCX: ffffc90017983000
> > RDX: 0000000000040000 RSI: ffffffff81445327 RDI: 0000000000000005
> > RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8880a2ef9663
> > R10: 0000000000000008 R11: 0000000000000000 R12: ffffffffffffffff
> > R13: ffff8880001b2280 R14: ffff88809e4fa840 R15: 0000000000000000
> > FS:  00007f7f035e5700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000001b2fd30000 CR3: 000000009b747000 CR4: 00000000001506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  release_task_stack kernel/fork.c:447 [inline]
> >  put_task_stack+0xc4/0x230 kernel/fork.c:459
> >  finish_task_switch+0x52a/0x750 kernel/sched/core.c:3649
> >  context_switch kernel/sched/core.c:3781 [inline]
> >  __schedule+0x8ed/0x21e0 kernel/sched/core.c:4527
> >  schedule+0xd0/0x2a0 kernel/sched/core.c:4602
> >  freezable_schedule include/linux/freezer.h:172 [inline]
> >  futex_wait_queue_me+0x2a7/0x570 kernel/futex.c:2588
> >  futex_wait+0x1df/0x560 kernel/futex.c:2690
> >  do_futex+0x15b/0x1a60 kernel/futex.c:3749
> >  __do_sys_futex kernel/futex.c:3810 [inline]
> >  __se_sys_futex kernel/futex.c:3778 [inline]
> >  __x64_sys_futex+0x378/0x4e0 kernel/futex.c:3778
> >  do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > RIP: 0033:0x45ccd9
> > Code: 2d b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 fb b5 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > RSP: 002b:00007f7f035e4cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> > RAX: ffffffffffffffda RBX: 000000000078bfa8 RCX: 000000000045ccd9
> > RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000078bfa8
> > RBP: 000000000078bfa0 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bfac
> > R13: 00007fff896cb67f R14: 00007f7f035e59c0 R15: 000000000078bfac
> > Modules linked in:
> > ---[ end trace ff14b6c5822b8142 ]---
> > RIP: 0010:account_kernel_stack+0x297/0x320 kernel/fork.c:390
> > Code: 89 e2 be 23 00 00 00 48 89 ef c1 e2 05 e8 81 9e 75 00 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f e9 ae c9 2f 00 e8 a9 c9 2f 00 <0f> 0b e8 f2 50 6f 00 e9 d2 fd ff ff e8 98 c9 2f 00 48 c7 c6 20 24
> > RSP: 0018:ffffc90015e4f850 EFLAGS: 00010216
> > RAX: 00000000000001f4 RBX: 0000000000000000 RCX: ffffc90017983000
> > RDX: 0000000000040000 RSI: ffffffff81445327 RDI: 0000000000000005
> > RBP: 0000000000000000 R08: 0000000000000001 R09: ffff8880a2ef9663
> > R10: 0000000000000008 R11: 0000000000000000 R12: ffffffffffffffff
> > R13: ffff8880001b2280 R14: ffff88809e4fa840 R15: 0000000000000000
> > FS:  00007f7f035e5700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000001b2fd30000 CR3: 000000009b747000 CR4: 00000000001506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
>
>
> --
> ~Randy
>
