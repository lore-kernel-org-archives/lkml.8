Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD56C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E97C22078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732292AbgFWQWK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:22:10 -0400
Received: from foss.arm.com ([217.140.110.172]:60562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732185AbgFWQWK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:22:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E72B71F1;
        Tue, 23 Jun 2020 09:22:08 -0700 (PDT)
Received: from [10.57.9.128] (unknown [10.57.9.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 41F9F3F73C;
        Tue, 23 Jun 2020 09:22:07 -0700 (PDT)
Subject: Re: [PATCH 4/4] iommu/arm-smmu-v3: Remove cmpxchg() in
 arm_smmu_cmdq_issue_cmdlist()
To:     John Garry <john.garry@huawei.com>,
        kernel test robot <lkp@intel.com>,
        "will@kernel.org" <will@kernel.org>, rikard.falkeborn@gmail.com
Cc:     "trivial@kernel.org" <trivial@kernel.org>,
        "maz@kernel.org" <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <1592846920-45338-5-git-send-email-john.garry@huawei.com>
 <202006230905.3HpPgtSC%lkp@intel.com>
 <5ba2e240-b324-d316-c00c-38c03ee49baa@huawei.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <693bfa60-82cf-bcbb-5745-0d001f7d9f9e@arm.com>
Date:   Tue, 23 Jun 2020 17:22:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <5ba2e240-b324-d316-c00c-38c03ee49baa@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-23 10:21, John Garry wrote:
> On 23/06/2020 02:07, kernel test robot wrote:
> 
> + Rikard, as the GENMASK compile-time sanity checks were added recently
> 
>> Hi John,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on iommu/next]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use  as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    
>> https://github.com/0day-ci/linux/commits/John-Garry/iommu-arm-smmu-v3-Improve-cmdq-lock-efficiency/20200623-013438 
>>
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git 
>> next
>> config: arm64-randconfig-c024-20200622 (attached as .config)
>> compiler: aarch64-linux-gcc (GCC) 9.3.0
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>, old ones prefixed by <<):
>>
>> In file included from include/linux/bits.h:23,
>> from include/linux/ioport.h:15,
>> from include/linux/acpi.h:12,
>> from drivers/iommu/arm-smmu-v3.c:12:
>> drivers/iommu/arm-smmu-v3.c: In function 'arm_smmu_cmdq_issue_cmdlist':
>> include/linux/bits.h:26:28: warning: comparison of unsigned expression 
>> < 0 is always false [-Wtype-limits]
>> 26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> 
> I'd say that GENMASK_INPUT_CHECK() should be able to handle a l=0 and 
> h=unsigned value, so I doubt this warn.
> 
> Using GENMASK((int)cmdq->q.llq.max_n_shift, 0) resolves it, but it looks 
> like GENMASK_INPUT_CHECK() could be improved.

That said, I think this particular case might be even better off dodging
GENMASK() entirely, by doing something like this first. Untested...

Robin.

----->8-----
Subject: [PATCH] iommu/arm-smmu-v3: Streamline queue calculations

Beyond the initial queue setup based on the log2 values from ID
registers, the log2 queue size is only ever used in the form of
(1 << max_n_shift) to repeatedly recalculate the number of queue
elements. Simply storing it in that form leads to slightly more
efficient code, particularly in the low-level queue accessors
where it counts most:

add/remove: 0/0 grow/shrink: 1/7 up/down: 4/-120 (-116)
Function                                     old     new   delta
arm_smmu_init_one_queue                      360     364      +4
arm_smmu_priq_thread                         512     508      -4
arm_smmu_evtq_thread                         300     292      -8
__arm_smmu_cmdq_poll_set_valid_map.isra      296     288      -8
queue_remove_raw                             180     164     -16
arm_smmu_gerror_handler                      732     716     -16
arm_smmu_device_probe                       4312    4284     -28
arm_smmu_cmdq_issue_cmdlist                 1892    1852     -40
Total: Before=20135, After=20019, chg -0.58%

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/iommu/arm-smmu-v3.c | 46 ++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index f578677a5c41..407cb9451a7a 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -185,8 +185,8 @@
 #define ARM_SMMU_MEMATTR_DEVICE_nGnRE	0x1
 #define ARM_SMMU_MEMATTR_OIWB		0xf
 
-#define Q_IDX(llq, p)			((p) & ((1 << (llq)->max_n_shift) - 1))
-#define Q_WRP(llq, p)			((p) & (1 << (llq)->max_n_shift))
+#define Q_IDX(llq, p)			((p) & ((llq)->max_n - 1))
+#define Q_WRP(llq, p)			((p) & (llq)->max_n)
 #define Q_OVERFLOW_FLAG			(1U << 31)
 #define Q_OVF(p)			((p) & Q_OVERFLOW_FLAG)
 #define Q_ENT(q, p)			((q)->base +			\
@@ -531,7 +531,7 @@ struct arm_smmu_ll_queue {
 		} atomic;
 		u8			__pad[SMP_CACHE_BYTES];
 	} ____cacheline_aligned_in_smp;
