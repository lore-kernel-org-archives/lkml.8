Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE6DC35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9C821741
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582424777;
	bh=1UG6/K0ZXbloJbcRrJtGl0di2YcCGVylYoLcKEsDLJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=w4znxHkJ36IdpoaJ4vJbEIWf5fYb5Dl4pahuN/Q9nGG8XVtqXOOOIdGsXy3076cbu
	 8PWLiZSc0WwOe4jxyEgt1fc0SYX02JfJJfamGG3TsNhFnb5tHCpnWVZhOzs5TyDp0U
	 IMs+t8/Li/DXkrHX4a7zuyYtqcVt3zpTf66sw/HE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbgBWC0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:26:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:55352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729495AbgBWCYz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:24:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 479502467C;
        Sun, 23 Feb 2020 02:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424695;
        bh=1UG6/K0ZXbloJbcRrJtGl0di2YcCGVylYoLcKEsDLJc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHiiIPTsOsPZ8DcxCpibLamXnrQshZhhuHWUTtMUMK7QHpnMcLNJ3JYPxti2Yh5M/
         DGALDgM3iQQse8sFSdpWkpF9Tfm91jq4o02VijWvo1D16Rpv1EjvfumM7h6OHAZRyo
         BRR56aHOQkKSsUYesMlOV/DxQCwYpRLIg0i61PTE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arthur Kiyanovski <akiyano@amazon.com>,
        Sameeh Jubran <sameehj@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 13/16] net: ena: ena-com.c: prevent NULL pointer dereference
Date:   Sat, 22 Feb 2020 21:24:35 -0500
Message-Id: <20200223022438.2398-13-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022438.2398-1-sashal@kernel.org>
References: <20200223022438.2398-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Kiyanovski <akiyano@amazon.com>

[ Upstream commit c207979f5ae10ed70aff1bb13f39f0736973de99 ]

comp_ctx can be NULL in a very rare case when an admin command is executed
during the execution of ena_remove().

The bug scenario is as follows:

* ena_destroy_device() sets the comp_ctx to be NULL
* An admin command is executed before executing unregister_netdev(),
  this can still happen because our device can still receive callbacks
  from the netdev infrastructure such as ethtool commands.
* When attempting to access the comp_ctx, the bug occurs since it's set
  to NULL

Fix:
Added a check that comp_ctx is not NULL

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Sameeh Jubran <sameehj@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_com.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_com.c b/drivers/net/ethernet/amazon/ena/ena_com.c
index e1f694322e41a..9bd2a7a5b5a78 100644
--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -199,6 +199,11 @@ static inline void comp_ctxt_release(struct ena_com_admin_queue *queue,
 static struct ena_comp_ctx *get_comp_ctxt(struct ena_com_admin_queue *queue,
 					  u16 command_id, bool capture)
 {
+	if (unlikely(!queue->comp_ctx)) {
+		pr_err("Completion context is NULL\n");
+		return NULL;
+	}
+
 	if (unlikely(command_id >= queue->q_depth)) {
 		pr_err("command id is larger than the queue size. cmd_id: %u queue size %d\n",
 		       command_id, queue->q_depth);
-- 
2.20.1

