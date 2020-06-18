Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EE7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3A2206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 21:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgFRVR0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 17:17:26 -0400
Received: from mail-il1-f197.google.com ([209.85.166.197]:49526 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgFRVRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 17:17:16 -0400
Received: by mail-il1-f197.google.com with SMTP id i7so4933813ilq.16
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 14:17:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=AAP02DG4gObySl04uyedKEVnzUHVVcCam/N0R2NtK38=;
        b=XFYTo45f0bq6u32PAinSeK7HuaBbKS2GVsJv1AMAtcwC7HgXQ1npsrQWAU7kH6LcZo
         ApeicbpmamNBJNLEVlFAKKbZ6AzJET4MlSAbK+ZVTZFy0texxCWp5YhxhdGRIpmvozsi
         Nq/2ORkzsxk+cA2uT2S487AEUqymRcCJz4aJnF5LWaxhtDmwX2jiFwc3Ja0syPv081H1
         8pTtmRc9gM6KbwRsmdBV6RA4xTxFGWLKrZTFgjdKc1M9Ts8I6c7Vyng+lklL1NSjewOE
         GgxRwT/CNRjRjDxJCkfQnsYzZS/47mrcS7BqlK7CMt56erCqKMV1+BK/Fu8KRy4t0R30
         fnnA==
X-Gm-Message-State: AOAM533ipKhBidjjucf9oeHAb8+CNwIt1CnVDBvyGRKM5SMek2mRjZJS
        /WN5EMZ600HWunzC3Rhje/Ek7W6WwqvncRuvmpROu8XQycHJ
X-Google-Smtp-Source: ABdhPJw/aLtCXPg1+z8Co94WVIF2nA3frvnbaR7Cf4f7HV6dSfB6FqnD+lnBSt1NdN9mSmw+pkxzuWxioh1PXGGbOXnKPi/RIxc0
MIME-Version: 1.0
X-Received: by 2002:a5d:8b53:: with SMTP id c19mr672568iot.93.1592515035964;
 Thu, 18 Jun 2020 14:17:15 -0700 (PDT)
Date:   Thu, 18 Jun 2020 14:17:15 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000004a76305a8624d22@google.com>
Subject: INFO: trying to register non-static key in is_dynamic_key
From:   syzbot <syzbot+42bc0d31b9a21faebdf8@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, bp@alien8.de, devel@etsukata.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        viro@zeniv.linux.org.uk, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    b791d1bd Merge tag 'locking-kcsan-2020-06-11' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=13f305a9100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=16c2467d4b6dbee2
dashboard link: https://syzkaller.appspot.com/bug?extid=42bc0d31b9a21faebdf8
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=136ad566100000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10138f7a100000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+42bc0d31b9a21faebdf8@syzkaller.appspotmail.com

INFO: trying to register non-static key.
the code is fine but needs lockdep annotation.
turning off the locking correctness validator.
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xf6/0x16e lib/dump_stack.c:118
 assign_lock_key kernel/locking/lockdep.c:894 [inline]
 register_lock_class+0x1442/0x17e0 kernel/locking/lockdep.c:1206
 arch_stack_walk+0x81/0xf0 arch/x86/kernel/stacktrace.c:25
 lock_downgrade+0x720/0x720 kernel/locking/lockdep.c:4624
 is_dynamic_key+0x1b0/0x1b0 kernel/locking/lockdep.c:1176
 trace_hardirqs_off+0x50/0x1f0 kernel/trace/trace_preemptirq.c:83
 __lock_acquire+0x101/0x6270 kernel/locking/lockdep.c:4259
 save_stack+0x32/0x40 mm/kasan/common.c:50
 save_stack+0x1b/0x40 mm/kasan/common.c:48
 set_track mm/kasan/common.c:56 [inline]
 __kasan_kmalloc mm/kasan/common.c:494 [inline]
 __kasan_kmalloc.constprop.0+0xbf/0xd0 mm/kasan/common.c:467
 slab_post_alloc_hook mm/slab.h:586 [inline]
 slab_alloc_node mm/slub.c:2824 [inline]
 slab_alloc mm/slub.c:2832 [inline]
 kmem_cache_alloc+0xd8/0x300 mm/slub.c:2837
 __build_skb+0x21/0x60 net/core/skbuff.c:311
 __netdev_alloc_skb+0x1e2/0x360 net/core/skbuff.c:464
 __dev_alloc_skb include/linux/skbuff.h:2813 [inline]
 ath9k_hif_usb_rx_stream drivers/net/wireless/ath/ath9k/hif_usb.c:620 [inline]
 ath9k_hif_usb_rx_cb+0x64f/0x1050 drivers/net/wireless/ath/ath9k/hif_usb.c:671
 __usb_hcd_giveback_urb+0x29a/0x550 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1716
 dummy_timer+0x125e/0x32b4 drivers/usb/gadget/udc/dummy_hcd.c:1967
 call_timer_fn+0x1ac/0x6e0 kernel/time/timer.c:1404
 expire_timers kernel/time/timer.c:1449 [inline]
 __run_timers kernel/time/timer.c:1773 [inline]
 __run_timers kernel/time/timer.c:1740 [inline]
 run_timer_softirq+0x5e5/0x14c0 kernel/time/timer.c:1786
 __do_softirq+0x21e/0x996 kernel/softirq.c:292
 lockdep_hardirqs_on_prepare+0x550/0x550 kernel/locking/lockdep.c:3667
 native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
 arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
 acpi_safe_halt drivers/acpi/processor_idle.c:111 [inline]
 acpi_safe_halt+0x72/0x90 drivers/acpi/processor_idle.c:108


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
