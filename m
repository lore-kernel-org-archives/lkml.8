Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12653C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D38E320774
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729273AbgHKRGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:06:22 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:49019 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729181AbgHKRGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:06:19 -0400
Received: by mail-io1-f72.google.com with SMTP id k10so10216528iow.15
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 10:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RxnDrZAgrm5qTZ0RPNFz6huceHpzuDNxWd8B/TcZ13s=;
        b=Wl2qXoVCyNL2TT3y/og8o4avAZG0CpPX4rkucRVVJ9HhLW0kJKU9PUTiFSzInl/Kps
         S7bejF/vs0y8nLdDTPin8gyA3MgJIUr74Ww9YfJDHKrlbw0sVYJwVVyaSbvl0H4dAPZR
         e8nVQ/aRDofS7HajIcAvzD+DtiVyo31DuRqm2QeX70mvhnhHLULSwoYKpeKhxHCTouJn
         xz2gSufeJUO1tFm0KO5vGJTGX9Fsja3fMkmG+cG/YbsqyimxxdAcJ+URvuwKhK72SHcL
         FFW/4PpNQGQ8AZLSPKu9xS9nUj21+Mik5B/ACiQZ9UcJ6zd47FP6Ykw0oLCdNRf0yvwn
         I2Og==
X-Gm-Message-State: AOAM530KVNDUkJh6FK/e+ZwuK2y2ys1rUrBKvdQmW2A/e8ELIqjHzsP0
        8hfyKZv9zEQbUEheLoa9wiEcLaNEttDCkCY/BibtVrxGxNn/
X-Google-Smtp-Source: ABdhPJyVzuOJqFeDPOWCQIBGIxE4BphWmAyddfJ97xQeXPlpEfycHfskkE1R39zcSbsSr1S84/rXvf2wvQ705g2Cbs483WLzwZiC
MIME-Version: 1.0
X-Received: by 2002:a92:cb12:: with SMTP id s18mr7589772ilo.13.1597165578180;
 Tue, 11 Aug 2020 10:06:18 -0700 (PDT)
Date:   Tue, 11 Aug 2020 10:06:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef601705ac9d161b@google.com>
Subject: KMSAN: kernel-usb-infoleak in hif_usb_send
From:   syzbot <syzbot+f83a1df1ed4f67e8d8ad@syzkaller.appspotmail.com>
To:     glider@google.com, gregkh@linuxfoundation.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ce8056d1 wip: changed copy_from_user where instrumented
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=124d453c900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3afe005fb99591f
dashboard link: https://syzkaller.appspot.com/bug?extid=f83a1df1ed4f67e8d8ad
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f83a1df1ed4f67e8d8ad@syzkaller.appspotmail.com

usb 4-1: ath9k_htc: Transferred FW: ath9k_htc/htc_9271-1.4.0.fw, size: 51008
=====================================================
BUG: KMSAN: kernel-usb-infoleak in kmsan_handle_urb+0x28/0x40 mm/kmsan/kmsan_hooks.c:307
CPU: 1 PID: 13012 Comm: kworker/1:6 Not tainted 5.8.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events request_firmware_work_func
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x21c/0x280 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:121
 kmsan_internal_check_memory+0x238/0x3d0 mm/kmsan/kmsan.c:423
 kmsan_handle_urb+0x28/0x40 mm/kmsan/kmsan_hooks.c:307
 usb_submit_urb+0x861/0x2470 drivers/usb/core/urb.c:406
 hif_usb_send_regout drivers/net/wireless/ath/ath9k/hif_usb.c:127 [inline]
 hif_usb_send+0x633/0x1790 drivers/net/wireless/ath/ath9k/hif_usb.c:470
 htc_issue_send drivers/net/wireless/ath/ath9k/htc_hst.c:34 [inline]
 htc_connect_service+0x14b4/0x19f0 drivers/net/wireless/ath/ath9k/htc_hst.c:275
 ath9k_wmi_connect+0x178/0x2c0 drivers/net/wireless/ath/ath9k/wmi.c:268
 ath9k_init_htc_services+0xf3/0x11f0 drivers/net/wireless/ath/ath9k/htc_drv_init.c:146
 ath9k_htc_probe_device+0x4dc/0x3ed0 drivers/net/wireless/ath/ath9k/htc_drv_init.c:962
 ath9k_htc_hw_init+0xdf/0x190 drivers/net/wireless/ath/ath9k/htc_hst.c:501
 ath9k_hif_usb_firmware_cb+0x42e/0xab0 drivers/net/wireless/ath/ath9k/hif_usb.c:1218
 request_firmware_work_func+0x1aa/0x2d0 drivers/base/firmware_loader/main.c:1001
 process_one_work+0x1688/0x2140 kernel/workqueue.c:2269
 worker_thread+0x10bc/0x2730 kernel/workqueue.c:2415
 kthread+0x551/0x590 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:80
 slab_alloc_node mm/slub.c:2839 [inline]
 __kmalloc_node_track_caller+0xeab/0x12e0 mm/slub.c:4478
 __kmalloc_reserve net/core/skbuff.c:142 [inline]
 __alloc_skb+0x35f/0xb30 net/core/skbuff.c:210
 alloc_skb include/linux/skbuff.h:1083 [inline]
 htc_connect_service+0x1057/0x19f0 drivers/net/wireless/ath/ath9k/htc_hst.c:258
 ath9k_wmi_connect+0x178/0x2c0 drivers/net/wireless/ath/ath9k/wmi.c:268
 ath9k_init_htc_services+0xf3/0x11f0 drivers/net/wireless/ath/ath9k/htc_drv_init.c:146
 ath9k_htc_probe_device+0x4dc/0x3ed0 drivers/net/wireless/ath/ath9k/htc_drv_init.c:962
 ath9k_htc_hw_init+0xdf/0x190 drivers/net/wireless/ath/ath9k/htc_hst.c:501
 ath9k_hif_usb_firmware_cb+0x42e/0xab0 drivers/net/wireless/ath/ath9k/hif_usb.c:1218
 request_firmware_work_func+0x1aa/0x2d0 drivers/base/firmware_loader/main.c:1001
 process_one_work+0x1688/0x2140 kernel/workqueue.c:2269
 worker_thread+0x10bc/0x2730 kernel/workqueue.c:2415
 kthread+0x551/0x590 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293

Bytes 4-7 of 18 are uninitialized
Memory access of size 18 starts at ffff8881d24f1000
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
