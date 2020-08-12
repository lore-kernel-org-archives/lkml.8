Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C999C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24BD12076B
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 10:18:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNMjvyk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgHLKSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 06:18:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgHLKSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 06:18:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F300C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 03:18:47 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so1475936wrh.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 03:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Op8wUEeW1+YJ4p9fePRwQOD2dxqtWpVLKUfQbTutL/s=;
        b=iNMjvyk9noOJlFZSKCV9vQxmPf7QBDYfOj+SlirJE5kGKGROPIK7IcPUrBU+AV2+Fe
         mzGbhotbwDRci0bgpypxRMU8CKl7SspKovholJ8cqYDbY6mhlO3FnpDB90gbLB0aEN2z
         cgbC846ZEbeylQmEHDViqSs3zQUkF5wK5eb7I4YyX6tcjJ8tajza1/r0IBLfa7mdaTY1
         ywStU+fAdjYpFG+G5m72Pc8GSYVOFJ+M0iEJdIgtwEhlKXw1nW+86pq4qImmm+nik4Lq
         Rjuqopv9B/fvyvQ5haW1MUR6I6VleGvEU9HdAyhNpF8xepTNnLokwllgtjWIgOIZ1TO9
         XK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Op8wUEeW1+YJ4p9fePRwQOD2dxqtWpVLKUfQbTutL/s=;
        b=CdHgZXejIY9Isqi6arrfjhfYOrFXr+WcRo9WT9hV50Gs5Rk/cXS3vtUQz/QW+8tDzk
         VUcBLAkYiu4KBKb8EpJcEWt402YCJ1OfV2f4vZWcCW/nxTTIIA++Fle5bkmfYJd1ejYL
         IEcKuPoJIMKTzeRsiNojAwyWV8e+2Qo1n1HKMJloxAthYvlPy4J5O5aAa6Mljkq+zUN6
         tw0f14jg0YEytV4jv1gYfjvRUtJYhw2JsEDQB47bJCCLrjNGfAwE078JOXwgjVFpyWvc
         yHIKKzs0bmouTbTrLe1L4bAc0XvE7vuobWR14otGQOT4qU+eqr7LOENZRQPasEZp8TPX
         2fVQ==
X-Gm-Message-State: AOAM533NLkszgtc5eDMtW8DlL6+QDoKcpr0ve8Is+FQETnIveHFu1KVs
        MRKwSRyiSmDM1u4/97YGqGNP7NSY
X-Google-Smtp-Source: ABdhPJz1nmTvCb245BQ9Cd7mMlOkrbQN22c/A1P5EL+02iK3mj7A8qCbghFPEqWMbtj4eDxn9NWJfQ==
X-Received: by 2002:a5d:42cc:: with SMTP id t12mr4593882wrr.214.1597227525843;
        Wed, 12 Aug 2020 03:18:45 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id w64sm3429714wmb.26.2020.08.12.03.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 03:18:44 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 2/3] habanalabs: check correct vmalloc return code
Date:   Wed, 12 Aug 2020 13:18:38 +0300
Message-Id: <20200812101839.31233-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812101839.31233-1-oded.gabbay@gmail.com>
References: <20200812101839.31233-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

vmalloc can return different return code than NULL and a valid
pointer. We must validate it in order to dereference a non valid
pointer.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/common/memory.c | 9 +++++++--
 drivers/misc/habanalabs/common/mmu.c    | 2 +-
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/common/memory.c b/drivers/misc/habanalabs/common/memory.c
index dce9273e557a..5ff4688683fd 100644
--- a/drivers/misc/habanalabs/common/memory.c
+++ b/drivers/misc/habanalabs/common/memory.c
@@ -66,6 +66,11 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 	num_pgs = (args->alloc.mem_size + (page_size - 1)) >> page_shift;
 	total_size = num_pgs << page_shift;
 
+	if (!total_size) {
+		dev_err(hdev->dev, "Cannot allocate 0 bytes\n");
+		return -EINVAL;
+	}
+
 	contiguous = args->flags & HL_MEM_CONTIGUOUS;
 
 	if (contiguous) {
@@ -93,7 +98,7 @@ static int alloc_device_memory(struct hl_ctx *ctx, struct hl_mem_in *args,
 	phys_pg_pack->contiguous = contiguous;
 
 	phys_pg_pack->pages = kvmalloc_array(num_pgs, sizeof(u64), GFP_KERNEL);
-	if (!phys_pg_pack->pages) {
+	if (ZERO_OR_NULL_PTR(phys_pg_pack->pages)) {
 		rc = -ENOMEM;
 		goto pages_arr_err;
 	}
@@ -683,7 +688,7 @@ static int init_phys_pg_pack_from_userptr(struct hl_ctx *ctx,
 
 	phys_pg_pack->pages = kvmalloc_array(total_npages, sizeof(u64),
 						GFP_KERNEL);
-	if (!phys_pg_pack->pages) {
+	if (ZERO_OR_NULL_PTR(phys_pg_pack->pages)) {
 		rc = -ENOMEM;
 		goto page_pack_arr_mem_err;
 	}
diff --git a/drivers/misc/habanalabs/common/mmu.c b/drivers/misc/habanalabs/common/mmu.c
index edcc11d5eaf1..3fc0f497fab3 100644
--- a/drivers/misc/habanalabs/common/mmu.c
+++ b/drivers/misc/habanalabs/common/mmu.c
@@ -450,7 +450,7 @@ int hl_mmu_init(struct hl_device *hdev)
 	hdev->mmu_shadow_hop0 = kvmalloc_array(prop->max_asid,
 					prop->mmu_hop_table_size,
 					GFP_KERNEL | __GFP_ZERO);
-	if (!hdev->mmu_shadow_hop0) {
+	if (ZERO_OR_NULL_PTR(hdev->mmu_shadow_hop0)) {
 		rc = -ENOMEM;
 		goto err_pool_add;
 	}
-- 
2.17.1

