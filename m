Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C14BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5599A20702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:08:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391633AbgFWVIZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:08:25 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:50615 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387767AbgFWVIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 17:08:21 -0400
Received: by mail-io1-f72.google.com with SMTP id b3so13752825ion.17
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 14:08:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ELUKFjBiXhk0webECGHmWukN2wiZ/fGcxCiXxbEJvZw=;
        b=BcRSYJLMFB1C1XmGVYYisMMKMULmwqERsPnK6hGPRxYb8CPqWGapTiUvhyXlJrfnrx
         JgHyekH/EiABcgJA6lK5F1FXPR4gwRJcozGL8N1IBco9ou3J69TjylfpE3x8XBbDmrXQ
         RFU8Pu0cPScURHxdN9m6kbrmGJR/HLUOoQ3BEOmL1ScN7R8CPWMbF3pQ1qk6l10O7sDI
         xm8TCtI5qf97EMzmyhgYxpdtPcnso9xyPwOvmQlHO9vqSVrADVQYh9gGerCURdrtZ66r
         ZHExs5riKAKNsvsnucCMp6A7Qq6KSAkHKGd6H/hKZhA4nLKeq8I7BPZ/0sM35ctJ8S8f
         xsdg==
X-Gm-Message-State: AOAM530FyQnNVpcnrtZ33Js1YdgyL2Oqs5X/ElHeLbST+cQYxRX/7FPm
        IGMWrG25PVL61/imt/g/AINpuMfRpcKwpQO+y0Ye61sbpXa2
X-Google-Smtp-Source: ABdhPJzxUWezLj25GQcJjmzFyyzV8zPhnAOMUqh+3uMYMglVl03aqlkd4yYm3QP6f4c1cxC0jQjo0GNtFagv4l+QvSFZJRYKs793
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:f41:: with SMTP id y1mr25744802ilj.232.1592946499365;
 Tue, 23 Jun 2020 14:08:19 -0700 (PDT)
Date:   Tue, 23 Jun 2020 14:08:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003dbc0305a8c6c238@google.com>
Subject: KASAN: slab-out-of-bounds Write in snd_usb_mixer_interrupt
From:   syzbot <syzbot+2405ca3401e943c538b5@syzkaller.appspotmail.com>
To:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        perex@perex.cz, syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    7ae77150 Merge tag 'powerpc-5.8-1' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b9b0a1100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=be4578b3f1083656
dashboard link: https://syzkaller.appspot.com/bug?extid=2405ca3401e943c538b5
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1589f7cd100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10162bf1100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2405ca3401e943c538b5@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in snd_usb_mixer_notify_id sound/usb/mixer.c:3240 [inline]
BUG: KASAN: slab-out-of-bounds in snd_usb_mixer_interrupt+0xaa7/0xc30 sound/usb/mixer.c:3379
Write of size 4 at addr ffff8880a39c5ae0 by task swapper/0/0

CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1e9/0x30e lib/dump_stack.c:118
 print_address_description+0x66/0x5a0 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report+0x132/0x1d0 mm/kasan/report.c:530
 snd_usb_mixer_notify_id sound/usb/mixer.c:3240 [inline]
 snd_usb_mixer_interrupt+0xaa7/0xc30 sound/usb/mixer.c:3379
 __usb_hcd_giveback_urb+0x333/0x4b0 drivers/usb/core/hcd.c:1650
 dummy_timer+0x75c/0x3ff0 drivers/usb/gadget/udc/dummy_hcd.c:1966
 call_timer_fn+0x91/0x160 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1449 [inline]
 __run_timers+0x776/0x970 kernel/time/timer.c:1773
 run_timer_softirq+0x46/0x80 kernel/time/timer.c:1786
 __do_softirq+0x268/0x80c kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0x223/0x230 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:546 [inline]
 smp_apic_timer_interrupt+0x113/0x280 arch/x86/kernel/apic/apic.c:1107
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
 </IRQ>
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: 80 e1 07 80 c1 03 38 c1 7c bc 48 89 df e8 9a 17 9b f9 eb b2 cc cc cc cc cc cc cc cc e9 07 00 00 00 0f 00 2d 56 46 4a 00 fb f4 <c3> 90 e9 07 00 00 00 0f 00 2d 46 46 4a 00 f4 c3 cc cc 41 56 53 65
RSP: 0018:ffffffff89207d48 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff13
RAX: 1ffffffff12577b9 RBX: 0000000000000000 RCX: ffffffffffffffff
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff89282364
RBP: 1ffff1104351204e R08: ffffffff817a4660 R09: fffffbfff1250361
R10: fffffbfff1250361 R11: 0000000000000000 R12: 0000000000000001
R13: dffffc0000000000 R14: dffffc0000000000 R15: ffff88821a890270
 arch_safe_halt arch/x86/include/asm/paravirt.h:150 [inline]
 acpi_safe_halt+0x87/0xe0 drivers/acpi/processor_idle.c:111
 acpi_idle_do_entry drivers/acpi/processor_idle.c:525 [inline]
 acpi_idle_enter+0x3f4/0xac0 drivers/acpi/processor_idle.c:651
 cpuidle_enter_state+0x2d7/0x7b0 drivers/cpuidle/cpuidle.c:234
 cpuidle_enter+0x59/0x90 drivers/cpuidle/cpuidle.c:345
 call_cpuidle kernel/sched/idle.c:117 [inline]
 cpuidle_idle_call kernel/sched/idle.c:207 [inline]
 do_idle+0x49c/0x650 kernel/sched/idle.c:269
 cpu_startup_entry+0x15/0x20 kernel/sched/idle.c:365
 start_kernel+0x674/0x777 init/main.c:1041
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242

