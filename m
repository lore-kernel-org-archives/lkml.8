Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EECBBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC0D6206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 17:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgENRX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 13:23:28 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46962 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726141AbgENRXQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 13:23:16 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jZHZV-00021s-U7; Thu, 14 May 2020 11:23:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1jZHZU-0001h6-QQ; Thu, 14 May 2020 11:23:00 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Date:   Thu, 14 May 2020 11:22:50 -0600
Message-Id: <20200514172253.6445-7-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200514172253.6445-1-logang@deltatee.com>
References: <20200514172253.6445-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, maxg@mellanox.com, sbates@raithlin.com, logang@deltatee.com, Chaitanya.Kulkarni@wdc.com, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v13 6/9] nvme: Export existing nvme core functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export nvme_put_ns(), nvme_command_effects(), nvme_execute_passthru_rq()
and nvme_find_get_ns() for use in the nvmet passthru code.

The exports are conditional on CONFIG_NVME_TARGET_PASSTHRU.

Based-on-a-patch-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 14 +++++++++-----
 drivers/nvme/host/nvme.h |  5 +++++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2604971362d8..c76f2e4b7c1c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -457,7 +457,7 @@ static void nvme_free_ns(struct kref *kref)
 	kfree(ns);
 }
 
-static void nvme_put_ns(struct nvme_ns *ns)
+void nvme_put_ns(struct nvme_ns *ns)
 {
 	kref_put(&ns->kref, nvme_free_ns);
 }
@@ -890,8 +890,8 @@ static void *nvme_add_user_metadata(struct bio *bio, void __user *ubuf,
 	return ERR_PTR(ret);
 }
 
-static u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-				u8 opcode)
+u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			 u8 opcode)
 {
 	u32 effects = 0;
 
@@ -976,7 +976,7 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 		nvme_queue_scan(ctrl);
 }
 
-static void nvme_execute_passthru_rq(struct request *rq)
+void nvme_execute_passthru_rq(struct request *rq)
 {
 	struct nvme_command *cmd = nvme_req(rq)->cmd;
 	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
@@ -3530,7 +3530,7 @@ static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 	return nsa->head->ns_id - nsb->head->ns_id;
 }
 
-static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns, *ret = NULL;
 
@@ -4311,6 +4311,10 @@ EXPORT_SYMBOL_GPL(nvme_sync_queues);
  * use by the nvmet-passthru and should not be used for
  * other things.
  */
+EXPORT_SYMBOL_GPL(nvme_put_ns);
+EXPORT_SYMBOL_GPL(nvme_command_effects);
+EXPORT_SYMBOL_GPL(nvme_execute_passthru_rq);
+EXPORT_SYMBOL_GPL(nvme_find_get_ns);
 
 struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9195dd97b61b..76b4aa8f35e1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -695,6 +695,11 @@ static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
  * use by the nvmet-passthru and should not be used for
  * other things.
  */
+void nvme_put_ns(struct nvme_ns *ns);
+u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			 u8 opcode);
+void nvme_execute_passthru_rq(struct request *rq);
+struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned int nsid);
 struct nvme_ctrl *nvme_ctrl_get_by_path(const char *path);
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 
-- 
2.20.1

