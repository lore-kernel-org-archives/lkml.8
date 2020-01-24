Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BF89C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A4AB2077C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579863875;
	bh=MvDF8ko1JKsYoID0YXdfqrN8Dh1ZztD6vS+RwrryhpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zu9hDg9lcyqMLBHj8YeX/2F+css/sZcEnOMEFaUTi/asGf26EgL2eKnz3+w/I3KtY
	 wSbzdqp1TDY/cq6nDmll7t4ErJr2Wn5hkAyLdHRKxH458nwRZRCQ8XnQi9VeIGczSj
	 eJsoM9rSxWoV3pDR0HgxdTWuqkW76Lv6QpsiqOeA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388618AbgAXLEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:04:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387885AbgAXLEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:04:31 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75E992075D;
        Fri, 24 Jan 2020 11:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579863871;
        bh=MvDF8ko1JKsYoID0YXdfqrN8Dh1ZztD6vS+RwrryhpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V2rGwwMB3fpWuOdRLt1khaGFpx63tSozZXEXPiuKzVYQ5R19Ecx5OHlF2eSFww+QR
         6UwZDiJ04X7D6rx8M8lYCCHxK0dr1x0OVXMXy+zh6FfEMjzfjmqj51wqUqJkDc9H0F
         XVXQlpGggQebCicvZ3yY5VJLvv9gsN/ZMliMwwss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huazhong Tan <tanhuazhong@huawei.com>,
        Peng Li <lipeng321@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 097/639] net: hns3: fix error handling int the hns3_get_vector_ring_chain
Date:   Fri, 24 Jan 2020 10:24:27 +0100
Message-Id: <20200124093059.466079866@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huazhong Tan <tanhuazhong@huawei.com>

[ Upstream commit cda69d244585bc4497d3bb878c22fe2b6ad647c1 ]

When hns3_get_vector_ring_chain() failed in the
hns3_nic_init_vector_data(), it should do the error handling instead
of return directly.

Also, cur_chain should be freed instead of chain and head->next should
be set to NULL in error handling of hns3_get_vector_ring_chain.

This patch fixes them.

Fixes: 73b907a083b8 ("net: hns3: bugfix for buffer not free problem during resetting")
Signed-off-by: Huazhong Tan <tanhuazhong@huawei.com>
Signed-off-by: Peng Li <lipeng321@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 9df807ec8c840..10fa7f5df57e7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -2605,9 +2605,10 @@ err_free_chain:
 	cur_chain = head->next;
 	while (cur_chain) {
 		chain = cur_chain->next;
-		devm_kfree(&pdev->dev, chain);
+		devm_kfree(&pdev->dev, cur_chain);
 		cur_chain = chain;
 	}
+	head->next = NULL;
 
 	return -ENOMEM;
 }
@@ -2679,7 +2680,7 @@ static int hns3_nic_init_vector_data(struct hns3_nic_priv *priv)
 		ret = hns3_get_vector_ring_chain(tqp_vector,
 						 &vector_ring_chain);
 		if (ret)
-			return ret;
+			goto map_ring_fail;
 
 		ret = h->ae_algo->ops->map_ring_to_vector(h,
 			tqp_vector->vector_irq, &vector_ring_chain);
-- 
2.20.1



