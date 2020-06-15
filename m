Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4FAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052832078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbgFOOOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:14:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:34462 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730376AbgFOOOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:14:12 -0400
IronPort-SDR: ZhMeLxp1hgeMO9KjFnXcAFIldaZeiF4zr3I9jGAvfB/hnE5QILJknExlWeL2eWLv9FDKdsITKv
 Up22DHeJGzKQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 07:14:11 -0700
IronPort-SDR: k9djKIdal2wc37fNT9kpJZemtgrmCA4QyxgkxnDn6gzPMAvwtLneky8PNYPxMOhpNU4ik10y37
 TMbIURV0luTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="476029220"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2020 07:14:11 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCH 3/4] firmware: stratix10-rsu: extend rsu driver for new features
Date:   Mon, 15 Jun 2020 09:29:07 -0500
Message-Id: <1592231348-31334-4-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592231348-31334-1-git-send-email-richard.gong@linux.intel.com>
References: <1592231348-31334-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Extend Intel Remote System Update (RSU) driver to get decision
configuration management firmware (DCMF) versions and max retry
parameter value.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 drivers/firmware/stratix10-rsu.c | 166 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 161 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index 469b8f7..9378075 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -20,10 +20,16 @@
 #define RSU_VERSION_MASK		GENMASK_ULL(63, 32)
 #define RSU_ERROR_LOCATION_MASK		GENMASK_ULL(31, 0)
 #define RSU_ERROR_DETAIL_MASK		GENMASK_ULL(63, 32)
+#define RSU_DCMF0_MASK			GENMASK_ULL(31, 0)
+#define RSU_DCMF1_MASK			GENMASK_ULL(63, 32)
+#define RSU_DCMF2_MASK			GENMASK_ULL(31, 0)
+#define RSU_DCMF3_MASK			GENMASK_ULL(63, 32)
 
 #define RSU_TIMEOUT	(msecs_to_jiffies(SVC_RSU_REQUEST_TIMEOUT_MS))
 
-#define INVALID_RETRY_COUNTER		0xFFFFFFFF
+#define INVALID_RETRY_COUNTER		0xFF
+#define INVALID_DCMF_VERSION		0xFF
+
 
 typedef void (*rsu_callback)(struct stratix10_svc_client *client,
 			     struct stratix10_svc_cb_data *data);
