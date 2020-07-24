Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4F0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E4B206D8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 17:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="LI+oW/UF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgGXRZ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 13:25:26 -0400
Received: from ale.deltatee.com ([204.191.154.188]:58562 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgGXRZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 13:25:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=hSGWBwm/NutG4cL4B08mF9B/cFvn+Vs21yYP8xZpoEs=; b=LI+oW/UFlHU7aXgaiv0gCIFDIK
        rYI/2fAEmQiHAir/UaXD+MfnfYEQDfjTioR/QQNgOVsW19B/KxXV7OTavs3F+7p01np8Mc9JWWd0y
        2rjPu0njXV7Fad9BzApZDKySTFiXNqzPOlRKW8I+a+pY6Yyxi3G1xoF1Mo2heCxL0Qym8QpObIjFb
        MZ9MhKgE+RGexqTnPZCQ63/h+TMeuQtf4DYY1Zq/bRZN18Ybt+sFuDy18Q6se8gC06fT2brS77Itt
        aPKVfVBEDvHjoXGP9FZIx9AMJ65OleXx8b2EqfjDVWUSeHymFCHY+kmtTDjboR/fIWJ+BvkBtQEnf
        Nm0fEbjg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jz1Rk-0006yp-5m; Fri, 24 Jul 2020 11:25:25 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jz1Ri-0004GC-79; Fri, 24 Jul 2020 11:25:22 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Fri, 24 Jul 2020 11:25:14 -0600
Message-Id: <20200724172520.16318-4-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200724172520.16318-1-logang@deltatee.com>
References: <20200724172520.16318-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, Chaitanya.Kulkarni@wdc.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v16 3/9] nvme: Introduce nvme_execute_passthru_rq to call nvme_passthru_[start|end]()
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
code and is exported in the NVME_TARGET_PASSTHRU namespace.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/host/core.c | 22 +++++++++++++++-------
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bd07b4edd6fc..ccca36f881d6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1017,6 +1017,20 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 	}
 }
 
+void nvme_execute_passthru_rq(struct request *rq)
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
+EXPORT_SYMBOL_NS_GPL(nvme_execute_passthru_rq, NVME_TARGET_PASSTHRU);
+
 static int nvme_submit_user_cmd(struct request_queue *q,
 		struct nvme_command *cmd, void __user *ubuffer,
 		unsigned bufflen, void __user *meta_buffer, unsigned meta_len,
@@ -1055,7 +1069,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		}
 	}
 
-	blk_execute_rq(req->q, disk, req, 0);
+	nvme_execute_passthru_rq(req);
 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
 		ret = -EINTR;
 	else
@@ -1489,7 +1503,6 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct nvme_passthru_cmd cmd;
 	struct nvme_command c;
 	unsigned timeout = 0;
-	u32 effects;
 	u64 result;
 	int status;
 
@@ -1516,12 +1529,10 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
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
@@ -1537,7 +1548,6 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct nvme_passthru_cmd64 cmd;
 	struct nvme_command c;
 	unsigned timeout = 0;
-	u32 effects;
 	int status;
 
 	if (!capable(CAP_SYS_ADMIN))
@@ -1563,12 +1573,10 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
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
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d4dbf7280500..c43e0e4e0b97 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -786,5 +786,6 @@ static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
 
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
+void nvme_execute_passthru_rq(struct request *rq);
 
 #endif /* _NVME_H */
-- 
2.20.1

