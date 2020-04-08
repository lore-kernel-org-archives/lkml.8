Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680F8C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AAEF206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 07:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgDHHnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 03:43:18 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:53091 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgDHHnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 03:43:18 -0400
Received: by mail-il1-f199.google.com with SMTP id a79so5912562ill.19
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 00:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Yfh2racHXRGiiea0ss2C7ykuBCurPHg2w5+o2zZWepE=;
        b=KBzq44jj7T+riAc4PBd83E65Q5AwSXQisW0CVyvh3KKoEm0X70gfdwCxlu2ziieSt2
         n8rvSN4OfLcR9XckHECnlEtJZFnXk+IAws71Es8HNYegV78Ov3v0HC2gNzQbBxBNOcJO
         X63F+cvafADYLZV9I1FVQKNGEN1IR/Fgl1VTmAsVDzJqVLRTSjzhfrAjSlIMYw/E101v
         6kZi0X3XiXElszfv4FAJKBUpoMnG4PdxEz46KhSYkPMkvusyyBV2ph+pcufHZUFl7OjG
         +rN4iRLLTpTfqo/0XMObjpRqkgZRKoVeV8YuFWmHuQ94Z0q9x9q3flgvdibdKHsOU/Bj
         EzZw==
X-Gm-Message-State: AGi0PuZKPhFpA5BAqLGkaC5LdpuTTa+GtO2rq5dx0Zdrc9QwgdhnrvhU
        4hjtjtzqO0G4aAS3/yYIsT25muFJVGWSL/4RsobTHAWZuuMY
X-Google-Smtp-Source: APiQypKYhNsV7VhUUeknf5ONVUjMGdirW/1J2Rp3wbrY+qYaMmSb2s8pHA6fI3guQfzv6HLR6oXKgFLg/3OagJWEPuvfND9TuLSo
MIME-Version: 1.0
X-Received: by 2002:a05:6638:c44:: with SMTP id g4mr1832688jal.99.1586331797318;
 Wed, 08 Apr 2020 00:43:17 -0700 (PDT)
Date:   Wed, 08 Apr 2020 00:43:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004671b105a2c2a702@google.com>
Subject: general protection fault in kernel_get_mempolicy
From:   syzbot <syzbot+ceba41fd2d12f822c1bd@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bef7b2a7 Merge tag 'devicetree-for-5.7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=124974e7e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91b674b8f0368e69
dashboard link: https://syzkaller.appspot.com/bug?extid=ceba41fd2d12f822c1bd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ceba41fd2d12f822c1bd@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xf223931c0412cd20: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0x911cb8e020966900-0x911cb8e020966907]
CPU: 1 PID: 21483 Comm: syz-executor.5 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:page_to_nid include/linux/mm.h:1245 [inline]
RIP: 0010:lookup_node mm/mempolicy.c:906 [inline]
RIP: 0010:do_get_mempolicy mm/mempolicy.c:970 [inline]
RIP: 0010:kernel_get_mempolicy+0x604/0xfb0 mm/mempolicy.c:1615
Code: 89 c7 e8 2f 37 c5 ff 85 db 0f 88 00 07 00 00 e8 b2 35 c5 ff 4c 8b 7c 24 78 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 fb 08 00 00 49 8b 1f 48 c7 c7 ff ff ff ff 48 89
RSP: 0018:ffffc900055e7de8 EFLAGS: 00010a02
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90013b96000
RDX: 1223971c0412cd20 RSI: ffffffff81adaafe RDI: 0000000000000005
RBP: 0000000000000000 R08: ffff88802e0fe380 R09: ffffed1005c1fc71
R10: ffff88802e0fe387 R11: ffffed1005c1fc70 R12: 0000000000000000
R13: 1ffff92000abcfc4 R14: ffffffff89a6df60 R15: 911cb8e020966900
FS:  00007f93143f7700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b30b23000 CR3: 0000000052590000 CR4: 00000000001426e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __do_sys_get_mempolicy mm/mempolicy.c:1633 [inline]
 __se_sys_get_mempolicy mm/mempolicy.c:1629 [inline]
 __x64_sys_get_mempolicy+0xba/0x150 mm/mempolicy.c:1629
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45c849
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f93143f6c78 EFLAGS: 00000246 ORIG_RAX: 00000000000000ef
RAX: ffffffffffffffda RBX: 00007f93143f76d4 RCX: 000000000045c849
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 000000000076bf00 R08: 0000000000000003 R09: 0000000000000000
R10: 000000002073b000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 00000000000000eb R14: 00000000004c371a R15: 000000000076bf0c
Modules linked in:
---[ end trace 4f30e35dce9f5dd6 ]---
RIP: 0010:page_to_nid include/linux/mm.h:1245 [inline]
RIP: 0010:lookup_node mm/mempolicy.c:906 [inline]
RIP: 0010:do_get_mempolicy mm/mempolicy.c:970 [inline]
RIP: 0010:kernel_get_mempolicy+0x604/0xfb0 mm/mempolicy.c:1615
Code: 89 c7 e8 2f 37 c5 ff 85 db 0f 88 00 07 00 00 e8 b2 35 c5 ff 4c 8b 7c 24 78 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 fb 08 00 00 49 8b 1f 48 c7 c7 ff ff ff ff 48 89
RSP: 0018:ffffc900055e7de8 EFLAGS: 00010a02
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffc90013b96000
RDX: 1223971c0412cd20 RSI: ffffffff81adaafe RDI: 0000000000000005
RBP: 0000000000000000 R08: ffff88802e0fe380 R09: ffffed1005c1fc71
R10: ffff88802e0fe387 R11: ffffed1005c1fc70 R12: 0000000000000000
R13: 1ffff92000abcfc4 R14: ffffffff89a6df60 R15: 911cb8e020966900
FS:  00007f93143f7700(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f535ca3c000 CR3: 0000000052590000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
