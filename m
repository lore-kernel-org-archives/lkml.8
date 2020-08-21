Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFA0C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC62207DE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 13:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgHUN6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 09:58:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10305 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728764AbgHUN6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 09:58:20 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 18C9F5937A24790A5672;
        Fri, 21 Aug 2020 21:58:15 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 21 Aug 2020 21:58:05 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <robin.murphy@arm.com>
CC:     <joro@8bytes.org>, <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <maz@kernel.org>,
        <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 2/2] iommu/arm-smmu-v3: Remove cmpxchg() in arm_smmu_cmdq_issue_cmdlist()
Date:   Fri, 21 Aug 2020 21:54:22 +0800
Message-ID: <1598018062-175608-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1598018062-175608-1-git-send-email-john.garry@huawei.com>
References: <1598018062-175608-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It has been shown that the cmpxchg() for finding space in the cmdq can
be a bottleneck:
- for more CPUs contending the cmdq, the cmpxchg() will fail more often
- since the software-maintained cons pointer is updated on the same 64b
  memory region, the chance of cmpxchg() failure increases again

The cmpxchg() is removed as part of 2 related changes:

- Update prod and cmdq owner in a single atomic64 add operation.

  The prod value is updated in one 32b region, while the "owner" is updated
  in another 32b region.

  For the "owner", we now count this value, instead of setting a flag.
  Similar to before, once the owner has finished gathering, it will clear
  a mask. As such, a CPU declares itself as the "owner" when it reads zero
  for this region.

  The owner is now responsible for all cmdq locking to avoid possible
  deadlock. The owner will lock the cmdq for all non-owers it has gathered
  when they have space in the queue and have written their entries.

- Check for space in the cmdq after the prod pointer has been assigned.

  We don't bother checking for space in the cmdq before assigning the prod
  pointer, as this would be super racy.

  So since the prod pointer is updated unconditionally, it would be common
  for no space to be available in the cmdq when prod is assigned - that
  is, according the software-maintained prod and cons pointer. So now
  it must be ensured that the entries are not yet written and not until
  there is space.

  How the prod pointer is maintained also leads to a strange condition
  where the prod pointer can wrap past the cons pointer. We can detect this
  condition, and report no space here. However, a prod pointer progressed
  twice past the cons pointer cannot be detected. But it can be ensured
  that this that this scenario does not occur, as we limit the amount of
  commands any CPU can issue at any given time, such that we cannot
  progress prod pointer further.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 120 ++++++++++++--------
 1 file changed, 72 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a705fa3e18ea..d3c1400c644c 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -521,16 +521,17 @@ struct arm_smmu_cmdq_ent {
 struct arm_smmu_ll_queue {
 	union {
 		u64			val;
+		atomic64_t		atomic;
 		struct {
+			struct {
+				u16	sync;
+				u16	count;
+			};
 			u32		prod;
-			u32		cons;
 		};
-		struct {
-			atomic_t	prod;
-			atomic_t	cons;
-		} atomic;
 		u8			__pad[SMP_CACHE_BYTES];
 	} ____cacheline_aligned_in_smp;
+	u32				cons;
 	u32				max_n_shift;
 	u32				max_cmd_per_batch;
 };
@@ -771,10 +772,19 @@ static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
 	prod = Q_IDX(q, q->prod);
 	cons = Q_IDX(q, q->cons);
 
-	if (Q_WRP(q, q->prod) == Q_WRP(q, q->cons))
+	if (Q_WRP(q, q->prod) == Q_WRP(q, q->cons)) {
+		/* check if we have wrapped, meaning definitely no space */
+		if (cons > prod)
+			return false;
+
 		space = (1 << q->max_n_shift) - (prod - cons);
-	else
+	} else {
+		/* similar check to above */
+		if (prod > cons)
+			return false;
+
 		space = cons - prod;
+	}
 
 	return space >= n;
 }
