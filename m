Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FD7C28CBC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 03:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAC63207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 03:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5hcaOQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgEADEI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 23:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727889AbgEADEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 23:04:07 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D73CDC035494;
        Thu, 30 Apr 2020 20:04:06 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w20so1567420ljj.0;
        Thu, 30 Apr 2020 20:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wVHLLDpF4M6g85tJGEjUSxJsQO/6Y2aPrpXDejqwwss=;
        b=M5hcaOQtmRnJ1Bo8utxu3anU6dKr9HouqSvUSFrR4+47/WIqdPGmnfwRCroLJsoL4u
         FCtOCJPlVbM/1nDoFUQVWk4Srohehnamm1HJAbzUM0TxbEEe2AAWwTQEDpOBu81wIJm5
         z4ZVZqxxW1fizQK+ZxjbiCxN1e6qvqPMcZENgBCu78Rpc0cXMvpot/8cNd3yrUkemWl/
         YevNY6pDs3d/COZA9dkbv7oM1GN+P+Fb1CblHHmhh49NVjDj/EqrWXp2xIOhw7YiffnC
         SAkiZG2YwEkMa2kAqt/j2ifCyp3rwmzWfF9zEuqCIz1YBnNSBEB6JrmpCIJb98tWrgum
         BGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wVHLLDpF4M6g85tJGEjUSxJsQO/6Y2aPrpXDejqwwss=;
        b=Ecmv7AJdY0tvdohfbVsryNlfvjvsoRD6u1moSYXjatGzonTLqgKbbe4OJ9EeE4adcV
         ORiIOmEZngkHubfL4vuv6eEa15/pQ+8CLUAkfaE9J3hjYZzOPdhOrKtaHVZZYSJwExtN
         6a8ilIg8U86jz3KqQHsMvuMrDVg81xFIfoyZRbeFNirpitu+YIS3lw4Rq20N4y3arf2b
         Gk/0538MnLIDfeRLS7F0+his+ic8HCCyOC8Zl6qKtQVcHlM9ZsEqqPoFWQdvEEefmsSC
         o9xj8JJytyqER1HJQEGTJea6sbyVXwGtpuwgB8tTJnAxoH5QbhFF3QYQ51PJ6xxhiS55
         UH/Q==
X-Gm-Message-State: AGi0PuY2EZ7ZgvEpPJE762bZf01zO0LGAU6hnymdmNq6SrytoE43CQWO
        rhkEyW2Rzk95BoJv5He3kAbX0TA0eJY6BvU/oPw=
X-Google-Smtp-Source: APiQypK+B30NPeMqyVmQ3CHCFxUdAOQ3P4+0P1AChTdDZUQlNtS4xu5idVAvKzLXvrOB712PlTT1MQ3ojxYwALayqAE=
X-Received: by 2002:a2e:910e:: with SMTP id m14mr1040394ljg.141.1588302245258;
 Thu, 30 Apr 2020 20:04:05 -0700 (PDT)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Thu, 30 Apr 2020 23:03:54 -0400
Message-ID: <CAEAjamvq+puThrxfo80TOy=xgbQEQNT6xvxy4w6hP2O1By66uw@mail.gmail.com>
Subject: KASAN: slab-out-of-bounds Read in gadget_dev_desc_UDC_store
To:     balbi@kernel.org, Greg KH <gregkh@linuxfoundation.org>
Cc:     syzkaller <syzkaller@googlegroups.com>,
        USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Tian <dave.jing.tian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a bug (in linux-5.6.8) found by FuzzUSB (a modified version
of syzkaller).

This happened when the size of "name" buffer is smaller than that of
"page" buffer
(after function kstrdup executed at line 263).
I guess it comes from the "page" buffer containing 0 value in the middle.
So accessing the "name" buffer with "len" variable, which is used to
indicate the size of "page" buffer,
triggered memory access violation.
To fix, it may need to check the size of name buffer, and try to use
right index variable.

kernel config: https://kt0755.github.io/etc/config_v5.6.8

==================================================================
BUG: KASAN: slab-out-of-bounds in
gadget_dev_desc_UDC_store+0x1ba/0x200
drivers/usb/gadget/configfs.c:266
Read of size 1 at addr ffff88806a55dd7e by task syz-executor.0/17208

CPU: 2 PID: 17208 Comm: syz-executor.0 Not tainted 5.6.8 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xce/0x128 lib/dump_stack.c:118
 print_address_description.constprop.4+0x21/0x3c0 mm/kasan/report.c:374
 __kasan_report+0x131/0x1b0 mm/kasan/report.c:506
 kasan_report+0x12/0x20 mm/kasan/common.c:641
 __asan_report_load1_noabort+0x14/0x20 mm/kasan/generic_report.c:132
 gadget_dev_desc_UDC_store+0x1ba/0x200 drivers/usb/gadget/configfs.c:266
 flush_write_buffer fs/configfs/file.c:251 [inline]
 configfs_write_file+0x2f1/0x4c0 fs/configfs/file.c:283
 __vfs_write+0x85/0x110 fs/read_write.c:494
 vfs_write+0x1cd/0x510 fs/read_write.c:558
 ksys_write+0x18a/0x220 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x73/0xb0 fs/read_write.c:620
 do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x452149
Code: 2d 61 fc ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 fb 60 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f3bd907cc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000073c0f8 RCX: 0000000000452149
RDX: 00000000fffffed8 RSI: 00000000200003c0 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004bf782
R13: 00000000004d7710 R14: 00007f3bd907d6d4 R15: 00000000ffffffff

