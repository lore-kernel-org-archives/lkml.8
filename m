Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E26FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09B70207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Yum2ASHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgHTFuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:50:04 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38047 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725798AbgHTFuD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:50:03 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597902602; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=oN3lYegcP9MiFhZ66Td4q7OEP1nPHIQuKra0uoHEguc=; b=Yum2ASHOl8xvQW5gOW5dV7AHHViF/QMtFGJF5p7pAt7QWf1V2BMnNL/5Gjhj/9vfEtnD1M9Z
 nY6Yxf3zdJi/Z1nBLvPBF+c7nVPxT8txl6/u4xLLLMIbHjF/oKlwJtsojmt+Z6xt87wPQIuI
 OIyCEm1TKG/Uye2RwQeRppLcbWk=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f3e0f06b8eb275bd5c67421 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 05:49:58
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D512CC433C6; Thu, 20 Aug 2020 05:49:57 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 148DFC43455;
        Thu, 20 Aug 2020 05:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 148DFC43455
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Kim Phillips <kim.phillips@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Tingwei Zhang <tingwei@codeaurora.org>
Subject: [PATCH v9 10/24] coresight: etm4x: allow etm4x to be built as a module
Date:   Thu, 20 Aug 2020 13:47:04 +0800
Message-Id: <20200820054718.20115-11-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200820054718.20115-1-tingwei@codeaurora.org>
References: <20200820054718.20115-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@arm.com>

Allow to build coresight-etm4x as a module, for ease of development.

- Kconfig becomes a tristate, to allow =m
- append -core to source file name to allow module to
  be called coresight-etm4x by the Makefile
- add an etm4_remove function, for module unload
- add a MODULE_DEVICE_TABLE for autoloading on boot
- delay advertising the per-cpu etmdrvdata
- protect etmdrvdata[] by modifying it on relevant CPU

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
Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/Kconfig           |  5 +-
 drivers/hwtracing/coresight/Makefile          |  4 +-
 ...resight-etm4x.c => coresight-etm4x-core.c} | 84 ++++++++++++++-----
 3 files changed, 69 insertions(+), 24 deletions(-)
 rename drivers/hwtracing/coresight/{coresight-etm4x.c => coresight-etm4x-core.c} (96%)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index 8fd9fd139cf3..d6e107bbd30b 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -78,7 +78,7 @@ config CORESIGHT_SOURCE_ETM3X
 	  module will be called coresight-etm3x.
 
 config CORESIGHT_SOURCE_ETM4X
-	bool "CoreSight Embedded Trace Macrocell 4.x driver"
+	tristate "CoreSight Embedded Trace Macrocell 4.x driver"
 	depends on ARM64
 	select CORESIGHT_LINKS_AND_SINKS
 	select PID_IN_CONTEXTIDR
@@ -88,6 +88,9 @@ config CORESIGHT_SOURCE_ETM4X
 	  for instruction level tracing. Depending on the implemented version
 	  data tracing may also be available.
 
+	  To compile this driver as a module, choose M here: the
+	  module will be called coresight-etm4x.
+
 config CORESIGHT_STM
 	tristate "CoreSight System Trace Macrocell driver"
 	depends on (ARM && !(CPU_32v3 || CPU_32v4 || CPU_32v4T)) || ARM64
diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
index d619cfd0abd8..271dc255454f 100644
--- a/drivers/hwtracing/coresight/Makefile
+++ b/drivers/hwtracing/coresight/Makefile
@@ -14,8 +14,8 @@ obj-$(CONFIG_CORESIGHT_LINKS_AND_SINKS) += coresight-funnel.o \
 obj-$(CONFIG_CORESIGHT_SOURCE_ETM3X) += coresight-etm3x.o
 coresight-etm3x-y := coresight-etm3x-core.o coresight-etm-cp14.o \
 					coresight-etm3x-sysfs.o
-obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o \
-					coresight-etm4x-sysfs.o
+obj-$(CONFIG_CORESIGHT_SOURCE_ETM4X) += coresight-etm4x.o
+coresight-etm4x-y := coresight-etm4x-core.o coresight-etm4x-sysfs.o
 obj-$(CONFIG_CORESIGHT_STM) += coresight-stm.o
 obj-$(CONFIG_CORESIGHT_CPU_DEBUG) += coresight-cpu-debug.o
 obj-$(CONFIG_CORESIGHT_CATU) += coresight-catu.o
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
similarity index 96%
rename from drivers/hwtracing/coresight/coresight-etm4x.c
rename to drivers/hwtracing/coresight/coresight-etm4x-core.c
index fddfd93b9a7b..a26f0fd63d5a 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1430,7 +1430,7 @@ static int __init etm4_pm_setup(void)
 	return ret;
 }
 
