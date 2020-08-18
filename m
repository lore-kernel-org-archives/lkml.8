Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49C5AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27854207DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHRMKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:10:05 -0400
Received: from mga07.intel.com ([134.134.136.100]:58725 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgHRMJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:09:59 -0400
IronPort-SDR: +2bJHmZ4UEDYE91soeuy2qlEirzam0pVgyrbUyJBQtVZFLaYqqpeRGFg4CakITnP073U/EBdpd
 VtJ5Ch3TWPHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="219200362"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="219200362"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 05:09:58 -0700
IronPort-SDR: egMjF1RqL2L/5mJGoH6cv2B26SV2kh9J1d5UEMsfILOakDfQDMScOodMnTwI5AVmTowXciwtSH
 9Di5pxdcCQvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="326712929"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 05:09:57 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 01/13] mei: hbm: add capabilities message
Date:   Tue, 18 Aug 2020 14:51:35 +0300
Message-Id: <20200818115147.2567012-2-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200818115147.2567012-1-tomas.winkler@intel.com>
References: <20200818115147.2567012-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

The new capabilities command in HBM version 2.2 allows
performing capabilities handshake between the firmware
and the host driver. The driver requests a capability
by setting the appropriate bit in 24bit wide bitmask and
the fw responses with the bit set providing the requested
capability is supported.

Bump copyright year in affected files.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/debugfs.c |  1 +
 drivers/misc/mei/hbm.c     | 72 ++++++++++++++++++++++++++++++++++++++
 drivers/misc/mei/hbm.h     |  2 ++
 drivers/misc/mei/hw.h      | 31 ++++++++++++++++
 drivers/misc/mei/mei_dev.h |  2 ++
 5 files changed, 108 insertions(+)

diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c
index a26c716c61a1..72ee572ad9b4 100644
--- a/drivers/misc/mei/debugfs.c
+++ b/drivers/misc/mei/debugfs.c
@@ -103,6 +103,7 @@ static int mei_dbgfs_devstate_show(struct seq_file *m, void *unused)
 		seq_printf(m, "\tFA: %01d\n", dev->hbm_f_fa_supported);
 		seq_printf(m, "\tOS: %01d\n", dev->hbm_f_os_supported);
 		seq_printf(m, "\tDR: %01d\n", dev->hbm_f_dr_supported);
+		seq_printf(m, "\tCAP: %01d\n", dev->hbm_f_cap_supported);
 	}
 
 	seq_printf(m, "pg:  %s, %s\n",
diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index 308caee86920..3a227d9363d5 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -325,6 +325,37 @@ static int mei_hbm_dma_setup_req(struct mei_device *dev)
 	return 0;
 }
 
