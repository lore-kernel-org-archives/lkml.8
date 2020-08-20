Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D3FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20CFD208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 09:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597916615;
	bh=xyDZYkyPG1JpMD3a/x9ITUBO7mLGiopl2omnRGsYpl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YDNJIUqxbClMyt8nmrWEcWaMZAbOJ+R5k7hu7/55lVDVqfEywSQBK/1EHLJjh+8w9
	 ih4r6I7YrQMZ5Alxn8b61Orrx54EGyvXdH8nmPdJzXnqAMsehnhjnXhcjWeZFA4YFV
	 urKAm4ZVpK3AnYKqkb+5mPZgMFPVdBx0OgQLISCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgHTJnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:43:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727774AbgHTJmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:42:14 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 398782075E;
        Thu, 20 Aug 2020 09:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597916533;
        bh=xyDZYkyPG1JpMD3a/x9ITUBO7mLGiopl2omnRGsYpl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NnydXkJ8hCsEyobyebgrrAXKrQNFLB5r7YzE8m2ejtN29rkJEluUmEvUhpW8gZ0u3
         sBH5/hmY0g8kxjTF6zLWqyW14JqBor4lYmsKo8r0mqyFsy0CA2UDK+QgcDLYY2uIDJ
         U/vUrdIzvS6GqVDGW68jUkkXyZJmn3eeKkAYS++g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Zhang <markz@mellanox.com>,
        Maor Gottlieb <maorg@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 122/204] RDMA/counter: Only bind user QPs in auto mode
Date:   Thu, 20 Aug 2020 11:20:19 +0200
Message-Id: <20200820091612.389345052@linuxfoundation.org>
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

[ Upstream commit c9f557421e505f75da4234a6af8eff46bc08614b ]

In auto mode only bind user QPs to a dynamic counter, since this feature
is mainly used for system statistic and diagnostic purpose, while there's
no need to counter kernel QPs so far.

Fixes: 99fa331dc862 ("RDMA/counter: Add "auto" configuration mode support")
Link: https://lore.kernel.org/r/20200702082933.424537-3-leon@kernel.org
Signed-off-by: Mark Zhang <markz@mellanox.com>
Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/counters.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/counters.c b/drivers/infiniband/core/counters.c
index 738d1faf4bba5..6deb1901fbd02 100644
--- a/drivers/infiniband/core/counters.c
+++ b/drivers/infiniband/core/counters.c
@@ -288,7 +288,7 @@ int rdma_counter_bind_qp_auto(struct ib_qp *qp, u8 port)
 	struct rdma_counter *counter;
 	int ret;
 
-	if (!qp->res.valid)
+	if (!qp->res.valid || rdma_is_kernel_res(&qp->res))
 		return 0;
 
 	if (!rdma_is_port_valid(dev, port))
-- 
2.25.1



