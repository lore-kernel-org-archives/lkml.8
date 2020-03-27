Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3830C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 05:30:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B8420748
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 05:30:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s00siaw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgC0FaN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 01:30:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47077 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgC0FaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 01:30:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id s23so3028074plq.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 22:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6pEsB8AZFeEH+m7U/vg9ITtNO6GSqqFvYVzanp9D3jM=;
        b=s00siaw9b/dR1AYhBi91Mr+p0j3IVm6Shs6x4q1U6egYD5Zblk4G6Giw2S5CQZbXQW
         W3N0JUQ3NYvzq/WYT6sWhN3cZB1zJrZBp0Dw2D9qYlGtuI5Y3IdwS++agOFi7Sk1lLT5
         i/kTY3RaN2MCIeky7EqlONNnDkWxLALNQ0kGvdgGNfktseVyTUSOF3jRwxQ0xdvbQ62v
         s+lZvTktDdqN2MzyAjXbm29b31yyJlEuxqD0FLJfkR0sqfRpXKVFyeWQL1pRiWP2lEiV
         AujqCmw7hjObu/3QJzv7n23KoctQtEqyWaT9yjtc5ityLd8jZoSLkiUCnAss0xtFXdp5
         CvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6pEsB8AZFeEH+m7U/vg9ITtNO6GSqqFvYVzanp9D3jM=;
        b=BVMyRPFUHNpVGO33+CACjSL3EKh6DrV1bGI11ghOhTl+MFhS02xk22/I7Rk5L6X222
         TPAGjLU/l4Gp8OtgJUGVOzTFQVVI7s5fj/BqcD16T3j6UBjl6NtgoZL3n70ODVQsTEzH
         8In5WK7DFVmaqupr+m82rU01oxIezjoxXKQvUBBZLhyxKxy9Oz3rgw4lvUrF8g8N/CCu
         iu+RyvPphh5ijDeLrLgDa0l7cxh4JPuV/istEnYp8UyAwLL1ESSbJFX/4JQfF6nlXycK
         wQJkA5+kSuafBIB/QNeKTbEnM/E9dY/d6awLzV0iMKG4t0IZXqJyaDAwiY9yoOHnT1hb
         Zw1A==
X-Gm-Message-State: ANhLgQ3UEK2+7bg15+R9d7j7JdE1lkbyv2Qlp1WOUI/LONfWVWoNCi9Q
        sXv/BQwJsF18z6QAmYndMj+h+A==
X-Google-Smtp-Source: ADFU+vurGxV49J4dAN8FPtiEV/uCfmdmaaU/AYmFUxWctlsRaVlav2hzI8Rj6vhFXwRSESm5A7SuRg==
X-Received: by 2002:a17:902:8bc7:: with SMTP id r7mr11812061plo.12.1585287011622;
        Thu, 26 Mar 2020 22:30:11 -0700 (PDT)
Received: from localhost.localdomain ([117.210.211.37])
        by smtp.gmail.com with ESMTPSA id l5sm3003637pgt.10.2020.03.26.22.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 Mar 2020 22:30:10 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jens.wiklander@linaro.org
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        jerome@forissier.org, stuart.yoder@arm.com,
        daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v6 1/2] tee: enable support to register kernel memory
Date:   Fri, 27 Mar 2020 10:59:47 +0530
Message-Id: <1585286988-10671-2-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585286988-10671-1-git-send-email-sumit.garg@linaro.org>
References: <1585286988-10671-1-git-send-email-sumit.garg@linaro.org>
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

