Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA75FC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD1C207E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 15:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HU2qf7r1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgAMPHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 10:07:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22119 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726399AbgAMPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:07:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578928071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=j0msucI64dJuIAu2X81lzy2WWfJxmhNNupBdmcu4cNw=;
        b=HU2qf7r1aTUusC0blwg/6Dccy8RQS+tAHq2M+ESE8qU1ASSi/sK4EQULJYB5Abhe5nV30y
        4M6OY/61xFOpkmC4g0a1E/q4zHVx2Z+axgX+ChhY2TjqWX+1GMuF36i+1KzhA3mDaIzvTq
        mZn/7AF+XE17tj2XoMVWL6HzGaEA4lc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-17KnZeizOzqCtpqsnADSdg-1; Mon, 13 Jan 2020 10:07:48 -0500
X-MC-Unique: 17KnZeizOzqCtpqsnADSdg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF5A210054E3;
        Mon, 13 Jan 2020 15:07:46 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 325425C21B;
        Mon, 13 Jan 2020 15:07:43 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, yezengruan <yezengruan@huawei.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v3] locking/osq: Use optimized spinning loop for arm64
Date:   Mon, 13 Jan 2020 10:07:35 -0500
Message-Id: <20200113150735.21956-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm64 has a more optimized spinning loop (atomic_cond_read_acquire)
using wfe for spinlock that can boost performance of sibling threads
by putting the current cpu to a wait state that is broken only when
the monitored variable changes or an external event happens.

OSQ has a more complicated spinning loop. Besides the lock value, it
also checks for need_resched() and vcpu_is_preempted(). The check for
need_resched() is not a problem as it is only set by the tick interrupt
handler. That will be detected by the spinning cpu right after iret.

The vcpu_is_preempted() check, however, is a problem as changes to the
preempt state of of previous node will not affect the wait state. For
ARM64, vcpu_is_preempted is not currently defined and so is a no-op.
Will has indicated that he is planning to para-virtualize wfe instead
of defining vcpu_is_preempted for PV support. So just add a comment in
arch/arm64/include/asm/spinlock.h to indicate that vcpu_is_preempted()
should not be defined as suggested.

On a 2-socket 56-core 224-thread ARM64 system, a kernel mutex locking
microbenchmark was run for 10s with and without the patch. The
performance numbers before patch were:

Running locktest with mutex [runtime = 10s, load = 1]
Threads = 224, Min/Mean/Max = 316/123,143/2,121,269
Threads = 224, Total Rate = 2,757 kop/s; Percpu Rate = 12 kop/s

After patch, the numbers were:

Running locktest with mutex [runtime = 10s, load = 1]
Threads = 224, Min/Mean/Max = 334/147,836/1,304,787
Threads = 224, Total Rate = 3,311 kop/s; Percpu Rate = 15 kop/s

So there was about 20% performance improvement.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/arm64/include/asm/spinlock.h |  9 +++++++++
 kernel/locking/osq_lock.c         | 17 ++++-------------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/spinlock.h b/arch/arm64/include/asm/spinlock.h
index b093b287babf..102404dc1e13 100644
--- a/arch/arm64/include/asm/spinlock.h
+++ b/arch/arm64/include/asm/spinlock.h
@@ -11,4 +11,13 @@
 /* See include/linux/spinlock.h */
 #define smp_mb__after_spinlock()	smp_mb()
 
+/*
+ * Changing this will break osq_lock() thanks to the call inside
+ * smp_cond_load_relaxed().
+ *
+ * See:
+ * https://lore.kernel.org/lkml/20200110100612.GC2827@hirez.programming.kicks-ass.net
+ */
+#define vcpu_is_preempted(cpu)	false
+
 #endif /* __ASM_SPINLOCK_H */
diff --git a/kernel/locking/osq_lock.c b/kernel/locking/osq_lock.c
index 6ef600aa0f47..e42893f2fcbc 100644
--- a/kernel/locking/osq_lock.c
+++ b/kernel/locking/osq_lock.c
@@ -134,20 +134,11 @@ bool osq_lock(struct optimistic_spin_queue *lock)
 	 * cmpxchg in an attempt to undo our queueing.
 	 */
 
-	while (!READ_ONCE(node->locked)) {
-		/*
-		 * If we need to reschedule bail... so we can block.
-		 * Use vcpu_is_preempted() to avoid waiting for a preempted
-		 * lock holder:
-		 */
-		if (need_resched() || vcpu_is_preempted(node_cpu(node->prev)))
-			goto unqueue;
-
-		cpu_relax();
-	}
-	return true;
+	if (smp_cond_load_relaxed(&node->locked, VAL || need_resched() ||
+				  vcpu_is_preempted(node_cpu(node->prev))))
+		return true;
 
-unqueue:
+	/* unqueue */
 	/*
 	 * Step - A  -- stabilize @prev
 	 *
-- 
2.18.1

