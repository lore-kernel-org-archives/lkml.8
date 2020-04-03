Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32F43C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062632077D
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 12:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403968AbgDCMfP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 08:35:15 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:45568 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbgDCMfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 08:35:13 -0400
Received: by mail-il1-f197.google.com with SMTP id p15so6677252ils.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 05:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=KYTCItlIzGjfUPCFO3Xia9WBfLKbB/2YdCU/twntNsI=;
        b=ewaZ5SSmEhZ54P9AbFfaKdMcDLc/i2Xi9QoWfysqc5Lwez+CUWqEFgVRsywsiiYaqX
         8QaGjhLC+nZxNs6KG42ZGG2sUlzUuZCn5dqhouIbXXl1in29V9VOlYMId0rm5JV4fvb4
         U3Hnh9x1LMmmqrxkEfHtj9ccpCAnMesDqK5vozgYJaiEGkL2MxTK2JkrvrslP9RMvElz
         rBrgyPAaYJRfIwbLNCeOVIwgRZxXKtbI0syeXJ5dNINeLu1bVW1ebLHXir2J50tvzTy0
         yP78VY5h2adIgyOIJc3dkVD2vuVd2gSdlh6zH7lzLeXXqgeo2lpb5x99+xPes9XoDAMp
         9afA==
X-Gm-Message-State: AGi0Puaqpe2bNhEJttjiSMKhOxfulm9a/iAkifHUTZJmHcqBtF3oIClP
        q64/l64vXDzCG9iYup1jMSq9RFM16rA5Hx1I99xe+A/WvN2c
X-Google-Smtp-Source: APiQypK8yl0gZd1VlkweFFk+ualprCzO4RaIBJVcqW87iT6e7NKACvrzDb8Dlk8cGym+9kniTNpQQ8TmIrausBM3h8qY/ncSXVGB
MIME-Version: 1.0
X-Received: by 2002:a6b:e81a:: with SMTP id f26mr7519494ioh.20.1585917312432;
 Fri, 03 Apr 2020 05:35:12 -0700 (PDT)
Date:   Fri, 03 Apr 2020 05:35:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000cfff005a26226ce@google.com>
Subject: KCSAN: data-race in __fat_write_inode / fat12_ent_get
From:   syzbot <syzbot+6f1624f937d9d6911e2d@syzkaller.appspotmail.com>
To:     elver@google.com, hirofumi@mail.parknet.co.jp,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    40959e34 kcsan: Avoid blocking producers in prepare_report()
git tree:       https://github.com/google/ktsan.git kcsan
console output: https://syzkaller.appspot.com/x/log.txt?x=1201d5a3e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1ab2c758651b11f6
dashboard link: https://syzkaller.appspot.com/bug?extid=6f1624f937d9d6911e2d
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6f1624f937d9d6911e2d@syzkaller.appspotmail.com

FAT-fs (loop1): error, clusters badly computed (876 != 875)
FAT-fs (loop1): error, clusters badly computed (877 != 876)
FAT-fs (loop1): error, clusters badly computed (878 != 877)
==================================================================
BUG: KCSAN: data-race in __fat_write_inode / fat12_ent_get

write to 0xffff8881015f423c of 4 bytes by task 9966 on cpu 1:
 __fat_write_inode+0x246/0x510 fs/fat/inode.c:877
 fat_write_inode+0x67/0xe0 fs/fat/inode.c:909
 write_inode fs/fs-writeback.c:1312 [inline]
 __writeback_single_inode+0x722/0x910 fs/fs-writeback.c:1511
 writeback_single_inode+0x219/0x2f0 fs/fs-writeback.c:1565
 sync_inode fs/fs-writeback.c:2602 [inline]
 sync_inode_metadata+0x75/0xa0 fs/fs-writeback.c:2622
 __generic_file_fsync+0x117/0x180 fs/libfs.c:1081
 fat_file_fsync+0x54/0x120 fs/fat/file.c:190
 vfs_fsync_range+0x7c/0x150 fs/sync.c:197
 generic_write_sync include/linux/fs.h:2867 [inline]
 generic_file_write_iter+0x31c/0x38e mm/filemap.c:3452
 call_write_iter include/linux/fs.h:1901 [inline]
 do_iter_readv_writev+0x4a7/0x5d0 fs/read_write.c:693
 do_iter_write fs/read_write.c:998 [inline]
 do_iter_write+0x137/0x3a0 fs/read_write.c:979
 vfs_iter_write+0x56/0x80 fs/read_write.c:1039
 iter_file_splice_write+0x530/0x830 fs/splice.c:760
 do_splice_from fs/splice.c:863 [inline]
 direct_splice_actor+0x97/0xb0 fs/splice.c:1037
 splice_direct_to_actor+0x22f/0x540 fs/splice.c:992
 do_splice_direct+0x152/0x1d0 fs/splice.c:1080
 do_sendfile+0x396/0x810 fs/read_write.c:1520
 __do_sys_sendfile64 fs/read_write.c:1575 [inline]
 __se_sys_sendfile64 fs/read_write.c:1567 [inline]
 __x64_sys_sendfile64+0xb8/0x140 fs/read_write.c:1567
 do_syscall_64+0xc7/0x390 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

read to 0xffff8881015f423d of 1 bytes by task 9960 on cpu 0:
 fat12_ent_get+0x5e/0x120 fs/fat/fatent.c:125
 fat_ent_read+0x3de/0x560 fs/fat/fatent.c:370
 fat_get_cluster+0x52b/0x920 fs/fat/cache.c:266
 fat_bmap_cluster fs/fat/cache.c:299 [inline]
 fat_get_mapped_cluster+0x105/0x230 fs/fat/cache.c:320
 fat_bmap+0x146/0x28e fs/fat/cache.c:384
 __fat_get_block fs/fat/inode.c:165 [inline]
 fat_get_block+0x244/0x4f0 fs/fat/inode.c:190
 __block_write_begin_int+0x306/0xf80 fs/buffer.c:2008
 __block_write_begin fs/buffer.c:2058 [inline]
 block_write_begin+0x76/0x160 fs/buffer.c:2117
 cont_write_begin+0x3bd/0x660 fs/buffer.c:2466
 fat_write_begin+0x69/0xc0 fs/fat/inode.c:236
 pagecache_write_begin+0x67/0x90 mm/filemap.c:3106
 cont_expand_zero fs/buffer.c:2393 [inline]
 cont_write_begin+0x176/0x660 fs/buffer.c:2456
 fat_write_begin+0x69/0xc0 fs/fat/inode.c:236
 generic_perform_write+0x13a/0x320 mm/filemap.c:3287
 __generic_file_write_iter+0x240/0x370 mm/filemap.c:3416
 generic_file_write_iter+0x294/0x38e mm/filemap.c:3448
 call_write_iter include/linux/fs.h:1901 [inline]
 new_sync_write+0x303/0x400 fs/read_write.c:483
 __vfs_write+0x9e/0xb0 fs/read_write.c:496
 vfs_write fs/read_write.c:558 [inline]
 vfs_write+0x189/0x380 fs/read_write.c:542
 ksys_write+0xc5/0x1a0 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x49/0x60 fs/read_write.c:620
 do_syscall_64+0xc7/0x390 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x44/0xa9

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 9960 Comm: syz-executor.1 Not tainted 5.6.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