-static void __init etm4_pm_clear(void)
+static void etm4_pm_clear(void)
 {
 	cpu_pm_unregister_notifier(&etm4_cpu_pm_nb);
 	cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_STARTING);
@@ -1487,25 +1487,20 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!desc.name)
 		return -ENOMEM;
 
-	etmdrvdata[drvdata->cpu] = drvdata;
-
 	if (smp_call_function_single(drvdata->cpu,
 				etm4_init_arch_data,  drvdata, 1))
 		dev_err(dev, "ETM arch init failed\n");
 
-	if (etm4_arch_supported(drvdata->arch) == false) {
-		ret = -EINVAL;
-		goto err_arch_supported;
-	}
+	if (etm4_arch_supported(drvdata->arch) == false)
+		return -EINVAL;
 
 	etm4_init_trace_id(drvdata);
 	etm4_set_default(&drvdata->config);
 
 	pdata = coresight_get_platform_data(dev);
-	if (IS_ERR(pdata)) {
-		ret = PTR_ERR(pdata);
-		goto err_arch_supported;
-	}
+	if (IS_ERR(pdata))
+		return PTR_ERR(pdata);
+
 	adev->dev.platform_data = pdata;
 
 	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
@@ -1515,17 +1510,17 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.dev = dev;
 	desc.groups = coresight_etmv4_groups;
 	drvdata->csdev = coresight_register(&desc);
-	if (IS_ERR(drvdata->csdev)) {
-		ret = PTR_ERR(drvdata->csdev);
-		goto err_arch_supported;
-	}
+	if (IS_ERR(drvdata->csdev))
+		return PTR_ERR(drvdata->csdev);
 
 	ret = etm_perf_symlink(drvdata->csdev, true);
 	if (ret) {
 		coresight_unregister(drvdata->csdev);
-		goto err_arch_supported;
+		return ret;
 	}
 
+	etmdrvdata[drvdata->cpu] = drvdata;
+
 	pm_runtime_put(&adev->dev);
 	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
 		 drvdata->cpu, drvdata->arch >> 4, drvdata->arch & 0xf);
@@ -1536,10 +1531,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	return 0;
-
-err_arch_supported:
-	etmdrvdata[drvdata->cpu] = NULL;
-	return ret;
 }
 
 static struct amba_cs_uci_id uci_id_etm4[] = {
@@ -1551,6 +1542,40 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
 	}
 };
 
+static void __exit clear_etmdrvdata(void *info)
+{
+	int cpu = *(int *)info;
+
+	etmdrvdata[cpu] = NULL;
+}
+
+static int __exit etm4_remove(struct amba_device *adev)
+{
+	struct etmv4_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+
+	etm_perf_symlink(drvdata->csdev, false);
+
+	/*
+	 * Taking hotplug lock here to avoid racing between etm4_remove and
+	 * CPU hotplug call backs.
+	 */
+	cpus_read_lock();
+	/*
+	 * The readers for etmdrvdata[] are CPU hotplug call backs
+	 * and PM notification call backs. Change etmdrvdata[i] on
+	 * CPU i ensures these call backs has consistent view
+	 * inside one call back function.
+	 */
+	if (smp_call_function_single(drvdata->cpu, clear_etmdrvdata, &drvdata->cpu, 1))
+		etmdrvdata[drvdata->cpu] = NULL;
+
+	cpus_read_unlock();
+
+	coresight_unregister(drvdata->csdev);
+
+	return 0;
+}
+
 static const struct amba_id etm4_ids[] = {
 	CS_AMBA_ID(0x000bb95d),			/* Cortex-A53 */
 	CS_AMBA_ID(0x000bb95e),			/* Cortex-A57 */
@@ -1568,12 +1593,16 @@ static const struct amba_id etm4_ids[] = {
 	{},
 };
 
+MODULE_DEVICE_TABLE(amba, etm4_ids);
+
 static struct amba_driver etm4x_driver = {
 	.drv = {
 		.name   = "coresight-etm4x",
+		.owner  = THIS_MODULE,
 		.suppress_bind_attrs = true,
 	},
 	.probe		= etm4_probe,
+	.remove         = etm4_remove,
 	.id_table	= etm4_ids,
 };
 
@@ -1595,4 +1624,17 @@ static int __init etm4x_init(void)
 
 	return ret;
 }
-device_initcall(etm4x_init);
+
+static void __exit etm4x_exit(void)
+{
+	amba_driver_unregister(&etm4x_driver);
+	etm4_pm_clear();
+}
+
+module_init(etm4x_init);
+module_exit(etm4x_exit);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Program Flow Trace v4.x driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

