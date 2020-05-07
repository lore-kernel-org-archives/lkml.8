Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F770C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D1A324962
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:46:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgEGKqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:46:23 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:45936 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgEGKqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:46:22 -0400
Received: by mail-il1-f199.google.com with SMTP id t10so5474552ilf.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 03:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=9YRWNw876Bp8+RmqR18Bh/B8o4vq3mVySMJDoaPo78I=;
        b=LlwjGPRjuxDaN+Sv58UKXb2VOvIgwXEZqCF+VjqsvFGphCzfI4cLCe4k9QhfMbZgwq
         s+3c1MhE4cgjPViu8eFk2u2urlOShBEuDtJsXMi+LQg+XaHMQW3CeGV0aPwH7H5b0Asj
         LG1bGXGFYTDa8R5qcjOOUyYwWKMxs110Csnsmwpot2JDVrzgzkjK0cEmx3sc8LMqfmhW
         zd7dTIFjSvDiJrDS8viAqWMkT51Q9/X2ThHMXQb5llSRLEFbt0Va2HKUCdlETZfYQ+I3
         e8+AH6tvQR5Gjk8pXxxNgkTwAOBcfU10l+ygzPNNJ1j4AbPxA5oPbEWEDBWT32wuPOc/
         cLxQ==
X-Gm-Message-State: AGi0PuY4ZdaOqKVhb7/OoiH3QC7HQaG7GXv0P5/rO0wKe4MllR8+EkI/
        ra0NIcqU705XWZ/Z3+ZAAtnLlWFGQ/5DU+aHN+VM0EH+KYNP
X-Google-Smtp-Source: APiQypLZ1mH9vdaWQ7RH36ivcn/YcJmE7731qHRTs1kDszQknDE/kUGrr1WNJytmBVo8urs1em4AwKOhaHu8zZNEjv4Z9sCTNHGb
MIME-Version: 1.0
X-Received: by 2002:a02:a408:: with SMTP id c8mr13213757jal.143.1588848380014;
 Thu, 07 May 2020 03:46:20 -0700 (PDT)
Date:   Thu, 07 May 2020 03:46:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004af71905a50c973a@google.com>
Subject: KASAN: use-after-free Write in get_block
From:   syzbot <syzbot+c7d9ec7a1a7272dd71b3@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, danarag@gmail.com,
        deepa.kernel@gmail.com, jack@suse.cz, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ac935d22 Add linux-next specific files for 20200415
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13f7824c100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc498783097e9019
dashboard link: https://syzkaller.appspot.com/bug?extid=c7d9ec7a1a7272dd71b3
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=100a1660100000

Bisection is inconclusive: the bug happens on the oldest tested release.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=135471e4100000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=10d471e4100000
console output: https://syzkaller.appspot.com/x/log.txt?x=175471e4100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+c7d9ec7a1a7272dd71b3@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: use-after-free in alloc_branch fs/minix/itree_common.c:92 [inline]
BUG: KASAN: use-after-free in get_block+0x1202/0x1380 fs/minix/itree_common.c:191
Write of size 2 at addr ffff888083a817b8 by task syz-executor.0/7219

CPU: 0 PID: 7219 Comm: syz-executor.0 Not tainted 5.7.0-rc1-next-20200415-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x315 mm/kasan/report.c:382
 __kasan_report.cold+0x35/0x4d mm/kasan/report.c:511
 kasan_report+0x33/0x50 mm/kasan/common.c:625
 alloc_branch fs/minix/itree_common.c:92 [inline]
 get_block+0x1202/0x1380 fs/minix/itree_common.c:191
 minix_get_block+0xe5/0x110 fs/minix/inode.c:376
 __block_write_begin_int+0x490/0x1b00 fs/buffer.c:2039
 __block_write_begin fs/buffer.c:2089 [inline]
 block_write_begin+0x58/0x2e0 fs/buffer.c:2148
 minix_write_begin+0x35/0xe0 fs/minix/inode.c:412
 generic_perform_write+0x20a/0x4e0 mm/filemap.c:3308
 __generic_file_write_iter+0x24c/0x610 mm/filemap.c:3437
 generic_file_write_iter+0x3f3/0x630 mm/filemap.c:3469
 call_write_iter include/linux/fs.h:1907 [inline]
 new_sync_write+0x4a2/0x700 fs/read_write.c:484
 __vfs_write+0xc9/0x100 fs/read_write.c:497
 __kernel_write+0x11c/0x3a0 fs/read_write.c:516
 do_acct_process+0xcdc/0x10e0 kernel/acct.c:522
 acct_pin_kill+0x29/0xf0 kernel/acct.c:174
 pin_kill+0x175/0x7c0 fs/fs_pin.c:44
 mnt_pin_kill+0x6c/0x1c0 fs/fs_pin.c:81
 cleanup_mnt+0x3c4/0x4b0 fs/namespace.c:1092
 task_work_run+0xf4/0x1b0 kernel/task_work.c:123
 tracehook_notify_resume include/linux/tracehook.h:188 [inline]
 exit_to_usermode_loop+0x2fa/0x360 arch/x86/entry/common.c:165
 prepare_exit_to_usermode arch/x86/entry/common.c:196 [inline]
 syscall_return_slowpath arch/x86/entry/common.c:279 [inline]
 do_syscall_64+0x6b1/0x7d0 arch/x86/entry/common.c:305
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x45f257
Code: 64 89 04 25 d0 02 00 00 58 5f ff d0 48 89 c7 e8 8f be ff ff 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48> 3d 01 f0 ff ff 0f 83 ad 8c fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fff1bed8a48 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000045f257
RDX: 0000000000402ff8 RSI: 0000000000000002 RDI: 00007fff1bed8af0
RBP: 0000000000000014 R08: 0000000000000000 R09: 0000000000000009
R10: 0000000000000005 R11: 0000000000000246 R12: 00007fff1bed9b80
R13: 0000000001b28940 R14: 0000000000000000 R15: 00007fff1bed9b80

The buggy address belongs to the page:
page:ffffea00020ea040 refcount:0 mapcount:0 mapping:0000000033e8f566 index:0x1
flags: 0xfffe0000000000()
raw: 00fffe0000000000 ffffea00021c95c8 ffffea00020e9d48 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888083a81680: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888083a81700: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>ffff888083a81780: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                                        ^
 ffff888083a81800: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
 ffff888083a81880: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
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
