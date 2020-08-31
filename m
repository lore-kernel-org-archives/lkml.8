Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05323C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8D412054F
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 17:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgHaRHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 13:07:21 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:39705 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728644AbgHaRHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 13:07:19 -0400
Received: by mail-il1-f198.google.com with SMTP id o1so5607913ilk.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 10:07:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=pgFu1p8h9Ux4HOhRX7jy/a6A2Bz00oLRJJ81vpA+6Ow=;
        b=m0+pr34MCIlNXIUa8IeFewwMcLi89byaptRQyvklxcEbeMMlp7Rz5hx91Ct8giWQFv
         vZDd8oe7w8rL8vadN5L5DrEqpsuIoYITiMW4lt4nFyvcWBvwtuvZwJJefO4tlpxxNHQk
         n0sHhvl7G5HQPCOa9LnDuJ5TEtYpK9G6Hgl7urIAo3twgZz94g+YWxxcfCk0chxmokxD
         22bPacUFI+dwkfGey8SUzka50naCnZqPKYN43Eq0Y2z0zK2rdxShqQgDssBG8ks7w69u
         f+TOs6ASAPEHCh7AWZIyPa79E/R6uIYOSyqaB65TA+66O3DNF3mrIKg8xoqPQq8ITbjE
         SuaQ==
X-Gm-Message-State: AOAM532zD5y2u8rELnQyO588Mnbee+POEF5sx/p3Ujj67yd1gPsO4e7B
        oA5X2nHGowypd3ga+TTb/o0W7W1ZkdbRTc24LAQOglatKmlH
X-Google-Smtp-Source: ABdhPJxbaySGcmCPsLgimLZxA5TlRXRrqaSmJ1pg2AGx3PbvrNO1Rg8wmsm79dEWPpl6m3yhnNfyAUO2m2KzcBW1gjDLlJXpiY3K
MIME-Version: 1.0
X-Received: by 2002:a5d:9051:: with SMTP id v17mr1979896ioq.88.1598893638182;
 Mon, 31 Aug 2020 10:07:18 -0700 (PDT)
Date:   Mon, 31 Aug 2020 10:07:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000566d5405ae2f6f70@google.com>
Subject: WARNING in timer_wait_running
From:   syzbot <syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com>
To:     baolu.lu@linux.intel.com, jroedel@suse.de, jun.miao@windriver.com,
        koba.ko@canonical.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1127b219 Merge tag 'fallthrough-fixes-5.9-rc3' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1501768e900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=978db74cb30aa994
dashboard link: https://syzkaller.appspot.com/bug?extid=3b14b2ed9b3d06dcaa07
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1446598e900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ac97d5900000

The issue was bisected to:

commit b1012ca8dc4f9b1a1fe8e2cb1590dd6d43ea3849
Author: Lu Baolu <baolu.lu@linux.intel.com>
Date:   Thu Jul 23 01:34:37 2020 +0000

    iommu/vt-d: Skip TE disabling on quirky gfx dedicated iommu

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=177a7499900000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14fa7499900000
console output: https://syzkaller.appspot.com/x/log.txt?x=10fa7499900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com
Fixes: b1012ca8dc4f ("iommu/vt-d: Skip TE disabling on quirky gfx dedicated iommu")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 10581 at kernel/time/posix-timers.c:849 timer_wait_running+0x218/0x250 kernel/time/posix-timers.c:849
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 10581 Comm: syz-executor958 Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x4a kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:timer_wait_running+0x218/0x250 kernel/time/posix-timers.c:849
Code: 00 48 c7 c2 a0 97 4d 88 be 7b 02 00 00 48 c7 c7 00 98 4d 88 c6 05 8b eb 46 09 01 e8 87 85 f4 ff e9 b1 fe ff ff e8 f8 04 0e 00 <0f> 0b e9 08 ff ff ff e8 6c 1d 4e 00 e9 3b fe ff ff 4c 89 e7 e8 6f
RSP: 0018:ffffc9000ab87d40 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880a0b46100 RSI: ffffffff81663a18 RDI: ffffffff884da458
RBP: ffff888093acbb48 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: ffffc9000ab87da0
R13: 0000000000000000 R14: ffffffff884da3e0 R15: ffffc9000ab87da0
 do_timer_settime.part.0+0x119/0x1d0 kernel/time/posix-timers.c:929
 do_timer_settime kernel/time/posix-timers.c:961 [inline]
 __do_sys_timer_settime32 kernel/time/posix-timers.c:974 [inline]
 __se_sys_timer_settime32 kernel/time/posix-timers.c:961 [inline]
 __ia32_sys_timer_settime32+0x219/0x310 kernel/time/posix-timers.c:961
 do_syscall_32_irqs_on arch/x86/entry/common.c:84 [inline]
 __do_fast_syscall_32+0x57/0x80 arch/x86/entry/common.c:126
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:149
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c
RIP: 0023:0xf7fa7549
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 eb 0d 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f7f8114c EFLAGS: 00000296 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000020000300 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 0000000020000180 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
