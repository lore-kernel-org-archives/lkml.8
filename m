Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDD3C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67D6207EA
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598888111;
	bh=v4bypPfOHHDKcx4EgTafloiA7b16Xk5jkU7UZswiyRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H2Y1AtsmLjgX/g8osvj/LR2cgAGRpt1H9C5aFQajSYXgcgYWOqe0ge2TCyB6/Bcox
	 cVgoP6z/sLYSquI3guqOgefmerLHoZn9CBoxIfnAFMkEUkLknQZZLBNT8xgjWIPAvN
	 mgsyV4Q4YWIWn8J/kuTRfcCitXsW7yk9s1THRFso=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgHaPbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:31:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:41098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728759AbgHaPa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:30:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AD03214D8;
        Mon, 31 Aug 2020 15:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887857;
        bh=v4bypPfOHHDKcx4EgTafloiA7b16Xk5jkU7UZswiyRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bg7yrAvqcZKHMdDJCaBSP18zD2Zv9RrclzVihc01lbKbfFplYt3xW/3T94bgYlBqj
         3btYzMvDAO6UcA1t5odHDVrH35GucQ3ry78hS78QfvG3P2uk9OR7M0emcr3b8x5h9J
         UYKwUqLSujjwXPUj2ElXNNS1wmUFWYtDFEJsMT4M=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ofir Bitton <obitton@habana.ai>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 11/23] habanalabs: check correct vmalloc return code
Date:   Mon, 31 Aug 2020 11:30:27 -0400
Message-Id: <20200831153039.1024302-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831153039.1024302-1-sashal@kernel.org>
References: <20200831153039.1024302-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

[ Upstream commit 0839152f8c1efc1cc2d515d1ff1e253ca9402ad3 ]

vmalloc can return different return code than NULL and a valid
pointer. We must validate it in order to dereference a non valid
pointer.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/memory.c | 9 +++++++--
 drivers/misc/habanalabs/mmu.c    | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index 22566b75ca50c..acfccf32be6b9 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -67,6 +67,11 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 	num_pgs = (args->alloc.mem_size + (page_size - 1)) >> page_shift;
 	total_size = num_pgs << page_shift;
 
+	if (!total_size) {
+		dev_err(hdev->dev, "Cannot allocate 0 bytes\n");
+		return -EINVAL;
+	}
+
 	contiguous = args->flags & HL_MEM_CONTIGUOUS;
 
 	if (contiguous) {
@@ -94,7 +99,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 	phys_pg_pack->contiguous = contiguous;
 
 	phys_pg_pack->pages = kvmalloc_array(num_pgs, sizeof(u64), GFP_KERNEL);
-	if (!phys_pg_pack->pages) {
+	if (ZERO_OR_NULL_PTR(phys_pg_pack->pages)) {
 		rc = -ENOMEM;
 		goto pages_arr_err;
 	}
@@ -689,7 +694,7 @@ static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
 
 	phys_pg_pack->pages = kvmalloc_array(total_npages, sizeof(u64),
 						GFP_KERNEL);
-	if (!phys_pg_pack->pages) {
+	if (ZERO_OR_NULL_PTR(phys_pg_pack->pages)) {
 		rc = -ENOMEM;
 		goto page_pack_arr_mem_err;
 	}
diff --git a/drivers/misc/habanalabs/mmu.c b/drivers/misc/habanalabs/mmu.c
index 176c315836f12..d66e16de4cda3 100644
--- a/drivers/misc/habanalabs/mmu.c
+++ b/drivers/misc/habanalabs/mmu.c
@@ -422,7 +422,7 @@ int hl_mmu_init(struct hl_device *hdev)
 	hdev->mmu_shadow_hop0 = kvmalloc_array(prop->max_asid,
 					prop->mmu_hop_table_size,
 					GFP_KERNEL | __GFP_ZERO);
-	if (!hdev->mmu_shadow_hop0) {
+	if (ZERO_OR_NULL_PTR(hdev->mmu_shadow_hop0)) {
 		rc = -ENOMEM;
 		goto err_pool_add;
 	}
-- 
2.25.1

