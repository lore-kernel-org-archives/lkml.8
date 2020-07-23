Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D80C433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED8922B40
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbgGWO7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:59:43 -0400
Received: from mga09.intel.com ([134.134.136.24]:50088 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727885AbgGWO7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:59:41 -0400
IronPort-SDR: Tat7Qx5YUQwWgPYsby5uCGRy3A7VChWOCpHSbjMxkzovzXqrxDgSU4OMjDkscj8bEE70XnDi7d
 ArH9ZIn7S0vA==
X-IronPort-AV: E=McAfee;i="6000,8403,9690"; a="151839018"
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="151839018"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 07:59:41 -0700
IronPort-SDR: bOmTKMCFD6XrCcraSTYydHPtqDbDg7512DkU8WXOgh5+EabNUFDjhnWe0qK2UwqaTPOJCIAQfL
 XVHUWFRngemg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,386,1589266800"; 
   d="scan'208";a="311051172"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.138])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jul 2020 07:59:39 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [char-misc-next 1/6] mei: hbm: use sizeof of variable instead of struct type
Date:   Thu, 23 Jul 2020 17:59:22 +0300
Message-Id: <20200723145927.882743-2-tomas.winkler@intel.com>
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
 drivers/misc/mei/hbm.c | 74 ++++++++++++++++++------------------------
 1 file changed, 32 insertions(+), 42 deletions(-)

diff --git a/drivers/misc/mei/hbm.c b/drivers/misc/mei/hbm.c
index a44094cdbc36..308caee86920 100644
--- a/drivers/misc/mei/hbm.c
+++ b/drivers/misc/mei/hbm.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
+ * Copyright (c) 2003-2020, Intel Corporation. All rights reserved.
  * Intel Management Engine Interface (Intel MEI) Linux driver
  */
 #include <linux/export.h>
