Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14CFC3405E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AB9206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 17:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgBSRhN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 12:37:13 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:48619 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgBSRhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 12:37:12 -0500
Received: by mail-il1-f199.google.com with SMTP id u14so799928ilq.15
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 09:37:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EylrpKF7GIAQ3hHfexVu9JS9R5eT8JRr5fIRR7qUsqc=;
        b=kJbVA5dfqhQ7+1ZxFHXYtlM9zoJNvVhSH+ZsmlQhTwyb07Q4HrFHwCJOE6K9zPc4gR
         pQo2Qf6DjV6yqAkG4RYr2OmFD1onTQl8nbaKDDF16caU02eQ1eEX5s4+I+ToKK+R/Jvr
         FDmvW3LqZN99uXlbFJSDdMZ9L+BZlx/kavtusHhyVGONAcAsgJH05Wqd0UZBhFfEBgBG
         5rpDJwi+YCUQQHqakemRd3TJbR6COmY4BV8oaL6Mbm8CiO4EtdLpHDh3E2UxBBRVdzLh
         Bq8xez/SOWoPpNXgMeAB8t1JDgGVrJp4dj5byCdh+c4vgie/7CSrdbPECIvntz0fWHEx
         mq9g==
X-Gm-Message-State: APjAAAW39i+AV9bfhWkAu7oV9MyjUU8Nk3378xuSJvVuZbbQke4WZCDI
        I6Ay3RviaLF99R1dWW1/hG7HpnuAzGc1SGynIjjIMMJuWaFP
X-Google-Smtp-Source: APXvYqwLPBJ7+NXeeM/REpesmtUzzTWnqhevs7rBlKUN73YY7S0fPKvzSfbdCyUMxEfXMjOqjM3mGBEh0Ga8NKPHjRCm0+v7rhCJ
MIME-Version: 1.0
X-Received: by 2002:a05:6602:242c:: with SMTP id g12mr20221495iob.193.1582133829869;
 Wed, 19 Feb 2020 09:37:09 -0800 (PST)
Date:   Wed, 19 Feb 2020 09:37:09 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000eaa6bf059ef13c21@google.com>
Subject: possible deadlock in proc_pid_attr_write (2)
From:   syzbot <syzbot+ac4fc482d8eee6b61151@syzkaller.appspotmail.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org, avagin@gmail.com,
        christian@brauner.io, kent.overstreet@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@suse.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    9f01828e Add linux-next specific files for 20200214
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1328a229e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ffb2752ee30931a0
dashboard link: https://syzkaller.appspot.com/bug?extid=ac4fc482d8eee6b61151
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ac4fc482d8eee6b61151@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
5.6.0-rc1-next-20200214-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor.2/3299 is trying to acquire lock:
ffff88804c4e5150 (&sig->cred_guard_mutex){+.+.}, at: proc_pid_attr_write+0x268/0x6b0 fs/proc/base.c:2683

but task is already holding lock:
ffff888099519c60 (&pipe->mutex/1){+.+.}, at: pipe_lock_nested fs/pipe.c:66 [inline]
ffff888099519c60 (&pipe->mutex/1){+.+.}, at: pipe_lock+0x65/0x80 fs/pipe.c:74

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&pipe->mutex/1){+.+.}:
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
       mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1118
       pipe_lock_nested fs/pipe.c:66 [inline]
       pipe_lock+0x65/0x80 fs/pipe.c:74
       iter_file_splice_write+0x18b/0xc10 fs/splice.c:709
       do_splice_from fs/splice.c:863 [inline]
       do_splice+0xbae/0x1690 fs/splice.c:1170
       __do_sys_splice fs/splice.c:1447 [inline]
       __se_sys_splice fs/splice.c:1427 [inline]
       __x64_sys_splice+0x2c6/0x330 fs/splice.c:1427
       do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #2 (sb_writers#3){.+.+}:
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write+0x255/0x4a0 fs/super.c:1674
       sb_start_write include/linux/fs.h:1649 [inline]
       mnt_want_write+0x3f/0xc0 fs/namespace.c:354
       ovl_want_write+0x76/0xa0 fs/overlayfs/util.c:21
       ovl_setattr+0xdd/0x930 fs/overlayfs/inode.c:27
       notify_change+0xb6d/0x1060 fs/attr.c:336
       chmod_common+0x217/0x460 fs/open.c:561
       do_fchmodat+0xbe/0x150 fs/open.c:599
       __do_sys_chmod fs/open.c:617 [inline]
       __se_sys_chmod fs/open.c:615 [inline]
       __x64_sys_chmod+0x5c/0x80 fs/open.c:615
       do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #1 (&ovl_i_mutex_dir_key[depth]){++++}:
       down_read+0x95/0x440 kernel/locking/rwsem.c:1492
       inode_lock_shared include/linux/fs.h:801 [inline]
       do_last fs/namei.c:3400 [inline]
       path_openat+0x1c4f/0x33f0 fs/namei.c:3607
       do_filp_open+0x192/0x260 fs/namei.c:3637
       do_open_execat+0x13b/0x6d0 fs/exec.c:860
       __do_execve_file.isra.0+0x16d5/0x2270 fs/exec.c:1791
       do_execveat_common fs/exec.c:1897 [inline]
       do_execve fs/exec.c:1914 [inline]
       __do_sys_execve fs/exec.c:1990 [inline]
       __se_sys_execve fs/exec.c:1985 [inline]
       __x64_sys_execve+0x8f/0xc0 fs/exec.c:1985
       do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

