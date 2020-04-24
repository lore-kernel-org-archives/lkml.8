Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1B2C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D827C20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 15:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgDXPeG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 11:34:06 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:48732 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDXPeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 11:34:06 -0400
Received: by mail-io1-f72.google.com with SMTP id i15so10837703iog.15
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 08:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6+LYSWCNY+AWOZQVAq2B2Z81Z56vWKeSEUAwZX+Hltg=;
        b=IaYeXjkzooJ14wQF84uM34xsbaDJZLvNhc1oIZJnpZSJadeFHm+HzQTFGMgenlj6wc
         GPVGpXA3VV8mei+mwBmbzaZY87QA2Y4ULjGnNeVFhxDTUtmKLKMp6ZbGsCfmLxTDPr21
         PedubeVGGKOWnYT4C77WhJRUt/8og3wdx1iD3kFj5Qq4IW6iiQbzRm8cCu3pV9huPgPt
         Ev5x4TSDkAAwyJG5V2Zgmgkl/bRJHkBk5BIOs8BCFSw+ud/hUQOJIgzndd8rSoaIW7jN
         g2ERgtcvudCRCZA1yE+KvjhQ2gZobwt7dPa24vuIHc22m37wF+6/XBfNHl+Xp1BCRwFt
         77vw==
X-Gm-Message-State: AGi0PuY7QsLkfsKbXpdYjYG08RIgN48CnMcccLfPnIpL9l270sYAyy5I
        F8SwbtgYtAzmzEQtotJxzG1sO2fU1ZVb9ANEi3ezYUVa6Fdo
X-Google-Smtp-Source: APiQypJAvruu5ttakeffC3ZrphiG0YXQ4ufIQ1axcfegSYPIi4NHp5uHciQy2jWtdMLiMFIT4SyjMZbvbKdJawd9v1C5Y4o+xHqZ
MIME-Version: 1.0
X-Received: by 2002:a6b:fc0d:: with SMTP id r13mr8995491ioh.89.1587742443252;
 Fri, 24 Apr 2020 08:34:03 -0700 (PDT)
Date:   Fri, 24 Apr 2020 08:34:03 -0700
In-Reply-To: <Pine.LNX.4.44L0.2004241114460.2596-100000@netrider.rowland.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000535b2805a40b1847@google.com>
Subject: Re: WARNING in usbhid_raw_request/usb_submit_urb (3)
From:   syzbot <syzbot+db339689b2101f6f6071@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, gregkh@linuxfoundation.org,
        ingrassia@epigenesys.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, stern@rowland.harvard.edu,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch but the reproducer still triggered crash:
INFO: task hung in usb_disable_device

INFO: task kworker/0:1:12 blocked for more than 143 seconds.
      Not tainted 5.6.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/0:1     D23304    12      2 0x80004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 schedule+0xcd/0x2b0 kernel/sched/core.c:4154
 schedule_preempt_disabled+0xc/0x20 kernel/sched/core.c:4213
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x87c/0x1360 kernel/locking/mutex.c:1103
 device_lock include/linux/device.h:771 [inline]
 device_del+0x9e/0xd30 drivers/base/core.c:2640
 usb_disable_device+0x23d/0x7a0 drivers/usb/core/message.c:1238
 usb_disconnect+0x2a5/0x920 drivers/usb/core/hub.c:2211
 hub_port_connect drivers/usb/core/hub.c:5049 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5339 [inline]
 port_event drivers/usb/core/hub.c:5485 [inline]
 hub_event+0x1a56/0x43b0 drivers/usb/core/hub.c:5567
 process_one_work+0x94b/0x1620 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
