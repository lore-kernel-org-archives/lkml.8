Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8505C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9924A204EA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 08:58:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgFJI6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 04:58:17 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:49274 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgFJI6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 04:58:16 -0400
Received: by mail-il1-f198.google.com with SMTP id i7so1021501ilq.16
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 01:58:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=swBsRiPm3WFuS4YfdrHR8e1rZPo+xOvNbmYgDsiRTZk=;
        b=WW3KvB3MdWs1jN/ocNPmEAt1GYuWGmrtTZYi1h4o6t8v6hwhTNP1tqGTpdbDVTJo9x
         36Gx6dhn+vjlX5DMLnM4d5Zp6K8lfxEdNPyzvOc4p6qjVoHm94RerkuEbfBvXIngiuE6
         AyrHg9dEoCCwxquTzJiwCnbCIsuNqRDycWXclifTvGgFjtbH+qaQgXXZaZz4HXup3ma8
         t1uhr1klmEhaeJ0lqBS649JX9KJWSGcZoeZlkJetRRx7n6J8ZY0PXvYZPV7aR+SfOCBs
         1k7yvzinyaXR2UpQ5hQECyxGRWr8VjotEIjHXNaVv7K8I4rUUKAgETzU6yD/IhiJw3W3
         Ri7w==
X-Gm-Message-State: AOAM530tALNNKoAVg4SAi69pINsP2hDyveV8Z63b4KRmhDEl6d7YRdei
        CxZRHOsG83/5c2Berv9mFCWKVKwXWvj5KjbO0bkoKPAyBxyb
X-Google-Smtp-Source: ABdhPJzAUjLiryGcHMKtP83fEZZI4qQzZPQFlOL+8Kij6iFhyuErtrxM9GbRgMLnETWQy2tHCU9unKVyiPRCetqHrGnmR9yBfV5W
MIME-Version: 1.0
X-Received: by 2002:a6b:7b4a:: with SMTP id m10mr2258899iop.55.1591779495178;
 Wed, 10 Jun 2020 01:58:15 -0700 (PDT)
Date:   Wed, 10 Jun 2020 01:58:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ef79005a7b70b3c@google.com>
Subject: upstream test error: BUG: using smp_processor_id() in preemptible
 code in ext4_ext_map_blocks
From:   syzbot <syzbot+d541e928666fa26ff342@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    5b14671b Merge tag 'fuse-update-5.8' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10993196100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1ea633f7958e008
dashboard link: https://syzkaller.appspot.com/bug?extid=d541e928666fa26ff342
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d541e928666fa26ff342@syzkaller.appspotmail.com

BUG: using smp_processor_id() in preemptible [00000000] code: systemd-rfkill/6724
caller is ext4_mb_new_blocks+0xa77/0x3b30 fs/ext4/mballoc.c:4711
CPU: 0 PID: 6724 Comm: systemd-rfkill Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_preemption_disabled lib/smp_processor_id.c:47 [inline]
 debug_smp_processor_id.cold+0x88/0x9b lib/smp_processor_id.c:57
 ext4_ext_map_blocks+0x2044/0x3410 fs/ext4/extents.c:4244
 ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
 ext4_getblk+0xad/0x520 fs/ext4/inode.c:833
 ext4_bread+0x7c/0x380 fs/ext4/inode.c:883
 ext4_append+0x153/0x360 fs/ext4/namei.c:67
 ext4_init_new_dir fs/ext4/namei.c:2757 [inline]
 ext4_mkdir+0x5e0/0xdf0 fs/ext4/namei.c:2802
 vfs_mkdir+0x419/0x690 fs/namei.c:3641
 do_mkdirat+0x21e/0x280 fs/namei.c:3664
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x7fc488153687
Code: Bad RIP value.
RSP: 002b:00007fffc165c4d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 000055df97011985 RCX: 00007fc488153687
RDX: 00007fffc165c3a0 RSI: 00000000000001ed RDI: 000055df97011985
RBP: 00007fc488153680 R08: 0000000000000100 R09: 0000000000000000
R10: 000055df97011980 R11: 0000000000000246 R12: 00000000000001ed
R13: 00007fffc165c660 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
