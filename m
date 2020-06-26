Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537D7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C78620663
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgFZRZS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:25:18 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:52484 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFZRZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:25:17 -0400
Received: by mail-il1-f199.google.com with SMTP id v14so6908206ilo.19
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 10:25:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=7i+ZPJL0lWnuxgXUoyKyRZHtLC2f4o2ruRnCWshkkfw=;
        b=fpFYnRR0aHjhnCyP1RXWw5Vadi6D9G5m8AaY8TRVvV1LYKtuZ+QzPwwV9p2N3jHRln
         1wczTQ3OT1HrRD6EgVpeFdgmCbm3ZtZgT13g9p91sBgXJ8XvlffWZx49o31IwaGslnsP
         7KABW0flMzCTRRPajdj+uhidJHoPQiF79jznt5Jfl4F5/748dpTa6miruXG/EHZtWQMB
         J5kZ42O7quQamTCIvFSV3hP/nYy/euNSk1vCMFoWgYM2hUyhaq3JMJD5PkoWq+/hTFoS
         AmyYpn8lnVDJ7FYk46WKUVQauuCGH1XxpcmcRg2+3plXCuU69XJ6vvzLeh+J7KzdfxPi
         pZpw==
X-Gm-Message-State: AOAM53241lygRDZstqAcxnjWqU3tsBtN5Y85wb9A2UMZa6bIUMUT0x3H
        yYZyhRAyvloI05xxT6VX9Iy+TDF4Fu8JqZ0gr89D12Bn7GUT
X-Google-Smtp-Source: ABdhPJxaMRhvcx8yBqSy+jvhReT6uQSitkpdXIXKk+C5jS9Qp+HpxRLYF9NrX3p8m9SsEZQQNM9g2lX+OmDJ0e0x/J34qQXZ6NJA
MIME-Version: 1.0
X-Received: by 2002:a92:7901:: with SMTP id u1mr4293689ilc.52.1593192316274;
 Fri, 26 Jun 2020 10:25:16 -0700 (PDT)
Date:   Fri, 26 Jun 2020 10:25:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000120ebe05a8fffe06@google.com>
Subject: KASAN: slab-out-of-bounds Read in snd_usb_mixer_interrupt
From:   syzbot <syzbot+e61a6f7fa0047e8b0a45@syzkaller.appspotmail.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=102bbcf9100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d195fe572fb15312
dashboard link: https://syzkaller.appspot.com/bug?extid=e61a6f7fa0047e8b0a45
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
userspace arch: i386

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+e61a6f7fa0047e8b0a45@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in snd_usb_mixer_interrupt_v2 sound/usb/mixer.c:3327 [inline]
BUG: KASAN: slab-out-of-bounds in snd_usb_mixer_interrupt+0x947/0x980 sound/usb/mixer.c:3392
Read of size 4 at addr ffff8880a700f5e0 by task swapper/0/0

CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x413 mm/kasan/report.c:383
 __kasan_report mm/kasan/report.c:513 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:530
 snd_usb_mixer_interrupt_v2 sound/usb/mixer.c:3327 [inline]
 snd_usb_mixer_interrupt+0x947/0x980 sound/usb/mixer.c:3392
 __usb_hcd_giveback_urb+0x2af/0x4b0 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1716
 __skb_queue_head_init include/linux/skbuff.h:1854 [inline]
 skbpoolfree drivers/block/aoe/aoedev.c:435 [inline]
 freedev drivers/block/aoe/aoedev.c:290 [inline]
 dummy_timer+0x1243/0x2fe1 drivers/block/aoe/aoedev.c:366
 call_timer_fn+0x1ac/0x780 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1449 [inline]
 __run_timers kernel/time/timer.c:1773 [inline]
 __run_timers kernel/time/timer.c:1740 [inline]
 run_timer_softirq+0x623/0x1600 kernel/time/timer.c:1786
 __do_softirq+0x26c/0x9f7 kernel/softirq.c:292
 invoke_softirq kernel/softirq.c:373 [inline]
 irq_exit+0x192/0x1d0 kernel/softirq.c:413
 exiting_irq arch/x86/include/asm/apic.h:546 [inline]
 smp_apic_timer_interrupt+0x19e/0x600 arch/x86/kernel/apic/apic.c:1107
 apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
 </IRQ>