INFO: task kworker/1:0:17 blocked for more than 143 seconds.
      Not tainted 5.6.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/1:0     D23392    17      2 0x80004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 schedule+0xcd/0x2b0 kernel/sched/core.c:4154
 schedule_preempt_disabled+0xc/0x20 kernel/sched/core.c:4213
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x87c/0x1360 kernel/locking/mutex.c:1103
 device_lock include/linux/device.h:771 [inline]
 device_del+0x9e/0xd30 drivers/base/core.c:2640
 usb_disable_device+0x23d/0x7a0 drivers/usb/core/message.c:1238
 usb_disconnect+0x2a5/0x920 drivers/usb/core/hub.c:2211
 hub_port_connect drivers/usb/core/hub.c:5049 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5339 [inline]
 port_event drivers/usb/core/hub.c:5485 [inline]
 hub_event+0x1a56/0x43b0 drivers/usb/core/hub.c:5567
 process_one_work+0x94b/0x1620 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
INFO: task kworker/0:4:3216 blocked for more than 143 seconds.
      Not tainted 5.6.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/0:4     D23696  3216      2 0x80004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 schedule+0xcd/0x2b0 kernel/sched/core.c:4154
 schedule_preempt_disabled+0xc/0x20 kernel/sched/core.c:4213
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x87c/0x1360 kernel/locking/mutex.c:1103
 __input_unregister_device+0x118/0x430 drivers/input/input.c:2087
 input_unregister_device+0xb4/0xf0 drivers/input/input.c:2272
 hidinput_disconnect+0x15e/0x3d0 drivers/hid/hid-input.c:1968
 hid_disconnect+0x13f/0x1a0 drivers/hid/hid-core.c:2008
 hid_hw_stop drivers/hid/hid-core.c:2055 [inline]
 hid_device_remove+0x186/0x240 drivers/hid/hid-core.c:2298
 __device_release_driver drivers/base/dd.c:1135 [inline]
 device_release_driver_internal+0x231/0x500 drivers/base/dd.c:1168
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x481/0xd30 drivers/base/core.c:2677
 hid_remove_device drivers/hid/hid-core.c:2467 [inline]
 hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2486
 usbhid_disconnect+0x9f/0xe0 drivers/hid/usbhid/hid-core.c:1414
 usb_unbind_interface+0x1c6/0x8a0 drivers/usb/core/driver.c:436
 __device_release_driver drivers/base/dd.c:1137 [inline]
 device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1168
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x481/0xd30 drivers/base/core.c:2677
 usb_disable_device+0x23d/0x7a0 drivers/usb/core/message.c:1238
 usb_disconnect+0x2a5/0x920 drivers/usb/core/hub.c:2211
 hub_port_connect drivers/usb/core/hub.c:5049 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5339 [inline]
 port_event drivers/usb/core/hub.c:5485 [inline]
 hub_event+0x1a56/0x43b0 drivers/usb/core/hub.c:5567
 process_one_work+0x94b/0x1620 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
INFO: task kworker/0:5:3229 blocked for more than 144 seconds.
      Not tainted 5.6.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/0:5     D27760  3229      2 0x80004000
