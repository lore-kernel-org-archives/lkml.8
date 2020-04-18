Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF18C2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 06:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D61DE214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 06:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umNoENMc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgDRGzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 02:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgDRGzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 02:55:22 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523B1C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 23:55:22 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b62so4956161qkf.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 23:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zA4TAPd3s2/1fOiuEWefHTUBEv1/DjG3SpNxlrduXbQ=;
        b=umNoENMcCFivIrZCfObQF9v9E490r6JAMXgR2FmNKvXmJEhDCvwFhvAy/U9gfgs9ky
         b4CALfBUQvsTVeIX3BYVbooOeyHCUITRMOUOXHANq9bUDYm4pbagGz+W8prCiITSLvBp
         KVL3w8m6ImKQURJ3YfAUXs88taPQUSI4nemAyGF1qFL5gv2dnqmMzQzzqDg1C82Y19Sh
         i6rUAjA78h69hhfshraz79CrOXrQ3yDgWjVWl5aIuZ3rwu5DwfMfYVXiSnLFa2WoIB84
         LWG5+91pLI9G2revq93crU6K95jmq12DPbtJFzPComS+IaZYJpJxSLM6CZJi7fB1emIj
         3+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zA4TAPd3s2/1fOiuEWefHTUBEv1/DjG3SpNxlrduXbQ=;
        b=gSnpgwioG0au/G2gEPLYvPZivbGCDWAbAsNxMZC+7JU4gxpDgWnaZhI0sjsW3+E7uC
         Ki5O9tX9XTrqHBRiH9/iLkY1rWY3f3eHc+937T/SrX+9MFRSMY8MNnXSFbUstKXS6kBE
         9h4AsqXiErwjBL6tCs4LATaGnm/0XZHual/j8KZwdUYDBVJQhsGHBrMKXQhuE0UCNCrv
         YXM87B3Satn9Td+0TJrSysHUG/BNy02WwCGOKK2B4APO9aCb0QlKkn0kNakw0IKH3oIc
         s3O/DGTR9uZj1fWJyYGS4Q8dGZimCQ2G5R1RzI86Yj9/bwf9+K4JGiKPwlZM6jdkrZLg
         zI+Q==
X-Gm-Message-State: AGi0PubA2gThYWFllfwsRuzCTjly9kizRm4cz3WoJTxDUHeX6NRuzX/V
        Atzc+cTxW5eiK9XiGT8dGWlTgJ6lqEHJc0v7Qt+JBA==
X-Google-Smtp-Source: APiQypLT6DBvh8lNY7n/+bua8Plt1jnVFwFhsgsnXXfNqkvH0aGOWlXlB3cYCGHa62n1T2KqMRvH1mrx7V+oT0oGhsQ=
X-Received: by 2002:a37:4f13:: with SMTP id d19mr6557533qkb.43.1587192921116;
 Fri, 17 Apr 2020 23:55:21 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000008832a805a38afe44@google.com>
In-Reply-To: <0000000000008832a805a38afe44@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 18 Apr 2020 08:55:09 +0200
Message-ID: <CACT4Y+bXkW-pBuYyGppoizE4EiFxjeOKzLYTy7H3XsJccbXX5w@mail.gmail.com>
Subject: Re: general protection fault in mm_update_next_owner (2)
To:     syzbot <syzbot+a0f91e07da410c63b9c3@syzkaller.appspotmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 18, 2020 at 8:44 AM syzbot
<syzbot+a0f91e07da410c63b9c3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    8f3d9f35 Linux 5.7-rc1
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=119a1c07e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d351a1019ed81a2
> dashboard link: https://syzkaller.appspot.com/bug?extid=a0f91e07da410c63b9c3
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+a0f91e07da410c63b9c3@syzkaller.appspotmail.com

FWIW similar crashes also happened on 4.14 and 4.19 LTS. You may see
more info about these crashes on the dashboard bug page.

> general protection fault, probably for non-canonical address 0xf1918d9191919193: 0000 [#1] PREEMPT SMP KASAN
> KASAN: maybe wild-memory-access in range [0x8c8c8c8c8c8c8c98-0x8c8c8c8c8c8c8c9f]
> CPU: 0 PID: 933 Comm: syz-executor.0 Not tainted 5.7.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
> RIP: 0010:mm_update_next_owner+0x49b/0x7a0 kernel/exit.c:385
> Code: 48 8d bd 48 03 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 f4 02 00 00 48 8b ad 48 03 00 00 4c 8d 7d 10 4c 89 f8 48 c1 e8 03 <80> 3c 18 00 0f 85 cb 02 00 00 48 8b 45 10 48 8d a8 68 fa ff ff 49
> RSP: 0018:ffffc90018517d20 EFLAGS: 00010a07
> RAX: 1191919191919193 RBX: dffffc0000000000 RCX: ffffffff81459ed3
> RDX: 0000000000000000 RSI: ffffffff81459ee1 RDI: ffff88800013e8e0
> RBP: 8c8c8c8c8c8c8c8c R08: ffff8882123f0580 R09: fffffbfff1301219
> R10: ffffffff898090c3 R11: fffffbfff1301218 R12: ffff88809552f800
> R13: ffff88800013e1c0 R14: 0000000000000000 R15: 8c8c8c8c8c8c8c9c
> FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000400200 CR3: 000000020b913000 CR4: 00000000001426f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  exit_mm kernel/exit.c:478 [inline]
>  do_exit+0xa49/0x2dd0 kernel/exit.c:782
>  do_group_exit+0x125/0x340 kernel/exit.c:893
>  __do_sys_exit_group kernel/exit.c:904 [inline]
>  __se_sys_exit_group kernel/exit.c:902 [inline]
>  __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:902
>  do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
>  entry_SYSCALL_64_after_hwframe+0x49/0xb3
> RIP: 0033:0x45c889
> Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007ffd4c670f58 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
> RAX: ffffffffffffffda RBX: 000000000000001e RCX: 000000000045c889
> RDX: 0000000000416421 RSI: fffffffffffffff7 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 01ffffffffffffff R09: 00007ffd4c670fb0
> R10: 00000000007702b0 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffd4c670fb0 R14: 0000000000000000 R15: 00007ffd4c670fc0
> Modules linked in:
> ---[ end trace 30f7c81df55d5d82 ]---
> RIP: 0010:__read_once_size include/linux/compiler.h:199 [inline]
> RIP: 0010:mm_update_next_owner+0x49b/0x7a0 kernel/exit.c:385
> Code: 48 8d bd 48 03 00 00 48 89 f8 48 c1 e8 03 80 3c 18 00 0f 85 f4 02 00 00 48 8b ad 48 03 00 00 4c 8d 7d 10 4c 89 f8 48 c1 e8 03 <80> 3c 18 00 0f 85 cb 02 00 00 48 8b 45 10 48 8d a8 68 fa ff ff 49
> RSP: 0018:ffffc90018517d20 EFLAGS: 00010a07
> RAX: 1191919191919193 RBX: dffffc0000000000 RCX: ffffffff81459ed3
> RDX: 0000000000000000 RSI: ffffffff81459ee1 RDI: ffff88800013e8e0
> RBP: 8c8c8c8c8c8c8c8c R08: ffff8882123f0580 R09: fffffbfff1301219
> R10: ffffffff898090c3 R11: fffffbfff1301218 R12: ffff88809552f800
> R13: ffff88800013e1c0 R14: 0000000000000000 R15: 8c8c8c8c8c8c8c9c
> FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000400200 CR3: 000000020b913000 CR4: 00000000001426f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/0000000000008832a805a38afe44%40google.com.
