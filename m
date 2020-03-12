Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58591C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B962067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 15:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgCLPrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 11:47:15 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:38154 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbgCLPrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 11:47:14 -0400
Received: by mail-io1-f72.google.com with SMTP id x2so4202133iog.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 08:47:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=O73odJhRE0RHld216mUpontgZMPThRLNn/9xOQ9zEz4=;
        b=oDmUTlrHsAkzGw74huAH7TAt2EG2zFO3CFnLooBOoOSd6Ze2cpMCXObE++5c5OZuh+
         S/ZCC8qScOaCbuKwOh5CGsyZ2K7aK/qBlOFoLFqw7BOPi/t1Q2pV2mgy/pZT54cmJtc8
         QdvKTEKShSTgZxNVgdGc9KBYbt5iwd/O5D5YDk1sZrwFYQQK8/6lXy/lav/QF9Y+hYhC
         8hYiiw/52/hLUE0Gv9C/wr9XiHLV9rJRbqci2uJZmQrGOtwro639QAHaPiNjeeE9UulZ
         UjPCyjWSrwAy5PSxkKwvF7EXVqANcpKr9egg3C9/adjRNN/sT5JPCXySfOGSpaeTPFVa
         8zvg==
X-Gm-Message-State: ANhLgQ2XGh8uR6DNCZlLQ8qj0WBkH9cuwhH5YPK8yTgk+2XetEBXDbBO
        k7MkzAxqa8vYqTuepTbBfeZFt6VwsjdkDvAIaagmTxW59QmE
X-Google-Smtp-Source: ADFU+vvaavmPhh9rz8kG1SSIP1LAz3qXenQRbRDuSH3nHZItb1tKcdfIX9vmI8nzNvqHJQLjeHH+GFo9B7OE3ObSiz50VG9KRMu2
MIME-Version: 1.0
X-Received: by 2002:a92:ddcb:: with SMTP id d11mr8654833ilr.211.1584028034040;
 Thu, 12 Mar 2020 08:47:14 -0700 (PDT)
Date:   Thu, 12 Mar 2020 08:47:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000488d2805a0aa449c@google.com>
Subject: linux-next test error: WARNING in snd_pcm_plug_alloc
From:   syzbot <syzbot+2a59ee7a9831b264f45e@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    407b0a62 Add linux-next specific files for 20200312
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14dd6545e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d644875269fc730b
dashboard link: https://syzkaller.appspot.com/bug?extid=2a59ee7a9831b264f45e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2a59ee7a9831b264f45e@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 8559 at sound/core/oss/pcm_plugin.c:126 snd_pcm_plug_alloc+0x29a/0x330 sound/core/oss/pcm_plugin.c:126
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 8559 Comm: syz-fuzzer Not tainted 5.6.0-rc5-next-20200312-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x35 kernel/panic.c:582
 report_bug+0x27b/0x2f0 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:175 [inline]
 fixup_bug arch/x86/kernel/traps.c:170 [inline]
 do_error_trap+0x12b/0x220 arch/x86/kernel/traps.c:267
 do_invalid_op+0x32/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:snd_pcm_plug_alloc+0x29a/0x330 sound/core/oss/pcm_plugin.c:126
Code: ff ff 45 31 e4 e8 d6 4d 7f fb 44 89 e0 5b 5d 41 5c 41 5d 41 5e c3 e8 c5 4d 7f fb 0f 0b 41 bc fa ff ff ff eb e0 e8 b6 4d 7f fb <0f> 0b 41 bc fa ff ff ff eb d1 e8 a7 4d 7f fb 0f 0b 41 bc fa ff ff
RSP: 0018:ffffc90002317b88 EFLAGS: 00010293
RAX: ffff888093a7c200 RBX: ffff8880a4086000 RCX: ffffffff85f37886
RDX: 0000000000000000 RSI: ffffffff85f37a0a RDI: 0000000000000007
RBP: 0000000000000000 R08: ffff888093a7c200 R09: ffffed10132a791f
R10: ffff88809953c8f3 R11: ffffed10132a791e R12: ffff8880a4086058
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88809953c800
 snd_pcm_oss_change_params_locked+0x1c05/0x34b0 sound/core/oss/pcm_oss.c:1021
 snd_pcm_oss_change_params+0x76/0xd0 sound/core/oss/pcm_oss.c:1084
 snd_pcm_oss_make_ready+0xb7/0x170 sound/core/oss/pcm_oss.c:1143
 snd_pcm_oss_sync.isra.0+0x1be/0x7d0 sound/core/oss/pcm_oss.c:1708
 snd_pcm_oss_release+0x210/0x280 sound/core/oss/pcm_oss.c:2546
 __fput+0x2da/0x850 fs/file_table.c:280
 task_work_run+0xf4/0x1b0 kernel/task_work.c:123
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x2fa/0x360 arch/x86/entry/common.c:165
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x6b1/0x7d0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4afb40
Code: 8b 7c 24 10 48 8b 74 24 18 48 8b 54 24 20 49 c7 c2 00 00 00 00 49 c7 c0 00 00 00 00 49 c7 c1 00 00 00 00 48 8b 44 24 08 0f 05 <48> 3d 01 f0 ff ff 76 20 48 c7 44 24 28 ff ff ff ff 48 c7 44 24 30
RSP: 002b:000000c000213588 EFLAGS: 00000212 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 000000c00002c000 RCX: 00000000004afb40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 000000c0002135c8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000212 R12: 0000000000000006
R13: 0000000000000005 R14: 0000000000000200 R15: 0000000000000000
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