@@ -1072,7 +1082,7 @@ static void arm_smmu_cmdq_skip_err(struct arm_smmu_device *smmu)
  *   fails if the caller appears to be the last lock holder (yes, this is
  *   racy). All successful UNLOCK routines have RELEASE semantics.
  */
-static void arm_smmu_cmdq_shared_lock(struct arm_smmu_cmdq *cmdq)
+static void arm_smmu_cmdq_shared_lock(struct arm_smmu_cmdq *cmdq, int count)
 {
 	int val;
 
@@ -1082,12 +1092,12 @@ static void arm_smmu_cmdq_shared_lock(struct arm_smmu_cmdq *cmdq)
 	 * to INT_MIN so these increments won't hurt as the value will remain
 	 * negative.
 	 */
-	if (atomic_fetch_inc_relaxed(&cmdq->lock) >= 0)
+	if (atomic_fetch_add_relaxed(count, &cmdq->lock) >= 0)
 		return;
 
 	do {
 		val = atomic_cond_read_relaxed(&cmdq->lock, VAL >= 0);
-	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + 1) != val);
+	} while (atomic_cmpxchg_relaxed(&cmdq->lock, val, val + count) != val);
 }
 
 static void arm_smmu_cmdq_shared_unlock(struct arm_smmu_cmdq *cmdq)
