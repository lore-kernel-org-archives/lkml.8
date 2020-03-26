Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E4CC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABE0720714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P0OU4TrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbgCZHYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:24:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39684 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgCZHYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:24:19 -0400
Received: by mail-pg1-f196.google.com with SMTP id b22so2442698pgb.6
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6pEsB8AZFeEH+m7U/vg9ITtNO6GSqqFvYVzanp9D3jM=;
        b=P0OU4TrKtw5tcXMcgz3q38L9ac3RFvsz+GrS7g4vuJ6yC5XQJRm8afO9QdiveIorxo
         ofdX7ICdu2um0/hxULxGZkL4jzbbI0e9FwkN9zK62z/8QRMCIBMkGSUZLIyUR1AAd6j4
         tkbVMUXfwfohzTohHDk5eKr1FMVw0+/QpZH/eZwD1FJ9b1gUcMM54Xj8Hnf31Ys68de0
         oHfeKL+VKg3LsziElDmO9mG77RdlXj5o2SPYkACb1ETAnkYDWMAOptNl4nJxqKkRs1Am
         weoYWApNkoaS4356uIf3WHRjFmfMu3f5MgNaECqoagiLq76cwcwFRtddjUrQISNLEx13
         pEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6pEsB8AZFeEH+m7U/vg9ITtNO6GSqqFvYVzanp9D3jM=;
        b=aHBcwVDjz//o0NMC6ugpmiSZxawetcQSeIylYszQ5pCrBxAgMJw3Dkl1Cn13pEiaGP
         PLb/ThIZXUJN9/wRmhmwDHeZJIZjDS4pQE5HwbokZrKF9LXY5o1munKXdD9UkRIKBMeU
         rFfEENhtQ9QAXtT9tHU3PpVErh+E6XOKWetVKCK5HS+TtlpfMF5Rj8gsOzmQaB/GiScm
         3354kAZHC4PCJxXKkeg6Bv6PazBmC6Cas6B/pvTbG0BDQSHovOdNnskngg8gmsOIVFiC
         wTGvd2I04EcAqYFcbCHWr8Hny+kANrcaTiWzo+Sy+xHXtWkaDLmxaxZUsAAYVnkOPAPz
         E+cQ==
X-Gm-Message-State: ANhLgQ2U5loKclM2tzTdrEcja63GrT5KPANSqBQoTER9ghMayQSE8Mto
        IWV7jZKw6O5K26YZDqEb33I6IQ==
X-Google-Smtp-Source: ADFU+vv5Hl+HKXyGSZVrO4kgI9yMeeIsXKrAU13TroldIduOGU+qFJ8M/+pZVz95wsFZwVONIguF/w==
X-Received: by 2002:aa7:9106:: with SMTP id 6mr7209801pfh.181.1585207458507;
        Thu, 26 Mar 2020 00:24:18 -0700 (PDT)
Received: from localhost.localdomain ([117.210.211.37])
        by smtp.gmail.com with ESMTPSA id e80sm979504pfh.117.2020.03.26.00.24.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Mar 2020 00:24:17 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        stuart.yoder@arm.com, daniel.thompson@linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v5 1/2] tee: enable support to register kernel memory
Date:   Thu, 26 Mar 2020 12:53:48 +0530
Message-Id: <1585207429-10630-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585207429-10630-1-git-send-email-sumit.garg@linaro.org>
References: <1585207429-10630-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support to register kernel memory reference with TEE. This change
will allow TEE bus drivers to register memory references.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/tee_shm.c   | 28 +++++++++++++++++++++++++---
 include/linux/tee_drv.h |  1 +
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 937ac5a..a6c75a4 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
+#include <linux/uio.h>
 #include "tee_private.h"
 
 static void tee_shm_release(struct tee_shm *shm)
@@ -217,14 +218,15 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 				 size_t length, u32 flags)
 {
 	struct tee_device *teedev = ctx->teedev;
-	const u32 req_flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED;
+	const u32 req_user_flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED;
+	const u32 req_kernel_flags = TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED;
 	struct tee_shm *shm;
 	void *ret;
 	int rc;
 	int num_pages;
 	unsigned long start;
 
-	if (flags != req_flags)
+	if (flags != req_user_flags && flags != req_kernel_flags)
 		return ERR_PTR(-ENOTSUPP);
 
 	if (!tee_device_get(teedev))
@@ -259,7 +261,27 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 		goto err;
 	}
 
-	rc = get_user_pages_fast(start, num_pages, FOLL_WRITE, shm->pages);
+	if (flags & TEE_SHM_USER_MAPPED) {
+		rc = get_user_pages_fast(start, num_pages, FOLL_WRITE,
+					 shm->pages);
+	} else {
+		struct kvec *kiov;
+		int i;
+
+		kiov = kcalloc(num_pages, sizeof(*kiov), GFP_KERNEL);
+		if (!kiov) {
+			ret = ERR_PTR(-ENOMEM);
+			goto err;
+		}
+
+		for (i = 0; i < num_pages; i++) {
+			kiov[i].iov_base = (void *)(start + i * PAGE_SIZE);
+			kiov[i].iov_len = PAGE_SIZE;
+		}
+
+		rc = get_kernel_pages(kiov, num_pages, 0, shm->pages);
+		kfree(kiov);
+	}
 	if (rc > 0)
 		shm->num_pages = rc;
 	if (rc != num_pages) {
diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
index 7a03f68..dedf8fa 100644
--- a/include/linux/tee_drv.h
+++ b/include/linux/tee_drv.h
@@ -26,6 +26,7 @@
 #define TEE_SHM_REGISTER	BIT(3)  /* Memory registered in secure world */
 #define TEE_SHM_USER_MAPPED	BIT(4)  /* Memory mapped in user space */
 #define TEE_SHM_POOL		BIT(5)  /* Memory allocated from pool */
+#define TEE_SHM_KERNEL_MAPPED	BIT(6)  /* Memory mapped in kernel space */
 
 struct device;
 struct tee_device;
-- 
2.7.4

