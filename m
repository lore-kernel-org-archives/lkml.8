Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5360C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82CBE20848
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 03:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgH1DSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 23:18:21 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:42807 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgH1DST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 23:18:19 -0400
Received: by mail-il1-f199.google.com with SMTP id f67so3216548ilf.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 20:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ybcWlaVYnyKmmmSvruOytOTa32xg058U5mTDSEh+amo=;
        b=Z+78l+MU+6yKeXvL+jyiu2yh3CK/Oe4VCArMKto339BKetbUK3W79ypnQSSgHujKEC
         oj6S/3wPszQTClgj/YSQ32gl8pYzGqzk5K+3RsfKMO/GRUtfQS9YsUcfHesefy6/aSau
         nNiKv105djnfBoawgQPaEtYabrdj/66QFWn3b4Fo3FZFTPNByuTnd3vG9RcLnborNi12
         /M5v9DQSrWMDACekdDej/QDnBUE0LwyXb063ieacfXYdjQMlK7ZQvhodQRAqWfJ440hW
         UqFE+Rhfun3ErnqagsFTVXMmBUBr9cTblyHDhYcNvKWxxNL7I8qtmnBkg1pYosV6aolF
         Bm0w==
X-Gm-Message-State: AOAM530IA09BHwEbYpFxkm4jGc9B99iz6O1eZLrGT6Q5W+PJkc7pJN2A
        dE5qfnifYCygpnWx7+XlI3chyvjO5CS3tS7WVstfGHegYqad
X-Google-Smtp-Source: ABdhPJxJvyi7f8Oc1RlzEInF1okM/kFLSOvu9JK0yTS6XiU3qvnI1Ge32uPn8RHgRmghhYntld6aawM+CRAopCqbmhGI0irxm/Pa
MIME-Version: 1.0
X-Received: by 2002:a02:82c3:: with SMTP id u3mr22483099jag.81.1598584698071;
 Thu, 27 Aug 2020 20:18:18 -0700 (PDT)
Date:   Thu, 27 Aug 2020 20:18:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001270e805ade781cf@google.com>
Subject: possible deadlock in proc_pid_stack (2)
From:   syzbot <syzbot+a26ada9907073b2f6f97@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        christian@brauner.io, ebiederm@xmission.com,
        gladkov.alexey@gmail.com, keescook@chromium.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, vbabka@suse.cz, walken@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    494d311a Add linux-next specific files for 20200821
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1644d50e900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a61d44f28687f508
dashboard link: https://syzkaller.appspot.com/bug?extid=a26ada9907073b2f6f97
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a26ada9907073b2f6f97@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.9.0-rc1-next-20200821-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.2/26207 is trying to acquire lock:
ffff8880a064e688 (&sig->exec_update_mutex){+.+.}-{3:3}, at: lock_trace fs/proc/base.c:408 [inline]
ffff8880a064e688 (&sig->exec_update_mutex){+.+.}-{3:3}, at: proc_pid_stack+0xf0/0x2a0 fs/proc/base.c:452

but task is already holding lock:
ffff88809dc4d8f8 (&p->lock){+.+.}-{3:3}, at: seq_read+0x61/0x1070 fs/seq_file.c:155

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&p->lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
       seq_read+0x61/0x1070 fs/seq_file.c:155
       do_loop_readv_writev fs/read_write.c:734 [inline]
       do_loop_readv_writev fs/read_write.c:721 [inline]
       do_iter_read+0x48e/0x6e0 fs/read_write.c:955
       vfs_readv+0xe5/0x150 fs/read_write.c:1073
       kernel_readv fs/splice.c:355 [inline]
       default_file_splice_read.constprop.0+0x4e6/0x9e0 fs/splice.c:412
       do_splice_to+0x137/0x170 fs/splice.c:871
       splice_direct_to_actor+0x307/0x980 fs/splice.c:950
       do_splice_direct+0x1b3/0x280 fs/splice.c:1059
       do_sendfile+0x55f/0xd40 fs/read_write.c:1540
       __do_sys_sendfile64 fs/read_write.c:1601 [inline]
       __se_sys_sendfile64 fs/read_write.c:1587 [inline]
       __x64_sys_sendfile64+0x1cc/0x210 fs/read_write.c:1587
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #2 (sb_writers#4){.+.+}-{0:0}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write+0x234/0x470 fs/super.c:1672
       sb_start_write include/linux/fs.h:1643 [inline]
       mnt_want_write+0x3a/0xb0 fs/namespace.c:354
       ovl_do_remove+0xe1/0xe00 fs/overlayfs/dir.c:889
       vfs_rmdir.part.0+0x113/0x430 fs/namei.c:3712
       vfs_rmdir fs/namei.c:3698 [inline]
       do_rmdir+0x3ae/0x440 fs/namei.c:3773
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #1 (&ovl_i_mutex_dir_key[depth]#2){++++}-{3:3}:
       down_read+0x96/0x420 kernel/locking/rwsem.c:1492
       inode_lock_shared include/linux/fs.h:789 [inline]
       lookup_slow fs/namei.c:1560 [inline]
       walk_component+0x409/0x6a0 fs/namei.c:1860
       lookup_last fs/namei.c:2309 [inline]
       path_lookupat+0x1ba/0x830 fs/namei.c:2333
       filename_lookup+0x19f/0x560 fs/namei.c:2366
       create_local_trace_uprobe+0x87/0x4e0 kernel/trace/trace_uprobe.c:1574
       perf_uprobe_init+0x132/0x210 kernel/trace/trace_event_perf.c:323
       perf_uprobe_event_init+0xff/0x1c0 kernel/events/core.c:9608
       perf_try_init_event+0x12a/0x560 kernel/events/core.c:10927
       perf_init_event kernel/events/core.c:10979 [inline]
       perf_event_alloc.part.0+0xe04/0x3790 kernel/events/core.c:11257
       perf_event_alloc kernel/events/core.c:11636 [inline]
       __do_sys_perf_event_open+0x72c/0x2cb0 kernel/events/core.c:11752
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

