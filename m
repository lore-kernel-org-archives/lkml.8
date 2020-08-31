Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2573EC43461
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E85432064B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598888161;
	bh=aG8fDo6WokZr7tWPDWgK8Q8I17+Fk1k0aLx8aKCBCZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zdkmqy9bR7WbkP1qchSTYMdXbxPtPwOrRF1I6TVyI7OgAQWI9EhVp3bZ2WkMdHR18
	 Z1NSsKbnxLHwMKcMsENu3V4NTgH5i82oXNkLmH+4PeAboCNvZ1dLC+9peS69evUwYy
	 S79o12o2UJm3rFrg8c7cOZbG/SUWa3X6GV+ZEOqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgHaPf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728748AbgHaPay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:30:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CCD7F214DB;
        Mon, 31 Aug 2020 15:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598887853;
        bh=aG8fDo6WokZr7tWPDWgK8Q8I17+Fk1k0aLx8aKCBCZQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NEjHg0D9q6I5dKK4tqXwurgaa+1iX0SjBvnJfZYY+0Pd5xr5FqmShMrkPMOjsJCPT
         LtECZffBEpi9NzbihHVnSCaiMAQ4oCTV/T7GJtpaNgJGrMGX5oP7R81RBMMyhBQM42
         B77vDFfjxYmxnflwWW4/nFWCHHSC5Pwnieksqltg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Amit Engel <amit.engel@dell.com>, Sagi Grimberg <sagi@grimberg.me>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 08/23] nvmet: Disable keep-alive timer when kato is cleared to 0h
Date:   Mon, 31 Aug 2020 11:30:24 -0400
Message-Id: <20200831153039.1024302-8-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831153039.1024302-1-sashal@kernel.org>
References: <20200831153039.1024302-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Amit Engel <amit.engel@dell.com>

[ Upstream commit 0d3b6a8d213a30387b5104b2fb25376d18636f23 ]

Based on nvme spec, when keep alive timeout is set to zero
the keep-alive timer should be disabled.

Signed-off-by: Amit Engel <amit.engel@dell.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 57a4062cbb59e..7d7176369edf7 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -369,6 +369,9 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
 
 static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
 {
+	if (unlikely(ctrl->kato == 0))
+		return;
+
 	pr_debug("ctrl %d start keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
 
@@ -378,6 +381,9 @@ static void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
 
 static void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 {
+	if (unlikely(ctrl->kato == 0))
+		return;
+
 	pr_debug("ctrl %d stop keep-alive\n", ctrl->cntlid);
 
 	cancel_delayed_work_sync(&ctrl->ka_work);
-- 
2.25.1