@@ -257,22 +257,21 @@ int mei_hbm_start_wait(struct mei_device *dev)
 int mei_hbm_start_req(struct mei_device *dev)
 {
 	struct mei_msg_hdr mei_hdr;
-	struct hbm_host_version_request start_req;
-	const size_t len = sizeof(struct hbm_host_version_request);
+	struct hbm_host_version_request req;
 	int ret;
 
 	mei_hbm_reset(dev);
 
-	mei_hbm_hdr(&mei_hdr, len);
+	mei_hbm_hdr(&mei_hdr, sizeof(req));
 
 	/* host start message */
-	memset(&start_req, 0, len);
-	start_req.hbm_cmd = HOST_START_REQ_CMD;
-	start_req.host_version.major_version = HBM_MAJOR_VERSION;
-	start_req.host_version.minor_version = HBM_MINOR_VERSION;
+	memset(&req, 0, sizeof(req));
+	req.hbm_cmd = HOST_START_REQ_CMD;
+	req.host_version.major_version = HBM_MAJOR_VERSION;
+	req.host_version.minor_version = HBM_MINOR_VERSION;
 
 	dev->hbm_state = MEI_HBM_IDLE;
-	ret = mei_hbm_write_message(dev, &mei_hdr, &start_req);
+	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret) {
 		dev_err(dev->dev, "version message write failed: ret = %d\n",
 			ret);
@@ -295,13 +294,12 @@ static int mei_hbm_dma_setup_req(struct mei_device *dev)
 {
 	struct mei_msg_hdr mei_hdr;
 	struct hbm_dma_setup_request req;
-	const size_t len = sizeof(struct hbm_dma_setup_request);
 	unsigned int i;
 	int ret;
 
-	mei_hbm_hdr(&mei_hdr, len);
+	mei_hbm_hdr(&mei_hdr, sizeof(req));
 
-	memset(&req, 0, len);
+	memset(&req, 0, sizeof(req));
 	req.hbm_cmd = MEI_HBM_DMA_SETUP_REQ_CMD;
 	for (i = 0; i < DMA_DSCR_NUM; i++) {
 		phys_addr_t paddr;
@@ -337,21 +335,19 @@ static int mei_hbm_dma_setup_req(struct mei_device *dev)
 static int mei_hbm_enum_clients_req(struct mei_device *dev)
 {
 	struct mei_msg_hdr mei_hdr;
-	struct hbm_host_enum_request enum_req;
-	const size_t len = sizeof(struct hbm_host_enum_request);
+	struct hbm_host_enum_request req;
 	int ret;
 
 	/* enumerate clients */
-	mei_hbm_hdr(&mei_hdr, len);
+	mei_hbm_hdr(&mei_hdr, sizeof(req));
 
-	memset(&enum_req, 0, len);
-	enum_req.hbm_cmd = HOST_ENUM_REQ_CMD;
-	enum_req.flags |= dev->hbm_f_dc_supported ?
-			  MEI_HBM_ENUM_F_ALLOW_ADD : 0;
-	enum_req.flags |= dev->hbm_f_ie_supported ?
+	memset(&req, 0, sizeof(req));
+	req.hbm_cmd = HOST_ENUM_REQ_CMD;
+	req.flags |= dev->hbm_f_dc_supported ? MEI_HBM_ENUM_F_ALLOW_ADD : 0;
+	req.flags |= dev->hbm_f_ie_supported ?
 			  MEI_HBM_ENUM_F_IMMEDIATE_ENUM : 0;
 
-	ret = mei_hbm_write_message(dev, &mei_hdr, &enum_req);
+	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret) {
 		dev_err(dev->dev, "enumeration request write failed: ret = %d.\n",
 			ret);
@@ -380,7 +376,7 @@ static int mei_hbm_me_cl_add(struct mei_device *dev,
 
 	mei_me_cl_rm_by_uuid(dev, uuid);
 
-	me_cl = kzalloc(sizeof(struct mei_me_client), GFP_KERNEL);
+	me_cl = kzalloc(sizeof(*me_cl), GFP_KERNEL);
 	if (!me_cl)
 		return -ENOMEM;
 
@@ -408,14 +404,13 @@ static int mei_hbm_add_cl_resp(struct mei_device *dev, u8 addr, u8 status)
 {
 	struct mei_msg_hdr mei_hdr;
 	struct hbm_add_client_response resp;
-	const size_t len = sizeof(struct hbm_add_client_response);
 	int ret;
 
 	dev_dbg(dev->dev, "adding client response\n");
 
-	mei_hbm_hdr(&mei_hdr, len);
+	mei_hbm_hdr(&mei_hdr, sizeof(resp));
 
-	memset(&resp, 0, sizeof(struct hbm_add_client_response));
+	memset(&resp, 0, sizeof(resp));
 	resp.hbm_cmd = MEI_HBM_ADD_CLIENT_RES_CMD;
 	resp.me_addr = addr;
 	resp.status  = status;
@@ -469,11 +464,10 @@ int mei_hbm_cl_notify_req(struct mei_device *dev,
 
 	struct mei_msg_hdr mei_hdr;
 	struct hbm_notification_request req;
-	const size_t len = sizeof(struct hbm_notification_request);
 	int ret;
 
-	mei_hbm_hdr(&mei_hdr, len);
-	mei_hbm_cl_hdr(cl, MEI_HBM_NOTIFY_REQ_CMD, &req, len);
+	mei_hbm_hdr(&mei_hdr, sizeof(req));
+	mei_hbm_cl_hdr(cl, MEI_HBM_NOTIFY_REQ_CMD, &req, sizeof(req));
 
 	req.start = start;
 
@@ -580,8 +574,7 @@ static void mei_hbm_cl_notify(struct mei_device *dev,
 static int mei_hbm_prop_req(struct mei_device *dev, unsigned long start_idx)
 {
 	struct mei_msg_hdr mei_hdr;
-	struct hbm_props_request prop_req;
-	const size_t len = sizeof(struct hbm_props_request);
+	struct hbm_props_request req;
 	unsigned long addr;
 	int ret;
 
@@ -591,18 +584,17 @@ static int mei_hbm_prop_req(struct mei_device *dev, unsigned long start_idx)
 	if (addr == MEI_CLIENTS_MAX) {
 		dev->hbm_state = MEI_HBM_STARTED;
 		mei_host_client_init(dev);
-
 		return 0;
 	}
 
-	mei_hbm_hdr(&mei_hdr, len);
+	mei_hbm_hdr(&mei_hdr, sizeof(req));
 
-	memset(&prop_req, 0, sizeof(struct hbm_props_request));
+	memset(&req, 0, sizeof(req));
 
-	prop_req.hbm_cmd = HOST_CLIENT_PROPERTIES_REQ_CMD;
-	prop_req.me_addr = addr;
+	req.hbm_cmd = HOST_CLIENT_PROPERTIES_REQ_CMD;
+	req.me_addr = addr;
 
-	ret = mei_hbm_write_message(dev, &mei_hdr, &prop_req);
+	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
 	if (ret) {
 		dev_err(dev->dev, "properties request write failed: ret = %d\n",
 			ret);
@@ -628,15 +620,14 @@ int mei_hbm_pg(struct mei_device *dev, u8 pg_cmd)
 {
 	struct mei_msg_hdr mei_hdr;
 	struct hbm_power_gate req;
-	const size_t len = sizeof(struct hbm_power_gate);
 	int ret;
 
 	if (!dev->hbm_f_pg_supported)
 		return -EOPNOTSUPP;
 
-	mei_hbm_hdr(&mei_hdr, len);
+	mei_hbm_hdr(&mei_hdr, sizeof(req));
 
-	memset(&req, 0, len);
+	memset(&req, 0, sizeof(req));
 	req.hbm_cmd = pg_cmd;
 
 	ret = mei_hbm_write_message(dev, &mei_hdr, &req);
@@ -657,11 +648,10 @@ static int mei_hbm_stop_req(struct mei_device *dev)
 {
 	struct mei_msg_hdr mei_hdr;
 	struct hbm_host_stop_request req;
-	const size_t len = sizeof(struct hbm_host_stop_request);
 
-	mei_hbm_hdr(&mei_hdr, len);
+	mei_hbm_hdr(&mei_hdr, sizeof(req));
 
-	memset(&req, 0, len);
+	memset(&req, 0, sizeof(req));
 	req.hbm_cmd = HOST_STOP_REQ_CMD;
 	req.reason = DRIVER_STOP_REQUEST;
 
-- 
2.25.4

