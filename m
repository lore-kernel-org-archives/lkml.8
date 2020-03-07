Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3E7C10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 21:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230DE2077C
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 21:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgCGVFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 16:05:12 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:47557 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgCGVFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 16:05:11 -0500
Received: by mail-il1-f200.google.com with SMTP id a4so4455611ili.14
        for <linux-kernel@vger.kernel.org>; Sat, 07 Mar 2020 13:05:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=O1ccFeNcaK8O1b3uUp4LiaEXL8aJeslQL+A0Zwji8U0=;
        b=VPzb7imKYurzm7RN91OoneMIy4ruVu4OqLIOPgSrbEzkNbS00WiRY70X1++MWnvJ4P
         j6sOvifNg6QADB8zCni+mwFvWY8jfSGWvWGyNPpFbnhDiS+t8lgqUwPcids6LmTjxQA+
         6pbkkbbRczu5FUc8HuUeG0nVfggrdd103bWAIAKjk0ajynQVuGk/QEbZyVJUH+tXkknw
         eT7RT4/4QoQgr4iM/r3KGRw6dc7X4cwqiawCMnXJqRhpzVYoLOn+Y+bg9HVEWi7bh6J8
         S/FsYfyIfOzHR8bXKEtQb6VSMZCAmbb4uuFGkKjZXz1Hypguu1wUJA0b7dAfsN4eC6TK
         r68A==
X-Gm-Message-State: ANhLgQ1b39SNZ8rUkP+UvbU/4txv/vKsAve9CCSA/nDa/7xrXChGIbE6
        VLn8Y0GW0PtFrs4h7jnknGS+5lVZfs/ussLgXtQk7uGGtVuX
X-Google-Smtp-Source: ADFU+vuUZiUcXNLMejnvQX9m1BhaeK/4+otxEb29NkXyHXCgmY51ipzqKu0Rt6/WI/MsIsqGUJQaCqk4xGwKgwwhj0Wn6XLSF8CH
MIME-Version: 1.0
X-Received: by 2002:a92:d09:: with SMTP id 9mr8484060iln.191.1583615110700;
 Sat, 07 Mar 2020 13:05:10 -0800 (PST)
Date:   Sat, 07 Mar 2020 13:05:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000022640205a04a20d8@google.com>
Subject: linux-next test error: BUG: using __this_cpu_read() in preemptible
 code in __mod_memcg_state
From:   syzbot <syzbot+826543256ed3b8c37f62@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhocko@kernel.org,
        syzkaller-bugs@googlegroups.com, vdavydov.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b86a6a24 Add linux-next specific files for 20200306
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1766b731e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c79dccc623ccc6f
dashboard link: https://syzkaller.appspot.com/bug?extid=826543256ed3b8c37f62
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+826543256ed3b8c37f62@syzkaller.appspotmail.com

