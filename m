Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0D5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E6FD20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 09:58:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731628AbgGVJ6z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 05:58:55 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:61882 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726153AbgGVJ6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 05:58:54 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21893827-1500050 
        for multiple; Wed, 22 Jul 2020 10:57:56 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200721113719.GI119549@hirez.programming.kicks-ass.net>
References: <20200622100122.477087977@infradead.org> <20200622100825.726200103@infradead.org> <159532854586.15672.5123219635720172265@build.alporthouse.com> <20200721113719.GI119549@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH -v2 1/5] sched: Fix ttwu() race
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, paulmck@kernel.org, frederic@kernel.org,
        torvalds@linux-foundation.org, hch@lst.de
To:     peterz@infradead.org
Date:   Wed, 22 Jul 2020 10:57:56 +0100
Message-ID: <159541187604.15672.2433896906671712337@build.alporthouse.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting peterz@infradead.org (2020-07-21 12:37:19)
> On Tue, Jul 21, 2020 at 11:49:05AM +0100, Chris Wilson wrote:
> > Quoting Peter Zijlstra (2020-06-22 11:01:23)
> > > @@ -2378,6 +2385,9 @@ static inline bool ttwu_queue_cond(int c
> > >  static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
> > >  {
> > >         if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
> > > +               if (WARN_ON_ONCE(cpu == smp_processor_id()))
> > > +                       return false;
> > > +
> > >                 sched_clock_cpu(cpu); /* Sync clocks across CPUs */
> > >                 __ttwu_queue_wakelist(p, cpu, wake_flags);
> > >                 return true;
> > 
> > We've been hitting this warning frequently, but have never seen the
> > rcu-torture-esque oops ourselves.
> 
> How easy is it to hit this? What, if anything, can I do to make my own
> computer go bang?

I tried reproducing it in a mockup, hrtimer + irq_work + waitqueue, but
it remains elusive. It pops up in an obscure HW tests where we are
exercising timeout handling for rogue HW.
> 
> > <4> [181.766705] RIP: 0010:ttwu_queue_wakelist+0xbc/0xd0
> > <4> [181.766710] Code: 00 00 00 5b 5d 41 5c 41 5d c3 31 c0 5b 5d 41 5c 41 5d c3 31 c0 f6 c3 08 74 f2 48 c7 c2 00 ad 03 00 83 7c 11 40 01 77 e4 eb 80 <0f> 0b 31 c0 eb dc 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 bf 17
> > <4> [181.766726] RSP: 0018:ffffc90000003e08 EFLAGS: 00010046
> > <4> [181.766733] RAX: 0000000000000000 RBX: 00000000ffffffff RCX: ffff888276a00000
> > <4> [181.766740] RDX: 000000000003ad00 RSI: ffffffff8232045b RDI: ffffffff8233103e
> > <4> [181.766747] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
> > <4> [181.766754] R10: 00000000d3fa25c3 R11: 0000000053712267 R12: ffff88825b912940
> > <4> [181.766761] R13: 0000000000000000 R14: 0000000000000087 R15: 000000000003ad00
> > <4> [181.766769] FS:  0000000000000000(0000) GS:ffff888276a00000(0000) knlGS:0000000000000000
> > <4> [181.766777] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > <4> [181.766783] CR2: 000055b8245814e0 CR3: 0000000005610003 CR4: 00000000003606f0
> > <4> [181.766790] Call Trace:
> > <4> [181.766794]  <IRQ>
> > <4> [181.766798]  try_to_wake_up+0x21b/0x690
> > <4> [181.766805]  autoremove_wake_function+0xc/0x50
> > <4> [181.766858]  __i915_sw_fence_complete+0x1ee/0x250 [i915]
> > <4> [181.766912]  dma_i915_sw_fence_wake+0x2d/0x40 [i915]
> 
> Please, don't trim oopses..
> 
> > We are seeing this on the ttwu_queue() path, so with p->on_cpu=0, and the
> > warning is cleared up by
> > 
> > -               if (WARN_ON_ONCE(cpu == smp_processor_id()))
> > +               if (WARN_ON_ONCE(p->on_cpu && cpu == smp_processor_id()))
> > 
> > which would appear to restore the old behaviour for ttwu_queue() and
> > seem to be consistent with the intent of this patch. Hopefully this
> > helps identify the problem correctly.
> 
> Hurmph, that's actively wrong. We should never queue to self, as that
> would result in self-IPI, which is not possible on a bunch of archs. It
> works for you because x86 can in fact do that.
> 
> So ttwu_queue_cond() will only return true when:
> 
>  - target-cpu and current-cpu do not share cache;
>    so it cannot be this condition, because you _always_
>    share cache with yourself.
> 
>  - when WF_ON_CPU and target-cpu has nr_running <= 1;
>    which means p->on_cpu == true.
> 
> So now you have cpu == smp_processor_id() && p->on_cpu == 1, however
> your modified WARN contradicts that.
> 
> *puzzle*

Perhaps more damning is that I can replace WF_ON_CPU with p->on_cpu to
suppress the warning:

-static inline bool ttwu_queue_cond(int cpu, int wake_flags)
+static inline bool ttwu_queue_cond(struct task_struct *p, int cpu, int wake_flags)
 {
        /*
         * If the CPU does not share cache, then queue the task on the
@@ -2370,7 +2370,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
         * the soon-to-be-idle CPU as the current CPU is likely busy.
         * nr_running is checked to avoid unnecessary task stacking.
         */
-       if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
+       if (p->on_cpu && cpu_rq(cpu)->nr_running <= 1)
                return true;

        return false;
@@ -2378,7 +2378,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)

 static bool ttwu_queue_wakelist(struct task_struct *p, int cpu, int wake_flags)
 {
-       if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(cpu, wake_flags)) {
+       if (sched_feat(TTWU_QUEUE) && ttwu_queue_cond(p, cpu, wake_flags)) {
                if (WARN_ON_ONCE(cpu == smp_processor_id()))
                        return false;
