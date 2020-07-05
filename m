Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8257BC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D47F20739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 13:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fzX5iTSA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgGENMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 09:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgGENMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 09:12:46 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECB1C061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 06:12:46 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r12so37787738wrj.13
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 06:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TIMWex1bzxSjXlZ+zlgh0Ik6rG406/F6/kfESusS0KE=;
        b=fzX5iTSAtB/uzjPpRQGdrVjJ3C1sATbyKd8OqWDp4GOn2NiekG6zcAJiqPUoenJIbe
         UGPo0WLUDjQKvm2H+x75gEbtBoj09k529GZiGePOfV1RB8sQhXxx9Pg6mwzV8owq+MtT
         axelAmOnV5skyM4wtqvYZFMPERQ2LhR35TnWL244cEtHZWqVsC1yxRkeq7ly6XPG79QB
         w/aFA7qRERLFOqwyk8oV27WZiYFsV9iWFczrcl59qXaEtuom0H4OosEwO3LAdyRz0pCU
         NbeVP7iqXJ9CrrNae95SA1pqg/J5aud8w+kzcPsMINuEIQ2DOLaUZYv7VdJzFebYQzHz
         i1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TIMWex1bzxSjXlZ+zlgh0Ik6rG406/F6/kfESusS0KE=;
        b=CV4czKtxVAPo+QdQOfbxRGzckkXc+YM964Gq+BABOVmS45NYn+BcA7WJgPX7rKhcnv
         XTIs+U6pSTBKTOqkBw2BJIPSQM5K9J3p7sLXSPGtGtuRbzc8EscU2m5hI9TOcpz6avD+
         VH3AJE4MDtQo49Z8fV/JEVk/lsizEtjON/7UcDbwKUT1NG0+BTs+DUGKsbFWsPqDjdzZ
         TPih9G2DslfTu+L078EnNBo7WWhcbZ7SEFN4GVkSD6JgsINC2gkE1sOkQ/IgTDEonPxy
         npwIce6RIPbYsFAXvxoIQbqy3vi0oADcKFMI0sTrWGVpAWks8EPMny66gfmLER2SDxKC
         FQtA==
X-Gm-Message-State: AOAM530NMe0hmEWnV0E0MslGplB552FlBUwhWDYeMDGPLJEkD34Y7nt5
        5/iRZbQ+IY+Mv0XBYkese8crU3cO
X-Google-Smtp-Source: ABdhPJzQD9Pv/oFpggRJ6RrLJ1rG4fgJToxUglzuWELchnFQrO+hNVwRcX05Y/5CU8q9P7jE/jsolg==
X-Received: by 2002:adf:82a1:: with SMTP id 30mr47504889wrc.210.1593954764854;
        Sun, 05 Jul 2020 06:12:44 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id 26sm19401809wmj.25.2020.07.05.06.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 06:12:43 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Cc:     Ofir Bitton <obitton@habana.ai>
Subject: [PATCH 1/9] habanalabs: Increase queues depth
Date:   Sun,  5 Jul 2020 16:12:37 +0300
Message-Id: <20200705131245.9368-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ofir Bitton <obitton@habana.ai>

After recent concurrent cs amount increase, we must also
increase queues depth since much more concurrent work can be done.
All external queue depths were increased to 4096 as gaudi's
internal queue depths were also increased to 1024.

Signed-off-by: Ofir Bitton <obitton@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/gaudi/gaudiP.h |  6 ++---
 drivers/misc/habanalabs/habanalabs.h   | 31 ++++----------------------
 drivers/misc/habanalabs/hw_queue.c     |  2 --
 drivers/misc/habanalabs/irq.c          |  4 ----
 4 files changed, 7 insertions(+), 36 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudiP.h b/drivers/misc/habanalabs/gaudi/gaudiP.h
index 3958fe38c8ee..bdc5f96085a7 100644
--- a/drivers/misc/habanalabs/gaudi/gaudiP.h
+++ b/drivers/misc/habanalabs/gaudi/gaudiP.h
@@ -123,14 +123,14 @@
 
 /* Internal QMANs PQ sizes */
 
-#define MME_QMAN_LENGTH			64
+#define MME_QMAN_LENGTH			1024
 #define MME_QMAN_SIZE_IN_BYTES		(MME_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE)
 
-#define HBM_DMA_QMAN_LENGTH		64
+#define HBM_DMA_QMAN_LENGTH		1024
 #define HBM_DMA_QMAN_SIZE_IN_BYTES	\
 				(HBM_DMA_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE)
 
