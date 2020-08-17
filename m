Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A35C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24DCF20758
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597688017;
	bh=czLzkuigSE0yWbb7CWeu1dApXw6x2Ys57xFZ91ZAJVU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KT7/afj64CRCovWw1A1+ERT0hsJvATV0DKmlVBzdj9hzrn6lQfIhgzNc1R9xL6yt2
	 Rvx1svP1Q7fNZhvTqMXwjn91j4OfMo1HlImHUGjyCal7glMUZUgdawiCCsEQ9jouRS
	 GF4vWVCsxCPg6GC9F22vrG/Cf8lPU5wBMmMcwIN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390532AbgHQSMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388404AbgHQQH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:07:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F5C52063A;
        Mon, 17 Aug 2020 16:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680430;
        bh=czLzkuigSE0yWbb7CWeu1dApXw6x2Ys57xFZ91ZAJVU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zfSdrBrcEBKY7iC4tQqX5Z5b5qYCEC+UAxx+9CNlxq2M8YZn5Eq9WRUBpizcwKNPj
         WMuISpfL3022fGz+jGUzXml9q4FcQx6X8fj71cvBQpD+aNumULcgfbdDl/7Y3sPB5R
         8eVgp3KreTsIS+Y4aeCPcgkBhpm1tg+TMiK/aJnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Zhang <markz@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 183/270] RDMA/netlink: Remove CAP_NET_RAW check when dump a raw QP
Date:   Mon, 17 Aug 2020 17:16:24 +0200
Message-Id: <20200817143804.925597303@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143755.807583758@linuxfoundation.org>
References: <20200817143755.807583758@linuxfoundation.org>
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
index 244ebf285fc3f..e4905d9fecb05 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -702,9 +702,6 @@ static int fill_stat_counter_qps(struct sk_buff *msg,
 			continue;
 
 		qp = container_of(res, struct ib_qp, res);
-		if (qp->qp_type == IB_QPT_RAW_PACKET && !capable(CAP_NET_RAW))
-			continue;
-
 		if (!qp->counter || (qp->counter->id != counter->id))
 			continue;
 
-- 
2.25.1



