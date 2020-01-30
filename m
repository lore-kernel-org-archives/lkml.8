Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E9AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ACCC2464B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409934;
	bh=YgsZRwJQo5NDjLt5Mz+9Gt6+Z3gsDcXgk385OZZSpSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xiqmdjS5+3AXDuZIRSrDN7tnPIpc+qTQ7DcLHUsgSG6etzDI3gm3kbudNj1EznBUS
	 M7yludQArBUlpWmBH19en2yGzMVMgLCzTmA77UX+Xk5jvWV79vIat5QEM9JXnCgZQL
	 0xbrGXzDF0j2KeEaFUt3ojdlBnajwCQ+vDNsxa14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbgA3Spd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:45:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:55146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731028AbgA3Spc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:45:32 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64AD92464B;
        Thu, 30 Jan 2020 18:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409930;
        bh=YgsZRwJQo5NDjLt5Mz+9Gt6+Z3gsDcXgk385OZZSpSo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gpbP23U0EHUmwTYFE+0KJbUIZIuAYG8PQKWss0Ch3N5Pbs1Pz1SLodtJyr4uXzgHc
         wmlavmbdNgEjmTL5Cc3HgZPhxbJm4HeE+Cg4BrULqSPR1z+ffndpakmd4gIKpr1iM3
         mcIMB7WSjHfIl4l0nYIvWKfyRht2mFcdMUwjiyq8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joakim Zhang <qiangqing.zhang@nxp.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 088/110] perf/imx_ddr: Add enhanced AXI ID filter support
Date:   Thu, 30 Jan 2020 19:39:04 +0100
Message-Id: <20200130183624.644827284@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183613.810054545@linuxfoundation.org>
References: <20200130183613.810054545@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joakim Zhang <qiangqing.zhang@nxp.com>

[ Upstream commit 44f8bd014a94ed679ddb77d0b92350d4ac4f23a5 ]

With DDR_CAP_AXI_ID_FILTER quirk, indicating HW supports AXI ID filter
which only can get bursts from DDR transaction, i.e. DDR read/write
requests.

This patch add DDR_CAP_AXI_ID_ENHANCED_FILTER quirk, indicating HW
supports AXI ID filter which can get bursts and bytes from DDR
transaction at the same time. We hope PMU always return bytes in the
driver due to it is more meaningful for users.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 63 +++++++++++++++++++++-----------
 1 file changed, 42 insertions(+), 21 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index ce7345745b42c..2a3966d059e70 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -45,7 +45,8 @@
 static DEFINE_IDA(ddr_ida);
 
 /* DDR Perf hardware feature */
-#define DDR_CAP_AXI_ID_FILTER          0x1     /* support AXI ID filter */
+#define DDR_CAP_AXI_ID_FILTER			0x1     /* support AXI ID filter */
+#define DDR_CAP_AXI_ID_FILTER_ENHANCED		0x3     /* support enhanced AXI ID filter */
 
 struct fsl_ddr_devtype_data {
 	unsigned int quirks;    /* quirks needed for different DDR Perf core */
@@ -178,6 +179,36 @@ static const struct attribute_group *attr_groups[] = {
 	NULL,
 };
 
+static bool ddr_perf_is_filtered(struct perf_event *event)
+{
+	return event->attr.config == 0x41 || event->attr.config == 0x42;
+}
+
+static u32 ddr_perf_filter_val(struct perf_event *event)
+{
+	return event->attr.config1;
+}
+
+static bool ddr_perf_filters_compatible(struct perf_event *a,
+					struct perf_event *b)
+{
+	if (!ddr_perf_is_filtered(a))
+		return true;
+	if (!ddr_perf_is_filtered(b))
+		return true;
+	return ddr_perf_filter_val(a) == ddr_perf_filter_val(b);
+}
+
+static bool ddr_perf_is_enhanced_filtered(struct perf_event *event)
+{
+	unsigned int filt;
+	struct ddr_pmu *pmu = to_ddr_pmu(event->pmu);
+
+	filt = pmu->devtype_data->quirks & DDR_CAP_AXI_ID_FILTER_ENHANCED;
+	return (filt == DDR_CAP_AXI_ID_FILTER_ENHANCED) &&
+		ddr_perf_is_filtered(event);
+}
+
 static u32 ddr_perf_alloc_counter(struct ddr_pmu *pmu, int event)
 {
 	int i;
@@ -209,27 +240,17 @@ static void ddr_perf_free_counter(struct ddr_pmu *pmu, int counter)
 
 static u32 ddr_perf_read_counter(struct ddr_pmu *pmu, int counter)
 {
-	return readl_relaxed(pmu->base + COUNTER_READ + counter * 4);
-}
-
-static bool ddr_perf_is_filtered(struct perf_event *event)
-{
-	return event->attr.config == 0x41 || event->attr.config == 0x42;
-}
+	struct perf_event *event = pmu->events[counter];
+	void __iomem *base = pmu->base;
 
-static u32 ddr_perf_filter_val(struct perf_event *event)
-{
-	return event->attr.config1;
-}
-
-static bool ddr_perf_filters_compatible(struct perf_event *a,
-					struct perf_event *b)
-{
-	if (!ddr_perf_is_filtered(a))
-		return true;
-	if (!ddr_perf_is_filtered(b))
-		return true;
-	return ddr_perf_filter_val(a) == ddr_perf_filter_val(b);
+	/*
+	 * return bytes instead of bursts from ddr transaction for
+	 * axid-read and axid-write event if PMU core supports enhanced
+	 * filter.
+	 */
+	base += ddr_perf_is_enhanced_filtered(event) ? COUNTER_DPCR1 :
+						       COUNTER_READ;
+	return readl_relaxed(base + counter * 4);
 }
 
 static int ddr_perf_event_init(struct perf_event *event)
-- 
2.20.1



