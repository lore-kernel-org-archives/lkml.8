Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C9FC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 11:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74BDE206B5
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 11:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+Fy/C62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbgHIL6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 07:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgHIL6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 07:58:43 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA160C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 04:58:42 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 9so5324046wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 04:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=M/b4J1cMbw6iLkItrWjESTJnmCJ1lTczlOCi5qx9M/s=;
        b=Z+Fy/C621J12TNPLFmpI9XKhaa4nzFb0IP+HrR/drT/wMGfpATov/XwKnhpAcbBs4m
         LHdrdUjjwLICPtd32zoEIfRdByRKK3Ghx1xDiX3RVhc0t3HTUbFBJx2FiN4XjhrG7F7v
         1h5OCaKQ79hdEceHKk20gvNz7+vvrC4oikhBXEXHLMiZxjg+MT14id2Rof18gfI/TWfa
         1Q4syEmeVYzxpgo6CpPYaVDdfjPY6Fn+idKGef1XxrP77yQhyDlknvAMzmGoD1X7cxsw
         nBmgc2LvXttQLb8Meg6oNBdtYqMKmlHAlHSLRyGyRTHJDV697PjJnBnFtbE+4uX3OrQC
         1vYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=M/b4J1cMbw6iLkItrWjESTJnmCJ1lTczlOCi5qx9M/s=;
        b=ubvT6ntlZUMax6lVGtHbaIuflOoXLvssYwA9UaP//69xKG7ZnDdsDNSlX8oQGu0IyT
         SxuPXFYOZ2oydRdtSfMTHHJLWAmqf2vqlQeBKAcaF703SqD6nrwJRelXzxeDlyT7Img+
         eEU8p0q2sd2rHUsx0yItm2DkhZeom7xkuJi4PBprdUf9ILNOwyQgtg/yz956zjREc55v
         Ww1YjEZmf6SPO2BvS6sCIMBRYVbxSMWz/4aM3K+TRyi4JH0goGdnmeeM61tlRbWeEQLI
         +V3yY4XXXVe0mEbtyo80CjV4VHBhohCktIlPjvJZk6ywcr2GgsrpBBjz6wnsP47ROtsP
         aoOQ==
X-Gm-Message-State: AOAM530lTyNLIyaOU6Rl+n1fwPjjV6H7g9hTqL5KhcD+HNxE7ihQNY/7
        i/9yf11gdhr+5veGpnaRwEn8ryfu
X-Google-Smtp-Source: ABdhPJygrw0dtWpSgqKpmvpxInWI+or1gcxmOPpy69d/3aN3sg8gcx8iJz1cMXhCCGc9O5B2VBhxYw==
X-Received: by 2002:a7b:c8da:: with SMTP id f26mr21414120wml.126.1596974321159;
        Sun, 09 Aug 2020 04:58:41 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id o124sm17620369wmb.2.2020.08.09.04.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 04:58:40 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Dotan Barak <dbarak@habana.ai>
Subject: [PATCH] habanalabs: print the queue id in case of an error
Date:   Sun,  9 Aug 2020 14:58:37 +0300
Message-Id: <20200809115837.4823-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dotan Barak <dbarak@habana.ai>

If there is a failure during the testing of a queue,
to ease up debugging - print the queue id.

Signed-off-by: Dotan Barak <dbarak@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 9 ++++++---
 drivers/misc/habanalabs/goya/goya.c   | 9 ++++++---
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 437219985327..6febfe4fdd81 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3427,7 +3427,8 @@ static int gaudi_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 							&fence_dma_addr);
 	if (!fence_ptr) {
 		dev_err(hdev->dev,
-			"Failed to allocate memory for queue testing\n");
+			"Failed to allocate memory for H/W queue %d testing\n",
+			hw_queue_id);
 		return -ENOMEM;
 	}
 
@@ -3438,7 +3439,8 @@ static int gaudi_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 					GFP_KERNEL, &pkt_dma_addr);
 	if (!fence_pkt) {
 		dev_err(hdev->dev,
-			"Failed to allocate packet for queue testing\n");
+			"Failed to allocate packet for H/W queue %d testing\n",
+			hw_queue_id);
 		rc = -ENOMEM;
 		goto free_fence_ptr;
 	}
@@ -3455,7 +3457,8 @@ static int gaudi_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 					pkt_dma_addr);
 	if (rc) {
 		dev_err(hdev->dev,
-			"Failed to send fence packet\n");
+			"Failed to send fence packet to H/W queue %d\n",
+			hw_queue_id);
 		goto free_pkt;
 	}
 
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index c497ae25c331..77a5963a4d10 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2927,7 +2927,8 @@ int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 							&fence_dma_addr);
 	if (!fence_ptr) {
 		dev_err(hdev->dev,
-			"Failed to allocate memory for queue testing\n");
+			"Failed to allocate memory for H/W queue %d testing\n",
+			hw_queue_id);
 		return -ENOMEM;
 	}
 
@@ -2938,7 +2939,8 @@ int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 					GFP_KERNEL, &pkt_dma_addr);
 	if (!fence_pkt) {
 		dev_err(hdev->dev,
-			"Failed to allocate packet for queue testing\n");
+			"Failed to allocate packet for H/W queue %d testing\n",
+			hw_queue_id);
 		rc = -ENOMEM;
 		goto free_fence_ptr;
 	}
@@ -2955,7 +2957,8 @@ int goya_test_queue(struct hl_device *hdev, u32 hw_queue_id)
 					pkt_dma_addr);
 	if (rc) {
 		dev_err(hdev->dev,
-			"Failed to send fence packet\n");
+			"Failed to send fence packet to H/W queue %d\n",
+			hw_queue_id);
 		goto free_pkt;
 	}
 
-- 
2.17.1

