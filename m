Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A997CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E99F20747
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRKNHjez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgGENMu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgGENMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 09:12:48 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A938BC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 06:12:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so37877340wrv.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 06:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=v73geGNQdJRSU+D/5TIQX1X5VJYVJpSHvUsz4xsJQmA=;
        b=lRKNHjezwtZTmTkeBX9SunbIIFxAC4q+npjWnJMgBGmegnvSYvg67c8V7qfSDCFCAy
         rRR3MXf0SFCmsmDlt2w0fh7cux/YVF7+gj0Kyu3PCOw/OPLYwqCYmsjY6WGQdiKVmAcg
         SVT7V3STuYaX7DsdcUJXS6VpBb4ys1+Z7XYyQPc8rLBJyyaC4uOm3dGAAmsNUu2td3lc
         WoAa3tDw1/nAiWNheq3KMmnEoNddcQAyV1WSxM/3HDWMj1UmXoA14cWdXDenhR3KEpA+
         OkJMJVYsMtiQgJl0KDRVUSSP04Xu6Kxr2JFIZG4ZGqgxdYH+1yZmzI4xXENGAI+n3j5A
         UY1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=v73geGNQdJRSU+D/5TIQX1X5VJYVJpSHvUsz4xsJQmA=;
        b=Nxq32XWQkHY+qFY1V8+HzX1MpsqmyCMbWCsjBYSmmlf/7iaZWqdCSq5PT0ybijmRvV
         rj+WWODyV6yuFz04MeQ5zyth4j/EEByYV3tpeP6xmRJ1rVku8sEpnEHSWGmY2NVG3MqL
         7PGwxGgCFHTCDyvL0U9u2afBsz6OBa2JJMsPWpP0gVnGGunnowcYRb9//S7hf5IHMXW2
         FdeFxYDHhoRZ5tFMzPTPEvH1PudCkqRa099V5GmTf6GdzrTLulBjxuYcLgwrN+ZSqkCO
         Uk4h1YWa7PbuGoV8ZonGXOv7GO34OwMavlqOA4RaoOJHnOb95JoLY7vUPzquuEGfHDjv
         YYAg==
X-Gm-Message-State: AOAM530Y/7w67S2pd95VPyXGUvaFyvJxAfMWBQX92O0PEjGwC7p6/zf0
        yvnJYLFUk23XYI+OO19tWZw2rUkr
X-Google-Smtp-Source: ABdhPJyYkLN4gMCaVA6nLKAIB60NKjW36QNlqorhiaIkB7W9Sdli9LBTiNrZEIQ4jgbVcLpzftAM/Q==
X-Received: by 2002:adf:c3c7:: with SMTP id d7mr42970669wrg.51.1593954766111;
        Sun, 05 Jul 2020 06:12:46 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id 26sm19401809wmj.25.2020.07.05.06.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 06:12:45 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 2/9] habanalabs: rephrase error messages
Date:   Sun,  5 Jul 2020 16:12:38 +0300
Message-Id: <20200705131245.9368-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200705131245.9368-1-oded.gabbay@gmail.com>
References: <20200705131245.9368-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rephrase some error/warning/notice messages to make them more accessible to
ordinary users.

There is no need to print context ASID as the driver currently doesn't
support multiple contexts.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c | 20 +++++++++++++-------
 drivers/misc/habanalabs/context.c            |  3 +--
 drivers/misc/habanalabs/firmware_if.c        |  4 ++--
 drivers/misc/habanalabs/memory.c             |  3 +--
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 62dab99dda98..f81d6685e011 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -373,9 +373,9 @@ static void cs_timedout(struct work_struct *work)
 	hdev = cs->ctx->hdev;
 	ctx_asid = cs->ctx->asid;
 
-	/* TODO: add information about last signaled seq and last emitted seq */
-	dev_err(hdev->dev, "User %d command submission %llu got stuck!\n",
-		ctx_asid, cs->sequence);
+	dev_err(hdev->dev,
+		"Command submission %llu has not finished in time!\n",
+		cs->sequence);
 
 	cs_put(cs);
 
