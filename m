Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DE4C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6835420715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgGFMnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:43:11 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42708 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729136AbgGFMnI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:43:08 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EE8AB1A06A0;
        Mon,  6 Jul 2020 14:43:06 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E22631A0650;
        Mon,  6 Jul 2020 14:43:06 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 8CA95203C3;
        Mon,  6 Jul 2020 14:43:06 +0200 (CEST)
From:   Diana Craciun <diana.craciun@nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com,
        gregkh@linuxfoundation.org
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v3 05/13] bus/fsl-mc: Cache the DPRC API version
Date:   Mon,  6 Jul 2020 15:42:35 +0300
Message-Id: <20200706124243.10697-6-diana.craciun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706124243.10697-1-diana.craciun@nxp.com>
References: <20200706124243.10697-1-diana.craciun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diana Craciun <diana.craciun@oss.nxp.com>

There are already firmware API commands that have multiple
versions. For each multiple version command, another command
to retrieve the API version is issued. This may introduce an important
overhead. The version does not change while the system is running,
so the DPRC API version can be safely cached.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index 602f030d84eb..01bf41743efc 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /*
  * Copyright 2013-2016 Freescale Semiconductor Inc.
+ * Copyright 2020 NXP
  *
  */
 #include <linux/kernel.h>
@@ -8,6 +9,13 @@
 
 #include "fsl-mc-private.h"
 
+/**
+ * cache the DPRC version to reduce the number of commands
+ * towards the mc firmware
+ */
+static u16 dprc_major_ver;
+static u16 dprc_minor_ver;
+
 /**
  * dprc_open() - Open DPRC object for use
  * @mc_io:	Pointer to MC portal's I/O object
@@ -443,15 +451,19 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
 	struct fsl_mc_command cmd = { 0 };
 	struct dprc_cmd_get_obj_region *cmd_params;
 	struct dprc_rsp_get_obj_region *rsp_params;
-	u16 major_ver, minor_ver;
 	int err;
 
-	/* prepare command */
-	err = dprc_get_api_version(mc_io, 0,
-				     &major_ver,
-				     &minor_ver);
-	if (err)
-		return err;
+    /**
+     * If the DPRC object version was not yet cached, cache it now.
+     * Otherwise use the already cached value.
+     */
+	if (!dprc_major_ver && !dprc_minor_ver) {
+		err = dprc_get_api_version(mc_io, 0,
+				      &dprc_major_ver,
+				      &dprc_minor_ver);
+		if (err)
+			return err;
+	}
 
 	/**
 	 * MC API version 6.3 introduced a new field to the region
@@ -459,7 +471,7 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
 	 * address is set to zero to indicate it needs to be obtained elsewhere
 	 * (typically the device tree).
 	 */
-	if (major_ver > 6 || (major_ver == 6 && minor_ver >= 3))
+	if (dprc_major_ver > 6 || (dprc_major_ver == 6 && dprc_minor_ver >= 3))
 		cmd.header =
 			mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG_V2,
 					     cmd_flags, token);
@@ -483,7 +495,7 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
 	rsp_params = (struct dprc_rsp_get_obj_region *)cmd.params;
 	region_desc->base_offset = le64_to_cpu(rsp_params->base_offset);
 	region_desc->size = le32_to_cpu(rsp_params->size);
-	if (major_ver > 6 || (major_ver == 6 && minor_ver >= 3))
+	if (dprc_major_ver > 6 || (dprc_major_ver == 6 && dprc_minor_ver >= 3))
 		region_desc->base_address = le64_to_cpu(rsp_params->base_addr);
 	else
 		region_desc->base_address = 0;
-- 
2.17.1

