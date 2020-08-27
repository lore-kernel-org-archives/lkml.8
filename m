Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7540C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC2620872
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbgH0W2R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:28:17 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:45773 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgH0W2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:28:16 -0400
Received: by mail-io1-f71.google.com with SMTP id q5so4892900ion.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:28:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sfsNcaggWfK0yNjpNiqr1Uope//+z/yI7A8OJwlBPcM=;
        b=nKbnUuj34OJYB4NFKZO20dJ60+hfGjPbIDJTGSAied2QQdumm3mP0hOnnqqn1OdYhq
         Az7K8H7X/6ZxOm+CjbDF0ah927Bv4UStDpdNvDYD8E5mUDb/8PVZYZedgnTiNa0sUxlC
         OtEK0pCLhRbSZWzx56h10fBUYVH5geqNAaRb83MOvAWmmx5rOiL8IJlcCB7RTV/mHsIN
         kvWIPARnmyEbYndazWBh/UnTCCnyg3Qp7LkQoJJrjP82z3kDyk7WwS11mZPR+G6Lxmh5
         rAuIqn2BgctIbWpQjdrK5+e5cq2gjgmgi+7aQ/pgo27WuAjap9a3j7A6qAgbN6P8H1KO
         rJsw==
X-Gm-Message-State: AOAM531VslwW0Fc748+RZO6JXyM0t8BlnSHGM/6Po/jUYnRMShzgr9IM
        xaUiZGZkSGEl85qbWccRR2AZadrCzpPv1GK545Ue9+U0kcTt
X-Google-Smtp-Source: ABdhPJyvj5uFHnai6YbZnL07mjqROiuohiY3ojkh8SeHRI23UEbn8OaqhnvZIukCuJQX5kmTPt8NjYhP5K/g0RRA42Lt/bkP7o9V
MIME-Version: 1.0
X-Received: by 2002:a5d:954f:: with SMTP id a15mr19066704ios.53.1598567295373;
 Thu, 27 Aug 2020 15:28:15 -0700 (PDT)
Date:   Thu, 27 Aug 2020 15:28:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ca5cfb05ade37394@google.com>
Subject: memory leak in prepare_creds
From:   syzbot <syzbot+71c4697e27c99fddcf17@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bernd.edlinger@hotmail.de,
        dhowells@redhat.com, ebiederm@xmission.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, shakeelb@google.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c3d8f220 Merge tag 'kbuild-fixes-v5.9' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14bf4f5e900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=948134d9ff96e950
