Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2632C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5F7720773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389160AbgGTQsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:48:30 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:51462 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbgGTQsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 12:48:22 -0400
Received: by mail-il1-f197.google.com with SMTP id s137so11365753ilc.18
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 09:48:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=52vgdGaAA8hcUPFlyYtitvwg340NDLC7/fQIeVBuX18=;
        b=NNZHlX1XU2fpHGAQw9Pky7oAmF5eZm6NQawUPrrx6MWFDwyBCltFZkdaP+3h0wtD1M
         kUYbS17wvpIZu/4uA3bzElSlrLvy+sIBCCfEIQdEN2HJqJzs6XcHAYUsRtGCQpWuE5zk
         ckEiox0uKbvERg9NzfuZhHdkHWG1YhrEFYhjrksDeiy+SENEUtqWdV+aglzzm8m/F5eA
         5bpnPAJ4B0/opCBDQdDx1kdNc11Ckrze8CNdiORBTYU02C9elLCeabnE+wS7bfHVKQI2
         KfwEHbJOF1lKzR0x7GohjzZuUqGLDRLwsPR/Q4far1RI0yu3RuS0LhgbixuEFRkL4SsY
         u/JA==
X-Gm-Message-State: AOAM533npieTSz0B2ys4dnJ79F7/HuQIBj99gS+JXEnEYw9mlQ6zQJaJ
        q56V0iKptFJrYWj7hARbCXDZeMi0ZOb6PKK72c219SPvZ7LH
X-Google-Smtp-Source: ABdhPJy58JS4cE77WSSYRgFG6obmjU2yddsYxThq4PWwqhYKRsFd+VPkQu8IsDYbqRgP6hlD9BEImNQdCHOEYPl2L/ThChPnaouR
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:961:: with SMTP id q1mr22201056ilt.94.1595263701276;
 Mon, 20 Jul 2020 09:48:21 -0700 (PDT)
Date:   Mon, 20 Jul 2020 09:48:21 -0700
In-Reply-To: <000000000000588c2c05aa156b2b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003cdc6c05aae24652@google.com>
Subject: Re: kernel BUG at mm/vmalloc.c:LINE! (2)
From:   syzbot <syzbot+5f326d255ca648131f87@syzkaller.appspotmail.com>
To:     akpm@linux-foundation.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mingo@redhat.com, peterz@infradead.org,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    ab8be66e Add linux-next specific files for 20200720
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=161a0cc8900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c4bf77d63d0cf88c
dashboard link: https://syzkaller.appspot.com/bug?extid=5f326d255ca648131f87
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151192bb100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d7a873100000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5f326d255ca648131f87@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at mm/vmalloc.c:3089!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.8.0-rc6-next-20200720-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events pcpu_balance_workfn
RIP: 0010:free_vm_area mm/vmalloc.c:3089 [inline]
RIP: 0010:free_vm_area mm/vmalloc.c:3085 [inline]
RIP: 0010:pcpu_free_vm_areas+0x96/0xc0 mm/vmalloc.c:3432
Code: 75 48 48 8b 2b 48 8d 7d 08 48 89 f8 48 c1 e8 03 42 80 3c 30 00 75 2c 48 8b 7d 08 e8 c4 c8 ff ff 48 39 c5 74 a5 e8 ea c3 c9 ff <0f> 0b e8 e3 c3 c9 ff 4c 89 ff 5b 5d 41 5c 41 5d 41 5e 41 5f e9 71
RSP: 0018:ffffc90000d2fba8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880a801be00 RCX: 0000000000000000
RDX: ffff8880a95fa300 RSI: ffffffff81aa7c76 RDI: 0000000000000001
RBP: ffff8880a2b38180 R08: 0000000000000000 R09: ffffffff89cfecc3
R10: fffffbfff139fd98 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff8880a801be00
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c8e48 CR3: 00000000a4c08000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 pcpu_destroy_chunk mm/percpu-vm.c:366 [inline]
 __pcpu_balance_workfn mm/percpu.c:1982 [inline]
 pcpu_balance_workfn+0x8b3/0x1310 mm/percpu.c:2069
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace 6a2e56ec52e1f480 ]---
RIP: 0010:free_vm_area mm/vmalloc.c:3089 [inline]
RIP: 0010:free_vm_area mm/vmalloc.c:3085 [inline]
RIP: 0010:pcpu_free_vm_areas+0x96/0xc0 mm/vmalloc.c:3432
Code: 75 48 48 8b 2b 48 8d 7d 08 48 89 f8 48 c1 e8 03 42 80 3c 30 00 75 2c 48 8b 7d 08 e8 c4 c8 ff ff 48 39 c5 74 a5 e8 ea c3 c9 ff <0f> 0b e8 e3 c3 c9 ff 4c 89 ff 5b 5d 41 5c 41 5d 41 5e 41 5f e9 71
RSP: 0018:ffffc90000d2fba8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880a801be00 RCX: 0000000000000000
RDX: ffff8880a95fa300 RSI: ffffffff81aa7c76 RDI: 0000000000000001
RBP: ffff8880a2b38180 R08: 0000000000000000 R09: ffffffff89cfecc3
R10: fffffbfff139fd98 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff8880a801be00
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004c8e48 CR3: 00000000a4c08000 CR4: 00000000001506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

