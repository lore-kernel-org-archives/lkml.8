Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45264C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 20:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F110E2073B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 20:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=habanalabs.onmicrosoft.com header.i=@habanalabs.onmicrosoft.com header.b="wnzNDSrC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbgEXUJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 16:09:48 -0400
Received: from mail-eopbgr70094.outbound.protection.outlook.com ([40.107.7.94]:46918
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388029AbgEXUJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 16:09:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYfR2ZTjSFbZ9GrTFyqu7eu5+F2SkOX+ikwlkIKvbr+SWa0NyMcWkgHv7r+Ydaj8426qCpW8i+2OYH8C7agzLDhQAYGgg1/0+4wYITxqJ6GkAKlSnuGtXRHrVaX92vJMhR/Qqe3TSkS63Nf2H7U/8uefhkDUrM6NLDbjK+YuUWB0uLcnmUewmKFgZU6R8+7SzbvENrSXJ5N9YhHF46lItV4NOHXyYSphnxpTtt7LUyObnhgms8axfJOfInuZ4SV7FkWhKrDQbSIAnhO/8tZFLQNyP1BrehIf0K3PntctVpVGqn4MroHkfXjdIyO5a2gRC6psG13OcLa1WH6AA++cuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8Wjs02I+JJhXQDP+zOkPOGgD2oOVjujsc4vY702pIQ=;
 b=FH49iHeQc5C5k1NshO3I2dew2ImcFw7M794etb4O2I3tQ/wR3EAaGcGLCqb8g9ajKaxg8q8KD58Hrgfo/rOI4Ec9z12ONtRohJUfx5Y9KMtqfg7aoSFUfBOkwXp6+9KTOZHMimBndIqw1h39LQb0nVBtiGsDS4hgBe4miFqJw3ZEAB6YdIHAxCIrLGTKMNhTJ7Pti8LsvxRCzJ2AOHTpNFilrwUyfXWYqHrIZ91FUhjEtcnWpuxNxZ6svipLuVUAOvBPIKxTiU5w7FXRIefQMZhoYUAbOTWPq5ullYJBx9E83WMUDU2bN4j9qgSty68/Vj2v/AguHwbK45KyHKHFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=habana.ai; dmarc=pass action=none header.from=habana.ai;
 dkim=pass header.d=habana.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=habanalabs.onmicrosoft.com; s=selector2-habanalabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K8Wjs02I+JJhXQDP+zOkPOGgD2oOVjujsc4vY702pIQ=;
 b=wnzNDSrCXPVb99qZRqgHtwHUn7T76NrkIjtufgthDWW0w1mFWZew4Goz1Ybt9jH47GIlgQ36XTRJpjyWZIjP78LDdVZM8TyzHcUzV3yAQBxo8xY2tsy6rsHzvABV4T2iB9zGdQiOKf0sKDDFqDQHHAofAKym9N0+mChU6Tep3gQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=habana.ai;
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com (2603:10a6:208:15e::24)
 by AM0PR02MB4451.eurprd02.prod.outlook.com (2603:10a6:208:ed::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Sun, 24 May
 2020 20:07:06 +0000
Received: from AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e]) by AM0PR02MB5523.eurprd02.prod.outlook.com
 ([fe80::ec0b:a8c:1064:db6e%7]) with mapi id 15.20.3021.029; Sun, 24 May 2020
 20:07:06 +0000
