Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9B9C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A99C20773
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 15:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595259853;
	bh=7KAztGtg5zIFVJoJpv7CQCGrmy5Zf3wf58AWBtyQj04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=oZ5tv9vbPZU1/Hr6+xkXdEmfwhI7Zk+VV3Keo6C4gsn/FiYUDHBQ1YiRoMzcb5LsL
	 BDRfaZqY0SiVEX29W9hlEp9jpezbpfrUnDgBG5RcWc3lFRwA/7UcEkUHe8Th/Wt9Ei
	 BGoICo18/+d+qEwkDoVpkIH36ys0GUE1KRa1cPAE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgGTPoL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:44:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730358AbgGTPoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:44:07 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F183B20773;
        Mon, 20 Jul 2020 15:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595259847;
        bh=7KAztGtg5zIFVJoJpv7CQCGrmy5Zf3wf58AWBtyQj04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ILHeLCucyJyDoSDVezUNk+V6XBepqrP3/hRO1aieqDVrX/3YrYMxTCDLkFkotBiUG
         WV9d5f0fMGa+vy2jJksCgHnx95U02+jnfryrtelSaM7byHd0MahKeKhzLS3M9PmDD2
         Gul4IsucP+7XEvkfaNAsU0t/FkIr09ZMb7jSyZNQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 015/125] nvme-rdma: assign completion vector correctly
Date:   Mon, 20 Jul 2020 17:35:54 +0200
Message-Id: <20200720152803.718190477@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152802.929969555@linuxfoundation.org>
References: <20200720152802.929969555@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 9fffe41ead500..c91bfd839cabe 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -470,7 +470,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	 * Spread I/O queues completion vectors according their queue index.
 	 * Admin queues can always go on completion vector 0.
 	 */
-	comp_vector = idx == 0 ? idx : idx - 1;
+	comp_vector = (idx == 0 ? idx : idx - 1) % ibdev->num_comp_vectors;
 
 	/* +1 for ib_stop_cq */
 	queue->ib_cq = ib_alloc_cq(ibdev, queue,
-- 
2.25.1



