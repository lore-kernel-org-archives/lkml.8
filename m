Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A3BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E3D9207DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbgH0QeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:34:17 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:36203 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726246AbgH0QeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:34:17 -0400
Received: by mail-il1-f199.google.com with SMTP id f20so4083246ilg.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 09:34:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CeejWM1wsnx+eYnik6gMIrJziDJ/HbH2NxxTTf+OlEo=;
        b=h4MIUo12EPfVawXSnT8+2mwDLBpBoSuT4WcLI/bEk4FE4qAee2pnTeQEh2HCC90vM2
         oTxsnXgubBQBIAsBzzXHV6dloSkW0Nnz04vwXey2Ux7ooBMhog9rVf2XY7DDn6IoJs9K
         2zpMmDVwW++mXplhJbEs8TqEZsy+4ODPajcH1HAO+HDm4Ezy/5UlopmxZbzOQiVGmvok
         gi5v0n4hN1O5dVToYRocCm72VtKMHhn0ctq5m3Af26a1iohq7QMr15tHdYQkF1EqG781
         9OI4hurJ8CXMdgje3Hay2/loGya543s7QuyG57+xFxS2bJVM4ahDKZIRpPiBBkIU/2jI
         +ZPA==
X-Gm-Message-State: AOAM530l1Rvxm67LgQLsYi0JRg5KikNWRGl8T2KObEns+2Wpm7LpFqw5
        H6MzvfrnlxVLBfJjUDgwsvqS43SRFV+bdTVQGp330riv55iT
X-Google-Smtp-Source: ABdhPJwHkrto7t0X1WgI6fFrkVMbX4Uvg4rR0wAtL+dlrFnlUcoF9NqNwCZped76HCsV5Uryb/Pn3h1YMIx/Dt1YLvEIpkdKkk/J
MIME-Version: 1.0
X-Received: by 2002:a92:da07:: with SMTP id z7mr11323378ilm.196.1598546055601;
 Thu, 27 Aug 2020 09:34:15 -0700 (PDT)
Date:   Thu, 27 Aug 2020 09:34:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd24b305adde81ff@google.com>
Subject: KASAN: use-after-free Read in snd_pcm_oss_release
From:   syzbot <syzbot+12a3fcd1493ec6585007@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, alsa-devel@alsa-project.org,
        arnd@arndb.de, gustavoars@kernel.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com,
        vbabka@suse.cz, walken@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    f37be724 Add linux-next specific files for 20200826
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=137c7cb9900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5a1cf036089d95
dashboard link: https://syzkaller.appspot.com/bug?extid=12a3fcd1493ec6585007
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+12a3fcd1493ec6585007@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2367 [inline]
BUG: KASAN: use-after-free in snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2361 [inline]
BUG: KASAN: use-after-free in snd_pcm_oss_release+0x28d/0x300 sound/core/oss/pcm_oss.c:2548
Read of size 8 at addr ffff888026b66480 by task syz-executor.1/27751

CPU: 1 PID: 27751 Comm: syz-executor.1 Not tainted 5.9.0-rc2-next-20200826-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xae/0x497 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2367 [inline]
 snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2361 [inline]
 snd_pcm_oss_release+0x28d/0x300 sound/core/oss/pcm_oss.c:2548
 __fput+0x285/0x920 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:140 [inline]
 exit_to_user_mode_prepare+0x195/0x1c0 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x59/0x2b0 kernel/entry/common.c:242
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x416f01
Code: 75 14 b8 03 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 04 1b 00 00 c3 48 83 ec 08 e8 0a fc ff ff 48 89 04 24 b8 03 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 53 fc ff ff 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffdd39a5e70 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: 0000000000000000 RBX: 0000000000000004 RCX: 0000000000416f01
RDX: 0000000000000001 RSI: 0000000001190428 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00007ffdd39a5f60 R11: 0000000000000293 R12: 0000000001190428
R13: 0000000000268c54 R14: ffffffffffffffff R15: 000000000118cfec

Allocated by task 27754:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:461
 kmem_cache_alloc_trace+0x16e/0x2c0 mm/slab.c:3550
 kmalloc include/linux/slab.h:554 [inline]
 kzalloc include/linux/slab.h:666 [inline]
 snd_pcm_oss_open_file sound/core/oss/pcm_oss.c:2389 [inline]
 snd_pcm_oss_open.part.0+0x55e/0x1290 sound/core/oss/pcm_oss.c:2491
 snd_pcm_oss_open+0x3c/0x50 sound/core/oss/pcm_oss.c:2455
 soundcore_open+0x445/0x600 sound/sound_core.c:593
 chrdev_open+0x266/0x770 fs/char_dev.c:414
 do_dentry_open+0x4b9/0x11b0 fs/open.c:817
 do_open fs/namei.c:3251 [inline]
 path_openat+0x1b9a/0x2730 fs/namei.c:3368
 do_filp_open+0x17e/0x3c0 fs/namei.c:3395
 do_sys_openat2+0x16d/0x420 fs/open.c:1168
 do_sys_open fs/open.c:1184 [inline]
 __do_sys_openat fs/open.c:1200 [inline]
 __se_sys_openat fs/open.c:1195 [inline]
 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1195
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Freed by task 27754:
 kasan_save_stack+0x1b/0x40 mm/kasan/common.c:48
 kasan_set_track+0x1c/0x30 mm/kasan/common.c:56
 kasan_set_free_info+0x1b/0x30 mm/kasan/generic.c:355
 __kasan_slab_free+0xd8/0x120 mm/kasan/common.c:422
 __cache_free mm/slab.c:3418 [inline]
 kfree+0x103/0x2c0 mm/slab.c:3756
 snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2371 [inline]
 snd_pcm_oss_release_file sound/core/oss/pcm_oss.c:2361 [inline]
 snd_pcm_oss_release+0x17e/0x300 sound/core/oss/pcm_oss.c:2548
 __fput+0x285/0x920 fs/file_table.c:281
 task_work_run+0xdd/0x190 kernel/task_work.c:141
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:140 [inline]
 exit_to_user_mode_prepare+0x195/0x1c0 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x59/0x2b0 kernel/entry/common.c:242
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

The buggy address belongs to the object at ffff888026b66480
 which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
 32-byte region [ffff888026b66480, ffff888026b664a0)
The buggy address belongs to the page:
page:0000000076bbbb49 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888026b66fc1 pfn:0x26b66
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002385208 ffffea0000782448 ffff8880aa040100
raw: ffff888026b66fc1 ffff888026b66000 000000010000002e 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888026b66380: fa fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
 ffff888026b66400: 00 fc fc fc fc fc fc fc 00 00 00 00 fc fc fc fc
>ffff888026b66480: fa fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
                   ^
 ffff888026b66500: 00 fc fc fc fc fc fc fc 00 fc fc fc fc fc fc fc
 ffff888026b66580: fa fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
