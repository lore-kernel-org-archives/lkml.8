Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED93FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D019720814
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgE2Lhp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:37:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:51032 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgE2Lho (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:37:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6E4A2AE54;
        Fri, 29 May 2020 11:37:43 +0000 (UTC)
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Keith Busch <kbusch@kernel.org>,
        Daniel Wagner <dwagner@suse.de>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH] nvme-fc: Only call nvme_cleanup_cmd() for normal operations
Date:   Fri, 29 May 2020 13:37:40 +0200
Message-Id: <20200529113740.31269-1-dwagner@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Asynchronous event notifications do not have an request
associated. When fcp_io() fails we unconditionally call
nvme_cleanup_cmd() which leads to a crash.

Fixes: 16686f3a6c3c ("nvme: move common call to nvme_cleanup_cmd to core layer")
Cc: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 7dfc4a2ecf1e..287a3e8ea317 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2300,10 +2300,11 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 		opstate = atomic_xchg(&op->state, FCPOP_STATE_COMPLETE);
 		__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
 
-		if (!(op->flags & FCOP_FLAGS_AEN))
+		if (!(op->flags & FCOP_FLAGS_AEN)) {
 			nvme_fc_unmap_data(ctrl, op->rq, op);
+			nvme_cleanup_cmd(op->rq);
+		}
 
-		nvme_cleanup_cmd(op->rq);
 		nvme_fc_ctrl_put(ctrl);
 
 		if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE &&
-- 
2.26.2

