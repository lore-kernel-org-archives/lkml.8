Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31158C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E0C22AB0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 18:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594752401;
	bh=ygP+kvB9/t08RSdTKMcD2QE5Gt3TvzBA4D0jbatvNt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EuSqDfCQIuyvYFjF9XF8H2OHCJdwHHvyNrC1QSr0OgW6brK4NNfVf42f0vijHlg3o
	 RufVdvURHhekQuD48tOATr03zK9mlFdyrQRw/JNZCkCjs8+JA2fHKwXkhdflZuZ2RK
	 LbpaP75GvntIcCAfMigtIg+aDm4wcQbwppYbSLh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729527AbgGNSqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 14:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729491AbgGNSqa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:46:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 426DC22B2E;
        Tue, 14 Jul 2020 18:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752389;
        bh=ygP+kvB9/t08RSdTKMcD2QE5Gt3TvzBA4D0jbatvNt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bZ/ta7es3635OZiSw7lJ4v5ing+YzqDhBmYnrbdP8o/XRBSb3MVUsGYTL/7aKbawv
         NYLcA3vu62Fdd7gFGyn70zum1x2prwJvIGs7D4S4L4snmNWJ+m77/VM1O+aLhtGolt
         MRaJ0LL/AlpIb27uAvxkOVPPw+eZzC6FwbINTMX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 23/58] nvme-rdma: assign completion vector correctly
Date:   Tue, 14 Jul 2020 20:43:56 +0200
Message-Id: <20200714184057.296932001@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184056.149119318@linuxfoundation.org>
References: <20200714184056.149119318@linuxfoundation.org>
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



