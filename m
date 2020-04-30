Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7EEC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:06:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F21207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uZm85oNN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgD3TGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgD3TGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:06:24 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092EAC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:06:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t9so1174382pjw.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PUPDbypIxhh2WVCFx2ZlZOTBGGgSTEvz8TM+sHkk8P4=;
        b=uZm85oNNlhOH74T3gDaMkTUyTfNQ+mnP2aok4Zpkvjz9Yff6NI7kpdgRr+20Fdd+os
         kfc3S/8fb6vzd4kK0ogsPDYj0KebnSA9nSOYZSySv+cU7ZiaVgpbP4X7H2/m6pWtsb0s
         0v+H4yjgMTR35CNcvZJBiB5jDUbE0upcs4pTU1kY8Svo1X/QYNIHik92GSX9iwI+XwOi
         gtmJFdTmO5auycgfmxvxmLZoMUAl9t3ljLBlZa/UBliRdHroyukXuUdABjj3yLTkUT/3
         GRiI2IR+S3Ozvb74YC0VoPnDneJlf8ZGfrKRBeeHdtOJvyhNgBzqM8XfB0UWrnzmnb2j
         H0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PUPDbypIxhh2WVCFx2ZlZOTBGGgSTEvz8TM+sHkk8P4=;
        b=WBPVMqDssK23ZtiasUKYlpoBeh0KVoTt2RMRqHF/PME+LSIT8TKD4J6e2T1KxCmaM/
         qdilN6dFcQwyfq963VnvD4+Y3fnAhLJu3Ov+dhSHP4TIC4Gp7EikGgKnKeSre9EYzGCw
         8DtwUkJQLexYq7clYoNp5dGhxqPmMcQh/Qoxu1KAaWM1nGAE0/4n7hTOOx77WJqAvtpO
         fpe8W+OuZjqreietYgTfWCE6ye3uOCmpWZHgBAl7jDZYFe6TtN1HENYLl16xL2rkgWqQ
         hDpa843wuXnEx4XnVyG8oc7ne7lZjcafTJbaKo4tXoR4RWmBPfxCQ66L432M7vD01+9t
         KiQA==
X-Gm-Message-State: AGi0PuaIs5faLWjcSy+vYSpH0dFQpZLB2npMi9jRo7hf7OL19BRp4Gl6
        G4iH5nLNMGfOuryfQEZpjDMI
X-Google-Smtp-Source: APiQypJzuYqCCAVTxGBbPMUUxm6BAcisq+u16Nx2Rfw5SL7UcM60s7mUaT1d0UHi6iRnOK8vkFmmGA==
X-Received: by 2002:a17:90a:eb05:: with SMTP id j5mr291007pjz.86.1588273583431;
        Thu, 30 Apr 2020 12:06:23 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6081:946c:419e:a71:7237:1613])
        by smtp.gmail.com with ESMTPSA id l37sm467863pje.12.2020.04.30.12.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:06:22 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 4/6] bus: mhi: core: Offload register accesses to the controller
Date:   Fri,  1 May 2020 00:35:53 +0530
Message-Id: <20200430190555.32741-5-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430190555.32741-1-manivannan.sadhasivam@linaro.org>
References: <20200430190555.32741-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jhugo@codeaurora.org>

When reading or writing MHI registers, the core assumes that the physical
link is a memory mapped PCI link.  This assumption may not hold for all
MHI devices.  The controller knows what is the physical link (ie PCI, I2C,
SPI, etc), and therefore knows the proper methods to access that link.
The controller can also handle link specific error scenarios, such as
reading -1 when the PCI link went down.

Therefore, it is appropriate that the MHI core requests the controller to
make register accesses on behalf of the core, which abstracts the core
from link specifics, and end up removing an unnecessary assumption.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c     |  3 ++-
 drivers/bus/mhi/core/internal.h |  3 ---
 drivers/bus/mhi/core/main.c     | 12 ++----------
 include/linux/mhi.h             |  6 ++++++
 4 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 2af08d57ec28..eb2ab058a01d 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -813,7 +813,8 @@ int mhi_register_controller(struct mhi_controller *mhi_cntrl,
 		return -EINVAL;
 
 	if (!mhi_cntrl->runtime_get || !mhi_cntrl->runtime_put ||
-	    !mhi_cntrl->status_cb)
+	    !mhi_cntrl->status_cb || !mhi_cntrl->read_reg ||
+	    !mhi_cntrl->write_reg)
 		return -EINVAL;
 
 	ret = parse_config(mhi_cntrl, config);
diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
index 5deadfaa053a..095d95bc0e37 100644
--- a/drivers/bus/mhi/core/internal.h
+++ b/drivers/bus/mhi/core/internal.h
@@ -11,9 +11,6 @@
 
 extern struct bus_type mhi_bus_type;
 
-/* MHI MMIO register mapping */
-#define PCI_INVALID_READ(val) (val == U32_MAX)
-
 #define MHIREGLEN (0x0)
 #define MHIREGLEN_MHIREGLEN_MASK (0xFFFFFFFF)
 #define MHIREGLEN_MHIREGLEN_SHIFT (0)
diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
index 374e3db31ab7..0cc85753d9d6 100644
--- a/drivers/bus/mhi/core/main.c
+++ b/drivers/bus/mhi/core/main.c
@@ -18,15 +18,7 @@
 int __must_check mhi_read_reg(struct mhi_controller *mhi_cntrl,
 			      void __iomem *base, u32 offset, u32 *out)
 {
-	u32 tmp = readl(base + offset);
-
-	/* If the value is invalid, the link is down */
-	if (PCI_INVALID_READ(tmp))
-		return -EIO;
-
-	*out = tmp;
-
-	return 0;
+	return mhi_cntrl->read_reg(mhi_cntrl, base + offset, out);
 }
 
 int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
@@ -48,7 +40,7 @@ int __must_check mhi_read_reg_field(struct mhi_controller *mhi_cntrl,
 void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
 		   u32 offset, u32 val)
 {
-	writel(val, base + offset);
+	mhi_cntrl->write_reg(mhi_cntrl, base + offset, val);
 }
 
 void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 0794483b9a18..ab737821ab89 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -342,6 +342,8 @@ struct mhi_controller_config {
  * @runtimet_put: CB function to decrement pm usage (required)
  * @map_single: CB function to create TRE buffer
  * @unmap_single: CB function to destroy TRE buffer
+ * @read_reg: Read a MHI register via the physical link (required)
+ * @write_reg: Write a MHI register via the physical link (required)
  * @buffer_len: Bounce buffer length
  * @bounce_buf: Use of bounce buffer
  * @fbc_download: MHI host needs to do complete image transfer (optional)
@@ -425,6 +427,10 @@ struct mhi_controller {
 			  struct mhi_buf_info *buf);
 	void (*unmap_single)(struct mhi_controller *mhi_cntrl,
 			     struct mhi_buf_info *buf);
+	int (*read_reg)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
+			u32 *out);
+	void (*write_reg)(struct mhi_controller *mhi_cntrl, void __iomem *addr,
+			  u32 val);
 
 	size_t buffer_len;
 	bool bounce_buf;
-- 
2.17.1

