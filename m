Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A60E4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83ACA20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgGQHuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:50:19 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:48577 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgGQHuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:50:18 -0400
Received: by mail-io1-f69.google.com with SMTP id r9so5996521ioa.15
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 00:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=K0xpYgdDbOkmDKfy09w7rceR9YlCNd4wQzw3kksCOjY=;
        b=Qb1+460UwlKaUXXxXiy3jZu8n04SGkzHo3itzSKGcoMF13ru3brChVPI7VSFmDnozV
         jJgjE+ZCn0+szWGrh1bd/Sc66rFEyIoS0JdLkUwmx0HCFJXvvd0puRtNBRhbWYosbBK4
         4We520NH4F4/2QAkj565jPYhnuLyM3q2nx0nNttgs2GfsXR8nX/N8Y6q6rgUzCFpdH7z
         L0KqmwgyVqA8Vre31Ba/ZH4mO2rfhhHH+7DUzXr/lhXV0FWskc+h4jG5qPV/nsQXQX8/
         YRTAptcefW+ARjOD40GXj7DgTfCcudtq6Ij3++YJiZfSMmke9vT2VdpH97Q//hDzDxtI
         dq2A==
X-Gm-Message-State: AOAM530NnpAYmEbQepAbMmaTjePOyFMO1LOKVCHBBYwR2pyFaRqIW3o4
        pVMhtFwv38YxqJcXlCgy3Ys7rOXj5h0EPVkw+dQ6//ZdNeiz
X-Google-Smtp-Source: ABdhPJy9MHfJA3K/uRrEETeJS7pFj1JuWZ14huXJU7C83Yu5kG+1/OkMiBmXRvPRmu6Qid9JxiIc0lXqZr1Syi7KxAIV/9gT8Cod
MIME-Version: 1.0
X-Received: by 2002:a6b:ee15:: with SMTP id i21mr8402115ioh.25.1594972217317;
 Fri, 17 Jul 2020 00:50:17 -0700 (PDT)
Date:   Fri, 17 Jul 2020 00:50:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000070a78f05aa9e6883@google.com>
Subject: WARNING in snd_info_get_line
From:   syzbot <syzbot+e42d0746c3c3699b6061@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org,
        alsa-devel@alsa-project.org, colin.king@canonical.com,
        linux-kernel@vger.kernel.org, perex@perex.cz, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f8456690 Merge tag 'clk-fixes-for-linus' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11539507100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e944500a36bc4d55
dashboard link: https://syzkaller.appspot.com/bug?extid=e42d0746c3c3699b6061
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1531c5ab100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17c399c7100000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e42d0746c3c3699b6061@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6804 at sound/core/info.c:609 snd_info_get_line+0x3d0/0x450 sound/core/info.c:609
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 6804 Comm: syz-executor373 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:231
 __warn+0x227/0x250 kernel/panic.c:600
 report_bug+0x1b1/0x2e0 lib/bug.c:198
 handle_bug+0x42/0x80 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:542
RIP: 0010:snd_info_get_line+0x3d0/0x450 sound/core/info.c:609
Code: 0f 85 84 00 00 00 41 c6 45 00 00 31 ed 89 e8 48 83 c4 40 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 57 8a 3b fb eb 05 e8 50 8a 3b fb <0f> 0b bd 01 00 00 00 eb da 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c a3
RSP: 0018:ffffc90001077a38 EFLAGS: 00010293
RAX: ffffffff86390470 RBX: 0000000000000080 RCX: ffff888096156500
RDX: 0000000000000000 RSI: ffffc90001077b10 RDI: ffff8880a1e30600
RBP: ffffc90001077bc8 R08: dffffc0000000000 R09: ffffed10429a6594
R10: ffffed10429a6594 R11: 0000000000000000 R12: ffff8880a2527908
R13: ffffc90001077b10 R14: 1ffff110143c60c0 R15: ffff8880a1e30600
 snd_mixer_oss_proc_write+0x6d/0x670 sound/core/oss/mixer_oss.c:1179
 snd_info_text_entry_release+0xdf/0x1c0 sound/core/info.c:409
 close_pdeo+0x16c/0x310 fs/proc/inode.c:244
 proc_reg_release+0x17c/0x1c0 fs/proc/inode.c:561
 __fput+0x2f0/0x750 fs/file_table.c:281
 task_work_run+0x137/0x1c0 kernel/task_work.c:135
 exit_task_work include/linux/task_work.h:25 [inline]
 do_exit+0x601/0x1f80 kernel/exit.c:805
 do_group_exit+0x161/0x2d0 kernel/exit.c:903
 __do_sys_exit_group+0x13/0x20 kernel/exit.c:914
 __se_sys_exit_group+0x10/0x10 kernel/exit.c:912
 __x64_sys_exit_group+0x37/0x40 kernel/exit.c:912
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x43eeb8
Code: Bad RIP value.
RSP: 002b:00007ffce5a0e308 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 000000000043eeb8
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 00000000004be6c8 R08: 00000000000000e7 R09: ffffffffffffffd0
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00000000006d0180 R14: 0000000000000000 R15: 0000000000000000
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
