Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A22C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A75B2206F2
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 08:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfJt/cAM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgC1Iwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 04:52:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36210 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726316AbgC1Iwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 04:52:49 -0400
Received: by mail-wr1-f65.google.com with SMTP id 31so14558176wrs.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 01:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=InlW8Sz+Gmo/5bga6VjhdX/uC/q4xSSsJKQ3pG8saLQ=;
        b=DfJt/cAMt8IVLdcMdRnkUFuQAoPanK1ao5ntOGtEqn67gUR5zqMRLgm5mPfSVKgVgu
         BavnMUmE/hQG1kzELYKUa+VzL1TCcvL6yUNWvxsu2lYF4QOzpdtCy49xEmw26Uyk1A7/
         WiZWYQvfMlk2sBJESJjhkwGxIIw0Ab0F3p8qrH2i/QDCt9Sj19A9hG4SYdmGzoZ1AT2l
         82BxwCCJR2zlTKKKhhF0U5C0j+cITLZSbgA/yShirpYCIb+47gCoVzeJ/kW06e/HQkq2
         a4/uN++CkUvmxsNvh/7ZlL1BW46b/FjAk6VUawtaeZFXpMnYsBzOK3HqP9p5mmX5EXgU
         i9Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=InlW8Sz+Gmo/5bga6VjhdX/uC/q4xSSsJKQ3pG8saLQ=;
        b=mTnmpcTnmuD+cuFoAyarUN6zjP81Of8O8Bzd+Hp85l22xV5Inyg0KU7ZvXVmLsA5nQ
         PeAOfeEk6MIDJn/FW6msf151UBPTERk4W3aR7lmq+2d44I6I3U1HdpZ3Nh5dybrvyyn6
         e5oH/YA0gukzoyAdKqDM/x5HVPEjjaAKRQJ6CZ6zn0E6ge3pxZOcrPAUA/3GJOYD5EIZ
         wTlxwRRbnbUTmfYoRPq1Clz+5Kf2j8v1qSh96/E3/KE16nnmQlRkby1TelddD1vKS4Kx
         /8R9FygpBv6N08tXGrPCShQmYpgRmGLwO/NfK8AqcEWMTCAnuhKiN/AvIP1I2SbUcjU/
         1RpA==
X-Gm-Message-State: ANhLgQ0QaRRUQPq7wMpd6RCZv4CJrphtKkEnRfPamT7BxkYKxqhSHpD5
        0+VL9F1wBiZRHq3Mqk3YhPJCOrE0
X-Google-Smtp-Source: ADFU+vs+AiplgZkbu32tAp4khRyGauBtp4qcxIR886brycirteQu1ImQhtrlpxMDQfkMG7UM4yM23A==
X-Received: by 2002:adf:aacc:: with SMTP id i12mr4122782wrc.116.1585385566242;
        Sat, 28 Mar 2020 01:52:46 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id k15sm11908683wrm.55.2020.03.28.01.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2020 01:52:45 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 3/6] habanalabs: re-factor H/W queues initialization
Date:   Sat, 28 Mar 2020 11:52:35 +0300
Message-Id: <20200328085238.3428-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200328085238.3428-1-oded.gabbay@gmail.com>
References: <20200328085238.3428-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omer Shpigelman <oshpigelman@habana.ai>

We want to remove the following restrictions/assumptions in our driver:
1. The H/W queue index is also the completion queue index.
2. The H/W queue index is also the IRQ number of the completion queue.
3. All queues of the same type have consecutive indexes.

Therefore we add the support for H/W queues of the same type with
nonconsecutive indexes and completion queue index and IRQ number different
than the H/W queue index.

Signed-off-by: Omer Shpigelman <oshpigelman@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/device.c     | 17 +++++++++--------
 drivers/misc/habanalabs/goya/goya.c  |  9 ++++++++-
 drivers/misc/habanalabs/goya/goyaP.h |  1 +
 drivers/misc/habanalabs/habanalabs.h |  6 ++++++
 drivers/misc/habanalabs/hw_queue.c   | 10 +++++-----
 5 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/misc/habanalabs/device.c b/drivers/misc/habanalabs/device.c
