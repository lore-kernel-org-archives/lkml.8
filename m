Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC566C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13002072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 08:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCFIzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 03:55:14 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:53730 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFIzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 03:55:14 -0500
Received: by mail-io1-f70.google.com with SMTP id q24so1035491iot.20
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 00:55:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=OHAdMXHEbgyJcd7squtr2O7LMyxk1mH33v8nI4baTFo=;
        b=E6XT1HTIU5TvljwamaiLidv2UCYGj4rFkVtIuEFlwjsCnwBA0u5sKnXsQOQ5bz9mrU
         uHGoxbIOiZ34f4a1y8QR4z7tGSh5e8nZKwINHkf3XXeINhWlTOyxiqLevqS2eI8q0zuA
         wb0A+yqLwCC91rnJKK0OJLGvKiBfd7et3XLalg+V2hu5dcUMl0ZosHvqeWS+yDsya2Ld
         WlGSBCmVwBCRxQ/mCC4SlcIShC/WAcXbTx1q/ue243ddnyxzzXJ5z/nCW8VQJNks9I2V
         vwsCR65ihFbkOBUc50ZuXEdHJdvuyUWKjfgEsxWGQGMs6/SL1VWs62N1QuBUw5T/4ZtK
         Az0A==
X-Gm-Message-State: ANhLgQ2dlOOq2fLYpNz3KuGeL96KWsuNmsCbIhExtGu6PgYX65dN6mbj
        oDr5j4ahouOUMxGC30slr/ItFKgCikBZBdGZAVMQLFC1zsDX
X-Google-Smtp-Source: ADFU+vvn5UC2VwfwJe6V1Pu4RpWg0ALGHO73otg+1dPmE4w3rz62g98B4X3bVon9zKjV0Y1R8QWu273z9L+V6y3C02vzW3gSmUIJ
MIME-Version: 1.0
X-Received: by 2002:a02:5483:: with SMTP id t125mr1916323jaa.114.1583484912163;
 Fri, 06 Mar 2020 00:55:12 -0800 (PST)
Date:   Fri, 06 Mar 2020 00:55:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b25ea005a02bcf21@google.com>
Subject: KASAN: slab-out-of-bounds Read in resample_shrink
From:   syzbot <syzbot+e1fe9f44fb8ecf4fb5dd@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, gustavo@embeddedor.com,
        linux-kernel@vger.kernel.org, perex@perex.cz,
        syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110662f9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
dashboard link: https://syzkaller.appspot.com/bug?extid=e1fe9f44fb8ecf4fb5dd
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160e2e91e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=125f09fde00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e1fe9f44fb8ecf4fb5dd@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in resample_shrink+0x4cd/0x820 sound/core/oss/rate.c:160
Read of size 2 at addr ffff8880940b8a00 by task syz-executor858/9001

CPU: 0 PID: 9001 Comm: syz-executor858 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1fb/0x318 lib/dump_stack.c:118
 print_address_description+0x74/0x5c0 mm/kasan/report.c:374
 __kasan_report+0x149/0x1c0 mm/kasan/report.c:506
 kasan_report+0x26/0x50 mm/kasan/common.c:641
 __asan_report_load2_noabort+0x14/0x20 mm/kasan/generic_report.c:133
 resample_shrink+0x4cd/0x820 sound/core/oss/rate.c:160
 rate_transfer+0x51c/0x620 sound/core/oss/rate.c:279
 snd_pcm_plug_read_transfer+0x1cc/0x270 sound/core/oss/pcm_plugin.c:651
 snd_pcm_oss_read2 sound/core/oss/pcm_oss.c:1460 [inline]
 snd_pcm_oss_read1 sound/core/oss/pcm_oss.c:1517 [inline]
 snd_pcm_oss_read+0x7a6/0xd70 sound/core/oss/pcm_oss.c:2741
 do_loop_readv_writev fs/read_write.c:714 [inline]
 do_iter_read+0x4a2/0x5b0 fs/read_write.c:935
 vfs_readv fs/read_write.c:1053 [inline]
 do_readv+0x18c/0x330 fs/read_write.c:1090
 __do_sys_readv fs/read_write.c:1181 [inline]
 __se_sys_readv fs/read_write.c:1178 [inline]
 __x64_sys_readv+0x7d/0x90 fs/read_write.c:1178
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4467e9
Code: e8 0c e8 ff ff 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 5b 07 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fe8f541ddb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000013
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 00000000004467e9
RDX: 0000000000000001 RSI: 0000000020395000 RDI: 0000000000000003
RBP: 00000000006dbc20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffdbf15dd2f R14: 00007fe8f541e9c0 R15: 000000000000002d

