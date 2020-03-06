Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6269C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C8420717
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 17:24:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgCFRYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 12:24:10 -0500
Received: from mail-io1-f80.google.com ([209.85.166.80]:56715 "EHLO
        mail-io1-f80.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgCFRYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 12:24:10 -0500
Received: by mail-io1-f80.google.com with SMTP id d13so1881153ioo.23
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 09:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=IZ6VmTHdl7NhBMpo0eSH8LA+stGdQmrwuQ2udc6q5jY=;
        b=M/qh642y5EZQCxpVBwKdmljn3i9ye6/KHfVRwQ8AdDSd7Qg9HR9EfwNDQxyw4ZVKFN
         YFaoj3TaAQDFrp4aKj4nav7nFP8JW8Ab98yO/LaPFAI/ffJ9CgVFyqoVjSPZvFln2x5n
         hO9seRAzAT06xeOV5B7O0mTF3amgxd3zKOQlIwQAu+kaG1QlC06excNvpZ+d0mTrJ3GV
         Yz1HbtmNhyQnZSrOCTirknVbD6VkMzmUtE3nffQpWHkj4I8/yWS1lGHbvrkPVJVKatZR
         N+YVD9lu8cGBLEn+FL8QV3rdW1THCWMMGE16Ich1XxQeJXbFKm47rsc/OcdkCiUXvZT4
         piSQ==
X-Gm-Message-State: ANhLgQ2y22T26gR9wJhIRpvawvvBEwHWP/a038jQTPha7gwsYwGA9Dtz
        nOEDmAyAdATB13LdxZr8Hybr8MxrYXIUmgkF21sTErXu3xoj
X-Google-Smtp-Source: ADFU+vu6U9NrY2mOyJ5Wh3UUC9/LZhQhiHPygFxcyO+cO3ZG193EWhb4Bi0U6ISx3M+MhF/DqL1N5TtCTLmQvpbghg9Siyv3F6hX
MIME-Version: 1.0
X-Received: by 2002:a92:216:: with SMTP id 22mr4196141ilc.53.1583515448967;
 Fri, 06 Mar 2020 09:24:08 -0800 (PST)
Date:   Fri, 06 Mar 2020 09:24:08 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d5157705a032eb4b@google.com>
Subject: BUG: Bad page map (4)
From:   syzbot <syzbot+5f10718b9688f3ce609e@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    c99b17ac Add linux-next specific files for 20200225
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1012fa81e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b7ebe4bd0931c45
dashboard link: https://syzkaller.appspot.com/bug?extid=5f10718b9688f3ce609e
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5f10718b9688f3ce609e@syzkaller.appspotmail.com

BUG: Bad page map in process udevd  pte:77007770 pmd:00172067
addr:00007f08bce11000 vm_flags:08000070 anon_vma:0000000000000000 mapping:ffff8880979b1b10 index:1aa
file:libnss_nis-2.13.so fault:ext4_filemap_fault mmap:ext4_file_mmap readpage:ext4_readpage
CPU: 0 PID: 16669 Comm: udevd Not tainted 5.6.0-rc3-next-20200225-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_bad_pte.cold+0x1d5/0x232 mm/memory.c:546
 vm_normal_page+0x244/0x3c0 mm/memory.c:609
 zap_pte_range mm/memory.c:1053 [inline]
 zap_pmd_range mm/memory.c:1184 [inline]
 zap_pud_range mm/memory.c:1213 [inline]
 zap_p4d_range mm/memory.c:1234 [inline]
 unmap_page_range+0x98f/0x2820 mm/memory.c:1255
 unmap_single_vma+0x19d/0x300 mm/memory.c:1300
 unmap_vmas+0x184/0x2f0 mm/memory.c:1332
 exit_mmap+0x2ba/0x530 mm/mmap.c:3141
 __mmput kernel/fork.c:1090 [inline]
 mmput+0x179/0x4d0 kernel/fork.c:1111
 exec_mmap fs/exec.c:1077 [inline]
 flush_old_exec+0x8ef/0x1e80 fs/exec.c:1310
 load_elf_binary+0x8ae/0x4ab0 fs/binfmt_elf.c:846
 search_binary_handler fs/exec.c:1688 [inline]
 search_binary_handler+0x16d/0x570 fs/exec.c:1665
 exec_binprm fs/exec.c:1731 [inline]
 __do_execve_file.isra.0+0x12fc/0x2270 fs/exec.c:1851
 do_execveat_common fs/exec.c:1897 [inline]
 do_execve fs/exec.c:1914 [inline]
 __do_sys_execve fs/exec.c:1990 [inline]
 __se_sys_execve fs/exec.c:1985 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:1985
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f08bd760207
Code: Bad RIP value.
RSP: 002b:00007fff1a787ec8 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f08bd760207
RDX: 0000000001f622f0 RSI: 00007fff1a787fc0 RDI: 00007fff1a788fd0
RBP: 0000000000625500 R08: 0000000000000ddf R09: 0000000000000ddf
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000001f622f0
R13: 0000000000000007 R14: 0000000001f50250 R15: 0000000000000005
BUG: Bad page map in process udevd  pte:00000700 pmd:00172067
addr:00007f08bcebb000 vm_flags:08000070 anon_vma:0000000000000000 mapping:ffff8880979aea50 index:49
file:libnsl-2.13.so fault:ext4_filemap_fault mmap:ext4_file_mmap readpage:ext4_readpage
CPU: 0 PID: 16669 Comm: udevd Tainted: G    B             5.6.0-rc3-next-20200225-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_bad_pte.cold+0x1d5/0x232 mm/memory.c:546
 vm_normal_page+0x244/0x3c0 mm/memory.c:609
 zap_pte_range mm/memory.c:1053 [inline]
 zap_pmd_range mm/memory.c:1184 [inline]
 zap_pud_range mm/memory.c:1213 [inline]
 zap_p4d_range mm/memory.c:1234 [inline]
 unmap_page_range+0x98f/0x2820 mm/memory.c:1255
 unmap_single_vma+0x19d/0x300 mm/memory.c:1300
 unmap_vmas+0x184/0x2f0 mm/memory.c:1332
 exit_mmap+0x2ba/0x530 mm/mmap.c:3141
 __mmput kernel/fork.c:1090 [inline]
 mmput+0x179/0x4d0 kernel/fork.c:1111
 exec_mmap fs/exec.c:1077 [inline]
 flush_old_exec+0x8ef/0x1e80 fs/exec.c:1310
 load_elf_binary+0x8ae/0x4ab0 fs/binfmt_elf.c:846
 search_binary_handler fs/exec.c:1688 [inline]
 search_binary_handler+0x16d/0x570 fs/exec.c:1665
 exec_binprm fs/exec.c:1731 [inline]
 __do_execve_file.isra.0+0x12fc/0x2270 fs/exec.c:1851
 do_execveat_common fs/exec.c:1897 [inline]
 do_execve fs/exec.c:1914 [inline]
 __do_sys_execve fs/exec.c:1990 [inline]
 __se_sys_execve fs/exec.c:1985 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:1985
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f08bd760207
Code: Bad RIP value.
RSP: 002b:00007fff1a787ec8 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f08bd760207
RDX: 0000000001f622f0 RSI: 00007fff1a787fc0 RDI: 00007fff1a788fd0
RBP: 0000000000625500 R08: 0000000000000ddf R09: 0000000000000ddf
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000001f622f0
R13: 0000000000000007 R14: 0000000001f50250 R15: 0000000000000005
swap_info_get: Bad swap file entry 3ffffffc44447
BUG: Bad page map in process udevd  pte:77777000 pmd:00172067
addr:00007f08bcf1b000 vm_flags:08000070 anon_vma:0000000000000000 mapping:ffff8880979aea50 index:a9
file:libnsl-2.13.so fault:ext4_filemap_fault mmap:ext4_file_mmap readpage:ext4_readpage
CPU: 0 PID: 16669 Comm: udevd Tainted: G    B             5.6.0-rc3-next-20200225-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_bad_pte.cold+0x1d5/0x232 mm/memory.c:546
 zap_pte_range mm/memory.c:1126 [inline]
 zap_pmd_range mm/memory.c:1184 [inline]
 zap_pud_range mm/memory.c:1213 [inline]
 zap_p4d_range mm/memory.c:1234 [inline]
 unmap_page_range+0x1cd6/0x2820 mm/memory.c:1255
 unmap_single_vma+0x19d/0x300 mm/memory.c:1300
 unmap_vmas+0x184/0x2f0 mm/memory.c:1332
 exit_mmap+0x2ba/0x530 mm/mmap.c:3141
 __mmput kernel/fork.c:1090 [inline]
 mmput+0x179/0x4d0 kernel/fork.c:1111
 exec_mmap fs/exec.c:1077 [inline]
 flush_old_exec+0x8ef/0x1e80 fs/exec.c:1310
 load_elf_binary+0x8ae/0x4ab0 fs/binfmt_elf.c:846
 search_binary_handler fs/exec.c:1688 [inline]
 search_binary_handler+0x16d/0x570 fs/exec.c:1665
 exec_binprm fs/exec.c:1731 [inline]
 __do_execve_file.isra.0+0x12fc/0x2270 fs/exec.c:1851
 do_execveat_common fs/exec.c:1897 [inline]
 do_execve fs/exec.c:1914 [inline]
 __do_sys_execve fs/exec.c:1990 [inline]
 __se_sys_execve fs/exec.c:1985 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:1985
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f08bd760207
Code: Bad RIP value.
RSP: 002b:00007fff1a787ec8 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f08bd760207
RDX: 0000000001f622f0 RSI: 00007fff1a787fc0 RDI: 00007fff1a788fd0
RBP: 0000000000625500 R08: 0000000000000ddf R09: 0000000000000ddf
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000001f622f0
R13: 0000000000000007 R14: 0000000001f50250 R15: 0000000000000005
BUG: Bad page map in process udevd  pte:00700777 pmd:00172067
addr:00007f08bcf65000 vm_flags:08000070 anon_vma:0000000000000000 mapping:ffff8880979aea50 index:f3
file:libnsl-2.13.so fault:ext4_filemap_fault mmap:ext4_file_mmap readpage:ext4_readpage
CPU: 0 PID: 16669 Comm: udevd Tainted: G    B             5.6.0-rc3-next-20200225-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_bad_pte.cold+0x1d5/0x232 mm/memory.c:546
 vm_normal_page+0x244/0x3c0 mm/memory.c:609
 zap_pte_range mm/memory.c:1053 [inline]
 zap_pmd_range mm/memory.c:1184 [inline]
 zap_pud_range mm/memory.c:1213 [inline]
 zap_p4d_range mm/memory.c:1234 [inline]
 unmap_page_range+0x98f/0x2820 mm/memory.c:1255
 unmap_single_vma+0x19d/0x300 mm/memory.c:1300
 unmap_vmas+0x184/0x2f0 mm/memory.c:1332
 exit_mmap+0x2ba/0x530 mm/mmap.c:3141
 __mmput kernel/fork.c:1090 [inline]
 mmput+0x179/0x4d0 kernel/fork.c:1111
 exec_mmap fs/exec.c:1077 [inline]
 flush_old_exec+0x8ef/0x1e80 fs/exec.c:1310
 load_elf_binary+0x8ae/0x4ab0 fs/binfmt_elf.c:846
 search_binary_handler fs/exec.c:1688 [inline]
 search_binary_handler+0x16d/0x570 fs/exec.c:1665
 exec_binprm fs/exec.c:1731 [inline]
 __do_execve_file.isra.0+0x12fc/0x2270 fs/exec.c:1851
 do_execveat_common fs/exec.c:1897 [inline]
 do_execve fs/exec.c:1914 [inline]
 __do_sys_execve fs/exec.c:1990 [inline]
 __se_sys_execve fs/exec.c:1985 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:1985
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f08bd760207
Code: Bad RIP value.
RSP: 002b:00007fff1a787ec8 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f08bd760207
RDX: 0000000001f622f0 RSI: 00007fff1a787fc0 RDI: 00007fff1a788fd0
RBP: 0000000000625500 R08: 0000000000000ddf R09: 0000000000000ddf
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000001f622f0
R13: 0000000000000007 R14: 0000000001f50250 R15: 0000000000000005
swap_info_get: Bad swap file entry 3ffffffffc7ff
BUG: Bad page map in process udevd  pte:00700000 pmd:00172067
addr:00007f08bcfba000 vm_flags:08000070 anon_vma:0000000000000000 mapping:ffff8880979aea50 index:148
file:libnsl-2.13.so fault:ext4_filemap_fault mmap:ext4_file_mmap readpage:ext4_readpage
CPU: 0 PID: 16669 Comm: udevd Tainted: G    B             5.6.0-rc3-next-20200225-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_bad_pte.cold+0x1d5/0x232 mm/memory.c:546
 zap_pte_range mm/memory.c:1126 [inline]
 zap_pmd_range mm/memory.c:1184 [inline]
 zap_pud_range mm/memory.c:1213 [inline]
 zap_p4d_range mm/memory.c:1234 [inline]
 unmap_page_range+0x1cd6/0x2820 mm/memory.c:1255
 unmap_single_vma+0x19d/0x300 mm/memory.c:1300
 unmap_vmas+0x184/0x2f0 mm/memory.c:1332
 exit_mmap+0x2ba/0x530 mm/mmap.c:3141
 __mmput kernel/fork.c:1090 [inline]
 mmput+0x179/0x4d0 kernel/fork.c:1111
 exec_mmap fs/exec.c:1077 [inline]
 flush_old_exec+0x8ef/0x1e80 fs/exec.c:1310
 load_elf_binary+0x8ae/0x4ab0 fs/binfmt_elf.c:846
 search_binary_handler fs/exec.c:1688 [inline]
 search_binary_handler+0x16d/0x570 fs/exec.c:1665
 exec_binprm fs/exec.c:1731 [inline]
 __do_execve_file.isra.0+0x12fc/0x2270 fs/exec.c:1851
 do_execveat_common fs/exec.c:1897 [inline]
 do_execve fs/exec.c:1914 [inline]
 __do_sys_execve fs/exec.c:1990 [inline]
 __se_sys_execve fs/exec.c:1985 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:1985
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f08bd760207
Code: Bad RIP value.
RSP: 002b:00007fff1a787ec8 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f08bd760207
RDX: 0000000001f622f0 RSI: 00007fff1a787fc0 RDI: 00007fff1a788fd0
RBP: 0000000000625500 R08: 0000000000000ddf R09: 0000000000000ddf
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000001f622f0
R13: 0000000000000007 R14: 0000000001f50250 R15: 0000000000000005
swap_info_get: Bad swap file entry 3fffffffc7c47
BUG: Bad page map in process udevd  pte:07077000 pmd:00173067
addr:00007f08bd00f000 vm_flags:08000070 anon_vma:0000000000000000 mapping:ffff8880979aea50 index:19d
file:libnsl-2.13.so fault:ext4_filemap_fault mmap:ext4_file_mmap readpage:ext4_readpage
CPU: 0 PID: 16669 Comm: udevd Tainted: G    B             5.6.0-rc3-next-20200225-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_bad_pte.cold+0x1d5/0x232 mm/memory.c:546
 zap_pte_range mm/memory.c:1126 [inline]
 zap_pmd_range mm/memory.c:1184 [inline]
 zap_pud_range mm/memory.c:1213 [inline]
 zap_p4d_range mm/memory.c:1234 [inline]
 unmap_page_range+0x1cd6/0x2820 mm/memory.c:1255
 unmap_single_vma+0x19d/0x300 mm/memory.c:1300
 unmap_vmas+0x184/0x2f0 mm/memory.c:1332
 exit_mmap+0x2ba/0x530 mm/mmap.c:3141
 __mmput kernel/fork.c:1090 [inline]
 mmput+0x179/0x4d0 kernel/fork.c:1111
 exec_mmap fs/exec.c:1077 [inline]
 flush_old_exec+0x8ef/0x1e80 fs/exec.c:1310
 load_elf_binary+0x8ae/0x4ab0 fs/binfmt_elf.c:846
 search_binary_handler fs/exec.c:1688 [inline]
 search_binary_handler+0x16d/0x570 fs/exec.c:1665
 exec_binprm fs/exec.c:1731 [inline]
 __do_execve_file.isra.0+0x12fc/0x2270 fs/exec.c:1851
 do_execveat_common fs/exec.c:1897 [inline]
 do_execve fs/exec.c:1914 [inline]
 __do_sys_execve fs/exec.c:1990 [inline]
 __se_sys_execve fs/exec.c:1985 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:1985
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f08bd760207
Code: Bad RIP value.
RSP: 002b:00007fff1a787ec8 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f08bd760207
RDX: 0000000001f622f0 RSI: 00007fff1a787fc0 RDI: 00007fff1a788fd0
RBP: 0000000000625500 R08: 0000000000000ddf R09: 0000000000000ddf
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000001f622f0
R13: 0000000000000007 R14: 0000000001f50250 R15: 0000000000000005
BUG: Bad page map in process udevd  pte:77770707 pmd:00173067
addr:00007f08bd064000 vm_flags:08000070 anon_vma:0000000000000000 mapping:ffff8880979aea50 index:1f2
file:libnsl-2.13.so fault:ext4_filemap_fault mmap:ext4_file_mmap readpage:ext4_readpage
CPU: 0 PID: 16669 Comm: udevd Tainted: G    B             5.6.0-rc3-next-20200225-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_bad_pte.cold+0x1d5/0x232 mm/memory.c:546
 vm_normal_page+0x244/0x3c0 mm/memory.c:609
 zap_pte_range mm/memory.c:1053 [inline]
 zap_pmd_range mm/memory.c:1184 [inline]
 zap_pud_range mm/memory.c:1213 [inline]
 zap_p4d_range mm/memory.c:1234 [inline]
 unmap_page_range+0x98f/0x2820 mm/memory.c:1255
 unmap_single_vma+0x19d/0x300 mm/memory.c:1300
 unmap_vmas+0x184/0x2f0 mm/memory.c:1332
 exit_mmap+0x2ba/0x530 mm/mmap.c:3141
 __mmput kernel/fork.c:1090 [inline]
 mmput+0x179/0x4d0 kernel/fork.c:1111
 exec_mmap fs/exec.c:1077 [inline]
 flush_old_exec+0x8ef/0x1e80 fs/exec.c:1310
 load_elf_binary+0x8ae/0x4ab0 fs/binfmt_elf.c:846
 search_binary_handler fs/exec.c:1688 [inline]
 search_binary_handler+0x16d/0x570 fs/exec.c:1665
 exec_binprm fs/exec.c:1731 [inline]
 __do_execve_file.isra.0+0x12fc/0x2270 fs/exec.c:1851
 do_execveat_common fs/exec.c:1897 [inline]
 do_execve fs/exec.c:1914 [inline]
 __do_sys_execve fs/exec.c:1990 [inline]
 __se_sys_execve fs/exec.c:1985 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:1985
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f08bd760207
Code: Bad RIP value.
RSP: 002b:00007fff1a787ec8 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f08bd760207
RDX: 0000000001f622f0 RSI: 00007fff1a787fc0 RDI: 00007fff1a788fd0
RBP: 0000000000625500 R08: 0000000000000ddf R09: 0000000000000ddf
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000001f622f0
R13: 0000000000000007 R14: 0000000001f50250 R15: 0000000000000005
swap_info_get: Bad swap file entry 3ffffffc7c7ff
BUG: Bad page map in process udevd  pte:70700000 pmd:00173067
addr:00007f08bd06f000 vm_flags:08000070 anon_vma:0000000000000000 mapping:ffff8880979aea50 index:1fd
file:libnsl-2.13.so fault:ext4_filemap_fault mmap:ext4_file_mmap readpage:ext4_readpage
CPU: 0 PID: 16669 Comm: udevd Tainted: G    B             5.6.0-rc3-next-20200225-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_bad_pte.cold+0x1d5/0x232 mm/memory.c:546
 zap_pte_range mm/memory.c:1126 [inline]
 zap_pmd_range mm/memory.c:1184 [inline]
 zap_pud_range mm/memory.c:1213 [inline]
 zap_p4d_range mm/memory.c:1234 [inline]
 unmap_page_range+0x1cd6/0x2820 mm/memory.c:1255
 unmap_single_vma+0x19d/0x300 mm/memory.c:1300
 unmap_vmas+0x184/0x2f0 mm/memory.c:1332
 exit_mmap+0x2ba/0x530 mm/mmap.c:3141
 __mmput kernel/fork.c:1090 [inline]
 mmput+0x179/0x4d0 kernel/fork.c:1111
 exec_mmap fs/exec.c:1077 [inline]
 flush_old_exec+0x8ef/0x1e80 fs/exec.c:1310
 load_elf_binary+0x8ae/0x4ab0 fs/binfmt_elf.c:846
 search_binary_handler fs/exec.c:1688 [inline]
 search_binary_handler+0x16d/0x570 fs/exec.c:1665
 exec_binprm fs/exec.c:1731 [inline]
 __do_execve_file.isra.0+0x12fc/0x2270 fs/exec.c:1851
 do_execveat_common fs/exec.c:1897 [inline]
 do_execve fs/exec.c:1914 [inline]
 __do_sys_execve fs/exec.c:1990 [inline]
 __se_sys_execve fs/exec.c:1985 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:1985
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f08bd760207
Code: Bad RIP value.
RSP: 002b:00007fff1a787ec8 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f08bd760207
RDX: 0000000001f622f0 RSI: 00007fff1a787fc0 RDI: 00007fff1a788fd0
RBP: 0000000000625500 R08: 0000000000000ddf R09: 0000000000000ddf
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000001f622f0
R13: 0000000000000007 R14: 0000000001f50250 R15: 0000000000000005
BUG: Bad page map in process udevd  pte:77000770 pmd:00173067
addr:00007f08bd10e000 vm_flags:08000070 anon_vma:0000000000000000 mapping:ffff8880979ac9d0 index:84
file:libnss_compat-2.13.so fault:ext4_filemap_fault mmap:ext4_file_mmap readpage:ext4_readpage
CPU: 0 PID: 16669 Comm: udevd Tainted: G    B             5.6.0-rc3-next-20200225-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_bad_pte.cold+0x1d5/0x232 mm/memory.c:546
 vm_normal_page+0x244/0x3c0 mm/memory.c:609
 zap_pte_range mm/memory.c:1053 [inline]
 zap_pmd_range mm/memory.c:1184 [inline]
 zap_pud_range mm/memory.c:1213 [inline]
 zap_p4d_range mm/memory.c:1234 [inline]
 unmap_page_range+0x98f/0x2820 mm/memory.c:1255
 unmap_single_vma+0x19d/0x300 mm/memory.c:1300
 unmap_vmas+0x184/0x2f0 mm/memory.c:1332
 exit_mmap+0x2ba/0x530 mm/mmap.c:3141
 __mmput kernel/fork.c:1090 [inline]
 mmput+0x179/0x4d0 kernel/fork.c:1111
 exec_mmap fs/exec.c:1077 [inline]
 flush_old_exec+0x8ef/0x1e80 fs/exec.c:1310
 load_elf_binary+0x8ae/0x4ab0 fs/binfmt_elf.c:846
 search_binary_handler fs/exec.c:1688 [inline]
 search_binary_handler+0x16d/0x570 fs/exec.c:1665
 exec_binprm fs/exec.c:1731 [inline]
 __do_execve_file.isra.0+0x12fc/0x2270 fs/exec.c:1851
 do_execveat_common fs/exec.c:1897 [inline]
 do_execve fs/exec.c:1914 [inline]
 __do_sys_execve fs/exec.c:1990 [inline]
 __se_sys_execve fs/exec.c:1985 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:1985
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f08bd760207
Code: Bad RIP value.
RSP: 002b:00007fff1a787ec8 EFLAGS: 00000202 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00000000ffffffff RCX: 00007f08bd760207
RDX: 0000000001f622f0 RSI: 00007fff1a787fc0 RDI: 00007fff1a788fd0
RBP: 0000000000625500 R08: 0000000000000ddf R09: 0000000000000ddf
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000001f622f0
R13: 0000000000000007 R14: 0000000001f50250 R15: 0000000000000005
BUG: Bad page map in process udevd  pte:77770770 pmd:00173067
addr:00007f08bd163000 vm_flags:08000070 anon_vma:0000000000000000 mapping:ffff8880979ac9d0 index:d9
file:libnss_compat-2.13.so fault:ext4_filemap_fault mmap:ext4_file_mmap readpage:ext4_readpage
CPU: 0 PID: 16669 Comm: udevd Tainted: G    B             5.6.0-rc3-next-20200225-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_bad_pte.cold+0x1d5/0x232 mm/memory.c:546
 vm_normal_page+0x244/0x3c0 mm/memory.c:609
 zap_pte_range mm/memory.c:1053 [inline]
 zap_pmd_range mm/memory.c:1184 [inline]
 zap_pud_range mm/memory.c:1213 [inline]
 zap_p4d_range mm/memory.c:1234 [inline]
 unmap_page_range+0x98f/0x2820 mm/memory.c:1255
 unmap_single_vma+0x19d/0x300 mm/memory.c:1300
 unmap_vmas+0x184/0x2f0 mm/memory.c:1332
 exit_mmap+0x2ba/0x530 mm/mmap.c:3141
 __mmput kernel/fork.c:1090 [inline]
 mmput+0x179/0x4d0 kernel/fork.c:1111
 exec_mmap fs/exec.c:1077 [inline]
 flush_old_exec+0x8ef/0x1e80 fs/exec.c:1310
 load_elf_binary+0x8ae/0x4ab0 fs/binfmt_elf.c:846
 search_binary_handler fs/exec.c:1688 [inline]
 search_binary_handler+0x16d/0x570 fs/exec.c:1665
 exec_binprm fs/exec.c:1731 [inline]
 __do_execve_file.isra.0+0x12fc/0x2270 fs/exec.c:1851
 do_execveat_common fs/exec.c:1897 [inline]
 do_execve fs/exec.c:1914 [inline]
 __do_sys_execve fs/exec.c:1990 [inline]
 __se_sys_execve fs/exec.c:1985 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:1985
 do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7f08bd760207
Code: Bad RIP value.
RSP: 002b:00007fff1a787ec8 EFLAGS: 00000202 ORIG_RAX: 000000000000003b


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
