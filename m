Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED39CC33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14742082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 09:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgAQJ5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 04:57:12 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:42284 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726688AbgAQJ5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 04:57:11 -0500
Received: by mail-il1-f198.google.com with SMTP id c5so18496712ilo.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 01:57:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=jvd+XDcLUiNTgZf2ffx4vK9HLkx9bi+qfHlaOUZsns0=;
        b=V8P5S6nH08j7ZMGEmvWpOyEQOAuvDIT4+a7UrMaocYKIpxp2JF9+XiSUdO4TFk8n1C
         +WtJDimRG5ipv+IAVSwtRDHwXRh0wiGtyXax2sASAgvWoOUp1G4IA+0CnipUAHcPFeQV
         V+QjAowpvC716xg+IzcbjQNGkoH2laUJ0HXq2cDG8fYa2a7mfiw35V6K8hqTL3hDlxCB
         55QyZYC4i2UNj1JR0q/RJW/wY9D3ziL+SpR9ONIa2fJ/B2yZVM4OYe4adid2ViZ+sU1V
         kaWsGxtWwLIxPJ7mTTJ3sxSYyUSH1DSfmxM2nSISwvQx93+u/5ECwAcsOYTcLpeE+2Fu
         RR/Q==
X-Gm-Message-State: APjAAAWclADPN+gmvU88N3jSGnmbObV/CpH4947BRhdp7Q2S/e10IyGL
        bhMznxKWGUpONtVOeXhsY9ux+DVgW1mwyjMw067UMnzhlKJr
X-Google-Smtp-Source: APXvYqyG6FGOWIiAI1ZbABmLLBIo8ME5plAKAEezIubwTdN7xCMJQFUUmcLGBp3rpb9hJYrXxFphaiBsWGWKG5BTTQ1rw4r87Rv5
MIME-Version: 1.0
X-Received: by 2002:a92:2550:: with SMTP id l77mr2166053ill.21.1579255030515;
 Fri, 17 Jan 2020 01:57:10 -0800 (PST)
Date:   Fri, 17 Jan 2020 01:57:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a91f9059c52f727@google.com>
Subject: linux-next boot error: KASAN: slab-out-of-bounds Read in post_usb_notification
From:   syzbot <syzbot+afeecc39f502a8681560@syzkaller.appspotmail.com>
To:     arnd@arndb.de, dhowells@redhat.com, dmitry.torokhov@gmail.com,
        ebiederm@xmission.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    de970dff Add linux-next specific files for 20200117
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=163472d1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c59155180d08b1f7
dashboard link: https://syzkaller.appspot.com/bug?extid=afeecc39f502a8681560
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+afeecc39f502a8681560@syzkaller.appspotmail.com

usbcore: registered new interface driver usb-storage
usbcore: registered new interface driver ums-realtek
usbcore: registered new interface driver usbserial_generic
usbserial: USB Serial support registered for generic
usbcore: registered new interface driver ch341
usbserial: USB Serial support registered for ch341-uart
usbcore: registered new interface driver cp210x
usbserial: USB Serial support registered for cp210x
usbcore: registered new interface driver ftdi_sio
usbserial: USB Serial support registered for FTDI USB Serial Device
usbcore: registered new interface driver keyspan
usbserial: USB Serial support registered for Keyspan - (without firmware)
usbserial: USB Serial support registered for Keyspan 1 port adapter
usbserial: USB Serial support registered for Keyspan 2 port adapter
usbserial: USB Serial support registered for Keyspan 4 port adapter
usbcore: registered new interface driver option
usbserial: USB Serial support registered for GSM modem (1-port)
usbcore: registered new interface driver oti6858
usbserial: USB Serial support registered for oti6858
usbcore: registered new interface driver pl2303
usbserial: USB Serial support registered for pl2303
usbcore: registered new interface driver qcserial
usbserial: USB Serial support registered for Qualcomm USB modem
usbcore: registered new interface driver sierra
usbserial: USB Serial support registered for Sierra USB modem
usbcore: registered new interface driver usb_serial_simple
usbserial: USB Serial support registered for carelink
usbserial: USB Serial support registered for zio
usbserial: USB Serial support registered for funsoft
usbserial: USB Serial support registered for flashloader
usbserial: USB Serial support registered for google
usbserial: USB Serial support registered for libtransistor
usbserial: USB Serial support registered for vivopay
usbserial: USB Serial support registered for moto_modem
usbserial: USB Serial support registered for motorola_tetra
usbserial: USB Serial support registered for novatel_gps
usbserial: USB Serial support registered for hp4x
usbserial: USB Serial support registered for suunto
usbserial: USB Serial support registered for siemens_mpi
dummy_hcd dummy_hcd.0: USB Host+Gadget Emulator, driver 02 May 2005
dummy_hcd dummy_hcd.0: Dummy host controller
dummy_hcd dummy_hcd.0: new USB bus registered, assigned bus number 1
usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice=  
5.05
usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: Product: Dummy host controller
usb usb1: Manufacturer: Linux 5.5.0-rc6-next-20200117-syzkaller dummy_hcd
usb usb1: SerialNumber: dummy_hcd.0
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 1 port detected
==================================================================
BUG: KASAN: slab-out-of-bounds in memcpy include/linux/string.h:426 [inline]
BUG: KASAN: slab-out-of-bounds in post_usb_notification+0xe5/0x170  
drivers/usb/core/devio.c:2771
Read of size 21 at addr ffff88809ef1d5c0 by task swapper/0/1

CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.5.0-rc6-next-20200117-syzkaller  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x32 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:641
  check_memory_region_inline mm/kasan/generic.c:185 [inline]
  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
  memcpy+0x24/0x50 mm/kasan/common.c:127
  memcpy include/linux/string.h:426 [inline]
  post_usb_notification+0xe5/0x170 drivers/usb/core/devio.c:2771
  post_usb_device_notification drivers/usb/core/devio.c:2785 [inline]
  usbdev_notify+0x2c0/0x4a0 drivers/usb/core/devio.c:2800
  notifier_call_chain+0xc2/0x230 kernel/notifier.c:83
  __blocking_notifier_call_chain kernel/notifier.c:284 [inline]
  __blocking_notifier_call_chain kernel/notifier.c:271 [inline]
  blocking_notifier_call_chain kernel/notifier.c:295 [inline]
  blocking_notifier_call_chain+0x94/0xb0 kernel/notifier.c:292
  usb_notify_add_device+0x22/0x30 drivers/usb/core/notify.c:51
  generic_probe+0x8c/0xde drivers/usb/core/generic.c:220
  usb_probe_device+0xa0/0xf0 drivers/usb/core/driver.c:266
  really_probe+0x291/0x700 drivers/base/dd.c:551
  driver_probe_device+0x110/0x220 drivers/base/dd.c:724
  __device_attach_driver+0x1c9/0x230 drivers/base/dd.c:831
  bus_for_each_drv+0x172/0x1f0 drivers/base/bus.c:431
  __device_attach+0x237/0x390 drivers/base/dd.c:897
  device_initial_probe+0x1b/0x20 drivers/base/dd.c:944
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:491
  device_add+0x14fe/0x1d00 drivers/base/core.c:2487
  usb_new_device.cold+0x74c/0x1063 drivers/usb/core/hub.c:2539
  register_root_hub drivers/usb/core/hcd.c:1008 [inline]
  usb_add_hcd.cold+0x10f8/0x1496 drivers/usb/core/hcd.c:2790
  dummy_hcd_probe+0x1ae/0x32c drivers/usb/gadget/udc/dummy_hcd.c:2639
  platform_drv_probe+0x8d/0x140 drivers/base/platform.c:727
  really_probe+0x291/0x700 drivers/base/dd.c:551
  driver_probe_device+0x110/0x220 drivers/base/dd.c:724
  __device_attach_driver+0x1c9/0x230 drivers/base/dd.c:831
  bus_for_each_drv+0x172/0x1f0 drivers/base/bus.c:431
  __device_attach+0x237/0x390 drivers/base/dd.c:897
  device_initial_probe+0x1b/0x20 drivers/base/dd.c:944
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:491
  device_add+0x14fe/0x1d00 drivers/base/core.c:2487
  platform_device_add+0x365/0x6e0 drivers/base/platform.c:564
  init+0x534/0xab8 arch/x86/crypto/chacha_glue.c:293
  do_one_initcall+0x120/0x820 init/main.c:1109
  do_initcall_level init/main.c:1182 [inline]
  do_initcalls init/main.c:1198 [inline]
  do_basic_setup init/main.c:1218 [inline]
  kernel_init_freeable+0x522/0x5d0 init/main.c:1402
  kernel_init+0x12/0x1bf init/main.c:1309
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Allocated by task 1:
  save_stack+0x23/0x90 mm/kasan/common.c:72
  set_track mm/kasan/common.c:80 [inline]
  __kasan_kmalloc mm/kasan/common.c:515 [inline]
  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:488
  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
  __do_kmalloc mm/slab.c:3656 [inline]
  __kmalloc_track_caller+0x15f/0x760 mm/slab.c:3671
  kvasprintf+0xc8/0x170 lib/kasprintf.c:25
  kvasprintf_const+0x65/0x190 lib/kasprintf.c:49
  kobject_set_name_vargs+0x5b/0x150 lib/kobject.c:289
  dev_set_name+0xbb/0xf0 drivers/base/core.c:2265
  usb_alloc_dev+0xcc4/0xf86 drivers/usb/core/usb.c:641
  usb_add_hcd.cold+0x3c1/0x1496 drivers/usb/core/hcd.c:2697
  dummy_hcd_probe+0x1ae/0x32c drivers/usb/gadget/udc/dummy_hcd.c:2639
  platform_drv_probe+0x8d/0x140 drivers/base/platform.c:727
  really_probe+0x291/0x700 drivers/base/dd.c:551
  driver_probe_device+0x110/0x220 drivers/base/dd.c:724
  __device_attach_driver+0x1c9/0x230 drivers/base/dd.c:831
  bus_for_each_drv+0x172/0x1f0 drivers/base/bus.c:431
  __device_attach+0x237/0x390 drivers/base/dd.c:897
  device_initial_probe+0x1b/0x20 drivers/base/dd.c:944
  bus_probe_device+0x1f1/0x2a0 drivers/base/bus.c:491
  device_add+0x14fe/0x1d00 drivers/base/core.c:2487
  platform_device_add+0x365/0x6e0 drivers/base/platform.c:564
  init+0x534/0xab8 arch/x86/crypto/chacha_glue.c:293
  do_one_initcall+0x120/0x820 init/main.c:1109
  do_initcall_level init/main.c:1182 [inline]
  do_initcalls init/main.c:1198 [inline]
  do_basic_setup init/main.c:1218 [inline]
  kernel_init_freeable+0x522/0x5d0 init/main.c:1402
  kernel_init+0x12/0x1bf init/main.c:1309
  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Freed by task 0:
(stack is not available)

The buggy address belongs to the object at ffff88809ef1d5c0
  which belongs to the cache kmalloc-32 of size 32
The buggy address is located 0 bytes inside of
  32-byte region [ffff88809ef1d5c0, ffff88809ef1d5e0)
The buggy address belongs to the page:
page:ffffea00027bc740 refcount:1 mapcount:0 mapping:ffff8880aa4001c0  
index:0xffff88809ef1dfc1
flags: 0xfffe0000000200(slab)
raw: 00fffe0000000200 ffffea00027bf048 ffffea00027bf788 ffff8880aa4001c0
raw: ffff88809ef1dfc1 ffff88809ef1d000 000000010000003f 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff88809ef1d480: fb fb fb fb fc fc fc fc fb fb fb fb fc fc fc fc
  ffff88809ef1d500: 00 00 00 01 fc fc fc fc fb fb fb fb fc fc fc fc
> ffff88809ef1d580: fb fb fb fb fc fc fc fc 05 fc fc fc fc fc fc fc
                                            ^
  ffff88809ef1d600: 00 fc fc fc fc fc fc fc 00 04 fc fc fc fc fc fc
  ffff88809ef1d680: fb fb fb fb fc fc fc fc 00 04 fc fc fc fc fc fc
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
