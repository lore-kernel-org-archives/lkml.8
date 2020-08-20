Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A664C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FE672076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ci0/LU6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgHTFuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:50:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38047 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726752AbgHTFuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:50:32 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597902631; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=WM/BsbfLMGkoy8QU7+MrQG4X+TVPXDcUJnO5tlPi144=; b=ci0/LU6yzl2WTATFHOx5ZucWlwAro11a6rcH/E7KUBs8ddnvL2tuVDAX8nxeRki21htazUyN
 u6UKrlNvG9BWAopzGIJCLcxJcDgi0PwcAdI3qQA/UXYMXk5cKAGtyDmnVwpEtj5UqWL10+so
 154dWJBGRlDVT/5kbRQS+9iL3Sc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5f3e0f27f729de1078a3cb4b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 05:50:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ABA77C433AF; Thu, 20 Aug 2020 05:50:30 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A54F2C433BA;
        Thu, 20 Aug 2020 05:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A54F2C433BA
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
Subject: [PATCH v9 15/24] coresight: allow replicator driver to be built as module
Date:   Thu, 20 Aug 2020 13:47:09 +0800
Message-Id: <20200820054718.20115-16-tingwei@codeaurora.org>
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

Allow to build coresight-replicator as modules, for ease of development.

- Kconfig becomes a tristate, to allow =m
- combine static and dynamic replicator init into single
  module_init/exit call
- add replicator_remove functions, for module unload
- add a MODULE_DEVICE_TABLE for autoloading on boot

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@armlinux.org.uk>
Co-developed-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Signed-off-by: Kim Phillips <kim.phillips@arm.com>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/Kconfig           |  5 +-
 .../coresight/coresight-replicator.c          | 65 ++++++++++++++++++-
 2 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
index fc48ae086746..f31778dd0b5d 100644
--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -17,13 +17,16 @@ menuconfig CORESIGHT
 
 if CORESIGHT
 config CORESIGHT_LINKS_AND_SINKS
-	bool "CoreSight Link and Sink drivers"
+	tristate "CoreSight Link and Sink drivers"
 	help
 	  This enables support for CoreSight link and sink drivers that are
 	  responsible for transporting and collecting the trace data
 	  respectively.  Link and sinks are dynamically aggregated with a trace
 	  entity at run time to form a complete trace path.
 
+	  To compile these drivers as modules, choose M here: the
+	  modules will be called coresight-funnel and coresight-replicator.
+
 config CORESIGHT_LINK_AND_SINK_TMC
 	tristate "Coresight generic TMC driver"
 
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 78acf29c49ca..62afdde0e5ea 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -291,6 +291,14 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	return ret;
 }
 
+static int __exit replicator_remove(struct device *dev)
+{
+	struct replicator_drvdata *drvdata = dev_get_drvdata(dev);
+
+	coresight_unregister(drvdata->csdev);
+	return 0;
+}
+
 static int static_replicator_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -310,6 +318,13 @@ static int static_replicator_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int __exit static_replicator_remove(struct platform_device *pdev)
+{
+	replicator_remove(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int replicator_runtime_suspend(struct device *dev)
 {
@@ -343,24 +358,29 @@ static const struct of_device_id static_replicator_match[] = {
 	{}
 };
 
+MODULE_DEVICE_TABLE(of, static_replicator_match);
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id static_replicator_acpi_ids[] = {
 	{"ARMHC985", 0}, /* ARM CoreSight Static Replicator */
 	{}
 };
+
+MODULE_DEVICE_TABLE(acpi, static_replicator_acpi_ids);
 #endif
 
 static struct platform_driver static_replicator_driver = {
 	.probe          = static_replicator_probe,
+	.remove         = static_replicator_remove,
 	.driver         = {
 		.name   = "coresight-static-replicator",
+		.owner	= THIS_MODULE,
 		.of_match_table = of_match_ptr(static_replicator_match),
 		.acpi_match_table = ACPI_PTR(static_replicator_acpi_ids),
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
 };
-builtin_platform_driver(static_replicator_driver);
 
 static int dynamic_replicator_probe(struct amba_device *adev,
 				    const struct amba_id *id)
@@ -368,19 +388,60 @@ static int dynamic_replicator_probe(struct amba_device *adev,
 	return replicator_probe(&adev->dev, &adev->res);
 }
 
+static int __exit dynamic_replicator_remove(struct amba_device *adev)
+{
+	return replicator_remove(&adev->dev);
+}
+
 static const struct amba_id dynamic_replicator_ids[] = {
 	CS_AMBA_ID(0x000bb909),
 	CS_AMBA_ID(0x000bb9ec),		/* Coresight SoC-600 */
 	{},
 };
 
+MODULE_DEVICE_TABLE(amba, dynamic_replicator_ids);
+
 static struct amba_driver dynamic_replicator_driver = {
 	.drv = {
 		.name	= "coresight-dynamic-replicator",
 		.pm	= &replicator_dev_pm_ops,
+		.owner	= THIS_MODULE,
 		.suppress_bind_attrs = true,
 	},
 	.probe		= dynamic_replicator_probe,
+	.remove         = dynamic_replicator_remove,
 	.id_table	= dynamic_replicator_ids,
 };
-builtin_amba_driver(dynamic_replicator_driver);
+
+static int __init replicator_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&static_replicator_driver);
+	if (ret) {
+		pr_info("Error registering platform driver\n");
+		return ret;
+	}
+
+	ret = amba_driver_register(&dynamic_replicator_driver);
+	if (ret) {
+		pr_info("Error registering amba driver\n");
+		platform_driver_unregister(&static_replicator_driver);
+	}
+
+	return ret;
+}
+
+static void __exit replicator_exit(void)
+{
+	platform_driver_unregister(&static_replicator_driver);
+	amba_driver_unregister(&dynamic_replicator_driver);
+}
+
+module_init(replicator_init);
+module_exit(replicator_exit);
+
+MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
+MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
+MODULE_DESCRIPTION("Arm CoreSight Replicator Driver");
+MODULE_LICENSE("GPL v2");
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

