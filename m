Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E6DC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE0A20809
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="DSz2FxW/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgGPVSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:18:07 -0400
Received: from ale.deltatee.com ([204.191.154.188]:47706 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgGPVSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qoWf29NonWBDS/dE5K9e8x3kpYviQVg7RloXxFpEbBU=; b=DSz2FxW/UzFPrN4SejOnRpSVV/
        y6GNFsZQTvevKIBgiRFU8uB7CDAKsTWQeLjwVJx80U2fVKxQCx8qXwNb4U8PVCAmNUQAo7R56EVJa
        pai5AhdnKhYLM5JwYwMsj4AtGYVBvmsFGddfQJmCjySVFYVMHx6BbzLMfZ8kHgSLHubiZfSO+Rlos
        VU0Oxpaa5Fcqmf+zLtGj4GiUZUuNuEHeZCQaHJq4uCWFIGWlrPnLHKiJlaWNbJtaLpFTQyMXAAawb
        eA+ElJgpX2gVlnFJA/O3PwmOTwXwXfdJzYypJY+rMYwOIcH/VWRkbmiAmfDnH0k5HI6H/L1tDxoDZ
        +VVIS4qQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jwAZS-0005uJ-9X; Thu, 16 Jul 2020 14:33:35 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jwAZE-0004BQ-PC; Thu, 16 Jul 2020 14:33:20 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 16 Jul 2020 14:33:13 -0600
Message-Id: <20200716203319.16022-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200716203319.16022-1-logang@deltatee.com>
References: <20200716203319.16022-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v15 3/9] nvme: Move nvme_passthru_[start|end]() calls to common helper
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a new nvme_execute_passthru_rq() helper which calls
nvme_passthru_[start|end]() around blk_execute_rq(). This ensures
all passthru calls (including nvme_submit_io()) will be wrapped
appropriately.

nvme_execute_passthru_rq() will also be useful for the nvmet passthru
code.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 215 ++++++++++++++++++++-------------------
 1 file changed, 111 insertions(+), 104 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 80d534c5bc44..817ab76d2838 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -911,6 +911,116 @@ static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 	return ERR_PTR(ret);
 }
 
+static u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+				u8 opcode)
+{
+	u32 effects = 0;
+
+	if (ns) {
+		if (ns->head->effects)
+			effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
+		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
+			dev_warn(ctrl->device,
+				 "IO command:%02x has unhandled effects:%08x\n",
+				 opcode, effects);
+		return 0;
+	}
+
+	if (ctrl->effects)
+		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
+
+	switch (opcode) {
+	case nvme_admin_format_nvm:
+		effects |= NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
+			NVME_CMD_EFFECTS_CSE_MASK;
+		break;
+	case nvme_admin_sanitize_nvm:
+		effects |= NVME_CMD_EFFECTS_CSE_MASK;
+		break;
+	default:
+		break;
+	}
+
+	return effects;
+}
+
+static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			       u8 opcode)
+{
+	u32 effects = nvme_command_effects(ctrl, ns, opcode);
+
+	/*
+	 * For simplicity, IO to all namespaces is quiesced even if the command
+	 * effects say only one namespace is affected.
+	 */
+	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
+		mutex_lock(&ctrl->scan_lock);
+		mutex_lock(&ctrl->subsys->lock);
+		nvme_mpath_start_freeze(ctrl->subsys);
+		nvme_mpath_wait_freeze(ctrl->subsys);
+		nvme_start_freeze(ctrl);
+		nvme_wait_freeze(ctrl);
+	}
+	return effects;
+}
+
+static void nvme_update_formats(struct nvme_ctrl *ctrl, u32 *effects)
+{
+	struct nvme_ns *ns;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		if (_nvme_revalidate_disk(ns->disk))
+			nvme_set_queue_dying(ns);
+		else if (blk_queue_is_zoned(ns->disk->queue)) {
+			/*
+			 * IO commands are required to fully revalidate a zoned
+			 * device. Force the command effects to trigger rescan
+			 * work so report zones can run in a context with
+			 * unfrozen IO queues.
+			 */
+			*effects |= NVME_CMD_EFFECTS_NCC;
+		}
+	up_read(&ctrl->namespaces_rwsem);
+}
+
+static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
+{
+	/*
+	 * Revalidate LBA changes prior to unfreezing. This is necessary to
+	 * prevent memory corruption if a logical block size was changed by
+	 * this command.
+	 */
+	if (effects & NVME_CMD_EFFECTS_LBCC)
+		nvme_update_formats(ctrl, &effects);
+	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
+		nvme_unfreeze(ctrl);
+		nvme_mpath_unfreeze(ctrl->subsys);
+		mutex_unlock(&ctrl->subsys->lock);
+		nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
+		mutex_unlock(&ctrl->scan_lock);
+	}
+	if (effects & NVME_CMD_EFFECTS_CCC)
+		nvme_init_identify(ctrl);
+	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
+		nvme_queue_scan(ctrl);
+		flush_work(&ctrl->scan_work);
+	}
+}
+
+static void nvme_execute_passthru_rq(struct request *rq)
+{
+	struct nvme_command *cmd = nvme_req(rq)->cmd;
+	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
+	struct nvme_ns *ns = rq->q->queuedata;
+	struct gendisk *disk = ns ? ns->disk : NULL;
+	u32 effects;
+
+	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
+	blk_execute_rq(rq->q, disk, rq, 0);
+	nvme_passthru_end(ctrl, effects);
+}
+
 static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, void __user *ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
