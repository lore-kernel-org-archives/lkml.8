Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDA1C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8A024673
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583204579;
	bh=dZ6Es09tqYlqTLzTZe2PRZ3vS+0hQayTcGbsSTWc8FE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uJCfAYDA+oc6HKH3x7djb7VJH5s32NCebC6rRcmzIesDhEYtJZe6RspMwCs83bKBY
	 bGrHbtQCgZvomdXMEVIWix21SuGi5gzS6n6a2hvq91qfP0wFDYHQALdOD8bmeb2TbK
	 wE/dA5WC/pgwBBN86ZVbFs6RxwKQTPrHa9q/M6CA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727532AbgCCCqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 21:46:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:40858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbgCCCq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 21:46:29 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 292BC24681;
        Tue,  3 Mar 2020 02:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203588;
        bh=dZ6Es09tqYlqTLzTZe2PRZ3vS+0hQayTcGbsSTWc8FE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eu5Qo2r/JiR3eUjQDnI3GjDJcnEN0PnSVNRRSPj6MjXSKDuhes4oczMZDfFoAWKiA
         e8pmezOfWbkwxHYkrGm+ufiuAuDoM9LqhImR+05lEytJXeWH1TbrS9mn0WsPa0SoEi
         gj/9Th/9BQuHn34Hiy2wNpxYn5XCSslB5mDJYTTw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Oded Gabbay <oded.gabbay@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 11/66] habanalabs: patched cb equals user cb in device memset
Date:   Mon,  2 Mar 2020 21:45:20 -0500
Message-Id: <20200303024615.8889-11-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024615.8889-1-sashal@kernel.org>
References: <20200303024615.8889-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oded Gabbay <oded.gabbay@gmail.com>

[ Upstream commit cf01514c5c6efa2d521d35e68dff2e0674d08e91 ]

During device memory memset, the driver allocates and use a CB (command
buffer). To reuse existing code, it keeps a pointer to the CB in two
variables, user_cb and patched_cb. Therefore, there is no need to "put"
both the user_cb and patched_cb, as it will cause an underflow of the
refcnt of the CB.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/habanalabs/goya/goya.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index f24fe909b88d8..b8a8de24aaf72 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4690,8 +4690,6 @@ static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size,
 
 	rc = goya_send_job_on_qman0(hdev, job);
 
-	hl_cb_put(job->patched_cb);
-
 	hl_debugfs_remove_job(hdev, job);
 	kfree(job);
 	cb->cs_cnt--;
-- 
2.20.1