Allocated by task 9001:
 save_stack mm/kasan/common.c:72 [inline]
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc+0x118/0x1c0 mm/kasan/common.c:515
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
 __do_kmalloc_node mm/slab.c:3616 [inline]
 __kmalloc_node+0x4d/0x60 mm/slab.c:3623
 kmalloc_node include/linux/slab.h:578 [inline]
 kvmalloc_node+0x85/0x110 mm/util.c:574
 kvmalloc include/linux/mm.h:645 [inline]
 kvzalloc include/linux/mm.h:653 [inline]
 snd_pcm_plugin_alloc+0x167/0x760 sound/core/oss/pcm_plugin.c:70
 snd_pcm_plug_alloc+0x193/0x2e0 sound/core/oss/pcm_plugin.c:129
 snd_pcm_oss_change_params_locked+0x2b34/0x4350 sound/core/oss/pcm_oss.c:1024
 snd_pcm_oss_change_params sound/core/oss/pcm_oss.c:1087 [inline]
 snd_pcm_oss_get_active_substream+0x22c/0x2a0 sound/core/oss/pcm_oss.c:1104
 snd_pcm_oss_get_rate sound/core/oss/pcm_oss.c:1754 [inline]
 snd_pcm_oss_set_rate sound/core/oss/pcm_oss.c:1746 [inline]
 snd_pcm_oss_ioctl+0x1d66/0x4600 sound/core/oss/pcm_oss.c:2593
 vfs_ioctl fs/ioctl.c:47 [inline]
 ksys_ioctl fs/ioctl.c:763 [inline]
 __do_sys_ioctl fs/ioctl.c:772 [inline]
 __se_sys_ioctl+0x113/0x190 fs/ioctl.c:770
 __x64_sys_ioctl+0x7b/0x90 fs/ioctl.c:770
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 8498:
 save_stack mm/kasan/common.c:72 [inline]
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x12e/0x1e0 mm/kasan/common.c:476
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10d/0x220 mm/slab.c:3757
 load_elf_binary+0x2c73/0x3440 fs/binfmt_elf.c:1086
 search_binary_handler+0x190/0x5e0 fs/exec.c:1662
 exec_binprm fs/exec.c:1705 [inline]
 __do_execve_file+0x153b/0x1ca0 fs/exec.c:1825
 do_execveat_common fs/exec.c:1871 [inline]
 do_execve fs/exec.c:1888 [inline]
 __do_sys_execve fs/exec.c:1964 [inline]
 __se_sys_execve fs/exec.c:1959 [inline]
 __x64_sys_execve+0x94/0xb0 fs/exec.c:1959
 do_syscall_64+0xf7/0x1c0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

The buggy address belongs to the object at ffff8880940b8800
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes to the right of
 512-byte region [ffff8880940b8800, ffff8880940b8a00)
The buggy address belongs to the page:
page:ffffea0002502e00 refcount:1 mapcount:0 mapping:ffff8880aa400a80 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0002787a08 ffffea00024147c8 ffff8880aa400a80
raw: 0000000000000000 ffff8880940b8000 0000000100000004 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880940b8900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff8880940b8980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff8880940b8a00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff8880940b8a80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff8880940b8b00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
