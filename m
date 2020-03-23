Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3467EC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E5B20409
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:43:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgCWPnO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:43:14 -0400
Received: from foss.arm.com ([217.140.110.172]:51274 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727209AbgCWPnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:43:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E485F1FB;
        Mon, 23 Mar 2020 08:43:12 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3FFD53F7C3;
        Mon, 23 Mar 2020 08:43:12 -0700 (PDT)
Date:   Mon, 23 Mar 2020 15:43:09 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Hit WARN_ON() in rcutorture.c:1055
Message-ID: <20200323154309.nah44so2556ee56g@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I hit the following warning while running rcutorture tests. It only happens
when I try to hibernate the system (arm64 Juno-r2).

Let me know if you need additional info.


# echo suspend > /sys/power/disk
# [  299.688526] rcu_torture_fwd_prog_nr: Duration 2913 cver 183 gps 285
e[  300.176051] rcu_torture_fwd_prog_cr Duration 39 barrier: 29 pending 9295 n_launders: 21213 n_launders_sa: 8224 n_max_gps: 100 n_max_cbs: 12823 cver 4 gps 10
[  300.190434] rcu_torture_fwd_cb_hist: Callback-invocation histogram (duration 72 jiffies): 1s/10: 11381:6 2s/10: 21139:7 3s/10: 1516:1
# echo disk > /sys/power/state
[  304.592943] PM: hibernation: hibernation entry
[  304.612969] Filesystems sync: 0.003 seconds
[  304.617616] Freezing user space processes ... (elapsed 0.004 seconds) done.
[  304.629712] OOM killer disabled.
[  304.642462] PM: hibernation: Preallocating image memory
[  305.988263] PM: hibernation: Allocated 96990 pages for snapshot
[  305.994311] PM: hibernation: Allocated 387960 kbytes in 1.33 seconds (291.69 MB/s)
[  306.002022] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  306.013873] printk: Suspending console(s) (use no_console_suspend to debug)
[  306.079141] Disabling non-boot CPUs ...
[  306.082829] CPU1: shutdown
[  306.082947] psci: CPU1 killed (polled 0 ms)
[  306.090930] CPU2: shutdown
[  306.092095] psci: CPU2 killed (polled 0 ms)
[  306.101501] CPU3: shutdown
[  306.101551] psci: CPU3 killed (polled 0 ms)
[  306.112128] CPU4: shutdown
[  306.112177] psci: CPU4 killed (polled 0 ms)
[  306.130425] CPU5: shutdown
[  306.130477] psci: CPU5 killed (polled 0 ms)
[  306.135659] PM: hibernation: Creating image:
[  306.135659] PM: hibernation: Need to copy 95345 pages
[  306.135659] PM: hibernation: Image created (95345 pages copied)
[  306.138145] Enabling non-boot CPUs ...
[  306.152537] Detected PIPT I-cache on CPU1
[  306.152605] CPU1: Booted secondary processor 0x0000000000 [0x410fd080]
[  306.156520] CPU1 is up
[  306.170179] Detected PIPT I-cache on CPU2
[  306.170217] CPU2: Booted secondary processor 0x0000000001 [0x410fd080]
[  306.171592] CPU2 is up
[  306.185303] Detected VIPT I-cache on CPU3
[  306.185454] CPU3: Booted secondary processor 0x0000000101 [0x410fd033]
[  306.191492] CPU3 is up
[  306.205183] Detected VIPT I-cache on CPU4
[  306.205314] CPU4: Booted secondary processor 0x0000000102 [0x410fd033]
[  306.212156] CPU4 is up
[  306.226312] Detected VIPT I-cache on CPU5
[  306.226440] CPU5: Booted secondary processor 0x0000000103 [0x410fd033]
[  306.235222] CPU5 is up
[  306.392553] usb usb2: runtime PM trying to activate child device usb2 but parent (7ffb0000.ohci) is not active
[  306.552039] hibernate: Hibernating on CPU 0 [mpidr:0x100]
[  306.643894] PM: Using 3 thread(s) for compression
[  306.648700] PM: Compressing and saving image data (95532 pages)...
[  306.655007] PM: Image saving progress:   0%
[  308.347979] ata2: SATA link down (SStatus 0 SControl 0)
[  308.353489] ata1: SATA link down (SStatus 0 SControl 0)
[  311.608370] ------------[ cut here ]------------
[  311.613127] WARNING: CPU: 3 PID: 261 at kernel/rcu/rcutorture.c:1055 rcu_torture_writer+0x664/0xa90
[  311.622360] Modules linked in:
[  311.625495] CPU: 3 PID: 261 Comm: rcu_torture_wri Not tainted 5.6.0-rc6 #535
[  311.632690] Hardware name: ARM Juno development board (r2) (DT)
[  311.638737] pstate: 00000005 (nzcv daif -PAN -UAO)
[  311.643634] pc : rcu_torture_writer+0x664/0xa90
[  311.648266] lr : rcu_torture_writer+0x65c/0xa90
[  311.652896] sp : ffff800018a1bde0
[  311.656287] x29: ffff800018a1bde0 x28: ffff800014048140
[  311.661717] x27: 000000000000c134 x26: ffff800014046f08
[  311.667149] x25: ffff8000120ff000 x24: 0000000000000001
[  311.672581] x23: ffff800014046f08 x22: ffff800014045000
[  311.678012] x21: ffff800013279000 x20: ffff800014048938
[  311.683444] x19: ffff800014046000 x18: 00000000fffffffd
[  311.688875] x17: 000000001824429d x16: ffff800014554170
[  311.694306] x15: 00000000fffffffe x14: 003d090000000000
[  311.699737] x13: 00003d0900000000 x12: 0000000000000003
[  311.705169] x11: 0000000000000c02 x10: 0000000000000000
[  311.710599] x9 : ffff8000137ed0a0 x8 : ffff0009757c8850
[  311.716030] x7 : 0000000000000000 x6 : ffff800018a1bcc0
[  311.721461] x5 : 0000000000000001 x4 : 0000000000000000
[  311.726891] x3 : 0000000000000080 x2 : 0000000002611501
[  311.732322] x1 : 0000000000000000 x0 : 0000000000000001
[  311.737754] Call trace:
[  311.740263]  rcu_torture_writer+0x664/0xa90
[  311.744544]  kthread+0x13c/0x140
[  311.747852]  ret_from_fork+0x10/0x18
[  311.751510] irq event stamp: 228320
[  311.755086] hardirqs last  enabled at (228319): [<ffff800010113dc0>] __local_bh_enable_ip+0x98/0x148
[  311.764414] hardirqs last disabled at (228320): [<ffff8000100a9300>] do_debug_exception+0x1a8/0x258
[  311.773652] softirqs last  enabled at (228318): [<ffff8000101b95fc>] rcu_torture_free+0x84/0x98
[  311.782537] softirqs last disabled at (228316): [<ffff8000101b95d8>] rcu_torture_free+0x60/0x98
[  311.791417] ---[ end trace dab722c9424166a2 ]---
[  311.998802] PM: Image saving progress:  10%
[  312.211076] PM: Image saving progress:  20%
[  312.311430] PM: Image saving progress:  30%
[  312.949974] psmouse serio0: Failed to enable mouse on 1c060000.kmi
[  313.351906] rcu-torture: rtc: 00000000e3ff6cce ver: 6966 tfle: 0 rta: 6967 rtaf: 0 rtf: 6957 rtmbe: 0 rtbe: 0 rtbke: 0 rtbre: 0 rtbf: 0 rtb: 0 nt: 123307 onoff: 0/0:0/0 -1,0:-1,0 0:0 (HZ=250) barrier: 0/
0:0
[  313.370772] rcu-torture: Reader Pipe:  75577741 19694 0 0 0 0 0 0 0 0 0
[  313.377628] rcu-torture: Reader Batch:  75556519 40915 0 0 0 0 0 0 0 0 0
[  313.384570] rcu-torture: Free-Block Circulation:  6966 6965 6964 6963 6962 6961 6960 6959 6958 6957 0
[  315.017220] PM: Image saving progress:  40%
[  319.595899] psmouse serio1: Failed to enable mouse on 1c070000.kmi
[  321.033476] PM: Image saving progress:  50%
[  325.241344] PM: Image saving progress:  60%
[  325.692738] PM: Image saving progress:  70%
[  329.862793] PM: Image saving progress:  80%
[  333.941109] PM: Image saving progress:  90%
[  334.429067] PM: Image saving progress: 100%
[  334.442732] PM: Image saving done
[  334.446290] PM: hibernation: Wrote 382128 kbytes in 27.78 seconds (13.75 MB/s)
[  334.458377] PM: S|
[  334.747355] printk: Suspending console(s) (use no_console_suspend to debug)


Thanks

--
Qais Yousef
