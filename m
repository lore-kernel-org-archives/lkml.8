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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7338BC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:44:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540FD2075B
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 14:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkvM7fFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgH2OoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 10:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgH2OoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 10:44:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15454C061239
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 07:44:02 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c18so1798186wrm.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 07:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZIBOcgxzS8sTLW/0rMnxtoCzb9Rc1UXFCw1Y2eAww1A=;
        b=mkvM7fFfanYnuyMSL/+QJ1GIXHf1qFefPQfj58B4rF+1Tp7f63/733bFHtTupCXqVG
         3VE2xxkn82Qnzdn8Tw39yRSis2p2+fHRBoU1hO6/y+A1xp5HsPXDMNlqeQtiCI9kUngE
         SlpZn+5AqZsjeZJLm2uEIGjV1515b0S2kumR/bxC3BgF2itx8DXg+X6i737aZ17FkWs3
         gmaWU9qYCVrH84l8OwdLUr+7VZGCEf8LpyTQdDDTf4T++z/45sN8fON1hMJKS2Gmq/BX
         rsLVFkjI5hlKZmjAwcfIV+6K/dbFBrEEW4JnyWrb8UlDrAoeyBE16CPGSNZnCNWm0hul
         FPOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZIBOcgxzS8sTLW/0rMnxtoCzb9Rc1UXFCw1Y2eAww1A=;
        b=fJ4XzRKL7AyLkrx6eU3m13zEqeLsUS5hm4LgCijc86m2wQLRGBbV5kfPEte6kzIQC4
         3SjPpFVp68gU7NEPVyZAqN2W0H2l6mLWXcLd67JVDB61bs0rl9Fr8EVf26rO0JZmnIqi
         MxR6Cty0jmoyqM9hW1hxAxpdO4TD9r/waLumutjB7zrRCOJJah1GSq9t+MXLxtHl+JYV
         tNQzzP3NA9FGKe5Knj5SJb3vRof743f4wFn7kquXcKu/piESLzLPNJQnBf5Pp7m5KRC2
         RrYp03LrIp7MJ2Y8qIieLf775etkadP4T7WsG6ca0NSI6HHQBfhmQs1uMBGpmFHMUiXE
         dQbQ==
X-Gm-Message-State: AOAM532bvh8P8FshKSpu1DxL01Nf034X7601ONYKFMmSvetNgIMBChLE
        vs7RPEvgbDsd7KDne/ZKCHL4ujQRLAo=
X-Google-Smtp-Source: ABdhPJxtnb6IboPSPLIAP2eSbFFyxpaX08cTIUwsKnq2nVw9d8WJZ0V0WOmmYUcg9TaAifXBnELNpA==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr4131712wro.271.1598712239969;
        Sat, 29 Aug 2020 07:43:59 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id a11sm4066588wrq.0.2020.08.29.07.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 07:43:58 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Hillf Danton <hdanton@sina.com>, Christoph Hellwig <hch@lst.de>,
        Zhang Li <li.zhang@bitmain.com>,
        Ding Z Nan <oshack@hotmail.com>
Subject: [PATCH 3/3] habanalabs: make use of dma_mmap_coherent
Date:   Sat, 29 Aug 2020 17:43:52 +0300
Message-Id: <20200829144352.17171-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829144352.17171-1-oded.gabbay@gmail.com>
References: <20200829144352.17171-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hillf Danton <hdanton@sina.com>

Add dma_mmap_coherent() for goya and gaudi to match their use of
dma_alloc_coherent(), see the Link tag for why.

Link: https://lore.kernel.org/lkml/20200609091727.GA23814@lst.de/
Cc: Christoph Hellwig <hch@lst.de>
Cc: Zhang Li <li.zhang@bitmain.com>
Cc: Ding Z Nan <oshack@hotmail.com>
Signed-off-by: Hillf Danton <hdanton@sina.com>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/command_buffer.c | 9 ++-------
 drivers/misc/habanalabs/common/habanalabs.h     | 2 +-
 drivers/misc/habanalabs/gaudi/gaudi.c           | 7 +++----
 drivers/misc/habanalabs/goya/goya.c             | 7 +++----
 4 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/misc/habanalabs/common/command_buffer.c b/drivers/misc/habanalabs/common/command_buffer.c
