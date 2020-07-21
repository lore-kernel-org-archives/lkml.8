Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53E0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D5A206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 19:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbgGUTqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 15:46:11 -0400
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:14210 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730250AbgGUTqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 15:46:11 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Jul 2020 12:46:10 -0700
Received: from gurus-linux.qualcomm.com ([10.46.162.81])
  by ironmsg02-sd.qualcomm.com with ESMTP; 21 Jul 2020 12:46:10 -0700
Received: by gurus-linux.qualcomm.com (Postfix, from userid 383780)
        id 23AE915B2; Tue, 21 Jul 2020 12:46:10 -0700 (PDT)
From:   Guru Das Srinagesh <gurus@codeaurora.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     Subbaraman Narayanamurthy <subbaram@codeaurora.org>,
        David Collins <collinsd@codeaurora.org>,
        Anirudh Ghayal <aghayal@codeaurora.org>,
        Shyam Kumar Thella <sthella@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Guru Das Srinagesh <gurus@codeaurora.org>
Subject: [PATCH v2 1/1] nvmem: qcom-spmi-sdam: Enable multiple devices
Date:   Tue, 21 Jul 2020 12:46:01 -0700
Message-Id: <1595360761-640-1-git-send-email-gurus@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using pdev->id as the nvmem's config ID (which, by default, is
NVMEM_DEVID_NONE) prevents multiple instances of this driver from
probing because of the following error:

  sysfs: cannot create duplicate filename '/bus/nvmem/devices/spmi_sdam'

Use NVMEM_DEVID_AUTO as the NVMEM config ID to fix the issue.

Signed-off-by: Guru Das Srinagesh <gurus@codeaurora.org>
---
 drivers/nvmem/qcom-spmi-sdam.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/qcom-spmi-sdam.c b/drivers/nvmem/qcom-spmi-sdam.c
index 8682cda..a72704c 100644
--- a/drivers/nvmem/qcom-spmi-sdam.c
+++ b/drivers/nvmem/qcom-spmi-sdam.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (c) 2017 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2017, 2020 The Linux Foundation. All rights reserved.
  */
 
 #include <linux/device.h>
@@ -141,7 +141,7 @@ static int sdam_probe(struct platform_device *pdev)
 
 	sdam->sdam_config.dev = &pdev->dev;
 	sdam->sdam_config.name = "spmi_sdam";
-	sdam->sdam_config.id = pdev->id;
+	sdam->sdam_config.id = NVMEM_DEVID_AUTO;
 	sdam->sdam_config.owner = THIS_MODULE,
 	sdam->sdam_config.stride = 1;
 	sdam->sdam_config.word_size = 1;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

