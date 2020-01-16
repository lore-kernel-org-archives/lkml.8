Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012D7C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF265217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579197708;
	bh=kzHgwvVlvZywOl9IOGR6exySXwCFl52/8X1gpdv0k8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RbVCcIh3Md5fU2rZJzfQfdKWpH3SzxQudZNnrad2uyhr1Xd3mSr4QKKIdQsKy6QSd
	 DvZuEeahcBtv5u4UWGO9tnnc60wjLb5nvAhS7bTvj6HJR+MUZS+QxGz9xfRgsNLVav
	 2RroDC3TwPnh5BHKvZvN0VUVtCDZbQuj/d4x+c+0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393782AbgAPRlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:41:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390595AbgAPRkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:40:35 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95EA324713;
        Thu, 16 Jan 2020 17:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196434;
        bh=kzHgwvVlvZywOl9IOGR6exySXwCFl52/8X1gpdv0k8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1TgLuxCKZRqZ9xgzlbTf0s5fsKSYao68p5ak3wB5t9hkrTa3y4zlJ/hS8oxr3JQp4
         ybL837SFpz5/8rovCkJZXvhIToOm0DYO7uyCwY09bYBDfToe+7f+NyY6giz1ls6IJq
         5hgs54OedlPdX9aDnliH8uJOCFFRklDmv5OL+VZ0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mao Wenan <maowenan@huawei.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 200/251] net: sonic: replace dev_kfree_skb in sonic_send_packet
Date:   Thu, 16 Jan 2020 12:35:49 -0500
Message-Id: <20200116173641.22137-160-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mao Wenan <maowenan@huawei.com>

[ Upstream commit 49f6c90bf6805948b597eabb499e500a47cf24be ]

sonic_send_packet will be processed in irq or non-irq
context, so it would better use dev_kfree_skb_any
instead of dev_kfree_skb.

Fixes: d9fb9f384292 ("*sonic/natsemi/ns83829: Move the National Semi-conductor drivers")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/natsemi/sonic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/natsemi/sonic.c b/drivers/net/ethernet/natsemi/sonic.c
index 11f472fd5d47..a051dddcbd76 100644
--- a/drivers/net/ethernet/natsemi/sonic.c
+++ b/drivers/net/ethernet/natsemi/sonic.c
@@ -222,7 +222,7 @@ static int sonic_send_packet(struct sk_buff *skb, struct net_device *dev)
 	laddr = dma_map_single(lp->device, skb->data, length, DMA_TO_DEVICE);
 	if (!laddr) {
 		pr_err_ratelimited("%s: failed to map tx DMA buffer.\n", dev->name);
-		dev_kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		return NETDEV_TX_OK;
 	}
 
-- 
2.20.1

