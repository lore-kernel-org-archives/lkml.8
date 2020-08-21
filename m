Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE86C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 03:45:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7668920658
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 03:45:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wifOF6Zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHUDpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 23:45:44 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:58948 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726975AbgHUDpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 23:45:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597981541; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0JWnrqYnoICZtBZ5ETAhr8dod5Y3jvxCvvbjFVLwcIw=; b=wifOF6Zvaxy3hDHW983ZNguM12Mw/RUn+tnxcPLOH8cLuIRkHGQ6asXOP8bRMFYATrnVl9Qa
 PhTDX3Pv0PZPufV7tI8aKfDhkPNCB5sUsekdp1zIXoeEnfLFY/60WpRCZJDAtMrCZy+ZsoNg
 ZyDH8uVisqG+ym3l/hSlwZy2v8k=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5f3f4364949572eafb139b6b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 21 Aug 2020 03:45:40
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EC1BEC4344A; Fri, 21 Aug 2020 03:45:39 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9406EC433A0;
        Fri, 21 Aug 2020 03:45:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9406EC433A0
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
Subject: [PATCH v10 06/24] coresight: add try_get_module() in coresight_grab_device()
Date:   Fri, 21 Aug 2020 11:44:27 +0800
Message-Id: <20200821034445.967-7-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200821034445.967-1-tingwei@codeaurora.org>
References: <20200821034445.967-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When coresight device is in an active session, driver module of
that device should not be removed. Use try_get_module() in
coresight_grab_device() to prevent module to be unloaded.
Use get_device()/put_device() to protect device data
in the middle of active session.

Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Tested-by: Mike Leach <mike.leach@linaro.org>
Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight.c | 60 ++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index cd17aea6b50d..b040d4421f84 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -633,13 +633,45 @@ struct coresight_device *coresight_get_sink_by_id(u32 id)
 	return dev ? to_coresight_device(dev) : NULL;
 }
 
+/**
+ * coresight_get_ref- Helper function to increase reference count to module
+ * and device.
+ * Return true in successful case and power up the device.
+ * Return false when failed to get reference of module.
+ */
+static inline bool coresight_get_ref(struct coresight_device *csdev)
+{
+	struct device *dev = csdev->dev.parent;
+
+	/* Make sure the driver can't be removed */
+	if (!try_module_get(dev->driver->owner))
+		return false;
+	/* Make sure the device can't go away */
+	get_device(dev);
+	pm_runtime_get_sync(dev);
+	return true;
+}
+
+/**
+ * coresight_put_ref- Helper function to decrease reference count to module
+ * and device. Power off the device.
+ */
+static inline void coresight_put_ref(struct coresight_device *csdev)
+{
+	struct device *dev = csdev->dev.parent;
+
+	pm_runtime_put(dev);
+	put_device(dev);
+	module_put(dev->driver->owner);
+}
+
 /*
  * coresight_grab_device - Power up this device and any of the helper
  * devices connected to it for trace operation. Since the helper devices
  * don't appear on the trace path, they should be handled along with the
  * the master device.
  */
-static void coresight_grab_device(struct coresight_device *csdev)
+static int coresight_grab_device(struct coresight_device *csdev)
 {
 	int i;
 
@@ -648,9 +680,20 @@ static void coresight_grab_device(struct coresight_device *csdev)
 
 		child  = csdev->pdata->conns[i].child_dev;
 		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
-			pm_runtime_get_sync(child->dev.parent);
+			if (!coresight_get_ref(child))
+				goto err;
+	}
+	if (coresight_get_ref(csdev))
+		return 0;
+err:
+	for (i--; i >= 0; i--) {
+		struct coresight_device *child;
+
+		child  = csdev->pdata->conns[i].child_dev;
+		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
+			coresight_put_ref(child);
 	}
-	pm_runtime_get_sync(csdev->dev.parent);
+	return -ENODEV;
 }
 
 /*
@@ -661,13 +704,13 @@ static void coresight_drop_device(struct coresight_device *csdev)
 {
 	int i;
 
-	pm_runtime_put(csdev->dev.parent);
+	coresight_put_ref(csdev);
 	for (i = 0; i < csdev->pdata->nr_outport; i++) {
 		struct coresight_device *child;
 
 		child  = csdev->pdata->conns[i].child_dev;
 		if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
-			pm_runtime_put(child->dev.parent);
+			coresight_put_ref(child);
 	}
 }
 
@@ -686,7 +729,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
 				 struct coresight_device *sink,
 				 struct list_head *path)
 {
-	int i;
+	int i, ret;
 	bool found = false;
 	struct coresight_node *node;
 
@@ -716,11 +759,14 @@ static int _coresight_build_path(struct coresight_device *csdev,
 	 * is tell the PM runtime core we need this element and add a node
 	 * for it.
 	 */
+	ret = coresight_grab_device(csdev);
+	if (ret)
+		return ret;
+
 	node = kzalloc(sizeof(struct coresight_node), GFP_KERNEL);
 	if (!node)
 		return -ENOMEM;
 
-	coresight_grab_device(csdev);
 	node->csdev = csdev;
 	list_add(&node->link, path);
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

