Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A3EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E84E214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592322262;
	bh=u5N459dcvBlfL8RvNPYveLVl7hbu5p0YY7+pQOJb8UA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MZ3GZLMlvPbrjUQV5SFKC5CD1uOUL3wBiI9tuWyFyQfdjgu2e6b/TrHjkvptGgqZW
	 phGcGfzGwsq4GLQqy0RVhE8FPKbTP+T4ZXDIiKAbbUuSQce97uZzHTANe+ZTcU2FHt
	 V7u/iEPfx12s5AD3iMD1ZOulKwrBBT3Oe+65wfIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbgFPPoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:34194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731339AbgFPPoM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:44:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 611F8208E4;
        Tue, 16 Jun 2020 15:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322251;
        bh=u5N459dcvBlfL8RvNPYveLVl7hbu5p0YY7+pQOJb8UA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UC2p7BVeR45vWeRFhRalMVhQtXjauEIcoE5HivUXxgK0AYUr5Cba38yvSH5F+6n2a
         wr/pIFanOCwb4GtmgY6R1KBHanRVD+y9gDVUeuMIedA3Whp+woQz7yM+GtjVK21vuN
         gs/uQUTgwG1o0/9H5tjcW04QwmVviNOyOotbCbVY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 029/163] RDMA/uverbs: Make the event_queue fds return POLLERR when disassociated
Date:   Tue, 16 Jun 2020 17:33:23 +0200
Message-Id: <20200616153108.278078972@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.849127260@linuxfoundation.org>
References: <20200616153106.849127260@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

[ Upstream commit eb356e6dc15a30af604f052cd0e170450193c254 ]

If is_closed is set, and the event list is empty, then read() will return
-EIO without blocking. After setting is_closed in
ib_uverbs_free_event_queue(), we do trigger a wake_up on the poll_wait,
but the fops->poll() function does not check it, so poll will continue to
sleep on an empty list.

Fixes: 14e23bd6d221 ("RDMA/core: Fix locking in ib_uverbs_event_read")
Link: https://lore.kernel.org/r/0-v1-ace813388969+48859-uverbs_poll_fix%25jgg@mellanox.com
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/uverbs_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_main.c b/drivers/infiniband/core/uverbs_main.c
index 1bab8de14757..b94572e9c24f 100644
--- a/drivers/infiniband/core/uverbs_main.c
+++ b/drivers/infiniband/core/uverbs_main.c
@@ -296,6 +296,8 @@ static __poll_t ib_uverbs_event_poll(struct ib_uverbs_event_queue *ev_queue,
 	spin_lock_irq(&ev_queue->lock);
 	if (!list_empty(&ev_queue->event_list))
 		pollflags = EPOLLIN | EPOLLRDNORM;
+	else if (ev_queue->is_closed)
+		pollflags = EPOLLERR;
 	spin_unlock_irq(&ev_queue->lock);
 
 	return pollflags;
-- 
2.25.1



