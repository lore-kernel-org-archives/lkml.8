Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A86C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 069E52076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:51:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kSs9AFV8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbgHTFvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:51:25 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57742 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727033AbgHTFvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:51:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597902683; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=MVSR5eo3ekzMPEuamuESKWHSSG+RGv5XuMCArPFpmFo=; b=kSs9AFV8/jfAflWpNsjJTQRhISpumjsPQmI2kLKLeiXXCYCF8lZA38DVNGoN5yTEZDDI3RzK
 wyOEVz53DqIazn36wZp2NtfJ9nu2J2ebb2ZS8BNMPht03xX27I3GqzMMH3s/XiO4eQCOCfDy
 NIDKnjUyHS03foTsk6kMwFgUp5U=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f3e0f5ae8bbfbec10d39c63 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 05:51:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7C63BC433AD; Thu, 20 Aug 2020 05:51:21 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 33267C433BA;
        Thu, 20 Aug 2020 05:51:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 33267C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Mian Yousaf Kaukab <ykaukab@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>
Subject: [PATCH v9 22/24] coresight: tmc-etr: add function to register catu ops
Date:   Thu, 20 Aug 2020 13:47:16 +0800
Message-Id: <20200820054718.20115-23-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200820054718.20115-1-tingwei@codeaurora.org>
References: <20200820054718.20115-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mian Yousaf Kaukab <ykaukab@suse.de>

Make etr_catu_buf_ops static. Instead of directly accessing it in
etr_buf_ops[], add a function to let catu driver register the ops at
runtime. Break circular dependency between tmc-etr and catu drivers.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-catu.c  | 22 +++++++++++++++++--
 drivers/hwtracing/coresight/coresight-catu.h  |  2 --
 .../hwtracing/coresight/coresight-tmc-etr.c   | 15 +++++++++++--
 drivers/hwtracing/coresight/coresight-tmc.h   |  3 +++
 4 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 1801804a7762..47696a7d24a7 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -358,7 +358,7 @@ static int catu_alloc_etr_buf(struct tmc_drvdata *tmc_drvdata,
 	return 0;
 }
 
-const struct etr_buf_operations etr_catu_buf_ops = {
+static const struct etr_buf_operations etr_catu_buf_ops = {
 	.alloc = catu_alloc_etr_buf,
 	.free = catu_free_etr_buf,
 	.sync = catu_sync_etr_buf,
@@ -582,4 +582,22 @@ static struct amba_driver catu_driver = {
 	.id_table			= catu_ids,
 };
 
-builtin_amba_driver(catu_driver);
+static int __init catu_init(void)
+{
+	int ret;
+
+	ret = amba_driver_register(&catu_driver);
+	if (ret)
+		pr_info("Error registering catu driver\n");
+	tmc_etr_set_catu_ops(&etr_catu_buf_ops);
+	return ret;
+}
+
+static void __exit catu_exit(void)
+{
+	tmc_etr_remove_catu_ops();
+	amba_driver_unregister(&catu_driver);
+}
+
+module_init(catu_init);
+module_exit(catu_exit);
diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
index 80ceee3c739c..6160c2d75a56 100644
--- a/drivers/hwtracing/coresight/coresight-catu.h
+++ b/drivers/hwtracing/coresight/coresight-catu.h
@@ -108,6 +108,4 @@ static inline bool coresight_is_catu_device(struct coresight_device *csdev)
 	return true;
 }
 
-extern const struct etr_buf_operations etr_catu_buf_ops;
-
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index ad991a37e2d2..714f9e867e5f 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -794,10 +794,21 @@ static inline void tmc_etr_disable_catu(struct tmc_drvdata *drvdata)
 static const struct etr_buf_operations *etr_buf_ops[] = {
 	[ETR_MODE_FLAT] = &etr_flat_buf_ops,
 	[ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
-	[ETR_MODE_CATU] = IS_ENABLED(CONFIG_CORESIGHT_CATU)
-						? &etr_catu_buf_ops : NULL,
+	[ETR_MODE_CATU] = NULL,
 };
 
+void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu)
+{
+	etr_buf_ops[ETR_MODE_CATU] = catu;
+}
+EXPORT_SYMBOL_GPL(tmc_etr_set_catu_ops);
+
+void tmc_etr_remove_catu_ops(void)
+{
+	etr_buf_ops[ETR_MODE_CATU] = NULL;
+}
+EXPORT_SYMBOL_GPL(tmc_etr_remove_catu_ops);
+
 static inline int tmc_etr_mode_alloc_buf(int mode,
 					 struct tmc_drvdata *drvdata,
 					 struct etr_buf *etr_buf, int node,
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 6e8d2dc33d17..b91ec7dde7bc 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -326,4 +326,7 @@ tmc_sg_table_buf_size(struct tmc_sg_table *sg_table)
 
 struct coresight_device *tmc_etr_get_catu_device(struct tmc_drvdata *drvdata);
 
+void tmc_etr_set_catu_ops(const struct etr_buf_operations *catu);
+void tmc_etr_remove_catu_ops(void);
+
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

