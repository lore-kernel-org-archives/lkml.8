Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2103EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCB6B20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597926835;
	bh=xW1RePcyO1D+A0SCQ4SXfegUKzuv4CW2G79xpHbRwTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hPtfTXDuHVg6qZJfhun0wefmBYLrjbymGPeqZ6SJQu2XLC/Sq3mQvw8WR3BF6ArRF
	 ijEuDuDD8OPHFbl4W0K87gcn9pyKwFhNMAyLYiGJlcOor+thmrLOB1jh0PVcuj39Np
	 5akzQNRWtHsUKkf1a975MELSWuu0tc478MhPvQxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgHTJtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:49:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729583AbgHTJst (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:48:49 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CD702173E;
        Thu, 20 Aug 2020 09:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916929;
        bh=xW1RePcyO1D+A0SCQ4SXfegUKzuv4CW2G79xpHbRwTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=byWtFfeBqWnw1A+nz45ywhY+rMv4hczcUGA1j33CYK+vjUsQrB3bt5DQAUHLMzxdN
         MTUGPx94LS46JU13H5ogFTXEi3h4XSQINjdcfzncniYgBflZVcH0A8QgtLSL04PLrg
         JpDV5HG3aeMEB30o4uc231JHkOzuRCzXFbQeE5H8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Zhang <markz@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 095/152] RDMA/counter: Allow manually bind QPs with different pids to same counter
Date:   Thu, 20 Aug 2020 11:21:02 +0200
Message-Id: <20200820091558.600195140@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091553.615456912@linuxfoundation.org>
References: <20200820091553.615456912@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

[ Upstream commit cbeb7d896c0f296451ffa7b67e7706786b8364c8 ]

In manual mode allow bind user QPs with different pids to same counter,
since this is allowed in auto mode.
Bind kernel QPs and user QPs to the same counter are not allowed.

Fixes: 1bd8e0a9d0fd ("RDMA/counter: Allow manual mode configuration support")
Link: https://lore.kernel.org/r/20200702082933.424537-4-leon@kernel.org
Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 42809f612c2c4..f454d63008d69 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -487,7 +487,7 @@ int rdma_counter_bind_qpn(struct ib_device *dev, u8 port,
 		goto err;
 	}
 
-	if (counter->res.task != qp->res.task) {
+	if (rdma_is_kernel_res(&counter->res) != rdma_is_kernel_res(&qp->res)) {
 		ret = -EINVAL;
 		goto err_task;
 	}
-- 
2.25.1



