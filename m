Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83503C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 698A1206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 04:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGOEtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 00:49:24 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:47402 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgGOEtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 00:49:23 -0400
Received: by mail-il1-f198.google.com with SMTP id o2so577440ilg.14
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 21:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cQlyQjeZtqtfMvwuPzf5yEC1Uo4z1sU+UmIQX9yqS6o=;
        b=qL4GfPRLJQMgjmwnO1ZwpK0uTGOS2WOQHj4Mg7u7xaw757yqn8edZWWC7/4QqeYOS3
         ulcmh4mM8I31maGF9lEVCkYn5vJOLzt1J9VnbJ5KL0RLrm1yNnoC4KlRvT4J8wb/YKlv
         zQDypTkM3MoDwqvNUVpFkN0oCbqK0NzVA5Wft7XEv2MOxtZtELmMd/09mqE/WHjfifsm
         pNs7Qs2o7zhr/RceZ99Y8aZkSCdZcXJ+XSaiGAjeDB59guwpkTi31uHHPQNYjpwc1h9W
         UoEPzJDKipGobzV7+XZ8SjGtd02+yIdmFcSkrb6sjXoRloW5XXD5qX/HtcLe3jyuMYzJ
         VGcA==
X-Gm-Message-State: AOAM532itZf7IArvJ9k8VagpLCxKSRgAbzjnpe9RiFDu6W7H4xaPWxUJ
        3bzRjt4V2O39XZPJTdjhSCC180xbxFjrMLNXJthGyST3M46q
X-Google-Smtp-Source: ABdhPJyphRjaJDa0dB4ZKljmI+cv0NSQh5IRxWg13MJTPlkO0winotUw5eJb7PN4PFTJfGNXjheFCSut1z6EpXFagoR10UayUtVc
MIME-Version: 1.0
X-Received: by 2002:a02:70d6:: with SMTP id f205mr9703595jac.5.1594788562740;
 Tue, 14 Jul 2020 21:49:22 -0700 (PDT)
Date:   Tue, 14 Jul 2020 21:49:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c62c0205aa73a505@google.com>
Subject: kernel panic: System is deadlocked on memory
From:   syzbot <syzbot+98be80110b9043885626@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, laoar.shao@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d31958b3 Add linux-next specific files for 20200710
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11a2fe13100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3fe4fccb94cbc1a6
dashboard link: https://syzkaller.appspot.com/bug?extid=98be80110b9043885626
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101ec967100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14a77000900000

The issue was bisected to:

commit e642d9be463d02c735cd99a9a904063324ee03d6
Author: Yafang Shao <laoar.shao@gmail.com>
Date:   Fri Jul 10 04:58:08 2020 +0000

    mm, oom: make the calculation of oom badness more accurate

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1432bd77100000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1632bd77100000
console output: https://syzkaller.appspot.com/x/log.txt?x=1232bd77100000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+98be80110b9043885626@syzkaller.appspotmail.com
Fixes: e642d9be463d ("mm, oom: make the calculation of oom badness more accurate")

Out of memory and no killable processes...
Kernel panic - not syncing: System is deadlocked on memory
CPU: 0 PID: 6810 Comm: syz-executor919 Not tainted 5.8.0-rc4-next-20200710-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 out_of_memory mm/oom_kill.c:1106 [inline]
 out_of_memory.cold+0xa6/0x182 mm/oom_kill.c:1041
 pagefault_out_of_memory+0x109/0x11c mm/oom_kill.c:1135
 mm_fault_error+0x123/0x380 arch/x86/mm/fault.c:930
 do_user_addr_fault+0x5f8/0xbf0 arch/x86/mm/fault.c:1317
 handle_page_fault arch/x86/mm/fault.c:1351 [inline]
 exc_page_fault+0xab/0x170 arch/x86/mm/fault.c:1404
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:544
RIP: 0033:0x40154d
Code: Bad RIP value.
RSP: 002b:00007ffddf4649b0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: fffffffffffffffd
RDX: 0000000000000001 RSI: 00007ffddf4665e0 RDI: ffffffffffffffff
RBP: 00007ffddf4665e0 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000064 R11: 0000000000000246 R12: ffffffffffffffff
R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000000000
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