Workqueue: events hid_reset
Call Trace:
 schedule+0xcd/0x2b0 kernel/sched/core.c:4154
 schedule_timeout+0x682/0xb20 kernel/time/timer.c:1871
 do_wait_for_common kernel/sched/completion.c:83 [inline]
 __wait_for_common kernel/sched/completion.c:104 [inline]
 wait_for_common kernel/sched/completion.c:115 [inline]
 wait_for_completion+0x26f/0x3c0 kernel/sched/completion.c:136
 __flush_work+0x4f9/0xa80 kernel/workqueue.c:3043
 __cancel_work_timer+0x32c/0x460 kernel/workqueue.c:3130
 hid_cancel_delayed_stuff drivers/hid/usbhid/hid-core.c:1421 [inline]
 usbhid_close+0x134/0x210 drivers/hid/usbhid/hid-core.c:750
 hid_hw_close+0xa8/0xd0 drivers/hid/hid-core.c:2100
 input_close_device+0x110/0x1a0 drivers/input/input.c:682
 input_leds_disconnect+0xfd/0x160 drivers/input/input-leds.c:182
 __input_unregister_device+0x1b0/0x430 drivers/input/input.c:2090
 input_unregister_device+0xb4/0xf0 drivers/input/input.c:2272
 hidinput_disconnect+0x15e/0x3d0 drivers/hid/hid-input.c:1968
 hid_disconnect+0x13f/0x1a0 drivers/hid/hid-core.c:2008
 hid_hw_stop drivers/hid/hid-core.c:2055 [inline]
 hid_device_remove+0x186/0x240 drivers/hid/hid-core.c:2298
 __device_release_driver drivers/base/dd.c:1135 [inline]
 device_release_driver_internal+0x231/0x500 drivers/base/dd.c:1168
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x481/0xd30 drivers/base/core.c:2677
 hid_remove_device drivers/hid/hid-core.c:2467 [inline]
 hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2486
 usbhid_disconnect+0x9f/0xe0 drivers/hid/usbhid/hid-core.c:1414
 usb_unbind_interface+0x1c6/0x8a0 drivers/usb/core/driver.c:436
 __device_release_driver drivers/base/dd.c:1137 [inline]
 device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1168
 usb_driver_release_interface+0x102/0x180 drivers/usb/core/driver.c:609
 usb_forced_unbind_intf+0x50/0xb0 drivers/usb/core/driver.c:1057
 unbind_marked_interfaces.isra.0+0x15e/0x1c0 drivers/usb/core/driver.c:1080
 usb_unbind_and_rebind_marked_interfaces+0x34/0x70 drivers/usb/core/driver.c:1141
 usb_reset_device+0x742/0x960 drivers/usb/core/hub.c:5967
 hid_reset+0x243/0x420 drivers/hid/usbhid/hid-core.c:138
 process_one_work+0x94b/0x1620 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
INFO: task kworker/0:6:3266 blocked for more than 144 seconds.
      Not tainted 5.6.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/0:6     D27552  3266      2 0x80004000
Workqueue: events hid_reset
Call Trace:
 schedule+0xcd/0x2b0 kernel/sched/core.c:4154
 schedule_preempt_disabled+0xc/0x20 kernel/sched/core.c:4213
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x87c/0x1360 kernel/locking/mutex.c:1103
 __input_unregister_device+0x118/0x430 drivers/input/input.c:2087
 input_unregister_device+0xb4/0xf0 drivers/input/input.c:2272
 hidinput_disconnect+0x15e/0x3d0 drivers/hid/hid-input.c:1968
 hid_disconnect+0x13f/0x1a0 drivers/hid/hid-core.c:2008
 hid_hw_stop drivers/hid/hid-core.c:2055 [inline]
 hid_device_remove+0x186/0x240 drivers/hid/hid-core.c:2298
 __device_release_driver drivers/base/dd.c:1135 [inline]
 device_release_driver_internal+0x231/0x500 drivers/base/dd.c:1168
 bus_remove_device+0x2eb/0x5a0 drivers/base/bus.c:533
 device_del+0x481/0xd30 drivers/base/core.c:2677
 hid_remove_device drivers/hid/hid-core.c:2467 [inline]
 hid_destroy_device+0xe1/0x150 drivers/hid/hid-core.c:2486
 usbhid_disconnect+0x9f/0xe0 drivers/hid/usbhid/hid-core.c:1414
 usb_unbind_interface+0x1c6/0x8a0 drivers/usb/core/driver.c:436
 __device_release_driver drivers/base/dd.c:1137 [inline]
 device_release_driver_internal+0x42f/0x500 drivers/base/dd.c:1168
 usb_driver_release_interface+0x102/0x180 drivers/usb/core/driver.c:609
 usb_forced_unbind_intf+0x50/0xb0 drivers/usb/core/driver.c:1057
 unbind_marked_interfaces.isra.0+0x15e/0x1c0 drivers/usb/core/driver.c:1080
 usb_unbind_and_rebind_marked_interfaces+0x34/0x70 drivers/usb/core/driver.c:1141
 usb_reset_device+0x742/0x960 drivers/usb/core/hub.c:5967
 hid_reset+0x243/0x420 drivers/hid/usbhid/hid-core.c:138
 process_one_work+0x94b/0x1620 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