index aef4de36b7aa..c89157dafa33 100644
--- a/drivers/misc/habanalabs/device.c
+++ b/drivers/misc/habanalabs/device.c
@@ -1062,7 +1062,7 @@ int hl_device_reset(struct hl_device *hdev, bool hard_reset,
  */
 int hl_device_init(struct hl_device *hdev, struct class *hclass)
 {
-	int i, rc, cq_ready_cnt;
+	int i, rc, cq_cnt, cq_ready_cnt;
 	char *name;
 	bool add_cdev_sysfs_on_err = false;
 
@@ -1120,14 +1120,16 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto sw_fini;
 	}
 
+	cq_cnt = hdev->asic_prop.completion_queues_count;
+
 	/*
 	 * Initialize the completion queues. Must be done before hw_init,
 	 * because there the addresses of the completion queues are being
 	 * passed as arguments to request_irq
 	 */
-	hdev->completion_queue =
-			kcalloc(hdev->asic_prop.completion_queues_count,
-				sizeof(*hdev->completion_queue), GFP_KERNEL);
+	hdev->completion_queue = kcalloc(cq_cnt,
+						sizeof(*hdev->completion_queue),
+						GFP_KERNEL);
 
 	if (!hdev->completion_queue) {
 		dev_err(hdev->dev, "failed to allocate completion queues\n");
@@ -1135,10 +1137,9 @@ int hl_device_init(struct hl_device *hdev, struct class *hclass)
 		goto hw_queues_destroy;
 	}
 
-	for (i = 0, cq_ready_cnt = 0;
-			i < hdev->asic_prop.completion_queues_count;
-			i++, cq_ready_cnt++) {
-		rc = hl_cq_init(hdev, &hdev->completion_queue[i], i);
+	for (i = 0, cq_ready_cnt = 0 ; i < cq_cnt ; i++, cq_ready_cnt++) {
+		rc = hl_cq_init(hdev, &hdev->completion_queue[i],
+				hdev->asic_funcs->get_queue_id_for_cq(hdev, i));
 		if (rc) {
 			dev_err(hdev->dev,
 				"failed to initialize completion queue\n");
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 08f1d4080008..f7eb60f5f6f9 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -890,6 +890,7 @@ void goya_init_dma_qmans(struct hl_device *hdev)
 	q = &hdev->kernel_queues[0];
 
 	for (i = 0 ; i < NUMBER_OF_EXT_HW_QUEUES ; i++, q++) {
+		q->cq_id = q->msi_vec = i;
 		goya_init_dma_qman(hdev, i, q->bus_address);
 		goya_init_dma_ch(hdev, i);
 	}
@@ -5273,6 +5274,11 @@ static enum hl_device_hw_state goya_get_hw_state(struct hl_device *hdev)
 	return RREG32(mmHW_STATE);
 }
 
+u32 goya_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx)
+{
+	return cq_idx;
+}
+
 static const struct hl_asic_funcs goya_funcs = {
 	.early_init = goya_early_init,
 	.early_fini = goya_early_fini,
@@ -5332,7 +5338,8 @@ static const struct hl_asic_funcs goya_funcs = {
 	.rreg = hl_rreg,
 	.wreg = hl_wreg,
 	.halt_coresight = goya_halt_coresight,
-	.get_clk_rate = goya_get_clk_rate
+	.get_clk_rate = goya_get_clk_rate,
+	.get_queue_id_for_cq = goya_get_queue_id_for_cq
 };
 
 /*
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index 1555d03e3cb2..5db5f6ea1d98 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -234,5 +234,6 @@ void goya_cpu_accessible_dma_pool_free(struct hl_device *hdev, size_t size,
 void goya_mmu_remove_device_cpu_mappings(struct hl_device *hdev);
 
 int goya_get_clk_rate(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
+u32 goya_get_queue_id_for_cq(struct hl_device *hdev, u32 cq_idx);
 
 #endif /* GOYAP_H_ */
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index ae3db8eb2fb5..299add419e79 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -365,6 +365,8 @@ struct hl_cs_job;
  * @pi: holds the queue's pi value.
  * @ci: holds the queue's ci value, AS CALCULATED BY THE DRIVER (not real ci).
  * @hw_queue_id: the id of the H/W queue.
+ * @cq_id: the id for the corresponding CQ for this H/W queue.
+ * @msi_vec: the IRQ number of the H/W queue.
  * @int_queue_len: length of internal queue (number of entries).
  * @valid: is the queue valid (we have array of 32 queues, not all of them
  *		exists).
@@ -377,6 +379,8 @@ struct hl_hw_queue {
 	u32			pi;
 	u32			ci;
 	u32			hw_queue_id;
+	u32			cq_id;
+	u32			msi_vec;
 	u16			int_queue_len;
 	u8			valid;
 };
@@ -534,6 +538,7 @@ enum hl_pll_frequency {
  * @wreg: Write a register. Needed for simulator support.
  * @halt_coresight: stop the ETF and ETR traces.
  * @get_clk_rate: Retrieve the ASIC current and maximum clock rate in MHz
+ * @get_queue_id_for_cq: Get the H/W queue id related to the given CQ index.
  */
 struct hl_asic_funcs {
 	int (*early_init)(struct hl_device *hdev);
@@ -620,6 +625,7 @@ struct hl_asic_funcs {
 	void (*wreg)(struct hl_device *hdev, u32 reg, u32 val);
 	void (*halt_coresight)(struct hl_device *hdev);
 	int (*get_clk_rate)(struct hl_device *hdev, u32 *cur_clk, u32 *max_clk);
+	u32 (*get_queue_id_for_cq)(struct hl_device *hdev, u32 cq_idx);
 };
 
 
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index 91579dde9262..8248adcc7ef8 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -111,7 +111,7 @@ static int ext_queue_sanity_checks(struct hl_device *hdev,
 				bool reserve_cq_entry)
 {
 	atomic_t *free_slots =
-			&hdev->completion_queue[q->hw_queue_id].free_slots_cnt;
+			&hdev->completion_queue[q->cq_id].free_slots_cnt;
 	int free_slots_cnt;
 
 	/* Check we have enough space in the queue */
@@ -194,7 +194,7 @@ static int hw_queue_sanity_checks(struct hl_device *hdev, struct hl_hw_queue *q,
 					int num_of_entries)
 {
 	atomic_t *free_slots =
-			&hdev->completion_queue[q->hw_queue_id].free_slots_cnt;
+			&hdev->completion_queue[q->cq_id].free_slots_cnt;
 
 	/*
 	 * Check we have enough space in the completion queue.
@@ -308,13 +308,13 @@ static void ext_queue_schedule_job(struct hl_cs_job *job)
 	 * No need to check if CQ is full because it was already
 	 * checked in ext_queue_sanity_checks
 	 */
-	cq = &hdev->completion_queue[q->hw_queue_id];
+	cq = &hdev->completion_queue[q->cq_id];
 	cq_addr = cq->bus_address + cq->pi * sizeof(struct hl_cq_entry);
 
 	hdev->asic_funcs->add_end_of_cb_packets(hdev, cb->kernel_address, len,
 						cq_addr,
 						le32_to_cpu(cq_pkt.data),
-						q->hw_queue_id);
+						q->msi_vec);
 
 	q->shadow_queue[hl_pi_2_offset(q->pi)] = job;
 
@@ -401,7 +401,7 @@ static void hw_queue_schedule_job(struct hl_cs_job *job)
 	 * No need to check if CQ is full because it was already
 	 * checked in hw_queue_sanity_checks
 	 */
-	cq = &hdev->completion_queue[q->hw_queue_id];
+	cq = &hdev->completion_queue[q->cq_id];
 	cq->pi = hl_cq_inc_ptr(cq->pi);
 
 	ext_and_hw_queue_submit_bd(hdev, q, ctl, len, ptr);
-- 
2.17.1

