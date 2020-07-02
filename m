Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC10C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E9D220874
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 01:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593653246;
	bh=ygP+kvB9/t08RSdTKMcD2QE5Gt3TvzBA4D0jbatvNt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gV1oEo9Fm3RpTmrIf+jzLVcHa9D7S8fe289THzq4wbPXPY2uhSAkwPXpZjnSGChRl
	 fpyig6suc9tL+ap3aMFk0wkSBTnhWnmxEzOWva9DROE1z6FgemCWvZx3y6YlRGpEmk
	 oo1vZQt6TRyhGlybDzkfJVAR1pONQaeI1WOts1t4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729469AbgGBB1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 21:27:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729277AbgGBB0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 21:26:46 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D63ED206BE;
        Thu,  2 Jul 2020 01:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593653206;
        bh=ygP+kvB9/t08RSdTKMcD2QE5Gt3TvzBA4D0jbatvNt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=duRQGEk7hX+rrOIRRptJJPBIFJeKhN0HKHEzKfTrQ5VXmFOukhl2hoTTapFTxt+Yw
         z4pWYniLgWzxPG/NvGbYFjQx59+FOhwiIMhQrufr1Vizq4QWs5GpzpaQPn2EPnlvZc
         t43pg0OLVTp8ropZLuby9lBMbcmEcyco+S54Qa1k=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 25/27] nvme-rdma: assign completion vector correctly
Date:   Wed,  1 Jul 2020 21:26:13 -0400
Message-Id: <20200702012615.2701532-25-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200702012615.2701532-1-sashal@kernel.org>
References: <20200702012615.2701532-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Gurtovoy <maxg@mellanox.com>

[ Upstream commit 032a9966a22a3596addf81dacf0c1736dfedc32a ]

The completion vector index that is given during CQ creation can't
exceed the number of support vectors by the underlying RDMA device. This
violation currently can accure, for example, in case one will try to
connect with N regular read/write queues and M poll queues and the sum
of N + M > num_supported_vectors. This will lead to failure in establish
a connection to remote target. Instead, in that case, share a completion
vector between queues.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9711bfbdf4316..f393a6193252e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -447,7 +447,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	 * Spread I/O queues completion vectors according their queue index.
 	 * Admin queues can always go on completion vector 0.
 	 */
-	comp_vector = idx == 0 ? idx : idx - 1;
+	comp_vector = (idx == 0 ? idx : idx - 1) % ibdev->num_comp_vectors;
 
 	/* +1 for ib_stop_cq */
 	queue->ib_cq = ib_alloc_cq(ibdev, queue,
-- 
2.25.1

