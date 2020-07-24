Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7121DC433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DEA62070B
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="eaAbosg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgGXRZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:25:34 -0400
Received: from ale.deltatee.com ([204.191.154.188]:58588 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgGXRZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JLjv2Vih/TZbLrwLSO1P4T0929e7FypKzTz3xvkWH/M=; b=eaAbosg+mL443thjIFhgxa3lLn
        QjlsIkpSMwtpyVfadrHYaprydcBsGTomkOnXMcSNOivDtT1Uv7nDKpZhmpD1+hMmIcsuZghbsnUR9
        S7kC8A4DJseUojZUbIUsNkFSukUvkSCFF+h1ydNIW349FwymX+1w0XCEOcmeDLG0NXUqFImwX9uc4
        QcEQyxUhOfneiRuoB7RP9l7Mxm6x/VqmmR88tDNYy2xPkPFpUtN4mFTXySU23ojFLuum748CjnoJE
        P9IZ8sb9d5Rfz6zdNMN+3dQAMleA9n2/yLk1yBv3Cgl/Scjj4V80igdyqlNrWqmuVpjT9tX/BsrRQ
        V6g02VJQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jz1Rk-0006yo-5m; Fri, 24 Jul 2020 11:25:29 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jz1Ri-0004G9-4B; Fri, 24 Jul 2020 11:25:22 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 24 Jul 2020 11:25:13 -0600
Message-Id: <20200724172520.16318-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724172520.16318-1-logang@deltatee.com>
References: <20200724172520.16318-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v16 2/9] nvme: Create helper function to obtain command effects
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate the code to obtain command effects from the code
to start a passthru request and move the nvme_passthru_start() and
nvme_passthru_end() functions up above nvme_submit_user_cmd() in order
that they may be used in a new helper a subsequent patch.

The new helper function will be necessary for nvmet passthru
code to determine if we need to change out of interrupt context
to handle the effects. It is exported in the NVME_TARGET_PASSTHRU
namespace.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c | 192 ++++++++++++++++++++-------------------
 drivers/nvme/host/nvme.h |   3 +
 2 files changed, 103 insertions(+), 92 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6f80bd78eba6..bd07b4edd6fc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -917,6 +917,106 @@ static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 	return ERR_PTR(ret);
 }
 
+static u32 nvme_known_admin_effects(u8 opcode)
+{
+	switch (opcode) {
+	case nvme_admin_format_nvm:
+		return NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
+			NVME_CMD_EFFECTS_CSE_MASK;
+	case nvme_admin_sanitize_nvm:
+		return NVME_CMD_EFFECTS_CSE_MASK;
+	default:
+		break;
+	}
+	return 0;
+}
+
+u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
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
+	effects |= nvme_known_admin_effects(opcode);
+
+	return effects;
+}
+EXPORT_SYMBOL_NS_GPL(nvme_command_effects, NVME_TARGET_PASSTHRU);
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
 static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, void __user *ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
@@ -1383,98 +1483,6 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 			metadata, meta_len, lower_32_bits(io.slba), NULL, 0);
 }
 
-static u32 nvme_known_admin_effects(u8 opcode)
-{
-	switch (opcode) {
-	case nvme_admin_format_nvm:
-		return NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
-					NVME_CMD_EFFECTS_CSE_MASK;
-	case nvme_admin_sanitize_nvm:
-		return NVME_CMD_EFFECTS_CSE_MASK;
-	default:
-		break;
-	}
-	return 0;
-}
-
-static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-								u8 opcode)
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
-	effects |= nvme_known_admin_effects(opcode);
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
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 92629758b77c..d4dbf7280500 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -784,4 +784,7 @@ void nvme_hwmon_init(struct nvme_ctrl *ctrl);
 static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
 #endif
 
+u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			 u8 opcode);
+
 #endif /* _NVME_H */
-- 
2.20.1

