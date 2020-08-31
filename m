Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE70BC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9118620707
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 16:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgHaQ6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 12:58:31 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:35370 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgHaQ6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:58:22 -0400
Received: by mail-il1-f197.google.com with SMTP id p16so2466450ilp.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:58:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Ve3fMaP+GgxKOYA2jQMbUsBIcbQ4arT97D2zd8YTu2Q=;
        b=sRBNo/L79y4XVEMWuF3UvM59MgV1G+kEc7wE6LYdjeRFLLg+9v/6MY3ssPjLgGpKaB
         aeJEpQlN21LVOIipLf/y32hmGTDLM2McBNet2lbrbTqLPz26B6Qgz6X18r5kFVcneGko
         YgOk3eVYcHng2z8R/gGwUUB/yyT3e/eBe4jgeni5O9J+Plk0+HHcCpIFw8mPBatJxlpd
         UzJUPMkaHKPK6ECVcBEPv5W276c0DEMej2j4rCdkbtnQSWdBdBvAkFNYoTXPGzx+8ON0
         zB99iMGrWZphJwSigvQFVYwGsHzg0NvXANU01jhUuZcGNCvu9czYNc4CbioXI5haIIMf
         x21Q==
X-Gm-Message-State: AOAM531mk1ucQZAWqcr/BEb7o/gdxC+KJEKmIWU54PwndfRadGe5k8qU
        i3GcZjWgdcX1NlL836i+JYs0He0wvDigBz9z48YeUe2GqoS4
X-Google-Smtp-Source: ABdhPJzebhMi2YVlQFv285w6irW+P0ujyzgsqNUG/Nz0LVkoTR+LISYvXb9Tq45g6gErJc3xGQPz6sdNe3TLeT7IuWRIkJdkg24k
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ca3:: with SMTP id 3mr2232309ilg.227.1598893101210;
 Mon, 31 Aug 2020 09:58:21 -0700 (PDT)
Date:   Mon, 31 Aug 2020 09:58:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000054e22905ae2f4fae@google.com>
Subject: WARNING in chnl_net_uninit
From:   syzbot <syzbot+ef72fb13d1c081833ebe@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        wangyunjian@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    4d41ead6 Merge tag 'block-5.9-2020-08-28' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100cf1de900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ebdb650dfa501c1
dashboard link: https://syzkaller.appspot.com/bug?extid=ef72fb13d1c081833ebe
compiler:       gcc (GCC) 10.1.0-syz 20200507
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ef72fb13d1c081833ebe@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 3 PID: 11918 at net/caif/chnl_net.c:67 robust_list_del net/caif/chnl_net.c:67 [inline]
WARNING: CPU: 3 PID: 11918 at net/caif/chnl_net.c:67 chnl_net_uninit+0xc9/0x2dc net/caif/chnl_net.c:380
Kernel panic - not syncing: panic_on_warn set ...
CPU: 2 PID: 11918 Comm: syz-executor.1 Not tainted 5.9.0-rc2-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:231
 __warn.cold+0x20/0x4a kernel/panic.c:600
 report_bug+0x1bd/0x210 lib/bug.c:198
 handle_bug+0x38/0x90 arch/x86/kernel/traps.c:234
 exc_invalid_op+0x14/0x40 arch/x86/kernel/traps.c:254
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:536
RIP: 0010:robust_list_del net/caif/chnl_net.c:67 [inline]
RIP: 0010:chnl_net_uninit+0xc9/0x2dc net/caif/chnl_net.c:380
Code: 89 eb e8 3a 44 b0 f9 48 89 d8 48 c1 e8 03 42 80 3c 28 00 0f 85 bf 01 00 00 48 81 fb 60 ba a5 8a 48 8b 2b 75 d0 e8 17 44 b0 f9 <0f> 0b 5b 5d 41 5c 41 5d e9 0a 44 b0 f9 4c 89 e3 e8 02 44 b0 f9 4c
RSP: 0000:ffffc90001707070 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffffffff8aa5ba60 RCX: ffffffff87c3fa72
RDX: ffff88802797d800 RSI: ffffffff87c3faf9 RDI: 0000000000000005
RBP: ffffffff8aa5ba60 R08: 0000000000000000 R09: ffffffff8a7e73e7
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88805fdd6d88
R13: ffff88805fdd6000 R14: dffffc0000000000 R15: ffff888023b07f80
 rollback_registered_many+0xa7a/0x1210 net/core/dev.c:9300


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
