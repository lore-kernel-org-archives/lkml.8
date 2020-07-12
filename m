Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83231C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 20:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E2D2206E2
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 20:46:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PV9QpEbj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgGLUqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 16:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgGLUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 16:46:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D912C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 13:46:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k6so11937983wrn.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 13:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=DVgRD0gh9eDqjQDFEqnBTiCeHKvrz/fk4Oqpfiqiea4=;
        b=PV9QpEbjD7fiynBLP7wcc9NLRn5N/ZzRHSYQL8edrx+QpBvrYNHD4gRnt9lJPV1SiM
         ao6UKktemlhmS+9tq8tDCgZPFZ9ARCbJSRx6GaWQuFnVtPOKT4ncgNpRcVgV6/jXQWtH
         hC1d+OM6AcqhS3JEQQNlFdbOqiLSs5Sk7Z7qS9xA1Be5U4VQWzB9iU/tOwOt0G7SpDLY
         8BYj+1DjYlVR7VaarQX3B4u0lnTUnLle1ol2fNp8Hqe/AOSQEduCiXhfh0GXiojE2o9i
         emi3Lw8/E+xYKAjoHJdzpwG023XzLXUp+965GbpfGUKKAltfKZDphNY6Hl5XuFMuh6TZ
         kazQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=DVgRD0gh9eDqjQDFEqnBTiCeHKvrz/fk4Oqpfiqiea4=;
        b=Cw8EOwY/S9GigTAWdB20rgO9D3+yaCm6o2asyufmLv8Tpc3U+8FZmiP7hgKRHjdoK4
         VSYDv0F2GCYv4W0bjzlmSqtkkY/KPHBJ6o8cnbJmF24Yy1WjPegTFoYKKW5uwOy/Tp2P
         CMI8sXCZkn/AuLA2P2uLuGeM3pNxQNraw/0WeMBZz0k8q07bVM4Qdpj7TkpsxJiTfZ5r
         2ZtvzjVw27tKvWcIag7RaNw2SFNf4Tm8wxGSoZI0CMZeHjEoMvz+waBhqHUyObPMtXfD
         fMJSAFrYcuZRxzEAQumJFSwigD9SKdTvs4iuslavJys60Fx1DYhRtEBE8QSr/wKW11IB
         li8A==
X-Gm-Message-State: AOAM531AxTKrOPolyDh6ecRR/vsofouJxm6RZaMcCJIgNFmBy+rdbcqA
        ZVsMEuqE7KsuA/Cnb8sLkGTW4+qw
X-Google-Smtp-Source: ABdhPJx6vg2I9tq4NnUwBPSYP54oKsO1xZOoBHv0qDfVEBeSztk6PQQ18BAGMQgalft4DlTeDvhXpA==
X-Received: by 2002:adf:ec42:: with SMTP id w2mr77621794wrn.269.1594586776907;
        Sun, 12 Jul 2020 13:46:16 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id h13sm19779806wml.42.2020.07.12.13.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 13:46:15 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: prevent possible out-of-bounds array access
Date:   Sun, 12 Jul 2020 23:46:21 +0300
Message-Id: <20200712204621.29357-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queue index is received from the user. Therefore, we must validate it
before using it to access the queue props array.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index b0f62cbbdc87..f3a8f113865d 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -499,11 +499,19 @@ static int validate_queue_index(struct hl_device *hdev,
 	struct asic_fixed_properties *asic = &hdev->asic_prop;
 	struct hw_queue_properties *hw_queue_prop;
 
+	/* This must be checked here to prevent out-of-bounds access to
+	 * hw_queues_props array
+	 */
+	if (chunk->queue_index >= HL_MAX_QUEUES) {
+		dev_err(hdev->dev, "Queue index %d is invalid\n",
+			chunk->queue_index);
+		return -EINVAL;
+	}
+
 	hw_queue_prop = &asic->hw_queues_props[chunk->queue_index];
 
-	if ((chunk->queue_index >= HL_MAX_QUEUES) ||
-			(hw_queue_prop->type == QUEUE_TYPE_NA)) {
-		dev_err(hdev->dev, "Queue index %d is invalid\n",
+	if (hw_queue_prop->type == QUEUE_TYPE_NA) {
+		dev_err(hdev->dev, "Queue index %d is not applicable\n",
 			chunk->queue_index);
 		return -EINVAL;
 	}
-- 
2.17.1

