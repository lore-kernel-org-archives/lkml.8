Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221D8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E4521BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 08:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgFRIiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:38:22 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:33710 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbgFRIiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 04:38:18 -0400
Received: by mail-il1-f199.google.com with SMTP id c11so3564230ilq.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 01:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=FTL5j6yPXfFni9d58QsALbqJhTpTc8DivuDW9RNIKrI=;
        b=IhCC2J7lxdF1uIdlTyZz31XKemsqU02FQCIrhbLId5PdoRzJ6U59Qz44ahtKl47WzU
         /zx2OvBxPi9ASEq8Ma0za3smWalIWPLgFaMc3GtOGSyt6oYOpSOqjQ5YjcybWLHdIqB+
         FzvLszxfn/IJXhWQl0NZzkHbt5ecbds6RDiuLUmsRmKpb834CPsB1AMOhrD4QKniYQHL
         RmQn3SmVWxsznLBC0lqq1hFI5PaSZjnOnxntrCtxhvugsYE/rIZrfNtsRzxtrBBrx153
         ZJuFy8VUJx/GqBDi7x0LcQHQhzjyHlw185zY2zdaH0iGBjQT4wBE71xLG2gBzEe+4QA1
         I7XQ==
X-Gm-Message-State: AOAM533bkWVNL60LbSBeV2naPHUS0GUt3V5zpDXhRl8iW2bgTlt6cKdG
        N5OhmQzyFdMbvGoNmHC5285s0daPSiZwZIwYdIla6lD4uQY6
X-Google-Smtp-Source: ABdhPJxOX61H7E2J66acHXVBA5Ow8E89BMRmore6uGwEDFwRmsioC3OvN60NUlDqoOuDoHM00Tb7gzO0pyJ/ve7fY4AzHM3ZQPPD
MIME-Version: 1.0
X-Received: by 2002:a05:6638:209:: with SMTP id e9mr3468124jaq.48.1592469496537;
 Thu, 18 Jun 2020 01:38:16 -0700 (PDT)
Date:   Thu, 18 Jun 2020 01:38:16 -0700
In-Reply-To: <000000000000b7773d0599438538@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8260b05a857b25c@google.com>
Subject: Re: BUG: unable to handle kernel paging request in drm_fb_helper_dirty_work
From:   syzbot <syzbot+8a2039467425e497e64a@syzkaller.appspotmail.com>
To:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sean@poorly.run,
        syzkaller-bugs@googlegroups.com, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    435faf5c Merge tag 'riscv-for-linus-5.8-mw0' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14fed799100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3dbb617b9c2a5bdf
dashboard link: https://syzkaller.appspot.com/bug?extid=8a2039467425e497e64a
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c1e011100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12fed799100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+8a2039467425e497e64a@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffff520016dec00
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 7ffcd067 P4D 7ffcd067 PUD 2c920067 PMD 28203067 PTE 0
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 1221 Comm: kworker/1:2 Not tainted 5.7.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events drm_fb_helper_dirty_work
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:120 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:134 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:165 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:183 [inline]
RIP: 0010:check_memory_region+0x9d/0x190 mm/kasan/generic.c:192
Code: c9 4d 0f 49 c1 49 c1 f8 03 45 85 c0 0f 84 03 01 00 00 41 83 e8 01 4e 8d 44 c0 08 eb 0d 48 83 c0 08 4c 39 c0 0f 84 b2 00 00 00 <48> 83 38 00 74 ed 4c 8d 40 08 eb 09 48 83 c0 01 49 39 c0 74 69 80
RSP: 0018:ffffc90003f47c20 EFLAGS: 00010216
RAX: fffff520016dec00 RBX: fffff520016dec00 RCX: ffffffff840645bd
RDX: 0000000000000001 RSI: 0000000000001000 RDI: ffffc9000b6f6000
RBP: fffff520016dee00 R08: fffff520016dee00 R09: 0000000000000200
R10: ffffc9000b6f6fff R11: fffff520016dedff R12: 0000000000001000
R13: ffffc9000b6f6000 R14: ffffc90009b47000 R15: ffff888078c65a00
FS:  0000000000000000(0000) GS:ffff88802cf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff520016dec00 CR3: 00000000214d1000 CR4: 0000000000340ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 memcpy+0x39/0x60 mm/kasan/common.c:106
 memcpy include/linux/string.h:406 [inline]
 drm_fb_helper_dirty_blit_real drivers/gpu/drm/drm_fb_helper.c:386 [inline]
 drm_fb_helper_dirty_work+0x42d/0x760 drivers/gpu/drm/drm_fb_helper.c:415
 process_one_work+0x965/0x16a0 kernel/workqueue.c:2268
 worker_thread+0x96/0xe20 kernel/workqueue.c:2414
 kthread+0x388/0x470 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:351
Modules linked in:
CR2: fffff520016dec00
---[ end trace fdb627f1507ae2fd ]---
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:120 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:134 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:165 [inline]
RIP: 0010:check_memory_region_inline mm/kasan/generic.c:183 [inline]
RIP: 0010:check_memory_region+0x9d/0x190 mm/kasan/generic.c:192
Code: c9 4d 0f 49 c1 49 c1 f8 03 45 85 c0 0f 84 03 01 00 00 41 83 e8 01 4e 8d 44 c0 08 eb 0d 48 83 c0 08 4c 39 c0 0f 84 b2 00 00 00 <48> 83 38 00 74 ed 4c 8d 40 08 eb 09 48 83 c0 01 49 39 c0 74 69 80
RSP: 0018:ffffc90003f47c20 EFLAGS: 00010216
RAX: fffff520016dec00 RBX: fffff520016dec00 RCX: ffffffff840645bd
RDX: 0000000000000001 RSI: 0000000000001000 RDI: ffffc9000b6f6000
RBP: fffff520016dee00 R08: fffff520016dee00 R09: 0000000000000200
R10: ffffc9000b6f6fff R11: fffff520016dedff R12: 0000000000001000
R13: ffffc9000b6f6000 R14: ffffc90009b47000 R15: ffff888078c65a00
FS:  0000000000000000(0000) GS:ffff88802cf00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffff520016dec00 CR3: 00000000214d1000 CR4: 0000000000340ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

