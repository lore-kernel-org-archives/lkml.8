Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10C2C3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B50B21D94
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729634AbgDQKy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:54:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:44328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729364AbgDQKy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:54:59 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8087CD7DBF35CF8B1E2F;
        Fri, 17 Apr 2020 18:54:50 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Apr 2020 18:54:41 +0800
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <qiangqing.zhang@nxp.com>,
        <jolsa@redhat.com>, <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <shameerali.kolothum.thodi@huawei.com>,
        John Garry <john.garry@huawei.com>
Subject: [RFC PATCH] perf/smmuv3: Support sysfs identifier file
Date:   Fri, 17 Apr 2020 18:50:34 +0800
Message-ID: <1587120634-19666-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the perf tool to know the specific HW implementation, expose a HW
identifier file for the PMU device.

For now, we just support HiSilicon "hip08" through pre-existing ACPI
options quirk framework. A minimalistic approach is used, based on the
hope that a proper identification method will be available in a future
SMMUv3 spec.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index f01a57e5a5f3..0ed358cff4a7 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -113,6 +113,7 @@ struct smmu_pmu {
 	u64 counter_mask;
 	u32 options;
 	bool global_filter;
+	const char *identifier;
 };
 
 #define to_smmu_pmu(p) (container_of(p, struct smmu_pmu, pmu))
@@ -552,6 +553,27 @@ static struct attribute_group smmu_pmu_events_group = {
 	.is_visible = smmu_pmu_event_is_visible,
 };
 
+static ssize_t smmu_pmu_identifier_attr_show(struct device *dev,
+					struct device_attribute *attr,
+					char *page)
+{
+	struct smmu_pmu *smmu_pmu = to_smmu_pmu(dev_get_drvdata(dev));
+
+	return sprintf(page, "%s\n", smmu_pmu->identifier);
+}
+
+static struct device_attribute smmu_pmu_identifier_attr =
+	__ATTR(identifier, 0444, smmu_pmu_identifier_attr_show, NULL);
+
+static struct attribute *smmu_pmu_identifier_attrs[] = {
+	&smmu_pmu_identifier_attr.attr,
+	NULL
+};
+
+static struct attribute_group smmu_pmu_identifier_group = {
+	.attrs = smmu_pmu_identifier_attrs,
+};
+
 /* Formats */
 PMU_FORMAT_ATTR(event,		   "config:0-15");
 PMU_FORMAT_ATTR(filter_stream_id,  "config1:0-31");
@@ -575,6 +597,7 @@ static const struct attribute_group *smmu_pmu_attr_grps[] = {
 	&smmu_pmu_cpumask_group,
 	&smmu_pmu_events_group,
 	&smmu_pmu_format_group,
+	&smmu_pmu_identifier_group,
 	NULL
 };
 
@@ -718,7 +741,10 @@ static void smmu_pmu_get_acpi_options(struct smmu_pmu *smmu_pmu)
 	case IORT_SMMU_V3_PMCG_HISI_HIP08:
 		/* HiSilicon Erratum 162001800 */
 		smmu_pmu->options |= SMMU_PMCG_EVCNTR_RDONLY;
+		smmu_pmu->identifier = "hip08";
 		break;
+	default:
+		smmu_pmu->identifier = "none";
 	}
 
 	dev_notice(smmu_pmu->dev, "option mask 0x%x\n", smmu_pmu->options);
-- 
2.16.4

