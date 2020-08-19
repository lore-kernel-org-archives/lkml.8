Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB9DEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 06:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A47F820885
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 06:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbgHSG7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 02:59:53 -0400
Received: from inva020.nxp.com ([92.121.34.13]:35234 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727064AbgHSG7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 02:59:51 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D0091A02FF;
        Wed, 19 Aug 2020 08:59:48 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3F2EB1A0311;
        Wed, 19 Aug 2020 08:59:44 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 5199F4024E;
        Wed, 19 Aug 2020 08:59:34 +0200 (CEST)
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Li Yang <leoyang.li@nxp.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Ma <peng.ma@nxp.com>, Ran Wang <ran.wang_1@nxp.com>
Subject: [PATCH v4] soc: fsl: enable acpi support in RCPM driver
Date:   Wed, 19 Aug 2020 14:52:07 +0800
Message-Id: <20200819065207.43930-1-ran.wang_1@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Ma <peng.ma@nxp.com>

This patch enables ACPI support in RCPM driver.

Signed-off-by: Peng Ma <peng.ma@nxp.com>
Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
---
Change in v4:
 - Make commit subject more accurate
 - Remove unrelated new blank line

Change in v3:
 - Add #ifdef CONFIG_ACPI for acpi_device_id
 - Rename rcpm_acpi_imx_ids to rcpm_acpi_ids

Change in v2:
 - Update acpi_device_id to fix conflict with other driver

 drivers/soc/fsl/rcpm.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/rcpm.c b/drivers/soc/fsl/rcpm.c
index a093dbe..b5aa6db 100644
--- a/drivers/soc/fsl/rcpm.c
+++ b/drivers/soc/fsl/rcpm.c
@@ -2,7 +2,7 @@
 //
 // rcpm.c - Freescale QorIQ RCPM driver
 //
-// Copyright 2019 NXP
+// Copyright 2019-2020 NXP
 //
 // Author: Ran Wang <ran.wang_1@nxp.com>
 
@@ -13,6 +13,7 @@
 #include <linux/slab.h>
 #include <linux/suspend.h>
 #include <linux/kernel.h>
+#include <linux/acpi.h>
 
 #define RCPM_WAKEUP_CELL_MAX_SIZE	7
 
@@ -139,10 +140,19 @@ static const struct of_device_id rcpm_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rcpm_of_match);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id rcpm_acpi_ids[] = {
+	{"NXP0015",},
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, rcpm_acpi_ids);
+#endif
+
 static struct platform_driver rcpm_driver = {
 	.driver = {
 		.name = "rcpm",
 		.of_match_table = rcpm_of_match,
+		.acpi_match_table = ACPI_PTR(rcpm_acpi_ids),
 		.pm	= &rcpm_pm_ops,
 	},
 	.probe = rcpm_probe,
-- 
2.7.4

