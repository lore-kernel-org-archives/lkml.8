Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982D5C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 06:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5424C20672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 06:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDFGqQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 02:46:16 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:52994 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgDFGqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 02:46:15 -0400
Received: by mail-io1-f69.google.com with SMTP id c15so198089iom.19
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 23:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Unvu00AzWihNcjFsSegg++/SIJKIxJgCZcRTM9IrS/E=;
        b=ICIkThAWArs/u49yEneWSzAepM6saEJ0zQKPkOLh6Y/rqukejEmTYHVgGvRoO3dGCN
         A7dTTsW7S2OWvvJV2hqYRpLNTNLQFDLUX7umpAZeK1gcdOhYCnW2fb2w1yMHkVVipxjo
         9/p5JX7J97fk0ePrieydLtZtcAnwgy3pY3RRH4mhX2FNA2K9jqNRH45wkJvbiuHDINI/
         2L6MwBRFM2Xp54HtFm1JNa+1g+EEZMy944bjjFrPJtnQUjl/u3kk44/y3nAaY78VZy7q
         gamVd+uJDWz12whsu6jDUgf03ZGUuHkQXgrpY27a+J3CCSNk/vCXzvkhycvdmbsP8mb4
         eS8w==
X-Gm-Message-State: AGi0PuYsIppyAosL5SZ0VU/1ZJP4Rh3RzwRnvJzuj5+SA0goghsT+hZK
        CfebynD6VaS/Wv5SwdzhGsKRQqNvf57GLZqlbBkktPCnukFi
X-Google-Smtp-Source: APiQypI42AhMdpPxlU9bJ4dEm3CQ2AzXPVsUtQcCoxRydTQKXEFT0X1NEeIup+SXwT9RTiSSYZr8JQZQLvq+R8H5vCi7rpZAtTVo
MIME-Version: 1.0
X-Received: by 2002:a92:d650:: with SMTP id x16mr20678240ilp.226.1586155574329;
 Sun, 05 Apr 2020 23:46:14 -0700 (PDT)
Date:   Sun, 05 Apr 2020 23:46:14 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091056b05a2999f1e@google.com>
Subject: upstream boot error: KASAN: slab-out-of-bounds Write in virtio_gpu_object_create
From:   syzbot <syzbot+d3a7951ed361037407db@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    ffc1c20c Merge tag 'for-5.7/dm-changes' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1690471fe00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d6a1e2f9a9986236
dashboard link: https://syzkaller.appspot.com/bug?extid=d3a7951ed361037407db
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d3a7951ed361037407db@syzkaller.appspotmail.com

