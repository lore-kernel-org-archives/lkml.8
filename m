Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4600DC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 03:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12A852076E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 03:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="qJTrWSMY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbgHUDtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 23:49:16 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:30017 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727074AbgHUDtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 23:49:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597981751; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=G3NWJhcpshmxUsxuxtiTW00PrgrSba6krKqUHoDt/6Q=; b=qJTrWSMYj6uv80C8RdIYzzNwW/XYyy195aB+rIqNRXbiQBioGq05VNlexvceQx3v6aSLvZRM
 AhukVWS2XcAdntg5OMqXTtDFywL1NnxBmjNkUsPVKWWIsioGVXkuWvWa0+GBVQiVSc1Gi1Ys
 tyBaBTOAkzAMzygC+8Wlak9CdcQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f3f442f949572eafb145db3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 Aug 2020 03:49:03
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9D974C433AF; Fri, 21 Aug 2020 03:49:02 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8C301C433CB;
        Fri, 21 Aug 2020 03:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8C301C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 21/24] coresight: cti: allow cti to be built as a module
Date:   Fri, 21 Aug 2020 11:44:42 +0800
Message-Id: <20200821034445.967-22-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200821034445.967-1-tingwei@codeaurora.org>
References: <20200821034445.967-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to build coresight-cti as a module, for ease of development.

- Kconfig becomes a tristate, to allow =m
- append -core to source file name to allow module to
  be called coresight-cti by the Makefile
- add an cti_remove function, for module unload
- move cti_remove_conn_xrefs to cti_remove
- add a MODULE_DEVICE_TABLE for autoloading on boot

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig           |  5 ++++-
 drivers/hwtracing/coresight/Makefile          |  4 ++--
 .../{coresight-cti.c => coresight-cti-core.c} | 20 ++++++++++++++++++-
 .../hwtracing/coresight/coresight-platform.c  |  1 +
 drivers/hwtracing/coresight/coresight.c       |  1 +
 5 files changed, 27 insertions(+), 4 deletions(-)
 rename drivers/hwtracing/coresight/{coresight-cti.c => coresight-cti-core.c} (98%)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index f31778dd0b5d..b04aae2ceecc 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -136,7 +136,7 @@ config CORESIGHT_CPU_DEBUG
 	  module will be called coresight-cpu-debug.
 
 config CORESIGHT_CTI
-	bool "CoreSight Cross Trigger Interface (CTI) driver"
+	tristate "CoreSight Cross Trigger Interface (CTI) driver"
 	depends on ARM || ARM64
 	help
 	  This driver provides support for CoreSight CTI and CTM components.
@@ -147,6 +147,9 @@ config CORESIGHT_CTI
 	  halt compared to disabling sources and sinks normally in driver
 	  software.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight-cti.
+
 config CORESIGHT_CTI_INTEGRATION_REGS
 	bool "Access CTI CoreSight Integration Registers"
 	depends on CORESIGHT_CTI
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index f2a568b969c4..0359d5a1588f 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -19,6 +19,6 @@ coresight-etm4x-y := coresight-etm4x-core.o coresight-etm4x-sysfs.o
 obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
 obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
 obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
-obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o \
-				coresight-cti-platform.o \
+obj-$(CONFIG_CORESIGHT_CTI) += coresight-cti.o
+coresight-cti-y := coresight-cti-core.o	coresight-cti-platform.o \
 				coresight-cti-sysfs.o
diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti-core.c
similarity index 98%
rename from drivers/hwtracing/coresight/coresight-cti.c
rename to drivers/hwtracing/coresight/coresight-cti-core.c
index ec286d617b73..d6d5419ec21c 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti-core.c
@@ -838,7 +838,6 @@ static void cti_device_release(struct device *dev)
 	struct cti_drvdata *ect_item, *ect_tmp;
 
 	mutex_lock(&ect_mutex);
-	cti_remove_conn_xrefs(drvdata);
 	cti_pm_release(drvdata);
 
 	/* remove from the list */
@@ -853,6 +852,18 @@ static void cti_device_release(struct device *dev)
 	if (drvdata->csdev_release)
 		drvdata->csdev_release(dev);
 }
+static int __exit cti_remove(struct amba_device *adev)
+{
+	struct cti_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	mutex_lock(&ect_mutex);
+	cti_remove_conn_xrefs(drvdata);
+	mutex_unlock(&ect_mutex);
+
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
 
 static int cti_probe(struct amba_device *adev, const struct amba_id *id)
 {
@@ -973,6 +984,8 @@ static const struct amba_id cti_ids[] = {
 	{ 0, 0},
 };
 
+MODULE_DEVICE_TABLE(amba, cti_ids);
+
 static struct amba_driver cti_driver = {
 	.drv = {
 		.name	= "coresight-cti",
@@ -980,6 +993,7 @@ static struct amba_driver cti_driver = {
 		.suppress_bind_attrs = true,
 	},
 	.probe		= cti_probe,
+	.remove		= cti_remove,
 	.id_table	= cti_ids,
 };
 
@@ -1002,3 +1016,7 @@ static void __exit cti_exit(void)
 
 module_init(cti_init);
 module_exit(cti_exit);
+
+MODULE_AUTHOR("Mike Leach <mike.leach@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight CTI Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 227e234a2470..3629b7885aca 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -75,6 +75,7 @@ coresight_find_csdev_by_fwnode(struct fwnode_handle *r_fwnode)
 	}
 	return csdev;
 }
+EXPORT_SYMBOL_GPL(coresight_find_csdev_by_fwnode);
 
 #ifdef CONFIG_OF
 static inline bool of_coresight_legacy_ep_is_input(struct device_node *ep)
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index 6c9f6930b8b8..668963b4b7d4 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -288,6 +288,7 @@ void coresight_set_assoc_ectdev_mutex(struct coresight_device *csdev,
 	csdev->ect_dev = ect_csdev;
 	mutex_unlock(&coresight_mutex);
 }
+EXPORT_SYMBOL_GPL(coresight_set_assoc_ectdev_mutex);
 
 static int coresight_enable_sink(struct coresight_device *csdev,
 				 u32 mode, void *data)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

