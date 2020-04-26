Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58F0C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 08:58:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15AB20700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 08:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgDZI6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 04:58:12 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:37800 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgDZI6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 04:58:12 -0400
Received: by mail-io1-f72.google.com with SMTP id c26so16981157ioa.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 01:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gux4NOLxg7FiIqphQRtrzoaHRmZz99PEyeYy7f3Also=;
        b=sl04VV6pSg5lbxoJwSmzOK9e1Vr05fsUShS/QK/lpTG86IYoNizDauU8CodPEDGoMM
         ZxulxSsZAQ7E85kWU8/bLVi/J3AX3H79uLBXGZSwlExWfrgdIAlisA17mSMSrIrxs9wL
         meKASwjNoyh0Fl4IC5PxyOUiwiB97/fAbH2t2Myv/PsLOOcqEpj8TWVARvrHo57R3p/H
         EuGVFsjEoTIUc2kUm3/ArZ83xh0AAy2HB0148/5gopdLsCO9MIW85waAyUTKrc0m1QdS
         JF6cvB4KASYOZ/xW4CvB4pUaZnD90aqvx4LSo3o6tyA6D3Eo97SSLfR5uNbTVho5OaWQ
         Kv9g==
X-Gm-Message-State: AGi0Pubql6hSoyRNmsm9EtkfPqzFEvhR4DB+XdsGhyxGqKxQ+y98hJe4
        YSCPx3AJkkIL8z9An54wD0ykPCfOBqeUBJhfeuFcUi52SOPw
X-Google-Smtp-Source: APiQypJ5OalE0SFcIWfKO6srvl5NzOd/eYmpVSASb2cvC7CA6iNrgP0+G6FI/C5ZfTgCddDNkfszWpiXwhVqklSdVFM28cvaeTTj
MIME-Version: 1.0
X-Received: by 2002:a5e:a610:: with SMTP id q16mr16154599ioi.75.1587891490054;
 Sun, 26 Apr 2020 01:58:10 -0700 (PDT)
Date:   Sun, 26 Apr 2020 01:58:10 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034e65105a42dcc5e@google.com>
Subject: KASAN: use-after-free Read in get_block
From:   syzbot <syzbot+3b7b03a0c28948054fb5@syzkaller.appspotmail.com>
To:     danarag@gmail.com, deepa.kernel@gmail.com, dvlasenk@redhat.com,
        linux-kernel@vger.kernel.org, pombredanne@nexb.com,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    189522da Merge tag 'for_linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14193487e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b7a70e992f2f9b68
dashboard link: https://syzkaller.appspot.com/bug?extid=3b7b03a0c28948054fb5
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cb136fe00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fd5930100000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=122603f0100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=112603f0100000
console output: https://syzkaller.appspot.com/x/log.txt?x=162603f0100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+3b7b03a0c28948054fb5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in add_chain fs/minix/itree_common.c:14 [inline]
BUG: KASAN: use-after-free in get_branch fs/minix/itree_common.c:52 [inline]
BUG: KASAN: use-after-free in get_block+0x110f/0x1380 fs/minix/itree_common.c:160
Read of size 2 at addr ffff888082c493be by task syz-executor205/7041

CPU: 1 PID: 7041 Comm: syz-executor205 Not tainted 5.7.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x315 mm/kasan/report.c:382
 __kasan_report.cold+0x35/0x4d mm/kasan/report.c:511
 kasan_report+0x33/0x50 mm/kasan/common.c:625
 add_chain fs/minix/itree_common.c:14 [inline]
 get_branch fs/minix/itree_common.c:52 [inline]
 get_block+0x110f/0x1380 fs/minix/itree_common.c:160
 minix_get_block+0xe5/0x110 fs/minix/inode.c:376
 block_read_full_page+0x2bf/0x1010 fs/buffer.c:2290
 do_read_cache_page+0x1053/0x1810 mm/filemap.c:2768
 read_mapping_page include/linux/pagemap.h:397 [inline]
 dir_get_page.isra.0+0x1d/0x60 fs/minix/dir.c:70
 minix_find_entry+0x200/0x7b0 fs/minix/dir.c:170
 minix_inode_by_name+0x6d/0x452 fs/minix/dir.c:454
 minix_lookup fs/minix/namei.c:30 [inline]
 minix_lookup+0x103/0x190 fs/minix/namei.c:22
 lookup_open+0x8d7/0x1320 fs/namei.c:3060
 open_last_lookups fs/namei.c:3155 [inline]
 path_openat+0x93f/0x27d0 fs/namei.c:3343
 do_filp_open+0x192/0x260 fs/namei.c:3373
 do_sys_openat2+0x585/0x7d0 fs/open.c:1148
 do_sys_open+0xc3/0x140 fs/open.c:1164
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x445ef9
Code: ed cb fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 bb cb fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007ffc4f7dec58 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000445ef9
RDX: 0000000000000000 RSI: 0000000000020040 RDI: 0000000020000040
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000402fd0
R10: 00007ffc4f7deb30 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000402fd0 R14: 0000000000000000 R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea00020b1240 refcount:2 mapcount:0 mapping:000000007b3de2b2 index:0x2f24f
minix_aops name:"/"
flags: 0xfffe0000002016(referenced|uptodate|lru|private)
raw: 00fffe0000002016 ffffea0002389288 ffffea00020b1388 ffff8880846492e8
raw: 000000000002f24f ffff8880856d0ae0 00000002ffffffff ffff8880a9550000
page dumped because: kasan: bad access detected
page->mem_cgroup:ffff8880a9550000

Memory state around the buggy address:
 ffff888082c49280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888082c49300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888082c49380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
                                        ^
 ffff888082c49400: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888082c49480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
