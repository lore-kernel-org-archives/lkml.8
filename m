Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEACC2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 02:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB6820838
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 02:23:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCZCXR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 22:23:17 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:36192 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCZCXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 22:23:17 -0400
Received: by mail-io1-f70.google.com with SMTP id s66so3971392iod.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 19:23:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jjcklPTFG/JOSYDNzhoR0GP+m16dMXW/acVNxhkr13M=;
        b=B0rN5HLmvETh6YqJz7bg5Puv312V4HcfX2NFSTjslFrcMWukCEOifk4aC5pw2MxPzv
         25VfECg6pmsCtUmCpRQ5Vw7iQcLGxWt/XXlajbVcRoeTqSEqYnrhx+AN9EtWQPpashFV
         ivvSgAOjC1HZRfptsvo/bnCtTRM8/B6Qdl/bFiug/FhLMglZlIWansa4gxQQewwk3ZTv
         6R3ru2o8t209y6Go5AWCaG927ICzgG2jB1gFrzd3uzTqJ4iWJMWFiDAVmGIgCbDbDqBe
         dsW8vyhwlP3Js+Q6MOCTY6rac5UZl92RsoUJ4ghEhxUm13GzIORnnf1uyebGPZ8lxTw9
         vHtQ==
X-Gm-Message-State: ANhLgQ0i2vSzeJULrdLSmlDNxca2gBGDuONWU0/oWiuqvKOyxTwr8erS
        LL7KKswH3ZdnRX7rJwRTMsqIvtJ0oXL/1Wnhjbw6PWp/r+VZ
X-Google-Smtp-Source: ADFU+vuFdx8Cykk/wP3bq8+c/AkLZBEIcB0V4L0PJsrt3R+zE/w3/MvevFNXwK6+O5sTSo29elK7Oa1lRfpsKj/N0pkvckDpda4O
MIME-Version: 1.0
X-Received: by 2002:a92:8312:: with SMTP id f18mr6238159ild.98.1585189396481;
 Wed, 25 Mar 2020 19:23:16 -0700 (PDT)
Date:   Wed, 25 Mar 2020 19:23:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e10cb305a1b8aac6@google.com>
Subject: KASAN: stack-out-of-bounds Write in mpol_to_str
From:   syzbot <syzbot+b055b1a6b2b958707a21@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    e2cf67f6 Merge tag 'zonefs-5.6-rc7' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c4bd39e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2b05d5a033f5be50
dashboard link: https://syzkaller.appspot.com/bug?extid=b055b1a6b2b958707a21
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13252bf9e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1632c813e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+b055b1a6b2b958707a21@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: stack-out-of-bounds in set_bit include/asm-generic/bitops/instrumented-atomic.h:28 [inline]
BUG: KASAN: stack-out-of-bounds in __node_set include/linux/nodemask.h:130 [inline]
BUG: KASAN: stack-out-of-bounds in mpol_to_str+0x377/0x3be mm/mempolicy.c:2962
Write of size 8 at addr ffffc90000c7fb60 by task systemd/1

CPU: 0 PID: 1 Comm: systemd Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0x5/0x315 mm/kasan/report.c:374
 __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:641
 check_memory_region_inline mm/kasan/generic.c:185 [inline]
 check_memory_region+0x128/0x190 mm/kasan/generic.c:192
 set_bit include/asm-generic/bitops/instrumented-atomic.h:28 [inline]
 __node_set include/linux/nodemask.h:130 [inline]
 mpol_to_str+0x377/0x3be mm/mempolicy.c:2962
 shmem_show_mpol mm/shmem.c:1406 [inline]
 shmem_show_options+0x418/0x630 mm/shmem.c:3609
 show_mountinfo+0x616/0x900 fs/proc_namespace.c:187
 seq_read+0xad0/0x1160 fs/seq_file.c:268
 __vfs_read+0x76/0x100 fs/read_write.c:425
 vfs_read+0x1ea/0x430 fs/read_write.c:461
 ksys_read+0x127/0x250 fs/read_write.c:587
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f17892db92d
Code: 2d 2c 00 00 75 10 b8 00 00 00 00 0f 05 48 3d 01 f0 ff ff 73 31 c3 48 83 ec 08 e8 de 9b 01 00 48 89 04 24 b8 00 00 00 00 0f 05 <48> 8b 3c 24 48 89 c2 e8 27 9c 01 00 48 89 d0 48 83 c4 08 48 3d 01
RSP: 002b:00007ffc058b86b0 EFLAGS: 00000293 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000556657fec630 RCX: 00007f17892db92d
RDX: 0000000000000400 RSI: 0000556657fec860 RDI: 000000000000002c
RBP: 0000000000000d68 R08: 00007f178ad11500 R09: 00000000000000e0
R10: 0000556657fecc47 R11: 0000000000000293 R12: 00007f1789596440
R13: 00007f1789595900 R14: 0000000000000019 R15: 0000000000000000


addr ffffc90000c7fb60 is located in stack of task systemd/1 at offset 40 in frame:
 mpol_to_str+0x0/0x3be mm/mempolicy.c:2924

this frame has 1 object:
 [32, 40) 'nodes'

Memory state around the buggy address:
 ffffc90000c7fa00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffc90000c7fa80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffffc90000c7fb00: 00 00 00 00 00 00 00 f1 f1 f1 f1 00 f3 f3 f3 00
                                                       ^
 ffffc90000c7fb80: 00 00 00 00 00 00 00 00 00 00 f1 f1 f1 f1 00 00
 ffffc90000c7fc00: 00 00 00 00 00 00 f3 f3 f3 f3 00 00 00 00 00 00
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
