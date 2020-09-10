Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420BAC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED805208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgIJVoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:44:13 -0400
Received: from mail-io1-f80.google.com ([209.85.166.80]:48490 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbgIJMzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 08:55:43 -0400
Received: by mail-io1-f80.google.com with SMTP id u3so4231758iow.15
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 05:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=CJdeGnfvTdFShzW3CvkO0Zv30IHEQqOXfaVuXTwQMzk=;
        b=FwJZ/lQV+3pwKXvrZcYzYpzmjGcs+k2k+jxmPmEVf7kKIdWO9NIDne3Rzi/b7157Nv
         1p8i+OMNrNvTkLUlMAWOjLFqC2o7lINoa0jISCcnqH4lsmCtTERrK5lNLIN2VV+rCmiw
         IEzFOwFxUmG1HYxL8MgRyVUrKUKFvhQu0OnD5Gj9oV2pPv+aSf64e5BPVpcLJaTZDOEb
         qnzpOTz2iqG6MLUNfb5TU3gRq/91XjqePIp9KSDGn884zcJo6CGaEnNoO5Fgl5olfSUR
         OnsxY6VwSnVIhwys5CnuAOUqnZ+HADXEZU7tZHHtuKQtbqyaZK/mBfSJBxJtjlZOie5D
         ky4A==
X-Gm-Message-State: AOAM532OwO9HrslW/n1YCPhOIU5QHpuxnEcPwKDOzjqfO9lHY2zYCE0d
        CS9V1HQilEo6DPdHtfX2CrTj52iwGCfq6rpy3ezTqOhP4fPI
X-Google-Smtp-Source: ABdhPJzhzNIDm37fSE+kzTV+nR7ABFssw+mTyY+5bOgc61FzQgFtzAXuSg+9m11NqJCiF2JQlZQK2Cvdbtt11HMFFbuchT8TW6Gr
MIME-Version: 1.0
X-Received: by 2002:a6b:2c44:: with SMTP id s65mr7251195ios.185.1599742521360;
 Thu, 10 Sep 2020 05:55:21 -0700 (PDT)
Date:   Thu, 10 Sep 2020 05:55:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b7c4dd05aef51494@google.com>
Subject: BUG: unable to handle kernel paging request in free_swap_cache
From:   syzbot <syzbot+b41193cb6e40673119c1@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    dd9fb9bb Merge tags 'auxdisplay-for-linus-v5.9-rc4', 'clan..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164e35cd900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bd46548257448703
dashboard link: https://syzkaller.appspot.com/bug?extid=b41193cb6e40673119c1
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b41193cb6e40673119c1@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffea007777777f
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 12fff8067 P4D 12fff8067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 10690 Comm: syz-executor.2 Not tainted 5.9.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:compound_head include/linux/page-flags.h:182 [inline]
RIP: 0010:PageSwapCache include/linux/page-flags.h:391 [inline]
RIP: 0010:free_swap_cache+0x32/0x300 mm/swap_state.c:325
Code: 49 89 fc 55 4d 8d 6c 24 08 53 e8 49 10 c7 ff 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 85 02 00 00 <4d> 8b 74 24 08 31 ff 4c 89 e5 4c 89 f3 83 e3 01 48 89 de e8 b6 0c
RSP: 0018:ffffc900088a76d0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff888000143848 RCX: ffffffff81ad73c2
RDX: 1ffffd400eeeeeef RSI: ffffffff81ad3ab7 RDI: ffffea0077777777
RBP: 0000000000000107 R08: 0000000000000000 R09: ffffea00018ec9c7
R10: 00000000000001fe R11: 0000000000000000 R12: ffffea0077777777
R13: ffffea007777777f R14: dffffc0000000000 R15: ffffc900088a7a80
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffea007777777f CR3: 0000000214b08000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 free_pages_and_swap_cache+0x58/0x90 mm/swap_state.c:353
 tlb_batch_pages_flush mm/mmu_gather.c:49 [inline]
 tlb_flush_mmu_free mm/mmu_gather.c:242 [inline]
 tlb_flush_mmu+0xe9/0x6b0 mm/mmu_gather.c:249
 zap_pte_range mm/memory.c:1159 [inline]
 zap_pmd_range mm/memory.c:1197 [inline]
 zap_pud_range mm/memory.c:1226 [inline]
 zap_p4d_range mm/memory.c:1247 [inline]
 unmap_page_range+0x1e22/0x2b20 mm/memory.c:1268
 unmap_single_vma+0x198/0x300 mm/memory.c:1313
 unmap_vmas+0x168/0x2e0 mm/memory.c:1345
 exit_mmap+0x2b1/0x530 mm/mmap.c:3183
 __mmput+0x122/0x470 kernel/fork.c:1076
 mmput+0x53/0x60 kernel/fork.c:1097
 exit_mm kernel/exit.c:483 [inline]
 do_exit+0xa8b/0x29f0 kernel/exit.c:793
 do_group_exit+0x125/0x310 kernel/exit.c:903
 get_signal+0x428/0x1f00 kernel/signal.c:2757
 arch_do_signal+0x82/0x2520 arch/x86/kernel/signal.c:811
 exit_to_user_mode_loop kernel/entry/common.c:136 [inline]
 exit_to_user_mode_prepare+0x1ae/0x200 kernel/entry/common.c:167
 syscall_exit_to_user_mode+0x7e/0x2e0 kernel/entry/common.c:242
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45d5b9
Code: Bad RIP value.
RSP: 002b:00007f77c0d90cf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 000000000118cf48 RCX: 000000000045d5b9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 000000000118cf4c
RBP: 000000000118cf40 R08: 000000000000000e R09: 0000000000000000
R10: 0000000000000003 R11: 0000000000000246 R12: 000000000118cf4c
R13: 000000000169fb6f R14: 00007f77c0d919c0 R15: 000000000118cf4c
Modules linked in:
CR2: ffffea007777777f
---[ end trace 07566fd2f7a76eaf ]---
RIP: 0010:compound_head include/linux/page-flags.h:182 [inline]
RIP: 0010:PageSwapCache include/linux/page-flags.h:391 [inline]
RIP: 0010:free_swap_cache+0x32/0x300 mm/swap_state.c:325
Code: 49 89 fc 55 4d 8d 6c 24 08 53 e8 49 10 c7 ff 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 0f 85 85 02 00 00 <4d> 8b 74 24 08 31 ff 4c 89 e5 4c 89 f3 83 e3 01 48 89 de e8 b6 0c
RSP: 0018:ffffc900088a76d0 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff888000143848 RCX: ffffffff81ad73c2
RDX: 1ffffd400eeeeeef RSI: ffffffff81ad3ab7 RDI: ffffea0077777777
RBP: 0000000000000107 R08: 0000000000000000 R09: ffffea00018ec9c7
R10: 00000000000001fe R11: 0000000000000000 R12: ffffea0077777777
R13: ffffea007777777f R14: dffffc0000000000 R15: ffffc900088a7a80
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffea007777777f CR3: 0000000214b08000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
