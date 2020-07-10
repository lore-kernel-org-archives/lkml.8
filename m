Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF87C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:37:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4E22076A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 17:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Or5BdrrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgGJRhB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726977AbgGJRg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 13:36:58 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFD85C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:36:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so6980912wmj.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 10:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Iiz4rYBh0ppy8E6FVGSuhxlekX/0+s0wESvlaeRWIoE=;
        b=Or5BdrrCvZbbSE0fPN11pmiriYqwUOPDmjZPCkGG4uxThrPQeqKs79u9AtglL1lx9s
         qIPUd1l001+kGv1QhzHWTRbIo85y4c8iBW0k771L5mq9xcnC5V0PrLpD6Oj6vZrSk3z9
         GEQOmWaRD3GXCJyJpc2qzJVxksuiehDUNbRGOCMJsHfLNYEOVfOxop1HWCEVbKLGfsiz
         +AYpBQWG6IfG+TEVR4546T73GceNp1XGNtRTcXl5Z2EG5rLwu5yjGpmp7MsGm8yzTc45
         /lNHSfpytl4dE74hhiIN0oFLdtcFrKtAM3wK+X//vRFKlIK6D7csIH/yk+v5p024Ml0r
         WPXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Iiz4rYBh0ppy8E6FVGSuhxlekX/0+s0wESvlaeRWIoE=;
        b=KFCte3+RmxDydrbbT+qCg+OtkPcLoTX5vkF5nzezeWcWmu631sqOWiZlPeuRezy2xx
         mgKz1Jd0PBuI5tb4qeRgnZWfATLFqObRJZ7Vbpeg2SRRphrymMOtmgW/b3zgZbXuAaNQ
         PHEo796qZLyg6ac7SrhjKFrNA3pu52B18vjVqztV+lrbdwqNmK4l5fxIRfsUjqhWWML/
         LBlBgQbFRZRerDJN2gxGD3LfM0DIZ1aTNgWo0vhro9c1LC7hZf4LDRQ4IQOCfGzrm+nL
         h5uKe3CuQOQC+8PtxsD8Wdh32UVOxeeydbr26VApAEPTtYeTV+dBP8zGoWW/XjZ38P9/
         1/yQ==
X-Gm-Message-State: AOAM530JfOktGuh1DwM4id48PeEqTsfkIhJR2ynXhLB6Pf+67Err6tcE
        Fy9GkCr+iiMEDj3QNMxFagFYcopb
X-Google-Smtp-Source: ABdhPJyG30GMqmPugFhnU7rHKQuuDFM6rfeG5jCyYPpX+hMpml2iDX00qwWcNazvIA21hwQxort7Og==
X-Received: by 2002:a7b:c936:: with SMTP id h22mr5908728wml.114.1594402615413;
        Fri, 10 Jul 2020 10:36:55 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id n16sm9903857wmc.40.2020.07.10.10.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 10:36:54 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 4/4] habanalabs: check for DMA errors when clearing memory
Date:   Fri, 10 Jul 2020 20:36:52 +0300
Message-Id: <20200710173652.31039-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200710173652.31039-1-oded.gabbay@gmail.com>
References: <20200710173652.31039-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

In GAUDI we use QMAN0 DMA for clearing the MMU memory region
at initialization. if this operation fails it places the DMA in an error
state and then when trying to initialize QMAN0 we fail and erroneously
assume its the QMAN that failed.

This commit adds a check and clear of such DMA errors at initialization so
we will have a better understanding of what went wrong.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index a9fd3d352ef0..57b2b9392cb2 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -4253,7 +4253,7 @@ static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
 {
 	struct packet_lin_dma *lin_dma_pkt;
 	struct hl_cs_job *job;
-	u32 cb_size, ctl;
+	u32 cb_size, ctl, err_cause;
 	struct hl_cb *cb;
 	int rc;
 
@@ -4282,6 +4282,15 @@ static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
 		goto release_cb;
 	}
 
+	/* Verify DMA is OK */
+	err_cause = RREG32(mmDMA0_CORE_ERR_CAUSE);
+	if (err_cause && !hdev->init_done) {
+		dev_dbg(hdev->dev,
+			"Clearing DMA0 engine from errors (cause 0x%x)\n",
+			err_cause);
+		WREG32(mmDMA0_CORE_ERR_CAUSE, err_cause);
+	}
+
 	job->id = 0;
 	job->user_cb = cb;
 	job->user_cb->cs_cnt++;
@@ -4293,11 +4302,23 @@ static int gaudi_memset_device_memory(struct hl_device *hdev, u64 addr,
 	hl_debugfs_add_job(hdev, job);
 
 	rc = gaudi_send_job_on_qman0(hdev, job);
-
 	hl_debugfs_remove_job(hdev, job);
 	kfree(job);
 	cb->cs_cnt--;
 
+	/* Verify DMA is OK */
+	err_cause = RREG32(mmDMA0_CORE_ERR_CAUSE);
+	if (err_cause) {
+		dev_err(hdev->dev, "DMA Failed, cause 0x%x\n", err_cause);
+		rc = -EIO;
+		if (!hdev->init_done) {
+			dev_dbg(hdev->dev,
+				"Clearing DMA0 engine from errors (cause 0x%x)\n",
+				err_cause);
+			WREG32(mmDMA0_CORE_ERR_CAUSE, err_cause);
+		}
+	}
+
 release_cb:
 	hl_cb_put(cb);
 	hl_cb_destroy(hdev, &hdev->kernel_cb_mgr, cb->id << PAGE_SHIFT);
-- 
2.17.1

