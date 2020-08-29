Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD4EC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B682320757
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUuU94RE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgH2OoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH2On5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:43:57 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F72C061236
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 07:43:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x7so1828582wro.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 07:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=Aw9HcmNBjOZwegGuIW3O8GKoqmBo2RjgFxq9mcIvYbg=;
        b=oUuU94REb2UY3is4S0o2P4mswXirUWPvplatf/n+JjfIexOLu+jG1IPXKeFFoaPIfH
         /rzo21nTryO3y5p5incLiW0vv7TzQlc0TiDwYbCoq/VAVUdoD9l4kUVrRN+W0lUVuKPU
         Noo1I6t6+WQF5R6M5tTAzdOjNh4AhEAfJrQQ0LA4ehfQ3m6MXV19ISTtZsDAYcPXsVJk
         1zPy911WUEFBs7OIKgpifgUNFlLIVCzCYVcMgGE5HiLyBGSdrMj83/Cq1Shp0RpKkKtQ
         6983Yx4/rlw1v66xhxATbtnPxJvHGmWtA4/KRvYkhXU+6u5Tc8xbuI5HXDyYbV2VArFD
         rfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Aw9HcmNBjOZwegGuIW3O8GKoqmBo2RjgFxq9mcIvYbg=;
        b=bXxTqWhkmJEr8lBbAb0gjzdn5jfAf1T3bn9lPNGf+rsMFPTRI3uCmDBuLvKoxpIwCd
         aI8atQkhIPcqFXr6a1YvhGIse7ez6dljJuDJcjqWtKCD66zuXOf5jvqiJRsn958M+IkS
         yYcqH6CrKunQzM2NOcxX1GLST6AxcTC2c87jgASguzRhl8+aSpO/IIDzBB0dwI6AKpg6
         2QiLN/Xxhr9ntprTsyH19VcjPF//Mhwi5xeZ4vz3oRbVboEW/M5+4kYb5Wm6r60KXJfW
         bZE2TVGYRic7eKERuBipp5sHGVcU8Ag5WCEDmGnuMzdPDc1idi7E5t+WvBw6KvhM/Xdk
         NikA==
X-Gm-Message-State: AOAM532nz68aTEnXBLfdCpuYlYcDR5RUsd0V+3hHO/3HtVChvCKNXyle
        QS3YRzmK2NQQRz5kBmbPMypaPDzmSW4=
X-Google-Smtp-Source: ABdhPJxoXZhfAQBtohqbk+iimFB392WGJmzt8MmT+qtmtIkEOtWs8Z1s46dNPaXSwc9/M5eF6cB1Aw==
X-Received: by 2002:adf:db43:: with SMTP id f3mr4114165wrj.219.1598712235401;
        Sat, 29 Aug 2020 07:43:55 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id a11sm4066588wrq.0.2020.08.29.07.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 07:43:54 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH 1/3] habanalabs: restructure hl_mmap
Date:   Sat, 29 Aug 2020 17:43:50 +0300
Message-Id: <20200829144352.17171-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arrange the hl_mmap code to be more structured and expandable for the
future. Add better defines that describe our usage of the vm_pgoff.

Note that I shamelessly took the code and defines from the amdkfd driver
(my previous driver).

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/command_buffer.c |  2 +-
 drivers/misc/habanalabs/common/device.c         |  8 ++++++--
 drivers/misc/habanalabs/common/habanalabs.h     | 14 +++++++++++++-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index e4bbe6a8e00f..68dfbafe3354 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -183,7 +183,7 @@ int hl_cb_create(struct hl_device *hdev, struct hl_cb_mgr *mgr,
 	 * idr is 32-bit so we can safely OR it with a mask that is above
 	 * 32 bit
 	 */
-	*handle = cb->id | HL_MMAP_CB_MASK;
+	*handle = cb->id | HL_MMAP_TYPE_CB;
 	*handle <<= PAGE_SHIFT;
 
 	hl_debugfs_add_cb(cb);
diff --git a/drivers/misc/habanalabs/common/device.c b/drivers/misc/habanalabs/common/device.c
index 6e916cc22a4c..aa7fa9e94651 100644
--- a/drivers/misc/habanalabs/common/device.c
+++ b/drivers/misc/habanalabs/common/device.c
@@ -123,9 +123,13 @@ static int hl_device_release_ctrl(struct inode *inode, struct file *filp)
 static int hl_mmap(struct file *filp, struct vm_area_struct *vma)
 {
 	struct hl_fpriv *hpriv = filp->private_data;
+	unsigned long vm_pgoff;
 
-	if ((vma->vm_pgoff & HL_MMAP_CB_MASK) == HL_MMAP_CB_MASK) {
-		vma->vm_pgoff ^= HL_MMAP_CB_MASK;
+	vm_pgoff = vma->vm_pgoff;
+	vma->vm_pgoff = HL_MMAP_OFFSET_VALUE_GET(vm_pgoff);
+
+	switch (vm_pgoff & HL_MMAP_TYPE_MASK) {
+	case HL_MMAP_TYPE_CB:
 		return hl_cb_mmap(hpriv, vma);
 	}
 
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index 6912f88a4b01..cdb7a672ed30 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -22,7 +22,19 @@
 
 #define HL_NAME				"habanalabs"
 
-#define HL_MMAP_CB_MASK			(0x8000000000000000ull >> PAGE_SHIFT)
+/* Use upper bits of mmap offset to store habana driver specific information.
+ * bits[63:62] - Encode mmap type
+ * bits[45:0]  - mmap offset value
+ *
+ * NOTE: struct vm_area_struct.vm_pgoff uses offset in pages. Hence, these
+ *  defines are w.r.t to PAGE_SIZE
+ */
+#define HL_MMAP_TYPE_SHIFT		(62 - PAGE_SHIFT)
+#define HL_MMAP_TYPE_MASK		(0x3ull << HL_MMAP_TYPE_SHIFT)
+#define HL_MMAP_TYPE_CB			(0x2ull << HL_MMAP_TYPE_SHIFT)
+
+#define HL_MMAP_OFFSET_VALUE_MASK	(0x3FFFFFFFFFFFull >> PAGE_SHIFT)
+#define HL_MMAP_OFFSET_VALUE_GET(off)	(off & HL_MMAP_OFFSET_VALUE_MASK)
 
 #define HL_PENDING_RESET_PER_SEC	30
 
-- 
2.17.1