index 6563e4dfe7b6..ba63cee74050 100644
--- a/drivers/misc/habanalabs/common/command_buffer.c
+++ b/drivers/misc/habanalabs/common/command_buffer.c
@@ -300,7 +300,6 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 {
 	struct hl_device *hdev = hpriv->hdev;
 	struct hl_cb *cb;
-	phys_addr_t address;
 	u32 handle, user_cb_size;
 	int rc;
 
@@ -360,12 +359,8 @@ int hl_cb_mmap(struct hl_fpriv *hpriv, struct vm_area_struct *vma)
 
 	vma->vm_private_data = cb;
 
-	/* Calculate address for CB */
-	address = virt_to_phys((void *) (uintptr_t) cb->kernel_address);
-
-	rc = hdev->asic_funcs->cb_mmap(hdev, vma, cb->kernel_address,
-					address, cb->size);
-
+	rc = hdev->asic_funcs->cb_mmap(hdev, vma, (void *) cb->kernel_address,
+					cb->bus_address, cb->size);
 	if (rc) {
 		spin_lock(&cb->lock);
 		cb->mmap = false;
diff --git a/drivers/misc/habanalabs/common/habanalabs.h b/drivers/misc/habanalabs/common/habanalabs.h
index cdb7a672ed30..6ea8ae616cf4 100644
--- a/drivers/misc/habanalabs/common/habanalabs.h
+++ b/drivers/misc/habanalabs/common/habanalabs.h
@@ -710,7 +710,7 @@ struct hl_asic_funcs {
 	int (*suspend)(struct hl_device *hdev);
 	int (*resume)(struct hl_device *hdev);
 	int (*cb_mmap)(struct hl_device *hdev, struct vm_area_struct *vma,
-			u64 kaddress, phys_addr_t paddress, u32 size);
+			void *cpu_addr, dma_addr_t dma_addr, size_t size);
 	void (*ring_doorbell)(struct hl_device *hdev, u32 hw_queue_id, u32 pi);
 	void (*pqe_write)(struct hl_device *hdev, __le64 *pqe,
 			struct hl_bd *bd);
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 084019788e11..bc7e7e3ba3a8 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -3091,17 +3091,16 @@ static int gaudi_resume(struct hl_device *hdev)
 }
 
 static int gaudi_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
-		u64 kaddress, phys_addr_t paddress, u32 size)
+			void *cpu_addr, dma_addr_t dma_addr, size_t size)
 {
 	int rc;
 
 	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP |
 			VM_DONTCOPY | VM_NORESERVE;
 
-	rc = remap_pfn_range(vma, vma->vm_start, paddress >> PAGE_SHIFT,
-				size, vma->vm_page_prot);
+	rc = dma_mmap_coherent(hdev->dev, vma, cpu_addr, dma_addr, size);
 	if (rc)
-		dev_err(hdev->dev, "remap_pfn_range error %d", rc);
+		dev_err(hdev->dev, "dma_mmap_coherent error %d", rc);
 
 	return rc;
 }
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 88847eb1b472..94b7958ba5fb 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -2661,17 +2661,16 @@ int goya_resume(struct hl_device *hdev)
 }
 
 static int goya_cb_mmap(struct hl_device *hdev, struct vm_area_struct *vma,
-		u64 kaddress, phys_addr_t paddress, u32 size)
+			void *cpu_addr, dma_addr_t dma_addr, size_t size)
 {
 	int rc;
 
 	vma->vm_flags |= VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP |
 			VM_DONTCOPY | VM_NORESERVE;
 
-	rc = remap_pfn_range(vma, vma->vm_start, paddress >> PAGE_SHIFT,
-				size, vma->vm_page_prot);
+	rc = dma_mmap_coherent(hdev->dev, vma, cpu_addr, dma_addr, size);
 	if (rc)
-		dev_err(hdev->dev, "remap_pfn_range error %d", rc);
+		dev_err(hdev->dev, "dma_mmap_coherent error %d", rc);
 
 	return rc;
 }
-- 
2.17.1

