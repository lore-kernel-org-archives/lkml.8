Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE4FC3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E4DA22245
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 14:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587220971;
	bh=j6iGxe6hgIhvhNhibRWCBc45s0hch/cUkLVkSENAXGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T/AKGrd9Qhux1OvlX1u6znW4YThhFaMs8DtqDGY+Ci/AZuIrzrW5r89OQ3UolQT5Q
	 of+fO7XclHtWetnL8eCJF2brkiD73/Fbs1u6BuNL2Sib1ubvh7QpFJcsb66rOy4Wg3
	 MighHfLLRtizA+lD3CaOKY6nN92HkczgHO71XYNs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgDROmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 10:42:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728405AbgDROmn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 10:42:43 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9EAB52224F;
        Sat, 18 Apr 2020 14:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587220963;
        bh=j6iGxe6hgIhvhNhibRWCBc45s0hch/cUkLVkSENAXGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLn+XIU56ubevZudsbJhJkAxrGhPSxHTMFWzMPkRq5B2Yn3g4oiRlUiR5kptDi9Gy
         /8+h/LS8Hjn16xxqM4zCYxjMT8zTxkZ28nIzZzerbxLgczAp30qxYh8FqdeV5KUW1S
         DnGQRFrs4cM4yv4alOloZnbpIvU68BkoOckkgsdE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 13/47] nvme: fix deadlock caused by ANA update wrong locking
Date:   Sat, 18 Apr 2020 10:41:53 -0400
Message-Id: <20200418144227.9802-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200418144227.9802-1-sashal@kernel.org>
References: <20200418144227.9802-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 657f1975e9d9c880fa13030e88ba6cc84964f1db ]

The deadlock combines 4 flows in parallel:
- ns scanning (triggered from reconnect)
- request timeout
- ANA update (triggered from reconnect)
- I/O coming into the mpath device

(1) ns scanning triggers disk revalidation -> update disk info ->
    freeze queue -> but blocked, due to (2)

(2) timeout handler reference the g_usage_counter - > but blocks in
    the transport .timeout() handler, due to (3)

(3) the transport timeout handler (indirectly) calls nvme_stop_queue() ->
    which takes the (down_read) namespaces_rwsem - > but blocks, due to (4)

(4) ANA update takes the (down_write) namespaces_rwsem -> calls
    nvme_mpath_set_live() -> which synchronize the ns_head srcu
    (see commit 504db087aacc) -> but blocks, due to (5)

(5) I/O came into nvme_mpath_make_request -> took srcu_read_lock ->
    direct_make_request > blk_queue_enter -> but blocked, due to (1)

==> the request queue is under freeze -> deadlock.

The fix is making ANA update take a read lock as the namespaces list
is not manipulated, it is just the ns and ns->head that are being
updated (which is protected with the ns->head lock).

Fixes: 0d0b660f214dc ("nvme: add ANA support")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e8bc25aed44ca..588864beabd80 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -402,7 +402,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	if (!nr_nsids)
 		return 0;
 
-	down_write(&ctrl->namespaces_rwsem);
+	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		unsigned nsid = le32_to_cpu(desc->nsids[n]);
 
@@ -413,7 +413,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 		if (++n == nr_nsids)
 			break;
 	}
-	up_write(&ctrl->namespaces_rwsem);
+	up_read(&ctrl->namespaces_rwsem);
 	return 0;
 }
 
-- 
2.20.1