@@ -1130,7 +1130,7 @@ static long _hl_cs_wait_ioctl(struct hl_device *hdev,
 		rc = PTR_ERR(fence);
 		if (rc == -EINVAL)
 			dev_notice_ratelimited(hdev->dev,
-				"Can't wait on seq %llu because current CS is at seq %llu\n",
+				"Can't wait on CS %llu because current CS is at seq %llu\n",
 				seq, ctx->cs_sequence);
 	} else if (fence) {
 		rc = dma_fence_wait_timeout(fence, true, timeout);
@@ -1163,15 +1163,21 @@ int hl_cs_wait_ioctl(struct hl_fpriv *hpriv, void *data)
 	memset(args, 0, sizeof(*args));
 
 	if (rc < 0) {
-		dev_err_ratelimited(hdev->dev,
-				"Error %ld on waiting for CS handle %llu\n",
-				rc, seq);
 		if (rc == -ERESTARTSYS) {
+			dev_err_ratelimited(hdev->dev,
+				"user process got signal while waiting for CS handle %llu\n",
+				seq);
 			args->out.status = HL_WAIT_CS_STATUS_INTERRUPTED;
 			rc = -EINTR;
 		} else if (rc == -ETIMEDOUT) {
+			dev_err_ratelimited(hdev->dev,
+				"CS %llu has timed-out while user process is waiting for it\n",
+				seq);
 			args->out.status = HL_WAIT_CS_STATUS_TIMEDOUT;
 		} else if (rc == -EIO) {
+			dev_err_ratelimited(hdev->dev,
+				"CS %llu has been aborted while user process is waiting for it\n",
+				seq);
 			args->out.status = HL_WAIT_CS_STATUS_ABORTED;
 		}
 		return rc;
diff --git a/drivers/misc/habanalabs/context.c b/drivers/misc/habanalabs/context.c
index 1b96fefa4a65..1e3e5b19ecd9 100644
--- a/drivers/misc/habanalabs/context.c
+++ b/drivers/misc/habanalabs/context.c
@@ -112,8 +112,7 @@ void hl_ctx_free(struct hl_device *hdev, struct hl_ctx *ctx)
 		return;
 
 	dev_warn(hdev->dev,
-		"Context %d closed or terminated but its CS are executing\n",
-		ctx->asid);
+		"user process released device but its command submissions are still executing\n");
 }
 
 int hl_ctx_init(struct hl_device *hdev, struct hl_ctx *ctx, bool is_kernel_ctx)
diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
index 6900c01d060f..9e7f203a09d7 100644
--- a/drivers/misc/habanalabs/firmware_if.c
+++ b/drivers/misc/habanalabs/firmware_if.c
@@ -289,7 +289,7 @@ int hl_fw_armcp_info_get(struct hl_device *hdev)
 					HL_ARMCP_INFO_TIMEOUT_USEC, &result);
 	if (rc) {
 		dev_err(hdev->dev,
-			"Failed to send ArmCP info pkt, error %d\n", rc);
+			"Failed to handle ArmCP info pkt, error %d\n", rc);
 		goto out;
 	}
 
@@ -340,7 +340,7 @@ int hl_fw_get_eeprom_data(struct hl_device *hdev, void *data, size_t max_size)
 
 	if (rc) {
 		dev_err(hdev->dev,
-			"Failed to send ArmCP EEPROM packet, error %d\n", rc);
+			"Failed to handle ArmCP EEPROM packet, error %d\n", rc);
 		goto out;
 	}
 
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 47da84a17719..e4e1693e5c6c 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -1730,8 +1730,7 @@ void hl_vm_ctx_fini(struct hl_ctx *ctx)
 	 */
 	if (!hdev->hard_reset_pending && !hash_empty(ctx->mem_hash))
 		dev_notice(hdev->dev,
-				"ctx %d is freed while it has va in use\n",
-				ctx->asid);
+			"user released device without removing its memory mappings\n");
 
 	hash_for_each_safe(ctx->mem_hash, i, tmp_node, hnode, node) {
 		dev_dbg(hdev->dev,
-- 
2.17.1

