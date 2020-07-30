Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F39C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FAB52083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgG3FxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 01:53:23 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:45416 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgG3FxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 01:53:22 -0400
Received: by mail-il1-f200.google.com with SMTP id c1so18235035ilk.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 22:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=cZqveESVb4dxGAsDKYcIwEFOolAR61lbQIGOuYt5eyM=;
        b=DrbEPJVtgbkOd49QtSQ6kg5m4am4dIaSU9Zojw71pw0AmewL2H7nrK68Q83A+taCU3
         sbM4K0xW36HjMXXOqZWAOrt59JavW5zZZ2bijK5aZ8v+SiDU7lIOc6D++4s9MIUuUxsO
         fyuRhfOH43CqlAi1VahtTQYXi42HXwEiO44//kJs6NV/83FDmUtmQTTCtOIcxEcNAhqw
         +k1fZDM5JejjqiZWLIOatA5h0yf0uOaCplw9ZwEXoR/2zrJeLFl0oIe3ZE5uo4q6WSYb
         YHmLrLD0dKfPP53OTn4Ym+6Hq7yud8vZaoZ+aCnPAurdbU2pXuWsN0pZ9vgczC4vywNQ
         FOpA==
X-Gm-Message-State: AOAM531aYaEy1eQA8AIoPUtvtahYM+ADwebQX9anDTKMIJB4VYU/FGHs
        jCnHxO/P4I/1ungE45pibpIngwdTnaGVx+8IRll9C5Hi4Sn/
X-Google-Smtp-Source: ABdhPJyW4uvls/pU6LN4B4s6Ah6NWPBPFO/nl8CuC7y9z1wq6FDvrEEOJ2OZJoqUqbbz58GaCWptrEh0rzbsQZmjpn4spUkbwUA6
MIME-Version: 1.0
X-Received: by 2002:a92:9687:: with SMTP id g129mr18004529ilh.219.1596088401058;
 Wed, 29 Jul 2020 22:53:21 -0700 (PDT)
Date:   Wed, 29 Jul 2020 22:53:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ce2fc05aba24a7e@google.com>
Subject: KASAN: invalid-free in snd_seq_port_disconnect
From:   syzbot <syzbot+9d2abfef257f3e2d4713@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    d3590ebf Merge tag 'audit-pr-20200729' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1797d388900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=812bbfcb6ae2cd60
dashboard link: https://syzkaller.appspot.com/bug?extid=9d2abfef257f3e2d4713
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14761be4900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d2abfef257f3e2d4713@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: double-free or invalid-free in snd_seq_port_disconnect+0x570/0x610 sound/core/seq/seq_ports.c:614

CPU: 1 PID: 7530 Comm: syz-executor.0 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 print_address_description+0x66/0x5a0 mm/kasan/report.c:383
 kasan_report_invalid_free+0x54/0xd0 mm/kasan/report.c:477
 __kasan_slab_free+0xae/0x170 mm/kasan/common.c:443
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 snd_seq_port_disconnect+0x570/0x610 sound/core/seq/seq_ports.c:614
 snd_seq_ioctl_unsubscribe_port+0x349/0x6c0 sound/core/seq/seq_clientmgr.c:1525
 snd_seq_oss_midi_close+0x397/0x620 sound/core/seq/oss/seq_oss_midi.c:405
 snd_seq_oss_synth_reset+0x335/0x8b0 sound/core/seq/oss/seq_oss_synth.c:406
 snd_seq_oss_reset+0x5b/0x250 sound/core/seq/oss/seq_oss_init.c:435
 snd_seq_oss_ioctl+0x5c2/0x1090 sound/core/seq/oss/seq_oss_ioctl.c:93
 odev_ioctl+0x51/0x70 sound/core/seq/oss/seq_oss.c:174
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl fs/ioctl.c:753 [inline]
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl+0xf9/0x160 fs/ioctl.c:760
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45c429
Code: 8d b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f25d0cb3c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00000000000154c0 RCX: 000000000045c429
RDX: 0000000000000000 RSI: 0000000000005100 RDI: 0000000000000003
RBP: 000000000078bfd8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000078bfac
R13: 00007ffe03b9f5df R14: 00007f25d0cb49c0 R15: 000000000078bfac

Allocated by task 7529:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x103/0x140 mm/kasan/common.c:494
 kmem_cache_alloc_trace+0x234/0x300 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 snd_seq_port_connect+0x66/0x460 sound/core/seq/seq_ports.c:553
 snd_seq_ioctl_subscribe_port+0x349/0x6c0 sound/core/seq/seq_clientmgr.c:1484
 snd_seq_oss_midi_open+0x4db/0x830 sound/core/seq/oss/seq_oss_midi.c:364
 snd_seq_oss_synth_setup_midi+0x108/0x510 sound/core/seq/oss/seq_oss_synth.c:269
 snd_seq_oss_open+0x899/0xe90 sound/core/seq/oss/seq_oss_init.c:261
 odev_open+0x5e/0x90 sound/core/seq/oss/seq_oss.c:125
 chrdev_open+0x498/0x580 fs/char_dev.c:414
 do_dentry_open+0x813/0x1070 fs/open.c:828
 do_open fs/namei.c:3243 [inline]
 path_openat+0x278d/0x37f0 fs/namei.c:3360
 do_filp_open+0x191/0x3a0 fs/namei.c:3387
 do_sys_openat2+0x463/0x770 fs/open.c:1179
 do_sys_open fs/open.c:1195 [inline]
 __do_sys_openat fs/open.c:1209 [inline]
 __se_sys_openat fs/open.c:1204 [inline]
 __x64_sys_openat+0x1c8/0x1f0 fs/open.c:1204
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 7529:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x114/0x170 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 snd_seq_port_disconnect+0x570/0x610 sound/core/seq/seq_ports.c:614
 snd_seq_ioctl_unsubscribe_port+0x349/0x6c0 sound/core/seq/seq_clientmgr.c:1525
 snd_seq_oss_midi_close+0x397/0x620 sound/core/seq/oss/seq_oss_midi.c:405
 snd_seq_oss_synth_reset+0x335/0x8b0 sound/core/seq/oss/seq_oss_synth.c:406
 snd_seq_oss_reset+0x5b/0x250 sound/core/seq/oss/seq_oss_init.c:435
 snd_seq_oss_ioctl+0x5c2/0x1090 sound/core/seq/oss/seq_oss_ioctl.c:93
 odev_ioctl+0x51/0x70 sound/core/seq/oss/seq_oss.c:174
 vfs_ioctl fs/ioctl.c:48 [inline]
 ksys_ioctl fs/ioctl.c:753 [inline]
 __do_sys_ioctl fs/ioctl.c:762 [inline]
 __se_sys_ioctl+0xf9/0x160 fs/ioctl.c:760
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:384
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff8880a3acdd00
 which belongs to the cache kmalloc-128 of size 128
The buggy address is located 0 bytes inside of
 128-byte region [ffff8880a3acdd00, ffff8880a3acdd80)
The buggy address belongs to the page:
page:ffffea00028eb340 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00025c5208 ffffea0002a371c8 ffff8880aa400700
raw: 0000000000000000 ffff8880a3acd000 0000000100000010 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a3acdc00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880a3acdc80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>ffff8880a3acdd00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff8880a3acdd80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880a3acde00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
