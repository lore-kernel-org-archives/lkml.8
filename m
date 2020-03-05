Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4253EC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D07F207FD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 20:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LsH6N3zH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgCEUYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 15:24:54 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60584 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgCEUYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 15:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2AxF3rBzH2O9+SrDfyVrkJ+dsz7MJmXWm1lYsOWuXYs=; b=LsH6N3zHv1yaPCl0gUK1JVBS3m
        QJxyQ1Lg+spvOciBUExGK0VJg5G1QCNjtP/ziPoi2Ugh2aO9kxS+EV0G9Rf8Gdbv42kK5oDEXNGbz
        5APf5L3Kk1gJhT+Hc8OecKRZaySRKQjni+aRM4JqPCRDWCfGXj1m/GecrPkmUWPTq+NP7jov6w+QT
        uU150JPltELinr8ptQ2XVQBumwOUdArLyVHeeRDLL2uJwu/+5QpO7dLH3/wCr5SBm2SwIrW9TZfvR
        EEKj5Eclz7HnneQuQ+V1sNWymzuLoCHQuQRtWsPNrs2FgATTjQ0mmsCMF7EM9xeg7FjCCZgu1ab8V
        nzdz2hng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j9x32-0006BG-AE; Thu, 05 Mar 2020 20:24:48 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6CF6C980DC4; Thu,  5 Mar 2020 21:24:40 +0100 (CET)
Date:   Thu, 5 Mar 2020 21:24:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     syzbot <syzbot+61ffbb75d30176841f76@syzkaller.appspotmail.com>
Cc:     bristot@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, simon.horman@netronome.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: possible deadlock in __static_key_slow_dec
Message-ID: <20200305202440.GC3348@worktop.programming.kicks-ass.net>
References: <0000000000006f20e205a01ef5e1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000006f20e205a01ef5e1@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 09:35:10AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=154474f9e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5d2e033af114153f
> dashboard link: https://syzkaller.appspot.com/bug?extid=61ffbb75d30176841f76
> compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14f0efa1e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=119cf3b5e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+61ffbb75d30176841f76@syzkaller.appspotmail.com

>  lock_acquire+0x154/0x250 kernel/locking/lockdep.c:4484
>  percpu_down_read include/linux/percpu-rwsem.h:40 [inline]
>  cpus_read_lock+0x3e/0x130 kernel/cpu.c:292
>  __static_key_slow_dec+0x14/0x90 kernel/jump_label.c:254
>  static_key_slow_dec+0x50/0xa0 kernel/jump_label.c:270
>  sw_perf_event_destroy+0x78/0x170 kernel/events/core.c:8840
>  _free_event+0x825/0xdc0 kernel/events/core.c:4616
>  put_event kernel/events/core.c:4710 [inline]
>  perf_mmap_close+0xc04/0xea0 kernel/events/core.c:5754
>  remove_vma mm/mmap.c:177 [inline]
>  remove_vma_list mm/mmap.c:2568 [inline]
>  __do_munmap+0x1006/0x14b0 mm/mmap.c:2812
>  do_munmap mm/mmap.c:2820 [inline]
>  mmap_region+0x8c8/0x1c40 mm/mmap.c:1713
>  do_mmap+0xa8f/0x1100 mm/mmap.c:1543
>  do_mmap_pgoff include/linux/mm.h:2334 [inline]
>  vm_mmap_pgoff+0x13d/0x1d0 mm/util.c:506

This seems to be by far the simplest to break, it also has some actual
benefits too.

Something like the (compile only tested) below ought to help. I'll try
and poke at the reproducer in the morning.

---
 include/linux/perf_event.h |  8 ++++----
 kernel/events/core.c       | 11 +++++++----
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 547773f5894e..a5684b2e481d 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1103,7 +1103,7 @@ static inline int is_exclusive_pmu(struct pmu *pmu)
 	return pmu->capabilities & PERF_PMU_CAP_EXCLUSIVE;
 }

-extern struct static_key perf_swevent_enabled[PERF_COUNT_SW_MAX];
+extern struct static_key_deferred perf_swevent_enabled[PERF_COUNT_SW_MAX];

 extern void ___perf_sw_event(u32, u64, struct pt_regs *, u64);
 extern void __perf_sw_event(u32, u64, struct pt_regs *, u64);
@@ -1134,7 +1134,7 @@ static inline void perf_fetch_caller_regs(struct pt_regs *regs)
 static __always_inline void
 perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)
 {
-	if (static_key_false(&perf_swevent_enabled[event_id]))
+	if (static_key_false(&perf_swevent_enabled[event_id].key))
 		__perf_sw_event(event_id, nr, regs, addr);
 }

@@ -1148,7 +1148,7 @@ DECLARE_PER_CPU(struct pt_regs, __perf_regs[4]);
 static __always_inline void
 perf_sw_event_sched(u32 event_id, u64 nr, u64 addr)
 {
-	if (static_key_false(&perf_swevent_enabled[event_id])) {
+	if (static_key_false(&perf_swevent_enabled[event_id].key)) {
 		struct pt_regs *regs = this_cpu_ptr(&__perf_regs[0]);

 		perf_fetch_caller_regs(regs);
@@ -1161,7 +1161,7 @@ extern struct static_key_false perf_sched_events;
 static __always_inline bool
 perf_sw_migrate_enabled(void)
 {
-	if (static_key_false(&perf_swevent_enabled[PERF_COUNT_SW_CPU_MIGRATIONS]))
+	if (static_key_false(&perf_swevent_enabled[PERF_COUNT_SW_CPU_MIGRATIONS].key))
 		return true;
 	return false;
 }
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e453589da97c..8ce277ec0b85 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8829,7 +8829,7 @@ static int swevent_hlist_get(void)
 	return err;
 }

-struct static_key perf_swevent_enabled[PERF_COUNT_SW_MAX];
+struct static_key_deferred perf_swevent_enabled[PERF_COUNT_SW_MAX];

 static void sw_perf_event_destroy(struct perf_event *event)
 {
@@ -8837,7 +8837,7 @@ static void sw_perf_event_destroy(struct perf_event *event)

 	WARN_ON(event->parent);

-	static_key_slow_dec(&perf_swevent_enabled[event_id]);
+	static_key_slow_dec_deferred(&perf_swevent_enabled[event_id]);
 	swevent_hlist_put();
 }

@@ -8873,7 +8873,7 @@ static int perf_swevent_init(struct perf_event *event)
 		if (err)
 			return err;

-		static_key_slow_inc(&perf_swevent_enabled[event_id]);
+		static_key_slow_inc(&perf_swevent_enabled[event_id].key);
 		event->destroy = sw_perf_event_destroy;
 	}

@@ -12376,7 +12376,10 @@ int perf_event_init_task(struct task_struct *child)
 static void __init perf_event_init_all_cpus(void)
 {
 	struct swevent_htable *swhash;
-	int cpu;
+	int i, cpu;
+
+	for (i = 0; i < PERF_COUNT_SW_MAX; i++)
+		jump_label_rate_limit(&perf_swevent_enabled[i], HZ/10);

 	zalloc_cpumask_var(&perf_online_mask, GFP_KERNEL);


