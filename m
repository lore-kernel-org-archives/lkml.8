Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F203AC433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D43AD20781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731742AbgGVRVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:21:04 -0400
Received: from foss.arm.com ([217.140.110.172]:59966 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731271AbgGVRU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:20:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 09E11113E;
        Wed, 22 Jul 2020 10:20:59 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 254CE3F66F;
        Wed, 22 Jul 2020 10:20:58 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 03/14] coresight: tpiu: Use coresight device access abstraction
Date:   Wed, 22 Jul 2020 18:20:29 +0100
Message-Id: <20200722172040.1299289-4-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200722172040.1299289-1-suzuki.poulose@arm.com>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPIU driver access the device before the coresight device
is registered. In other words, before the drvdata->csdev
is valid. Thus, we need to make sure that the csdev_access
is valid for both the invocations. Switch to using the
csdev_access directly instead of relying on availability
of drvdata->csdev.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-tpiu.c | 30 +++++++++-----------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 7ef7649f48ad..84ff4bf5d3b8 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -60,49 +60,45 @@ struct tpiu_drvdata {
 	struct coresight_device	*csdev;
 };
 
-static void tpiu_enable_hw(struct tpiu_drvdata *drvdata)
+static void tpiu_enable_hw(struct csdev_access *csa)
 {
-	CS_UNLOCK(drvdata->base);
+	CS_UNLOCK(csa->base);
 
 	/* TODO: fill this up */
 
-	CS_LOCK(drvdata->base);
+	CS_LOCK(csa->base);
 }
 
 static int tpiu_enable(struct coresight_device *csdev, u32 mode, void *__unused)
 {
-	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
-	tpiu_enable_hw(drvdata);
+	tpiu_enable_hw(&csdev->access);
 	atomic_inc(csdev->refcnt);
 	dev_dbg(&csdev->dev, "TPIU enabled\n");
 	return 0;
 }
 
-static void tpiu_disable_hw(struct tpiu_drvdata *drvdata)
+static void tpiu_disable_hw(struct csdev_access *csa)
 {
-	CS_UNLOCK(drvdata->base);
+	CS_UNLOCK(csa->base);
 
 	/* Clear formatter and stop on flush */
-	writel_relaxed(FFCR_STOP_FI, drvdata->base + TPIU_FFCR);
+	csdev_access_relaxed_write32(csa, FFCR_STOP_FI, TPIU_FFCR);
 	/* Generate manual flush */
-	writel_relaxed(FFCR_STOP_FI | FFCR_FON_MAN, drvdata->base + TPIU_FFCR);
+	csdev_access_relaxed_write32(csa, FFCR_STOP_FI | FFCR_FON_MAN, TPIU_FFCR);
 	/* Wait for flush to complete */
-	coresight_timeout(drvdata->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
+	coresight_timeout(csa->base, TPIU_FFCR, FFCR_FON_MAN_BIT, 0);
 	/* Wait for formatter to stop */
-	coresight_timeout(drvdata->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
+	coresight_timeout(csa->base, TPIU_FFSR, FFSR_FT_STOPPED_BIT, 1);
 
-	CS_LOCK(drvdata->base);
+	CS_LOCK(csa->base);
 }
 
 static int tpiu_disable(struct coresight_device *csdev)
 {
-	struct tpiu_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
-
 	if (atomic_dec_return(csdev->refcnt))
 		return -EBUSY;
 
-	tpiu_disable_hw(drvdata);
+	tpiu_disable_hw(&csdev->access);
 
 	dev_dbg(&csdev->dev, "TPIU disabled\n");
 	return 0;
@@ -152,7 +148,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.access.base = base;
 
 	/* Disable tpiu to support older devices */
-	tpiu_disable_hw(drvdata);
+	tpiu_disable_hw(&desc.access);
 
 	pdata = coresight_get_platform_data(dev);
 	if (IS_ERR(pdata))
-- 
2.24.1

