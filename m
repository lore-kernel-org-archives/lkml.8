Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C98C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 747B021D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 18:45:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnAojsLq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgIJSpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgIJSPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 14:15:50 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4564C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:31 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id q21so7317568edv.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 11:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fBMnGhFEGtSKYNN1DbAaLO5ZmFvQLZu2d8gj+7Gu1Z8=;
        b=NnAojsLqGyoeMB26IbuJihdbMsJdxnNeUFbc5iP8EY3ZPi40/gPM4Qaa9agBsi/85w
         Rmyzt5gmNN8K7i9ZMmeQzRx/FR0uugQbKVeeMG5QRkW2sT33sw0wGIQ7Rgmge5zyQYbi
         Y7ie2PwSXhklwLTVMnhOq8v5HBI/gEHk5HotJfpnxD255a1/lzrfj0lvNgKAwHu4Mi0Z
         nXSuYxnRTeOAzmzFls1WgwvUYVJmNFIqwDxCYVBrubEupBdNY7fnOQ+1nJOBkvtPLNTR
         mOy54KFsb/f+skmSGxexxXRgtSQcJZWya76DYSenlP0u2wcNcJJqn83JDwYalhpER733
         x3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fBMnGhFEGtSKYNN1DbAaLO5ZmFvQLZu2d8gj+7Gu1Z8=;
        b=pSyDc9hUPUsxdjcSGONxGZTaqnevCpPY3QFAUp69kIKPek8jQ2yImxvou/qtryNsww
         +OLSEzzGbxLf7npy2mZmb77E3jovrQKC4LCB9SD3L9ORHWcJvhOKwww//hRncFDzRd08
         i581BzfpLlbZ31N0vB9TrJu+Wb06gYBvezZbIGmzqZedBDb8jkxJeQ++uvP/mnPHDPEj
         bSMtg/sY9YcDAlLRHdlFe5V5CHSx7i1NeYwolgTRWJFfaBc7TMSq1bCigmLfyyFqoV8I
         YJ2gDmx20aHAXOQXGexH+K4EwP2r9Vgb4HGZjG7KuyNQC6BYv9Vi4/2vHZmVQr5nHrYX
         BLJw==
X-Gm-Message-State: AOAM533e2JcAXHNEx7d0jCPjwwYRKXGQ+jYyat563/hVwtnyz0DWs6jG
        Ys5wL7geoC8hop0ba3RkL2sGE02YAho=
X-Google-Smtp-Source: ABdhPJxq+VRmWchB2Hm97YbLm3lcmhTMtdB/YvR4vkOmwmhgcdEXajPXP80//lDWcPTFGxJDWVP38Q==
X-Received: by 2002:aa7:da0f:: with SMTP id r15mr10399804eds.321.1599761729791;
        Thu, 10 Sep 2020 11:15:29 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id y6sm8636117edj.50.2020.09.10.11.15.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 11:15:28 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     gregkh@linuxfoundation.org, Omer Shpigelman <oshpigelman@habana.ai>
Subject: [PATCH 01/11] habanalabs: use smallest possible alignment for virtual addresses
Date:   Thu, 10 Sep 2020 21:15:14 +0300
Message-Id: <20200910181524.21460-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

Change the acquiring of a device virtual address for mapping by using the
smallest possible alignment, rather than the biggest, depending on the
page size used by the user for allocating the memory. This will lower the
virtual space memory consumption.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/memory.c | 86 ++++++++++++++-----------
 1 file changed, 48 insertions(+), 38 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index 5ff4688683fd..3324332811bc 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -505,41 +505,32 @@ static inline int add_va_block(struct hl_device *hdev,
 }
 
 /*
- * get_va_block - get a virtual block with the requested size
- *
- * @hdev            : pointer to the habanalabs device structure
- * @va_range        : pointer to the virtual addresses range
- * @size            : requested block size
- * @hint_addr       : hint for request address by the user
- * @is_userptr      : is host or DRAM memory
+ * get_va_block() - get a virtual block for the given size and alignment.
+ * @hdev: pointer to the habanalabs device structure.
+ * @va_range: pointer to the virtual addresses range.
+ * @size: requested block size.
+ * @hint_addr: hint for requested address by the user.
+ * @va_block_align: required alignment of the virtual block start address.
  *
  * This function does the following:
  * - Iterate on the virtual block list to find a suitable virtual block for the
- *   requested size
- * - Reserve the requested block and update the list
- * - Return the start address of the virtual block
+ *   given size and alignment.
+ * - Reserve the requested block and update the list.
+ * - Return the start address of the virtual block.
  */