check_preemption_disabled: 3 callbacks suppressed
BUG: using __this_cpu_read() in preemptible [00000000] code: syz-fuzzer/9432
caller is __mod_memcg_state+0x27/0x1a0 mm/memcontrol.c:689
CPU: 1 PID: 9432 Comm: syz-fuzzer Not tainted 5.6.0-rc4-next-20200306-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 check_preemption_disabled lib/smp_processor_id.c:47 [inline]
 __this_cpu_preempt_check.cold+0x84/0x90 lib/smp_processor_id.c:64
 __mod_memcg_state+0x27/0x1a0 mm/memcontrol.c:689
 __split_huge_page mm/huge_memory.c:2575 [inline]
 split_huge_page_to_list+0x124b/0x3380 mm/huge_memory.c:2862
 split_huge_page include/linux/huge_mm.h:167 [inline]
 madvise_free_huge_pmd+0x873/0xb90 mm/huge_memory.c:1766
 madvise_free_pte_range+0x6ff/0x2650 mm/madvise.c:584
 walk_pmd_range mm/pagewalk.c:89 [inline]
 walk_pud_range mm/pagewalk.c:160 [inline]
 walk_p4d_range mm/pagewalk.c:193 [inline]
 walk_pgd_range mm/pagewalk.c:229 [inline]
 __walk_page_range+0xcfb/0x2070 mm/pagewalk.c:331
 walk_page_range+0x1bd/0x3a0 mm/pagewalk.c:427
 madvise_free_single_vma+0x384/0x550 mm/madvise.c:731
 madvise_dontneed_free mm/madvise.c:819 [inline]
 madvise_vma mm/madvise.c:958 [inline]
 do_madvise mm/madvise.c:1161 [inline]
 do_madvise+0x5ba/0x1b80 mm/madvise.c:1084
 __do_sys_madvise mm/madvise.c:1189 [inline]
 __se_sys_madvise mm/madvise.c:1187 [inline]
 __x64_sys_madvise+0xae/0x120 mm/madvise.c:1187
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x460bf7
Code: 8b 24 24 48 8b 6c 24 10 48 83 c4 18 c3 cc cc cc cc cc cc 48 8b 7c 24 08 48 8b 74 24 10 8b 54 24 18 48 c7 c0 1c 00 00 00 0f 05 <89> 44 24 20 c3 cc cc cc cc 48 8b 7c 24 08 8b 74 24 10 8b 54 24 14
RSP: 002b:00007ffd6e086670 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 0000000000460bf7
RDX: 0000000000000008 RSI: 000000000000a000 RDI: 000000c00029a000
RBP: 00007ffd6e0866b0 R08: 000000c000200000 R09: 000000c0002a4000
R10: 00007fffffffffff R11: 0000000000000246 R12: 0000000000000007
R13: 00007f30cae546d0 R14: 0000000000000080 R15: 00000000000000fa
BUG: using __this_cpu_add() in preemptible [00000000] code: syz-fuzzer/9432
caller is __mod_memcg_state+0xca/0x1a0 mm/memcontrol.c:697
CPU: 1 PID: 9432 Comm: syz-fuzzer Not tainted 5.6.0-rc4-next-20200306-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 check_preemption_disabled lib/smp_processor_id.c:47 [inline]
 __this_cpu_preempt_check.cold+0x84/0x90 lib/smp_processor_id.c:64
 __mod_memcg_state+0xca/0x1a0 mm/memcontrol.c:697
 __split_huge_page mm/huge_memory.c:2575 [inline]
 split_huge_page_to_list+0x124b/0x3380 mm/huge_memory.c:2862
 split_huge_page include/linux/huge_mm.h:167 [inline]
 madvise_free_huge_pmd+0x873/0xb90 mm/huge_memory.c:1766
 madvise_free_pte_range+0x6ff/0x2650 mm/madvise.c:584
 walk_pmd_range mm/pagewalk.c:89 [inline]
 walk_pud_range mm/pagewalk.c:160 [inline]
 walk_p4d_range mm/pagewalk.c:193 [inline]
 walk_pgd_range mm/pagewalk.c:229 [inline]
 __walk_page_range+0xcfb/0x2070 mm/pagewalk.c:331
 walk_page_range+0x1bd/0x3a0 mm/pagewalk.c:427
 madvise_free_single_vma+0x384/0x550 mm/madvise.c:731
 madvise_dontneed_free mm/madvise.c:819 [inline]
 madvise_vma mm/madvise.c:958 [inline]
 do_madvise mm/madvise.c:1161 [inline]
 do_madvise+0x5ba/0x1b80 mm/madvise.c:1084
 __do_sys_madvise mm/madvise.c:1189 [inline]
 __se_sys_madvise mm/madvise.c:1187 [inline]
 __x64_sys_madvise+0xae/0x120 mm/madvise.c:1187
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x460bf7
Code: 8b 24 24 48 8b 6c 24 10 48 83 c4 18 c3 cc cc cc cc cc cc 48 8b 7c 24 08 48 8b 74 24 10 8b 54 24 18 48 c7 c0 1c 00 00 00 0f 05 <89> 44 24 20 c3 cc cc cc cc 48 8b 7c 24 08 8b 74 24 10 8b 54 24 14
RSP: 002b:00007ffd6e086670 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 0000000000460bf7
RDX: 0000000000000008 RSI: 000000000000a000 RDI: 000000c00029a000
RBP: 00007ffd6e0866b0 R08: 000000c000200000 R09: 000000c0002a4000
R10: 00007fffffffffff R11: 0000000000000246 R12: 0000000000000007
R13: 00007f30cae546d0 R14: 0000000000000080 R15: 00000000000000fa
BUG: using __this_cpu_write() in preemptible [00000000] code: syz-fuzzer/9432
caller is __mod_memcg_state+0x87/0x1a0 mm/memcontrol.c:702
CPU: 1 PID: 9432 Comm: syz-fuzzer Not tainted 5.6.0-rc4-next-20200306-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 check_preemption_disabled lib/smp_processor_id.c:47 [inline]
 __this_cpu_preempt_check.cold+0x84/0x90 lib/smp_processor_id.c:64
 __mod_memcg_state+0x87/0x1a0 mm/memcontrol.c:702
 __split_huge_page mm/huge_memory.c:2575 [inline]
 split_huge_page_to_list+0x124b/0x3380 mm/huge_memory.c:2862
 split_huge_page include/linux/huge_mm.h:167 [inline]
 madvise_free_huge_pmd+0x873/0xb90 mm/huge_memory.c:1766
 madvise_free_pte_range+0x6ff/0x2650 mm/madvise.c:584
 walk_pmd_range mm/pagewalk.c:89 [inline]
 walk_pud_range mm/pagewalk.c:160 [inline]
 walk_p4d_range mm/pagewalk.c:193 [inline]
 walk_pgd_range mm/pagewalk.c:229 [inline]
 __walk_page_range+0xcfb/0x2070 mm/pagewalk.c:331
 walk_page_range+0x1bd/0x3a0 mm/pagewalk.c:427
 madvise_free_single_vma+0x384/0x550 mm/madvise.c:731
 madvise_dontneed_free mm/madvise.c:819 [inline]
 madvise_vma mm/madvise.c:958 [inline]
 do_madvise mm/madvise.c:1161 [inline]
 do_madvise+0x5ba/0x1b80 mm/madvise.c:1084
 __do_sys_madvise mm/madvise.c:1189 [inline]
 __se_sys_madvise mm/madvise.c:1187 [inline]
 __x64_sys_madvise+0xae/0x120 mm/madvise.c:1187
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x460bf7
Code: 8b 24 24 48 8b 6c 24 10 48 83 c4 18 c3 cc cc cc cc cc cc 48 8b 7c 24 08 48 8b 74 24 10 8b 54 24 18 48 c7 c0 1c 00 00 00 0f 05 <89> 44 24 20 c3 cc cc cc cc 48 8b 7c 24 08 8b 74 24 10 8b 54 24 14
RSP: 002b:00007ffd6e086670 EFLAGS: 00000246 ORIG_RAX: 000000000000001c
RAX: ffffffffffffffda RBX: 0000000000000008 RCX: 0000000000460bf7
RDX: 0000000000000008 RSI: 000000000000a000 RDI: 000000c00029a000
RBP: 00007ffd6e0866b0 R08: 000000c000200000 R09: 000000c0002a4000
R10: 00007fffffffffff R11: 0000000000000246 R12: 0000000000000007
R13: 00007f30cae546d0 R14: 0000000000000080 R15: 00000000000000fa


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
