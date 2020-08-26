Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB764C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFA0E20786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgHZJ0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:26:25 -0400
Received: from inva020.nxp.com ([92.121.34.13]:56602 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgHZJ0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:26:10 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 420621A16BC;
        Wed, 26 Aug 2020 11:26:07 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 342841A16B9;
        Wed, 26 Aug 2020 11:26:07 +0200 (CEST)
Received: from fsr-ub1864-111.ea.freescale.net (fsr-ub1864-111.ea.freescale.net [10.171.82.141])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id CAFE72030A;
        Wed, 26 Aug 2020 11:26:06 +0200 (CEST)
From:   Diana Craciun <diana.craciun@oss.nxp.com>
To:     linux-kernel@vger.kernel.org, laurentiu.tudor@nxp.com
Cc:     stuyoder@gmail.com, leoyang.li@nxp.com, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, bharatb.linux@gmail.com,
        Bharat Bhushan <Bharat.Bhushan@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>
Subject: [PATCH v4 12/13] bus/fsl-mc: Extend ICID size from 16bit to 32bit
Date:   Wed, 26 Aug 2020 12:25:26 +0300
Message-Id: <20200826092527.4992-13-diana.craciun@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826092527.4992-1-diana.craciun@oss.nxp.com>
References: <20200826092527.4992-1-diana.craciun@oss.nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bharat Bhushan <Bharat.Bhushan@nxp.com>

In virtual machines the device-id range is defined
between 0x10000-0x20000. The reason for using such a
large range is to avoid overlapping with the PCI range.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
---
 drivers/bus/fsl-mc/dprc.c           | 2 +-
 drivers/bus/fsl-mc/fsl-mc-bus.c     | 2 +-
 drivers/bus/fsl-mc/fsl-mc-private.h | 5 ++---
 include/linux/fsl/mc.h              | 2 +-
 4 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/bus/fsl-mc/dprc.c b/drivers/bus/fsl-mc/dprc.c
index 2448a723eb28..650808799a29 100644
--- a/drivers/bus/fsl-mc/dprc.c
+++ b/drivers/bus/fsl-mc/dprc.c
@@ -360,7 +360,7 @@ int dprc_get_attributes(struct fsl_mc_io *mc_io,
 	/* retrieve response parameters */
 	rsp_params = (struct dprc_rsp_get_attributes *)cmd.params;
 	attr->container_id = le32_to_cpu(rsp_params->container_id);
-	attr->icid = le16_to_cpu(rsp_params->icid);
+	attr->icid = le32_to_cpu(rsp_params->icid);
 	attr->options = le32_to_cpu(rsp_params->options);
 	attr->portal_id = le32_to_cpu(rsp_params->portal_id);
 
diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 32f194814b08..d375bb585749 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -503,7 +503,7 @@ static int get_dprc_attr(struct fsl_mc_io *mc_io,
 }
 
 static int get_dprc_icid(struct fsl_mc_io *mc_io,
-			 int container_id, u16 *icid)
+			 int container_id, u32 *icid)
 {
 	struct dprc_attributes attr;
 	int error;
diff --git a/drivers/bus/fsl-mc/fsl-mc-private.h b/drivers/bus/fsl-mc/fsl-mc-private.h
index ffe709a3f0f8..3e9f9c778631 100644
--- a/drivers/bus/fsl-mc/fsl-mc-private.h
+++ b/drivers/bus/fsl-mc/fsl-mc-private.h
@@ -159,8 +159,7 @@ struct dprc_cmd_clear_irq_status {
 struct dprc_rsp_get_attributes {
 	/* response word 0 */
 	__le32 container_id;
-	__le16 icid;
-	__le16 pad;
+	__le32 icid;
 	/* response word 1 */
 	__le32 options;
 	__le32 portal_id;
@@ -337,7 +336,7 @@ int dprc_clear_irq_status(struct fsl_mc_io *mc_io,
  */
 struct dprc_attributes {
 	int container_id;
-	u16 icid;
+	u32 icid;
 	int portal_id;
 	u64 options;
 };
diff --git a/include/linux/fsl/mc.h b/include/linux/fsl/mc.h
index f791fe38c251..db244874e834 100644
--- a/include/linux/fsl/mc.h
+++ b/include/linux/fsl/mc.h
@@ -195,7 +195,7 @@ struct fsl_mc_device {
 	struct device dev;
 	u64 dma_mask;
 	u16 flags;
-	u16 icid;
+	u32 icid;
 	u16 mc_handle;
 	struct fsl_mc_io *mc_io;
 	struct fsl_mc_obj_desc obj_desc;
-- 
2.17.1

