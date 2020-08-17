Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFAC9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CAD820760
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 15:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597678880;
	bh=lXVav9E9BQJ2rFz0dDrWD2AusujUD6njRBjQsuo33o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HR2RpHv9iCBc/ibdvsMmIRhJyzTHB+D2O/CH6YNgRZq93rPnGAFU0T5ew2sLalU0G
	 jhxVJwAdEdv5cZmh3wKOxMX8XyINGShueJAu4g/k45+Rg39smv40Yo+5o/YCqNa1vT
	 Vtvr9FUToYUHfz1rG5mHbnCiwhSqkVnow2TMx9N8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgHQPlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 11:41:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730389AbgHQPdg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:33:36 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D4A512310C;
        Mon, 17 Aug 2020 15:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678415;
        bh=lXVav9E9BQJ2rFz0dDrWD2AusujUD6njRBjQsuo33o4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZqrC8dPuLq0HaMLPsgZ7FYvhdWbVnic/6bHOJP+Oq4WRIgjzrlQBhnKY2EBY2Ss9m
         azX8uu/G5c9etI4H64WRitVR/3I7w/SsOwI41NLpeVuKwl5N4J5x5ECXyL5UzGMo/G
         XrjnXxuvzxv0C6lN/bvWNdjQmgfn76gV5hqCzCzg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Lang Cheng <chenglang@huawei.com>,
        Weihang Li <liweihang@huawei.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 327/464] RDMA/hns: Fix error during modify qp RTS2RTS
Date:   Mon, 17 Aug 2020 17:14:40 +0200
Message-Id: <20200817143849.454683604@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143833.737102804@linuxfoundation.org>
References: <20200817143833.737102804@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

[ Upstream commit 4327bd2c41412657ee2c8c0d8d3d1945268b4238 ]

One qp state migrations legal configuration was deleted mistakenly.

Fixes: 357f34294686 ("RDMA/hns: Simplify the state judgment code of qp")
Link: https://lore.kernel.org/r/1595932941-40613-7-git-send-email-liweihang@huawei.com
Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 0618ced45bf80..9833ce3e21f9e 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -4301,7 +4301,9 @@ static bool check_qp_state(enum ib_qp_state cur_state,
 		[IB_QPS_RTR] = { [IB_QPS_RESET] = true,
 				 [IB_QPS_RTS] = true,
 				 [IB_QPS_ERR] = true },
-		[IB_QPS_RTS] = { [IB_QPS_RESET] = true, [IB_QPS_ERR] = true },
+		[IB_QPS_RTS] = { [IB_QPS_RESET] = true,
+				 [IB_QPS_RTS] = true,
+				 [IB_QPS_ERR] = true },
 		[IB_QPS_SQD] = {},
 		[IB_QPS_SQE] = {},
 		[IB_QPS_ERR] = { [IB_QPS_RESET] = true, [IB_QPS_ERR] = true }
-- 
2.25.1



