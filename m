Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE33C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 039352064A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgDFSQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:16:20 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:39583 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgDFSQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:16:15 -0400
Received: by mail-il1-f199.google.com with SMTP id w76so324600ila.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 11:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=qNP9UDy4Ly1/fSgo8ZGDVd9zXzm3XrXZBZreph/oOFo=;
        b=UgeW37An+XGwI3797R4tW01LCTFBHI+HbUx3HmkpPrJhdtXq6Oocs1m67t+9C7weKs
         XtPZ5eYFap64e3cNCYEqtSLWdP65URoVZoPVk9pj28bZPE6hza+kz5xLM0mey8kzqPTH
         H12I15F5tjUqF2l+cXH7x2O5FpgYt8Vgp/IUhgwEtpswkzSXqKSlNfKnUei8Aq/sqKrx
         hrMBHjP4e+gCgYRwxPrBbGsrKPLSPco9n76Kl+QhQAyme+c66WKNCDMDeoJ+HTvFt+ZL
         j6hAiZmy5itimjWulurgALv7GXsWR++XtZQdmafEl95p9L0lzf0Fqx0jgChGK8hfYz2o
         vmeQ==
X-Gm-Message-State: AGi0PuYMqjnPt322oXyGdNnYe20Q7OqJbE+ALbSSnfxdsgMTOf36plOe
        ZWRSjXnEuwWTXd78DIbCq/O9y7TPe7X9jlFKt9cDyFH0eQg6
X-Google-Smtp-Source: APiQypIHw/QFNnMEPb7wn/+NCy7yUgDe/gv7pno2an9Nkl/JIv8/B9KBw/oYfu05eW7vIon8xsuEO++3IcX7rqQSRsL8X2sqenT3
MIME-Version: 1.0
X-Received: by 2002:a92:8510:: with SMTP id f16mr651423ilh.208.1586196973821;
 Mon, 06 Apr 2020 11:16:13 -0700 (PDT)
Date:   Mon, 06 Apr 2020 11:16:13 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b25f105a2a3434d@google.com>
Subject: BUG: unable to handle kernel paging request in kernel_get_mempolicy
From:   syzbot <syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bgeffon@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        peterx@redhat.com, syzkaller-bugs@googlegroups.com,
        torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    bef7b2a7 Merge tag 'devicetree-for-5.7' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13966e8fe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=91b674b8f0368e69
dashboard link: https://syzkaller.appspot.com/bug?extid=693dc11fcb53120b5559
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1738b02be00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d2c76de00000

The bug was bisected to:

commit 4426e945df588f2878affddf88a51259200f7e29
Author: Peter Xu <peterx@redhat.com>
Date:   Thu Apr 2 04:08:49 2020 +0000

    mm/gup: allow VM_FAULT_RETRY for multiple times

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14ac4a5de00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=16ac4a5de00000
console output: https://syzkaller.appspot.com/x/log.txt?x=12ac4a5de00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")

BUG: unable to handle page fault for address: ffffffff00000000
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 987c067 P4D 987c067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 7181 Comm: syz-executor616 Not tainted 5.6.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:page_to_nid include/linux/mm.h:1245 [inline]
RIP: 0010:lookup_node mm/mempolicy.c:906 [inline]
RIP: 0010:do_get_mempolicy mm/mempolicy.c:970 [inline]
RIP: 0010:kernel_get_mempolicy+0x60e/0xfb0 mm/mempolicy.c:1615
Code: 88 00 07 00 00 e8 b2 35 c5 ff 4c 8b 7c 24 78 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 fb 08 00 00 <49> 8b 1f 48 c7 c7 ff ff ff ff 48 89 de e8 10 37 c5 ff 48 83 fb ff
RSP: 0018:ffffc900018d7de8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81adaaf1
RDX: 1fffffffe0000000 RSI: ffffffff81adaafe RDI: 0000000000000005
RBP: 0000000000000000 R08: ffff88808de924c0 R09: ffffed1011bd2499
R10: ffff88808de924c7 R11: ffffed1011bd2498 R12: 0000000000000000
R13: 1ffff9200031afc4 R14: ffffffff89a6df60 R15: ffffffff00000000
FS:  00007f848cd4a700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff00000000 CR3: 00000000a7a8d000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __do_sys_get_mempolicy mm/mempolicy.c:1633 [inline]
 __se_sys_get_mempolicy mm/mempolicy.c:1629 [inline]
 __x64_sys_get_mempolicy+0xba/0x150 mm/mempolicy.c:1629
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x446719
Code: e8 5c b3 02 00 48 83 c4 18 c3 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 0b 08 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f848cd49db8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ef
RAX: ffffffffffffffda RBX: 00000000006dbc28 RCX: 0000000000446719
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00000000006dbc20 R08: 0000000000000003 R09: 0000000000000000
R10: 000000002073b000 R11: 0000000000000246 R12: 00000000006dbc2c
R13: 00007ffcfe6ba66f R14: 00007f848cd4a9c0 R15: 20c49ba5e353f7cf
Modules linked in:
CR2: ffffffff00000000
---[ end trace 0becf554e06291c3 ]---
RIP: 0010:page_to_nid include/linux/mm.h:1245 [inline]
RIP: 0010:lookup_node mm/mempolicy.c:906 [inline]
RIP: 0010:do_get_mempolicy mm/mempolicy.c:970 [inline]
RIP: 0010:kernel_get_mempolicy+0x60e/0xfb0 mm/mempolicy.c:1615
Code: 88 00 07 00 00 e8 b2 35 c5 ff 4c 8b 7c 24 78 48 b8 00 00 00 00 00 fc ff df 4c 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 fb 08 00 00 <49> 8b 1f 48 c7 c7 ff ff ff ff 48 89 de e8 10 37 c5 ff 48 83 fb ff
RSP: 0018:ffffc900018d7de8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff81adaaf1
RDX: 1fffffffe0000000 RSI: ffffffff81adaafe RDI: 0000000000000005
RBP: 0000000000000000 R08: ffff88808de924c0 R09: ffffed1011bd2499
R10: ffff88808de924c7 R11: ffffed1011bd2498 R12: 0000000000000000
R13: 1ffff9200031afc4 R14: ffffffff89a6df60 R15: ffffffff00000000
FS:  00007f848cd4a700(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff00000000 CR3: 00000000a7a8d000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