INFO: task kworker/1:4:3267 blocked for more than 144 seconds.
      Not tainted 5.6.0-rc7-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/1:4     D28272  3267      2 0x80004000
Workqueue: events hid_reset
Call Trace:
 schedule+0xcd/0x2b0 kernel/sched/core.c:4154
 schedule_preempt_disabled+0xc/0x20 kernel/sched/core.c:4213
 __mutex_lock_common kernel/locking/mutex.c:1033 [inline]
 __mutex_lock+0x87c/0x1360 kernel/locking/mutex.c:1103
 device_lock include/linux/device.h:771 [inline]
 __device_attach+0x7b/0x390 drivers/base/dd.c:874
 usb_rebind_intf drivers/usb/core/driver.c:1104 [inline]
 rebind_marked_interfaces.isra.0+0x1ea/0x290 drivers/usb/core/driver.c:1127
 usb_reset_device+0x742/0x960 drivers/usb/core/hub.c:5967
 hid_reset+0x243/0x420 drivers/hid/usbhid/hid-core.c:138
 process_one_work+0x94b/0x1620 kernel/workqueue.c:2266
 worker_thread+0x96/0xe20 kernel/workqueue.c:2412
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

Showing all locks held in the system:
5 locks held by kworker/0:1/12:
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: __write_once_size include/linux/compiler.h:226 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:855 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: process_one_work+0x82a/0x1620 kernel/workqueue.c:2237
 #1: ffff8881da227dd0 ((work_completion)(&hub->events)){+.+.}, at: process_one_work+0x85e/0x1620 kernel/workqueue.c:2241
 #2: ffff8881d4d1e208 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #2: ffff8881d4d1e208 (&dev->mutex){....}, at: hub_event+0x1be/0x43b0 drivers/usb/core/hub.c:5513
 #3: ffff8881da2f3208 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #3: ffff8881da2f3208 (&dev->mutex){....}, at: usb_disconnect+0xa3/0x920 drivers/usb/core/hub.c:2202
 #4: ffff8881d8fac190 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #4: ffff8881d8fac190 (&dev->mutex){....}, at: device_del+0x9e/0xd30 drivers/base/core.c:2640
5 locks held by kworker/1:0/17:
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: __write_once_size include/linux/compiler.h:226 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:855 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: process_one_work+0x82a/0x1620 kernel/workqueue.c:2237
 #1: ffff8881da267dd0 ((work_completion)(&hub->events)){+.+.}, at: process_one_work+0x85e/0x1620 kernel/workqueue.c:2241
 #2: ffff8881d4ccf208 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #2: ffff8881d4ccf208 (&dev->mutex){....}, at: hub_event+0x1be/0x43b0 drivers/usb/core/hub.c:5513
 #3: ffff8881c8d9e208 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #3: ffff8881c8d9e208 (&dev->mutex){....}, at: usb_disconnect+0xa3/0x920 drivers/usb/core/hub.c:2202
 #4: ffff8881d8fad190 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #4: ffff8881d8fad190 (&dev->mutex){....}, at: device_del+0x9e/0xd30 drivers/base/core.c:2640
1 lock held by khungtaskd/23:
 #0: ffffffff87108b60 (rcu_read_lock){....}, at: debug_show_all_locks+0x53/0x264 kernel/locking/lockdep.c:5331
7 locks held by kworker/1:2/83:
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: __write_once_size include/linux/compiler.h:226 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:855 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: process_one_work+0x82a/0x1620 kernel/workqueue.c:2237
 #1: ffff8881d8a87dd0 ((work_completion)(&hub->events)){+.+.}, at: process_one_work+0x85e/0x1620 kernel/workqueue.c:2241
 #2: ffff8881d4dc2208 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #2: ffff8881d4dc2208 (&dev->mutex){....}, at: hub_event+0x1be/0x43b0 drivers/usb/core/hub.c:5513
 #3: ffff8881d416f208 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #3: ffff8881d416f208 (&dev->mutex){....}, at: __device_attach+0x7b/0x390 drivers/base/dd.c:874
 #4: ffff8881d0a69190 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #4: ffff8881d0a69190 (&dev->mutex){....}, at: __device_attach+0x7b/0x390 drivers/base/dd.c:874
 #5: ffff8881c8219a88 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #5: ffff8881c8219a88 (&dev->mutex){....}, at: __device_attach+0x7b/0x390 drivers/base/dd.c:874
 #6: ffffffff877ca580 (input_mutex){+.+.}, at: input_register_device.cold+0x5c/0x316 drivers/input/input.c:2221
