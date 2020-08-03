Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9144EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B40220781
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 11:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTE7hykx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgHCL7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 07:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCL7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 07:59:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6752CC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 04:59:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f18so33948256wrs.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 04:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ODpe9Of45ypWSunkHclhehrlsNMAbcIDPO0bQQOojWM=;
        b=sTE7hykxYCkG2ZADx7ulHttXidfjjeQ9crUcnPQI4eM+L4SsKUlRLEFQ9nikm3MWxJ
         v4j86yWpTVw48VGsbnaTOicJ0tgKAvipUCDEfntU+frxMyJAjPTPPFIUT7M8WurPZPGq
         mZn53GlX7NnDD6vJ4AXIpgSH+h8JMDICUTHJpp36LkI861gZxGakfkEfbWoTYEzEaQY2
         zJOy0EHAr1y0l+LQP2Gk/aAHpUggjTGRF+WXnslb3esBrzqGDRj/GSRsvz1FAcugqCTn
         2KQgBF3ONCAfUBaW6uQv6QI3ICfqkJv5s7NaBI7nS7t+Gov5Uf5tMV+5DCFUVh+bKbVL
         sujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ODpe9Of45ypWSunkHclhehrlsNMAbcIDPO0bQQOojWM=;
        b=nhW2dPGyP0Aed9o11Ledk6QYoTSfXYRI6QRA+P1pAsceC76bKlLULvj6FBBsxZSLjr
         RAEDlXs5j7s+Zdl+zGgUy2aMNc6JugEbibfwHxD8fgC0c+w+2bybtDcf3Ueb4Foe/T13
         NmLGz1ATRLveeH8xTMvLMvHLs69XCgbUe2e+Hfghne+zKNg4KRrAY8GevedolzVQtYao
         ov844WwpApQh8ZH5/DWasvZYFgN3s4J56PwmcDWRYhs9Ly9y1+0llmIwbgOwy8bP7Wuf
         /4iyVZGxDEMnCqGnUl9fm6cCuMsRQ3/f6KKa0a59aXR99Hfu158pyVjyXjqTrkcIUvFH
         OCKA==
X-Gm-Message-State: AOAM530qKMAHssBgTvshewyjhlFnOM8JjwQSUVoJEu9qyIMQYVY7Z3MG
        J0J4r0akH9QcBK1Mi7v4xUjwGSJA
X-Google-Smtp-Source: ABdhPJx8n/0+c3xG/hnkCy+8tcT1xitkmOO5f2Z2MO+9lD1VJ7RgXJqgFDG93yB6BmEWo5JPClKRHw==
X-Received: by 2002:a5d:4610:: with SMTP id t16mr15620972wrq.101.1596455968654;
        Mon, 03 Aug 2020 04:59:28 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id j24sm26693444wrb.49.2020.08.03.04.59.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 04:59:27 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/2] habanalabs: Validate user address before mapping
Date:   Mon,  3 Aug 2020 14:59:24 +0300
Message-Id: <20200803115925.4908-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

User address must be validated before driver performs address map.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/command_buffer.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 7c38c4f7f9c0..a8004911c977 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -10,6 +10,7 @@
 
 #include <linux/mm.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
 #include <linux/genalloc.h>
 
 static void cb_fini(struct hl_device *hdev, struct hl_cb *cb)
@@ -300,7 +301,7 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_cb *cb;
 	phys_addr_t address;
-	u32 handle;
+	u32 handle, user_cb_size;
 	int rc;
 
 	handle = vma->vm_pgoff;
@@ -314,7 +315,8 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 	}
 
 	/* Validation check */
-	if ((vma->vm_end - vma->vm_start) != ALIGN(cb->size, PAGE_SIZE)) {
+	user_cb_size = vma->vm_end - vma->vm_start;
+	if (user_cb_size != ALIGN(cb->size, PAGE_SIZE)) {
 		dev_err(hdev->dev,
 			"CB mmap failed, mmap size 0x%lx != 0x%x cb size\n",
 			vma->vm_end - vma->vm_start, cb->size);
@@ -322,6 +324,16 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 		goto put_cb;
 	}
 
+	if (!access_ok((void __user *) (uintptr_t) vma->vm_start,
+							user_cb_size)) {
+		dev_err(hdev->dev,
+			"user pointer is invalid - 0x%lx\n",
+			vma->vm_start);
+
+		rc = -EINVAL;
+		goto put_cb;
+	}
+
 	spin_lock(&cb->lock);
 
 	if (cb->mmap) {
-- 
2.17.1

