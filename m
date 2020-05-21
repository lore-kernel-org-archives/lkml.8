Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E6EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B6712065F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jq6ZJqV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgEUHCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728000AbgEUHCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:02:16 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E7C8C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 00:02:14 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so1334706wru.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 00:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LEMen+xsA6qxMWbCQqco6Cjvh1dtSQNqj0Uunndr3LE=;
        b=Jq6ZJqV+XpCkC148hfZCiSUkCElFrAoq1soivuhDpjftmmrcsr3t0Dj1jLSN3RE3Gh
         Ak86lrD8kB2EPPJOs8WNA8x4GJSbSNyo8C8N9Kl1J4n7rUDC5UsznJZ9+RaUQrMYiIm8
         gjEFy2dz9eHqD07s447Tikzwp1YHjZMl+77E3tcfx4IC6NS4oLAObOQI65IGXB/EkOfY
         WJ3/386jEXUvGtYvudsL2ZjYh0Hk0VgLmRkdua4hbBFDEdPm73ry7lgFO9ZJwGBQdXWD
         GXk7WG7g6P1AC9w4yIUq1ND/VXPuQ7fMofe4LoqJYJ7B6SKXqZpFFT0GK4FGd3zBzsTX
         ZtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LEMen+xsA6qxMWbCQqco6Cjvh1dtSQNqj0Uunndr3LE=;
        b=JoL7erDl367fqa2VBlR58ZB/aiVdbLP7Dba99uBU+AJyA42qd2xUBcoGqHrn4bruW0
         nrym1L8+cmHzKLA6uZpSwwVzJdid7RX7M4eEZQpERRImuT71rPfHiqSOJ6UhudG2cy/h
         XO4aL2z3UZtSnji2QAJP7ikD2szEk3taBU0B9o8m5KItCeyV2TQU/e9kBydhsqLohcSj
         gDRxVrm6qXS+a1YDksnCb46qIvI5ltvTDXPo5RQK9PT8d4dGcvkYofZs6UEzNLAEIXuT
         U+XfH0nyLJVBgFvk8NTx3LbfkWdZuobOaXQ1z36+QdS1Z/Owk0RAUZc8CFaoov7X5ojd
         FFWw==
X-Gm-Message-State: AOAM532bZykCT0ue4jwpfQjwJtSxER6JOBT2Nbha7L1k/hBd3jcDwxkk
        8OpDY/dDGs2dPtShqWgxLnJawU0c
X-Google-Smtp-Source: ABdhPJyjs6IPVAHaVZL0TryluA6418I2iAWrT1XcIPaUpqzG7Be3OegC8VWJj0QifwWfUOKzN0LOXA==
X-Received: by 2002:a5d:4d89:: with SMTP id b9mr7789323wru.210.1590044532789;
        Thu, 21 May 2020 00:02:12 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id w20sm5448205wmk.25.2020.05.21.00.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 00:02:11 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 1/4] habanalabs: improve MMU cache invalidation code
Date:   Thu, 21 May 2020 10:02:02 +0300
Message-Id: <20200521070205.26673-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

A new sequence is introduced to invalidate the MMU cache in order to avoid
timeouts.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 4cb1f71dd4f1..093384731f0d 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5982,16 +5982,18 @@ static void gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 		timeout_usec = MMU_CONFIG_TIMEOUT_USEC;
 
 	/* L0 & L1 invalidation */
-	WREG32(mmSTLB_INV_ALL_START, 1);
+	WREG32(mmSTLB_INV_PS, 2);
 
 	rc = hl_poll_timeout(
 		hdev,
-		mmSTLB_INV_ALL_START,
+		mmSTLB_INV_PS,
 		status,
 		!status,
 		1000,
 		timeout_usec);
 
+	WREG32(mmSTLB_INV_SET, 0);
+
 	if (rc)
 		dev_notice_ratelimited(hdev->dev,
 			"Timeout when waiting for MMU cache invalidation\n");
-- 
2.17.1

