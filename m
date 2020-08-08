Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7EF8C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93BC02053B
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 23:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596930217;
	bh=lbL7P2kqhPvQnOmd05EN1QjyhRu02oRHZ6JHPQepo6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=b7tUon8BbMR/ktI7EBKsGo8rzojASotC47zUxkW1x2Z1tXjpFTePKpHbIUljSzIss
	 eOvNMgiFdc+cx4FgojY7KgjNeDoKWJ02wBKZxgLxooV+KiHKTnS+RzTnyQPl7IAeDT
	 WDnnv0FBGuneVoXjb/1eeGyTJ1JhR5M5g6FdQmPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbgHHXng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 19:43:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:54594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728613AbgHHXjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 19:39:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF5F420748;
        Sat,  8 Aug 2020 23:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596929980;
        bh=lbL7P2kqhPvQnOmd05EN1QjyhRu02oRHZ6JHPQepo6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HqvPqYUUbFCnnF5ZwEM+eTloJDHGwPvbfoBrZqGPDCfabTMgI6hZTKRJSc98qg97J
         oliYzVlbTosTRu+l7iYL+7kzvsGCZKb0KXe70GkgOLkhVOcC08NGw4Vo0lbyqEHg/D
         u0RuKocszO9HpyBlj/MKuEiZ/FrSwlskCAWjjD3c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hannes Reinecke <hare@suse.de>, Martin Wilck <mwilck@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 40/40] nvme-multipath: do not fall back to __nvme_find_path() for non-optimized paths
Date:   Sat,  8 Aug 2020 19:38:44 -0400
Message-Id: <20200808233844.3618823-40-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200808233844.3618823-1-sashal@kernel.org>
References: <20200808233844.3618823-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hannes Reinecke <hare@suse.de>

[ Upstream commit fbd6a42d8932e172921c7de10468a2e12c34846b ]

When nvme_round_robin_path() finds a valid namespace we should be using it;
falling back to __nvme_find_path() for non-optimized paths will cause the
result from nvme_round_robin_path() to be ignored for non-optimized paths.

Fixes: 75c10e732724 ("nvme-multipath: round-robin I/O policy")
Signed-off-by: Martin Wilck <mwilck@suse.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 38d25d7c6bca3..484aad0d0c9c6 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -275,10 +275,13 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	ns = srcu_dereference(head->current_path[node], &head->srcu);
-	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR && ns)
-		ns = nvme_round_robin_path(head, node, ns);
-	if (unlikely(!ns || !nvme_path_is_optimized(ns)))
-		ns = __nvme_find_path(head, node);
+	if (unlikely(!ns))
+		return __nvme_find_path(head, node);
+
+	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
+		return nvme_round_robin_path(head, node, ns);
+	if (unlikely(!nvme_path_is_optimized(ns)))
+		return __nvme_find_path(head, node);
 	return ns;
 }
 
-- 
2.25.1