-	u32				max_n_shift;
+	u32				max_n;
 };
 
 struct arm_smmu_queue {
@@ -771,7 +771,7 @@ static bool queue_has_space(struct arm_smmu_ll_queue *q, u32 n)
 	cons = Q_IDX(q, q->cons);
 
 	if (Q_WRP(q, q->prod) == Q_WRP(q, q->cons))
-		space = (1 << q->max_n_shift) - (prod - cons);
+		space = q->max_n - (prod - cons);
 	else
 		space = cons - prod;
 
@@ -1164,8 +1164,8 @@ static void __arm_smmu_cmdq_poll_set_valid_map(struct arm_smmu_cmdq *cmdq,
 {
 	u32 swidx, sbidx, ewidx, ebidx;
 	struct arm_smmu_ll_queue llq = {
-		.max_n_shift	= cmdq->q.llq.max_n_shift,
-		.prod		= sprod,
+		.max_n	= cmdq->q.llq.max_n,
+		.prod	= sprod,
 	};
 
 	ewidx = BIT_WORD(Q_IDX(&llq, eprod));
@@ -1344,8 +1344,8 @@ static void arm_smmu_cmdq_write_entries(struct arm_smmu_cmdq *cmdq, u64 *cmds,
 {
 	int i;
 	struct arm_smmu_ll_queue llq = {
-		.max_n_shift	= cmdq->q.llq.max_n_shift,
-		.prod		= prod,
+		.max_n	= cmdq->q.llq.max_n,
+		.prod	= prod,
 	};
 
 	for (i = 0; i < n; ++i) {
@@ -1381,7 +1381,7 @@ static int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	bool owner;
 	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
 	struct arm_smmu_ll_queue llq = {
-		.max_n_shift = cmdq->q.llq.max_n_shift,
+		.max_n = cmdq->q.llq.max_n,
 	}, head = llq;
 	int ret = 0;
 
@@ -3144,13 +3144,13 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 	size_t qsz;
 
 	do {
-		qsz = ((1 << q->llq.max_n_shift) * dwords) << 3;
+		qsz = (q->llq.max_n * dwords) << 3;
 		q->base = dmam_alloc_coherent(smmu->dev, qsz, &q->base_dma,
 					      GFP_KERNEL);
 		if (q->base || qsz < PAGE_SIZE)
 			break;
 
-		q->llq.max_n_shift--;
+		q->llq.max_n >>= 1;
 	} while (1);
 
 	if (!q->base) {
@@ -3162,7 +3162,7 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 
 	if (!WARN_ON(q->base_dma & (qsz - 1))) {
 		dev_info(smmu->dev, "allocated %u entries for %s\n",
-			 1 << q->llq.max_n_shift, name);
+			 q->llq.max_n, name);
 	}
 
 	q->prod_reg	= arm_smmu_page1_fixup(prod_off, smmu);
@@ -3171,7 +3171,7 @@ static int arm_smmu_init_one_queue(struct arm_smmu_device *smmu,
 
 	q->q_base  = Q_BASE_RWA;
 	q->q_base |= q->base_dma & Q_BASE_ADDR_MASK;
-	q->q_base |= FIELD_PREP(Q_BASE_LOG2SIZE, q->llq.max_n_shift);
+	q->q_base |= FIELD_PREP(Q_BASE_LOG2SIZE, ilog2(q->llq.max_n));
 
 	q->llq.prod = q->llq.cons = 0;
 	return 0;
@@ -3187,13 +3187,12 @@ static int arm_smmu_cmdq_init(struct arm_smmu_device *smmu)
 {
 	int ret = 0;
 	struct arm_smmu_cmdq *cmdq = &smmu->cmdq;
-	unsigned int nents = 1 << cmdq->q.llq.max_n_shift;
 	atomic_long_t *bitmap;
 
 	atomic_set(&cmdq->owner_prod, 0);
 	atomic_set(&cmdq->lock, 0);
 
-	bitmap = (atomic_long_t *)bitmap_zalloc(nents, GFP_KERNEL);
+	bitmap = (atomic_long_t *)bitmap_zalloc(cmdq->q.llq.max_n, GFP_KERNEL);
 	if (!bitmap) {
 		dev_err(smmu->dev, "failed to allocate cmdq bitmap\n");
 		ret = -ENOMEM;
@@ -3695,7 +3694,7 @@ static int arm_smmu_device_reset(struct arm_smmu_device *smmu, bool bypass)
 
 static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 {
-	u32 reg;
+	u32 reg, max_n_shift;
 	bool coherent = smmu->features & ARM_SMMU_FEAT_COHERENCY;
 
 	/* IDR0 */
@@ -3798,9 +3797,9 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 	}
 
 	/* Queue sizes, capped to ensure natural alignment */
-	smmu->cmdq.q.llq.max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT,
-					     FIELD_GET(IDR1_CMDQS, reg));
-	if (smmu->cmdq.q.llq.max_n_shift <= ilog2(CMDQ_BATCH_ENTRIES)) {
+	max_n_shift = min_t(u32, CMDQ_MAX_SZ_SHIFT, FIELD_GET(IDR1_CMDQS, reg));
+	smmu->cmdq.q.llq.max_n = 1 << max_n_shift;
+	if (smmu->cmdq.q.llq.max_n <= CMDQ_BATCH_ENTRIES) {
 		/*
 		 * We don't support splitting up batches, so one batch of
 		 * commands plus an extra sync needs to fit inside the command
@@ -3812,10 +3811,11 @@ static int arm_smmu_device_hw_probe(struct arm_smmu_device *smmu)
 		return -ENXIO;
 	}
 
-	smmu->evtq.q.llq.max_n_shift = min_t(u32, EVTQ_MAX_SZ_SHIFT,
-					     FIELD_GET(IDR1_EVTQS, reg));
-	smmu->priq.q.llq.max_n_shift = min_t(u32, PRIQ_MAX_SZ_SHIFT,
-					     FIELD_GET(IDR1_PRIQS, reg));
+	max_n_shift = min_t(u32, EVTQ_MAX_SZ_SHIFT, FIELD_GET(IDR1_EVTQS, reg));
+	smmu->evtq.q.llq.max_n = 1 << max_n_shift;
+
+	max_n_shift = min_t(u32, PRIQ_MAX_SZ_SHIFT, FIELD_GET(IDR1_PRIQS, reg));
+	smmu->priq.q.llq.max_n = 1 << max_n_shift;
 
 	/* SID/SSID sizes */
 	smmu->ssid_bits = FIELD_GET(IDR1_SSIDSIZE, reg);
-- 
2.23.0.dirty