Allocated by task 12:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc+0x103/0x140 mm/kasan/common.c:494
 kmem_cache_alloc_trace+0x234/0x300 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 add_single_ctl_with_resume sound/usb/mixer_quirks.c:147 [inline]
 snd_mbox1_create_sync_switch sound/usb/mixer_quirks.c:719 [inline]
 snd_usb_mixer_apply_create_quirk+0x1333/0x4fc0 sound/usb/mixer_quirks.c:2654
 snd_usb_create_mixer+0x22d8/0x2e90 sound/usb/mixer.c:3538
 snd_usb_create_quirk sound/usb/quirks.c:563 [inline]
 create_composite_quirk+0x221/0x510 sound/usb/quirks.c:48
 usb_audio_probe+0xc3d/0x2500 sound/usb/card.c:668
 usb_probe_interface+0x614/0xac0 drivers/usb/core/driver.c:374
 really_probe+0x761/0xf60 drivers/base/dd.c:524
 driver_probe_device+0xe6/0x230 drivers/base/dd.c:697
 bus_for_each_drv+0x108/0x170 drivers/base/bus.c:431
 __device_attach+0x20c/0x3a0 drivers/base/dd.c:870
 bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:491
 device_add+0x1828/0x1ba0 drivers/base/core.c:2557
 usb_set_configuration+0x19d2/0x1f20 drivers/usb/core/message.c:2032
 usb_generic_driver_probe+0x82/0x140 drivers/usb/core/generic.c:241
 usb_probe_device+0x12d/0x1d0 drivers/usb/core/driver.c:272
 really_probe+0x761/0xf60 drivers/base/dd.c:524
 driver_probe_device+0xe6/0x230 drivers/base/dd.c:697
 bus_for_each_drv+0x108/0x170 drivers/base/bus.c:431
 __device_attach+0x20c/0x3a0 drivers/base/dd.c:870
 bus_probe_device+0xb8/0x1f0 drivers/base/bus.c:491
 device_add+0x1828/0x1ba0 drivers/base/core.c:2557
 usb_new_device+0xcc3/0x1650 drivers/usb/core/hub.c:2554
 hub_port_connect drivers/usb/core/hub.c:5208 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x2823/0x4cb0 drivers/usb/core/hub.c:5576
 process_one_work+0x76e/0xfd0 kernel/workqueue.c:2268
 worker_thread+0xa7f/0x1450 kernel/workqueue.c:2414
 kthread+0x353/0x380 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:351

Freed by task 4844:
 save_stack mm/kasan/common.c:48 [inline]
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0x114/0x170 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x10a/0x220 mm/slab.c:3757
 tomoyo_path_perm+0x59b/0x740 security/tomoyo/file.c:842
 security_inode_getattr+0xc0/0x140 security/security.c:1278
 vfs_getattr fs/stat.c:121 [inline]
 vfs_statx_fd fs/stat.c:151 [inline]
 vfs_fstat include/linux/fs.h:3319 [inline]
 __do_sys_newfstat fs/stat.c:398 [inline]
 __se_sys_newfstat fs/stat.c:395 [inline]
 __x64_sys_newfstat+0x97/0x150 fs/stat.c:395
 do_syscall_64+0xf3/0x1b0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3

The buggy address belongs to the object at ffff8880a39c5a80
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 32 bytes to the right of
 64-byte region [ffff8880a39c5a80, ffff8880a39c5ac0)
The buggy address belongs to the page:
page:ffffea00028e7140 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea000299a688 ffffea00028e3948 ffff8880aa400380
raw: 0000000000000000 ffff8880a39c5000 0000000100000020 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a39c5980: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880a39c5a00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff8880a39c5a80: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
                                                       ^
 ffff8880a39c5b00: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880a39c5b80: 00 00 00 00 01 fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
