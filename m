Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A06C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 05:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D748420665
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 05:43:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgCIFnR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 01:43:17 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:40718 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIFnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 01:43:17 -0400
Received: by mail-io1-f71.google.com with SMTP id m24so5938524iol.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 22:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=lej4BEptjJW9JruDzkwbSSJ6dnEJwxXB1HgbAhByq9k=;
        b=TFVRTk0Y4biEhepb8B0f7y/vaiFCHLYbwH9XvotK4vpA5ZqW41D2pemZaSYy6P513f
         Gem2tK1n+LFA2RZVSKz7AZpMGgLgwwLzUph3PNGLtb5Gv4Cox7kGtn6arsndY2P4W0k/
         m+PTn4bMNT4BfEJIfnFI7oEQGqusMo2gP70AmK/QiUR6VyPOJA+l2P0apoaKD9hkXQwC
         zFkMDUfqOGu3GvjYX7eBMX1ghuG0xZKY26QrDjUbXfxjkgvsyLeFWDLR+ozCv2yKq4bc
         ATcv7yuQxYU+qrAcGHiT0UA6u9n8H9Hi85RIPO82Uy0xRi0Nxxu7cenoypUXzO3d0t8/
         gTrQ==
X-Gm-Message-State: ANhLgQ3HI21AhV5Ck8LQXsLcKwj2bCxEuG8f8EfiGRiIZfiYOMep7uQI
        XOkprfeCrPFALpNpsZedzqFQF5k0y9/WiRf53xmhORjiovaV
X-Google-Smtp-Source: ADFU+vumYX7oNgDqklDDdvea8gzEwb+rjm8WHBNS0jkNiUy1+gA5T6MO2ERptQYxh1o1X1Q676tSRLXEXyeShoX/1PDbbmKOzLnW
MIME-Version: 1.0
X-Received: by 2002:a5d:9ac1:: with SMTP id x1mr11899552ion.144.1583732595170;
 Sun, 08 Mar 2020 22:43:15 -0700 (PDT)
Date:   Sun, 08 Mar 2020 22:43:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1213405a0657a16@google.com>
Subject: KASAN: use-after-free Read in ext4_xattr_set_entry (3)
From:   syzbot <syzbot+15fbdaa8666ea08754f4@syzkaller.appspotmail.com>
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

HEAD commit:    c2003765 Merge tag 'io_uring-5.6-2020-03-07' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1671b01de00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4527d1e2fb19fd5c
dashboard link: https://syzkaller.appspot.com/bug?extid=15fbdaa8666ea08754f4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+15fbdaa8666ea08754f4@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in memmove include/linux/string.h:396 [inline]
BUG: KASAN: use-after-free in ext4_xattr_set_entry+0xafc/0x34f0 fs/ext4/xattr.c:1714
Read of size 4 at addr ffff888035a85ffe by task syz-executor.3/12471

CPU: 1 PID: 12471 Comm: syz-executor.3 Not tainted 5.6.0-rc4-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x315 mm/kasan/report.c:374
 __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:641
 check_memory_region_inline mm/kasan/generic.c:185 [inline]
 check_memory_region+0x128/0x190 mm/kasan/generic.c:192
 memmove+0x20/0x50 mm/kasan/common.c:117
 memmove include/linux/string.h:396 [inline]
 ext4_xattr_set_entry+0xafc/0x34f0 fs/ext4/xattr.c:1714
 ext4_xattr_ibody_set+0x78/0x2b0 fs/ext4/xattr.c:2216
 ext4_xattr_set_handle+0x933/0x1200 fs/ext4/xattr.c:2372
 ext4_xattr_set+0x1fc/0x390 fs/ext4/xattr.c:2484
 __vfs_setxattr+0x10e/0x170 fs/xattr.c:150
 __vfs_setxattr_noperm+0x11a/0x410 fs/xattr.c:181
 vfs_setxattr+0xd2/0xf0 fs/xattr.c:224
 setxattr+0x23d/0x330 fs/xattr.c:451
 path_setxattr+0x170/0x190 fs/xattr.c:470
 __do_sys_setxattr fs/xattr.c:485 [inline]
 __se_sys_setxattr fs/xattr.c:481 [inline]
 __x64_sys_setxattr+0xc0/0x160 fs/xattr.c:481
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x45c4a9
Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ff39057ac78 EFLAGS: 00000246 ORIG_RAX: 00000000000000bc
RAX: ffffffffffffffda RBX: 00007ff39057b6d4 RCX: 000000000045c4a9
RDX: 00000000200000c0 RSI: 0000000020000040 RDI: 0000000020000000
RBP: 000000000076bf20 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000016 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000b49 R14: 00000000004d77d8 R15: 000000000076bf2c

The buggy address belongs to the page:
page:ffffea0000d6a140 refcount:2 mapcount:0 mapping:ffff8880a2f5dba0 index:0x43a
def_blk_aops
flags: 0xfffe000000203a(referenced|dirty|lru|active|private)
raw: 00fffe000000203a ffffea00010ca048 ffffea00010d3ac8 ffff8880a2f5dba0
raw: 000000000000043a ffff888086c77930 00000002ffffffff ffff88804831c000
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff88804831c000

Memory state around the buggy address:
 ffff888035a85f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888035a85f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888035a86000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                   ^
 ffff888035a86080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888035a86100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
