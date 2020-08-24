Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158B2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D90902067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 16:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598287317;
	bh=mdxoQ4ei3+fvVShYPWCRRxh5xRlB/KycAgoxaaOHUIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MpGRYm0f/Dp095EVwQjGZ2NVmBWz8228swRDLyVt1wQd9wvyUrgPLjJJbEx7hTXkf
	 AMq+TXXoaH/y1pyyA2ZtC8mCIL621LMJQQvEqtYh5COHLCVP+2T4dH2M5+yl7DQdYe
	 D/uSKnrhvNngxoso1ifNrE0fFEUa0D66/pJuw1Ak=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728601AbgHXQly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 12:41:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgHXQju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 12:39:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB14622C9F;
        Mon, 24 Aug 2020 16:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598287190;
        bh=mdxoQ4ei3+fvVShYPWCRRxh5xRlB/KycAgoxaaOHUIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O3YJF8tVHVfKzeB5iECkcoWXA3Rjc3wz/Po72PlESWPdEDHSAuCepumSocTjaw1FP
         eKqLXIUlXcOPmijzZ7ON+gDrEz7D3cobJEL3mL99roDE5a6slUIa7H2yV5KWeNKML4
         QaIEk0SxyKNb+WGoCRs/gfjyrzMemN6qwAQcxGZY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 5/6] net: gianfar: Add of_node_put() before goto statement
Date:   Mon, 24 Aug 2020 12:39:42 -0400
Message-Id: <20200824163943.607406-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824163943.607406-1-sashal@kernel.org>
References: <20200824163943.607406-1-sashal@kernel.org>
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
index 37cc1f838dd8b..96310e2ee5458 100644
--- a/drivers/net/ethernet/freescale/gianfar.c
+++ b/drivers/net/ethernet/freescale/gianfar.c
@@ -845,8 +845,10 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
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

