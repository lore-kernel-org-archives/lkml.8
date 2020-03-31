Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFCF6C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8957720675
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWu7jFxK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731021AbgCaO4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:56:10 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40634 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730511AbgCaO4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:56:09 -0400
Received: by mail-wm1-f66.google.com with SMTP id a81so3061820wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 07:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QRAHV/0QWc+6YkHTGwBi3yO06BtooQlbTnVyJvbMoRw=;
        b=SWu7jFxKyoO+/YCp3gzmqecYqmTncBI9Dm29Ll6lMYIg2sciPRIW8KTuJ13VNvsgPa
         i8Kr1KQBf0ZMOGfeol/EfhxBJ0y5n9fNRyzJX3AO6p81gfVvWPXt7QfQivT5B5M6rJf0
         WNcTbHR7iTREmuXLBe2CJ208JN2ahmRQmRXVsPOlc7NVymTktywQDC02BA1Zgun8OqNq
         //YintZVAukRuN8anRnJZCkvMyvo61s2+czhwPpEfrnV8jq5ec4C/RpDx/7yTepUNBaN
         zMBH6PLgQ+AWzXavT1Zyy3xJ7z+zJc09Gk3hGSdUMsxsQa6fqTQed7pfJ7c/htoNTTDk
         wFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QRAHV/0QWc+6YkHTGwBi3yO06BtooQlbTnVyJvbMoRw=;
        b=PBkUkLNLqIMuhhiLBsYv5C7mnQ5oeRi3xtERGJ0YpANV/5VWvWew6jaENXfiOELFtG
         hCOHJaXUErrUvzgtfQgkilS9hcbRH7iUT6mvKDiMChq2CNcqTR1houFdnMVvtcPFQC8+
         GRDxJlJiFpvSwDO1E2be+AfhSzTLPKysrwVP8G8Eh8uOHj1OCmdvf8/KlWm16YCDQddz
         JPEJkoDBeWYACspTSTG9XmuiKqqZ6YBSeE05iS/xxJzfB055Yv+4SzHu86SYW7/SQlwk
         3rywB/72KRtr6jXJBo+TaGk/4TBjyq+9SbJZL34eNc7yQi1Nt/GyfT7mtW78SIZ+1tvK
         tWgw==
X-Gm-Message-State: ANhLgQ3w5PVpB3dNSu3Nd6HMSJ5G5GeEigGRYVGmt15b3XysqctVZXqJ
        Lc1YiF6CQi9jBM0LoNRNjuBicsPR
X-Google-Smtp-Source: ADFU+vus6YLpwaiEyZSM9eSCadksJYM7CKZmA7hlLVNrCDnjm4voj6IFZ7ZmZTEaEaWvSF3tpXUvDQ==
X-Received: by 2002:a1c:bad5:: with SMTP id k204mr3778260wmf.162.1585666565576;
        Tue, 31 Mar 2020 07:56:05 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id r3sm27118507wrm.35.2020.03.31.07.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 07:56:04 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH 2/2] habanalabs: handle barriers in DMA QMAN streams
Date:   Tue, 31 Mar 2020 17:56:00 +0300
Message-Id: <20200331145600.768-2-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200331145600.768-1-oded.gabbay@gmail.com>
References: <20200331145600.768-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we have DMA QMAN with multiple streams, we need to know whether the
command buffer contains at least one DMA packet in order to configure the
barriers correctly when adding the 2xMSG_PROT at the end of the JOB. If
there is no DMA packet, then there is no need to put engine barrier. This
is relevant only for GAUDI as GOYA doesn't have streams so the engine can't
be busy by another stream.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/command_submission.c |  1 +
 drivers/misc/habanalabs/goya/goya.c          |  3 ++-
 drivers/misc/habanalabs/goya/goyaP.h         |  3 ++-
 drivers/misc/habanalabs/habanalabs.h         | 17 ++++++++++++++++-
 drivers/misc/habanalabs/hw_queue.c           |  3 ++-
 5 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/habanalabs/command_submission.c b/drivers/misc/habanalabs/command_submission.c