@@ -35,11 +41,16 @@ typedef void (*rsu_callback)(struct stratix10_svc_client *client,
  * @lock: a mutex to protect callback completion state
  * @status.current_image: address of image currently running in flash
  * @status.fail_image: address of failed image in flash
- * @status.version: the version number of RSU firmware
+ * @status.version: the interface version number of RSU firmware
  * @status.state: the state of RSU system
  * @status.error_details: error code
  * @status.error_location: the error offset inside the image that failed
+ * @dcmf_version.dcmf0: Quartus dcmf0 version
+ * @dcmf_version.dcmf1: Quartus dcmf1 version
+ * @dcmf_version.dcmf2: Quartus dcmf2 version
+ * @dcmf_version.dcmf3: Quartus dcmf3 version
  * @retry_counter: the current image's retry counter
+ * @max_retry: the preset max retry value
  */
 struct stratix10_rsu_priv {
 	struct stratix10_svc_chan *chan;
@@ -54,7 +65,16 @@ struct stratix10_rsu_priv {
 		unsigned int error_details;
 		unsigned int error_location;
 	} status;
+
+	struct {
+		unsigned int dcmf0;
+		unsigned int dcmf1;
+		unsigned int dcmf2;
+		unsigned int dcmf3;
+	} dcmf_version;
+
 	unsigned int retry_counter;
+	unsigned int max_retry;
 };
 
 /**
@@ -109,7 +129,7 @@ static void rsu_command_callback(struct stratix10_svc_client *client,
 	struct stratix10_rsu_priv *priv = client->priv;
 
 	if (data->status == BIT(SVC_STATUS_NO_SUPPORT))
-		dev_warn(client->dev, "Secure FW doesn't support notify\n");
+		dev_warn(client->dev, "FW doesn't support notify\n");
 	else if (data->status == BIT(SVC_STATUS_ERROR))
 		dev_err(client->dev, "Failure, returned status is %lu\n",
 			BIT(data->status));
@@ -119,7 +139,7 @@ static void rsu_command_callback(struct stratix10_svc_client *client,
 
 /**
  * rsu_retry_callback() - Callback from Intel service layer for getting
- * the current image's retry counter from firmware
+ * the current image's retry counter from the firmware
  * @client: pointer to client
  * @data: pointer to callback data structure
  *
@@ -136,7 +156,7 @@ static void rsu_retry_callback(struct stratix10_svc_client *client,
 	if (data->status == BIT(SVC_STATUS_OK))
 		priv->retry_counter = *counter;
 	else if (data->status == BIT(SVC_STATUS_NO_SUPPORT))
-		dev_warn(client->dev, "Secure FW doesn't support retry\n");
+		dev_warn(client->dev, "FW doesn't support retry\n");
 	else
 		dev_err(client->dev, "Failed to get retry counter %lu\n",
 			BIT(data->status));
@@ -145,6 +165,57 @@ static void rsu_retry_callback(struct stratix10_svc_client *client,
 }
 
 /**
+ * rsu_max_retry_callback() - Callback from Intel service layer for getting
+ * the max retry value from the firmware
+ * @client: pointer to client
+ * @data: pointer to callback data structure
+ *
+ * Callback from Intel service layer for max retry.
+ */
+static void rsu_max_retry_callback(struct stratix10_svc_client *client,
+				   struct stratix10_svc_cb_data *data)
+{
+	struct stratix10_rsu_priv *priv = client->priv;
+	unsigned int *max_retry = (unsigned int *)data->kaddr1;
+
+	if (data->status == BIT(SVC_STATUS_OK))
+		priv->max_retry = *max_retry;
+	else if (data->status == BIT(SVC_STATUS_NO_SUPPORT))
+		dev_warn(client->dev, "FW doesn't support max retry\n");
+	else
+		dev_err(client->dev, "Failed to get max retry %lu\n",
+			BIT(data->status));
+
+	complete(&priv->completion);
+}
+
+/**
+ * rsu_dcmf_version_callback() - Callback from Intel service layer for getting
+ * the DCMF version
+ * @client: pointer to client
+ * @data: pointer to callback data structure
+ *
+ * Callback from Intel service layer for DCMF version number
+ */
+static void rsu_dcmf_version_callback(struct stratix10_svc_client *client,
+				      struct stratix10_svc_cb_data *data)
+{
+	struct stratix10_rsu_priv *priv = client->priv;
+	unsigned long long *value1 = (unsigned long long *)data->kaddr1;
+	unsigned long long *value2 = (unsigned long long *)data->kaddr2;
+
+	if (data->status == BIT(SVC_STATUS_OK)) {
+		priv->dcmf_version.dcmf0 = FIELD_GET(RSU_DCMF0_MASK, *value1);
+		priv->dcmf_version.dcmf1 = FIELD_GET(RSU_DCMF1_MASK, *value1);
+		priv->dcmf_version.dcmf2 = FIELD_GET(RSU_DCMF2_MASK, *value2);
+		priv->dcmf_version.dcmf3 = FIELD_GET(RSU_DCMF3_MASK, *value2);
+	} else
+		dev_err(client->dev, "failed to get DCMF version\n");
+
+	complete(&priv->completion);
+}
+
+/**
  * rsu_send_msg() - send a message to Intel service layer
  * @priv: pointer to rsu private data
  * @command: RSU status or update command
@@ -282,6 +353,61 @@ static ssize_t retry_counter_show(struct device *dev,
 	return sprintf(buf, "0x%08x\n", priv->retry_counter);
 }
 
+static ssize_t max_retry_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	return sprintf(buf, "0x%08x\n", priv->max_retry);
+}
+
+static ssize_t dcmf0_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	return sprintf(buf, "0x%08x\n", priv->dcmf_version.dcmf0);
+}
+
+static ssize_t dcmf1_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	return sprintf(buf, "0x%08x\n", priv->dcmf_version.dcmf1);
+}
+
+static ssize_t dcmf2_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	return sprintf(buf, "0x%08x\n", priv->dcmf_version.dcmf2);
+}
+
+static ssize_t dcmf3_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct stratix10_rsu_priv *priv = dev_get_drvdata(dev);
+
+	if (!priv)
+		return -ENODEV;
+
+	return sprintf(buf, "0x%08x\n", priv->dcmf_version.dcmf3);
+}
+
 static ssize_t reboot_image_store(struct device *dev,
 				  struct device_attribute *attr,
 				  const char *buf, size_t count)
@@ -353,6 +479,11 @@ static DEVICE_ATTR_RO(version);
 static DEVICE_ATTR_RO(error_location);
 static DEVICE_ATTR_RO(error_details);
 static DEVICE_ATTR_RO(retry_counter);
+static DEVICE_ATTR_RO(max_retry);
+static DEVICE_ATTR_RO(dcmf0);
+static DEVICE_ATTR_RO(dcmf1);
+static DEVICE_ATTR_RO(dcmf2);
+static DEVICE_ATTR_RO(dcmf3);
 static DEVICE_ATTR_WO(reboot_image);
 static DEVICE_ATTR_WO(notify);
 
@@ -364,6 +495,11 @@ static struct attribute *rsu_attrs[] = {
 	&dev_attr_error_location.attr,
 	&dev_attr_error_details.attr,
 	&dev_attr_retry_counter.attr,
+	&dev_attr_max_retry.attr,
+	&dev_attr_dcmf0.attr,
+	&dev_attr_dcmf1.attr,
+	&dev_attr_dcmf2.attr,
+	&dev_attr_dcmf3.attr,
 	&dev_attr_reboot_image.attr,
 	&dev_attr_notify.attr,
 	NULL
@@ -391,6 +527,11 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
 	priv->status.version = 0;
 	priv->status.state = 0;
 	priv->retry_counter = INVALID_RETRY_COUNTER;
+	priv->dcmf_version.dcmf0 = INVALID_DCMF_VERSION;
+	priv->dcmf_version.dcmf1 = INVALID_DCMF_VERSION;
+	priv->dcmf_version.dcmf2 = INVALID_DCMF_VERSION;
+	priv->dcmf_version.dcmf3 = INVALID_DCMF_VERSION;
+	priv->max_retry = INVALID_RETRY_COUNTER;
 
 	mutex_init(&priv->lock);
 	priv->chan = stratix10_svc_request_channel_byname(&priv->client,
@@ -412,12 +553,27 @@ static int stratix10_rsu_probe(struct platform_device *pdev)
 		stratix10_svc_free_channel(priv->chan);
 	}
 
+	/* get DCMF version from firmware */
+	ret = rsu_send_msg(priv, COMMAND_RSU_DCMF_VERSION,
+			   0, rsu_dcmf_version_callback);
+	if (ret) {
+		dev_err(dev, "Error, getting DCMF version %i\n", ret);
+		stratix10_svc_free_channel(priv->chan);
+	}
+
 	ret = rsu_send_msg(priv, COMMAND_RSU_RETRY, 0, rsu_retry_callback);
 	if (ret) {
 		dev_err(dev, "Error, getting RSU retry %i\n", ret);
 		stratix10_svc_free_channel(priv->chan);
 	}
 
+	ret = rsu_send_msg(priv, COMMAND_RSU_MAX_RETRY, 0,
+			   rsu_max_retry_callback);
+	if (ret) {
+		dev_err(dev, "Error, getting RSU max retry %i\n", ret);
+		stratix10_svc_free_channel(priv->chan);
+	}
+
 	return ret;
 }
 
-- 
2.7.4

