Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB34C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 06:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E901724656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 06:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgB0GJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 01:09:14 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:52842 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgB0GJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 01:09:13 -0500
Received: by mail-io1-f70.google.com with SMTP id l62so2176889ioa.19
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 22:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Mghh8SCiDdbHvDX8JBCxoVgF15o5weHGC4OfyCFcXZQ=;
        b=dy5TdNYaiqTeBqO490ZH/u7Jbjcu1Kbw6g7z3bMmQiBmzT1j+3SnDEiAyz3DjdhxcU
         NROhcg/YdKuKRKsK/9BZC7x/Ep8H+K1fN0GC//RuZMvZW6nZp4OoQYyK18RHhPQz8NWU
         XaaWZwa+/gqwipbpE71foSShp+FosKnpqomB5CcFWSK12pwO95JyI0qxauVURAm2C+yg
         rTZA2QB0G1F6rRYXZy7QkLZbnwMGmN7J9L8HUCfdeg4XHk8f7YGEbJ7yte+CubQ4HU3p
         9c+g/hysB8Cm/HC7kxbns4daqxzgsiC9b8BZEoBDz47fzLjjTRrFCNMh7Y8jFDB/omXR
         A1DQ==
X-Gm-Message-State: APjAAAXps9nOuOACaz6eualBCYQ2br7iWkhP038/O49fFpx7xR085gJF
        AcfcdNELu4n5sMSCzuT/V3cG/6XvzvfTCaIEfY2IL++wqR+/
X-Google-Smtp-Source: APXvYqxGwmUJGnFtTxD5+jkI1/WYe0cDkI2Jl/oNwZusdut3sLbK9MlFM4lt46RaRvKB1AL9aWkHOzFomVNoiZKInuaEu5vlsFxa
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:ea9:: with SMTP id u9mr3571292ilj.40.1582783753318;
 Wed, 26 Feb 2020 22:09:13 -0800 (PST)
Date:   Wed, 26 Feb 2020 22:09:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005f77d6059f888f2e@google.com>
Subject: WARNING: kobject bug in add_one_compat_dev
From:   syzbot <syzbot+ab4dae63f7d310641ded@syzkaller.appspotmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    732a0dee Merge branch 'mlxfw-Improve-error-reporting-and-F..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17a17a29e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3b8906eb6a7d6028
dashboard link: https://syzkaller.appspot.com/bug?extid=ab4dae63f7d310641ded
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+ab4dae63f7d310641ded@syzkaller.appspotmail.com

kobject: (0000000004952746): attempted to be registered with empty name!
WARNING: CPU: 0 PID: 329 at lib/kobject.c:234 kobject_add_internal+0x7ac/0x9a0 lib/kobject.c:234
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 329 Comm: syz-executor.5 Not tainted 5.6.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 panic+0x2e3/0x75c kernel/panic.c:221
 __warn.cold+0x2f/0x3e kernel/panic.c:582
 report_bug+0x289/0x300 lib/bug.c:195
 fixup_bug arch/x86/kernel/traps.c:174 [inline]
 fixup_bug arch/x86/kernel/traps.c:169 [inline]
 do_error_trap+0x11b/0x200 arch/x86/kernel/traps.c:267
 do_invalid_op+0x37/0x50 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:kobject_add_internal+0x7ac/0x9a0 lib/kobject.c:234
Code: 1a 98 ca f9 e9 f0 f8 ff ff 4c 89 f7 e8 6d 98 ca f9 e9 95 f9 ff ff e8 c3 f0 8b f9 4c 89 e6 48 c7 c7 a0 0e 1a 89 e8 e3 41 5c f9 <0f> 0b 41 bd ea ff ff ff e9 52 ff ff ff e8 a2 f0 8b f9 0f 0b e8 9b
RSP: 0018:ffffc90005b27908 EFLAGS: 00010286
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000040000 RSI: ffffffff815eae46 RDI: fffff52000b64f13
RBP: ffffc90005b27960 R08: ffff88805aeba480 R09: ffffed1015d06659
R10: ffffed1015d06658 R11: ffff8880ae8332c7 R12: ffff8880a37fd000
R13: 0000000000000000 R14: ffff888096691780 R15: 0000000000000001
 kobject_add_varg lib/kobject.c:390 [inline]
 kobject_add+0x150/0x1c0 lib/kobject.c:442
 device_add+0x3be/0x1d00 drivers/base/core.c:2412
 add_one_compat_dev drivers/infiniband/core/device.c:901 [inline]
 add_one_compat_dev+0x46a/0x7e0 drivers/infiniband/core/device.c:857
 rdma_dev_init_net+0x2eb/0x490 drivers/infiniband/core/device.c:1120
 ops_init+0xb3/0x420 net/core/net_namespace.c:137
 setup_net+0x2d5/0x8b0 net/core/net_namespace.c:327
 copy_net_ns+0x29e/0x5a0 net/core/net_namespace.c:468
 create_new_namespaces+0x403/0xb50 kernel/nsproxy.c:108
 unshare_nsproxy_namespaces+0xc2/0x200 kernel/nsproxy.c:229
 ksys_unshare+0x444/0x980 kernel/fork.c:2955
 __do_sys_unshare kernel/fork.c:3023 [inline]
 __se_sys_unshare kernel/fork.c:3021 [inline]
 __x64_sys_unshare+0x31/0x40 kernel/fork.c:3021
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c429
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3be2b6dc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f3be2b6e6d4 RCX: 000000000045c429
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 000000000076bf20 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000c3e R14: 00000000004ce1f6 R15: 000000000076bf2c
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