1 lock held by in:imklog/256:
 #0: ffff8881c8ce1c60 (&f->f_pos_lock){+.+.}, at: __fdget_pos+0xe3/0x100 fs/file.c:826
7 locks held by kworker/0:4/3216:
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: __write_once_size include/linux/compiler.h:226 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:855 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: process_one_work+0x82a/0x1620 kernel/workqueue.c:2237
 #1: ffff8881bd4d7dd0 ((work_completion)(&hub->events)){+.+.}, at: process_one_work+0x85e/0x1620 kernel/workqueue.c:2241
 #2: ffff8881d4d4d208 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #2: ffff8881d4d4d208 (&dev->mutex){....}, at: hub_event+0x1be/0x43b0 drivers/usb/core/hub.c:5513
 #3: ffff8881d8eb3208 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #3: ffff8881d8eb3208 (&dev->mutex){....}, at: usb_disconnect+0xa3/0x920 drivers/usb/core/hub.c:2202
 #4: ffff8881d8fd0190 (&dev->mutex){....}, at: device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1165
 #5: ffff8881cd365a88 (&dev->mutex){....}, at: device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1165
 #6: ffffffff877ca580 (input_mutex){+.+.}, at: __input_unregister_device+0x118/0x430 drivers/input/input.c:2087
7 locks held by kworker/0:5/3229:
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: __write_once_size include/linux/compiler.h:226 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:855 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: process_one_work+0x82a/0x1620 kernel/workqueue.c:2237
 #1: ffff8881bd47fdd0 ((work_completion)(&usbhid->reset_work)){+.+.}, at: process_one_work+0x85e/0x1620 kernel/workqueue.c:2241
 #2: ffff8881d8fad190 (&dev->mutex){....}, at: device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1165
 #3: ffff8881cd0c1a88 (&dev->mutex){....}, at: device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1165
 #4: ffffffff877ca580 (input_mutex){+.+.}, at: __input_unregister_device+0x118/0x430 drivers/input/input.c:2087
 #5: ffff8881d8fa02a8 (&dev->mutex#2){+.+.}, at: input_close_device+0x42/0x1a0 drivers/input/input.c:673
 #6: ffff8881cd0c1e50 (&hdev->ll_open_lock){+.+.}, at: hid_hw_close+0x1d/0xd0 drivers/hid/hid-core.c:2098
7 locks held by kworker/1:3/3231:
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: __write_once_size include/linux/compiler.h:226 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:855 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: process_one_work+0x82a/0x1620 kernel/workqueue.c:2237
 #1: ffff8881cc797dd0 ((work_completion)(&hub->events)){+.+.}, at: process_one_work+0x85e/0x1620 kernel/workqueue.c:2241
 #2: ffff8881d4da3208 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #2: ffff8881d4da3208 (&dev->mutex){....}, at: hub_event+0x1be/0x43b0 drivers/usb/core/hub.c:5513
 #3: ffff8881d0a6e208 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #3: ffff8881d0a6e208 (&dev->mutex){....}, at: __device_attach+0x7b/0x390 drivers/base/dd.c:874
 #4: ffff8881cffc8190 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #4: ffff8881cffc8190 (&dev->mutex){....}, at: __device_attach+0x7b/0x390 drivers/base/dd.c:874
 #5: ffff8881c81f9a88 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #5: ffff8881c81f9a88 (&dev->mutex){....}, at: __device_attach+0x7b/0x390 drivers/base/dd.c:874
 #6: ffffffff877ca580 (input_mutex){+.+.}, at: input_register_device.cold+0x5c/0x316 drivers/input/input.c:2221
