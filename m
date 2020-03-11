Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DEEC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2155121655
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 06:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgCKGoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 02:44:15 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:45908 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgCKGoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 02:44:14 -0400
Received: by mail-il1-f198.google.com with SMTP id h12so699873ils.12
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 23:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YtV7jGLGMcAp29GFO159t6p3b3YjpBCWK33ht3yH0pw=;
        b=DS1F2YVTbzu/AEWTr81Ce3Ua68EqQ5d4UYgUIYqJaUGb5HSReSkgaiRhVP8dXOrXNS
         dW10gtG21PpcbHGOBPNO9t9YSZrs/ByxypO/z+uR0rJhTIYT4+HiDUMpy28mKElVDEqR
         qNvDtk3+2qzuAPKVTHAfVc0weTqUF4Mg4Nz/AhBCfHXQlZykYDQBzYORjr0NFPUaQmmZ
         OOnN5MaNk9lPJYndDhyMXOeu7F5HL8LlFsR5qqnwpWzcVzOZFmduWDT3VWa6utlonh8R
         mGhlU8mxBaPrv5DAoBmnfuFAR0IcrQ6XAu7IiC2G2DNYU5UCQfE2mkvf2O+kgtGQ3SE+
         QWIA==
X-Gm-Message-State: ANhLgQ1thL29QVKDexNeyk2gPgLgQHjJjZ0+46XlxkUMMwQ+c62AT0S5
        dbncg6XzfiiHn6tX1PE+n9+I8kv/btpxc58e6svkURTYUu9k
X-Google-Smtp-Source: ADFU+vtB67Ml4ghGD81EjWvWukFQaiYCbuwypjU3u1gtlYZawe0DdIHGKgVuGltrfQmSZJAvX1xeZejsBj5NAOQC5/wt7DWOphzN
MIME-Version: 1.0
X-Received: by 2002:a92:d4d0:: with SMTP id o16mr1744420ilm.40.1583909052265;
 Tue, 10 Mar 2020 23:44:12 -0700 (PDT)
Date:   Tue, 10 Mar 2020 23:44:12 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006abbca05a08e902c@google.com>
Subject: BUG: unable to handle kernel paging request in tcf_action_destroy
From:   syzbot <syzbot+e30bd6a0f27d4d638567@syzkaller.appspotmail.com>
To:     davem@davemloft.net, jhs@mojatatu.com, jiri@resnulli.us,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    425c075d Merge branch 'tun-debug'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12a97f0de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=598678fc6e800071
dashboard link: https://syzkaller.appspot.com/bug?extid=e30bd6a0f27d4d638567
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e30bd6a0f27d4d638567@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffffffffffffff
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 9670067 P4D 9670067 PUD 9672067 PMD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 26046 Comm: syz-executor.3 Not tainted 5.6.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:tcf_action_destroy+0x75/0x150 net/sched/act_api.c:720
Code: 83 c3 08 89 ee e8 3b 27 48 fb 83 fd 20 0f 84 ae 00 00 00 e8 bd 25 48 fb 48 89 d8 48 c1 e8 03 42 80 3c 28 00 0f 85 ae 00 00 00 <4c> 8b 3b 4d 85 ff 0f 84 8b 00 00 00 e8 9a 25 48 fb 4c 89 f8 48 c7
RSP: 0018:ffffc90001c57028 EFLAGS: 00010246
RAX: 1fffffffffffffff RBX: ffffffffffffffff RCX: ffffc9000fec9000
RDX: 00000000000008d1 RSI: ffffffff8629ecd3 RDI: ffffffffffffffff
RBP: 0000000000000000 R08: ffff88805b4861c0 R09: ffffed1015ce7074
R10: ffffed1015ce7073 R11: ffff8880ae73839b R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f4bd1960700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffff CR3: 000000004a795000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 tcf_exts_destroy+0x42/0xc0 net/sched/cls_api.c:3001
 tcf_exts_change+0xf4/0x150 net/sched/cls_api.c:3059
 tcindex_set_parms+0xed8/0x1a00 net/sched/cls_tcindex.c:456
 tcindex_change+0x203/0x2e0 net/sched/cls_tcindex.c:518
 tc_new_tfilter+0xa59/0x20b0 net/sched/cls_api.c:2103
 rtnetlink_rcv_msg+0x810/0xad0 net/core/rtnetlink.c:5431
 netlink_rcv_skb+0x15a/0x410 net/netlink/af_netlink.c:2478
 netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
 netlink_unicast+0x537/0x740 net/netlink/af_netlink.c:1329
 netlink_sendmsg+0x882/0xe10 net/netlink/af_netlink.c:1918
 sock_sendmsg_nosec net/socket.c:652 [inline]
 sock_sendmsg+0xcf/0x120 net/socket.c:672
 ____sys_sendmsg+0x6b9/0x7d0 net/socket.c:2343
 ___sys_sendmsg+0x100/0x170 net/socket.c:2397
 __sys_sendmsg+0xec/0x1b0 net/socket.c:2430
 do_syscall_64+0xf6/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c4a9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f4bd195fc78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f4bd19606d4 RCX: 000000000045c4a9
RDX: 0000000000000000 RSI: 00000000200001c0 RDI: 0000000000000003
RBP: 000000000076bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000009fa R14: 00000000004cc777 R15: 000000000076bf2c
Modules linked in:
CR2: ffffffffffffffff
---[ end trace c654cd1e2ba461f1 ]---
RIP: 0010:tcf_action_destroy+0x75/0x150 net/sched/act_api.c:720
Code: 83 c3 08 89 ee e8 3b 27 48 fb 83 fd 20 0f 84 ae 00 00 00 e8 bd 25 48 fb 48 89 d8 48 c1 e8 03 42 80 3c 28 00 0f 85 ae 00 00 00 <4c> 8b 3b 4d 85 ff 0f 84 8b 00 00 00 e8 9a 25 48 fb 4c 89 f8 48 c7
RSP: 0018:ffffc90001c57028 EFLAGS: 00010246
RAX: 1fffffffffffffff RBX: ffffffffffffffff RCX: ffffc9000fec9000
RDX: 00000000000008d1 RSI: ffffffff8629ecd3 RDI: ffffffffffffffff
RBP: 0000000000000000 R08: ffff88805b4861c0 R09: ffffed1015ce7074
R10: ffffed1015ce7073 R11: ffff8880ae73839b R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000001 R15: 0000000000000000
FS:  00007f4bd1960700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffff CR3: 000000004a795000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