RIP: 0010:native_safe_halt+0xe/0x10 arch/x86/include/asm/irqflags.h:61
Code: cc cc cc cc cc cc cc cc cc cc cc cc e9 07 00 00 00 0f 00 2d 84 9c 4a 00 f4 c3 66 90 e9 07 00 00 00 0f 00 2d 74 9c 4a 00 fb f4 <c3> cc 41 56 41 55 41 54 55 53 e8 33 9c 83 f9 e8 be c8 bf fb 0f 1f
RSP: 0018:ffffffff89807c50 EFLAGS: 00000293 ORIG_RAX: ffffffffffffff13
RAX: ffffffff89886580 RBX: 0000000000000000 RCX: 1ffffffff15173ba
RDX: 0000000000000000 RSI: ffffffff87de1248 RDI: ffffffff89886e00
RBP: ffff8880a6ed7864 R08: 0000000000000000 R09: 0000000000000001
R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880a6ed7864
R13: 1ffffffff1300f95 R14: ffff8880a6ed7865 R15: 0000000000000001
 arch_safe_halt arch/x86/include/asm/paravirt.h:150 [inline]
 acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
 acpi_safe_halt+0x8d/0x110 drivers/acpi/processor_idle.c:108
 acpi_idle_do_entry+0xa9/0xe0 drivers/acpi/processor_idle.c:525
 acpi_idle_enter+0x437/0xb20 drivers/acpi/processor_idle.c:651
 cpuidle_enter_state+0xdd/0xd60 drivers/cpuidle/cpuidle.c:234
 cpuidle_enter+0x4a/0xa0 drivers/cpuidle/cpuidle.c:345
 call_cpuidle kernel/sched/idle.c:117 [inline]
 cpuidle_idle_call kernel/sched/idle.c:207 [inline]
 do_idle+0x42f/0x690 kernel/sched/idle.c:269
 cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:365
 start_kernel+0x9be/0x9fb init/main.c:1041
 secondary_startup_64+0xa4/0xb0 arch/x86/kernel/head_64.S:242

Allocated by task 8069:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc mm/kasan/common.c:494 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:467
 kmem_cache_alloc_trace+0x153/0x7d0 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 add_single_ctl_with_resume+0x53/0x1d0 sound/usb/mixer_quirks.c:147
 snd_mbox1_create_sync_switch sound/usb/mixer_quirks.c:719 [inline]
 snd_usb_mixer_apply_create_quirk+0x17ac/0x2000 sound/usb/mixer_quirks.c:2654
 snd_usb_create_mixer+0x7de/0x18c0 sound/usb/mixer.c:3538
 create_standard_mixer_quirk+0x57/0x70 sound/usb/quirks.c:508
 snd_usb_create_quirk+0x9f/0xd0 sound/usb/quirks.c:563
 create_composite_quirk+0x1d5/0x420 sound/usb/quirks.c:48
 snd_usb_create_quirk+0x9f/0xd0 sound/usb/quirks.c:563
 usb_audio_probe+0x57a/0x2240 sound/usb/card.c:668
 usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:374
 really_probe+0x281/0x6d0 drivers/base/dd.c:520
 driver_probe_device+0x104/0x210 drivers/base/dd.c:697
 __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:804
 bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:431
 __device_attach+0x21a/0x360 drivers/base/dd.c:870
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0x132d/0x1c10 drivers/base/core.c:2557
 usb_set_configuration+0xec5/0x1740 drivers/usb/core/message.c:2032
 usb_generic_driver_probe+0x9d/0xe0 drivers/usb/core/generic.c:241
 usb_probe_device+0xc6/0x1f0 drivers/usb/core/driver.c:272
 really_probe+0x281/0x6d0 drivers/base/dd.c:520
 driver_probe_device+0x104/0x210 drivers/base/dd.c:697
 __device_attach_driver+0x1c2/0x220 drivers/base/dd.c:804
 bus_for_each_drv+0x162/0x1e0 drivers/base/bus.c:431
 __device_attach+0x21a/0x360 drivers/base/dd.c:870
 bus_probe_device+0x1e4/0x290 drivers/base/bus.c:491
 device_add+0x132d/0x1c10 drivers/base/core.c:2557
 usb_new_device.cold+0x753/0x103d drivers/usb/core/hub.c:2554
 hub_port_connect drivers/usb/core/hub.c:5208 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5348 [inline]
 port_event drivers/usb/core/hub.c:5494 [inline]
 hub_event+0x1eca/0x38f0 drivers/usb/core/hub.c:5576
 process_one_work+0x965/0x16a0 kernel/workqueue.c:2268
 worker_thread+0x96/0xe20 kernel/workqueue.c:2414
 kthread+0x388/0x470 kernel/kthread.c:268
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:351

Freed by task 7414:
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 kasan_set_free_info mm/kasan/common.c:316 [inline]
 __kasan_slab_free+0xf7/0x140 mm/kasan/common.c:455
 __cache_free mm/slab.c:3426 [inline]
 kfree+0x109/0x2b0 mm/slab.c:3757
 tomoyo_path_perm+0x236/0x400 security/tomoyo/file.c:842
 tomoyo_path_unlink+0x8e/0xd0 security/tomoyo/tomoyo.c:150
 security_path_unlink+0xf3/0x150 security/security.c:1100
 do_unlinkat+0x381/0x680 fs/namei.c:3872
 do_syscall_32_irqs_on arch/x86/entry/common.c:337 [inline]
 do_fast_syscall_32+0x270/0xe90 arch/x86/entry/common.c:396
 entry_SYSENTER_compat+0x70/0x7f arch/x86/entry/entry_64_compat.S:139

The buggy address belongs to the object at ffff8880a700f580
 which belongs to the cache kmalloc-64 of size 64
The buggy address is located 32 bytes to the right of
 64-byte region [ffff8880a700f580, ffff8880a700f5c0)
The buggy address belongs to the page:
page:ffffea00029c03c0 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00028dd288 ffffea00025ec548 ffff8880aa000380
raw: 0000000000000000 ffff8880a700f000 0000000100000020 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff8880a700f480: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
 ffff8880a700f500: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>ffff8880a700f580: 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc
                                                       ^
 ffff8880a700f600: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
 ffff8880a700f680: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
