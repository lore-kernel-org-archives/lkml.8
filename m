Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277C1C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECD0E2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597648477;
	bh=2ySxnifEZD8oaBtv2l66MKMMUsoZY8TKt22SdNRdIOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pHPQNFNUqRTUhACx5sGi9xG0kpuAKEY7Fo48NMokUWXsJi9ydMfK5a9/7L+qJ2i8/
	 XGQTScIinPWDCM9bZfzpz/wEEwBBlokeagKJ6t7POBdba0IbCxoE9vZXPLJHkWssSh
	 M61CNUjq6x3/d32u7Gj3ee+j2Kn+MfKvK2ZsZxKE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgHQHOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:14:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:57850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgHQHLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:11:19 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC1D72080D;
        Mon, 17 Aug 2020 07:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597648277;
        bh=2ySxnifEZD8oaBtv2l66MKMMUsoZY8TKt22SdNRdIOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XfHJoodD38UbgG1EJdPi0NswB9PFpNYTTIC5/Ne4s+q6hpeVzVi7OPAY70a6a+JJu
         q3vkuxz+Hz2uQIh203wHfY1z5AzeBV5Q1ORBPUqZ5gi1mDEgin2TpfCkdrKrcmTfo0
         7tZom32E7mW7pgnyG4hot6tOnB2vIrw8ItqbmL9s=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k7ZIY-00BdjQ-Vk; Mon, 17 Aug 2020 09:11:14 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: [PATCH v3 06/44] staging: spmi: hisi-spmi-controller: use le32 macros where needed
Date:   Mon, 17 Aug 2020 09:10:25 +0200
Message-Id: <927ac4f981649318dba399e46a1aa429c428cfa3.1597647359.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of manually using bswap_32(), just use the
le32 macros.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/hisi-spmi-controller.c   | 20 +++++++------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/hikey9xx/hisi-spmi-controller.c b/drivers/staging/hikey9xx/hisi-spmi-controller.c
index 7fae267a6062..cacd28150b49 100644
--- a/drivers/staging/hikey9xx/hisi-spmi-controller.c
+++ b/drivers/staging/hikey9xx/hisi-spmi-controller.c
@@ -11,7 +11,6 @@
 #include <linux/module.h>
 #include <linux/seq_file.h>
 #include <linux/spmi.h>
-#include <linux/spmi.h>
 
 #define SPMI_CONTROLLER_NAME		"spmi_controller"
 
@@ -43,11 +42,6 @@
 #define SPMI_APB_SPMI_CMD_TYPE_OFFSET			24
 #define SPMI_APB_SPMI_CMD_LENGTH_OFFSET			20
 
-#define bswap_32(X)   \
-    ((((u32)(X) & 0xff000000) >> 24) | \
-     (((u32)(X) & 0x00ff0000) >> 8) | \
-     (((u32)(X) & 0x0000ff00) << 8) | \
-     (((u32)(X) & 0x000000ff) << 24))
 #define SPMI_APB_SPMI_CMD_SLAVEID_OFFSET		16
 #define SPMI_APB_SPMI_CMD_ADDR_OFFSET			0
 
@@ -179,14 +173,15 @@ static int spmi_read_cmd(struct spmi_controller *ctrl,
 
 	writel(cmd, spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_CMD_BASE_ADDR);
 
-	rc = spmi_controller_wait_for_done(spmi_controller, spmi_controller->base, sid, addr);
+	rc = spmi_controller_wait_for_done(spmi_controller,
+					   spmi_controller->base, sid, addr);
 	if (rc)
 		goto done;
 
 	i = 0;
 	do {
 		data = readl(spmi_controller->base + chnl_ofst + SPMI_SLAVE_OFFSET * sid + SPMI_APB_SPMI_RDATA0_BASE_ADDR + i * SPMI_PER_DATAREG_BYTE);
-		data = bswap_32(data);
+		data = be32_to_cpu((__be32)data);
 		if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
 			memcpy(buf, &data, sizeof(data));
 			buf += sizeof(data);
@@ -210,8 +205,7 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
 {
 	struct spmi_controller_dev *spmi_controller = dev_get_drvdata(&ctrl->dev);
 	unsigned long flags;
-	u32 cmd;
-	u32 data = 0;
+	u32 cmd, data;
 	int rc;
 	u32 chnl_ofst = SPMI_CHANNEL_OFFSET * spmi_controller->channel;
 	u8 op_code, i;
@@ -246,7 +240,7 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
 
 	i = 0;
 	do {
-		memset(&data, 0, sizeof(data));
+		data = 0;
 		if ((bc - i * SPMI_PER_DATAREG_BYTE) >> 2) {
 			memcpy(&data, buf, sizeof(data));
 			buf += sizeof(data);
@@ -255,8 +249,8 @@ static int spmi_write_cmd(struct spmi_controller *ctrl,
 			buf += (bc % SPMI_PER_DATAREG_BYTE);
 		}
 
-		data = bswap_32(data);
-		writel(data, spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_WDATA0_BASE_ADDR + SPMI_PER_DATAREG_BYTE * i);
+		writel((u32)cpu_to_be32(data),
+		       spmi_controller->base + chnl_ofst + SPMI_APB_SPMI_WDATA0_BASE_ADDR + SPMI_PER_DATAREG_BYTE * i);
 		i++;
 	} while (bc > i * SPMI_PER_DATAREG_BYTE);
 
-- 
2.26.2

