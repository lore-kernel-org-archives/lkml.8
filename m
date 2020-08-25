Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1957C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:43:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7113320782
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:43:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Vh03nvee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgHYPnP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:43:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:40405 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgHYPnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:43:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598370193; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=vPjwRTcbHtJglbBEf+g+zBKRbHTS9GuM+a7BNj5yuBU=; b=Vh03nveeXVv8ph4et8GAzoNuY/j2fPUfIbunm4pLf2whrq6Wpcx4mN9w5nVd9CShJbAqBwvm
 KvrhDr4WIpe4PhdMVMUAJch71F5RbXjfFFYvlPwWpIknjKvypMVd1YLR7WaIueqKFyOWyCSA
 eyIYmcf1RxVzvUjchq90QoW8cFs=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f45318dca327a6430ed31f5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 25 Aug 2020 15:43:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5DD32C43395; Tue, 25 Aug 2020 15:43:08 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65BAAC433C6;
        Tue, 25 Aug 2020 15:43:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65BAAC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: [PATCH] iommu: Add support to filter non-strict/lazy mode based on device names
Date:   Tue, 25 Aug 2020 21:12:49 +0530
Message-Id: <20200825154249.20011-1-saiprakash.ranjan@codeaurora.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the non-strict or lazy mode of TLB invalidation can only be set
for all or no domains. This works well for development platforms where
setting to non-strict/lazy mode is fine for performance reasons but on
production devices, we need a more fine grained control to allow only
certain peripherals to support this mode where we can be sure that it is
safe. So add support to filter non-strict/lazy mode based on the device
names that are passed via cmdline parameter "iommu.nonstrict_device".

Example: iommu.nonstrict_device="7c4000.sdhci,a600000.dwc3,6048000.etr"

Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
---
 drivers/iommu/iommu.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 609bd25bf154..fd10a073f557 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -32,6 +32,9 @@ static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = true;
 static u32 iommu_cmd_line __read_mostly;
 
+#define DEVICE_NAME_LEN		1024
+static char nonstrict_device[DEVICE_NAME_LEN] __read_mostly;
+
 struct iommu_group {
 	struct kobject kobj;
 	struct kobject *devices_kobj;
@@ -327,6 +330,32 @@ static int __init iommu_dma_setup(char *str)
 }
 early_param("iommu.strict", iommu_dma_setup);
 
+static int __init iommu_nonstrict_filter_setup(char *str)
+{
+	strlcpy(nonstrict_device, str, DEVICE_NAME_LEN);
+	return 1;
+}
+__setup("iommu.nonstrict_device=", iommu_nonstrict_filter_setup);
+
+static bool iommu_nonstrict_device(struct device *dev)
+{
+	char *filter, *device;
+
+	if (!dev)
+		return false;
+
+	filter = kstrdup(nonstrict_device, GFP_KERNEL);
+	if (!filter)
+		return false;
+
+	while ((device = strsep(&filter, ","))) {
+		if (!strcmp(device, dev_name(dev)))
+			return true;
+	}
+
+	return false;
+}
+
 static ssize_t iommu_group_attr_show(struct kobject *kobj,
 				     struct attribute *__attr, char *buf)
 {
@@ -1470,7 +1499,7 @@ static int iommu_get_def_domain_type(struct device *dev)
 
 static int iommu_group_alloc_default_domain(struct bus_type *bus,
 					    struct iommu_group *group,
-					    unsigned int type)
+					    unsigned int type, struct device *dev)
 {
 	struct iommu_domain *dom;
 
@@ -1489,7 +1518,7 @@ static int iommu_group_alloc_default_domain(struct bus_type *bus,
 	if (!group->domain)
 		group->domain = dom;
 
-	if (!iommu_dma_strict) {
+	if (!iommu_dma_strict || iommu_nonstrict_device(dev)) {
 		int attr = 1;
 		iommu_domain_set_attr(dom,
 				      DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
@@ -1509,7 +1538,7 @@ static int iommu_alloc_default_domain(struct iommu_group *group,
 
 	type = iommu_get_def_domain_type(dev);
 
-	return iommu_group_alloc_default_domain(dev->bus, group, type);
+	return iommu_group_alloc_default_domain(dev->bus, group, type, dev);
 }
 
 /**
@@ -1684,7 +1713,7 @@ static void probe_alloc_default_domain(struct bus_type *bus,
 	if (!gtype.type)
 		gtype.type = iommu_def_domain_type;
 
-	iommu_group_alloc_default_domain(bus, group, gtype.type);
+	iommu_group_alloc_default_domain(bus, group, gtype.type, NULL);
 
 }
 

base-commit: e46b3c0d011eab9933c183d5b47569db8e377281
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation

