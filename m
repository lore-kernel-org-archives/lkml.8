Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19990C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC7FE20781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731916AbgGVRVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:21:07 -0400
Received: from foss.arm.com ([217.140.110.172]:59982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731378AbgGVRVC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:21:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E36A13A1;
        Wed, 22 Jul 2020 10:21:01 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 53FAD3F66F;
        Wed, 22 Jul 2020 10:21:00 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 05/14] coresight: Convert coresight_timeout to use access abstraction
Date:   Wed, 22 Jul 2020 18:20:31 +0100
Message-Id: <20200722172040.1299289-6-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200722172040.1299289-1-suzuki.poulose@arm.com>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the generic routines to use the new access abstraction layer
gradually, starting with coresigth_timeout.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c  |  2 +-
 drivers/hwtracing/coresight/coresight-etb10.c |  5 +++--
 drivers/hwtracing/coresight/coresight-etm4x.c | 12 +++++++-----
 drivers/hwtracing/coresight/coresight-stm.c   |  2 +-
 drivers/hwtracing/coresight/coresight-tmc.c   |  9 ++++++---
 drivers/hwtracing/coresight/coresight-tpiu.c  |  4 ++--
 drivers/hwtracing/coresight/coresight.c       | 15 +++++++++------
 include/linux/coresight.h                     | 17 +++++++++++++----
 8 files changed, 42 insertions(+), 24 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 6299ff7b8a14..30f037d4549d 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -401,7 +401,7 @@ static const struct attribute_group *catu_groups[] = {
 
 static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
 {
-	return coresight_timeout(drvdata->base,
+	return coresight_timeout(&drvdata->csdev->access,
 				 CATU_STATUS, CATU_STATUS_READY, 1);
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 0f2735e15119..507f63c51be5 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -251,6 +251,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
 {
 	u32 ffcr;
 	struct device *dev = &drvdata->csdev->dev;
+	struct coresight_device *csdev = drvdata->csdev;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -262,7 +263,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
 	ffcr |= ETB_FFCR_FON_MAN;
 	writel_relaxed(ffcr, drvdata->base + ETB_FFCR);
 
-	if (coresight_timeout(drvdata->base, ETB_FFCR, ETB_FFCR_BIT, 0)) {
+	if (coresight_timeout(&csdev->access, ETB_FFCR, ETB_FFCR_BIT, 0)) {
 		dev_err(dev,
 		"timeout while waiting for completion of Manual Flush\n");
 	}
@@ -270,7 +271,7 @@ static void __etb_disable_hw(struct etb_drvdata *drvdata)
 	/* disable trace capture */
 	writel_relaxed(0x0, drvdata->base + ETB_CTL_REG);
 
-	if (coresight_timeout(drvdata->base, ETB_FFSR, ETB_FFSR_BIT, 1)) {
+	if (coresight_timeout(&csdev->access, ETB_FFSR, ETB_FFSR_BIT, 1)) {
 		dev_err(dev,
 			"timeout while waiting for Formatter to Stop\n");
 	}
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 67deb4a4e618..d78d79940fc9 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -109,6 +109,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	int i, rc;
 	struct etmv4_config *config = &drvdata->config;
 	struct device *etm_dev = &drvdata->csdev->dev;
+	struct coresight_device *csdev = drvdata->csdev;
 
 	CS_UNLOCK(drvdata->base);
 
@@ -122,7 +123,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	writel_relaxed(0, drvdata->base + TRCPRGCTLR);
 
 	/* wait for TRCSTATR.IDLE to go up */
-	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
+	if (coresight_timeout(&csdev->access, TRCSTATR, TRCSTATR_IDLE_BIT, 1))
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 
@@ -209,7 +210,7 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	writel_relaxed(1, drvdata->base + TRCPRGCTLR);
 
 	/* wait for TRCSTATR.IDLE to go back down to '0' */
-	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
+	if (coresight_timeout(&csdev->access, TRCSTATR, TRCSTATR_IDLE_BIT, 0))
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 
@@ -474,6 +475,7 @@ static void etm4_disable_hw(void *info)
 	struct etmv4_drvdata *drvdata = info;
 	struct etmv4_config *config = &drvdata->config;
 	struct device *etm_dev = &drvdata->csdev->dev;
+	struct coresight_device *csdev = drvdata->csdev;
 	int i;
 
 	CS_UNLOCK(drvdata->base);
@@ -500,7 +502,7 @@ static void etm4_disable_hw(void *info)
 	writel_relaxed(control, drvdata->base + TRCPRGCTLR);
 
 	/* wait for TRCSTATR.PMSTABLE to go to '1' */
-	if (coresight_timeout(drvdata->base, TRCSTATR,
+	if (coresight_timeout(&csdev->access, TRCSTATR,
 			      TRCSTATR_PMSTABLE_BIT, 1))
 		dev_err(etm_dev,
 			"timeout while waiting for PM stable Trace Status\n");
@@ -1163,7 +1165,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	etm4_os_lock(drvdata);
 
 	/* wait for TRCSTATR.PMSTABLE to go up */
-	if (coresight_timeout(drvdata->base, TRCSTATR,
+	if (coresight_timeout(&csdev->access, TRCSTATR,
 			      TRCSTATR_PMSTABLE_BIT, 1)) {
 		dev_err(etm_dev,
 			"timeout while waiting for PM Stable Status\n");
@@ -1247,7 +1249,7 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	state->trcpdcr = readl(drvdata->base + TRCPDCR);
 
 	/* wait for TRCSTATR.IDLE to go up */
-	if (coresight_timeout(drvdata->base, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
+	if (coresight_timeout(&csdev->access, TRCSTATR, TRCSTATR_IDLE_BIT, 1)) {
 		dev_err(etm_dev,
 			"timeout while waiting for Idle Trace Status\n");
 		etm4_os_unlock(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index c8509cc78512..b704000c96b8 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -270,7 +270,7 @@ static void stm_disable(struct coresight_device *csdev,
 		spin_unlock(&drvdata->spinlock);
 
 		/* Wait until the engine has completely stopped */
-		coresight_timeout(drvdata->base, STMTCSR, STMTCSR_BUSY_BIT, 0);
+		coresight_timeout(&csdev->access, STMTCSR, STMTCSR_BUSY_BIT, 0);
 
 		pm_runtime_put(csdev->dev.parent);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index b49795ad6861..6036eb73dce8 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -33,16 +33,19 @@ DEFINE_CORESIGHT_DEVLIST(etr_devs, "tmc_etr");
 
 void tmc_wait_for_tmcready(struct tmc_drvdata *drvdata)
 {
+	struct coresight_device *csdev = drvdata->csdev;
+
 	/* Ensure formatter, unformatter and hardware fifo are empty */
-	if (coresight_timeout(drvdata->base,
+	if (coresight_timeout(&csdev->access,
 			      TMC_STS, TMC_STS_TMCREADY_BIT, 1)) {
-		dev_err(&drvdata->csdev->dev,
+		dev_err(&csdev->dev,
 			"timeout while waiting for TMC to be Ready\n");
 	}
 }
 
 void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
 {
+	struct coresight_device *csdev = drvdata->csdev;
 	u32 ffcr;
 
 	ffcr = readl_relaxed(drvdata->base + TMC_FFCR);
@@ -51,7 +54,7 @@ void tmc_flush_and_stop(struct tmc_drvdata *drvdata)
 	ffcr |= BIT(TMC_FFCR_FLUSHMAN_BIT);
 	writel_relaxed(ffcr, drvdata->base + TMC_FFCR);
 	/* Ensure flush completes */
-	if (coresight_timeout(drvdata->base,
+	if (coresight_timeout(&csdev->access,
 			      TMC_FFCR, TMC_FFCR_FLUSHMAN_BIT, 0)) {
 		dev_err(&drvdata->csdev->dev,
 		"timeout while waiting for completion of Manual Flush\n");
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 84ff4bf5d3b8..282d80e97265 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -86,9 +86,9 @@ static void tpiu_disable_hw(struct csdev_access *csa)
 	/* Generate manual flush */
 	csdev_access_relaxed_write32(csa, FFCR_STOP_FI | FFCR_FON_MAN, TPIU_FFCR);
 	/* Wait for flush to complete */
-	coresight_timeout(csa->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
+	coresight_timeout(csa, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
 	/* Wait for formatter to stop */
-	coresight_timeout(csa->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
+	coresight_timeout(csa, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
 
 	CS_LOCK(csa->base);
 }
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 38e9c03ab754..21e7615fcbc8 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1338,23 +1338,26 @@ static void coresight_remove_conns(struct coresight_device *csdev)
 }
 
 /**
- * coresight_timeout - loop until a bit has changed to a specific state.
- * @addr: base address of the area of interest.
- * @offset: address of a register, starting from @addr.
+ * coresight_timeout - loop until a bit has changed to a specific register
+ *			state.
+ * @csa: coresight device access for the device
+ * @offset: Offset of the register from the base of the device.
  * @position: the position of the bit of interest.
  * @value: the value the bit should have.
  *
  * Return: 0 as soon as the bit has taken the desired state or -EAGAIN if
  * TIMEOUT_US has elapsed, which ever happens first.
  */
-
-int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
+int coresight_timeout(struct csdev_access *csa,
+		      u32 offset,
+		      int position,
+		      int value)
 {
 	int i;
 	u32 val;
 
 	for (i = TIMEOUT_US; i > 0; i--) {
-		val = __raw_readl(addr + offset);
+		val = csdev_access_read32(csa, offset);
 		/* waiting on the bit to go from 0 to 1 */
 		if (value) {
 			if (val & BIT(position))
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 81ac708689f8..2989306f6041 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -433,8 +433,10 @@ coresight_register(struct coresight_desc *desc);
 extern void coresight_unregister(struct coresight_device *csdev);
 extern int coresight_enable(struct coresight_device *csdev);
 extern void coresight_disable(struct coresight_device *csdev);
-extern int coresight_timeout(void __iomem *addr, u32 offset,
-			     int position, int value);
+extern int coresight_timeout(struct csdev_access *csa,
+			     u32 offset,
+			     int position,
+			     int value);
 
 extern int coresight_claim_device(void __iomem *base);
 extern int coresight_claim_device_unlocked(void __iomem *base);
@@ -460,8 +462,15 @@ static inline void coresight_unregister(struct coresight_device *csdev) {}
 static inline int
 coresight_enable(struct coresight_device *csdev) { return -ENOSYS; }
 static inline void coresight_disable(struct coresight_device *csdev) {}
-static inline int coresight_timeout(void __iomem *addr, u32 offset,
-				     int position, int value) { return 1; }
+
+static inline int coresight_timeout(struct csdev_access *csa,
+				    u32 offset,
+				    int position,
+				    int value)
+{
+	return 1;
+}
+
 static inline int coresight_claim_device_unlocked(void __iomem *base)
 {
 	return -EINVAL;
-- 
2.24.1