NET: Registered protocol family 38
async_tx: api initialized (async)
Key type asymmetric registered
Asymmetric key parser 'x509' registered
Asymmetric key parser 'pkcs8' registered
Key type pkcs7_test registered
Asymmetric key parser 'tpm_parser' registered
Block layer SCSI generic (bsg) driver version 0.4 loaded (major 243)
io scheduler mq-deadline registered
io scheduler kyber registered
io scheduler bfq registered
hgafb: HGA card not detected.
hgafb: probe of hgafb.0 failed with error -22
usbcore: registered new interface driver udlfb
uvesafb: failed to execute /sbin/v86d
uvesafb: make sure that the v86d helper is installed and executable
uvesafb: Getting VBE info block failed (eax=0x4f00, err=-2)
uvesafb: vbe_init() failed with -22
uvesafb: probe of uvesafb.0 failed with error -22
vga16fb: mapped to 0x00000000ab381a8e
Console: switching to colour frame buffer device 80x30
fb0: VGA16 VGA frame buffer device
input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0
ACPI: Power Button [PWRF]
ioatdma: Intel(R) QuickData Technology Driver 5.00
PCI Interrupt Link [GSIF] enabled at IRQ 21
PCI Interrupt Link [GSIH] enabled at IRQ 23
N_HDLC line discipline registered with maxframe=4096
Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
00:05: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
Cyclades driver 2.6
Initializing Nozomi driver 2.1d
RocketPort device driver module, version 2.09, 12-June-2003
No rocketport ports found; unloading driver
Non-volatile memory driver v1.3
Linux agpgart interface v0.103
[drm] Initialized vgem 1.0.0 20120112 for vgem on minor 0
[drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[drm] Initialized vkms 1.0.0 20180514 for vkms on minor 1
usbcore: registered new interface driver udl
[drm] pci: virtio-vga detected at 0000:00:01.0
fb0: switching to virtiodrmfb from VGA16 VGA
Console: switching to colour VGA+ 80x25
virtio-pci 0000:00:01.0: vgaarb: deactivate vga console
Console: switching to colour dummy device 80x25
[drm] features: -virgl +edid
[drm] number of scanouts: 1
[drm] number of cap sets: 0
[drm] Initialized virtio_gpu 0.1.0 0 for virtio0 on minor 2
==================================================================
BUG: KASAN: slab-out-of-bounds in virtio_gpu_object_shmem_init drivers/gpu/drm/virtio/virtgpu_object.c:151 [inline]
BUG: KASAN: slab-out-of-bounds in virtio_gpu_object_create+0x9f3/0xaa0 drivers/gpu/drm/virtio/virtgpu_object.c:230
Write of size 8 at addr ffff888027f7a388 by task swapper/0/1

CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.6.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 print_address_description.constprop.0.cold+0xd3/0x315 mm/kasan/report.c:374
 __kasan_report.cold+0x1a/0x32 mm/kasan/report.c:506
 kasan_report+0xe/0x20 mm/kasan/common.c:641
 virtio_gpu_object_shmem_init drivers/gpu/drm/virtio/virtgpu_object.c:151 [inline]
 virtio_gpu_object_create+0x9f3/0xaa0 drivers/gpu/drm/virtio/virtgpu_object.c:230
 virtio_gpu_gem_create+0xaa/0x1d0 drivers/gpu/drm/virtio/virtgpu_gem.c:42
 virtio_gpu_mode_dumb_create+0x21e/0x360 drivers/gpu/drm/virtio/virtgpu_gem.c:82
 drm_mode_create_dumb+0x27c/0x300 drivers/gpu/drm/drm_dumb_buffers.c:94
 drm_client_buffer_create drivers/gpu/drm/drm_client.c:267 [inline]
 drm_client_framebuffer_create+0x1b7/0x770 drivers/gpu/drm/drm_client.c:412
 drm_fb_helper_generic_probe+0x1e4/0x810 drivers/gpu/drm/drm_fb_helper.c:2039
 drm_fb_helper_single_fb_probe drivers/gpu/drm/drm_fb_helper.c:1588 [inline]
 __drm_fb_helper_initial_config_and_unlock+0xb56/0x11e0 drivers/gpu/drm/drm_fb_helper.c:1746
 drm_fb_helper_initial_config drivers/gpu/drm/drm_fb_helper.c:1841 [inline]
 drm_fb_helper_initial_config drivers/gpu/drm/drm_fb_helper.c:1833 [inline]
 drm_fbdev_client_hotplug+0x30f/0x580 drivers/gpu/drm/drm_fb_helper.c:2133
 drm_fbdev_generic_setup drivers/gpu/drm/drm_fb_helper.c:2212 [inline]
 drm_fbdev_generic_setup+0x18b/0x295 drivers/gpu/drm/drm_fb_helper.c:2185
 virtio_gpu_probe+0x28f/0x2de drivers/gpu/drm/virtio/virtgpu_drv.c:127
 virtio_dev_probe+0x463/0x710 drivers/virtio/virtio.c:248
 really_probe+0x281/0x6d0 drivers/base/dd.c:527
 driver_probe_device+0x104/0x210 drivers/base/dd.c:701
 device_driver_attach+0x108/0x140 drivers/base/dd.c:975
 __driver_attach+0xda/0x240 drivers/base/dd.c:1052
 bus_for_each_dev+0x14b/0x1d0 drivers/base/bus.c:305
 bus_add_driver+0x4a2/0x5a0 drivers/base/bus.c:622
 driver_register+0x1c4/0x330 drivers/base/driver.c:171
 do_one_initcall+0x10a/0x7d0 init/main.c:1152
 do_initcall_level init/main.c:1225 [inline]
 do_initcalls init/main.c:1241 [inline]
 do_basic_setup init/main.c:1261 [inline]
 kernel_init_freeable+0x501/0x5ae init/main.c:1445
 kernel_init+0xd/0x1bb init/main.c:1352
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 1:
 save_stack+0x1b/0x80 mm/kasan/common.c:72
 set_track mm/kasan/common.c:80 [inline]
 __kasan_kmalloc mm/kasan/common.c:515 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:488
 kmem_cache_alloc_trace+0x153/0x7d0 mm/slab.c:3551
 kmalloc include/linux/slab.h:555 [inline]
 kzalloc include/linux/slab.h:669 [inline]
 virtio_gpu_create_object+0x3c/0xe0 drivers/gpu/drm/virtio/virtgpu_object.c:128
 drm_gem_shmem_create+0x83/0x330 drivers/gpu/drm/drm_gem_shmem_helper.c:58
 virtio_gpu_object_create+0xa5/0xaa0 drivers/gpu/drm/virtio/virtgpu_object.c:199
 virtio_gpu_gem_create+0xaa/0x1d0 drivers/gpu/drm/virtio/virtgpu_gem.c:42
 virtio_gpu_mode_dumb_create+0x21e/0x360 drivers/gpu/drm/virtio/virtgpu_gem.c:82
 drm_mode_create_dumb+0x27c/0x300 drivers/gpu/drm/drm_dumb_buffers.c:94
 drm_client_buffer_create drivers/gpu/drm/drm_client.c:267 [inline]
 drm_client_framebuffer_create+0x1b7/0x770 drivers/gpu/drm/drm_client.c:412
 drm_fb_helper_generic_probe+0x1e4/0x810 drivers/gpu/drm/drm_fb_helper.c:2039
 drm_fb_helper_single_fb_probe drivers/gpu/drm/drm_fb_helper.c:1588 [inline]
 __drm_fb_helper_initial_config_and_unlock+0xb56/0x11e0 drivers/gpu/drm/drm_fb_helper.c:1746
 drm_fb_helper_initial_config drivers/gpu/drm/drm_fb_helper.c:1841 [inline]
 drm_fb_helper_initial_config drivers/gpu/drm/drm_fb_helper.c:1833 [inline]
 drm_fbdev_client_hotplug+0x30f/0x580 drivers/gpu/drm/drm_fb_helper.c:2133
 drm_fbdev_generic_setup drivers/gpu/drm/drm_fb_helper.c:2212 [inline]
 drm_fbdev_generic_setup+0x18b/0x295 drivers/gpu/drm/drm_fb_helper.c:2185
 virtio_gpu_probe+0x28f/0x2de drivers/gpu/drm/virtio/virtgpu_drv.c:127
 virtio_dev_probe+0x463/0x710 drivers/virtio/virtio.c:248
 really_probe+0x281/0x6d0 drivers/base/dd.c:527
 driver_probe_device+0x104/0x210 drivers/base/dd.c:701
 device_driver_attach+0x108/0x140 drivers/base/dd.c:975
 __driver_attach+0xda/0x240 drivers/base/dd.c:1052
 bus_for_each_dev+0x14b/0x1d0 drivers/base/bus.c:305
 bus_add_driver+0x4a2/0x5a0 drivers/base/bus.c:622
 driver_register+0x1c4/0x330 drivers/base/driver.c:171
 do_one_initcall+0x10a/0x7d0 init/main.c:1152
 do_initcall_level init/main.c:1225 [inline]
 do_initcalls init/main.c:1241 [inline]
 do_basic_setup init/main.c:1261 [inline]
 kernel_init_freeable+0x501/0x5ae init/main.c:1445
 kernel_init+0xd/0x1bb init/main.c:1352
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff888027f7a000
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 904 bytes inside of
 1024-byte region [ffff888027f7a000, ffff888027f7a400)
The buggy address belongs to the page:
page:ffffea00009fde80 refcount:1 mapcount:0 mapping:ffff88802c800c40 index:0x0
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea0000a49408 ffff88802c801850 ffff88802c800c40
raw: 0000000000000000 ffff888027f7a000 0000000100000002 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff888027f7a280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888027f7a300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888027f7a380: 00 fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                      ^
 ffff888027f7a400: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888027f7a480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
