Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58956C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DA1F20786
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 12:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729234AbgGFMn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 08:43:28 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42910 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729187AbgGFMnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 08:43:12 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6BAC01A06BB;
        Mon,  6 Jul 2020 14:43:10 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 55DB11A0650;
        Mon,  6 Jul 2020 14:43:10 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0006F203C3;
        Mon,  6 Jul 2020 14:43:09 +0200 (CEST)
From:   Diana Craciun <diana.craciun@nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com,
        gregkh@linuxfoundation.org
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v3 13/13] bus/fsl-mc: Add a new version for dprc_get_obj_region command
Date:   Mon,  6 Jul 2020 15:42:43 +0300
Message-Id: <20200706124243.10697-14-diana.craciun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706124243.10697-1-diana.craciun@nxp.com>
References: <20200706124243.10697-1-diana.craciun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Diana Craciun <diana.craciun@oss.nxp.com>

The region size reported by the firmware for mc and software
portals was less than allocated by the hardware. This may be
problematic when mmapping the region in user space because the
region size is less than page size. However the size as reserved
by the hardware is 64K.

Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc.c           | 38 ++++++++++++++++++-----------
 drivers/bus/fsl-mc/fsl-mc-private.h |  3 +++
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index 3f08752c2c19..ba292c56fe19 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -536,20 +536,30 @@ int dprc_get_obj_region(struct fsl_mc_io *mc_io,
 			return err;
 	}
 
-	/**
-	 * MC API version 6.3 introduced a new field to the region
-	 * descriptor: base_address. If the older API is in use then the base
-	 * address is set to zero to indicate it needs to be obtained elsewhere
-	 * (typically the device tree).
-	 */
-	if (dprc_major_ver > 6 || (dprc_major_ver == 6 && dprc_minor_ver >= 3))
-		cmd.header =
-			mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG_V2,
-					     cmd_flags, token);
-	else
-		cmd.header =
-			mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG,
-					     cmd_flags, token);
+	if (dprc_major_ver > 6 || (dprc_major_ver == 6 && dprc_minor_ver >= 6)) {
+		/**
+		 * MC API version 6.6 changed the size of the MC portals and software
+		 * portals to 64K (as implemented by hardware). If older API is in use the
+		 * size reported is less (64 bytes for mc portals and 4K for software
+		 * portals).
+		 */
+
+		cmd.header = mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG_V3,
+						  cmd_flags, token);
+
+	} else if (dprc_major_ver == 6 && dprc_minor_ver >= 3) {
+		/**
+		 * MC API version 6.3 introduced a new field to the region
+		 * descriptor: base_address. If the older API is in use then the base
+		 * address is set to zero to indicate it needs to be obtained elsewhere
+		 * (typically the device tree).
+		 */
+		cmd.header = mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG_V2,
+						  cmd_flags, token);
+	} else {
+		cmd.header = mc_encode_cmd_header(DPRC_CMDID_GET_OBJ_REG,
+						  cmd_flags, token);
+	}
 
 	cmd_params = (struct dprc_cmd_get_obj_region *)cmd.params;
 	cmd_params->obj_id = cpu_to_le32(obj_id);
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index e6fcff12c68d..8d65273a78d7 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -80,10 +80,12 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,
 /* DPRC command versioning */
 #define DPRC_CMD_BASE_VERSION			1
 #define DPRC_CMD_2ND_VERSION			2
+#define DPRC_CMD_3RD_VERSION			3
 #define DPRC_CMD_ID_OFFSET			4
 
 #define DPRC_CMD(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_BASE_VERSION)
 #define DPRC_CMD_V2(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_2ND_VERSION)
+#define DPRC_CMD_V3(id)	(((id) << DPRC_CMD_ID_OFFSET) | DPRC_CMD_3RD_VERSION)
 
 /* DPRC command IDs */
 #define DPRC_CMDID_CLOSE                        DPRC_CMD(0x800)
@@ -105,6 +107,7 @@ int dpmcp_reset(struct fsl_mc_io *mc_io,
 #define DPRC_CMDID_GET_OBJ                      DPRC_CMD(0x15A)
 #define DPRC_CMDID_GET_OBJ_REG                  DPRC_CMD(0x15E)
 #define DPRC_CMDID_GET_OBJ_REG_V2               DPRC_CMD_V2(0x15E)
+#define DPRC_CMDID_GET_OBJ_REG_V3               DPRC_CMD_V3(0x15E)
 #define DPRC_CMDID_SET_OBJ_IRQ                  DPRC_CMD(0x15F)
 
 #define DPRC_CMDID_GET_CONNECTION               DPRC_CMD(0x16C)
-- 
2.17.1

