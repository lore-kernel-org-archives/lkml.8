Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC154C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:31:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2ECC20733
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgC3LbE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:31:04 -0400
Received: from foss.arm.com ([217.140.110.172]:50968 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729237AbgC3LbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:31:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E334131B;
        Mon, 30 Mar 2020 04:31:02 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 941893F52E;
        Mon, 30 Mar 2020 04:31:01 -0700 (PDT)
References: <20200122151617.531-2-ggherdovich@suse.cz> <158029757853.396.10568128383380430250.tip-bot2@tip-bot2> <158556634294.3228.4889951961483021094@build.alporthouse.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-tip-commits@vger.kernel.org,
        tip-bot2 for Giovanni Gherdovich <tip-bot2@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Ingo Molnar <mingo@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [tip: sched/core] x86, sched: Add support for frequency invariance
Message-ID: <jhjlfni13ms.mognet@arm.com>
In-reply-to: <158556634294.3228.4889951961483021094@build.alporthouse.com>
Date:   Mon, 30 Mar 2020 12:30:56 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Mar 30 2020, Chris Wilson wrote:
> <6> [184.949219] [IGT] perf_pmu: starting subtest cpu-hotplug
> <4> [185.092279] IRQ 24: no longer affine to CPU0
> <4> [185.092285] IRQ 25: no longer affine to CPU0
> <6> [185.093709] smpboot: CPU 0 is now offline
> <6> [186.107062] smpboot: Booting Node 0 Processor 0 APIC 0x0
> <3> [186.107643] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:49
> <3> [186.107648] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/0
> <4> [186.107650] no locks held by swapper/0/0.
> <4> [186.107652] irq event stamp: 6424624
> <4> [186.107658] hardirqs last  enabled at (6424623): [<ffffffff951744bf>] tick_nohz_idle_enter+0x5f/0x90
> <4> [186.107664] hardirqs last disabled at (6424624): [<ffffffff950fa1e2>] do_idle+0x82/0x260
> <4> [186.107669] softirqs last  enabled at (6424590): [<ffffffff95e00395>] __do_softirq+0x395/0x49e
> <4> [186.107674] softirqs last disabled at (6424571): [<ffffffff950c195a>] irq_exit+0xba/0xc0
> <3> [186.107677] Preemption disabled at:
> <4> [186.107681] [<ffffffff9504843b>] start_secondary+0x4b/0x1b0
> <4> [186.107685] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U            5.6.0-rc7-next-20200327-g975f7a88c64d-next-20200327 #1
> <4> [186.107687] Hardware name: MSI MS-7924/Z97M-G43(MS-7924), BIOS V1.12 02/15/2016
> <4> [186.107688] Call Trace:
> <4> [186.107695]  dump_stack+0x71/0x9b
> <4> [186.107702]  ___might_sleep+0x178/0x260
> <4> [186.107708]  cpus_read_lock+0x13/0xd0
> <4> [186.107713]  static_key_enable+0x9/0x20
> <4> [186.107717]  init_freq_invariance+0x1f0/0x3a0
> <4> [186.107724]  start_secondary+0x71/0x1b0
> <4> [186.107729]  secondary_startup_64+0xb6/0xc0
> <3> [186.107756] BUG: scheduling while atomic: swapper/0/0/0x00000002
> <4> [186.107763] 1 lock held by swapper/0/0:
> <4> [186.107767]  #0: ffffffff9643e510 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0x9/0x20
> <4> [186.107775] Modules linked in: vgem snd_hda_codec_hdmi mei_hdcp i915 x86_pkg_temp_thermal coretemp snd_hda_codec_realtek snd_hda_codec_generic crct10dif_pclmul snd_hda_intel crc32_pclmul snd_intel_dspcfg ghash_clmulni_intel snd_hda_codec snd_hwdep snd_hda_core r8169 lpc_ich snd_pcm mei_me mei realtek prime_numbers
> <3> [186.107797] Preemption disabled at:
> <4> [186.107800] [<ffffffff9504843b>] start_secondary+0x4b/0x1b0
> <4> [186.107803] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U  W         5.6.0-rc7-next-20200327-g975f7a88c64d-next-20200327 #1
> <4> [186.107805] Hardware name: MSI MS-7924/Z97M-G43(MS-7924), BIOS V1.12 02/15/2016
> <4> [186.107807] Call Trace:
> <4> [186.107811]  dump_stack+0x71/0x9b
> <4> [186.107815]  ? start_secondary+0x4b/0x1b0
> <4> [186.107819]  __schedule_bug+0x7b/0xd0
> <4> [186.107825]  __schedule+0x776/0x810
> <4> [186.107832]  ? mark_held_locks+0x49/0x70
> <4> [186.107839]  schedule+0x37/0xe0
> <4> [186.107843]  ? percpu_rwsem_wait+0x117/0x180
> <4> [186.107846]  percpu_rwsem_wait+0x117/0x180
> <4> [186.107851]  ? percpu_down_write+0x140/0x140
> <4> [186.107859]  __percpu_down_read+0x43/0x60
> <4> [186.107864]  cpus_read_lock+0xc6/0xd0
> <4> [186.107867]  static_key_enable+0x9/0x20
> <4> [186.107871]  init_freq_invariance+0x1f0/0x3a0
> <4> [186.107878]  start_secondary+0x71/0x1b0
> <4> [186.107883]  secondary_startup_64+0xb6/0xc0
>
> repeating ad nauseam, e.g.
> https://intel-gfx-ci.01.org/tree/linux-next/next-20200327/shard-hsw4/dmesg9.txt
>
> Across all our test boxen.
> -Chris

AFAICT this should be valid (I'm afraid I can't easily test it,
however); init doesn't take the hp lock (doesn't need it) and post-boot
hotplug will call this via the hotplug state machine with the right lock
held.

---
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 467191e51196..7651b06a1036 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -2014,7 +2014,7 @@ static void init_freq_invariance(void)
 
 	if (ret) {
 		on_each_cpu(init_counter_refs, NULL, 1);
-		static_branch_enable(&arch_scale_freq_key);
+		static_branch_enable_cpuslocked(&arch_scale_freq_key);
 	} else {
 		pr_debug("Couldn't determine max cpu frequency, necessary for scale-invariant accounting.\n");
 	}

