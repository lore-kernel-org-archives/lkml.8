Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A28C2BBFD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28BA20757
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646752;
	bh=7e+lmk/j9ahmLbPN8IdAVtxZF4+xs2Crkur5y87gkOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2II39gwRKfRquHHSCjt/hHR6G5Dz4cHnPdI4StGnG9qoAmM862oFJZ73ZLMZvGuvp
	 2BIHt4au84XYy7C20oh7TnavPkwsYGR9zTOOJ2MJjW7jibfxxuxgTTqVJXN/syCtL2
	 5uXp1qF79F8xzu2klqL19i5bH53Z6MFy+ASUct9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729921AbgDKXM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:12:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:52194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729220AbgDKXMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:12:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFCFD215A4;
        Sat, 11 Apr 2020 23:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646733;
        bh=7e+lmk/j9ahmLbPN8IdAVtxZF4+xs2Crkur5y87gkOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qKsISCHWfagA9sJaufaGQMWxXUH7Sejj+l4j5HOc3lZRWIAPh/4zBJVgWTLFVYOP0
         ja3Le+LyqWqM1yJkA2y/zahmmC3s6tkuJrfbVSYs0VqVWZGnpxLYrSXvtWmrx8NMDH
         dncSjkfE2ATzYMUOQhB3HdXqgpaVHWD7Y4BcHAkk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 08/66] RDMA/cm: Add missing locking around id.state in cm_dup_req_handler
Date:   Sat, 11 Apr 2020 19:11:05 -0400
Message-Id: <20200411231203.25933-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411231203.25933-1-sashal@kernel.org>
References: <20200411231203.25933-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

[ Upstream commit d1de9a88074b66482443f0cd91618d7b51a7c9b6 ]

All accesses to id.state must be done under the spinlock.

Fixes: a977049dacde ("[PATCH] IB: Add the kernel CM implementation")
Link: https://lore.kernel.org/r/20200310092545.251365-10-leon@kernel.org
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/cm.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 64f206e11d497..7251068b6af0f 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1812,8 +1812,12 @@ static void cm_dup_req_handler(struct cm_work *work,
 			counter[CM_REQ_COUNTER]);
 
 	/* Quick state check to discard duplicate REQs. */
-	if (cm_id_priv->id.state == IB_CM_REQ_RCVD)
+	spin_lock_irq(&cm_id_priv->lock);
+	if (cm_id_priv->id.state == IB_CM_REQ_RCVD) {
+		spin_unlock_irq(&cm_id_priv->lock);
 		return;
+	}
+	spin_unlock_irq(&cm_id_priv->lock);
 
 	ret = cm_alloc_response_msg(work->port, work->mad_recv_wc, &msg);
 	if (ret)
-- 
2.20.1

