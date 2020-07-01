Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4E3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370FA20722
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgGAKlC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:41:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:34696 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729180AbgGAKlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:41:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4AD9EAD04;
        Wed,  1 Jul 2020 10:40:59 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com, robh+dt@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sachin.ghadi@sifive.com,
        aou@eecs.berkeley.edu, anup@brainfault.org, lollivier@baylibre.com,
        green.wan@sifive.com, atish.patra@wdc.com,
        alistair.francis@wdc.com, deepa.kernel@gmail.com,
        bmeng.cn@gmail.com
Subject: Re: [PATCH 0/3] Dynamic CPU frequency switching for the HiFive
References: <1592308864-30205-1-git-send-email-yash.shah@sifive.com>
X-Yow:  ..  over in west Philadelphia a puppy is vomiting..
Date:   Wed, 01 Jul 2020 12:40:58 +0200
In-Reply-To: <1592308864-30205-1-git-send-email-yash.shah@sifive.com> (Yash
        Shah's message of "Tue, 16 Jun 2020 17:31:01 +0530")
Message-ID: <mvmftabiklh.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.0.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 16 2020, Yash Shah wrote:

> The patch series adds the support for dynamic CPU frequency switching
> for FU540-C000 SoC on the HiFive Unleashed board. All the patches are
> based on Paul Walmsley's work.
>
> This series is based on Linux v5.7 and tested on HiFive unleashed board.

I'm using that patch with 5.7.5.

It appears to interfer with serial output when using the ondemand
governor.

I also see soft lockups when using the performance governor:

[  101.587527] rcu: INFO: rcu_sched self-detected stall on CPU
[  101.592322] rcu:     0-...!: (932 ticks this GP) idle=11a/1/0x4000000000000004 softirq=4301/4301 fqs=4
[  101.601432]  (t=6001 jiffies g=4017 q=859)
[  101.605514] rcu: rcu_sched kthread starved for 5984 jiffies! g4017 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=2
[  101.615494] rcu: RCU grace-period kthread stack dump:
[  101.620530] rcu_sched       R  running task        0    10      2 0x00000000
[  101.627560] Call Trace:
[  101.630004] [<ffffffe00085a7e2>] __schedule+0x25c/0x616
[  101.635205] [<ffffffe00085abde>] schedule+0x42/0xb2
[  101.640070] [<ffffffe00085d0ba>] schedule_timeout+0x56/0xb8
[  101.645626] [<ffffffe000263c34>] rcu_gp_fqs_loop+0x208/0x248
[  101.651266] [<ffffffe0002666de>] rcu_gp_kthread+0xc2/0xcc
[  101.656651] [<ffffffe00022654e>] kthread+0xda/0xec
[  101.661426] [<ffffffe00020140a>] ret_from_exception+0x0/0xc
[  101.666977] Task dump for CPU 0:
[  101.670187] loop0           R  running task        0   655      2 0x00000008
[  101.677218] Call Trace:
[  101.679657] [<ffffffe0002028ae>] walk_stackframe+0x0/0xaa
[  101.685036] [<ffffffe000202b76>] show_stack+0x2a/0x34
[  101.690074] [<ffffffe0002319b0>] sched_show_task.part.0+0xc2/0xd2
[  101.696154] [<ffffffe00022bb9c>] sched_show_task+0x64/0x66
[  101.701618] [<ffffffe000231afe>] dump_cpu_task+0x3e/0x48
[  101.706916] [<ffffffe000267762>] rcu_dump_cpu_stacks+0x94/0xce
[  101.712731] [<ffffffe0002631f6>] print_cpu_stall+0x116/0x18a
[  101.718375] [<ffffffe000264a46>] check_cpu_stall+0xcc/0x1a2
[  101.723929] [<ffffffe000264b52>] rcu_pending.constprop.0+0x36/0xaa
[  101.730094] [<ffffffe000266ab2>] rcu_sched_clock_irq+0xa6/0xea
[  101.735913] [<ffffffe00026d1be>] update_process_times+0x1e/0x42
[  101.741821] [<ffffffe0002793bc>] tick_sched_handle+0x26/0x52
[  101.747456] [<ffffffe0002798fe>] tick_sched_timer+0x6a/0xd0
[  101.753015] [<ffffffe00026d9be>] __run_hrtimer.constprop.0+0x50/0xe8
[  101.759353] [<ffffffe00026da9e>] __hrtimer_run_queues+0x48/0x6c
[  101.765254] [<ffffffe00026e410>] hrtimer_interrupt+0xca/0x1d4
[  101.770985] [<ffffffe0006ceef8>] riscv_timer_interrupt+0x32/0x3a
[  101.776976] [<ffffffe00085e17c>] do_IRQ+0xa4/0xb8
[  101.781663] [<ffffffe00020140a>] ret_from_exception+0x0/0xc

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
