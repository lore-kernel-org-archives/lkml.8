Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 247A8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A35204EC
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597690253;
	bh=Zhr72qCloKmSKihEzvvhRpi+WqP9C5JQJiJVztuEjV4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Y/4iS5kAOheUUA4rgg097E5xTPe6+Ant/jlik1vXlhOGiOsG4wMdg3pMmAWSoTmyE
	 uIjAbHHEOgYYmrmJSIB9Y6ED2TbBmvB+PwTqa0wwqknB9BHkuqmp6yWHZoR32amxZP
	 Rz3gH96zr8WakfSkwtQYCpv8mxQ2xNsucUXaHQNU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391583AbgHQSuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:50:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387919AbgHQPx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:53:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AAEF0208C7;
        Mon, 17 Aug 2020 15:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679598;
        bh=Zhr72qCloKmSKihEzvvhRpi+WqP9C5JQJiJVztuEjV4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fy5jzI2wnAObdrvxd85YxMukHxI18WnB10Za6mU28thnJDRuKwMhJxCyCso/O4NsT
         NCo69M1IBALO20jJv3ViCxOgZJW+ap7errIeZPxivImJDWs0LefdhiJN7utmqElvbX
         PoTb7Q5lonzcLGBcybeKeuBnCh7GE7RZU6W7rqtU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Zhang <markz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 270/393] RDMA/netlink: Remove CAP_NET_RAW check when dump a raw QP
Date:   Mon, 17 Aug 2020 17:15:20 +0200
Message-Id: <20200817143832.717274797@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Zhang <markz@mellanox.com>

[ Upstream commit 1d70ad0f85435a7262de802b104e49e6598c50ff ]

When dumping QPs bound to a counter, raw QPs should be allowed to dump
without the CAP_NET_RAW privilege. This is consistent with what "rdma res
show qp" does.

Fixes: c4ffee7c9bdb ("RDMA/netlink: Implement counter dumpit calback")
Link: https://lore.kernel.org/r/20200727095828.496195-1-leon@kernel.org
Signed-off-by: Mark Zhang <markz@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/nldev.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index e16105be2eb23..98cd6403ca602 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -738,9 +738,6 @@ static int fill_stat_counter_qps(struct sk_buff *msg,
 	xa_lock(&rt->xa);
 	xa_for_each(&rt->xa, id, res) {
 		qp = container_of(res, struct ib_qp, res);
-		if (qp->qp_type == IB_QPT_RAW_PACKET && !capable(CAP_NET_RAW))
-			continue;
-
 		if (!qp->counter || (qp->counter->id != counter->id))
 			continue;
 
-- 
2.25.1



