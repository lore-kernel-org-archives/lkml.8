Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20021C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10602077D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgCWOjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 10:39:02 -0400
Received: from foss.arm.com ([217.140.110.172]:50276 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbgCWOjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 10:39:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7EB81FB;
        Mon, 23 Mar 2020 07:39:00 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F8613F52E;
        Mon, 23 Mar 2020 07:39:00 -0700 (PDT)
Date:   Mon, 23 Mar 2020 14:38:58 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: lockdep warning in urb.c:363 usb_submit_urb
Message-ID: <20200323143857.db5zphxhq4hz3hmd@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've hit the following lockdep warning when I trigger hibernate on arm64
platform (Juno-r2)


	echo suspend > /sys/power/disk
	echo disk > /sys/power/state

I only had a usb flash drive attached to it. Let me know if you need more info.



# echo suspend > disk
# echo disk > state
[  325.775152] PM: hibernation: hibernation entry
[  325.780708] Filesystems sync: 0.000 seconds
[  325.784976] Freezing user space processes ... (elapsed 0.001 seconds) done.
[  325.793322] OOM killer disabled.
[  325.797934] PM: hibernation: Preallocating image memory
[  326.852851] PM: hibernation: Allocated 96124 pages for snapshot
[  326.858826] PM: hibernation: Allocated 384496 kbytes in 1.04 seconds (369.70 MB/s)
[  326.866447] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  326.876429] printk: Suspending console(s) (use no_console_suspend to debug)
[  326.947751] Disabling non-boot CPUs ...
[  326.948909] CPU1: shutdown
[  326.948918] psci: CPU1 killed (polled 0 ms)
[  326.951082] CPU2: shutdown
[  326.952130] psci: CPU2 killed (polled 0 ms)
[  326.954600] CPU3: shutdown
[  326.954613] psci: CPU3 killed (polled 0 ms)
[  326.957217] CPU4: shutdown
[  326.957229] psci: CPU4 killed (polled 0 ms)
[  326.958924] CPU5: shutdown
[  326.958936] psci: CPU5 killed (polled 0 ms)
[  326.959878] PM: hibernation: Creating image:
[  326.959878] PM: hibernation: Need to copy 94789 pages
[  326.959878] PM: hibernation: Image created (94789 pages copied)
[  326.959994] Enabling non-boot CPUs ...
[  326.973678] Detected PIPT I-cache on CPU1
[  326.973728] CPU1: Booted secondary processor 0x0000000000 [0x410fd080]
[  326.975172] CPU1 is up
[  326.993051] Detected PIPT I-cache on CPU2
[  326.993081] CPU2: Booted secondary processor 0x0000000001 [0x410fd080]
[  326.993839] CPU2 is up
[  327.007492] Detected VIPT I-cache on CPU3
[  327.007557] CPU3: Booted secondary processor 0x0000000101 [0x410fd033]
[  327.009075] CPU3 is up
[  327.022636] Detected VIPT I-cache on CPU4
[  327.022682] CPU4: Booted secondary processor 0x0000000102 [0x410fd033]
[  327.024296] CPU4 is up
[  327.038227] Detected VIPT I-cache on CPU5
[  327.038272] CPU5: Booted secondary processor 0x0000000103 [0x410fd033]
[  327.039921] CPU5 is up
[  327.154849] usb usb2: runtime PM trying to activate child device usb2 but parent (7ffb0000.ohci) is not active
[  327.290355] PM: Cannot find swap device, try swapon -a
[  327.295533] PM: Cannot get swap writer
[  327.480758] OOM killer enabled.
[  327.483939] Restarting tasks ...
[  327.484229] ------------[ cut here ]------------
[  327.484664] done.
[  327.487743] URB 000000000c121c1c submitted while active
[  327.499622] WARNING: CPU: 1 PID: 296 at drivers/usb/core/urb.c:363 usb_submit_urb+0x3f0/0x520
[  327.508191] Modules linked in:
[  327.511262] CPU: 1 PID: 296 Comm: kworker/1:2 Not tainted 5.6.0-rc6 #533
[  327.517993] Hardware name: ARM Juno development board (r2) (DT)
[  327.523944] Workqueue: usb_hub_wq hub_event
[  327.528148] pstate: 40000005 (nZcv daif -PAN -UAO)
[  327.532959] pc : usb_submit_urb+0x3f0/0x520
[  327.537160] lr : usb_submit_urb+0x3f0/0x520
[  327.541360] sp : ffff80001891b8c0
[  327.544687] x29: ffff80001891b8c0 x28: ffff000973f7a000
[  327.550024] x27: ffff00097049f320 x26: 0000000000000003
[  327.555361] x25: ffff8000101704e8 x24: ffff80001891bb48
[  327.560697] x23: ffff80001323d000 x22: 0000000000000c00
[  327.566033] x21: 0000000000000004 x20: 00000000fffffff0
[  327.571369] x19: ffff0009703f0300 x18: 0000000000000000
[  327.576705] x17: 0000000000000000 x16: 0000000000000000
[  327.582041] x15: 0000000000000000 x14: 0000000000000000
[  327.587376] x13: 0000000000000000 x12: 0000000000000000
[  327.592712] x11: 0000000000000000 x10: 0000000000000000
[  327.598048] x9 : ffff80001323da88 x8 : ffff00097ef0a798
[  327.603384] x7 : ffff800010148c08 x6 : ffff00097eef7450
[  327.608720] x5 : ffff00097eef7450 x4 : 0000000000000000
[  327.614055] x3 : ffff00097ef06df0 x2 : 0000000000000001
[  327.619391] x1 : 1798c844b4d7c300 x0 : 0000000000000000
[  327.624727] Call trace:
[  327.627183]  usb_submit_urb+0x3f0/0x520
[  327.631035]  hub_activate+0x108/0x788
[  327.634713]  hub_resume+0x40/0x108
[  327.638129]  usb_resume_interface.isra.9+0x60/0x108
[  327.643028]  usb_resume_both+0xe4/0x140
[  327.646881]  usb_runtime_resume+0x24/0x30
[  327.650910]  __rpm_callback+0xdc/0x138
[  327.654675]  rpm_callback+0x34/0x98
[  327.658178]  rpm_resume+0x4a8/0x720
[  327.661681]  rpm_resume+0x50c/0x720
[  327.665183]  __pm_runtime_resume+0x4c/0xb8
[  327.669297]  usb_autopm_get_interface+0x28/0x60
[  327.673848]  hub_event+0x80/0x1368
[  327.677266]  process_one_work+0x2a4/0x748
[  327.681292]  worker_thread+0x48/0x498
[  327.684970]  kthread+0x13c/0x140
[  327.688211]  ret_from_fork+0x10/0x18
[  327.691801] irq event stamp: 17114
[  327.695219] hardirqs last  enabled at (17113): [<ffff80001191b29c>] _raw_spin_unlock_irq+0x34/0x68
[  327.704224] hardirqs last disabled at (17114): [<ffff8000119132d8>] __schedule+0xd0/0x7e8
[  327.712442] softirqs last  enabled at (16742): [<ffff8000100818a4>] __do_softirq+0x4bc/0x568
[  327.720922] softirqs last disabled at (16731): [<ffff800010114064>] irq_exit+0x144/0x150
[  327.729051] ---[ end trace 7d41436f96488c51 ]---
[  327.733762] PM: hibernation: hibernation exit
sh: write error: No such device
# [  327.739972] hub 2-0:1.0: activate --> -16



Thanks

--
Qais Yousef
