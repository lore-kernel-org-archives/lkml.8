Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75A6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C049A2076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="BMqrtfJe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHTFvw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:51:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38047 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgHTFvs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:51:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597902707; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=8rbtmpEouJenSJA2EpxoBAY5IfGcZIzNBKVktZgupcg=; b=BMqrtfJe09QjsvqhJFhrSUPvfTP6IdYg7Od9KTpO5znfRSdenwCJWfJttj2qrOhXhGROjjcr
 6kFlJ5cisUdsjZ3W2iDN/d/foe6DLpVUjTnhsieh9cFmnvqV+0smSbj8K2pcSywvo8SZfDns
 7vtYzdJO4hJ3U39wIjzz/iEp/kA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f3e0f6ac3a55812b1d25b81 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 05:51:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 24BEEC4339C; Thu, 20 Aug 2020 05:51:38 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D8476C43395;
        Thu, 20 Aug 2020 05:51:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D8476C43395
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
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>
Subject: [PATCH v9 24/24] coresight: allow the coresight core driver to be built as a module
Date:   Thu, 20 Aug 2020 13:47:18 +0800
Message-Id: <20200820054718.20115-25-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200820054718.20115-1-tingwei@codeaurora.org>
References: <20200820054718.20115-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enhance coresight developer's efficiency to debug coresight drivers.
- Kconfig becomes a tristate, to allow =m
- append -core to source file name to allow module to
  be called coresight by the Makefile
- modules can have only one init/exit, so we add the etm_perf
  register/unregister function calls to the core init/exit
  functions.
- add a MODULE_DEVICE_TABLE for autoloading on boot

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig           |  5 ++-
 drivers/hwtracing/coresight/Makefile          |  5 ++-
 .../{coresight.c => coresight-core.c}         | 42 ++++++++++++++-----
 .../hwtracing/coresight/coresight-etm-perf.c  |  8 +++-
 .../hwtracing/coresight/coresight-etm-perf.h  |  3 ++
 5 files changed, 48 insertions(+), 15 deletions(-)
 rename drivers/hwtracing/coresight/{coresight.c => coresight-core.c} (98%)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index dfe407cde262..c1198245461d 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -3,7 +3,7 @@
 # Coresight configuration
 #
 menuconfig CORESIGHT
-	bool "CoreSight Tracing Support"
+	tristate "CoreSight Tracing Support"
 	depends on ARM || ARM64
 	depends on OF || ACPI
 	select ARM_AMBA
@@ -15,6 +15,9 @@ menuconfig CORESIGHT
 	  specification and configure the right series of components when a
 	  trace source gets enabled.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight.
+
 if CORESIGHT
 config CORESIGHT_LINKS_AND_SINKS
 	tristate "CoreSight Link and Sink drivers"
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index 0359d5a1588f..1b35b55bd420 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -2,8 +2,9 @@
 #
 # Makefile for CoreSight drivers.
 #
-obj-$(CONFIG_CORESIGHT) += coresight.o coresight-etm-perf.o \
-			   coresight-platform.o coresight-sysfs.o
+obj-$(CONFIG_CORESIGHT) += coresight.o
+coresight-y := coresight-core.o  coresight-etm-perf.o coresight-platform.o \
+		coresight-sysfs.o
 obj-$(CONFIG_CORESIGHT_LINK_AND_SINK_TMC) += coresight-tmc.o
 coresight-tmc-y := coresight-tmc-core.o coresight-tmc-etf.o \
 		      coresight-tmc-etr.o
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight-core.c
similarity index 98%
rename from drivers/hwtracing/coresight/coresight.c
rename to drivers/hwtracing/coresight/coresight-core.c
index 668963b4b7d4..bf6edf468963 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1460,16 +1460,6 @@ int coresight_timeout(void __iomem *addr, u32 offset, int position, int value)
 }
 EXPORT_SYMBOL_GPL(coresight_timeout);
 
-struct bus_type coresight_bustype = {
-	.name	= "coresight",
-};
-
-static int __init coresight_init(void)
-{
-	return bus_register(&coresight_bustype);
-}
-postcore_initcall(coresight_init);
-
 /*
  * coresight_release_platform_data: Release references to the devices connected
  * to the output port of this device.
@@ -1678,3 +1668,35 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
 	return name;
 }
 EXPORT_SYMBOL_GPL(coresight_alloc_device_name);
+
+struct bus_type coresight_bustype = {
+	.name	= "coresight",
+};
+
+static int __init coresight_init(void)
+{
+	int ret;
+
+	ret = bus_register(&coresight_bustype);
+	if (ret)
+		return ret;
+
+	ret = etm_perf_init();
+	if (ret)
+		bus_unregister(&coresight_bustype);
+
+	return ret;
+}
+
+static void __exit coresight_exit(void)
+{
+	etm_perf_exit();
+	bus_unregister(&coresight_bustype);
+}
+
+module_init(coresight_init);
+module_exit(coresight_exit);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight tracer driver");
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 3728c44e5763..668b3ff11576 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -591,7 +591,7 @@ void etm_perf_del_symlink_sink(struct coresight_device *csdev)
 	csdev->ea = NULL;
 }
 
-static int __init etm_perf_init(void)
+int __init etm_perf_init(void)
 {
 	int ret;
 
@@ -618,4 +618,8 @@ static int __init etm_perf_init(void)
 
 	return ret;
 }
-device_initcall(etm_perf_init);
+
+void __exit etm_perf_exit(void)
+{
+	perf_pmu_unregister(&etm_pmu);
+}
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 05f89723e282..3e4f2ad5e193 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -82,4 +82,7 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 
 #endif /* CONFIG_CORESIGHT */
 
+int __init etm_perf_init(void);
+void __exit etm_perf_exit(void);
+
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