-> #0 (&sig->exec_update_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:2496 [inline]
       check_prevs_add kernel/locking/lockdep.c:2601 [inline]
       validate_chain kernel/locking/lockdep.c:3218 [inline]
       __lock_acquire+0x2a6b/0x5640 kernel/locking/lockdep.c:4426
       lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:5005
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
       lock_trace fs/proc/base.c:408 [inline]
       proc_pid_stack+0xf0/0x2a0 fs/proc/base.c:452
       proc_single_show+0x116/0x1e0 fs/proc/base.c:775
       seq_read+0x432/0x1070 fs/seq_file.c:208
       do_loop_readv_writev fs/read_write.c:734 [inline]
       do_loop_readv_writev fs/read_write.c:721 [inline]
       do_iter_read+0x48e/0x6e0 fs/read_write.c:955
       vfs_readv+0xe5/0x150 fs/read_write.c:1073
       do_preadv fs/read_write.c:1165 [inline]
       __do_sys_preadv fs/read_write.c:1215 [inline]
       __se_sys_preadv fs/read_write.c:1210 [inline]
       __x64_sys_preadv+0x231/0x310 fs/read_write.c:1210
       do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
       entry_SYSCALL_64_after_hwframe+0x44/0xa9

other info that might help us debug this:

Chain exists of:
  &sig->exec_update_mutex --> sb_writers#4 --> &p->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&p->lock);
                               lock(sb_writers#4);
                               lock(&p->lock);
  lock(&sig->exec_update_mutex);

 *** DEADLOCK ***

1 lock held by syz-executor.2/26207:
 #0: ffff88809dc4d8f8 (&p->lock){+.+.}-{3:3}, at: seq_read+0x61/0x1070 fs/seq_file.c:155

stack backtrace:
CPU: 1 PID: 26207 Comm: syz-executor.2 Not tainted 5.9.0-rc1-next-20200821-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_noncircular+0x324/0x3e0 kernel/locking/lockdep.c:1827
 check_prev_add kernel/locking/lockdep.c:2496 [inline]
 check_prevs_add kernel/locking/lockdep.c:2601 [inline]
 validate_chain kernel/locking/lockdep.c:3218 [inline]
 __lock_acquire+0x2a6b/0x5640 kernel/locking/lockdep.c:4426
 lock_acquire+0x1f1/0xad0 kernel/locking/lockdep.c:5005
 __mutex_lock_common kernel/locking/mutex.c:956 [inline]
 __mutex_lock+0x134/0x10e0 kernel/locking/mutex.c:1103
 lock_trace fs/proc/base.c:408 [inline]
 proc_pid_stack+0xf0/0x2a0 fs/proc/base.c:452
 proc_single_show+0x116/0x1e0 fs/proc/base.c:775
 seq_read+0x432/0x1070 fs/seq_file.c:208
 do_loop_readv_writev fs/read_write.c:734 [inline]
 do_loop_readv_writev fs/read_write.c:721 [inline]
 do_iter_read+0x48e/0x6e0 fs/read_write.c:955
 vfs_readv+0xe5/0x150 fs/read_write.c:1073
 do_preadv fs/read_write.c:1165 [inline]
 __do_sys_preadv fs/read_write.c:1215 [inline]
 __se_sys_preadv fs/read_write.c:1210 [inline]
 __x64_sys_preadv+0x231/0x310 fs/read_write.c:1210
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d579
Code: 5d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 2b b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3c7522cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000127
RAX: ffffffffffffffda RBX: 0000000000025780 RCX: 000000000045d579
RDX: 00000000000002bf RSI: 00000000200017c0 RDI: 0000000000000003
RBP: 000000000118cf90 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118cf4c
R13: 00007ffe544c9bff R14: 00007f3c7522d9c0 R15: 000000000118cf4c


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
