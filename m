Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A90C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 945DE20775
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659070;
	bh=z7gDBR7r2v1d53adOPJ8Y5sH1IQpGouDfJC0D7BaCZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pe5Iie//+cAetzGmadEuVXzVtWKhI2v3LhZLscKOxufhbpg0NiHfxOBJnnAjpB176
	 KFmkQ7SW6xn/i6qHXdTErX8N4QYJQ8VV7siSm7Yq0SqNmj31S4geL0Y8j8sNnbrcgK
	 v6EPi+KbJrN4DaGPoaRezvaZyXPjsGFvYVx+mWdQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387855AbgFHXbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:31:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:51304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731288AbgFHXY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:24:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5472214F1;
        Mon,  8 Jun 2020 23:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658697;
        bh=z7gDBR7r2v1d53adOPJ8Y5sH1IQpGouDfJC0D7BaCZI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YRphtSdtBCrIVRUk0m+c3oAQCpvf2clRzZLaYyZDSkgZsNxvAKi59N9tqhbQ1WBZx
         hjceF//FAs5AB7uFWYmTNVERiibhS+WD5VzfwikIaP+m88g/GN8lc4UbDDa6am5ThS
         xSkOrJuVZ49WcjwA8/TKj3h49QlCFTj3jqKvUiZo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Vasily Averin <vvs@virtuozzo.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 105/106] net_failover: fixed rollback in net_failover_open()
Date:   Mon,  8 Jun 2020 19:22:37 -0400
Message-Id: <20200608232238.3368589-105-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232238.3368589-1-sashal@kernel.org>
References: <20200608232238.3368589-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vasily Averin <vvs@virtuozzo.com>

[ Upstream commit e8224bfe77293494626f6eec1884fee7b87d0ced ]

found by smatch:
drivers/net/net_failover.c:65 net_failover_open() error:
 we previously assumed 'primary_dev' could be null (see line 43)

Fixes: cfc80d9a1163 ("net: Introduce net_failover driver")
Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/net_failover.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index beeb7eb76ca3..57273188b71e 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -62,7 +62,8 @@ static int net_failover_open(struct net_device *dev)
 	return 0;
 
 err_standby_open:
-	dev_close(primary_dev);
+	if (primary_dev)
+		dev_close(primary_dev);
 err_primary_open:
 	netif_tx_disable(dev);
 	return err;
-- 
2.25.1