@@ -949,7 +1059,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		}
 	}
 
-	blk_execute_rq(req->q, disk, req, 0);
+	nvme_execute_passthru_rq(req);
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
 	else
@@ -1377,110 +1487,12 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
 }
 
-static u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-				u8 opcode)
-{
-	u32 effects = 0;
-
-	if (ns) {
-		if (ns->head->effects)
-			effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
-		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
-			dev_warn(ctrl->device,
-				 "IO command:%02x has unhandled effects:%08x\n",
-				 opcode, effects);
-		return 0;
-	}
-
-	if (ctrl->effects)
-		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
-
-	switch (opcode) {
-	case nvme_admin_format_nvm:
-		effects |= NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
-			NVME_CMD_EFFECTS_CSE_MASK;
-		break;
-	case nvme_admin_sanitize_nvm:
-		effects |= NVME_CMD_EFFECTS_CSE_MASK;
-		break;
-	default:
-		break;
-	}
-
-	return effects;
-}
-
-static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-			       u8 opcode)
-{
-	u32 effects = nvme_command_effects(ctrl, ns, opcode);
-
-	/*
-	 * For simplicity, IO to all namespaces is quiesced even if the command
-	 * effects say only one namespace is affected.
-	 */
-	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
-		mutex_lock(&ctrl->scan_lock);
-		mutex_lock(&ctrl->subsys->lock);
-		nvme_mpath_start_freeze(ctrl->subsys);
-		nvme_mpath_wait_freeze(ctrl->subsys);
-		nvme_start_freeze(ctrl);
-		nvme_wait_freeze(ctrl);
-	}
-	return effects;
-}
-
-static void nvme_update_formats(struct nvme_ctrl *ctrl, u32 *effects)
-{
-	struct nvme_ns *ns;
-
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
-		if (_nvme_revalidate_disk(ns->disk))
-			nvme_set_queue_dying(ns);
-		else if (blk_queue_is_zoned(ns->disk->queue)) {
-			/*
-			 * IO commands are required to fully revalidate a zoned
-			 * device. Force the command effects to trigger rescan
-			 * work so report zones can run in a context with
-			 * unfrozen IO queues.
-			 */
-			*effects |= NVME_CMD_EFFECTS_NCC;
-		}
-	up_read(&ctrl->namespaces_rwsem);
-}
-
-static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
-{
-	/*
-	 * Revalidate LBA changes prior to unfreezing. This is necessary to
-	 * prevent memory corruption if a logical block size was changed by
-	 * this command.
-	 */
-	if (effects & NVME_CMD_EFFECTS_LBCC)
-		nvme_update_formats(ctrl, &effects);
-	if (effects & (NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK)) {
-		nvme_unfreeze(ctrl);
-		nvme_mpath_unfreeze(ctrl->subsys);
-		mutex_unlock(&ctrl->subsys->lock);
-		nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
-		mutex_unlock(&ctrl->scan_lock);
-	}
-	if (effects & NVME_CMD_EFFECTS_CCC)
-		nvme_init_identify(ctrl);
-	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC)) {
-		nvme_queue_scan(ctrl);
-		flush_work(&ctrl->scan_work);
-	}
-}
-
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			struct nvme_passthru_cmd __user *ucmd)
 {
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
 	unsigned timeout = 0;
-	u32 effects;
 	u64 result;
 	int status;
 
@@ -1507,12 +1519,10 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
-	effects = nvme_passthru_start(ctrl, ns, cmd.opcode);
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			nvme_to_user_ptr(cmd.addr), cmd.data_len,
 			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
 			0, &result, timeout);
-	nvme_passthru_end(ctrl, effects);
 
 	if (status >= 0) {
 		if (put_user(result, &ucmd->result))
@@ -1528,7 +1538,6 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct nvme_passthru_cmd64 cmd;
 	struct nvme_command c;
 	unsigned timeout = 0;
-	u32 effects;
 	int status;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -1554,12 +1563,10 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
 
-	effects = nvme_passthru_start(ctrl, ns, cmd.opcode);
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			nvme_to_user_ptr(cmd.addr), cmd.data_len,
 			nvme_to_user_ptr(cmd.metadata), cmd.metadata_len,
 			0, &cmd.result, timeout);
-	nvme_passthru_end(ctrl, effects);
 
 	if (status >= 0) {
 		if (put_user(cmd.result, &ucmd->result))
-- 
2.20.1