-static u64 get_va_block(struct hl_device *hdev,
-			struct hl_va_range *va_range, u64 size, u64 hint_addr,
-			bool is_userptr)
+static u64 get_va_block(struct hl_device *hdev, struct hl_va_range *va_range,
+			u64 size, u64 hint_addr, u32 va_block_align)
 {
 	struct hl_vm_va_block *va_block, *new_va_block = NULL;
-	u64 valid_start, valid_size, prev_start, prev_end, page_mask,
+	u64 valid_start, valid_size, prev_start, prev_end, align_mask,
 		res_valid_start = 0, res_valid_size = 0;
-	u32 page_size;
 	bool add_prev = false;
 
-	if (is_userptr)
-		/*
-		 * We cannot know if the user allocated memory with huge pages
-		 * or not, hence we continue with the biggest possible
-		 * granularity.
-		 */
-		page_size = hdev->asic_prop.pmmu_huge.page_size;
-	else
-		page_size = hdev->asic_prop.dmmu.page_size;
+	align_mask = ~((u64)va_block_align - 1);
 
-	page_mask = ~((u64)page_size - 1);
+	/* check if hint_addr is aligned */
+	if (hint_addr & (va_block_align - 1))
+		hint_addr = 0;
 
 	mutex_lock(&va_range->lock);
 
@@ -549,9 +540,9 @@ static u64 get_va_block(struct hl_device *hdev,
 		/* calc the first possible aligned addr */
 		valid_start = va_block->start;
 
-		if (valid_start & (page_size - 1)) {
-			valid_start &= page_mask;
-			valid_start += page_size;
+		if (valid_start & (va_block_align - 1)) {
+			valid_start &= align_mask;
+			valid_start += va_block_align;
 			if (valid_start > va_block->end)
 				continue;
 		}
@@ -863,7 +854,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	struct hl_va_range *va_range;
 	enum vm_type_t *vm_type;
 	u64 ret_vaddr, hint_addr;
-	u32 handle = 0;
+	u32 handle = 0, va_block_align;
 	int rc;
 	bool is_userptr = args->flags & HL_MEM_USERPTR;
 
@@ -873,6 +864,8 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 	if (is_userptr) {
 		u64 addr = args->map_host.host_virt_addr,
 			size = args->map_host.mem_size;
+		u32 page_size = hdev->asic_prop.pmmu.page_size,
+			huge_page_size = hdev->asic_prop.pmmu_huge.page_size;
 
 		rc = dma_map_host_va(hdev, addr, size, &userptr);
 		if (rc) {
@@ -892,6 +885,27 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 		vm_type = (enum vm_type_t *) userptr;
 		hint_addr = args->map_host.hint_addr;
 		handle = phys_pg_pack->handle;
+
+		/* get required alignment */
+		if (phys_pg_pack->page_size == page_size) {
+			va_range = ctx->host_va_range;
+
+			/*
+			 * huge page alignment may be needed in case of regular
+			 * page mapping, depending on the host VA alignment
+			 */
+			if (addr & (huge_page_size - 1))
+				va_block_align = page_size;
+			else
+				va_block_align = huge_page_size;
+		} else {
+			/*
+			 * huge page alignment is needed in case of huge page
+			 * mapping
+			 */
+			va_range = ctx->host_huge_va_range;
+			va_block_align = huge_page_size;
+		}
 	} else {
 		handle = lower_32_bits(args->map_device.handle);
 
@@ -912,6 +926,10 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 		vm_type = (enum vm_type_t *) phys_pg_pack;
 
 		hint_addr = args->map_device.hint_addr;
+
+		/* DRAM VA alignment is the same as the DRAM page size */
+		va_range = ctx->dram_va_range;
+		va_block_align = hdev->asic_prop.dmmu.page_size;
 	}
 
 	/*
@@ -933,16 +951,8 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 		goto hnode_err;
 	}
 
-	if (is_userptr)
-		if (phys_pg_pack->page_size == hdev->asic_prop.pmmu.page_size)
-			va_range = ctx->host_va_range;
-		else
-			va_range = ctx->host_huge_va_range;
-	else
-		va_range = ctx->dram_va_range;
-
 	ret_vaddr = get_va_block(hdev, va_range, phys_pg_pack->total_size,
-					hint_addr, is_userptr);
+					hint_addr, va_block_align);
 	if (!ret_vaddr) {
 		dev_err(hdev->dev, "no available va block for handle %u\n",
 				handle);
-- 
2.17.1