+/**
+ * mei_hbm_capabilities_req - request capabilities
+ *
+ * @dev: the device structure
+ *
+ * Return: 0 on success and < 0 on failure
+ */
+static int mei_hbm_capabilities_req(struct mei_device *dev)
+{
+	struct mei_msg_hdr mei_hdr;
+	struct hbm_capability_request req;
+	int ret;
+
+	mei_hbm_hdr(&mei_hdr, sizeof(req));
+
+	memset(&req, 0, sizeof(req));
+	req.hbm_cmd = MEI_HBM_CAPABILITIES_REQ_CMD;
+
+	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
+	if (ret) {
+		dev_err(dev->dev,
+			"capabilities request write failed: ret = %d.\n", ret);
+		return ret;
+	}
+
+	dev->hbm_state = MEI_HBM_CAP_SETUP;
+	dev->init_clients_timer = MEI_CLIENTS_INIT_TIMEOUT;
+	mei_schedule_stall_timer(dev);
+	return 0;
+}
+
 /**
  * mei_hbm_enum_clients_req - sends enumeration client request message.
  *
@@ -1042,6 +1073,12 @@ static void mei_hbm_config_features(struct mei_device *dev)
 	    (dev->version.major_version == HBM_MAJOR_VERSION_DR &&
 	     dev->version.minor_version >= HBM_MINOR_VERSION_DR))
 		dev->hbm_f_dr_supported = 1;
+
+	dev->hbm_f_cap_supported = 0;
+	if (dev->version.major_version > HBM_MAJOR_VERSION_CAP ||
+	    (dev->version.major_version == HBM_MAJOR_VERSION_CAP &&
+	     dev->version.minor_version >= HBM_MINOR_VERSION_CAP))
+		dev->hbm_f_cap_supported = 1;
 }
 
 /**
@@ -1138,6 +1175,13 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 			return -EPROTO;
 		}
 
+		if (dev->hbm_f_cap_supported) {
+			if (mei_hbm_capabilities_req(dev))
+				return -EIO;
+			wake_up(&dev->wait_hbm_start);
+			break;
+		}
+
 		if (dev->hbm_f_dr_supported) {
 			if (mei_dmam_ring_alloc(dev))
 				dev_info(dev->dev, "running w/o dma ring\n");
@@ -1159,6 +1203,34 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 		wake_up(&dev->wait_hbm_start);
 		break;
 
+	case MEI_HBM_CAPABILITIES_RES_CMD:
+		dev_dbg(dev->dev, "hbm: capabilities response: message received.\n");
+
+		dev->init_clients_timer = 0;
+
+		if (dev->hbm_state != MEI_HBM_CAP_SETUP) {
+			dev_err(dev->dev, "hbm: capabilities response: state mismatch, [%d, %d]\n",
+				dev->dev_state, dev->hbm_state);
+			return -EPROTO;
+		}
+
+		if (dev->hbm_f_dr_supported) {
+			if (mei_dmam_ring_alloc(dev))
+				dev_info(dev->dev, "running w/o dma ring\n");
+			if (mei_dma_ring_is_allocated(dev)) {
+				if (mei_hbm_dma_setup_req(dev))
+					return -EIO;
+				break;
+			}
+		}
+
+		dev->hbm_f_dr_supported = 0;
+		mei_dmam_ring_free(dev);
+
+		if (mei_hbm_enum_clients_req(dev))
+			return -EIO;
+		break;
+
 	case MEI_HBM_DMA_SETUP_RES_CMD:
 		dev_dbg(dev->dev, "hbm: dma setup response: message received.\n");
 
diff --git a/drivers/misc/mei/hbm.h b/drivers/misc/mei/hbm.h
index 5aa58cffdd2e..4d95e38e4ddf 100644
--- a/drivers/misc/mei/hbm.h
+++ b/drivers/misc/mei/hbm.h
@@ -16,6 +16,7 @@ struct mei_cl;
  *
  * @MEI_HBM_IDLE : protocol not started
  * @MEI_HBM_STARTING : start request message was sent
+ * @MEI_HBM_CAP_SETUP : capabilities request message was sent
  * @MEI_HBM_DR_SETUP : dma ring setup request message was sent
  * @MEI_HBM_ENUM_CLIENTS : enumeration request was sent
  * @MEI_HBM_CLIENT_PROPERTIES : acquiring clients properties
@@ -25,6 +26,7 @@ struct mei_cl;
 enum mei_hbm_state {
 	MEI_HBM_IDLE = 0,
 	MEI_HBM_STARTING,
+	MEI_HBM_CAP_SETUP,
 	MEI_HBM_DR_SETUP,
 	MEI_HBM_ENUM_CLIENTS,
 	MEI_HBM_CLIENT_PROPERTIES,
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index 26fa92cb7f7a..539d89ba1c61 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -76,6 +76,12 @@
 #define HBM_MINOR_VERSION_DR               1
 #define HBM_MAJOR_VERSION_DR               2
 
+/*
+ * MEI version with capabilities message support
+ */
+#define HBM_MINOR_VERSION_CAP              2
+#define HBM_MAJOR_VERSION_CAP              2
+
 /* Host bus message command opcode */
 #define MEI_HBM_CMD_OP_MSK                  0x7f
 /* Host bus message command RESPONSE */
@@ -121,6 +127,9 @@
 #define MEI_HBM_DMA_SETUP_REQ_CMD           0x12
 #define MEI_HBM_DMA_SETUP_RES_CMD           0x92
 
+#define MEI_HBM_CAPABILITIES_REQ_CMD        0x13
+#define MEI_HBM_CAPABILITIES_RES_CMD        0x93
+
 /*
  * MEI Stop Reason
  * used by hbm_host_stop_request.reason
@@ -533,4 +542,26 @@ struct hbm_dma_ring_ctrl {
 	u32 reserved4;
 } __packed;
 
+/**
+ * struct hbm_capability_request - capability request from host to fw
+ *
+ * @hbm_cmd : bus message command header
+ * @capability_requested: bitmask of capabilities requested by host
+ */
+struct hbm_capability_request {
+	u8 hbm_cmd;
+	u8 capability_requested[3];
+} __packed;
+
+/**
+ * struct hbm_capability_response - capability response from fw to host
+ *
+ * @hbm_cmd : bus message command header
+ * @capability_granted: bitmask of capabilities granted by FW
+ */
+struct hbm_capability_response {
+	u8 hbm_cmd;
+	u8 capability_granted[3];
+} __packed;
+
 #endif
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index d3a4f54c0ae7..e18af7dfd9ff 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -426,6 +426,7 @@ struct mei_fw_version {
  * @hbm_f_ie_supported  : hbm feature immediate reply to enum request
  * @hbm_f_os_supported  : hbm feature support OS ver message
  * @hbm_f_dr_supported  : hbm feature dma ring supported
+ * @hbm_f_cap_supported : hbm feature capabilities message supported
  *
  * @fw_ver : FW versions
  *
@@ -510,6 +511,7 @@ struct mei_device {
 	unsigned int hbm_f_ie_supported:1;
 	unsigned int hbm_f_os_supported:1;
 	unsigned int hbm_f_dr_supported:1;
+	unsigned int hbm_f_cap_supported:1;
 
 	struct mei_fw_version fw_ver[MEI_MAX_FW_VER_BLOCKS];
 
-- 
2.25.4

