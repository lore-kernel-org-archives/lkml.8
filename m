Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33DA9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3722065E
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UoQI0SD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbgGOFym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgGOFyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:54:41 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB429C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:54:41 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id e18so968670ilr.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gk5gOqeFa/8PMvpifJgWYM8DdQwMhfdSs+BEeyN+lWk=;
        b=UoQI0SD76HK2T2Ii1JDnPdT+PvnZKyeQNP5UmgmjtqqWMDNfNsVrdgvL9u9M5OQZlw
         jWrBK3/1I9ifUK3yzB4KfK9lOHDw4p0BzIC5h/sDKaOykLj4+l7aWhW2AcUSjjs7qgNZ
         M7STbp38ZNWWnAWiFOarV5AhpT1URj2fwrYq50SL6mLM/LYFTnSLElzJscEtLJ+9Zz0n
         Oa2TzPSZSz/7qJsnECRTf0821GGtOQCmci9mkNjjmldHSRRWa/8oKRwO7UUfdlHX225H
         LUwS/nKN/wlPMPapFZQYX1VrhI4SxAnljlwzTAzvXhrPIX/eu7C+Ke0rRiWcwEkDZZD3
         UJig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gk5gOqeFa/8PMvpifJgWYM8DdQwMhfdSs+BEeyN+lWk=;
        b=lgLP2q9KICW70w9H6Yn6itGX6exhcEkExQJMmLTJKiBbYVpLguLOKtPF0Y1nWc4Tot
         lCBIbPBTQ5L7v3WIaD+Jo1ntWb8emnKrUcEQnjt2gbenkuqFQZO278gY6QucP8DtbISS
         wI2gQe2ZSCEHik8SssEF0Z60Exs6mPqqwYnZdiMhif0O1J0AAPVOT/vVP9u5E/kCTI/8
         9Qvku/w8tK7NWk3WfGFfC25YtOc6znNqvZ6AqvI9RTYNUvr8nEK5TRMEb8brXiVcMdUN
         5zcFttSMpM9315PP+pWlU6xYR2n84KNhH1U/ArA/WdehGQkIlxVKY0N0Q1qXC5CkY26L
         LoHg==
X-Gm-Message-State: AOAM5321SimPYIpx6GKwmY5sPt6eJCoegix9n84hixWAg8ss/gyy1SyG
        3XgG4Gubvt3svyWtCDbBBxGQYcaWRVFR3GTOUp4=
X-Google-Smtp-Source: ABdhPJwspStu4Zb030bC5qMPQEqoOaI5xV2h4ZHgDrLom89QLQGaTQpOFqgl2TanB03FGAUqF4FOLmXEjoBkqs8B314=
X-Received: by 2002:a92:da4c:: with SMTP id p12mr8327803ilq.142.1594792480756;
 Tue, 14 Jul 2020 22:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000c62c0205aa73a505@google.com>
In-Reply-To: <000000000000c62c0205aa73a505@google.com>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 15 Jul 2020 13:54:04 +0800
Message-ID: <CALOAHbDsDTmi6EpfDeg2UcCX-btfw+dzQ2T6iZWvHUhffU0dFQ@mail.gmail.com>
Subject: Re: kernel panic: System is deadlocked on memory
To:     syzbot <syzbot+98be80110b9043885626@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 12:49 PM syzbot
<syzbot+98be80110b9043885626@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d31958b3 Add linux-next specific files for 20200710
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=11a2fe13100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3fe4fccb94cbc1a6
> dashboard link: https://syzkaller.appspot.com/bug?extid=98be80110b9043885626
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101ec967100000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a77000900000
>
> The issue was bisected to:
>
> commit e642d9be463d02c735cd99a9a904063324ee03d6
> Author: Yafang Shao <laoar.shao@gmail.com>
> Date:   Fri Jul 10 04:58:08 2020 +0000
>
>     mm, oom: make the calculation of oom badness more accurate
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1432bd77100000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=1632bd77100000
> console output: https://syzkaller.appspot.com/x/log.txt?x=1232bd77100000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+98be80110b9043885626@syzkaller.appspotmail.com
> Fixes: e642d9be463d ("mm, oom: make the calculation of oom badness more accurate")
>
> Out of memory and no killable processes...
> Kernel panic - not syncing: System is deadlocked on memory
> CPU: 0 PID: 6810 Comm: syz-executor919 Not tainted 5.8.0-rc4-next-20200710-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>  panic+0x2e3/0x75c kernel/panic.c:231
>  out_of_memory mm/oom_kill.c:1106 [inline]
>  out_of_memory.cold+0xa6/0x182 mm/oom_kill.c:1041
>  pagefault_out_of_memory+0x109/0x11c mm/oom_kill.c:1135
>  mm_fault_error+0x123/0x380 arch/x86/mm/fault.c:930
>  do_user_addr_fault+0x5f8/0xbf0 arch/x86/mm/fault.c:1317
>  handle_page_fault arch/x86/mm/fault.c:1351 [inline]
>  exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1404
>  asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:544
> RIP: 0033:0x40154d
> Code: Bad RIP value.
> RSP: 002b:00007ffddf4649b0 EFLAGS: 00010202
> RAX: 0000000000000001 RBX: 0000000000000000 RCX: fffffffffffffffd
> RDX: 0000000000000001 RSI: 00007ffddf4665e0 RDI: ffffffffffffffff
> RBP: 00007ffddf4665e0 R08: 0000000000000000 R09: 0000000000000001
> R10: 0000000000000064 R11: 0000000000000246 R12: ffffffffffffffff
> R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
> Kernel Offset: disabled
> Rebooting in 86400 seconds..
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> syzbot can test patches for this issue, for details see:
> https://goo.gl/tpsmEJ#testing-patches

Thanks for the report.
This issue has been already fixed by
"mm-oom-make-the-calculation-of-oom-badness-more-accurate-v3", which
is already in the -next tree.


-- 
Thanks
Yafang
