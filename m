Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7D0C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E3F220788
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 12:19:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GKOe6uSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgCWMT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 08:19:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42133 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727401AbgCWMT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:19:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id e1so826631plt.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 05:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rih5mm8tGYdBVrpj+OAizwYNEvky+nGCkyDwxBcHL0I=;
        b=GKOe6uSuKg32ZxNzv3XnLfNlkJAo4vkIp/QA5CrmqRIj9nsLXz3BJo7mbKOj1Dwdn2
         uN9RjwDYWo2rCzCbfTniwEtwIOVEMTBCtgzku+ctHI+Sl+54LnOJlAUdAJXYPDUuWHQY
         B2lTPJ4DJ4KEfvBTNiGbMY6YR7WEP0BS4s8ZdCHzEXMC92jfmyL/Pox88pDzz9WT2aKA
         bVYgblSXMvOxbvAH5kzto35BCoapM2MmWENoo5/WqN1ECenpOuNZc6sEl6Am+CFIetTT
         aI2eFXr2wuYLmqMc4BnqVAkUZMVQO6XvglMAAfedezxVqr8yyh89Jh3qNCBgNUR2pHK4
         ApgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Rih5mm8tGYdBVrpj+OAizwYNEvky+nGCkyDwxBcHL0I=;
        b=rVA8Yz2GAl5jcdt+W7DDIInMTvyh8dVAT4XosW49uBeaJzXM+F6jyf3YZNfMHE7NPw
         kZnYiV6h4+N88fIG8aQuveSI2VzrejffxWwfP5SW3zd/Kyij5G450fqm3EEDoTfESRQJ
         Sx0Zb6EY9uVBS2KR2CMWGzIn0vvRSQG2qyjVpqId8Gf/C4tKWm2FkffdoQ/PHSRYwK/n
         AJZPQ1I6GS7jmSqBPQungFKj/D7xHnrsLCtURYYuW0M0xYIE/HQJYvTDK1Dc+PdOPqdr
         TXJ+fJSqeugBfWk+VPsJW7MZetGDhgAm9zYY4btB3MocE5NOZPa8/dgAI8uXN4e63uQM
         4PUQ==
X-Gm-Message-State: ANhLgQ0589wRrJbCRNjISkWd8pD/t5Bn2mVuDL7a+Cz9tWL+JlCQPVFQ
        O7l3Ih3ARQnqtRgPfl7gAo/icQ==
X-Google-Smtp-Source: ADFU+vtv0+gK4YSmzKTD7kfSav1nuIlmOdZI0/Uwfn7DlDUZp6teXaUFjLXjiGUgM4zxDuFlq1706A==
X-Received: by 2002:a17:902:26a:: with SMTP id 97mr22484920plc.82.1584965966369;
        Mon, 23 Mar 2020 05:19:26 -0700 (PDT)
Received: from localhost.localdomain ([117.210.211.37])
        by smtp.gmail.com with ESMTPSA id f15sm2964597pfd.215.2020.03.23.05.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Mar 2020 05:19:25 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        stuart.yoder@arm.com, daniel.thompson@linaro.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v4 1/2] tee: enable support to register kernel memory
Date:   Mon, 23 Mar 2020 17:48:29 +0530
Message-Id: <1584965910-19068-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1584965910-19068-1-git-send-email-sumit.garg@linaro.org>
References: <1584965910-19068-1-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support to register kernel memory reference with TEE. This change
will allow TEE bus drivers to register memory references.

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/tee_shm.c   | 26 ++++++++++++++++++++++++--
 include/linux/tee_drv.h |  1 +
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
index 937ac5a..b88274c 100644
--- a/drivers/tee/tee_shm.c
+++ b/drivers/tee/tee_shm.c
@@ -9,6 +9,7 @@
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
+#include <linux/uio.h>
 #include "tee_private.h"
 
 static void tee_shm_release(struct tee_shm *shm)
@@ -218,13 +219,14 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
 {
 	struct tee_device *teedev = ctx->teedev;
 	const u32 req_flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED;
+	const u32 req_ker_flags = TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED;
 	struct tee_shm *shm;
 	void *ret;
 	int rc;
 	int num_pages;
 	unsigned long start;
 
-	if (flags != req_flags)
+	if (flags != req_flags && flags != req_ker_flags)
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

