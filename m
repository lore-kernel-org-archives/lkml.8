Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E15C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5B282067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598287432;
	bh=0aYOyJLFu4Wv5vEpEX4FeNcSW03GWsGp9oUJZGmRMAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nxCKBUfnevECQFll60EYetooS95q4KHnw7cIjC73C1h1a4NMKQsoxEqXg1Sm+c/Df
	 GGEBJKa2yJNOvUgYZMLhkljzf+TEyY339k/bjrT3ZnzblvLWkcKKO96rk9ZdYnWeE1
	 DCJXeJF5VneBuBSIS+FKCw9dVyvlZ6+EWeJs2mxw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgHXQnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:47724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728120AbgHXQjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:39:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73D1720838;
        Mon, 24 Aug 2020 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287181;
        bh=0aYOyJLFu4Wv5vEpEX4FeNcSW03GWsGp9oUJZGmRMAU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DlcyiRd2JzxEyPY/xi8GW0MN841wNqqTZTLhjw4Xqsudtk+7qysTx2iaHPUwNjqcV
         Wwzrsi99LjSg2dJxADSFIrzEYuLUMkEW1uIIh+PbAGlG8qYz8s2yDAXs1OWLQ2IbXc
         tDmX5kH+gXUHaBsFZgzoBKWzrQDfsbcv7kODwGSs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 7/8] net: gianfar: Add of_node_put() before goto statement
Date:   Mon, 24 Aug 2020 12:39:30 -0400
Message-Id: <20200824163931.607291-7-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163931.607291-1-sashal@kernel.org>
References: <20200824163931.607291-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sumera Priyadarsini <sylphrenadin@gmail.com>

[ Upstream commit 989e4da042ca4a56bbaca9223d1a93639ad11e17 ]

Every iteration of for_each_available_child_of_node() decrements
reference count of the previous node, however when control
is transferred from the middle of the loop, as in the case of
a return or break or goto, there is no decrement thus ultimately
resulting in a memory leak.

Fix a potential memory leak in gianfar.c by inserting of_node_put()
before the goto statement.

Issue found with Coccinelle.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/gianfar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
index b665d27f8e299..95ab44aa0eeab 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -844,8 +844,10 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
 				continue;
 
 			err = gfar_parse_group(child, priv, model);
-			if (err)
+			if (err) {
+				of_node_put(child);
 				goto err_grp_init;
+			}
 		}
 	} else { /* SQ_SG_MODE */
 		err = gfar_parse_group(np, priv, model);
-- 
2.25.1

