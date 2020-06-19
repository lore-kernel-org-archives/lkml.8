Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94157C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B89F217D8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592580386;
	bh=jBjbkxP1iiBAvE6/2yxT7Dz+8SrZGpJOC8QuAynfkJg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=2lETDVDyYZU4vkH0HZfGcetAcaUOqGbitZ2hDdN7NM2AMht6ByuNSkdUhW8wNrxy0
	 YuqQfbp49/Jrh7Z1AKBibEF72/y0ij/sBHR1qYBmEmrjLtnx/7Si+TR6i5F8M3u1eE
	 3VikDR9mQ5av6TUDLOnqQilPzVyL0kMWITV4YpdM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404302AbgFSP0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:55542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390801AbgFSPXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:23:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B99A721919;
        Fri, 19 Jun 2020 15:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592580234;
        bh=jBjbkxP1iiBAvE6/2yxT7Dz+8SrZGpJOC8QuAynfkJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ryya5rzDnnglAuPEu0EslLZ2hRHm39FrRNi7OKa1bdF73RjsgpirkUE6qqFrCRCdK
         aTjTdu0nRwu2FQRb0ltpfkCHotwGwUwmpiToJ+0JpsOWCGnznI2E4VDSnpUBydncpk
         31dG09YoQgH6N3PYiTtIrgv2iPZhIhbgIjjsYQAQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 172/376] nvme-tcp: use bh_lock in data_ready
Date:   Fri, 19 Jun 2020 16:31:30 +0200
Message-Id: <20200619141718.466795494@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141710.350494719@linuxfoundation.org>
References: <20200619141710.350494719@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sagi Grimberg <sagi@grimberg.me>

[ Upstream commit 386e5e6e1aa90b479fcf0467935922df8524393d ]

data_ready may be invoked from send context or from
softirq, so need bh locking for that.

Fixes: 3f2304f8c6d6 ("nvme-tcp: add NVMe over TCP host driver")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/tcp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c15a92163c1f..4862fa962011 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -794,11 +794,11 @@ static void nvme_tcp_data_ready(struct sock *sk)
 {
 	struct nvme_tcp_queue *queue;
 
-	read_lock(&sk->sk_callback_lock);
+	read_lock_bh(&sk->sk_callback_lock);
 	queue = sk->sk_user_data;
 	if (likely(queue && queue->rd_enabled))
 		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
-	read_unlock(&sk->sk_callback_lock);
+	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static void nvme_tcp_write_space(struct sock *sk)
-- 
2.25.1



