Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E084C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E03642075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916463;
	bh=ATlZv6UUf8gC4J7JiJhspjarlU5BxTsDmslsrQf6BAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AIde2ZJFjL4BG4/wRFCW0X1p2YeQrAFLPxSW+chMdIkMqOlfx3GuifJLpaAt8cWDY
	 qRXxTr6aIytA/26VxFwaoOXpriIcnnDWdZk28vKQadzfzEbAKWfK+xKThZGUvFH36E
	 7iHGMCmejeJzdRjGbqoSIDKZTDrhBbvgu/QsCDlU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbgHTJlA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:41:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:33336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728802AbgHTJkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:40:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53C662075E;
        Thu, 20 Aug 2020 09:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916445;
        bh=ATlZv6UUf8gC4J7JiJhspjarlU5BxTsDmslsrQf6BAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EvdcXM+ryr4MM1zea5XyPM6UCmMPyvNxTX400zC70CgyuSy+YPVERe0il2A3tCK4O
         7pek2eCAPzL8dSZno3pMm1m88GaOsUwhFNJ2tN7nwPyXM+CcLTmGinPTLpdvxs9sxw
         WlWqwpP+rM+EOadHKxq/iRXDnTQRR+kJnkyrKGnk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Zhang <markz@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 123/204] RDMA/counter: Allow manually bind QPs with different pids to same counter
Date:   Thu, 20 Aug 2020 11:20:20 +0200
Message-Id: <20200820091612.439376799@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091606.194320503@linuxfoundation.org>
References: <20200820091606.194320503@linuxfoundation.org>
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
index 6deb1901fbd02..417ebf4d8ba9b 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -483,7 +483,7 @@ int rdma_counter_bind_qpn(struct ib_device *dev, u8 port,
 		goto err;
 	}
 
-	if (counter->res.task != qp->res.task) {
+	if (rdma_is_kernel_res(&counter->res) != rdma_is_kernel_res(&qp->res)) {
 		ret = -EINVAL;
 		goto err_task;
 	}
-- 
2.25.1



