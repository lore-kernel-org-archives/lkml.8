Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B120C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59145206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgA3KHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:07:14 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:32904 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgA3KHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:07:14 -0500
Received: by mail-il1-f197.google.com with SMTP id s9so2246365ilk.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 02:07:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=UVL0VwcBqbuTLrIJtBXJtI8vXsa7snj6rEZ475PYU8Y=;
        b=cfTDyHO5+GaUW7wEaZNivbj7XZSPabKje5wt71mzHfmuFWmsEryuqxuaQ9ZGxM2biG
         F9ZghgMZ5MXlOoPZYZvMHsjn0SKxWLZRLQWbWmWGDyjwnaC1IbtswwFUA9fs54UEoNNN
         iqH2xMvReS25bgBjwulGfujp7zJ1kBdXCiHVmSBUCSvAhq6mvsajQuWHN1apgtywbwmq
         1wKFTlggaDiL/PQfde6HfZ5NeSbrzn/TaVCJAzScOx8Knlmm6AnNL8dSu37Vnl1PQ6+j
         eSD/SjZsd11UKiH6B0hk7gJ4VVZ6TwCXndOUEXIbMYVq0KbPwHRePHsDbWdAMZGINhzK
         vl6w==
X-Gm-Message-State: APjAAAVcdP+HevcyqxmUvsHjAzvFdHzwLrFTXrFyWo/Gz6n9ulBlyXfE
        ZSlCR0kr5sEjruJ2r87+KcIv6zMSNS3FKb7OIIcgkJ5Me5vs
X-Google-Smtp-Source: APXvYqzW3Kcag+S8CnAN7A9/7B6BstjSJsCUjtojrrsvr0rquOHjfPfZeeZMs05zFC0/ZTI5C8JhpmGHEo61p9b+gIBFj+if7/rn
MIME-Version: 1.0
X-Received: by 2002:a6b:6018:: with SMTP id r24mr3058653iog.284.1580378831969;
 Thu, 30 Jan 2020 02:07:11 -0800 (PST)
Date:   Thu, 30 Jan 2020 02:07:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3e280059d589ef4@google.com>
Subject: upstream boot error: KASAN: slab-out-of-bounds Write in hpet_alloc
From:   syzbot <syzbot+2b149e3a2468e54d2178@syzkaller.appspotmail.com>
To:     arnd@arndb.de, clemens@ladisch.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    39bed42d Merge tag 'for-linus-hmm' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1569d9a5e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2646535f8818ae25
dashboard link: https://syzkaller.appspot.com/bug?extid=2b149e3a2468e54d2178
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+2b149e3a2468e54d2178@syzkaller.appspotmail.com

pci 0000:00:1f.3: reg 0x20: [io  0x0700-0x073f]
ACPI: PCI Interrupt Link [LNKA] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [LNKB] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [LNKC] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKD] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKE] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [LNKF] (IRQs 5 *10 11)
ACPI: PCI Interrupt Link [LNKG] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [LNKH] (IRQs 5 10 *11)
ACPI: PCI Interrupt Link [GSIA] (IRQs *16)
ACPI: PCI Interrupt Link [GSIB] (IRQs *17)
ACPI: PCI Interrupt Link [GSIC] (IRQs *18)
ACPI: PCI Interrupt Link [GSID] (IRQs *19)
ACPI: PCI Interrupt Link [GSIE] (IRQs *20)
ACPI: PCI Interrupt Link [GSIF] (IRQs *21)
ACPI: PCI Interrupt Link [GSIG] (IRQs *22)
ACPI: PCI Interrupt Link [GSIH] (IRQs *23)
iommu: Default domain type: Translated 
pci 0000:00:01.0: vgaarb: setting as boot VGA device
pci 0000:00:01.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
pci 0000:00:01.0: vgaarb: bridge control possible
vgaarb: loaded
SCSI subsystem initialized
ACPI: bus type USB registered
usbcore: registered new interface driver usbfs
usbcore: registered new interface driver hub
usbcore: registered new device driver usb
mc: Linux media interface: v0.10
videodev: Linux video capture interface: v2.00
pps_core: LinuxPPS API ver. 1 registered
pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
PTP clock support registered
EDAC MC: Ver: 3.0.0
Advanced Linux Sound Architecture Driver Initialized.
PCI: Using ACPI for IRQ routing
Bluetooth: Core ver 2.22
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Bluetooth: L2CAP socket layer initialized
Bluetooth: SCO socket layer initialized
NET: Registered protocol family 8
NET: Registered protocol family 20
NetLabel: Initializing
NetLabel:  domain hash size = 128
NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
NetLabel:  unlabeled traffic allowed by default
nfc: nfc_init: NFC Core ver 0.1
NET: Registered protocol family 39
==================================================================
BUG: KASAN: slab-out-of-bounds in hpet_alloc+0x442/0x490 drivers/char/hpet.c:871
Write of size 4 at addr ffff88807882e5d8 by task swapper/0/1

CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.5.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x197/0x210 lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
 __kasan_report.cold+0x1b/0x32 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:639
 __asan_report_store4_noabort+0x17/0x20 mm/kasan/generic_report.c:139
 hpet_alloc+0x442/0x490 drivers/char/hpet.c:871
 hpet_reserve_platform_timers+0x1fc/0x245 arch/x86/kernel/hpet.c:222
 hpet_late_init+0x2f4/0x38b arch/x86/kernel/hpet.c:954
 do_one_initcall+0x120/0x820 init/main.c:939
 do_initcall_level init/main.c:1007 [inline]
 do_initcalls init/main.c:1015 [inline]
 do_basic_setup init/main.c:1032 [inline]
 kernel_init_freeable+0x4ca/0x570 init/main.c:1203
 kernel_init+0x12/0x1bf init/main.c:1110
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 1:
 save_stack+0x23/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:513 [inline]
 __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:486
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:527
 __do_kmalloc mm/slab.c:3656 [inline]
 __kmalloc+0x163/0x770 mm/slab.c:3665
 kmalloc include/linux/slab.h:561 [inline]
 kzalloc include/linux/slab.h:670 [inline]
 hpet_alloc+0x12b/0x490 drivers/char/hpet.c:858
 hpet_reserve_platform_timers+0x1fc/0x245 arch/x86/kernel/hpet.c:222
 hpet_late_init+0x2f4/0x38b arch/x86/kernel/hpet.c:954
 do_one_initcall+0x120/0x820 init/main.c:939
 do_initcall_level init/main.c:1007 [inline]
 do_initcalls init/main.c:1015 [inline]
 do_basic_setup init/main.c:1032 [inline]
 kernel_init_freeable+0x4ca/0x570 init/main.c:1203
 kernel_init+0x12/0x1bf init/main.c:1110
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff88807882e400
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 472 bytes inside of
 512-byte region [ffff88807882e400, ffff88807882e600)
The buggy address belongs to the page:
page:ffffea0001e20b80 refcount:1 mapcount:0 mapping:ffff88802cc00a80 index:0xffff88807882ec00
raw: 04fffe0000000200 ffff88807a800738 ffff88807a800738 ffff88802cc00a80
raw: ffff88807882ec00 ffff88807882e000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88807882e480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff88807882e500: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
>ffff88807882e580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                                                    ^
 ffff88807882e600: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88807882e680: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
