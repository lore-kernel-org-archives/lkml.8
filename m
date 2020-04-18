Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0EAC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F93C214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbphPSFh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgDRIY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 04:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726089AbgDRIYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 04:24:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBF2C061A0F
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:24:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id g12so5330892wmh.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mKNbAPK+EGyLOfQgeFZW1qJkb+J+XOAX0oV59UJYhF0=;
        b=qbphPSFhwmsnK8eujMKUPDuPD2WQjOHwLffxgOCegJrlv4+MIcaRXeIVQD519h2/RA
         rLh7LMHlJXb8CkC5fTfcUAiUuzYECw+KrMkkJRwzrAU2LWIXUKVNHZhaFpydASrqMSQU
         z2XWLaNk30rrO6Lbu747Jlb/ov6CSmRFQSxAaXzEgxqYXk2MKD/mPTkSS73FNoJXMo/O
         PdGmT96XSAJANASddz13ACgLqLm4mD3nRuDds4nkPVWNSueS4dbFh1KL4F7n+FAZwfke
         UohblkuNN3l03xAi+krTwXIrjBdpopR5CLCw1yVI2q7bw9b3pc5FWQLCg7yIzuqGSC4T
         +tuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mKNbAPK+EGyLOfQgeFZW1qJkb+J+XOAX0oV59UJYhF0=;
        b=Cq5/lpHSrmIzWCDO35Xx9+VqBK3PGJ93ZsCJvH0Enaf7mb5yJZBuFaJjT7zIPgldba
         q4n8zvegIneiub3tDCYEBOZJDWcUo87kePJwEuNJPjdllBtV1t7JUvwMj5ifd+rVKC0p
         7d1ghfliUNuyi814JSaSKkP2tBwBhxlGYXfrrGJisvFzUDCZJo2J8bwDyFn3JQkCy+gk
         ga5bfvlHb2s/QLfO/1MZXGE0b5dHjJgfRM/GWrituKgunnVsgSaWaHKtYhPuEt1b2cxP
         yVvyG5XNqdS7VRvXK2NcMXl+EZ19uC4mJZT5TCypKJo8GYwmx2kXgde/i1nWv6gh9h7Q
         0ejA==
X-Gm-Message-State: AGi0Pub3gdq1vcO2QddcOeR21yxB4YENI7gMSUlZhcbzkLqjcJ0y0UKx
        cPVPzYNX0VvGZ2T+/uN/rNxSwR1t
X-Google-Smtp-Source: APiQypI5B2aQ6EbjJuFamk6zcVY0a6VEe8jMySmVuZU2q7xh3EMqlO/qTASWKEopOaFgGVQ3XfqyVw==
X-Received: by 2002:a1c:2d02:: with SMTP id t2mr7188000wmt.98.1587198292473;
        Sat, 18 Apr 2020 01:24:52 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c190sm10898087wme.4.2020.04.18.01.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 01:24:51 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 5/5] habanalabs: leave space for 2xMSG_PROT in CB
Date:   Sat, 18 Apr 2020 11:24:40 +0300
Message-Id: <20200418082440.21277-5-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200418082440.21277-1-oded.gabbay@gmail.com>
References: <20200418082440.21277-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The user must leave space for 2xMSG_PROT in the external CB, so adjust the
define of max size accordingly. The driver, however, can still create a CB
with the maximum size of 2MB. Therefore, we need to add a check
specifically for the user requested size.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_buffer.c | 24 +++++++++++++++++-------
 include/uapi/misc/habanalabs.h           |  3 ++-
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/habanalabs/command_buffer.c b/drivers/misc/habanalabs/command_buffer.c
index 53fddbd8e693..6cb92efce4d9 100644
--- a/drivers/misc/habanalabs/command_buffer.c
+++ b/drivers/misc/habanalabs/command_buffer.c
@@ -105,10 +105,9 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 		goto out_err;
 	}
 
-	if (cb_size > HL_MAX_CB_SIZE) {
-		dev_err(hdev->dev,
-			"CB size %d must be less then %d\n",
-			cb_size, HL_MAX_CB_SIZE);
+	if (cb_size > SZ_2M) {
+		dev_err(hdev->dev, "CB size %d must be less than %d\n",
+			cb_size, SZ_2M);
 		rc = -EINVAL;
 		goto out_err;
 	}
@@ -211,7 +210,7 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 {
 	union hl_cb_args *args = data;
 	struct hl_device *hdev = hpriv->hdev;
-	u64 handle;
+	u64 handle = 0;
 	int rc;
 
 	if (hl_device_disabled_or_in_reset(hdev)) {
@@ -223,15 +222,26 @@ int hl_cb_ioctl(struct hl_fpriv *hpriv, void *data)
 
 	switch (args->in.op) {
 	case HL_CB_OP_CREATE:
-		rc = hl_cb_create(hdev, &hpriv->cb_mgr, args->in.cb_size,
-					&handle, hpriv->ctx->asid);
+		if (args->in.cb_size > HL_MAX_CB_SIZE) {
+			dev_err(hdev->dev,
+				"User requested CB size %d must be less than %d\n",
+				args->in.cb_size, HL_MAX_CB_SIZE);
+			rc = -EINVAL;
+		} else {
+			rc = hl_cb_create(hdev, &hpriv->cb_mgr,
+						args->in.cb_size, &handle,
+						hpriv->ctx->asid);
+		}
+
 		memset(args, 0, sizeof(*args));
 		args->out.cb_handle = handle;
 		break;
+
 	case HL_CB_OP_DESTROY:
 		rc = hl_cb_destroy(hdev, &hpriv->cb_mgr,
 					args->in.cb_handle);
 		break;
+
 	default:
 		rc = -ENOTTY;
 		break;
diff --git a/include/uapi/misc/habanalabs.h b/include/uapi/misc/habanalabs.h
index 4d593050c42b..523e511e6cff 100644
--- a/include/uapi/misc/habanalabs.h
+++ b/include/uapi/misc/habanalabs.h
@@ -209,7 +209,8 @@ struct hl_info_args {
 /* Opcode to destroy previously created command buffer */
 #define HL_CB_OP_DESTROY	1
 
-#define HL_MAX_CB_SIZE		0x200000	/* 2MB */
+/* 2MB minus 32 bytes for 2xMSG_PROT */
+#define HL_MAX_CB_SIZE		(0x200000 - 32)
 
 struct hl_cb_in {
 	/* Handle of CB or 0 if we want to create one */
-- 
2.17.1

