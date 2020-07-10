Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3E9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:24:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C14C20772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgGJMYS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:24:18 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:36833 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJMYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:24:16 -0400
Received: by mail-il1-f200.google.com with SMTP id t19so3581145ili.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 05:24:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=y5vv/dujPQlUXRTAis6P0BlyNCg1PALvDt1jQDbSjYU=;
        b=Odtgdf92ze8tuaiSpH2Es2DtjsJipio0IxJpEnoXFq8xCWjpX7XODiEtKpRUfBNiFJ
         xIVcrq4T9BY9GBnRQFCaenXDd3ziNkRKSTmT8dOTGFs+QrCY/4+m2IPfUvfqdCNw2w0Z
         hIEFvqbGiqQC7NyKtOUYt5vbKQEqYo/99iF7lzJv89gWEB3ltUKaQhSLqyFclgHk7ron
         fvsjL3fSjL15o4NgiXhkqeEYPwwlb/a7p1UwJRvqdoQhrsB2XhVyzY6utgITP93PLwyw
         vs8F6zdXGgvUVCSV2CRuSUSmB2HQrFDB0yGXN8VnoJejgdSlGHFnwBjrcUcIYS3T5g/D
         wYYw==
X-Gm-Message-State: AOAM533Shl+UEU91nS4rvqwlWtSk5ZVvVH9P3Rv4STXiBXDSimg4LXsj
        lwGcpCxd+9ugV5dGd2v2l1nijPv2+WDqCf75I9Dj+WepEEwj
X-Google-Smtp-Source: ABdhPJzBTBQ7rktGVxYWO1ZecbA7q8AoikhNx7NLZ4YQ658D1Z6v7zEQr6WiOFpzUIm6Hjq7VvOkETyV/7JJrtbO4dRGLLZm3/70
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:13e2:: with SMTP id w2mr53226289ilj.9.1594383855551;
 Fri, 10 Jul 2020 05:24:15 -0700 (PDT)
Date:   Fri, 10 Jul 2020 05:24:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000588c2c05aa156b2b@google.com>
Subject: kernel BUG at mm/vmalloc.c:LINE! (2)
From:   syzbot <syzbot+5f326d255ca648131f87@syzkaller.appspotmail.com>
To:     bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7cc2a8ea Merge tag 'block-5.8-2020-07-01' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129af755100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=183dd243398ba7ec
dashboard link: https://syzkaller.appspot.com/bug?extid=5f326d255ca648131f87
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+5f326d255ca648131f87@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/vmalloc.c:553!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3491 Comm: syz-executor.2 Not tainted 5.8.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:find_va_links mm/vmalloc.c:549 [inline]
RIP: 0010:merge_or_add_vmap_area mm/vmalloc.c:778 [inline]
RIP: 0010:__purge_vmap_area_lazy+0x18af/0x18c0 mm/vmalloc.c:1381
Code: e1 07 80 c1 03 38 c1 0f 8c f9 e8 ff ff 48 c7 c7 c8 2b 6d 89 e8 22 81 09 00 e9 e8 e8 ff ff e8 38 82 ca ff 0f 0b e8 31 82 ca ff <0f> 0b 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 e8 1b 82 ca ff
RSP: 0018:ffffc900187f7800 EFLAGS: 00010283
RAX: ffffffff81a9f9df RBX: ffffc90007ea8000 RCX: 0000000000040000
RDX: ffffc9000d74c000 RSI: 0000000000026b24 RDI: 0000000000026b25
RBP: ffffc90007ea7000 R08: ffffffff81a9e3fd R09: fffffbfff12631ef
R10: fffffbfff12631ef R11: 0000000000000000 R12: ffffc90008703000
R13: dffffc0000000000 R14: ffff88808e51ea90 R15: ffffc90000000000
FS:  00007f40b9e29700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000b770 CR3: 000000019dad6000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 _vm_unmap_aliases+0x442/0x4d0 mm/vmalloc.c:1800
 change_page_attr_set_clr+0x24b/0x5c0 arch/x86/mm/pat/set_memory.c:1732
 change_page_attr_clear arch/x86/mm/pat/set_memory.c:1789 [inline]
 set_memory_ro+0x5d/0x80 arch/x86/mm/pat/set_memory.c:1935
 bpf_jit_binary_lock_ro include/linux/filter.h:815 [inline]
 bpf_int_jit_compile+0x84a1/0x8910 arch/x86/net/bpf_jit_comp.c:1929
 bpf_prog_select_runtime+0x76d/0xa60 kernel/bpf/core.c:1807
 bpf_prog_load kernel/bpf/syscall.c:2198 [inline]
 __do_sys_bpf+0xfabc/0x10c80 kernel/bpf/syscall.c:4114
 do_syscall_64+0x73/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45cb29
Code: Bad RIP value.
RSP: 002b:00007f40b9e28c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00000000004db2a0 RCX: 000000000045cb29
RDX: 0000000000000048 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
R13: 0000000000000070 R14: 00000000004c3450 R15: 00007f40b9e296d4
Modules linked in:
---[ end trace 0c5c57c9d5f27037 ]---
RIP: 0010:find_va_links mm/vmalloc.c:549 [inline]
RIP: 0010:merge_or_add_vmap_area mm/vmalloc.c:778 [inline]
RIP: 0010:__purge_vmap_area_lazy+0x18af/0x18c0 mm/vmalloc.c:1381
Code: e1 07 80 c1 03 38 c1 0f 8c f9 e8 ff ff 48 c7 c7 c8 2b 6d 89 e8 22 81 09 00 e9 e8 e8 ff ff e8 38 82 ca ff 0f 0b e8 31 82 ca ff <0f> 0b 0f 1f 44 00 00 66 2e 0f 1f 84 00 00 00 00 00 e8 1b 82 ca ff
RSP: 0018:ffffc900187f7800 EFLAGS: 00010283
RAX: ffffffff81a9f9df RBX: ffffc90007ea8000 RCX: 0000000000040000
RDX: ffffc9000d74c000 RSI: 0000000000026b24 RDI: 0000000000026b25
RBP: ffffc90007ea7000 R08: ffffffff81a9e3fd R09: fffffbfff12631ef
R10: fffffbfff12631ef R11: 0000000000000000 R12: ffffc90008703000
R13: dffffc0000000000 R14: ffff88808e51ea90 R15: ffffc90000000000
FS:  00007f40b9e29700(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000000b770 CR3: 000000019dad6000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
