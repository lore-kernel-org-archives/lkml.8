Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E91C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD6FF2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729189AbgGUKuS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:50:18 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:59897 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726266AbgGUKuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:50:18 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21883524-1500050 
        for multiple; Tue, 21 Jul 2020 11:49:06 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200622100825.726200103@infradead.org>
References: <20200622100122.477087977@infradead.org> <20200622100825.726200103@infradead.org>
Subject: Re: [PATCH -v2 1/5] sched: Fix ttwu() race
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        paulmck@kernel.org, frederic@kernel.org, peterz@infradead.org,
        torvalds@linux-foundation.org, hch@lst.de
To:     Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        tglx@linutronix.de
Date:   Tue, 21 Jul 2020 11:49:05 +0100
Message-ID: <159532854586.15672.5123219635720172265@build.alporthouse.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peter Zijlstra (2020-06-22 11:01:23)
> @@ -2378,6 +2385,9 @@ static inline bool ttwu_queue_cond(int c
>  static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
>  {
>         if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
> +               if (WARN_ON_ONCE(cpu == smp_processor_id()))
> +                       return false;
> +
>                 sched_clock_cpu(cpu); /* Sync clocks across CPUs */
>                 __ttwu_queue_wakelist(p, cpu, wake_flags);
>                 return true;

We've been hitting this warning frequently, but have never seen the
rcu-torture-esque oops ourselves.

<4> [181.766705] RIP: 0010:ttwu_queue_wakelist+0xbc/0xd0
<4> [181.766710] Code: 00 00 00 5b 5d 41 5c 41 5d c3 31 c0 5b 5d 41 5c 41 5d c3 31 c0 f6 c3 08 74 f2 48 c7 c2 00 ad 03 00 83 7c 11 40 01 77 e4 eb 80 <0f> 0b 31 c0 eb dc 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 bf 17
<4> [181.766726] RSP: 0018:ffffc90000003e08 EFLAGS: 00010046
<4> [181.766733] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: ffff888276a00000
<4> [181.766740] RDX: 000000000003ad00 RSI: ffffffff8232045b RDI: ffffffff8233103e
<4> [181.766747] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
<4> [181.766754] R10: 00000000d3fa25c3 R11: 0000000053712267 R12: ffff88825b912940
<4> [181.766761] R13: 0000000000000000 R14: 0000000000000087 R15: 000000000003ad00
<4> [181.766769] FS:  0000000000000000(0000) GS:ffff888276a00000(0000) knlGS:0000000000000000
<4> [181.766777] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4> [181.766783] CR2: 000055b8245814e0 CR3: 0000000005610003 CR4: 00000000003606f0
<4> [181.766790] Call Trace:
<4> [181.766794]  <IRQ>
<4> [181.766798]  try_to_wake_up+0x21b/0x690
<4> [181.766805]  autoremove_wake_function+0xc/0x50
<4> [181.766858]  __i915_sw_fence_complete+0x1ee/0x250 [i915]
<4> [181.766912]  dma_i915_sw_fence_wake+0x2d/0x40 [i915]

We are seeing this on the ttwu_queue() path, so with p->on_cpu=0, and the
warning is cleared up by

-               if (WARN_ON_ONCE(cpu == smp_processor_id()))
+               if (WARN_ON_ONCE(p->on_cpu && cpu == smp_processor_id()))

which would appear to restore the old behaviour for ttwu_queue() and
seem to be consistent with the intent of this patch. Hopefully this
helps identify the problem correctly.
-Chris