From:   Omer Shpigelman <oshpigelman@habana.ai>
To:     oded.gabbay@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] habanalabs: handle MMU cache invalidation timeout
Date:   Sun, 24 May 2020 23:06:59 +0300
Message-Id: <20200524200659.12041-1-oshpigelman@habana.ai>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM3PR07CA0114.eurprd07.prod.outlook.com
 (2603:10a6:207:7::24) To AM0PR02MB5523.eurprd02.prod.outlook.com
 (2603:10a6:208:15e::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from oshpigelman2-vm.habana-labs.com (31.154.190.6) by AM3PR07CA0114.eurprd07.prod.outlook.com (2603:10a6:207:7::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.9 via Frontend Transport; Sun, 24 May 2020 20:07:05 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [31.154.190.6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ca149d3-30f4-4190-8afa-08d8001e0847
X-MS-TrafficTypeDiagnostic: AM0PR02MB4451:
X-Microsoft-Antispam-PRVS: <AM0PR02MB445132C71D1DAC868FC7E563B8B20@AM0PR02MB4451.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0413C9F1ED
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sizKvTcYyDW63pB2JNmw2fwvYjqPHFLGSiTRo9eZWko8HcjFQqJbTvUCU2WCqKYK54I+5a+Fexriz/TLjzr1qw2Qvn5P/SWcI8/quDmTyKjwQSlfDvuy9X/RSyD+amfmc8/w1ahnydo7tBkTssVsIIlNPHJsx6nhorYRopgmA+PUZXdoJYHfP+LVKB5beu6Ku2HhJQMuxfreGMEbX9+U655g+CyO/udKugOCKLfuZUh3bQ6C6KQlkRdMFJxvy/qnxL+RtiM4Yu9Rvs2hgbfgMMT1Wb2nIqLr8KBLRZSseR6lP1ghHrod894jJCjisV3w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR02MB5523.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(366004)(39850400004)(396003)(136003)(8936002)(478600001)(6916009)(1076003)(16526019)(5660300002)(6486002)(186003)(956004)(2616005)(6666004)(26005)(66946007)(66556008)(66476007)(4326008)(6512007)(6506007)(2906002)(316002)(36756003)(86362001)(8676002)(52116002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: p8eIaJolQgy7SZ+Sg+YPnTCnblPPFJKCDVEVobU7bpKwzwZtE01xk/Qj/j4pmn6Kws+LU1XDLH9b1LMOcQ+orFVEAqcQPF3A13d9amMxRjtPqFxh2PHLSlLNpPBT7/kG1p+07t+heBrr8T/i7FOPmKlkJbgQMkOp23NU0uGJEsZvY22TwyyhlNpSg/hsC7gZDDJPWaIU7/T/eexQqKmNYfEbi71i1zQ9kiBosOvy+yWqYBsjAJaqpfkqV/9MVKieS+6k4TnPU9xxjrq334HQjBBeZ2mEGF3rastq0EH+f2N5xj2O9nM5NVaWh6/0gvuVpot8nXmftrt+809P30k1WXMei7t8K7sefufy062qyjXwvFw4RBmjen4dq/fAxNrjhAv6kbyaF1SY+4bjUl4QPVswF6vcBpjm5Gpa9RnjXgbSeXtxeuQDaGIJMoM7O7XiOVnQasQevdWWsWUtzJ5RXempFhQAWKd6ZNnKwsTIlTI=
X-OriginatorOrg: habana.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca149d3-30f4-4190-8afa-08d8001e0847
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2020 20:07:06.4498
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0d4d4539-213c-4ed8-a251-dc9766ba127a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7J2d0qd5lkyiLJEsdP9UxxPYNbKmQtOoOh9X/F24CRs9nwnxpIhs/a6Bp1MjB0SbPu4qWVt36C9X5rXd9+qkfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB4451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MMU cache invalidation timeout indicates that the device is unstable and
therefore unusable.
Hence in such case do hard reset and return an error to the user if was
called from ioctl.
In addition, change the print to error level and rephrase its text.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 36 ++++++++++++++++-----------
 drivers/misc/habanalabs/goya/goya.c   | 34 +++++++++++++++----------
 drivers/misc/habanalabs/habanalabs.h  |  8 +++---
 drivers/misc/habanalabs/memory.c      | 35 ++++++++++++++++++++------
 4 files changed, 75 insertions(+), 38 deletions(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 92a5130f06fb..61f88e9884ce 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -5975,7 +5975,7 @@ static void *gaudi_get_events_stat(struct hl_device *hdev, bool aggregate,
 	return gaudi->events_stat;
 }
 
-static void gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
+static int gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 					u32 flags)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
@@ -5984,15 +5984,15 @@ static void gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 
 	if (!(gaudi->hw_cap_initialized & HW_CAP_MMU) ||
 		hdev->hard_reset_pending)
-		return;
-
-	mutex_lock(&hdev->mmu_cache_lock);
+		return 0;
 
 	if (hdev->pldm)
 		timeout_usec = GAUDI_PLDM_MMU_TIMEOUT_USEC;
 	else
 		timeout_usec = MMU_CONFIG_TIMEOUT_USEC;
 
+	mutex_lock(&hdev->mmu_cache_lock);
+
 	/* L0 & L1 invalidation */
 	WREG32(mmSTLB_INV_PS, 2);
 
@@ -6006,14 +6006,18 @@ static void gaudi_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 
 	WREG32(mmSTLB_INV_SET, 0);
 
-	if (rc)
-		dev_notice_ratelimited(hdev->dev,
-			"Timeout when waiting for MMU cache invalidation\n");
-
 	mutex_unlock(&hdev->mmu_cache_lock);
+
+	if (rc) {
+		dev_err_ratelimited(hdev->dev,
+					"MMU cache invalidation timeout\n");
+		hl_device_reset(hdev, true, false);
+	}
+
+	return rc;
 }
 
-static void gaudi_mmu_invalidate_cache_range(struct hl_device *hdev,
+static int gaudi_mmu_invalidate_cache_range(struct hl_device *hdev,
 				bool is_hard, u32 asid, u64 va, u64 size)
 {
 	struct gaudi_device *gaudi = hdev->asic_specific;
@@ -6024,7 +6028,7 @@ static void gaudi_mmu_invalidate_cache_range(struct hl_device *hdev,
 
 	if (!(gaudi->hw_cap_initialized & HW_CAP_MMU) ||
 		hdev->hard_reset_pending)
-		return;
+		return 0;
 
 	mutex_lock(&hdev->mmu_cache_lock);
 
@@ -6055,11 +6059,15 @@ static void gaudi_mmu_invalidate_cache_range(struct hl_device *hdev,
 		1000,
 		timeout_usec);
 
-	if (rc)
-		dev_notice_ratelimited(hdev->dev,
-			"Timeout when waiting for MMU cache invalidation\n");
-
 	mutex_unlock(&hdev->mmu_cache_lock);
+
+	if (rc) {
+		dev_err_ratelimited(hdev->dev,
+					"MMU cache invalidation timeout\n");
+		hl_device_reset(hdev, true, false);
+	}
+
+	return rc;
 }
 
 static int gaudi_mmu_update_asid_hop0_addr(struct hl_device *hdev,
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 152418dfe20c..0d2952bb58df 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4884,7 +4884,7 @@ static void goya_mmu_prepare(struct hl_device *hdev, u32 asid)
 		goya_mmu_prepare_reg(hdev, goya_mmu_regs[i], asid);
 }
 
-static void goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
+static int goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 					u32 flags)
 {
 	struct goya_device *goya = hdev->asic_specific;
@@ -4893,11 +4893,11 @@ static void goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 
 	if (!(goya->hw_cap_initialized & HW_CAP_MMU) ||
 		hdev->hard_reset_pending)
-		return;
+		return 0;
 
 	/* no need in L1 only invalidation in Goya */
 	if (!is_hard)
-		return;
+		return 0;
 
 	if (hdev->pldm)
 		timeout_usec = GOYA_PLDM_MMU_TIMEOUT_USEC;
@@ -4919,13 +4919,17 @@ static void goya_mmu_invalidate_cache(struct hl_device *hdev, bool is_hard,
 
 	mutex_unlock(&hdev->mmu_cache_lock);
 
-	if (rc)
-		dev_notice_ratelimited(hdev->dev,
-			"Timeout when waiting for MMU cache invalidation\n");
+	if (rc) {
+		dev_err_ratelimited(hdev->dev,
+					"MMU cache invalidation timeout\n");
+		hl_device_reset(hdev, true, false);
+	}
+
+	return rc;
 }
 
-static void goya_mmu_invalidate_cache_range(struct hl_device *hdev,
-		bool is_hard, u32 asid, u64 va, u64 size)
+static int goya_mmu_invalidate_cache_range(struct hl_device *hdev,
+				bool is_hard, u32 asid, u64 va, u64 size)
 {
 	struct goya_device *goya = hdev->asic_specific;
 	u32 status, timeout_usec, inv_data, pi;
@@ -4933,11 +4937,11 @@ static void goya_mmu_invalidate_cache_range(struct hl_device *hdev,
 
 	if (!(goya->hw_cap_initialized & HW_CAP_MMU) ||
 		hdev->hard_reset_pending)
-		return;
+		return 0;
 
 	/* no need in L1 only invalidation in Goya */
 	if (!is_hard)
-		return;
+		return 0;
 
 	if (hdev->pldm)
 		timeout_usec = GOYA_PLDM_MMU_TIMEOUT_USEC;
@@ -4970,9 +4974,13 @@ static void goya_mmu_invalidate_cache_range(struct hl_device *hdev,
 
 	mutex_unlock(&hdev->mmu_cache_lock);
 
-	if (rc)
-		dev_notice_ratelimited(hdev->dev,
-			"Timeout when waiting for MMU cache invalidation\n");
+	if (rc) {
+		dev_err_ratelimited(hdev->dev,
+					"MMU cache invalidation timeout\n");
+		hl_device_reset(hdev, true, false);
+	}
+
+	return rc;
 }
 
 int goya_send_heartbeat(struct hl_device *hdev)
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 0f0691875298..1ecdcf8b763a 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -675,9 +675,9 @@ struct hl_asic_funcs {
 				u32 *size);
 	u64 (*read_pte)(struct hl_device *hdev, u64 addr);
 	void (*write_pte)(struct hl_device *hdev, u64 addr, u64 val);
-	void (*mmu_invalidate_cache)(struct hl_device *hdev, bool is_hard,
+	int (*mmu_invalidate_cache)(struct hl_device *hdev, bool is_hard,
 					u32 flags);
-	void (*mmu_invalidate_cache_range)(struct hl_device *hdev, bool is_hard,
+	int (*mmu_invalidate_cache_range)(struct hl_device *hdev, bool is_hard,
 			u32 asid, u64 va, u64 size);
 	int (*send_heartbeat)(struct hl_device *hdev);
 	void (*enable_clock_gating)(struct hl_device *hdev);
@@ -755,8 +755,8 @@ struct hl_va_range {
  *                      with huge pages.
  * @dram_va_range: holds available virtual addresses for DRAM mappings.
  * @mem_hash_lock: protects the mem_hash.
- * @mmu_lock: protects the MMU page tables. Any change to the PGT, modifing the
- *            MMU hash or walking the PGT requires talking this lock
+ * @mmu_lock: protects the MMU page tables. Any change to the PGT, modifying the
+ *            MMU hash or walking the PGT requires talking this lock.
  * @debugfs_list: node in debugfs list of contexts.
  * @cs_sequence: sequence number for CS. Value is assigned to a CS and passed
  *			to user so user could inquire about CS. It is used as
diff --git a/drivers/misc/habanalabs/memory.c b/drivers/misc/habanalabs/memory.c
index a72f766ca470..4b8eed1ca513 100644
--- a/drivers/misc/habanalabs/memory.c
+++ b/drivers/misc/habanalabs/memory.c
@@ -886,6 +886,7 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 
 		vm_type = (enum vm_type_t *) userptr;
 		hint_addr = args->map_host.hint_addr;
+		handle = phys_pg_pack->handle;
 	} else {
 		handle = lower_32_bits(args->map_device.handle);
 
@@ -954,10 +955,17 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args,
 		goto map_err;
 	}
 
-	hdev->asic_funcs->mmu_invalidate_cache(hdev, false, *vm_type);
+	rc = hdev->asic_funcs->mmu_invalidate_cache(hdev, false, *vm_type);
 
 	mutex_unlock(&ctx->mmu_lock);
 
+	if (rc) {
+		dev_err(hdev->dev,
+			"mapping handle %u failed due to MMU cache invalidation\n",
+			handle);
+		goto map_err;
+	}
+
 	ret_vaddr += phys_pg_pack->offset;
 
 	hnode->ptr = vm_type;
@@ -1083,21 +1091,34 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr, bool ctx_free)
 	 * at the loop end rather than for each iteration
 	 */
 	if (!ctx_free)
-		hdev->asic_funcs->mmu_invalidate_cache(hdev, true, *vm_type);
+		rc = hdev->asic_funcs->mmu_invalidate_cache(hdev, true,
+								*vm_type);
 
 	mutex_unlock(&ctx->mmu_lock);
 
 	/*
-	 * No point in maintaining the free VA block list if the context is
-	 * closing as the list will be freed anyway
+	 * If the context is closing we don't need to check for the MMU cache
+	 * invalidation return code and update the VA free list as in this flow
+	 * we invalidate the MMU cache outside of this unmap function and the VA
+	 * free list will be freed anyway.
 	 */
 	if (!ctx_free) {
-		rc = add_va_block(hdev, va_range, vaddr,
-					vaddr + phys_pg_pack->total_size - 1);
+		int tmp_rc;
+
 		if (rc)
+			dev_err(hdev->dev,
+				"unmapping vaddr 0x%llx failed due to MMU cache invalidation\n",
+				vaddr);
+
+		tmp_rc = add_va_block(hdev, va_range, vaddr,
+					vaddr + phys_pg_pack->total_size - 1);
+		if (tmp_rc) {
 			dev_warn(hdev->dev,
 					"add va block failed for vaddr: 0x%llx\n",
 					vaddr);
+			if (!rc)
+				rc = tmp_rc;
+		}
 	}
 
 	atomic_dec(&phys_pg_pack->mapping_cnt);
@@ -1108,7 +1129,7 @@ static int unmap_device_va(struct hl_ctx *ctx, u64 vaddr, bool ctx_free)
 		dma_unmap_host_va(hdev, userptr);
 	}
 
-	return 0;
+	return rc;
 
 mapping_cnt_err:
 	if (is_userptr)
-- 
2.17.1

