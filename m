Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22ADC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2D9204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 12:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHRMKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 08:10:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:58725 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbgHRMKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 08:10:00 -0400
IronPort-SDR: RErJTQlTU2iBh6UPn6Omu6lHhvv+BtfyOOrHfBrtKenOkEguDwHIaSlKYyTxL62V3qZa2KYQuC
 WrnGCkSf0DLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="219200367"
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="219200367"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2020 05:10:00 -0700
IronPort-SDR: +iKCCltdzJLdJZYxSjc5+vyenoLDVMO4wyJ1wTfwl9lUlYQOhPPyEM4y3hqhn1VRKc6N+nzCer
 ZPOktOmCnwkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,327,1592895600"; 
   d="scan'208";a="326712937"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by orsmga008.jf.intel.com with ESMTP; 18 Aug 2020 05:09:59 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 02/13] mei: restrict vtag support to hbm version 2.2
Date:   Tue, 18 Aug 2020 14:51:36 +0300
Message-Id: <20200818115147.2567012-3-tomas.winkler@intel.com>
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

The vtag allows partitioning the mei messages into virtual groups/channels.
Vtags are supported for firmwares with HBM version 2.2 and newer
and only when a firmware confirms the support via capability handshake.
This change only define vtag restrictions in order to make
the series bisectable. Everything will be enabled when driver HBM
version is set to 2.2.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/debugfs.c |  1 +
 drivers/misc/mei/hbm.c     | 15 +++++++++++++++
 drivers/misc/mei/hw.h      |  9 +++++++++
 drivers/misc/mei/mei_dev.h |  2 ++
 4 files changed, 27 insertions(+)

diff --git a/drivers/misc/mei/debugfs.c b/drivers/misc/mei/debugfs.c
index 72ee572ad9b4..b98f6f9a4896 100644
--- a/drivers/misc/mei/debugfs.c
+++ b/drivers/misc/mei/debugfs.c
@@ -103,6 +103,7 @@ static int mei_dbgfs_devstate_show(struct seq_file *m, void *unused)
 		seq_printf(m, "\tFA: %01d\n", dev->hbm_f_fa_supported);
 		seq_printf(m, "\tOS: %01d\n", dev->hbm_f_os_supported);
 		seq_printf(m, "\tDR: %01d\n", dev->hbm_f_dr_supported);
+		seq_printf(m, "\tVT: %01d\n", dev->hbm_f_vt_supported);
 		seq_printf(m, "\tCAP: %01d\n", dev->hbm_f_cap_supported);
 	}
 
diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index 3a227d9363d5..0513b8a4ea88 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -342,6 +342,8 @@ static int mei_hbm_capabilities_req(struct mei_device *dev)
 
 	memset(&req, 0, sizeof(req));
 	req.hbm_cmd = MEI_HBM_CAPABILITIES_REQ_CMD;
+	if (dev->hbm_f_vt_supported)
+		req.capability_requested[0] = HBM_CAP_VT;
 
 	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret) {
@@ -1074,6 +1076,14 @@ static void mei_hbm_config_features(struct mei_device *dev)
 	     dev->version.minor_version >= HBM_MINOR_VERSION_DR))
 		dev->hbm_f_dr_supported = 1;
 
+	/* VTag Support */
+	dev->hbm_f_vt_supported = 0;
+	if (dev->version.major_version > HBM_MAJOR_VERSION_VT ||
+	    (dev->version.major_version == HBM_MAJOR_VERSION_VT &&
+	     dev->version.minor_version >= HBM_MINOR_VERSION_VT))
+		dev->hbm_f_vt_supported = 1;
+
+	/* Capability message Support */
 	dev->hbm_f_cap_supported = 0;
 	if (dev->version.major_version > HBM_MAJOR_VERSION_CAP ||
 	    (dev->version.major_version == HBM_MAJOR_VERSION_CAP &&
@@ -1112,6 +1122,7 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 	struct hbm_host_enum_response *enum_res;
 	struct hbm_dma_setup_response *dma_setup_res;
 	struct hbm_add_client_request *add_cl_req;
+	struct hbm_capability_response *capability_res;
 	int ret;
 
 	struct mei_hbm_cl_cmd *cl_cmd;
@@ -1214,6 +1225,10 @@ int mei_hbm_dispatch(struct mei_device *dev, struct mei_msg_hdr *hdr)
 			return -EPROTO;
 		}
 
+		capability_res = (struct hbm_capability_response *)mei_msg;
+		if (!(capability_res->capability_granted[0] & HBM_CAP_VT))
+			dev->hbm_f_vt_supported = 0;
+
 		if (dev->hbm_f_dr_supported) {
 			if (mei_dmam_ring_alloc(dev))
 				dev_info(dev->dev, "running w/o dma ring\n");
diff --git a/drivers/misc/mei/hw.h b/drivers/misc/mei/hw.h
index 539d89ba1c61..13e4cb68a0e6 100644
--- a/drivers/misc/mei/hw.h
+++ b/drivers/misc/mei/hw.h
@@ -76,6 +76,12 @@
 #define HBM_MINOR_VERSION_DR               1
 #define HBM_MAJOR_VERSION_DR               2
 
+/*
+ * MEI version with vm tag support
+ */
+#define HBM_MINOR_VERSION_VT               2
+#define HBM_MAJOR_VERSION_VT               2
+
 /*
  * MEI version with capabilities message support
  */
@@ -542,6 +548,9 @@ struct hbm_dma_ring_ctrl {
 	u32 reserved4;
 } __packed;
 
+/* virtual tag supported */
+#define HBM_CAP_VT BIT(0)
+
 /**
  * struct hbm_capability_request - capability request from host to fw
  *
diff --git a/drivers/misc/mei/mei_dev.h b/drivers/misc/mei/mei_dev.h
index e18af7dfd9ff..f80cc6463f18 100644
--- a/drivers/misc/mei/mei_dev.h
+++ b/drivers/misc/mei/mei_dev.h
@@ -426,6 +426,7 @@ struct mei_fw_version {
  * @hbm_f_ie_supported  : hbm feature immediate reply to enum request
  * @hbm_f_os_supported  : hbm feature support OS ver message
  * @hbm_f_dr_supported  : hbm feature dma ring supported
+ * @hbm_f_vt_supported  : hbm feature vtag supported
  * @hbm_f_cap_supported : hbm feature capabilities message supported
  *
  * @fw_ver : FW versions
@@ -511,6 +512,7 @@ struct mei_device {
 	unsigned int hbm_f_ie_supported:1;
 	unsigned int hbm_f_os_supported:1;
 	unsigned int hbm_f_dr_supported:1;
+	unsigned int hbm_f_vt_supported:1;
 	unsigned int hbm_f_cap_supported:1;
 
 	struct mei_fw_version fw_ver[MEI_MAX_FW_VER_BLOCKS];
-- 
2.25.4

