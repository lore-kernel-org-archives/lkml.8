Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3788AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AAC72076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="i9XKMfqq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgHTFvg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:51:36 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:57742 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgHTFvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:51:33 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597902692; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=pvey7MHCjq/KNSRPv9etNvqEzuuiEJ7zPteHziOq8to=; b=i9XKMfqqcHE05oy1O0St4SskEuDxOGFW+4kCkwgVoQ/yQ0HkMpLp95YJUoUqb0frdgMBq3E1
 hP7f3zP5AF8z0OJvpFE8d7zmSscbkQNTWQXX/xEdzNVPwTPQCAZAWEfEbxKqpIHY3gwOhItz
 n5iPQKR1Ln1Un9T6Xsfy6p8ppOQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5f3e0f2dce76f1f9618a2531 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 05:50:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CDF9AC433AD; Thu, 20 Aug 2020 05:50:36 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 574F0C43449;
        Thu, 20 Aug 2020 05:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 574F0C43449
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
Subject: [PATCH v9 16/24] coresight: cti: add function to register cti associate ops
Date:   Thu, 20 Aug 2020 13:47:10 +0800
Message-Id: <20200820054718.20115-17-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200820054718.20115-1-tingwei@codeaurora.org>
References: <20200820054718.20115-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add static cti_assoc_ops to coresight core driver. Let cti
driver register the add_assoc and remove_assoc call back.
Avoid coresight core driver to depend on cti driver.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cti.c  | 32 ++++++++++++++++++--
 drivers/hwtracing/coresight/coresight-priv.h | 14 ++++-----
 drivers/hwtracing/coresight/coresight.c      | 21 +++++++++++--
 3 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index 3ccc703dc940..1f470c47ba70 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -589,7 +589,6 @@ void cti_add_assoc_to_csdev(struct coresight_device *csdev)
 cti_add_done:
 	mutex_unlock(&ect_mutex);
 }
-EXPORT_SYMBOL_GPL(cti_add_assoc_to_csdev);
 
 /*
  * Removing the associated devices is easier.
@@ -616,7 +615,15 @@ void cti_remove_assoc_from_csdev(struct coresight_device *csdev)
 	}
 	mutex_unlock(&ect_mutex);
 }
-EXPORT_SYMBOL_GPL(cti_remove_assoc_from_csdev);
+
+/*
+ * Operations to add and remove associated CTI.
+ * Register to coresight core driver as call back function.
+ */
+static struct cti_assoc_op cti_assoc_ops = {
+	.add = cti_add_assoc_to_csdev,
+	.remove = cti_remove_assoc_from_csdev
+};
 
 /*
  * Update the cross references where the associated device was found
@@ -972,4 +979,23 @@ static struct amba_driver cti_driver = {
 	.probe		= cti_probe,
 	.id_table	= cti_ids,
 };
-builtin_amba_driver(cti_driver);
+
+static int __init cti_init(void)
+{
+	int ret;
+
+	ret = amba_driver_register(&cti_driver);
+	if (ret)
+		pr_info("Error registering cti driver\n");
+	coresight_set_cti_ops(&cti_assoc_ops);
+	return ret;
+}
+
+static void __exit cti_exit(void)
+{
+	coresight_remove_cti_ops();
+	amba_driver_unregister(&cti_driver);
+}
+
+module_init(cti_init);
+module_exit(cti_exit);
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index dcb8aeb6af62..6cde6cf42554 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -173,15 +173,13 @@ static inline int etm_readl_cp14(u32 off, unsigned int *val) { return 0; }
 static inline int etm_writel_cp14(u32 off, u32 val) { return 0; }
 #endif
 
-#ifdef CONFIG_CORESIGHT_CTI
-extern void cti_add_assoc_to_csdev(struct coresight_device *csdev);
-extern void cti_remove_assoc_from_csdev(struct coresight_device *csdev);
+struct cti_assoc_op {
+	void (*add)(struct coresight_device *csdev);
+	void (*remove)(struct coresight_device *csdev);
+};
 
-#else
-static inline void cti_add_assoc_to_csdev(struct coresight_device *csdev) {}
-static inline void
-cti_remove_assoc_from_csdev(struct coresight_device *csdev) {}
-#endif
+extern void coresight_set_cti_ops(const struct cti_assoc_op *cti_op);
+extern void coresight_remove_cti_ops(void);
 
 /*
  * Macros and inline functions to handle CoreSight UCI data and driver
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index b040d4421f84..c2174fed263b 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -56,6 +56,20 @@ static struct list_head *stm_path;
 const u32 coresight_barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
 EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
 
+static const struct cti_assoc_op *cti_assoc_ops;
+
+void coresight_set_cti_ops(const struct cti_assoc_op *cti_op)
+{
+	cti_assoc_ops = cti_op;
+}
+EXPORT_SYMBOL_GPL(coresight_set_cti_ops);
+
+void coresight_remove_cti_ops(void)
+{
+	cti_assoc_ops = NULL;
+}
+EXPORT_SYMBOL_GPL(coresight_remove_cti_ops);
+
 static int coresight_id_match(struct device *dev, void *data)
 {
 	int trace_id, i_trace_id;
@@ -1240,7 +1254,8 @@ static void coresight_device_release(struct device *dev)
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
-	cti_remove_assoc_from_csdev(csdev);
+	if (cti_assoc_ops && cti_assoc_ops->remove)
+		cti_assoc_ops->remove(csdev);
 	fwnode_handle_put(csdev->dev.fwnode);
 	kfree(csdev->refcnt);
 	kfree(csdev);
@@ -1551,8 +1566,8 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 		ret = coresight_fixup_device_conns(csdev);
 	if (!ret)
 		ret = coresight_fixup_orphan_conns(csdev);
-	if (!ret)
-		cti_add_assoc_to_csdev(csdev);
+	if (!ret && cti_assoc_ops && cti_assoc_ops->add)
+		cti_assoc_ops->add(csdev);
 
 	mutex_unlock(&coresight_mutex);
 	if (ret) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

