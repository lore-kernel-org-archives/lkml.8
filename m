Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC04C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E1C212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:09:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731264AbgCaQJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:09:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:23356 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730560AbgCaQJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:09:20 -0400
IronPort-SDR: Ocj9S3FdaswyL7x/dwhQQ5fIQSyeCwhcfNcA89kFng0KysmuQ6WDgZc64IRvfpGqpDRjmkBgFJ
 YmCdgRntFPjQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2020 09:09:02 -0700
IronPort-SDR: YhjyYUY1XbDbTS3x1uGNowAx+VvSePdvLNuY11LB1noJy1Za1ybq3szVqbEyPSvn4verxS1UYS
 XkMf9AYmXgxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,328,1580803200"; 
   d="scan'208";a="395549212"
Received: from marshy.an.intel.com ([10.122.105.159])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2020 09:09:01 -0700
From:   richard.gong@linux.intel.com
To:     mdf@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCHv1] firmware: fpga: replace the error codes with the standard ones
Date:   Tue, 31 Mar 2020 11:25:22 -0500
Message-Id: <1585671922-9754-2-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585671922-9754-1-git-send-email-richard.gong@linux.intel.com>
References: <1585671922-9754-1-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

The Intel service layer driver has defined error codes for the
specific services, which started from FPGA configuration then RSU
(Remote Status Update).

Intel service layer driver should define the standard error codes
rather than keep adding more error codes for the new services.

The standard error codes will be used by all the clients of Intel service
layer driver.

Replace FPGA and RSU specific error codes with Intel service layer’s
Common error codes.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 drivers/firmware/stratix10-rsu.c                   | 10 +--
 drivers/firmware/stratix10-svc.c                   | 62 ++++++-------------
 drivers/fpga/stratix10-soc.c                       | 25 +++-----
 include/linux/firmware/intel/stratix10-smc.h       | 49 +++++++--------
 .../linux/firmware/intel/stratix10-svc-client.h    | 71 +++++++++-------------
 5 files changed, 84 insertions(+), 133 deletions(-)

diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
index f853333..4379475 100644
--- a/drivers/firmware/stratix10-rsu.c
+++ b/drivers/firmware/stratix10-rsu.c
@@ -72,7 +72,7 @@ static void rsu_status_callback(struct stratix10_svc_client *client,
 	struct stratix10_rsu_priv *priv = client->priv;
 	struct arm_smccc_res *res = (struct arm_smccc_res *)data->kaddr1;
 
-	if (data->status == BIT(SVC_STATUS_RSU_OK)) {
+	if (data->status == BIT(SVC_STATUS_OK)) {
 		priv->status.version = FIELD_GET(RSU_VERSION_MASK,
 						 res->a2);
 		priv->status.state = FIELD_GET(RSU_STATE_MASK, res->a2);
@@ -108,9 +108,9 @@ static void rsu_command_callback(struct stratix10_svc_client *client,
 {
 	struct stratix10_rsu_priv *priv = client->priv;
 
-	if (data->status == BIT(SVC_STATUS_RSU_NO_SUPPORT))
+	if (data->status == BIT(SVC_STATUS_NO_SUPPORT))
 		dev_warn(client->dev, "Secure FW doesn't support notify\n");
-	else if (data->status == BIT(SVC_STATUS_RSU_ERROR))
+	else if (data->status == BIT(SVC_STATUS_ERROR))
 		dev_err(client->dev, "Failure, returned status is %lu\n",
 			BIT(data->status));
 
@@ -133,9 +133,9 @@ static void rsu_retry_callback(struct stratix10_svc_client *client,
 	struct stratix10_rsu_priv *priv = client->priv;
 	unsigned int *counter = (unsigned int *)data->kaddr1;
 
-	if (data->status == BIT(SVC_STATUS_RSU_OK))
+	if (data->status == BIT(SVC_STATUS_OK))
 		priv->retry_counter = *counter;
-	else if (data->status == BIT(SVC_STATUS_RSU_NO_SUPPORT))
+	else if (data->status == BIT(SVC_STATUS_NO_SUPPORT))
 		dev_warn(client->dev, "Secure FW doesn't support retry\n");
 	else
 		dev_err(client->dev, "Failed to get retry counter %lu\n",
diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index d5f0769..e0db8db 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -214,7 +214,7 @@ static void svc_thread_cmd_data_claim(struct stratix10_svc_controller *ctrl,
 				complete(&ctrl->complete_status);
 				break;
 			}
-			cb_data->status = BIT(SVC_STATUS_RECONFIG_BUFFER_DONE);
+			cb_data->status = BIT(SVC_STATUS_BUFFER_DONE);
 			cb_data->kaddr1 = svc_pa_to_va(res.a1);
 			cb_data->kaddr2 = (res.a2) ?
 					  svc_pa_to_va(res.a2) : NULL;
@@ -227,7 +227,7 @@ static void svc_thread_cmd_data_claim(struct stratix10_svc_controller *ctrl,
 				 __func__);
 		}
 	} while (res.a0 == INTEL_SIP_SMC_STATUS_OK ||
-		 res.a0 == INTEL_SIP_SMC_FPGA_CONFIG_STATUS_BUSY ||
+		 res.a0 == INTEL_SIP_SMC_STATUS_BUSY ||
 		 wait_for_completion_timeout(&ctrl->complete_status, timeout));
 }
 
@@ -250,7 +250,7 @@ static void svc_thread_cmd_config_status(struct stratix10_svc_controller *ctrl,
 	cb_data->kaddr1 = NULL;
 	cb_data->kaddr2 = NULL;
 	cb_data->kaddr3 = NULL;
-	cb_data->status = BIT(SVC_STATUS_RECONFIG_ERROR);
+	cb_data->status = BIT(SVC_STATUS_ERROR);
 
 	pr_debug("%s: polling config status\n", __func__);
 
@@ -259,7 +259,7 @@ static void svc_thread_cmd_config_status(struct stratix10_svc_controller *ctrl,
 		ctrl->invoke_fn(INTEL_SIP_SMC_FPGA_CONFIG_ISDONE,
 				0, 0, 0, 0, 0, 0, 0, &res);
 		if ((res.a0 == INTEL_SIP_SMC_STATUS_OK) ||
-		    (res.a0 == INTEL_SIP_SMC_FPGA_CONFIG_STATUS_ERROR))
+		    (res.a0 == INTEL_SIP_SMC_STATUS_ERROR))
 			break;
 
 		/*
@@ -271,7 +271,7 @@ static void svc_thread_cmd_config_status(struct stratix10_svc_controller *ctrl,
 	}
 
 	if (res.a0 == INTEL_SIP_SMC_STATUS_OK && count_in_sec)
-		cb_data->status = BIT(SVC_STATUS_RECONFIG_COMPLETED);
+		cb_data->status = BIT(SVC_STATUS_COMPLETED);
 
 	p_data->chan->scl->receive_cb(p_data->chan->scl, cb_data);
 }
@@ -294,24 +294,18 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 
 	switch (p_data->command) {
 	case COMMAND_RECONFIG:
-		cb_data->status = BIT(SVC_STATUS_RECONFIG_REQUEST_OK);
+	case COMMAND_RSU_UPDATE:
+	case COMMAND_RSU_NOTIFY:
+		cb_data->status = BIT(SVC_STATUS_OK);
 		break;
 	case COMMAND_RECONFIG_DATA_SUBMIT:
-		cb_data->status = BIT(SVC_STATUS_RECONFIG_BUFFER_SUBMITTED);
-		break;
-	case COMMAND_NOOP:
-		cb_data->status = BIT(SVC_STATUS_RECONFIG_BUFFER_SUBMITTED);
-		cb_data->kaddr1 = svc_pa_to_va(res.a1);
+		cb_data->status = BIT(SVC_STATUS_BUFFER_SUBMITTED);
 		break;
 	case COMMAND_RECONFIG_STATUS:
-		cb_data->status = BIT(SVC_STATUS_RECONFIG_COMPLETED);
-		break;
-	case COMMAND_RSU_UPDATE:
-	case COMMAND_RSU_NOTIFY:
-		cb_data->status = BIT(SVC_STATUS_RSU_OK);
+		cb_data->status = BIT(SVC_STATUS_COMPLETED);
 		break;
 	case COMMAND_RSU_RETRY:
-		cb_data->status = BIT(SVC_STATUS_RSU_OK);
+		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr1 = &res.a1;
 		break;
 	default:
@@ -430,9 +424,9 @@ static int svc_normal_to_secure_thread(void *data)
 
 		if (pdata->command == COMMAND_RSU_STATUS) {
 			if (res.a0 == INTEL_SIP_SMC_RSU_ERROR)
-				cbdata->status = BIT(SVC_STATUS_RSU_ERROR);
+				cbdata->status = BIT(SVC_STATUS_ERROR);
 			else
-				cbdata->status = BIT(SVC_STATUS_RSU_OK);
+				cbdata->status = BIT(SVC_STATUS_OK);
 
 			cbdata->kaddr1 = &res;
 			cbdata->kaddr2 = NULL;
@@ -445,7 +439,7 @@ static int svc_normal_to_secure_thread(void *data)
 		case INTEL_SIP_SMC_STATUS_OK:
 			svc_thread_recv_status_ok(pdata, cbdata, res);
 			break;
-		case INTEL_SIP_SMC_FPGA_CONFIG_STATUS_BUSY:
+		case INTEL_SIP_SMC_STATUS_BUSY:
 			switch (pdata->command) {
 			case COMMAND_RECONFIG_DATA_SUBMIT:
 				svc_thread_cmd_data_claim(ctrl,
@@ -460,33 +454,13 @@ static int svc_normal_to_secure_thread(void *data)
 				break;
 			}
 			break;
-		case INTEL_SIP_SMC_FPGA_CONFIG_STATUS_REJECTED:
+		case INTEL_SIP_SMC_STATUS_REJECTED:
 			pr_debug("%s: STATUS_REJECTED\n", __func__);
 			break;
-		case INTEL_SIP_SMC_FPGA_CONFIG_STATUS_ERROR:
+		case INTEL_SIP_SMC_STATUS_ERROR:
 		case INTEL_SIP_SMC_RSU_ERROR:
 			pr_err("%s: STATUS_ERROR\n", __func__);
-			switch (pdata->command) {
-			/* for FPGA mgr */
-			case COMMAND_RECONFIG_DATA_CLAIM:
-			case COMMAND_RECONFIG:
-			case COMMAND_RECONFIG_DATA_SUBMIT:
-			case COMMAND_RECONFIG_STATUS:
-				cbdata->status =
-					BIT(SVC_STATUS_RECONFIG_ERROR);
-				break;
-
-			/* for RSU */
-			case COMMAND_RSU_STATUS:
-			case COMMAND_RSU_UPDATE:
-			case COMMAND_RSU_NOTIFY:
-			case COMMAND_RSU_RETRY:
-				cbdata->status =
-					BIT(SVC_STATUS_RSU_ERROR);
-				break;
-			}
-
-			cbdata->status = BIT(SVC_STATUS_RECONFIG_ERROR);
+			cbdata->status = BIT(SVC_STATUS_ERROR);
 			cbdata->kaddr1 = NULL;
 			cbdata->kaddr2 = NULL;
 			cbdata->kaddr3 = NULL;
@@ -502,7 +476,7 @@ static int svc_normal_to_secure_thread(void *data)
 			if ((pdata->command == COMMAND_RSU_RETRY) ||
 				(pdata->command == COMMAND_RSU_NOTIFY)) {
 				cbdata->status =
-					BIT(SVC_STATUS_RSU_NO_SUPPORT);
+					BIT(SVC_STATUS_NO_SUPPORT);
 				cbdata->kaddr1 = NULL;
 				cbdata->kaddr2 = NULL;
 				cbdata->kaddr3 = NULL;
diff --git a/drivers/fpga/stratix10-soc.c b/drivers/fpga/stratix10-soc.c
index bac93d0..44b7c56 100644
--- a/drivers/fpga/stratix10-soc.c
+++ b/drivers/fpga/stratix10-soc.c
@@ -154,11 +154,11 @@ static void s10_receive_callback(struct stratix10_svc_client *client,
 	 * Here we set status bits as we receive them.  Elsewhere, we always use
 	 * test_and_clear_bit() to check status in priv->status
 	 */
-	for (i = 0; i <= SVC_STATUS_RECONFIG_ERROR; i++)
+	for (i = 0; i <= SVC_STATUS_ERROR; i++)
 		if (status & (1 << i))
 			set_bit(i, &priv->status);
 
-	if (status & BIT(SVC_STATUS_RECONFIG_BUFFER_DONE)) {
+	if (status & BIT(SVC_STATUS_BUFFER_DONE)) {
 		s10_unlock_bufs(priv, data->kaddr1);
 		s10_unlock_bufs(priv, data->kaddr2);
 		s10_unlock_bufs(priv, data->kaddr3);
@@ -209,8 +209,7 @@ static int s10_ops_write_init(struct fpga_manager *mgr,
 	}
 
 	ret = 0;
-	if (!test_and_clear_bit(SVC_STATUS_RECONFIG_REQUEST_OK,
-				&priv->status)) {
+	if (!test_and_clear_bit(SVC_STATUS_OK, &priv->status)) {
 		ret = -ETIMEDOUT;
 		goto init_done;
 	}
@@ -323,17 +322,15 @@ static int s10_ops_write(struct fpga_manager *mgr, const char *buf,
 				&priv->status_return_completion,
 				S10_BUFFER_TIMEOUT);
 
-		if (test_and_clear_bit(SVC_STATUS_RECONFIG_BUFFER_DONE,
-				       &priv->status) ||
-		    test_and_clear_bit(SVC_STATUS_RECONFIG_BUFFER_SUBMITTED,
+		if (test_and_clear_bit(SVC_STATUS_BUFFER_DONE, &priv->status) ||
+		    test_and_clear_bit(SVC_STATUS_BUFFER_SUBMITTED,
 				       &priv->status)) {
 			ret = 0;
 			continue;
 		}
 
-		if (test_and_clear_bit(SVC_STATUS_RECONFIG_ERROR,
-				       &priv->status)) {
-			dev_err(dev, "ERROR - giving up - SVC_STATUS_RECONFIG_ERROR\n");
+		if (test_and_clear_bit(SVC_STATUS_ERROR, &priv->status)) {
+			dev_err(dev, "ERROR - giving up - SVC_STATUS_ERROR\n");
 			ret = -EFAULT;
 			break;
 		}
@@ -393,13 +390,11 @@ static int s10_ops_write_complete(struct fpga_manager *mgr,
 		timeout = ret;
 		ret = 0;
 
-		if (test_and_clear_bit(SVC_STATUS_RECONFIG_COMPLETED,
-				       &priv->status))
+		if (test_and_clear_bit(SVC_STATUS_COMPLETED, &priv->status))
 			break;
 
-		if (test_and_clear_bit(SVC_STATUS_RECONFIG_ERROR,
-				       &priv->status)) {
-			dev_err(dev, "ERROR - giving up - SVC_STATUS_RECONFIG_ERROR\n");
+		if (test_and_clear_bit(SVC_STATUS_ERROR, &priv->status)) {
+			dev_err(dev, "ERROR - giving up - SVC_STATUS_ERROR\n");
 			ret = -EFAULT;
 			break;
 		}
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index 013ae48..682dbf6 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -54,32 +54,25 @@
  * Secure monitor software doesn't recognize the request.
  *
  * INTEL_SIP_SMC_STATUS_OK:
- * FPGA configuration completed successfully,
- * In case of FPGA configuration write operation, it means secure monitor
- * software can accept the next chunk of FPGA configuration data.
+ * Secure monitor software accepts the service client's request.
  *
- * INTEL_SIP_SMC_FPGA_CONFIG_STATUS_BUSY:
- * In case of FPGA configuration write operation, it means secure monitor
- * software is still processing previous data & can't accept the next chunk
- * of data. Service driver needs to issue
- * INTEL_SIP_SMC_FPGA_CONFIG_COMPLETED_WRITE call to query the
- * completed block(s).
+ * INTEL_SIP_SMC_STATUS_BUSY:
+ * Secure monitor software is still processing service client's request.
  *
- * INTEL_SIP_SMC_FPGA_CONFIG_STATUS_ERROR:
- * There is error during the FPGA configuration process.
+ * INTEL_SIP_SMC_STATUS_REJECTED:
+ * Secure monitor software reject the service client's request.
  *
- * INTEL_SIP_SMC_REG_ERROR:
- * There is error during a read or write operation of the protected registers.
+ * INTEL_SIP_SMC_STATUS_ERROR:
+ * There is error during the process of service request.
  *
  * INTEL_SIP_SMC_RSU_ERROR:
- * There is error during a remote status update.
+ * There is error during the process of remote status update request.
  */
 #define INTEL_SIP_SMC_RETURN_UNKNOWN_FUNCTION		0xFFFFFFFF
 #define INTEL_SIP_SMC_STATUS_OK				0x0
-#define INTEL_SIP_SMC_FPGA_CONFIG_STATUS_BUSY		0x1
-#define INTEL_SIP_SMC_FPGA_CONFIG_STATUS_REJECTED       0x2
-#define INTEL_SIP_SMC_FPGA_CONFIG_STATUS_ERROR		0x4
-#define INTEL_SIP_SMC_REG_ERROR				0x5
+#define INTEL_SIP_SMC_STATUS_BUSY			0x1
+#define INTEL_SIP_SMC_STATUS_REJECTED			0x2
+#define INTEL_SIP_SMC_STATUS_ERROR			0x4
 #define INTEL_SIP_SMC_RSU_ERROR				0x7
 
 /**
@@ -95,7 +88,7 @@
  * a2-7: not used.
  *
  * Return status:
- * a0: INTEL_SIP_SMC_STATUS_OK, or INTEL_SIP_SMC_FPGA_CONFIG_STATUS_ERROR.
+ * a0: INTEL_SIP_SMC_STATUS_OK, or INTEL_SIP_SMC_STATUS_ERROR.
  * a1-3: not used.
  */
 #define INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_START 1
@@ -115,8 +108,8 @@
  * a3-7: not used.
  *
  * Return status:
- * a0: INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_FPGA_CONFIG_STATUS_BUSY or
- * INTEL_SIP_SMC_FPGA_CONFIG_STATUS_ERROR.
+ * a0: INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_BUSY or
+ * INTEL_SIP_SMC_STATUS_ERROR.
  * a1: 64bit physical address of 1st completed memory block if any completed
  * block, otherwise zero value.
  * a2: 64bit physical address of 2nd completed memory block if any completed
@@ -133,15 +126,15 @@
  *
  * Sync call used by service driver at EL1 to track the completed write
  * transactions. This request is called after INTEL_SIP_SMC_FPGA_CONFIG_WRITE
- * call returns INTEL_SIP_SMC_FPGA_CONFIG_STATUS_BUSY.
+ * call returns INTEL_SIP_SMC_STATUS_BUSY.
  *
  * Call register usage:
  * a0: INTEL_SIP_SMC_FPGA_CONFIG_COMPLETED_WRITE.
  * a1-7: not used.
  *
  * Return status:
- * a0: INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_FPGA_CONFIG_STATUS_BUSY or
- * INTEL_SIP_SMC_FPGA_CONFIG_STATUS_ERROR.
+ * a0: INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_FPGA_BUSY or
+ * INTEL_SIP_SMC_STATUS_ERROR.
  * a1: 64bit physical address of 1st completed memory block.
  * a2: 64bit physical address of 2nd completed memory block if
  * any completed block, otherwise zero value.
@@ -164,8 +157,8 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
  * a1-7: not used.
  *
  * Return status:
- * a0: INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_FPGA_CONFIG_STATUS_BUSY or
- * INTEL_SIP_SMC_FPGA_CONFIG_STATUS_ERROR.
+ * a0: INTEL_SIP_SMC_STATUS_OK, INTEL_SIP_SMC_STATUS_BUSY or
+ * INTEL_SIP_SMC_STATUS_ERROR.
  * a1-3: not used.
  */
 #define INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_ISDONE 4
@@ -183,7 +176,7 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
  * a1-7: not used.
  *
  * Return status:
- * a0: INTEL_SIP_SMC_STATUS_OK or INTEL_SIP_SMC_FPGA_CONFIG_STATUS_ERROR.
+ * a0: INTEL_SIP_SMC_STATUS_OK or INTEL_SIP_SMC_STATUS_ERROR.
  * a1: start of physical address of reserved memory block.
  * a2: size of reserved memory block.
  * a3: not used.
@@ -203,7 +196,7 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
  * a1-7: not used.
  *
  * Return status:
- * a0: INTEL_SIP_SMC_STATUS_OK or INTEL_SIP_SMC_FPGA_CONFIG_STATUS_ERROR.
+ * a0: INTEL_SIP_SMC_STATUS_OK or INTEL_SIP_SMC_STATUS_ERROR.
  * a1-3: not used.
  */
 #define INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_LOOPBACK 6
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 59bc6e2..64213c3 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -18,45 +18,37 @@
 /**
  * Status of the sent command, in bit number
  *
- * SVC_COMMAND_STATUS_RECONFIG_REQUEST_OK:
- * Secure firmware accepts the request of FPGA reconfiguration.
+ * SVC_STATUS_OK:
+ * Secure firmware accepts the request issued by one of service clients.
  *
- * SVC_STATUS_RECONFIG_BUFFER_SUBMITTED:
- * Service client successfully submits FPGA configuration
- * data buffer to secure firmware.
+ * SVC_STATUS_BUFFER_SUBMITTED:
+ * Service client successfully submits data buffer to secure firmware.
  *
- * SVC_COMMAND_STATUS_RECONFIG_BUFFER_DONE:
+ * SVC_STATUS_BUFFER_DONE:
  * Secure firmware completes data process, ready to accept the
  * next WRITE transaction.
  *
- * SVC_COMMAND_STATUS_RECONFIG_COMPLETED:
- * Secure firmware completes FPGA configuration successfully, FPGA should
- * be in user mode.
+ * SVC_STATUS_COMPLETED:
+ * Secure firmware completes service request successfully. In case of
+ * FPGA configuration, FPGA should be in user mode.
  *
- * SVC_COMMAND_STATUS_RECONFIG_BUSY:
- * FPGA configuration is still in process.
+ * SVC_COMMAND_STATUS_BUSY:
+ * Service request is still in process.
  *
- * SVC_COMMAND_STATUS_RECONFIG_ERROR:
- * Error encountered during FPGA configuration.
+ * SVC_COMMAND_STATUS_ERROR:
+ * Error encountered during the process of the service request.
  *
- * SVC_STATUS_RSU_OK:
- * Secure firmware accepts the request of remote status update (RSU).
- *
- * SVC_STATUS_RSU_ERROR:
- * Error encountered during remote system update.
- *
- * SVC_STATUS_RSU_NO_SUPPORT:
- * Secure firmware doesn't support RSU retry or notify feature.
+ * SVC_STATUS_NO_SUPPORT:
+ * Secure firmware doesn't support requested features such as RSU retry
+ * or RSU notify.
  */
-#define SVC_STATUS_RECONFIG_REQUEST_OK		0
-#define SVC_STATUS_RECONFIG_BUFFER_SUBMITTED	1
-#define SVC_STATUS_RECONFIG_BUFFER_DONE		2
-#define SVC_STATUS_RECONFIG_COMPLETED		3
-#define SVC_STATUS_RECONFIG_BUSY		4
-#define SVC_STATUS_RECONFIG_ERROR		5
-#define SVC_STATUS_RSU_OK			6
-#define SVC_STATUS_RSU_ERROR			7
-#define SVC_STATUS_RSU_NO_SUPPORT		8
+#define SVC_STATUS_OK			0
+#define SVC_STATUS_BUFFER_SUBMITTED	1
+#define SVC_STATUS_BUFFER_DONE		2
+#define SVC_STATUS_COMPLETED		3
+#define SVC_STATUS_BUSY			4
+#define SVC_STATUS_ERROR		5
+#define SVC_STATUS_NO_SUPPORT		6
 
 /**
  * Flag bit for COMMAND_RECONFIG
@@ -84,32 +76,29 @@ struct stratix10_svc_chan;
  * @COMMAND_NOOP: do 'dummy' request for integration/debug/trouble-shooting
  *
  * @COMMAND_RECONFIG: ask for FPGA configuration preparation, return status
- * is SVC_STATUS_RECONFIG_REQUEST_OK
+ * is SVC_STATUS_OK
  *
  * @COMMAND_RECONFIG_DATA_SUBMIT: submit buffer(s) of bit-stream data for the
- * FPGA configuration, return status is SVC_STATUS_RECONFIG_BUFFER_SUBMITTED,
- * or SVC_STATUS_RECONFIG_ERROR
+ * FPGA configuration, return status is SVC_STATUS_SUBMITTED or SVC_STATUS_ERROR
  *
  * @COMMAND_RECONFIG_DATA_CLAIM: check the status of the configuration, return
- * status is SVC_STATUS_RECONFIG_COMPLETED, or SVC_STATUS_RECONFIG_BUSY, or
- * SVC_STATUS_RECONFIG_ERROR
+ * status is SVC_STATUS_COMPLETED, or SVC_STATUS_BUSY, or SVC_STATUS_ERROR
  *
  * @COMMAND_RECONFIG_STATUS: check the status of the configuration, return
- * status is SVC_STATUS_RECONFIG_COMPLETED, or  SVC_STATUS_RECONFIG_BUSY, or
- * SVC_STATUS_RECONFIG_ERROR
+ * status is SVC_STATUS_COMPLETED, or SVC_STATUS_BUSY, or SVC_STATUS_ERROR
  *
  * @COMMAND_RSU_STATUS: request remote system update boot log, return status
  * is log data or SVC_STATUS_RSU_ERROR
  *
  * @COMMAND_RSU_UPDATE: set the offset of the bitstream to boot after reboot,
- * return status is SVC_STATUS_RSU_OK or SVC_STATUS_RSU_ERROR
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
  *
  * @COMMAND_RSU_NOTIFY: report the status of hard processor system
- * software to firmware, return status is SVC_STATUS_RSU_OK or
- * SVC_STATUS_RSU_ERROR
+ * software to firmware, return status is SVC_STATUS_OK or
+ * SVC_STATUS_ERROR
  *
  * @COMMAND_RSU_RETRY: query firmware for the current image's retry counter,
- * return status is SVC_STATUS_RSU_OK or SVC_STATUS_RSU_ERROR
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
  */
 enum stratix10_svc_command_code {
 	COMMAND_NOOP = 0,
-- 
2.7.4

