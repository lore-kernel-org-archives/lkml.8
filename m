Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D75C3B188
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BAFB20873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 04:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgBLEfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 23:35:46 -0500
Received: from inva021.nxp.com ([92.121.34.21]:37988 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727918AbgBLEfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:35:45 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2AE5F2256C7;
        Wed, 12 Feb 2020 05:35:43 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1027E2256CC;
        Wed, 12 Feb 2020 05:35:36 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 6787C402B7;
        Wed, 12 Feb 2020 12:35:27 +0800 (SGT)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
        festevam@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ASoC: fsl_asrc: Move common definition to fsl_asrc_common
Date:   Wed, 12 Feb 2020 12:30:01 +0800
Message-Id: <916c5542c7248ee3dc9ebe5324b80beb2af9d1fa.1581475981.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1581475981.git.shengjiu.wang@nxp.com>
References: <cover.1581475981.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1581475981.git.shengjiu.wang@nxp.com>
References: <cover.1581475981.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a new ASRC included in i.MX serial platform, there
are some common definition can be shared with each other.
So move the common definition to a separate header file.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.h        | 11 +----------
 sound/soc/fsl/fsl_asrc_common.h | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 10 deletions(-)
 create mode 100644 sound/soc/fsl/fsl_asrc_common.h

diff --git a/sound/soc/fsl/fsl_asrc.h b/sound/soc/fsl/fsl_asrc.h
index 8a821132d9d0..e8abb27ffeda 100644
--- a/sound/soc/fsl/fsl_asrc.h
+++ b/sound/soc/fsl/fsl_asrc.h
@@ -10,8 +10,7 @@
 #ifndef _FSL_ASRC_H
 #define _FSL_ASRC_H
 
-#define IN	0
-#define OUT	1
+#include  "fsl_asrc_common.h"
 
 #define ASRC_DMA_BUFFER_NUM		2
 #define ASRC_INPUTFIFO_THRESHOLD	32
@@ -283,14 +282,6 @@
 #define ASRMCR1i_OW16_MASK		(1 << ASRMCR1i_OW16_SHIFT)
 #define ASRMCR1i_OW16(v)		((v) << ASRMCR1i_OW16_SHIFT)
 
-
-enum asrc_pair_index {
-	ASRC_INVALID_PAIR = -1,
-	ASRC_PAIR_A = 0,
-	ASRC_PAIR_B = 1,
-	ASRC_PAIR_C = 2,
-};
-
 #define ASRC_PAIR_MAX_NUM	(ASRC_PAIR_C + 1)
 
 enum asrc_inclk {
diff --git a/sound/soc/fsl/fsl_asrc_common.h b/sound/soc/fsl/fsl_asrc_common.h
new file mode 100644
index 000000000000..8acc55778ff2
--- /dev/null
+++ b/sound/soc/fsl/fsl_asrc_common.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2019 NXP
+ *
+ */
+
+#ifndef _FSL_ASRC_COMMON_H
+#define _FSL_ASRC_COMMON_H
+
+/* directions */
+#define IN	0
+#define OUT	1
+
+enum asrc_pair_index {
+	ASRC_INVALID_PAIR = -1,
+	ASRC_PAIR_A = 0,
+	ASRC_PAIR_B = 1,
+	ASRC_PAIR_C = 2,
+};
+
+#endif /* _FSL_ASRC_COMMON_H */
-- 
2.21.0

