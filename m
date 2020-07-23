Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12DBC433EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97AB420709
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbgGWO7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:59:49 -0400
Received: from mga09.intel.com ([134.134.136.24]:50088 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729489AbgGWO7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:59:45 -0400
IronPort-SDR: 86vEQuRc2YhMWFAlWmNA5pZgIGpZC91rZAYJi7Vfd2ahytd+3hCPPVqDvZU/rBWwoSBufmQqrQ
 VR4c0vIyQ13Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="151839030"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="151839030"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 07:59:45 -0700
IronPort-SDR: uKgacuuJyRTk6Cp8oCnrAOnvwJehTiJPJ5KYHGKaBHXTec6YP4/zqCJ4Mr0WbYXiLN+HRMkbSH
 Z+PQUzcu+dTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="311051200"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2020 07:59:43 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [char-misc-next 3/6] mei: bus: use sizeof of variable instead of struct type
Date:   Thu, 23 Jul 2020 17:59:24 +0300
Message-Id: <20200723145927.882743-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200723145927.882743-1-tomas.winkler@intel.com>
References: <20200723145927.882743-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a possibility of bug when variable type has changed but
corresponding struct passed to the sizeof has not.

Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/bus-fixup.c | 23 +++++++++++------------
 drivers/misc/mei/bus.c       |  2 +-
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/mei/bus-fixup.c b/drivers/misc/mei/bus-fixup.c
index 910f059b3384..07ba16d46690 100644
--- a/drivers/misc/mei/bus-fixup.c
+++ b/drivers/misc/mei/bus-fixup.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2013-2019, Intel Corporation. All rights reserved.
+ * Copyright (c) 2013-2020, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 
@@ -159,17 +159,17 @@ static int mei_osver(struct mei_cl_device *cldev)
 static int mei_fwver(struct mei_cl_device *cldev)
 {
 	char buf[MKHI_FWVER_BUF_LEN];
-	struct mkhi_msg *req;
+	struct mkhi_msg req;
+	struct mkhi_msg *rsp;
 	struct mkhi_fw_ver *fwver;
 	int bytes_recv, ret, i;
 
 	memset(buf, 0, sizeof(buf));
 
-	req = (struct mkhi_msg *)buf;
-	req->hdr.group_id = MKHI_GEN_GROUP_ID;
-	req->hdr.command = MKHI_GEN_GET_FW_VERSION_CMD;
+	req.hdr.group_id = MKHI_GEN_GROUP_ID;
+	req.hdr.command = MKHI_GEN_GET_FW_VERSION_CMD;
 
-	ret = __mei_cl_send(cldev->cl, buf, sizeof(struct mkhi_msg_hdr),
+	ret = __mei_cl_send(cldev->cl, (u8 *)&req, sizeof(req),
 			    MEI_CL_IO_TX_BLOCKING);
 	if (ret < 0) {
 		dev_err(&cldev->dev, "Could not send ReqFWVersion cmd\n");
@@ -188,7 +188,8 @@ static int mei_fwver(struct mei_cl_device *cldev)
 		return -EIO;
 	}
 
-	fwver = (struct mkhi_fw_ver *)req->data;
+	rsp = (struct mkhi_msg *)buf;
+	fwver = (struct mkhi_fw_ver *)rsp->data;
 	memset(cldev->bus->fw_ver, 0, sizeof(cldev->bus->fw_ver));
 	for (i = 0; i < MEI_MAX_FW_VER_BLOCKS; i++) {
 		if ((size_t)bytes_recv < MKHI_FWVER_LEN(i + 1))
@@ -329,16 +330,14 @@ static int mei_nfc_if_version(struct mei_cl *cl,
 
 	WARN_ON(mutex_is_locked(&bus->device_lock));
 
-	ret = __mei_cl_send(cl, (u8 *)&cmd, sizeof(struct mei_nfc_cmd),
-			    MEI_CL_IO_TX_BLOCKING);
+	ret = __mei_cl_send(cl, (u8 *)&cmd, sizeof(cmd), MEI_CL_IO_TX_BLOCKING);
 	if (ret < 0) {
 		dev_err(bus->dev, "Could not send IF version cmd\n");
 		return ret;
 	}
 
 	/* to be sure on the stack we alloc memory */
-	if_version_length = sizeof(struct mei_nfc_reply) +
-		sizeof(struct mei_nfc_if_version);
+	if_version_length = sizeof(*reply) + sizeof(*ver);
 
 	reply = kzalloc(if_version_length, GFP_KERNEL);
 	if (!reply)
@@ -352,7 +351,7 @@ static int mei_nfc_if_version(struct mei_cl *cl,
 		goto err;
 	}
 
-	memcpy(ver, reply->data, sizeof(struct mei_nfc_if_version));
+	memcpy(ver, reply->data, sizeof(*ver));
 
 	dev_info(bus->dev, "NFC MEI VERSION: IVN 0x%x Vendor ID 0x%x Type 0x%x\n",
 		ver->fw_ivn, ver->vendor_id, ver->radio_type);
diff --git a/drivers/misc/mei/bus.c b/drivers/misc/mei/bus.c
index f476dbc7252b..a6dfc3ce1db2 100644
--- a/drivers/misc/mei/bus.c
+++ b/drivers/misc/mei/bus.c
@@ -931,7 +931,7 @@ static struct mei_cl_device *mei_cl_bus_dev_alloc(struct mei_device *bus,
 	struct mei_cl_device *cldev;
 	struct mei_cl *cl;
 
-	cldev = kzalloc(sizeof(struct mei_cl_device), GFP_KERNEL);
+	cldev = kzalloc(sizeof(*cldev), GFP_KERNEL);
 	if (!cldev)
 		return NULL;
 
-- 
2.25.4

