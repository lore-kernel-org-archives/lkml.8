Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A88C54FCF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B117020714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JepYCPNi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbgCXUSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:18:35 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52556 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727747AbgCXUSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:18:34 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02OKIObx089240;
        Tue, 24 Mar 2020 15:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1585081104;
        bh=8qgGwfZnwiU6/Ir3wlJnjMa4hJEnhp9Vr0iuUASMO6M=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JepYCPNiGgj420B1JhpJuS7Ka+IMxnnobyJvzgCmwKWuHJ07sIjjxWsmDo2trprGE
         TiQ3wUGFXu086tg2NZAgpzncMix8DUZsrUQJEpLgIVCzX2OUbVESwBz/Gt2XUUfrnw
         ReQYqC1E75z1pmavpuPrPYhR37TpCCIN5GiQIba8=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02OKINUX110238;
        Tue, 24 Mar 2020 15:18:23 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 24
 Mar 2020 15:18:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 24 Mar 2020 15:18:23 -0500
Received: from fllv0103.dal.design.ti.com (fllv0103.dal.design.ti.com [10.247.120.73])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02OKINTN083843;
        Tue, 24 Mar 2020 15:18:23 -0500
Received: from localhost ([10.250.35.147])
        by fllv0103.dal.design.ti.com (8.14.7/8.14.7) with ESMTP id 02OKIMmN084957;
        Tue, 24 Mar 2020 15:18:23 -0500
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Loic Pallardy <loic.pallardy@st.com>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH 1/7] remoteproc: add prepare and unprepare ops
Date:   Tue, 24 Mar 2020 15:18:13 -0500
Message-ID: <20200324201819.23095-2-s-anna@ti.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200324201819.23095-1-s-anna@ti.com>
References: <20200324201819.23095-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Pallardy <loic.pallardy@st.com>

On some SoC architecture, it is needed to enable HW like
clock, bus, regulator, memory region... before loading
co-processor firmware.

This patch introduces prepare and unprepare ops to execute
platform specific function before firmware loading and after
stop execution.

Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/remoteproc_core.c | 20 +++++++++++++++++++-
 include/linux/remoteproc.h           |  4 ++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 26f6947267d2..aca6d022901a 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -1394,12 +1394,22 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 		return ret;
 	}
 
+	/* Prepare rproc for firmware loading if needed */
+	if (rproc->ops->prepare) {
+		ret = rproc->ops->prepare(rproc);
+		if (ret) {
+			dev_err(dev, "can't prepare rproc %s: %d\n",
+				rproc->name, ret);
+			goto disable_iommu;
+		}
+	}
+
 	rproc->bootaddr = rproc_get_boot_addr(rproc, fw);
 
 	/* Load resource table, core dump segment list etc from the firmware */
 	ret = rproc_parse_fw(rproc, fw);
 	if (ret)
-		goto disable_iommu;
+		goto unprepare_rproc;
 
 	/* reset max_notifyid */
 	rproc->max_notifyid = -1;
@@ -1433,6 +1443,10 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
 	kfree(rproc->cached_table);
 	rproc->cached_table = NULL;
 	rproc->table_ptr = NULL;
+unprepare_rproc:
+	/* release HW resources if needed */
+	if (rproc->ops->unprepare)
+		rproc->ops->unprepare(rproc);
 disable_iommu:
 	rproc_disable_iommu(rproc);
 	return ret;
@@ -1838,6 +1852,10 @@ void rproc_shutdown(struct rproc *rproc)
 	/* clean up all acquired resources */
 	rproc_resource_cleanup(rproc);
 
+	/* release HW resources if needed */
+	if (rproc->ops->unprepare)
+		rproc->ops->unprepare(rproc);
+
 	rproc_disable_iommu(rproc);
 
 	/* Free the copy of the resource table */
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 07bd73a6d72a..ddce7a7775d1 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -355,6 +355,8 @@ enum rsc_handling_status {
 
 /**
  * struct rproc_ops - platform-specific device handlers
+ * @prepare:	prepare device for code loading
+ * @unprepare:	unprepare device after stop
  * @start:	power on the device and boot it
  * @stop:	power off the device
  * @kick:	kick a virtqueue (virtqueue id given as a parameter)
@@ -371,6 +373,8 @@ enum rsc_handling_status {
  * @get_boot_addr:	get boot address to entry point specified in firmware
  */
 struct rproc_ops {
+	int (*prepare)(struct rproc *rproc);
+	int (*unprepare)(struct rproc *rproc);
 	int (*start)(struct rproc *rproc);
 	int (*stop)(struct rproc *rproc);
 	void (*kick)(struct rproc *rproc, int vqid);
-- 
2.23.0