Allocated by task 1:
 save_stack+0x21/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc.constprop.3+0xa7/0xd0 mm/kasan/common.c:515
 kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
 __kmalloc+0x11c/0x310 mm/slub.c:3841
 kmalloc include/linux/slab.h:560 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 acpi_os_allocate_zeroed+0x3e/0x42 include/acpi/platform/aclinuxex.h:57
 acpi_ns_internalize_name+0xd9/0x16a drivers/acpi/acpica/nsutils.c:331
 acpi_ns_get_node_unlocked+0x17e/0x1fe drivers/acpi/acpica/nsutils.c:666
 acpi_ns_get_node+0x44/0x62 drivers/acpi/acpica/nsutils.c:726
 acpi_ns_evaluate+0xc8/0x93e drivers/acpi/acpica/nseval.c:61
 acpi_ut_evaluate_object+0xe4/0x386 drivers/acpi/acpica/uteval.c:60
 acpi_ut_execute_power_methods+0xda/0x1b1 drivers/acpi/acpica/uteval.c:288
 acpi_get_object_info+0x487/0x994 drivers/acpi/acpica/nsxfname.c:366
 acpi_set_pnp_ids drivers/acpi/scan.c:1245 [inline]
 acpi_init_device_object+0xbfd/0x17a0 drivers/acpi/scan.c:1585
 acpi_add_single_object+0x121/0x1710 drivers/acpi/scan.c:1620
 acpi_bus_check_add+0x1c9/0x4f0 drivers/acpi/scan.c:1873
 acpi_ns_walk_namespace+0x1d3/0x320 drivers/acpi/acpica/nswalk.c:236
 acpi_walk_namespace+0xb5/0xef drivers/acpi/acpica/nsxfeval.c:606
 acpi_bus_scan+0xdf/0xf0 drivers/acpi/scan.c:2054
 acpi_scan_init+0x264/0x5e4 drivers/acpi/scan.c:2218
 acpi_init+0x592/0x612 drivers/acpi/bus.c:1249
 do_one_initcall+0xe0/0x650 init/main.c:1152
 do_initcall_level init/main.c:1225 [inline]
 do_initcalls init/main.c:1241 [inline]
 do_basic_setup init/main.c:1261 [inline]
 kernel_init_freeable+0x5e8/0x67c init/main.c:1445
 kernel_init+0x13/0x1b0 init/main.c:1352
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 1:
 save_stack+0x21/0x90 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 kasan_set_free_info mm/kasan/common.c:337 [inline]
 __kasan_slab_free+0x135/0x190 mm/kasan/common.c:476
 kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
 slab_free_hook mm/slub.c:1444 [inline]
 slab_free_freelist_hook mm/slub.c:1477 [inline]
 slab_free mm/slub.c:3034 [inline]
 kfree+0xf7/0x410 mm/slub.c:3995
 acpi_os_free include/acpi/platform/aclinuxex.h:62 [inline]
 acpi_ns_get_node_unlocked+0x1c8/0x1fe drivers/acpi/acpica/nsutils.c:686
 acpi_ns_get_node+0x44/0x62 drivers/acpi/acpica/nsutils.c:726
 acpi_ns_evaluate+0xc8/0x93e drivers/acpi/acpica/nseval.c:61
 acpi_ut_evaluate_object+0xe4/0x386 drivers/acpi/acpica/uteval.c:60
 acpi_ut_execute_power_methods+0xda/0x1b1 drivers/acpi/acpica/uteval.c:288
 acpi_get_object_info+0x487/0x994 drivers/acpi/acpica/nsxfname.c:366
 acpi_set_pnp_ids drivers/acpi/scan.c:1245 [inline]
 acpi_init_device_object+0xbfd/0x17a0 drivers/acpi/scan.c:1585
 acpi_add_single_object+0x121/0x1710 drivers/acpi/scan.c:1620
 acpi_bus_check_add+0x1c9/0x4f0 drivers/acpi/scan.c:1873
 acpi_ns_walk_namespace+0x1d3/0x320 drivers/acpi/acpica/nswalk.c:236
 acpi_walk_namespace+0xb5/0xef drivers/acpi/acpica/nsxfeval.c:606
 acpi_bus_scan+0xdf/0xf0 drivers/acpi/scan.c:2054
 acpi_scan_init+0x264/0x5e4 drivers/acpi/scan.c:2218
 acpi_init+0x592/0x612 drivers/acpi/bus.c:1249
 do_one_initcall+0xe0/0x650 init/main.c:1152
 do_initcall_level init/main.c:1225 [inline]
 do_initcalls init/main.c:1241 [inline]
 do_basic_setup init/main.c:1261 [inline]
 kernel_init_freeable+0x5e8/0x67c init/main.c:1445
 kernel_init+0x13/0x1b0 init/main.c:1352
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The buggy address belongs to the object at ffff88806a55dd68
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 14 bytes to the right of
 8-byte region [ffff88806a55dd68, ffff88806a55dd70)
The buggy address belongs to the page:
page:ffffea0001a95740 refcount:1 mapcount:0 mapping:ffff88806c00f980
index:0xffff88806a55dfd8
flags: 0x100000000000200(slab)
raw: 0100000000000200 ffffea0001a95600 0000000500000005 ffff88806c00f980
raw: ffff88806a55dfd8 0000000080aa0005 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff88806a55dc00: fb fc fc fb fc fc fb fc fc fb fc fc fb fc fc fb
 ffff88806a55dc80: fc fc fb fc fc fb fc fc fb fc fc fb fc fc fb fc
>ffff88806a55dd00: fc fb fc fc fb fc fc fb fc fc fb fc fc fb fc fc
                                                                ^
 ffff88806a55dd80: fb fc fc fb fc fc 00 fc fc 00 fc fc fb fc fc fb
 ffff88806a55de00: fc fc fb fc fc fb fc fc fb fc fc fb fc fc fb fc
==================================================================

Regards,
Kyungtae Kim
