Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1DBC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A62592078E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgFOOOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:14:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:34462 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730189AbgFOOOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:14:10 -0400
IronPort-SDR: 6m+DIwZEVWGSTnrhrab4o8m1e0z1uPS/LV20O/9vM9qXaj/EEGGsHnr5u0c/7+6+4wbDZncsuv
 glLXAeLuf31w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 07:14:09 -0700
IronPort-SDR: +rvVZM4voEcVWsABXZfiWalC3e5np/uJkdxDEGr/4eFk2iwOhLRGJB+KowBc6uHZiuK6wY784R
 89yXFTQJRRbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,514,1583222400"; 
   d="scan'208";a="476029201"
Received: from marshy.an.intel.com ([10.122.105.159])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2020 07:14:09 -0700
From:   richard.gong@linux.intel.com
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, dinguyen@kernel.org,
        richard.gong@linux.intel.com, Richard Gong <richard.gong@intel.com>
Subject: [PATCH 2/4] firmware: stratix10-svc: extend svc to support new RSU features
Date:   Mon, 15 Jun 2020 09:29:06 -0500
Message-Id: <1592231348-31334-3-git-send-email-richard.gong@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592231348-31334-1-git-send-email-richard.gong@linux.intel.com>
References: <1592231348-31334-1-git-send-email-richard.gong@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Gong <richard.gong@intel.com>

Extend Intel Stratix10 service layer driver to support new RSU DCMF
versions and max retry parameter.

DCMF = Decision Configuration Management Firmware. The max retry parameter
is the maximum times the images is allowed to reload itself before giving
up and starting RSU failover flow.

Signed-off-by: Richard Gong <richard.gong@intel.com>
---
 drivers/firmware/stratix10-svc.c                   | 17 +++++++++
 include/linux/firmware/intel/stratix10-smc.h       | 43 ++++++++++++++++++++++
 .../linux/firmware/intel/stratix10-svc-client.h    |  8 ++++
 3 files changed, 68 insertions(+)

diff --git a/drivers/firmware/stratix10-svc.c b/drivers/firmware/stratix10-svc.c
index e0db8db..3aa489d 100644
--- a/drivers/firmware/stratix10-svc.c
+++ b/drivers/firmware/stratix10-svc.c
@@ -305,9 +305,15 @@ static void svc_thread_recv_status_ok(struct stratix10_svc_data *p_data,
 		cb_data->status = BIT(SVC_STATUS_COMPLETED);
 		break;
 	case COMMAND_RSU_RETRY:
+	case COMMAND_RSU_MAX_RETRY:
 		cb_data->status = BIT(SVC_STATUS_OK);
 		cb_data->kaddr1 = &res.a1;
 		break;
+	case COMMAND_RSU_DCMF_VERSION:
+		cb_data->status = BIT(SVC_STATUS_OK);
+		cb_data->kaddr1 = &res.a1;
+		cb_data->kaddr2 = &res.a2;
+		break;
 	default:
 		pr_warn("it shouldn't happen\n");
 		break;
@@ -406,6 +412,16 @@ static int svc_normal_to_secure_thread(void *data)
 			a1 = 0;
 			a2 = 0;
 			break;
+		case COMMAND_RSU_MAX_RETRY:
+			a0 = INTEL_SIP_SMC_RSU_MAX_RETRY;
+			a1 = 0;
+			a2 = 0;
+			break;
+		case COMMAND_RSU_DCMF_VERSION:
+			a0 = INTEL_SIP_SMC_RSU_DCMF_VERSION;
+			a1 = 0;
+			a2 = 0;
+			break;
 		default:
 			pr_warn("it shouldn't happen\n");
 			break;
@@ -474,6 +490,7 @@ static int svc_normal_to_secure_thread(void *data)
 			 * doesn't support RSU notify or retry
 			 */
 			if ((pdata->command == COMMAND_RSU_RETRY) ||
+			    (pdata->command == COMMAND_RSU_MAX_RETRY) ||
 				(pdata->command == COMMAND_RSU_NOTIFY)) {
 				cbdata->status =
 					BIT(SVC_STATUS_NO_SUPPORT);
diff --git a/include/linux/firmware/intel/stratix10-smc.h b/include/linux/firmware/intel/stratix10-smc.h
index 682dbf6..c3e5ab0 100644
--- a/include/linux/firmware/intel/stratix10-smc.h
+++ b/include/linux/firmware/intel/stratix10-smc.h
@@ -361,3 +361,46 @@ INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_FPGA_CONFIG_COMPLETED_WRITE)
 #define INTEL_SIP_SMC_FUNCID_RSU_RETRY_COUNTER 15
 #define INTEL_SIP_SMC_RSU_RETRY_COUNTER \
 	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_RETRY_COUNTER)
+
+/**
+ * Request INTEL_SIP_SMC_RSU_DCMF_VERSION
+ *
+ * Sync call used by service driver at EL1 to query DCMF (Decision
+ * Configuration Management Firmware) version from FW
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_RSU_DCMF_VERSION
+ * a1-7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 dcmf1 | dcmf0
+ * a2 dcmf3 | dcmf2
+ *
+ * Or
+ *
+ * a0 INTEL_SIP_SMC_RSU_ERROR
+ */
+#define INTEL_SIP_SMC_FUNCID_RSU_DCMF_VERSION 16
+#define INTEL_SIP_SMC_RSU_DCMF_VERSION \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_DCMF_VERSION)
+
+/**
+ * Request INTEL_SIP_SMC_RSU_MAX_RETRY
+ *
+ * Sync call used by service driver at EL1 to query max retry value from FW
+ *
+ * Call register usage:
+ * a0 INTEL_SIP_SMC_RSU_MAX_RETRY
+ * a1-7 not used
+ *
+ * Return status
+ * a0 INTEL_SIP_SMC_STATUS_OK
+ * a1 max retry value
+ *
+ * Or
+ * a0 INTEL_SIP_SMC_RSU_ERROR
+ */
+#define INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY 18
+#define INTEL_SIP_SMC_RSU_MAX_RETRY \
+	INTEL_SIP_SMC_FAST_CALL_VAL(INTEL_SIP_SMC_FUNCID_RSU_MAX_RETRY)
diff --git a/include/linux/firmware/intel/stratix10-svc-client.h b/include/linux/firmware/intel/stratix10-svc-client.h
index 040bc3f..a93d859 100644
--- a/include/linux/firmware/intel/stratix10-svc-client.h
+++ b/include/linux/firmware/intel/stratix10-svc-client.h
@@ -98,6 +98,12 @@ struct stratix10_svc_chan;
  *
  * @COMMAND_RSU_RETRY: query firmware for the current image's retry counter,
  * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ * @COMMAND_RSU_MAX_RETRY: query firmware for the max retry value,
+ * return status is SVC_STATUS_OK or SVC_STATUS_ERROR
+ *
+ * @COMMAND_RSU_DCMF_VERSION: query firmware for the DCMF version, return status
+ * is SVC_STATUS_OK or SVC_STATUS_ERROR
  */
 enum stratix10_svc_command_code {
 	COMMAND_NOOP = 0,
@@ -109,6 +115,8 @@ enum stratix10_svc_command_code {
 	COMMAND_RSU_UPDATE,
 	COMMAND_RSU_NOTIFY,
 	COMMAND_RSU_RETRY,
+	COMMAND_RSU_MAX_RETRY,
+	COMMAND_RSU_DCMF_VERSION,
 };
 
 /**
-- 
2.7.4

