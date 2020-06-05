Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E27C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184282067B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 13:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dI/nXDSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgFENPf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 09:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbgFENPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:15:31 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5BDC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 06:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EHiSND5nLUtypK0tVLnzwgoG6lLcXNjxaMcDwTHkmro=; b=dI/nXDSpm6ffGMTdKggh9hW/hS
        N4BiSMJ340o1kBcZqORdaSJZ/MQmvoYWppBgdaPmLS6e1ls5bQMz1qchssDbEA0TR50GLXqWPMT5k
        io2x37DnePXxU5IuED3puM8GCLcZLbyX/W3HLmN5UO759zbiHTYGRPcEntpIXMngmqQbwrEJcGh9P
        esB2hDwKWJCgm9Z+02XMob8KzH3HIB71cvvZdChv+VVj5+s7Oywllv1e23Z1Mi1Se2tDhVXKK7ns+
        tU4q9LXJgDPgZoi+Y36w1RqKikhStUpqI3sC0GC/bwpHsA0ZHBi3nD5owpiCBES00HzPiBrIuokNm
        vyqUwpvQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jhCBS-0001id-HC; Fri, 05 Jun 2020 13:14:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 692D3301A7A;
        Fri,  5 Jun 2020 15:14:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2C3DA21A74B35; Fri,  5 Jun 2020 15:14:51 +0200 (CEST)
Date:   Fri, 5 Jun 2020 15:14:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Subject: Re: BUG: kernel NULL pointer dereference from check_preempt_wakeup()
Message-ID: <20200605131451.GE2750@hirez.programming.kicks-ass.net>
References: <20200604225445.GA32319@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604225445.GA32319@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 03:54:45PM -0700, Paul E. McKenney wrote:

> BUG: kernel NULL pointer dereference, address: 0000000000000150
> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0 
> Oops: 0000 [#1] PREEMPT SMP PTI
> CPU: 9 PID: 196 Comm: rcu_torture_rea Not tainted 5.7.0+ #3923
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.11.0-2.el7 04/01/2014
> RIP: 0010:check_preempt_wakeup+0xb1/0x180
> Code: 83 ea 01 48 8b 9b 48 01 00 00 39 d0 75 f2 48 39 bb 50 01 00 00 75 05 48 85 ff 75 29 48 8b ad 48 01 00 00 48 8b 9b 48 01 00 00 <48> 8b bd 50 01 00 00 48 39 bb 50 01 00 00 0f 95 c2 48 85 ff 0f 94

That is:

All code
========
   0:	83 ea 01             	sub    $0x1,%edx
   3:	48 8b 9b 48 01 00 00 	mov    0x148(%rbx),%rbx
   a:	39 d0                	cmp    %edx,%eax
   c:	75 f2                	jne    0x0
   e:	48 39 bb 50 01 00 00 	cmp    %rdi,0x150(%rbx)
  15:	75 05                	jne    0x1c
  17:	48 85 ff             	test   %rdi,%rdi
  1a:	75 29                	jne    0x45
  1c:	48 8b ad 48 01 00 00 	mov    0x148(%rbp),%rbp
  23:	48 8b 9b 48 01 00 00 	mov    0x148(%rbx),%rbx
  2a:*	48 8b bd 50 01 00 00 	mov    0x150(%rbp),%rdi		<-- trapping instruction
  31:	48 39 bb 50 01 00 00 	cmp    %rdi,0x150(%rbx)
  38:	0f 95 c2             	setne  %dl
  3b:	48 85 ff             	test   %rdi,%rdi
  3e:	0f                   	.byte 0xf
  3f:	94                   	xchg   %eax,%esp

> RSP: 0018:ffffaccdc02ecd38 EFLAGS: 00010006
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffffafa0bc20
> RDX: 0000000000000000 RSI: ffff946b5df50000 RDI: ffff946b5f469340
> RBP: 0000000000000000 R08: ffff946b5df80d00 R09: 0000000000000001

And you have RBP == NULL and RBX == NULL

Now, my compiler generates very similar code for this function and tells
me this is:

  check_preempt_wakeup()
    find_matching_se()
      is_same_group()
        if (se->cfs_rq == pse->cfs_rq) <-- *BOOM*

and pahole gives us (for struct sched_entity):

  struct sched_entity *      parent;                                               /* 0x148   0x8 */
  struct cfs_rq *            cfs_rq;                                               /* 0x150   0x8 */

apparently both your @se and @pse are NULL.

Which shouldn't be possible..

I also don't see a relation to my recent changes here:

> Call Trace:
>  <IRQ>
>  check_preempt_curr+0x5d/0x90
>  ttwu_do_wakeup.isra.93+0xf/0x100
>  sched_ttwu_pending+0x66/0x90
>  smp_call_function_single_interrupt+0x2d/0xf0
>  call_function_single_interrupt+0xf/0x20

Since I would expect that to blow up much earlier, like @p == NULL or
something along those lines.

Could you perhaps try something like the below ? It would splat when we
run ouf of hierarchy to ascend, which is the only semi sane scenario for
ending up where you are.

Are you actively using cgroups or just whatever systemd decides to gift
you? Can you perhaps dump /proc/sched_debug while your test is running?

---

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 35f4cc024dcfc..7aace0a5921e9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -416,8 +416,6 @@ static inline struct sched_entity *parent_entity(struct sched_entity *se)
 static void
 find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 {
-	int se_depth, pse_depth;
-
 	/*
 	 * preemption test can be made between sibling entities who are in the
 	 * same cfs_rq i.e who have a common parent. Walk up the hierarchy of
@@ -425,23 +423,22 @@ find_matching_se(struct sched_entity **se, struct sched_entity **pse)
 	 * parent.
 	 */
 
-	/* First walk up until both entities are at same depth */
-	se_depth = (*se)->depth;
-	pse_depth = (*pse)->depth;
-
-	while (se_depth > pse_depth) {
-		se_depth--;
-		*se = parent_entity(*se);
-	}
-
-	while (pse_depth > se_depth) {
-		pse_depth--;
-		*pse = parent_entity(*pse);
-	}
-
 	while (!is_same_group(*se, *pse)) {
-		*se = parent_entity(*se);
-		*pse = parent_entity(*pse);
+		int se_depth = (*se)->depth;
+		int pse_depth = (*pse)->depth;
+
+		if (se_depth <= pse_depth) {
+			struct sched_entity *parent = parent_entity(*pse);
+			if (WARN_ON_ONCE(!parent))
+				return;
+			*pse = parent;
+		}
+		if (se_depth >= pse_depth) {
+			struct sched_entity *parent = parent_entity(*se);
+			if (WARN_ON_ONCE(!parent))
+				return;
+			*se = parent_entity(*se);
+		}
 	}
 }
 