-> #0 (&sig->cred_guard_mutex){+.+.}:
       check_prev_add kernel/locking/lockdep.c:2481 [inline]
       check_prevs_add kernel/locking/lockdep.c:2586 [inline]
       validate_chain kernel/locking/lockdep.c:3203 [inline]
       __lock_acquire+0x29cd/0x6320 kernel/locking/lockdep.c:4190
       lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4720
       __mutex_lock_common kernel/locking/mutex.c:956 [inline]
       __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
       mutex_lock_interruptible_nested+0x16/0x20 kernel/locking/mutex.c:1140
       proc_pid_attr_write+0x268/0x6b0 fs/proc/base.c:2683
       __vfs_write+0x8a/0x110 fs/read_write.c:494
       __kernel_write+0x11b/0x3b0 fs/read_write.c:515
       write_pipe_buf+0x15d/0x1f0 fs/splice.c:809
       splice_from_pipe_feed fs/splice.c:512 [inline]
       __splice_from_pipe+0x3ee/0x7c0 fs/splice.c:636
       splice_from_pipe+0x108/0x170 fs/splice.c:671
       default_file_splice_write+0x3c/0x90 fs/splice.c:821
       do_splice_from fs/splice.c:863 [inline]
       do_splice+0xbae/0x1690 fs/splice.c:1170
       __do_sys_splice fs/splice.c:1447 [inline]
       __se_sys_splice fs/splice.c:1427 [inline]
       __x64_sys_splice+0x2c6/0x330 fs/splice.c:1427
       do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
       entry_SYSCALL_64_after_hwframe+0x49/0xbe

other info that might help us debug this:

Chain exists of:
  &sig->cred_guard_mutex --> sb_writers#3 --> &pipe->mutex/1

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&pipe->mutex/1);
                               lock(sb_writers#3);
                               lock(&pipe->mutex/1);
  lock(&sig->cred_guard_mutex);

 *** DEADLOCK ***

2 locks held by syz-executor.2/3299:
 #0: ffff8880a9996418 (sb_writers#6){.+.+}, at: file_start_write include/linux/fs.h:2903 [inline]
 #0: ffff8880a9996418 (sb_writers#6){.+.+}, at: do_splice+0xf52/0x1690 fs/splice.c:1169
 #1: ffff888099519c60 (&pipe->mutex/1){+.+.}, at: pipe_lock_nested fs/pipe.c:66 [inline]
 #1: ffff888099519c60 (&pipe->mutex/1){+.+.}, at: pipe_lock+0x65/0x80 fs/pipe.c:74

stack backtrace:
CPU: 1 PID: 3299 Comm: syz-executor.2 Not tainted 5.6.0-rc1-next-20200214-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_circular_bug.isra.0.cold+0x163/0x172 kernel/locking/lockdep.c:1688
 check_noncircular+0x32e/0x3e0 kernel/locking/lockdep.c:1812
 check_prev_add kernel/locking/lockdep.c:2481 [inline]
 check_prevs_add kernel/locking/lockdep.c:2586 [inline]
 validate_chain kernel/locking/lockdep.c:3203 [inline]
 __lock_acquire+0x29cd/0x6320 kernel/locking/lockdep.c:4190
 lock_acquire+0x190/0x410 kernel/locking/lockdep.c:4720
 __mutex_lock_common kernel/locking/mutex.c:956 [inline]
 __mutex_lock+0x156/0x13c0 kernel/locking/mutex.c:1103
 mutex_lock_interruptible_nested+0x16/0x20 kernel/locking/mutex.c:1140
 proc_pid_attr_write+0x268/0x6b0 fs/proc/base.c:2683
 __vfs_write+0x8a/0x110 fs/read_write.c:494
 __kernel_write+0x11b/0x3b0 fs/read_write.c:515
 write_pipe_buf+0x15d/0x1f0 fs/splice.c:809
 splice_from_pipe_feed fs/splice.c:512 [inline]
 __splice_from_pipe+0x3ee/0x7c0 fs/splice.c:636
 splice_from_pipe+0x108/0x170 fs/splice.c:671
 default_file_splice_write+0x3c/0x90 fs/splice.c:821
 do_splice_from fs/splice.c:863 [inline]
 do_splice+0xbae/0x1690 fs/splice.c:1170
 __do_sys_splice fs/splice.c:1447 [inline]
 __se_sys_splice fs/splice.c:1427 [inline]
 __x64_sys_splice+0x2c6/0x330 fs/splice.c:1427
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c6c9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffa3925ac78 EFLAGS: 00000246 ORIG_RAX: 0000000000000113
RAX: ffffffffffffffda RBX: 00007ffa3925b6d4 RCX: 000000000045c6c9
RDX: 0000000000000005 RSI: 0000000000000000 RDI: 0000000000000004
RBP: 000000000076bf20 R08: 0000000100000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000b6e R14: 00000000004ce22b R15: 000000000076bf2c


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