5 locks held by kworker/0:6/3266:
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: __write_once_size include/linux/compiler.h:226 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:855 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: process_one_work+0x82a/0x1620 kernel/workqueue.c:2237
 #1: ffff8881c9ec7dd0 ((work_completion)(&usbhid->reset_work)){+.+.}, at: process_one_work+0x85e/0x1620 kernel/workqueue.c:2241
 #2: ffff8881d8fac190 (&dev->mutex){....}, at: device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1165
 #3: ffff8881be6d1a88 (&dev->mutex){....}, at: device_release_driver_internal+0x23/0x500 drivers/base/dd.c:1165
 #4: ffffffff877ca580 (input_mutex){+.+.}, at: __input_unregister_device+0x118/0x430 drivers/input/input.c:2087
3 locks held by kworker/1:4/3267:
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: __write_once_size include/linux/compiler.h:226 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:855 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff8881da028d28 ((wq_completion)events){+.+.}, at: process_one_work+0x82a/0x1620 kernel/workqueue.c:2237
 #1: ffff8881bd6d7dd0 ((work_completion)(&usbhid->reset_work)){+.+.}, at: process_one_work+0x85e/0x1620 kernel/workqueue.c:2241
 #2: ffff8881d8fd0190 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #2: ffff8881d8fd0190 (&dev->mutex){....}, at: __device_attach+0x7b/0x390 drivers/base/dd.c:874
7 locks held by kworker/1:5/3268:
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: __write_once_size include/linux/compiler.h:226 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: atomic64_set include/asm-generic/atomic-instrumented.h:855 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: atomic_long_set include/asm-generic/atomic-long.h:40 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_data kernel/workqueue.c:615 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: set_work_pool_and_clear_pending kernel/workqueue.c:642 [inline]
 #0: ffff8881d8944128 ((wq_completion)usb_hub_wq){+.+.}, at: process_one_work+0x82a/0x1620 kernel/workqueue.c:2237
 #1: ffff8881bd6ffdd0 ((work_completion)(&hub->events)){+.+.}, at: process_one_work+0x85e/0x1620 kernel/workqueue.c:2241
 #2: ffff8881d4d74208 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #2: ffff8881d4d74208 (&dev->mutex){....}, at: hub_event+0x1be/0x43b0 drivers/usb/core/hub.c:5513
 #3: ffff8881d9302208 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #3: ffff8881d9302208 (&dev->mutex){....}, at: __device_attach+0x7b/0x390 drivers/base/dd.c:874
 #4: ffff8881d9306190 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #4: ffff8881d9306190 (&dev->mutex){....}, at: __device_attach+0x7b/0x390 drivers/base/dd.c:874
 #5: ffff8881c9679a88 (&dev->mutex){....}, at: device_lock include/linux/device.h:771 [inline]
 #5: ffff8881c9679a88 (&dev->mutex){....}, at: __device_attach+0x7b/0x390 drivers/base/dd.c:874
 #6: ffffffff877ca580 (input_mutex){+.+.}, at: input_register_device.cold+0x5c/0x316 drivers/input/input.c:2221

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 23 Comm: khungtaskd Not tainted 5.6.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xef/0x16e lib/dump_stack.c:118
 nmi_cpu_backtrace.cold+0x70/0xb1 lib/nmi_backtrace.c:101
 nmi_trigger_cpumask_backtrace+0x1db/0x207 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:205 [inline]
 watchdog+0xa99/0xfd0 kernel/hung_task.c:289
 kthread+0x318/0x420 kernel/kthread.c:255
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:60 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:103 [inline]
NMI backtrace for cpu 1 skipped: idling at default_idle+0x28/0x300 arch/x86/kernel/process.c:695


Tested on:

commit:         0fa84af8 Merge tag 'usb-serial-5.7-rc1' of https://git.ker..
git tree:       https://github.com/google/kasan.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13af50b0100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6b9c154b0c23aecf
dashboard link: https://syzkaller.appspot.com/bug?extid=db339689b2101f6f6071
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e551cfe00000

