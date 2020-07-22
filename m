Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10831C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8334207CD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732132AbgGVRVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:21:13 -0400
Received: from foss.arm.com ([217.140.110.172]:60056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732043AbgGVRVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:21:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1F311147A;
        Wed, 22 Jul 2020 10:21:10 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 393DA3F66F;
        Wed, 22 Jul 2020 10:21:09 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 13/14] coresight: etm4x: Add support for sysreg only devices
Date:   Wed, 22 Jul 2020 18:20:39 +0100
Message-Id: <20200722172040.1299289-14-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200722172040.1299289-1-suzuki.poulose@arm.com>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for etms without memory mapped access.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index e91af23ac419..88ec89629507 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -27,6 +27,7 @@
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
 #include <linux/perf_event.h>
+#include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <asm/sections.h>
@@ -1687,6 +1688,11 @@ static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+static int etm4_4_probe(struct platform_device *pdev)
+{
+	return etm4_probe_common(&pdev->dev, NULL);
+}
+
 static struct amba_cs_uci_id uci_id_etm4[] = {
 	{
 		/*  ETMv4 UCI data */
@@ -1722,3 +1728,18 @@ static struct amba_driver etm4x_driver = {
 	.id_table	= etm4_ids,
 };
 builtin_amba_driver(etm4x_driver);
+
+static const struct of_device_id etm4_4_match[] = {
+	{ .compatible	= "arm,coresight-etm-v4.4" },
+	{}
+};
+
+static struct platform_driver etm4_4_driver = {
+	.probe		= etm4_4_probe,
+	.driver			= {
+		.name			= "coresight-etm4x",
+		.of_match_table		= etm4_4_match,
+		.suppress_bind_attrs	= true,
+	},
+};
+builtin_platform_driver(etm4_4_driver);
-- 
2.24.1

