Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69747C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E42F20760
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 23:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726290AbgGBXY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 19:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgGBXY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 19:24:57 -0400
Received: from scorn.kernelslacker.org (scorn.kernelslacker.org [IPv6:2600:3c03:e000:2fb::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4930BC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 16:24:57 -0700 (PDT)
Received: from [2601:196:4600:6634:ae9e:17ff:feb7:72ca] (helo=wopr.kernelslacker.org)
        by scorn.kernelslacker.org with esmtp (Exim 4.92)
        (envelope-from <davej@codemonkey.org.uk>)
        id 1jr8ZY-0005Ew-BJ; Thu, 02 Jul 2020 19:24:52 -0400
Received: by wopr.kernelslacker.org (Postfix, from userid 1026)
        id D175656011F; Thu,  2 Jul 2020 19:24:51 -0400 (EDT)
Date:   Thu, 2 Jul 2020 19:24:51 -0400
From:   Dave Jones <davej@codemonkey.org.uk>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        mingo@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: weird loadavg on idle machine post 5.7
Message-ID: <20200702232451.GA3972@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>, peterz@infradead.org,
        mingo@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
References: <20200702171548.GA11813@codemonkey.org.uk>
 <20200702213627.GF3183@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702213627.GF3183@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 10:36:27PM +0100, Mel Gorman wrote:
 
 > I'm thinking that the !!task_contributes_to_load(p) should still happen
 > after smp_cond_load_acquire() when on_cpu is stable and the pi_lock is
 > held to stabilised p->state against a parallel wakeup or updating the
 > task rq. I do not see any hazards with respect to smp_rmb and the value
 > of p->state in this particular path but I've confused myself enough in
 > the various scheduler and wakeup paths that I don't want to bet money on
 > it late in the evening
 > 
 > It builds, not booted, it's for discussion but maybe Dave is feeling brave!

stalls, and then panics during boot :(


[   16.933212] igb 0000:02:00.0 eth1: igb: eth1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   69.572840] watchdog: BUG: soft lockup - CPU#3 stuck for 44s! [kworker/u8:0:7]
[   69.572849] CPU: 3 PID: 7 Comm: kworker/u8:0 Kdump: loaded Not tainted 5.8.0-rc3-firewall+ #2
[   69.572852] Hardware name: To be filled by O.E.M. To be filled by O.E.M./Q3XXG4-P, BIOS 5.6.5 06/30/2018
[   69.572861] Workqueue:  0x0 (events_power_efficient)
[   69.572877] RIP: 0010:finish_task_switch+0x71/0x1a0
[   69.572884] Code: 00 00 4d 8b 7c 24 10 65 4c 8b 34 25 c0 6c 01 00 0f 1f 44 00 00 0f 1f 44 00 00 41 c7 44 24 2c 00 00 00 00 c6 03 00 fb 4d 85 ed <74> 0b f0 41 ff 4d 4c 0f 84 d9 00 00 00 49 83 c7 80 74 7a 48 89 d8
[   69.572887] RSP: 0018:ffffb36700067e40 EFLAGS: 00000246
[   69.572893] RAX: ffff94654eab0000 RBX: ffff9465575a8b40 RCX: 0000000000000000
[   69.572895] RDX: 0000000000000000 RSI: ffff9465565c0000 RDI: ffff94654eab0000
[   69.572898] RBP: ffffb36700067e68 R08: 0000000000000001 R09: 00000000000283c0
[   69.572901] R10: 0000000000000000 R11: 0000000000000000 R12: ffff94654eab0000
[   69.572904] R13: 0000000000000000 R14: ffff9465565c0000 R15: 0000000000000001
[   69.572909] FS:  0000000000000000(0000) GS:ffff946557580000(0000) knlGS:0000000000000000
[   69.572912] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   69.572917] CR2: 00007f29b26abc30 CR3: 000000020812d001 CR4: 00000000001606e0
[   69.572919] Call Trace:
[   69.572937]  __schedule+0x28d/0x570
[   69.572946]  ? _cond_resched+0x15/0x30
[   69.572954]  schedule+0x38/0xa0
[   69.572962]  worker_thread+0xaa/0x3c0
[   69.572968]  ? process_one_work+0x3c0/0x3c0
[   69.572972]  kthread+0x116/0x130
[   69.572977]  ? __kthread_create_on_node+0x180/0x180
[   69.572982]  ret_from_fork+0x22/0x30
[   69.572988] Kernel panic - not syncing: softlockup: hung tasks
[   69.572993] CPU: 3 PID: 7 Comm: kworker/u8:0 Kdump: loaded Tainted: G             L    5.8.0-rc3-firewall+ #2
[   69.572995] Hardware name: To be filled by O.E.M. To be filled by O.E.M./Q3XXG4-P, BIOS 5.6.5 06/30/2018
[   69.572998] Workqueue:  0x0 (events_power_efficient)
[   69.573001] Call Trace:
[   69.573004]  <IRQ>
[   69.573010]  dump_stack+0x57/0x70
[   69.573016]  panic+0xfb/0x2cb
[   69.573024]  watchdog_timer_fn.cold.12+0x7d/0x96
[   69.573030]  ? softlockup_fn+0x30/0x30
[   69.573035]  __hrtimer_run_queues+0x100/0x280
[   69.573041]  hrtimer_interrupt+0xf4/0x210
[   69.573049]  __sysvec_apic_timer_interrupt+0x5d/0xf0
[   69.573055]  asm_call_on_stack+0x12/0x20
[   69.573058]  </IRQ>
[   69.573064]  sysvec_apic_timer_interrupt+0x6d/0x80
[   69.573069]  asm_sysvec_apic_timer_interrupt+0xf/0x20
[   69.573078] RIP: 0010:finish_task_switch+0x71/0x1a0
[   69.573082] Code: 00 00 4d 8b 7c 24 10 65 4c 8b 34 25 c0 6c 01 00 0f 1f 44 00 00 0f 1f 44 00 00 41 c7 44 24 2c 00 00 00 00 c6 03 00 fb 4d 85 ed <74> 0b f0 41 ff 4d 4c 0f 84 d9 00 00 00 49 83 c7 80 74 7a 48 89 d8
[   69.573085] RSP: 0018:ffffb36700067e40 EFLAGS: 00000246
[   69.573088] RAX: ffff94654eab0000 RBX: ffff9465575a8b40 RCX: 0000000000000000
[   69.573090] RDX: 0000000000000000 RSI: ffff9465565c0000 RDI: ffff94654eab0000
[   69.573092] RBP: ffffb36700067e68 R08: 0000000000000001 R09: 00000000000283c0
[   69.573094] R10: 0000000000000000 R11: 0000000000000000 R12: ffff94654eab0000
[   69.573096] R13: 0000000000000000 R14: ffff9465565c0000 R15: 0000000000000001
[   69.573106]  __schedule+0x28d/0x570
[   69.573113]  ? _cond_resched+0x15/0x30
[   69.573119]  schedule+0x38/0xa0
[   69.573125]  worker_thread+0xaa/0x3c0
[   69.573130]  ? process_one_work+0x3c0/0x3c0
[   69.573134]  kthread+0x116/0x130
[   69.573149]  ? __kthread_create_on_node+0x180/0x180
[   69.792344]  ret_from_fork+0x22/0x30


