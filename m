Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5602C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 19:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7951206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 19:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbgGZTEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 15:04:21 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:46585 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgGZTEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 15:04:20 -0400
Received: by mail-il1-f198.google.com with SMTP id o4so9900653ilo.13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 12:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=HEwees8XhvhaflJvsRUeTPvTEcUS/Bl/bP4ozLUGjQU=;
        b=JBpz1YngMtEfXamVSBsU+Tj23DmmU5JbO7d7hr6KUyPoF+rSpY4k2IWvJBxs92sOZO
         6ByMlBDU4TzPmkv/HSmy1CGfkE+6iKoC1gRoVsHCH/SGOxVfpH84og2wCeCI2lOYeaqu
         wm71BX2It0LQVaawEwddYgwvOc7R5SoxaoKaZ0n5koQX+H7Td99tp/wOaVoUehuu7k5+
         /WScNy20pJxjDSe27cr6A8PnweRhGThjmXjF8yZGCeMEgJVM2F0YNU/w2ckZObR7BqL7
         d8GwgTdCAaLibuNKAw05GglF55CtMrc8KSmGC6rkxr1SllUrBPqGYRsT6BrDzfhZwM4/
         T20w==
X-Gm-Message-State: AOAM533g85sWzaTZ34bHcjOQ0LxYzMWYohJrt/ilO9dP32ZME+pg4NwH
        cdgTgHSG3dDSrJTxawk9QAp4+o6ut6uAwZGxoDhwmIF3vkE0
X-Google-Smtp-Source: ABdhPJwSvBey4OTUTkxXaQGVsEi8AKNl4SrPBIb1jlQbKsxUERRw8I0GrZ5Lt4u9xEkU0ZqZncZNrEZby/yIsvsnGsvcjGun2oCv
MIME-Version: 1.0
X-Received: by 2002:a5d:8a04:: with SMTP id w4mr11255446iod.15.1595790259993;
 Sun, 26 Jul 2020 12:04:19 -0700 (PDT)
Date:   Sun, 26 Jul 2020 12:04:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009540e405ab5cdfcf@google.com>
Subject: upstream boot error: BUG: soft lockup in smp_call_function
From:   syzbot <syzbot+b33acc95084b5829b7c6@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8c26c87b Merge tag 'sound-5.8-rc7' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15069c64900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=455d284425bae0bd
dashboard link: https://syzkaller.appspot.com/bug?extid=b33acc95084b5829b7c6
compiler:       gcc (GCC) 10.1.0-syz 20200507

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b33acc95084b5829b7c6@syzkaller.appspotmail.com

random: fast init done
watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [kworker/2:2:1225]
Modules linked in:
irq event stamp: 1613250
hardirqs last  enabled at (1613249): [<ffffffff88000c42>] asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:585
hardirqs last disabled at (1613250): [<ffffffff87e592ed>] idtentry_enter_cond_rcu+0x1d/0x50 arch/x86/entry/common.c:649
softirqs last  enabled at (1609304): [<ffffffff88200748>] __do_softirq+0x748/0xa60 kernel/softirq.c:319
softirqs last disabled at (1609289): [<ffffffff88000f0f>] asm_call_on_stack+0xf/0x20 arch/x86/entry/entry_64.S:711
CPU: 2 PID: 1225 Comm: kworker/2:2 Not tainted 5.8.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Workqueue: events drm_fb_helper_dirty_work
RIP: 0010:csd_lock_wait kernel/smp.c:108 [inline]
RIP: 0010:smp_call_function_many_cond+0x7c4/0x990 kernel/smp.c:555
Code: 0a 00 85 ed 74 4d 48 b8 00 00 00 00 00 fc ff df 4d 89 f4 4c 89 f5 49 c1 ec 03 83 e5 07 49 01 c4 83 c5 03 e8 7e f3 0a 00 f3 90 <41> 0f b6 04 24 40 38 c5 7c 08 84 c0 0f 85 a2 00 00 00 8b 43 08 31
RSP: 0018:ffffc90004257990 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffffe8ffade098e0 RCX: ffffffff8168c938
RDX: ffff888027918000 RSI: ffffffff8168c912 RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000000 R09: ffffffff8aaed233
R10: 0000000000000000 R11: 0000000000000000 R12: fffff91ff5bc131d
R13: 0000000000000000 R14: ffffe8ffade098e8 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802d000000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8bf43cc9de CR3: 0000000009a79000 CR4: 0000000000340ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 smp_call_function_many kernel/smp.c:577 [inline]
 smp_call_function kernel/smp.c:599 [inline]
 on_each_cpu+0x4a/0x240 kernel/smp.c:699
 __purge_vmap_area_lazy+0x11e/0x1f20 mm/vmalloc.c:1367
 try_purge_vmap_area_lazy mm/vmalloc.c:1404 [inline]
 free_vmap_area_noflush+0x2bc/0x370 mm/vmalloc.c:1440
 free_unmap_vmap_area mm/vmalloc.c:1453 [inline]
 remove_vm_area+0x1ca/0x230 mm/vmalloc.c:2204
 vm_remove_mappings mm/vmalloc.c:2231 [inline]
 __vunmap+0x348/0xac0 mm/vmalloc.c:2293
 vunmap+0x50/0x60 mm/vmalloc.c:2398
 drm_gem_shmem_vunmap_locked drivers/gpu/drm/drm_gem_shmem_helper.c:323 [inline]
 drm_gem_shmem_vunmap+0x174/0x1c0 drivers/gpu/drm/drm_gem_shmem_helper.c:340
 drm_gem_vunmap+0x81/0x130 drivers/gpu/drm/drm_gem.c:1277
 drm_client_buffer_vunmap+0x51/0xa0 drivers/gpu/drm/drm_client.c:340
 drm_fb_helper_dirty_work+0x599/0x730 drivers/gpu/drm/drm_fb_helper.c:438
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
