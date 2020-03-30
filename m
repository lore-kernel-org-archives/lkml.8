Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EC0C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A5320675
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 11:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729798AbgC3LGE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 07:06:04 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:56311 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729448AbgC3LGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:06:03 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20738601-1500050 
        for multiple; Mon, 30 Mar 2020 12:05:44 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <158029757853.396.10568128383380430250.tip-bot2@tip-bot2>
References: <20200122151617.531-2-ggherdovich@suse.cz> <158029757853.396.10568128383380430250.tip-bot2@tip-bot2>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Ingo Molnar <mingo@kernel.org>,
        Doug Smythies <dsmythies@telus.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
To:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Giovanni Gherdovich <tip-bot2@linutronix.de>
Subject: Re: [tip: sched/core] x86, sched: Add support for frequency invariance
From:   Chris Wilson <chris@chris-wilson.co.uk>
Message-ID: <158556634294.3228.4889951961483021094@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Mon, 30 Mar 2020 12:05:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting tip-bot2 for Giovanni Gherdovich (2020-01-29 11:32:58)
> The following commit has been merged into the sched/core branch of tip:
> 
> Commit-ID:     1567c3e3467cddeb019a7b53ec632f834b6a9239
> Gitweb:        https://git.kernel.org/tip/1567c3e3467cddeb019a7b53ec632f834b6a9239
> Author:        Giovanni Gherdovich <ggherdovich@suse.cz>
> AuthorDate:    Wed, 22 Jan 2020 16:16:12 +01:00
> Committer:     Ingo Molnar <mingo@kernel.org>
> CommitterDate: Tue, 28 Jan 2020 21:36:59 +01:00
> 
> x86, sched: Add support for frequency invariance
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 69881b2..28696bc 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -147,6 +147,8 @@ static inline void smpboot_restore_warm_reset_vector(void)
>         *((volatile u32 *)phys_to_virt(TRAMPOLINE_PHYS_LOW)) = 0;
>  }
>  
> +static void init_freq_invariance(void);
> +
>  /*
>   * Report back to the Boot Processor during boot time or to the caller processor
>   * during CPU online.
> @@ -183,6 +185,8 @@ static void smp_callin(void)
>          */
>         set_cpu_sibling_map(raw_smp_processor_id());
>  
> +       init_freq_invariance();
> +
>         /*
>          * Get our bogomips.
>          * Update loops_per_jiffy in cpu_data. Previous call to
> @@ -1337,7 +1341,7 @@ void __init native_smp_prepare_cpus(unsigned int max_cpus)
>         set_sched_topology(x86_topology);
>  
>         set_cpu_sibling_map(0);
> -
> +       init_freq_invariance();
>         smp_sanity_check();
>  
>         switch (apic_intr_mode) {

Since this has become visible via linux-next [20200326?], we have been
deluged by oops during cpu-hotplug.

<6> [184.949219] [IGT] perf_pmu: starting subtest cpu-hotplug
<4> [185.092279] IRQ 24: no longer affine to CPU0
<4> [185.092285] IRQ 25: no longer affine to CPU0
<6> [185.093709] smpboot: CPU 0 is now offline
<6> [186.107062] smpboot: Booting Node 0 Processor 0 APIC 0x0
<3> [186.107643] BUG: sleeping function called from invalid context at ./include/linux/percpu-rwsem.h:49
<3> [186.107648] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 0, name: swapper/0
<4> [186.107650] no locks held by swapper/0/0.
<4> [186.107652] irq event stamp: 6424624
<4> [186.107658] hardirqs last  enabled at (6424623): [<ffffffff951744bf>] tick_nohz_idle_enter+0x5f/0x90
<4> [186.107664] hardirqs last disabled at (6424624): [<ffffffff950fa1e2>] do_idle+0x82/0x260
<4> [186.107669] softirqs last  enabled at (6424590): [<ffffffff95e00395>] __do_softirq+0x395/0x49e
<4> [186.107674] softirqs last disabled at (6424571): [<ffffffff950c195a>] irq_exit+0xba/0xc0
<3> [186.107677] Preemption disabled at:
<4> [186.107681] [<ffffffff9504843b>] start_secondary+0x4b/0x1b0
<4> [186.107685] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U            5.6.0-rc7-next-20200327-g975f7a88c64d-next-20200327 #1
<4> [186.107687] Hardware name: MSI MS-7924/Z97M-G43(MS-7924), BIOS V1.12 02/15/2016
<4> [186.107688] Call Trace:
<4> [186.107695]  dump_stack+0x71/0x9b
<4> [186.107702]  ___might_sleep+0x178/0x260
<4> [186.107708]  cpus_read_lock+0x13/0xd0
<4> [186.107713]  static_key_enable+0x9/0x20
<4> [186.107717]  init_freq_invariance+0x1f0/0x3a0
<4> [186.107724]  start_secondary+0x71/0x1b0
<4> [186.107729]  secondary_startup_64+0xb6/0xc0
<3> [186.107756] BUG: scheduling while atomic: swapper/0/0/0x00000002
<4> [186.107763] 1 lock held by swapper/0/0:
<4> [186.107767]  #0: ffffffff9643e510 (cpu_hotplug_lock){++++}-{0:0}, at: static_key_enable+0x9/0x20
<4> [186.107775] Modules linked in: vgem snd_hda_codec_hdmi mei_hdcp i915 x86_pkg_temp_thermal coretemp snd_hda_codec_realtek snd_hda_codec_generic crct10dif_pclmul snd_hda_intel crc32_pclmul snd_intel_dspcfg ghash_clmulni_intel snd_hda_codec snd_hwdep snd_hda_core r8169 lpc_ich snd_pcm mei_me mei realtek prime_numbers
<3> [186.107797] Preemption disabled at:
<4> [186.107800] [<ffffffff9504843b>] start_secondary+0x4b/0x1b0
<4> [186.107803] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U  W         5.6.0-rc7-next-20200327-g975f7a88c64d-next-20200327 #1
<4> [186.107805] Hardware name: MSI MS-7924/Z97M-G43(MS-7924), BIOS V1.12 02/15/2016
<4> [186.107807] Call Trace:
<4> [186.107811]  dump_stack+0x71/0x9b
<4> [186.107815]  ? start_secondary+0x4b/0x1b0
<4> [186.107819]  __schedule_bug+0x7b/0xd0
<4> [186.107825]  __schedule+0x776/0x810
<4> [186.107832]  ? mark_held_locks+0x49/0x70
<4> [186.107839]  schedule+0x37/0xe0
<4> [186.107843]  ? percpu_rwsem_wait+0x117/0x180
<4> [186.107846]  percpu_rwsem_wait+0x117/0x180
<4> [186.107851]  ? percpu_down_write+0x140/0x140
<4> [186.107859]  __percpu_down_read+0x43/0x60
<4> [186.107864]  cpus_read_lock+0xc6/0xd0
<4> [186.107867]  static_key_enable+0x9/0x20
<4> [186.107871]  init_freq_invariance+0x1f0/0x3a0
<4> [186.107878]  start_secondary+0x71/0x1b0
<4> [186.107883]  secondary_startup_64+0xb6/0xc0
<4> [186.107900] ------------[ cut here ]------------
<4> [186.107901] releasing a pinned lock
<4> [186.107908] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4640 lock_release+0x2a2/0x2c0
<4> [186.107909] Modules linked in: vgem snd_hda_codec_hdmi mei_hdcp i915 x86_pkg_temp_thermal coretemp snd_hda_codec_realtek snd_hda_codec_generic crct10dif_pclmul snd_hda_intel crc32_pclmul snd_intel_dspcfg ghash_clmulni_intel snd_hda_codec snd_hwdep snd_hda_core r8169 lpc_ich snd_pcm mei_me mei realtek prime_numbers
<4> [186.107924] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U  W         5.6.0-rc7-next-20200327-g975f7a88c64d-next-20200327 #1
<4> [186.107926] Hardware name: MSI MS-7924/Z97M-G43(MS-7924), BIOS V1.12 02/15/2016
<4> [186.107928] RIP: 0010:lock_release+0x2a2/0x2c0
<4> [186.107931] Code: be 3f 00 00 00 48 c7 c7 51 a7 2b 96 c6 05 68 6d 41 01 01 e8 40 8e ff ff eb ae 48 c7 c7 51 a8 2b 96 48 89 04 24 e8 be 0b f9 ff <0f> 0b 48 8b 04 24 e9 22 fe ff ff e8 4e 0e f9 ff 0f 1f 40 00 66 2e
<4> [186.107933] RSP: 0018:ffffffff96403d88 EFLAGS: 00010086
<4> [186.107936] RAX: 0000000000000000 RBX: ffffffff964188c0 RCX: 0000000000000003
<4> [186.107937] RDX: 0000000080000003 RSI: ffffffff95138419 RDI: 00000000ffffffff
<4> [186.107939] RBP: ffffa1290f83bc58 R08: 0000000000000001 R09: 0000000000000001
<4> [186.107940] R10: ffffffff96403dc0 R11: 0000000000077cc4 R12: 0000000000000046
<4> [186.107944] R13: ffffffff950fa029 R14: 0000000000000002 R15: 00000000d3a98c93
<4> [186.107947] FS:  0000000000000000(0000) GS:ffffa1290f800000(0000) knlGS:0000000000000000
<4> [186.107948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4> [186.107950] CR2: 00007f307e92fb24 CR3: 0000000287410001 CR4: 00000000001606f0
<4> [186.107951] Call Trace:
<4> [186.107956]  _raw_spin_unlock_irq+0x12/0x40
<4> [186.107959]  dequeue_task_idle+0x9/0x30
<4> [186.107962]  __schedule+0x3cc/0x810
<4> [186.107965]  schedule+0x37/0xe0
<4> [186.107969]  ? percpu_rwsem_wait+0x117/0x180
<4> [186.107972]  percpu_rwsem_wait+0x117/0x180
<4> [186.107975]  ? percpu_down_write+0x140/0x140
<4> [186.107978]  __percpu_down_read+0x43/0x60
<4> [186.107981]  cpus_read_lock+0xc6/0xd0
<4> [186.107984]  static_key_enable+0x9/0x20
<4> [186.107988]  init_freq_invariance+0x1f0/0x3a0
<4> [186.107991]  start_secondary+0x71/0x1b0
<4> [186.107993]  secondary_startup_64+0xb6/0xc0
<4> [186.107997] irq event stamp: 6424720
<4> [186.108001] hardirqs last  enabled at (6424719): [<ffffffff95a5f298>] dump_stack+0x93/0x9b
<4> [186.108004] hardirqs last disabled at (6424720): [<ffffffff95a781f4>] __schedule+0xc4/0x810
<4> [186.108007] softirqs last  enabled at (6424590): [<ffffffff95e00395>] __do_softirq+0x395/0x49e
<4> [186.108011] softirqs last disabled at (6424571): [<ffffffff950c195a>] irq_exit+0xba/0xc0
<4> [186.108013] ---[ end trace 8ae0a00b9ac91c9b ]---
<3> [186.108015] bad: scheduling from the idle thread!
<4> [186.108018] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U  W         5.6.0-rc7-next-20200327-g975f7a88c64d-next-20200327 #1
<4> [186.108020] Hardware name: MSI MS-7924/Z97M-G43(MS-7924), BIOS V1.12 02/15/2016
<4> [186.108022] Call Trace:
<4> [186.108028]  dump_stack+0x71/0x9b
<4> [186.108033]  dequeue_task_idle+0x1a/0x30
<4> [186.108036]  __schedule+0x3cc/0x810
<4> [186.108047]  schedule+0x37/0xe0
<4> [186.108050]  ? percpu_rwsem_wait+0x117/0x180
<4> [186.108053]  percpu_rwsem_wait+0x117/0x180
<4> [186.108059]  ? percpu_down_write+0x140/0x140
<4> [186.108067]  __percpu_down_read+0x43/0x60
<4> [186.108072]  cpus_read_lock+0xc6/0xd0
<4> [186.108077]  static_key_enable+0x9/0x20
<4> [186.108081]  init_freq_invariance+0x1f0/0x3a0
<4> [186.108089]  start_secondary+0x71/0x1b0
<4> [186.108094]  secondary_startup_64+0xb6/0xc0
<4> [186.108112] ------------[ cut here ]------------
<4> [186.108112] unpinning an unpinned lock
<4> [186.108117] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4768 lock_unpin_lock+0x11e/0x130
<4> [186.108119] Modules linked in: vgem snd_hda_codec_hdmi mei_hdcp i915 x86_pkg_temp_thermal coretemp snd_hda_codec_realtek snd_hda_codec_generic crct10dif_pclmul snd_hda_intel crc32_pclmul snd_intel_dspcfg ghash_clmulni_intel snd_hda_codec snd_hwdep snd_hda_core r8169 lpc_ich snd_pcm mei_me mei realtek prime_numbers
<4> [186.108133] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U  W         5.6.0-rc7-next-20200327-g975f7a88c64d-next-20200327 #1
<4> [186.108134] Hardware name: MSI MS-7924/Z97M-G43(MS-7924), BIOS V1.12 02/15/2016
<4> [186.108136] RIP: 0010:lock_unpin_lock+0x11e/0x130
<4> [186.108138] Code: 96 e8 86 01 f9 ff 0f 0b e9 37 ff ff ff 0f 0b c7 82 bc 08 00 00 00 00 00 00 e9 3c ff ff ff 48 c7 c7 90 a8 2b 96 e8 62 01 f9 ff <0f> 0b e9 13 ff ff ff 90 66 2e 0f 1f 84 00 00 00 00 00 44 8b 0d 4d
<4> [186.108139] RSP: 0018:ffffffff96403db0 EFLAGS: 00010086
<4> [186.108140] RAX: 0000000000000000 RBX: ffffffff964191a8 RCX: 0000000000000003
<4> [186.108141] RDX: 0000000080000003 RSI: ffffffff95138419 RDI: 00000000ffffffff
<4> [186.108142] RBP: ffffffff964188c0 R08: 0000000000000001 R09: 0000000000000001
<4> [186.108143] R10: 00000000e6f5d832 R11: 0000000000078b54 R12: ffffa1290f83bc58
<4> [186.108144] R13: ffffffff96419180 R14: 0000000000000046 R15: 0000000000000001
<4> [186.108145] FS:  0000000000000000(0000) GS:ffffa1290f800000(0000) knlGS:0000000000000000
<4> [186.108146] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4> [186.108147] CR2: 00007f307e92fb24 CR3: 0000000287410001 CR4: 00000000001606f0
<4> [186.108147] Call Trace:
<4> [186.108151]  __schedule+0x747/0x810
<4> [186.108154]  schedule+0x37/0xe0
<4> [186.108156]  ? percpu_rwsem_wait+0x117/0x180
<4> [186.108157]  percpu_rwsem_wait+0x117/0x180
<4> [186.108160]  ? percpu_down_write+0x140/0x140
<4> [186.108162]  __percpu_down_read+0x43/0x60
<4> [186.108165]  cpus_read_lock+0xc6/0xd0
<4> [186.108167]  static_key_enable+0x9/0x20
<4> [186.108171]  init_freq_invariance+0x1f0/0x3a0
<4> [186.108173]  start_secondary+0x71/0x1b0
<4> [186.108175]  secondary_startup_64+0xb6/0xc0
<4> [186.108178] irq event stamp: 6424730
<4> [186.108181] hardirqs last  enabled at (6424729): [<ffffffff95a5f298>] dump_stack+0x93/0x9b
<4> [186.108183] hardirqs last disabled at (6424730): [<ffffffff95a7f32a>] _raw_spin_lock_irq+0xa/0x40
<4> [186.108185] softirqs last  enabled at (6424590): [<ffffffff95e00395>] __do_softirq+0x395/0x49e
<4> [186.108188] softirqs last disabled at (6424571): [<ffffffff950c195a>] irq_exit+0xba/0xc0
<4> [186.108188] ---[ end trace 8ae0a00b9ac91c9c ]---
<4> [186.108191] ------------[ cut here ]------------
<4> [186.108191] releasing a pinned lock
<4> [186.108196] WARNING: CPU: 0 PID: 0 at kernel/locking/lockdep.c:4640 lock_release+0x2a2/0x2c0
<4> [186.108196] Modules linked in: vgem snd_hda_codec_hdmi mei_hdcp i915 x86_pkg_temp_thermal coretemp snd_hda_codec_realtek snd_hda_codec_generic crct10dif_pclmul snd_hda_intel crc32_pclmul snd_intel_dspcfg ghash_clmulni_intel snd_hda_codec snd_hwdep snd_hda_core r8169 lpc_ich snd_pcm mei_me mei realtek prime_numbers
<4> [186.108204] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U  W         5.6.0-rc7-next-20200327-g975f7a88c64d-next-20200327 #1
<4> [186.108205] Hardware name: MSI MS-7924/Z97M-G43(MS-7924), BIOS V1.12 02/15/2016
<4> [186.108207] RIP: 0010:lock_release+0x2a2/0x2c0
<4> [186.108208] Code: be 3f 00 00 00 48 c7 c7 51 a7 2b 96 c6 05 68 6d 41 01 01 e8 40 8e ff ff eb ae 48 c7 c7 51 a8 2b 96 48 89 04 24 e8 be 0b f9 ff <0f> 0b 48 8b 04 24 e9 22 fe ff ff e8 4e 0e f9 ff 0f 1f 40 00 66 2e
<4> [186.108209] RSP: 0018:ffffffff96403d88 EFLAGS: 00010086
<4> [186.108210] RAX: 0000000000000000 RBX: ffffffff964188c0 RCX: 0000000000000003
<4> [186.108211] RDX: 0000000080000003 RSI: ffffffff95138419 RDI: 00000000ffffffff
<4> [186.108212] RBP: ffffa1290f83bc58 R08: 0000000000000001 R09: 0000000000000001
<4> [186.108213] R10: ffffffff96403dc0 R11: 00000000000795ac R12: 0000000000000046
<4> [186.108214] R13: ffffffff950fa029 R14: 0000000000000002 R15: 00000000d3a98c93
<4> [186.108215] FS:  0000000000000000(0000) GS:ffffa1290f800000(0000) knlGS:0000000000000000
<4> [186.108216] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4> [186.108217] CR2: 00007f307e92fb24 CR3: 0000000287410001 CR4: 00000000001606f0
<4> [186.108218] Call Trace:
<4> [186.108221]  _raw_spin_unlock_irq+0x12/0x40
<4> [186.108225]  dequeue_task_idle+0x9/0x30
<4> [186.108227]  __schedule+0x3cc/0x810
<4> [186.108230]  schedule+0x37/0xe0
<4> [186.108232]  ? percpu_rwsem_wait+0x117/0x180
<4> [186.108233]  percpu_rwsem_wait+0x117/0x180
<4> [186.108235]  ? percpu_down_write+0x140/0x140
<4> [186.108238]  __percpu_down_read+0x43/0x60
<4> [186.108240]  cpus_read_lock+0xc6/0xd0
<4> [186.108242]  static_key_enable+0x9/0x20
<4> [186.108245]  init_freq_invariance+0x1f0/0x3a0
<4> [186.108247]  start_secondary+0x71/0x1b0
<4> [186.108249]  secondary_startup_64+0xb6/0xc0
<4> [186.108252] irq event stamp: 6424732
<4> [186.108255] hardirqs last  enabled at (6424731): [<ffffffff95a7f57f>] _raw_spin_unlock_irq+0x1f/0x40
<4> [186.108257] hardirqs last disabled at (6424732): [<ffffffff95a781f4>] __schedule+0xc4/0x810
<4> [186.108258] softirqs last  enabled at (6424590): [<ffffffff95e00395>] __do_softirq+0x395/0x49e
<4> [186.108261] softirqs last disabled at (6424571): [<ffffffff950c195a>] irq_exit+0xba/0xc0
<4> [186.108262] ---[ end trace 8ae0a00b9ac91c9d ]---
<3> [186.108263] bad: scheduling from the idle thread!
<4> [186.108266] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G     U  W         5.6.0-rc7-next-20200327-g975f7a88c64d-next-20200327 #1
<4> [186.108268] Hardware name: MSI MS-7924/Z97M-G43(MS-7924), BIOS V1.12 02/15/2016
<4> [186.108269] Call Trace:
<4> [186.108273]  dump_stack+0x71/0x9b
<4> [186.108278]  dequeue_task_idle+0x1a/0x30
<4> [186.108282]  __schedule+0x3cc/0x810
<4> [186.108292]  schedule+0x37/0xe0
<4> [186.108296]  ? percpu_rwsem_wait+0x117/0x180
<4> [186.108298]  percpu_rwsem_wait+0x117/0x180
<4> [186.108303]  ? percpu_down_write+0x140/0x140
<4> [186.108311]  __percpu_down_read+0x43/0x60
<4> [186.108316]  cpus_read_lock+0xc6/0xd0
<4> [186.108319]  static_key_enable+0x9/0x20
<4> [186.108323]  init_freq_invariance+0x1f0/0x3a0
<4> [186.108330]  start_secondary+0x71/0x1b0
<4> [186.108335]  secondary_startup_64+0xb6/0xc0
<4> [186.108351] ------------[ cut here ]------------

repeating ad nauseam, e.g.
https://intel-gfx-ci.01.org/tree/linux-next/next-20200327/shard-hsw4/dmesg9.txt

Across all our test boxen.
-Chris