-#define TPC_QMAN_LENGTH			64
+#define TPC_QMAN_LENGTH			1024
 #define TPC_QMAN_SIZE_IN_BYTES		(TPC_QMAN_LENGTH * QMAN_PQ_ENTRY_SIZE)
 
 #define SRAM_USER_BASE_OFFSET  GAUDI_DRIVER_SRAM_RESERVED_SIZE_FROM_START
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 4e68a41cce77..e4d6f7c91194 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -378,38 +378,15 @@ struct hl_cb {
 
 struct hl_cs_job;
 
-/*
- * Currently, there are two limitations on the maximum length of a queue:
- *
- * 1. The memory footprint of the queue. The current allocated space for the
- *    queue is PAGE_SIZE. Because each entry in the queue is HL_BD_SIZE,
- *    the maximum length of the queue can be PAGE_SIZE / HL_BD_SIZE,
- *    which currently is 4096/16 = 256 entries.
- *
- *    To increase that, we need either to decrease the size of the
- *    BD (difficult), or allocate more than a single page (easier).
- *
- * 2. Because the size of the JOB handle field in the BD CTL / completion queue
- *    is 10-bit, we can have up to 1024 open jobs per hardware queue.
- *    Therefore, each queue can hold up to 1024 entries.
- *
- * HL_QUEUE_LENGTH is in units of struct hl_bd.
- * HL_QUEUE_LENGTH * sizeof(struct hl_bd) should be <= HL_PAGE_SIZE
- */
-
-#define HL_PAGE_SIZE			4096 /* minimum page size */
-/* Must be power of 2 (HL_PAGE_SIZE / HL_BD_SIZE) */
-#define HL_QUEUE_LENGTH			256
+/* Queue length of external and HW queues */
+#define HL_QUEUE_LENGTH			4096
 #define HL_QUEUE_SIZE_IN_BYTES		(HL_QUEUE_LENGTH * HL_BD_SIZE)
 
-/*
- * HL_CQ_LENGTH is in units of struct hl_cq_entry.
- * HL_CQ_LENGTH should be <= HL_PAGE_SIZE
- */
+/* HL_CQ_LENGTH is in units of struct hl_cq_entry */
 #define HL_CQ_LENGTH			HL_QUEUE_LENGTH
 #define HL_CQ_SIZE_IN_BYTES		(HL_CQ_LENGTH * HL_CQ_ENTRY_SIZE)
 
-/* Must be power of 2 (HL_PAGE_SIZE / HL_EQ_ENTRY_SIZE) */
+/* Must be power of 2 */
 #define HL_EQ_LENGTH			64
 #define HL_EQ_SIZE_IN_BYTES		(HL_EQ_LENGTH * HL_EQ_ENTRY_SIZE)
 
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index 27f0c34b63b9..f5a10a5ac300 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -780,8 +780,6 @@ static int queue_init(struct hl_device *hdev, struct hl_hw_queue *q,
 {
 	int rc;
 
-	BUILD_BUG_ON(HL_QUEUE_SIZE_IN_BYTES > HL_PAGE_SIZE);
-
 	q->hw_queue_id = hw_queue_id;
 
 	switch (q->queue_type) {
diff --git a/drivers/misc/habanalabs/irq.c b/drivers/misc/habanalabs/irq.c
index 6981d67153b1..7a4878edb1a3 100644
--- a/drivers/misc/habanalabs/irq.c
+++ b/drivers/misc/habanalabs/irq.c
@@ -220,8 +220,6 @@ int hl_cq_init(struct hl_device *hdev, struct hl_cq *q, u32 hw_queue_id)
 {
 	void *p;
 
-	BUILD_BUG_ON(HL_CQ_SIZE_IN_BYTES > HL_PAGE_SIZE);
-
 	p = hdev->asic_funcs->asic_dma_alloc_coherent(hdev, HL_CQ_SIZE_IN_BYTES,
 				&q->bus_address, GFP_KERNEL | __GFP_ZERO);
 	if (!p)
@@ -282,8 +280,6 @@ int hl_eq_init(struct hl_device *hdev, struct hl_eq *q)
 {
 	void *p;
 
-	BUILD_BUG_ON(HL_EQ_SIZE_IN_BYTES > HL_PAGE_SIZE);
-
 	p = hdev->asic_funcs->cpu_accessible_dma_pool_alloc(hdev,
 							HL_EQ_SIZE_IN_BYTES,
 							&q->bus_address);
-- 
2.17.1

