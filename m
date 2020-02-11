Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7A0C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F96920661
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 17:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="sv8UbfiS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgBKRmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 12:42:43 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:61137 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729747AbgBKRmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 12:42:42 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01BHMX3v016895;
        Tue, 11 Feb 2020 18:42:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=FOURmepguUFywQ96NPfIBh3aOlft9LMLpvCDJzli+qg=;
 b=sv8UbfiSsn8RVJaJjqj5hLGfh5K9LyQGXMysp5aonePCwCAmdvz3sVZZpODjILEhK78o
 f2JlDbHVaLJqwJz8jcO29cIX+aSJ75iipcyjb+NIrE6AWfRJzZXeVdqvUiIx6kEEW6wT
 1yd7yGISoCBbk/RxXj0Fjqfd1jlfL0/8Mz/NYicnYGB9d1PJzHjZC8tb1o+u7hwl6SxX
 xR1MmV7LvyYzAwachOLT0ZCECqK+eOr8UGsTZuoRB2BQdi+uZ3+1BhCHobwcAEZtHo8r
 uqk1xD/M4odkfSPlN893dGsQ1oO7Yqw2JYpPV0fCy8Yc8TQBORClHgNaoniHtyVs9iN8 jA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2y1urh7j1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Feb 2020 18:42:29 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 632B310002A;
        Tue, 11 Feb 2020 18:42:28 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4D21F2C8E8C;
        Tue, 11 Feb 2020 18:42:28 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG3NODE1.st.com (10.75.127.7)
 with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 11 Feb 2020 18:42:27
 +0100
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        <arnaud.pouliquen@st.com>, Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: [PATCH v5 1/3] remoteproc: add support for co-processor loaded and booted before kernel
Date:   Tue, 11 Feb 2020 18:42:03 +0100
Message-ID: <20200211174205.22247-2-arnaud.pouliquen@st.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200211174205.22247-1-arnaud.pouliquen@st.com>
References: <20200211174205.22247-1-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-02-11_05:2020-02-10,2020-02-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Pallardy <loic.pallardy@st.com>

Remote processor could boot independently or be loaded/started before
Linux kernel by bootloader or any firmware.
This patch introduces a new property in rproc core, named skip_fw_load,
to be able to allocate resources and sub-devices like vdev and to
synchronize with current state without loading firmware from file system.
It is platform driver responsibility to implement the right firmware
load ops according to HW specificities.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 drivers/remoteproc/remoteproc_core.c | 67 ++++++++++++++++++++++------
 include/linux/remoteproc.h           |  2 +
 2 files changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 097f33e4f1f3..876b5420a32b 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1358,8 +1358,19 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
 	return ret;
 }
 
-/*
- * take a firmware and boot a remote processor with it.
+/**
+ * rproc_fw_boot() - boot specified remote processor according to specified
+ * firmware
+ * @rproc: handle of a remote processor
+ * @fw: pointer on firmware to handle
+ *
+ * Handle resources defined in resource table, load firmware and
+ * start remote processor.
+ *
+ * If firmware pointer fw is NULL, firmware is not handled by remoteproc
+ * core, but under the responsibility of platform driver.
+ *
+ * Returns 0 on success, and an appropriate error value otherwise.
  */
 static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 {
@@ -1371,7 +1382,11 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	if (ret)
 		return ret;
 
-	dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
+	if (fw)
+		dev_info(dev, "Booting fw image %s, size %zd\n", name,
+			 fw->size);
+	else
+		dev_info(dev, "Synchronizing with preloaded co-processor\n");
 
 	/*
 	 * if enabling an IOMMU isn't relevant for this rproc, this is
@@ -1718,16 +1733,22 @@ static void rproc_crash_handler_work(struct work_struct *work)
  * rproc_boot() - boot a remote processor
  * @rproc: handle of a remote processor
  *
- * Boot a remote processor (i.e. load its firmware, power it on, ...).
+ * Boot a remote processor (i.e. load its firmware, power it on, ...) from
+ * different contexts:
+ * - power off
+ * - preloaded firmware
+ * - started before kernel execution
+ * The different operations are selected thanks to properties defined by
+ * platform driver.
  *
- * If the remote processor is already powered on, this function immediately
- * returns (successfully).
+ * If the remote processor is already powered on at rproc level, this function
+ * immediately returns (successfully).
  *
  * Returns 0 on success, and an appropriate error value otherwise.
  */
 int rproc_boot(struct rproc *rproc)
 {
-	const struct firmware *firmware_p;
+	const struct firmware *firmware_p = NULL;
 	struct device *dev;
 	int ret;
 
@@ -1758,11 +1779,20 @@ int rproc_boot(struct rproc *rproc)
 
 	dev_info(dev, "powering up %s\n", rproc->name);
 
-	/* load firmware */
-	ret = request_firmware(&firmware_p, rproc->firmware, dev);
-	if (ret < 0) {
-		dev_err(dev, "request_firmware failed: %d\n", ret);
-		goto downref_rproc;
+	if (!rproc->skip_fw_load) {
+		/* load firmware */
+		ret = request_firmware(&firmware_p, rproc->firmware, dev);
+		if (ret < 0) {
+			dev_err(dev, "request_firmware failed: %d\n", ret);
+			goto downref_rproc;
+		}
+	} else {
+		/*
+		 * Set firmware name pointer to null as remoteproc core is not
+		 * in charge of firmware loading
+		 */
+		kfree(rproc->firmware);
+		rproc->firmware = NULL;
 	}
 
 	ret = rproc_fw_boot(rproc, firmware_p);
@@ -1916,8 +1946,17 @@ int rproc_add(struct rproc *rproc)
 	/* create debugfs entries */
 	rproc_create_debug_dir(rproc);
 
-	/* if rproc is marked always-on, request it to boot */
-	if (rproc->auto_boot) {
+	if (rproc->skip_fw_load) {
+		/*
+		 * If rproc is marked already booted, no need to wait
+		 * for firmware.
+		 * Just handle associated resources and start sub devices
+		 */
+		ret = rproc_boot(rproc);
+		if (ret < 0)
+			return ret;
+	} else if (rproc->auto_boot) {
+		/* if rproc is marked always-on, request it to boot */
 		ret = rproc_trigger_auto_boot(rproc);
 		if (ret < 0)
 			return ret;
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 16ad66683ad0..4fd5bedab4fa 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -479,6 +479,7 @@ struct rproc_dump_segment {
  * @table_sz: size of @cached_table
  * @has_iommu: flag to indicate if remote processor is behind an MMU
  * @auto_boot: flag to indicate if remote processor should be auto-started
+ * @skip_fw_load: remote processor has been preloaded before start sequence
  * @dump_segments: list of segments in the firmware
  * @nb_vdev: number of vdev currently handled by rproc
  */
@@ -512,6 +513,7 @@ struct rproc {
 	size_t table_sz;
 	bool has_iommu;
 	bool auto_boot;
+	bool skip_fw_load;
 	struct list_head dump_segments;
 	int nb_vdev;
 };
-- 
2.17.1

