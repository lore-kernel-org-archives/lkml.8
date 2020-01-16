Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF13C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D6CA2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579201117;
	bh=s89gvlUNQw6c84NWlJrR+GuuM5pUVH0aoRiLuhCld9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B7Bp2WBPvKwOF3iY0Z/Spup8JIZUOtSBFG/nHglRorqlfHfy5KO7nOIIvUi/eP1iM
	 pR4eKsG6fmdvjZqEJwb2fwf3onZlYkIeH6WfbBBBT6sbSlgsI7JoD7WJYGTz++lz4a
	 9ePGw/ij6MCW6tFSnnnvE59FjtuIjkj24z5id6f0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437201AbgAPS6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:58:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388991AbgAPRGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:06:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A29D205F4;
        Thu, 16 Jan 2020 17:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194408;
        bh=s89gvlUNQw6c84NWlJrR+GuuM5pUVH0aoRiLuhCld9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jEIx+kOseOVB47/JIZ7SMnL5tNxyWEDPlOwtM/rEj+no0YcYadQOHXxdJRNqNPjyz
         immGd0+apNs5b4pootfVm6m8GbVyuUtLxgLKLycjBvvx4EzfKVF7UBNKuEAL+7sctC
         gD08KRV4r79/KueRqqQSk7agIFgETiwAgCsjtEmE=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sameeh Jubran <sameehj@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 331/671] net: ena: fix: Free napi resources when ena_up() fails
Date:   Thu, 16 Jan 2020 11:59:29 -0500
Message-Id: <20200116170509.12787-68-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sameeh Jubran <sameehj@amazon.com>

[ Upstream commit b287cdbd1cedfc9606682c6e02b58d00ff3a33ae ]

ena_up() calls ena_init_napi() but does not call ena_del_napi() in
case of failure. This causes a segmentation fault upon rmmod when
netif_napi_del() is called. Fix this bug by calling ena_del_napi()
before returning error from ena_up().

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: Sameeh Jubran <sameehj@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index e26c195fec83..9afb19ebba58 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1800,6 +1800,7 @@ static int ena_up(struct ena_adapter *adapter)
 err_setup_tx:
 	ena_free_io_irq(adapter);
 err_req_irq:
+	ena_del_napi(adapter);
 
 	return rc;
 }
-- 
2.20.1