@@ -1236,13 +1246,14 @@ static int arm_smmu_cmdq_poll_until_not_full(struct arm_smmu_device *smmu,
 	if (arm_smmu_cmdq_exclusive_trylock_irqsave(cmdq, flags)) {
 		WRITE_ONCE(cmdq->q.llq.cons, readl_relaxed(cmdq->q.cons_reg));
 		arm_smmu_cmdq_exclusive_unlock_irqrestore(cmdq, flags);
-		llq->val = READ_ONCE(cmdq->q.llq.val);
+		llq->cons = READ_ONCE(cmdq->q.llq.cons);
 		return 0;
 	}
 
 	queue_poll_init(smmu, &qp);
 	do {
-		llq->val = READ_ONCE(smmu->cmdq.q.llq.val);
+		llq->prod = READ_ONCE(smmu->cmdq.q.llq.prod);
+		llq->cons = READ_ONCE(smmu->cmdq.q.llq.cons);
 		if (!queue_full(llq))
 			break;
 
@@ -1289,7 +1300,7 @@ static int __arm_smmu_cmdq_poll_until_consumed(struct arm_smmu_device *smmu,
 	int ret = 0;
 
 	queue_poll_init(smmu, &qp);
-	llq->val = READ_ONCE(smmu->cmdq.q.llq.val);
+	llq->cons = READ_ONCE(smmu->cmdq.q.llq.cons);
 	do {
 		if (queue_consumed(llq, prod))
 			break;
@@ -1383,53 +1394,46 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	struct arm_smmu_ll_queue llq = {
 		.max_n_shift = cmdq->q.llq.max_n_shift,
-	}, head = llq;
+	}, head = llq, space = {
+		.max_n_shift = cmdq->q.llq.max_n_shift,
+		/* We would need 2^16 CPUs gathered for overflow ... */
+		.count = 1,
+		.sync = sync,
+		.prod = n + sync,
+	};
+	u32 prod_mask = GENMASK(cmdq->q.llq.max_n_shift, 0);
 	int ret = 0;
 
 	/* 1. Allocate some space in the queue */
 	local_irq_save(flags);
-	llq.val = READ_ONCE(cmdq->q.llq.val);
-	do {
-		u64 old;
 
-		while (!queue_has_space(&llq, n + sync)) {
-			local_irq_restore(flags);
-			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
-				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
-			local_irq_save(flags);
-		}
+	llq.val = atomic64_fetch_add(space.val, &cmdq->q.llq.atomic);
+	llq.prod &= prod_mask;
+	owner = !llq.count;
+	head.prod = queue_inc_prod_n(&llq, n + sync);
 
-		head.cons = llq.cons;
-		head.prod = queue_inc_prod_n(&llq, n + sync) |
-					     CMDQ_PROD_OWNED_FLAG;
-
-		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
-		if (old == llq.val)
-			break;
+	/*
+	 * Ensure it's safe to write the entries. For this, we need to ensure
+	 * that there is space in the queue from our prod pointer.
+	 */
+	space.cons = READ_ONCE(cmdq->q.llq.cons);
+	space.prod = llq.prod;
+	while (!queue_has_space(&space, n + sync)) {
+		if (arm_smmu_cmdq_poll_until_not_full(smmu, &space))
+			dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 
-		llq.val = old;
-	} while (1);
-	owner = !(llq.prod & CMDQ_PROD_OWNED_FLAG);
-	head.prod &= ~CMDQ_PROD_OWNED_FLAG;
-	llq.prod &= ~CMDQ_PROD_OWNED_FLAG;
+		space.prod = llq.prod;
+	}
 
 	/*
 	 * 2. Write our commands into the queue
-	 * Dependency ordering from the cmpxchg() loop above.
+	 * Dependency ordering from the space-checking while loop, above.
 	 */
 	arm_smmu_cmdq_write_entries(cmdq, cmds, llq.prod, n);
 	if (sync) {
 		prod = queue_inc_prod_n(&llq, n);
 		arm_smmu_cmdq_build_sync_cmd(cmd_sync, smmu, prod);
 		queue_write(Q_ENT(&cmdq->q, prod), cmd_sync, CMDQ_ENT_DWORDS);
-
-		/*
-		 * In order to determine completion of our CMD_SYNC, we must
-		 * ensure that the queue can't wrap twice without us noticing.
-		 * We achieve that by taking the cmdq lock as shared before
-		 * marking our slot as valid.
-		 */
-		arm_smmu_cmdq_shared_lock(cmdq);
 	}
 
 	/* 3. Mark our slots as valid, ensuring commands are visible first */
@@ -1438,13 +1442,20 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 	/* 4. If we are the owner, take control of the SMMU hardware */
 	if (owner) {
+		struct arm_smmu_ll_queue tmp = {
+			.sync = ~0,
+			.count = ~0,
+			.prod = ~prod_mask,
+		};
+		int sync_count;
 		/* a. Wait for previous owner to finish */
 		atomic_cond_read_relaxed(&cmdq->owner_prod, VAL == llq.prod);
 
-		/* b. Stop gathering work by clearing the owned flag */
-		prod = atomic_fetch_andnot_relaxed(CMDQ_PROD_OWNED_FLAG,
-						   &cmdq->q.llq.atomic.prod);
-		prod &= ~CMDQ_PROD_OWNED_FLAG;
+		/* b. Stop gathering work by clearing the owned mask */
+		tmp.val = atomic64_fetch_andnot_relaxed(tmp.val,
+						       &cmdq->q.llq.atomic);
+		prod = Q_WRP(&llq, tmp.prod) | Q_IDX(&llq, tmp.prod);
+		sync_count = tmp.sync;
 
 		/*
 		 * c. Wait for any gathered work to be written to the queue.
@@ -1453,6 +1464,19 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 		 */
 		arm_smmu_cmdq_poll_valid_map(cmdq, llq.prod, prod);
 
+		/*
+		 * In order to determine completion of the CMD_SYNCs, we must
+		 * ensure that the queue can't wrap twice without us noticing.
+		 * We achieve that by taking the cmdq lock as shared before
+		 * progressing the prod pointer.
+		 * The owner does this for all the non-owners it has gathered.
+		 * Otherwise, some non-owner(s) may lock the cmdq, blocking the
+		 * cons being updating. This could be when the cmdq has just
+		 * become full. In this case, other sibling non-owners could be
+		 * blocked from progressing, leading to deadlock.
+		 */
+		arm_smmu_cmdq_shared_lock(cmdq, sync_count);
+
 		/*
 		 * d. Advance the hardware prod pointer
 		 * Control dependency ordering from the entries becoming valid.
-- 
2.26.2

