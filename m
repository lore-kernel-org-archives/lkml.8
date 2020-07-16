Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E36C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EF420853
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594894788;
	bh=3Kfj2U0gvDfDloWASjQO57LR6xuFE6ghFAVQobdH6ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EcIyWjL5NsjC76zbWlBUY/crjb7jYPgyDmhbslh4nks8QOb+G1JBoIggQVaoqwnqC
	 KEgJjy1AY8ufC0yr1Cdbbbr/0upa9HfJlX9IsQayKuhAw5QR4/WWho4JOm2AgPuZVZ
	 NnVsY77TPNHg4yrU+kVu1+7KVFotltDEectTZ6kI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbgGPKTr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:19:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:39526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgGPKTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:19:46 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791782074B;
        Thu, 16 Jul 2020 10:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594894786;
        bh=3Kfj2U0gvDfDloWASjQO57LR6xuFE6ghFAVQobdH6ks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=B4iWlTi9n5/jNVzGiiyq/aD+XME5+rlz4gpt0p4upnXV/Im/YL7X+2qNX8fIrM5P0
         djtcRTQhlMZz05N6beqSbpgNlaFKKjDiqdb98e9mWioHJg2tt7hK8KPKx6t0kdlVSL
         ll7K9O4OpFj4wprqEokl/98nt+0WnI17uXg0TZHA=
Date:   Thu, 16 Jul 2020 11:19:41 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     robin.murphy@arm.com, joro@8bytes.org, trivial@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, maz@kernel.org
Subject: Re: [PATCH 0/4] iommu/arm-smmu-v3: Improve cmdq lock efficiency
Message-ID: <20200716101940.GA7036@willie-the-truck>
References: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592846920-45338-1-git-send-email-john.garry@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 01:28:36AM +0800, John Garry wrote:
> As mentioned in [0], the CPU may consume many cycles processing
> arm_smmu_cmdq_issue_cmdlist(). One issue we find is the cmpxchg() loop to
> get space on the queue takes approx 25% of the cycles for this function.
> 
> This series removes that cmpxchg().

How about something much simpler like the diff below?

Will

--->8

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f578677a5c41..705d99ec8219 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -560,6 +560,7 @@ struct arm_smmu_cmdq {
 	atomic_long_t			*valid_map;
 	atomic_t			owner_prod;
 	atomic_t			lock;
+	spinlock_t			slock;
 };
 
 struct arm_smmu_cmdq_batch {
@@ -1378,7 +1379,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	u64 cmd_sync[CMDQ_ENT_DWORDS];
 	u32 prod;
 	unsigned long flags;
-	bool owner;
+	bool owner, cas_failed = false;
 	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	struct arm_smmu_ll_queue llq = {
 		.max_n_shift = cmdq->q.llq.max_n_shift,
@@ -1387,27 +1388,35 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 
 	/* 1. Allocate some space in the queue */
 	local_irq_save(flags);
-	llq.val = READ_ONCE(cmdq->q.llq.val);
 	do {
 		u64 old;
+		llq.val = READ_ONCE(cmdq->q.llq.val);
 
-		while (!queue_has_space(&llq, n + sync)) {
+		if (queue_has_space(&llq, n + sync))
+			goto try_cas;
+
+		if (cas_failed)
+			spin_unlock(&cmdq->slock);
+
+		do {
 			local_irq_restore(flags);
 			if (arm_smmu_cmdq_poll_until_not_full(smmu, &llq))
 				dev_err_ratelimited(smmu->dev, "CMDQ timeout\n");
 			local_irq_save(flags);
-		}
+		} while (!queue_has_space(&llq, n + sync));
 
+try_cas:
 		head.cons = llq.cons;
 		head.prod = queue_inc_prod_n(&llq, n + sync) |
 					     CMDQ_PROD_OWNED_FLAG;
 
 		old = cmpxchg_relaxed(&cmdq->q.llq.val, llq.val, head.val);
-		if (old == llq.val)
-			break;
+		cas_failed = old != llq.val;
+
+		if (cas_failed)
+			spin_lock(&cmdq->slock);
+	} while (cas_failed);
 
-		llq.val = old;
-	} while (1);
 	owner = !(llq.prod & CMDQ_PROD_OWNED_FLAG);
 	head.prod &= ~CMDQ_PROD_OWNED_FLAG;
 	llq.prod &= ~CMDQ_PROD_OWNED_FLAG;
@@ -3192,6 +3201,7 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
 
 	atomic_set(&cmdq->owner_prod, 0);
 	atomic_set(&cmdq->lock, 0);
+	spin_lock_init(&cmdq->slock);
 
 	bitmap = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
 	if (!bitmap) {
