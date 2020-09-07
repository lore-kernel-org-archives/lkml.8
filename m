Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7001DC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4689F217A0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 21:38:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbgIGVis (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 17:38:48 -0400
Received: from mail-il1-f207.google.com ([209.85.166.207]:40251 "EHLO
        mail-il1-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgIGViW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 17:38:22 -0400
Received: by mail-il1-f207.google.com with SMTP id g188so10608849ilh.7
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 14:38:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=R5dhbd1kdkcgMyAGfhuVfrBhTKEzGI7jgwcgg/qLjgA=;
        b=FHsaoB/YbCoC5GD8Pe5oLtbfO8uCkztxVdDZ/l5Hi+BwW71coSDMgsGI7Ac7h4u7n7
         dm+hopbXqG9y5CUSksUC3YTwCFAwl7890KIIKY4RsNxPIp1iqVkLsWx1t+AkoAfgbvs+
         /ACIkLuSw9L3BPGpM3/Ry+8kye41TYjEvoMcI6FeltCxfJHnmogPb77dlUP4261h4kGO
         kvdTUZkHh8Gcg/gCbpbi7w46Xeu5AH7Te6oRPyggiDkNZkjmhTS3WMfwECJPaceCFVx3
         HE0QLPHIiFVOUTLAujPDQ95Pxc8CofNVucSjs5HOR1JKMYo0VDFG/WXQAOFWbf4+PqPX
         BOBw==
X-Gm-Message-State: AOAM530Hod0ENZJ78FueCDA1ckAFizmyskxQojd7tGVanTNvUXgzhYtV
        iIM1gDJJRP87PcN0r4I5WIoT5GEb1AUVsEEIPusrYbMYRi9O
X-Google-Smtp-Source: ABdhPJzliQi/m7INB68wkxG7vZYa4xsfP2sBRSQm1xAaU6V7FFTld9rlLNyqcKdQLMzpZc4OZP9t+qyugvLiN4+liwCvqhlSpCEh
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:4a1:: with SMTP id e1mr21374824ils.113.1599514701522;
 Mon, 07 Sep 2020 14:38:21 -0700 (PDT)
Date:   Mon, 07 Sep 2020 14:38:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098ed0505aec00954@google.com>
Subject: WARNING: refcount bug in qrtr_recvmsg
From:   syzbot <syzbot+d0f27d9af17914bf253b@syzkaller.appspotmail.com>
To:     bjorn.andersson@linaro.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, manivannan.sadhasivam@linaro.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c70672d8 Merge tag 's390-5.9-5' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=163f0c31900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd46548257448703
dashboard link: https://syzkaller.appspot.com/bug?extid=d0f27d9af17914bf253b
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=124cc6a5900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11436195900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d0f27d9af17914bf253b@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 0 PID: 118 at lib/refcount.c:25 refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 118 Comm: kworker/u4:3 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: qrtr_ns_handler qrtr_ns_worker
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x198/0x1fd lib/dump_stack.c:118
 panic+0x347/0x7c0 kernel/panic.c:231
 __warn.cold+0x20/0x46 kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
Code: 07 31 ff 89 de e8 e7 df d8 fd 84 db 0f 85 36 ff ff ff e8 9a e3 d8 fd 48 c7 c7 00 dc 93 88 c6 05 67 18 12 07 01 e8 09 e7 a9 fd <0f> 0b e9 17 ff ff ff e8 7b e3 d8 fd 0f b6 1d 4c 18 12 07 31 ff 89
RSP: 0018:ffffc900013479d8 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880a8dd4000 RSI: ffffffff815db9a7 RDI: fffff52000268f2d
RBP: 0000000000000002 R08: 0000000000000001 R09: ffff8880ae620f8b
R10: 0000000000000000 R11: 0000000038313154 R12: ffff88821b0f4040
R13: ffff888095619c00 R14: ffff8880a87eb7f0 R15: ffff8880a87eb7f4
 refcount_add include/linux/refcount.h:204 [inline]
 refcount_inc include/linux/refcount.h:241 [inline]
 kref_get include/linux/kref.h:45 [inline]
 qrtr_node_acquire net/qrtr/qrtr.c:196 [inline]
 qrtr_node_lookup net/qrtr/qrtr.c:388 [inline]
 qrtr_send_resume_tx net/qrtr/qrtr.c:980 [inline]
 qrtr_recvmsg+0x845/0x970 net/qrtr/qrtr.c:1043
 sock_recvmsg_nosec net/socket.c:885 [inline]
 sock_recvmsg net/socket.c:903 [inline]
 sock_recvmsg net/socket.c:899 [inline]
 kernel_recvmsg+0x110/0x160 net/socket.c:928
 qrtr_ns_worker+0x15a/0x14fc net/qrtr/ns.c:624
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Shutting down cpus with NMI
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
