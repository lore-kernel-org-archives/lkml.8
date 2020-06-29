Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E24C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 306752076C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593468357;
	bh=whibX4Vflp6erw83MqLTzhDyklQNqGev6/SpT2TzU44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uQ8rvnap/x40JjK9eABg0UoJ58XqA+yt78bKaauEQ3sb9KVfERk9yjt8AMcyuwvDv
	 0+k9dhLRPz6tt5DO3vbDAT1B5dLDa8q/LVtI44F4/1MZ4B8R0Wlb/QmA4bLCAYqv2O
	 iOD9y7cZv7Fsk5spub+UvtEkWbzO5vkeJ8rgQUQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733015AbgF2WFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:05:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:56792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgF2SfT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:19 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 164FE24183;
        Mon, 29 Jun 2020 15:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593443951;
        bh=whibX4Vflp6erw83MqLTzhDyklQNqGev6/SpT2TzU44=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ScN9nS2gpbRLfAEB3eeRDGZ/Xr8rkuzmDVRphy37gB7K+QShYrjDDaOXpm+c/HiZw
         d9ikYFS1Qx7VEfvLxgp6+W877F6I7oCroqrcwJDZ3A0M2cEuRh7XfrBMmRYl/dXKBv
         Lx3Gu4OSDaoimUwLY/FexuMkwmni07t7NA0+UD5U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Milburn <dmilburn@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Yi Zhang <yi.zhang@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 053/265] nvmet: cleanups the loop in nvmet_async_events_process
Date:   Mon, 29 Jun 2020 11:14:46 -0400
Message-Id: <20200629151818.2493727-54-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Milburn <dmilburn@redhat.com>

[ Upstream commit 1cdf9f7670a7d74e27177d5c390c2f8b3b9ba338 ]

Based-on-a-patch-by: Christoph Hellwig <hch@infradead.org>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: David Milburn <dmilburn@redhat.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/core.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index aa5ca222c6f59..ac7ae031ce78d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -134,15 +134,10 @@ static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
 	struct nvmet_async_event *aen;
 	struct nvmet_req *req;
 
-	while (1) {
-		mutex_lock(&ctrl->lock);
-		aen = list_first_entry_or_null(&ctrl->async_events,
-				struct nvmet_async_event, entry);
-		if (!aen || !ctrl->nr_async_event_cmds) {
-			mutex_unlock(&ctrl->lock);
-			break;
-		}
-
+	mutex_lock(&ctrl->lock);
+	while (ctrl->nr_async_event_cmds && !list_empty(&ctrl->async_events)) {
+		aen = list_first_entry(&ctrl->async_events,
+				       struct nvmet_async_event, entry);
 		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
 		if (status == 0)
 			nvmet_set_result(req, nvmet_async_event_result(aen));
@@ -152,7 +147,9 @@ static void nvmet_async_events_process(struct nvmet_ctrl *ctrl, u16 status)
 
 		mutex_unlock(&ctrl->lock);
 		nvmet_req_complete(req, status);
+		mutex_lock(&ctrl->lock);
 	}
+	mutex_unlock(&ctrl->lock);
 }
 
 static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)
-- 
2.25.1