dashboard link: https://syzkaller.appspot.com/bug?extid=71c4697e27c99fddcf17
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115a5519900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+71c4697e27c99fddcf17@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88812a413f00 (size 168):
  comm "syz-executor.0", pid 6554, jiffies 4294953946 (age 13.120s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000008b882031>] prepare_creds+0x25/0x2f0 kernel/cred.c:258
    [<000000001d1756e8>] copy_creds+0x2e/0x1d1 kernel/cred.c:358
    [<00000000a3a640ca>] copy_process+0x50c/0x1f20 kernel/fork.c:1949
    [<00000000a1ad8dee>] _do_fork+0xad/0x530 kernel/fork.c:2428
    [<0000000070af4cd7>] __do_sys_clone+0x76/0xa0 kernel/fork.c:2545
    [<000000001470b5cf>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000b4c4b313>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88811b54e440 (size 32):
  comm "syz-executor.0", pid 6554, jiffies 4294953946 (age 13.120s)
  hex dump (first 32 bytes):
    01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000138403e6>] kmalloc include/linux/slab.h:559 [inline]
    [<00000000138403e6>] kzalloc include/linux/slab.h:666 [inline]
    [<00000000138403e6>] lsm_cred_alloc security/security.c:532 [inline]
    [<00000000138403e6>] security_prepare_creds+0x97/0xc0 security/security.c:1631
    [<0000000051662e48>] prepare_creds+0x1e1/0x2f0 kernel/cred.c:285
    [<000000001d1756e8>] copy_creds+0x2e/0x1d1 kernel/cred.c:358
    [<00000000a3a640ca>] copy_process+0x50c/0x1f20 kernel/fork.c:1949
    [<00000000a1ad8dee>] _do_fork+0xad/0x530 kernel/fork.c:2428
    [<0000000070af4cd7>] __do_sys_clone+0x76/0xa0 kernel/fork.c:2545
    [<000000001470b5cf>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000b4c4b313>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88812a657a00 (size 256):
  comm "syz-executor.0", pid 6790, jiffies 4294953946 (age 13.120s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    a0 e1 14 2b 81 88 ff ff 80 74 8f 16 81 88 ff ff  ...+.....t......
  backtrace:
    [<0000000053e1d866>] kmem_cache_zalloc include/linux/slab.h:656 [inline]
    [<0000000053e1d866>] __alloc_file+0x23/0x120 fs/file_table.c:101
    [<000000000d5d3703>] alloc_empty_file+0x4f/0xe0 fs/file_table.c:151
    [<0000000091abea17>] alloc_file+0x31/0x160 fs/file_table.c:193
    [<000000004bfab74c>] alloc_file_pseudo+0xae/0x120 fs/file_table.c:233
    [<00000000fc9b3b90>] anon_inode_getfile fs/anon_inodes.c:91 [inline]
    [<00000000fc9b3b90>] anon_inode_getfile+0x8e/0x100 fs/anon_inodes.c:74
    [<00000000cbd9d057>] anon_inode_getfd+0x42/0x90 fs/anon_inodes.c:136
    [<00000000589d6af2>] bpf_map_new_fd kernel/bpf/syscall.c:686 [inline]
    [<00000000589d6af2>] bpf_map_new_fd kernel/bpf/syscall.c:678 [inline]
    [<00000000589d6af2>] map_create kernel/bpf/syscall.c:872 [inline]
    [<00000000589d6af2>] __do_sys_bpf+0x67c/0x2450 kernel/bpf/syscall.c:4160
    [<000000001470b5cf>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000b4c4b313>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88812a73db50 (size 16):
  comm "syz-executor.0", pid 6790, jiffies 4294953946 (age 13.120s)
  hex dump (first 16 bytes):
    01 00 00 00 01 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000008ddd472b>] kmem_cache_zalloc include/linux/slab.h:656 [inline]
    [<000000008ddd472b>] lsm_file_alloc security/security.c:567 [inline]
    [<000000008ddd472b>] security_file_alloc+0x2e/0xc0 security/security.c:1455
    [<0000000079d891d7>] __alloc_file+0x61/0x120 fs/file_table.c:106
    [<000000000d5d3703>] alloc_empty_file+0x4f/0xe0 fs/file_table.c:151
    [<0000000091abea17>] alloc_file+0x31/0x160 fs/file_table.c:193
    [<000000004bfab74c>] alloc_file_pseudo+0xae/0x120 fs/file_table.c:233
    [<00000000fc9b3b90>] anon_inode_getfile fs/anon_inodes.c:91 [inline]
    [<00000000fc9b3b90>] anon_inode_getfile+0x8e/0x100 fs/anon_inodes.c:74
    [<00000000cbd9d057>] anon_inode_getfd+0x42/0x90 fs/anon_inodes.c:136
    [<00000000589d6af2>] bpf_map_new_fd kernel/bpf/syscall.c:686 [inline]
    [<00000000589d6af2>] bpf_map_new_fd kernel/bpf/syscall.c:678 [inline]
    [<00000000589d6af2>] map_create kernel/bpf/syscall.c:872 [inline]
    [<00000000589d6af2>] __do_sys_bpf+0x67c/0x2450 kernel/bpf/syscall.c:4160
    [<000000001470b5cf>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000b4c4b313>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88812a419240 (size 168):
  comm "syz-executor.0", pid 6554, jiffies 4294954493 (age 7.650s)
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000008b882031>] prepare_creds+0x25/0x2f0 kernel/cred.c:258
    [<000000001d1756e8>] copy_creds+0x2e/0x1d1 kernel/cred.c:358
    [<00000000a3a640ca>] copy_process+0x50c/0x1f20 kernel/fork.c:1949
    [<00000000a1ad8dee>] _do_fork+0xad/0x530 kernel/fork.c:2428
    [<0000000070af4cd7>] __do_sys_clone+0x76/0xa0 kernel/fork.c:2545
    [<000000001470b5cf>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000b4c4b313>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
