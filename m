Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CD8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 381F021744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 07:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgHEHT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 03:19:28 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:44646 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbgHEHTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 03:19:18 -0400
Received: by mail-io1-f72.google.com with SMTP id m12so21608298iov.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 00:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OKx9Us5b/IdKEJLDpwmtC0W7raoiG1eju8+Qz0Sr3G8=;
        b=LNRHJq1T38Y2YszzVM6KCbzdn8VjKyq+LTjGtrbQBwJYE5JsIBNUVVrMYnI1VfBhqW
         q83lcK+6O5Z5LFgqan5wtvq6Bwju/Nvn1xJlE6nlUZfH4Q+ln8wMlLdOMvoRXdVE1uqJ
         jE1xiET7lHv/Nvahr5fl9PtySFieufThYvIG+N3tJpd9YiMLOZNti2cBR09pQEESNocb
         qb9Qvrf+gyemEigiSmpLPAaModPoxf12HxlB8zIPPzElHHPK5FtlqCT23GjxH18EQ5FU
         vaJcLW5rxUizPHVYdWq6wlR66mgbGJjX4WYcreCIK/aXgsWGWhAfSi9pyhYzmNAL27rn
         wJ1Q==
X-Gm-Message-State: AOAM530NF5gJJ+7vSa33hyPJUINt/1255BkYkkENm/V6QBVCY2Gr3ldi
        GjFGhymX6XymKD9ve3mJ87S6SVuy37rv9zCtz3teG3NyBuzg
X-Google-Smtp-Source: ABdhPJx1I7n1nS28xF3ygw/KJr4JV+1pJ/f6JNIbl4FpStfxJKevXh685acNYCVzo6O8LZg7X8tj8lrhEtaH4BhBDT1Aod428c52
MIME-Version: 1.0
X-Received: by 2002:a92:bac5:: with SMTP id t66mr2502066ill.125.1596611956121;
 Wed, 05 Aug 2020 00:19:16 -0700 (PDT)
Date:   Wed, 05 Aug 2020 00:19:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d3b2d05ac1c303e@google.com>
Subject: upstream test error: WARNING in __local_bh_enable_ip
From:   syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, fenghua.yu@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        tony.luck@intel.com, x86@kernel.org, yu-cheng.yu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    2324d50d Merge tag 'docs-5.9' of git://git.lwn.net/linux
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16502632900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b21ad52fca7be434
dashboard link: https://syzkaller.appspot.com/bug?extid=8db9e1ecde74e590a657
compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 8690 at kernel/softirq.c:175 __local_bh_enable_ip+0xdf/0x100 kernel/softirq.c:175
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 8690 Comm: syz-fuzzer Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x16e/0x25d lib/dump_stack.c:118
 panic+0x20c/0x69a kernel/panic.c:231
 __warn+0x211/0x240 kernel/panic.c:600
 report_bug+0x153/0x1d0 lib/bug.c:198
 handle_bug+0x4d/0x90 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x16/0x70 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:__local_bh_enable_ip+0xdf/0x100 kernel/softirq.c:175
Code: 00 00 65 8b 05 ae cd cf 7e 85 c0 75 05 e8 10 ae ce ff 5b 41 5e c3 0f 0b 83 3d 40 ee 2f 07 00 0f 85 49 ff ff ff e9 53 ff ff ff <0f> 0b e9 4c ff ff ff e8 15 00 00 00 eb aa 0f 0b 0f 0b 0f 1f 44 00
RSP: 0000:ffffc90000debd40 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000200 RCX: ffff88811fc2a3c0
RDX: 0000000000000000 RSI: 0000000000000200 RDI: ffffffff811bf3f5
RBP: 0000000000000000 R08: 0000000000000000 R09: 000088811fc2b853
R10: 0000ffffffffffff R11: ffff88811fc2a3c0 R12: ffff88811fc2a3c0
R13: 000000c000099c80 R14: ffffffff811bf3f5 R15: ffff88811fc2b850
 local_bh_enable+0x1b/0x20 include/linux/bottom_half.h:32
 fpregs_unlock arch/x86/include/asm/fpu/api.h:41 [inline]
 copy_fpstate_to_sigframe+0x2aa/0x5a0 arch/x86/kernel/fpu/signal.c:195
 get_sigframe+0xf9/0x130 arch/x86/kernel/signal.c:274
 __setup_rt_frame+0x56/0x310 arch/x86/kernel/signal.c:450
 setup_rt_frame arch/x86/kernel/signal.c:702 [inline]
 handle_signal arch/x86/kernel/signal.c:746 [inline]
 arch_do_signal+0x1bd/0x270 arch/x86/kernel/signal.c:813
 exit_to_user_mode_loop kernel/entry/common.c:135 [inline]
 exit_to_user_mode_prepare+0x1bd/0x290 kernel/entry/common.c:166
 irqentry_exit_to_user_mode+0x6/0x30 kernel/entry/common.c:254
 irqentry_exit+0x23/0x80 kernel/entry/common.c:342
 asm_exc_page_fault+0x1e/0x30 arch/x86/include/asm/idtentry.h:538
RIP: 0033:0x467f53
Code: 00 48 81 eb 00 01 00 00 48 81 c7 00 01 00 00 48 81 fb 00 01 00 00 73 82 e9 07 ff ff ff c5 fd ef c0 48 81 fb 00 00 00 02 73 46 <c5> fe 7f 07 c5 fe 7f 47 20 c5 fe 7f 47 40 c5 fe 7f 47 60 48 81 eb
RSP: 002b:000000c00009fed8 EFLAGS: 00010202
RAX: 0000000000000000 RBX: 000000000000ce00 RCX: 0000000000000000
RDX: 00007f952f2dee00 RSI: 0000000000040000 RDI: 00007f952f2d2000
RBP: 000000c00009ff50 R08: 0000000000800000 R09: 00007f952f441fff
R10: 00007f952f086248 R11: 00000000000009cd R12: 00000000000003ff
R13: 0000000000000012 R14: 000080c000b9c000 R15: 000080c00139bfff
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
