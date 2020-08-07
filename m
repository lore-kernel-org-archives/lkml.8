Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F62C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADB6C20855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 02:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgHGC03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 22:26:29 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:36500 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHGC00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 22:26:26 -0400
Received: by mail-io1-f71.google.com with SMTP id h205so537547iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 19:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=TqHSrj2FBgKEImuAzO8lcW+iLNtmSnwAeQVgVneuW4U=;
        b=P0mZWgfI6Xb58hItvBXlE6dPkXUqQcBpjxOwj/bSY/he4JZvgYAw/8NUdBxOCbm9Kb
         nZzZMpVCS3NObUN89PMc+4gX5b9wlq0vAqxUEoB72e4bhpzAz+0TzfpquVyHA8OthmQ6
         rcvSV/LpyRhg5d6QX8mnOCOmQmlF92eEf7hZ11/9cQEtIxWMSjZKWeEAQNgLcNCL8O4i
         PPXf3qY4PqRqlFaHbxmSLmQZeC9ER+j5exAY4SbDKZ+sGndaBxAkX+noWCT//nWCASYu
         GK5mReHwYGsLLg2Z//Ji1SEQSXT5pMPJFbFDdx7+dePt5RLZCcKqcEIb0uFLaGUKaiAT
         f1cQ==
X-Gm-Message-State: AOAM531oFsGIttMZt2X0F6qBMrMPADrHrkuK6ZZtO5Q7jpRPBO+YtvYh
        ml2jcgEva8c+AT+3n1Xd0RX6Ibc9KLYK1NAuJW3jIP+2PoLC
X-Google-Smtp-Source: ABdhPJyXiz6IfY4/ea7U9cj/mN1eOjRbW5T+ByixbheRokxZas1NXEvv8WyelkzTu855jfcNBID+xDHetnsAqDjZ7KE4oweu6OGI
MIME-Version: 1.0
X-Received: by 2002:a02:c789:: with SMTP id n9mr2373392jao.40.1596767185600;
 Thu, 06 Aug 2020 19:26:25 -0700 (PDT)
Date:   Thu, 06 Aug 2020 19:26:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3068105ac405407@google.com>
Subject: WARNING in irqentry_exit
From:   syzbot <syzbot+d4336c84ed0099fdbe47@syzkaller.appspotmail.com>
To:     keescook@chromium.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    47ec5303 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1348d9dc900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7bb894f55faf8242
dashboard link: https://syzkaller.appspot.com/bug?extid=d4336c84ed0099fdbe47
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f1572a900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12669494900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d4336c84ed0099fdbe47@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 6845 at kernel/entry/common.c:338 irqentry_exit+0x47/0x90 kernel/entry/common.c:342
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 6845 Comm: syz-executor025 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x45 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:irqentry_exit+0x47/0x90 kernel/entry/common.c:338
Code: 27 f6 87 91 00 00 00 02 74 18 40 84 f6 75 3b 65 8b 05 ad ea 12 78 a9 ff ff ff 7f 74 11 e9 91 cd 8a f9 40 84 f6 75 3f c3 eb 89 <0f> 0b eb ca e8 f0 bf 72 f9 65 48 8b 04 25 00 ff 01 00 48 8b 00 a8
RSP: 0000:ffffc900054471d0 EFLAGS: 00010002
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff8179db77
RDX: ffff88809b98e340 RSI: 0000000000000000 RDI: ffffc90005447208
RBP: ffffc90005447208 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 exc_page_fault+0xc2/0x160 arch/x86/mm/fault.c:1421
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
RIP: 0010:__softirqentry_text_end+0x39/0x55
Code: be 04 e0 ff ba f2 ff ff ff 31 c9 e9 db c5 ce ff 41 bf f2 ff ff ff 31 c0 e9 6a 36 e1 f8 41 bf f2 ff ff ff 31 ed e9 85 36 e1 f8 <41> be f2 ff ff ff 48 31 c0 e9 92 39 e1 f8 41 be f2 ff ff ff 48 31
RSP: 0000:ffffc900054472b0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffffc90005447370 RCX: ffffffff810143e2
RDX: ffff88809b98e340 RSI: ffffffff810143f0 RDI: 0000000000000006
RBP: 0000000000000000 R08: 0000000000000000 R09: ffff88809b98e347
R10: 0000000000000000 R11: 0000000000000001 R12: ffffc9000544737c
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88809b98e340
 get_perf_callchain+0x321/0x620 kernel/events/callchain.c:222
 perf_callchain+0x165/0x1c0 kernel/events/core.c:6986
 perf_prepare_sample+0x8fd/0x1d40 kernel/events/core.c:7013
 __perf_event_output kernel/events/core.c:7171 [inline]
 perf_event_output_forward+0xf3/0x270 kernel/events/core.c:7191
 __perf_event_overflow+0x13c/0x370 kernel/events/core.c:8846
 perf_swevent_overflow kernel/events/core.c:8922 [inline]
 perf_swevent_event+0x4b9/0x550 kernel/events/core.c:8960
 perf_tp_event+0x2e4/0xb50 kernel/events/core.c:9378
 perf_trace_run_bpf_submit+0x11c/0x200 kernel/events/core.c:9352
 perf_trace_lock+0x2e2/0x4a0 include/trace/events/lock.h:39
 trace_lock_release include/trace/events/lock.h:58 [inline]
 lock_release+0x571/0x8e0 kernel/locking/lockdep.c:5022
 alloc_set_pte+0x3af/0x1ac0 mm/memory.c:3675
 filemap_map_pages+0x103d/0x1280 mm/filemap.c:2725
 do_fault_around mm/memory.c:3818 [inline]
 do_read_fault mm/memory.c:3852 [inline]
 do_fault mm/memory.c:3985 [inline]
 handle_pte_fault mm/memory.c:4225 [inline]
 __handle_mm_fault mm/memory.c:4357 [inline]
 handle_mm_fault+0x39b7/0x43f0 mm/memory.c:4394
 do_user_addr_fault+0x5a2/0xd00 arch/x86/mm/fault.c:1295
 handle_page_fault arch/x86/mm/fault.c:1365 [inline]
 exc_page_fault+0xa8/0x160 arch/x86/mm/fault.c:1418
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
RIP: 0033:0x49f4d0
Code: Bad RIP value.
RSP: 002b:00007fff1785f378 EFLAGS: 00010202
RAX: 000000000049f4d0 RBX: 0000000000000001 RCX: 00000000006d1190
RDX: 0000000000402140 RSI: 0000000000000000 RDI: 00000000004bf848
RBP: 00007fff1785f380 R08: 00000000004002c8 R09: 00000000004002c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d1180 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