index 409276b6374d..6680e183d881 100644
--- a/drivers/misc/habanalabs/command_submission.c
+++ b/drivers/misc/habanalabs/command_submission.c
@@ -113,6 +113,7 @@ static int cs_parser(struct hl_fpriv *hpriv, struct hl_cs_job *job)
 		if (!rc) {
 			job->patched_cb = parser.patched_cb;
 			job->job_cb_size = parser.patched_cb_size;
+			job->contains_dma_pkt = parser.contains_dma_pkt;
 
 			spin_lock(&job->patched_cb->lock);
 			job->patched_cb->cs_cnt++;
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 85f29cb7d67b..19c3bdf4c358 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -3903,7 +3903,8 @@ int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser)
 }
 
 void goya_add_end_of_cb_packets(struct hl_device *hdev, u64 kernel_address,
-				u32 len, u64 cq_addr, u32 cq_val, u32 msix_vec)
+				u32 len, u64 cq_addr, u32 cq_val, u32 msix_vec,
+				bool eb)
 {
 	struct packet_msg_prot *cq_pkt;
 	u32 tmp;
diff --git a/drivers/misc/habanalabs/goya/goyaP.h b/drivers/misc/habanalabs/goya/goyaP.h
index a05250e53175..86857cdd36b1 100644
--- a/drivers/misc/habanalabs/goya/goyaP.h
+++ b/drivers/misc/habanalabs/goya/goyaP.h
@@ -216,7 +216,8 @@ void goya_handle_eqe(struct hl_device *hdev, struct hl_eq_entry *eq_entry);
 void *goya_get_events_stat(struct hl_device *hdev, bool aggregate, u32 *size);
 
 void goya_add_end_of_cb_packets(struct hl_device *hdev, u64 kernel_address,
-				u32 len, u64 cq_addr, u32 cq_val, u32 msix_vec);
+				u32 len, u64 cq_addr, u32 cq_val, u32 msix_vec,
+				bool eb);
 int goya_cs_parser(struct hl_device *hdev, struct hl_cs_parser *parser);
 void *goya_get_int_queue_base(struct hl_device *hdev, u32 queue_id,
 				dma_addr_t *dma_handle,	u16 *queue_len);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 29b9767387af..8db955485609 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -598,7 +598,8 @@ struct hl_asic_funcs {
 					struct sg_table *sgt);
 	void (*add_end_of_cb_packets)(struct hl_device *hdev,
 					u64 kernel_address, u32 len,
-					u64 cq_addr, u32 cq_val, u32 msix_num);
+					u64 cq_addr, u32 cq_val, u32 msix_num,
+					bool eb);
 	void (*update_eq_ci)(struct hl_device *hdev, u32 val);
 	int (*context_switch)(struct hl_device *hdev, u32 asid);
 	void (*restore_phase_topology)(struct hl_device *hdev);
@@ -824,6 +825,12 @@ struct hl_cs {
  * @is_kernel_allocated_cb: true if the CB handle we got from the user holds a
  *                          handle to a kernel-allocated CB object, false
  *                          otherwise (SRAM/DRAM/host address).
+ * @contains_dma_pkt: whether the JOB contains at least one DMA packet. This
+ *                    info is needed later, when adding the 2xMSG_PROT at the
+ *                    end of the JOB, to know which barriers to put in the
+ *                    MSG_PROT packets. Relevant only for GAUDI as GOYA doesn't
+ *                    have streams so the engine can't be busy by another
+ *                    stream.
  */
 struct hl_cs_job {
 	struct list_head	cs_node;
@@ -839,6 +846,7 @@ struct hl_cs_job {
 	u32			user_cb_size;
 	u32			job_cb_size;
 	u8			is_kernel_allocated_cb;
+	u8			contains_dma_pkt;
 };
 
 /**
@@ -858,6 +866,12 @@ struct hl_cs_job {
  * @is_kernel_allocated_cb: true if the CB handle we got from the user holds a
  *                          handle to a kernel-allocated CB object, false
  *                          otherwise (SRAM/DRAM/host address).
+ * @contains_dma_pkt: whether the JOB contains at least one DMA packet. This
+ *                    info is needed later, when adding the 2xMSG_PROT at the
+ *                    end of the JOB, to know which barriers to put in the
+ *                    MSG_PROT packets. Relevant only for GAUDI as GOYA doesn't
+ *                    have streams so the engine can't be busy by another
+ *                    stream.
  */
 struct hl_cs_parser {
 	struct hl_cb		*user_cb;
@@ -871,6 +885,7 @@ struct hl_cs_parser {
 	u32			patched_cb_size;
 	u8			job_id;
 	u8			is_kernel_allocated_cb;
+	u8			contains_dma_pkt;
 };
 
 
diff --git a/drivers/misc/habanalabs/hw_queue.c b/drivers/misc/habanalabs/hw_queue.c
index 8248adcc7ef8..a5abc224399d 100644
--- a/drivers/misc/habanalabs/hw_queue.c
+++ b/drivers/misc/habanalabs/hw_queue.c
@@ -314,7 +314,8 @@ static void ext_queue_schedule_job(struct hl_cs_job *job)
 	hdev->asic_funcs->add_end_of_cb_packets(hdev, cb->kernel_address, len,
 						cq_addr,
 						le32_to_cpu(cq_pkt.data),
-						q->msi_vec);
+						q->msi_vec,
+						job->contains_dma_pkt);
 
 	q->shadow_queue[hl_pi_2_offset(q->pi)] = job;
 
-- 
2.17.1

