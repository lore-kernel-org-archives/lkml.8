Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54542C1975A
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C10C2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 13:26:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+Vd9GVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727180AbgCLN0U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:26:20 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:47103 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCLN0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 09:26:20 -0400
Received: by mail-pl1-f195.google.com with SMTP id w12so2655873pll.13;
        Thu, 12 Mar 2020 06:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yadWWPnf9zWB2WeGaGhSOgmwahmFfDSuIeUBZGwtGEM=;
        b=Q+Vd9GVPbHujjtRQGb4913nMo8ckaAWXGbCJl4pCA37gkJucBloMUBxnvjhqc2izNl
         OdmAlaGI8hmByyC3nCUN5/gONtRyG0vxuMd1sZr1rHZGWB302jUSE+UR80w31gTlMBfp
         35tm5odjj2V/0KxG5qGszSOVcpx4mmMmGpGV6jNyN2cWv9/wjunWQX01zvCbU6kbQcLR
         Supixt5/yAfoA/eQ98UH/MdB//GwK8AG2sBoVMQL94I2LM5j1V5yh4dP99RgfFUA4Hr3
         i/aHtD8THGwQscBD4uCgPpmrQfnUstRJ7Moow7tEuR66KVsqSBkHUh2JE96iq8VkSeA+
         w9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yadWWPnf9zWB2WeGaGhSOgmwahmFfDSuIeUBZGwtGEM=;
        b=Cc804InnGX+ZNjpjRfMXvKUi1Mn36DYeEb6SNcuF1gcFo/Jk+wWS0r47NR68S542lV
         3GaEZ3etI3OehmoFUI7dkMLtDhNJQCn+qDuFAKUL8PwMBDpJqPezUJIbqMlB88Axv6Q9
         sQgzGms/0W7YjyiCORN37fpl5+oa//wTmYIdSJxnMRvf8+4Z+iEIhbAk6RE+PMRjnpKE
         riQPnq41rUdQ2d/icKYDqYEP/UR7jgu/SxbGTGI0APlksKcVIKWdz30PPORqN9Hek3Ds
         H6QCaPp71spSb+Xp+wpAYP5r6V8yh/q9hUUwig9PlmE4JKrf59Dors6N14UpkOBQ9Hb3
         vGmA==
X-Gm-Message-State: ANhLgQ3ak0RUQx5d+3KKtt3oIa5UvZVRQcCDAoPGqNCgtMSamtukTbA+
        LYZJ6ySR/JtljVXGUkW0qRk=
X-Google-Smtp-Source: ADFU+vu+mM7W4MkJK9nhubqnVf7bXv7TCWWm5UXk/S7EldunzGAE3y1IYNikEu9M/prS78fKkvmArg==
X-Received: by 2002:a17:90a:f311:: with SMTP id ca17mr4201563pjb.6.1584019578882;
        Thu, 12 Mar 2020 06:26:18 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id d5sm49246859pga.36.2020.03.12.06.26.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Mar 2020 06:26:18 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     vkoul@kernel.org, dan.j.williams@intel.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang7@gmail.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: sprd: Set request pending flag when DMA controller is active
Date:   Thu, 12 Mar 2020 21:26:04 +0800
Message-Id: <02adbe4364ec436ec2c5bc8fd2386bab98edd884.1584019223.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhenfang Wang <zhenfang.wang@unisoc.com>

On new Spreadtrum platforms, when the CPU enters idle, it will close
the DMA controllers' clock to save power if the DMA controller is not
busy. Moreover the DMA controller's busy signal depends on the DMA
enable flag and the request pending flag.

When DMA controller starts to transfer data, which means we already
set the DMA enable flag, but now we should also set the request pending
flag, in case the DMA clock will be closed accidentally if the CPU
can not detect the DMA controller's busy signal.

Signed-off-by: Zhenfang Wang <zhenfang.wang@unisoc.com>
Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/dma/sprd-dma.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
index 9a31a315..c327eaa 100644
--- a/drivers/dma/sprd-dma.c
+++ b/drivers/dma/sprd-dma.c
@@ -486,6 +486,28 @@ static int sprd_dma_set_2stage_config(struct sprd_dma_chn *schan)
 	return 0;
 }
 
+static void sprd_dma_set_pending(struct sprd_dma_chn *schan, bool enable)
+{
+	struct sprd_dma_dev *sdev = to_sprd_dma_dev(&schan->vc.chan);
+	u32 reg, val, req_id;
+
+	if (schan->dev_id == SPRD_DMA_SOFTWARE_UID)
+		return;
+
+	/* The DMA request id always starts from 0. */
+	req_id = schan->dev_id - 1;
+
+	if (req_id < 32) {
+		reg = SPRD_DMA_GLB_REQ_PEND0_EN;
+		val = BIT(req_id);
+	} else {
+		reg = SPRD_DMA_GLB_REQ_PEND1_EN;
+		val = BIT(req_id - 32);
+	}
+
+	sprd_dma_glb_update(sdev, reg, val, enable ? val : 0);
+}
+
 static void sprd_dma_set_chn_config(struct sprd_dma_chn *schan,
 				    struct sprd_dma_desc *sdesc)
 {
@@ -532,6 +554,7 @@ static void sprd_dma_start(struct sprd_dma_chn *schan)
 	 */
 	sprd_dma_set_chn_config(schan, schan->cur_desc);
 	sprd_dma_set_uid(schan);
+	sprd_dma_set_pending(schan, true);
 	sprd_dma_enable_chn(schan);
 
 	if (schan->dev_id == SPRD_DMA_SOFTWARE_UID &&
@@ -543,6 +566,7 @@ static void sprd_dma_start(struct sprd_dma_chn *schan)
 static void sprd_dma_stop(struct sprd_dma_chn *schan)
 {
 	sprd_dma_stop_and_disable(schan);
+	sprd_dma_set_pending(schan, false);
 	sprd_dma_unset_uid(schan);
 	sprd_dma_clear_int(schan);
 	schan->cur_desc = NULL;
-- 
1.9.1

