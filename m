Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DEAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6382072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 08:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598259472;
	bh=JqRHT0KFFS2P9nKBaQiu5twB3tuiPvQp/NoeBcvYKjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tu4OxADXjDLa6VyyhnlFcz/MUUwrZgR1pJGH78MC9KdjqqX9l+i1w6+11h6T7dmAt
	 KveBdrvHmn++61Mq8FBf95uQQ2FifB8bh89rVG12wo2fMqOcO7CDuMlYPe2IQQmgAQ
	 5BZPFDzniZEpTZe9iLhDu2l6jTLHaiHsPBAmc7nU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbgHXI5v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 04:57:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:44430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730675AbgHXI50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:57:26 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 581F7207D3;
        Mon, 24 Aug 2020 08:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598259445;
        bh=JqRHT0KFFS2P9nKBaQiu5twB3tuiPvQp/NoeBcvYKjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eqF/f8y3VYGTlLWwWB6+hqBLZ8H+S4fK8TA9fZYxc1LTYmWaCwkPgstAy70NTm8ZQ
         ZXN9R0fksloxGfwqmCEkj1a3sj0a74PGah6zYwMgSoYfpWHjjdbnA0jVEZ9ZNb1prs
         yQVoZ+jaE8P6D4tUlli9p4lv3Dxgddz9Zhj9UUQQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hulk Robot <hulkci@huawei.com>,
        Wang Hai <wanghai38@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 62/71] net: gemini: Fix missing free_netdev() in error path of gemini_ethernet_port_probe()
Date:   Mon, 24 Aug 2020 10:31:53 +0200
Message-Id: <20200824082359.038754959@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082355.848475917@linuxfoundation.org>
References: <20200824082355.848475917@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>

[ Upstream commit cf96d977381d4a23957bade2ddf1c420b74a26b6 ]

Replace alloc_etherdev_mq with devm_alloc_etherdev_mqs. In this way,
when probe fails, netdev can be freed automatically.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index f402af39da42a..16de0fa92ab74 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -2392,7 +2392,7 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 
 	dev_info(dev, "probe %s ID %d\n", dev_name(dev), id);
 
-	netdev = alloc_etherdev_mq(sizeof(*port), TX_QUEUE_NUM);
+	netdev = devm_alloc_etherdev_mqs(dev, sizeof(*port), TX_QUEUE_NUM, TX_QUEUE_NUM);
 	if (!netdev) {
 		dev_err(dev, "Can't allocate ethernet device #%d\n", id);
 		return -ENOMEM;
@@ -2526,7 +2526,6 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
 	}
 
 	port->netdev = NULL;
-	free_netdev(netdev);
 	return ret;
 }
 
@@ -2535,7 +2534,6 @@ static int gemini_ethernet_port_remove(struct platform_device *pdev)
 	struct gemini_ethernet_port *port = platform_get_drvdata(pdev);
 
 	gemini_port_remove(port);
-	free_netdev(port->netdev);
 	return 0;
 }
 
-- 
2.25.1



