Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D801C35671
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65AC420659
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 02:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582424885;
	bh=YUp+x46YJV3qWYuyFvqm+xktcZT6q3KY1sQikdYXYxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pkJtFPzEuIAHOzqDqjzJ14HJAxUQwmPCh+WzoNQT2ut2LsxBgRufBHGg1UkyF4Ul+
	 zzOmmVgv3rhnZJ6dS7NzS4kvyiuordC4UTxIuESA290lAtfmNDCgnWEMkjRaGr1dpb
	 odZ99vLsebSeocOpvysewdBudPyxb3TdX280yLQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgBWC2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 21:28:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:54382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727978AbgBWCYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 21:24:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC77621D56;
        Sun, 23 Feb 2020 02:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582424664;
        bh=YUp+x46YJV3qWYuyFvqm+xktcZT6q3KY1sQikdYXYxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LJS2BV/HcaXa2EkZbiw+TAe0UXoCrlDXJlmNXnL8m4RBwNNOMkjoHARn0U0CEe7r6
         L2BYgikWRUcj1xN4psMgUbdUP9bGArzI6Sr2Rt2natd7ezQJAQrMtZCDe/cXKsplz8
         MiCyXz/kLOgli5acwCoTopbZhaYJOVS/8GR8aHWc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Arthur Kiyanovski <akiyano@amazon.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 10/21] net: ena: fix uses of round_jiffies()
Date:   Sat, 22 Feb 2020 21:24:00 -0500
Message-Id: <20200223022411.2159-10-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200223022411.2159-1-sashal@kernel.org>
References: <20200223022411.2159-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Kiyanovski <akiyano@amazon.com>

[ Upstream commit 2a6e5fa2f4c25b66c763428a3e65363214946931 ]

>From the documentation of round_jiffies():
"Rounds a time delta  in the future (in jiffies) up or down to
(approximately) full seconds. This is useful for timers for which
the exact time they fire does not matter too much, as long as
they fire approximately every X seconds.
By rounding these timers to whole seconds, all such timers will fire
at the same time, rather than at various times spread out. The goal
of this is to have the CPU wake up less, which saves power."

There are 2 parts to this patch:
================================
Part 1:
-------
In our case we need timer_service to be called approximately every
X=1 seconds, and the exact time does not matter, so using round_jiffies()
is the right way to go.

Therefore we add round_jiffies() to the mod_timer() in ena_timer_service().

Part 2:
-------
round_jiffies() is used in check_for_missing_keep_alive() when
getting the jiffies of the expiration of the keep_alive timeout. Here it
is actually a mistake to use round_jiffies() because we want the exact
time when keep_alive should expire and not an approximate rounded time,
which can cause early, false positive, timeouts.

Therefore we remove round_jiffies() in the calculation of
keep_alive_expired() in check_for_missing_keep_alive().

Fixes: 82ef30f13be0 ("net: ena: add hardware hints capability to the driver")
Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 518ff393a026b..d9ece9ac6f53c 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2803,8 +2803,8 @@ static void check_for_missing_keep_alive(struct ena_adapter *adapter)
 	if (adapter->keep_alive_timeout == ENA_HW_HINTS_NO_TIMEOUT)
 		return;
 
-	keep_alive_expired = round_jiffies(adapter->last_keep_alive_jiffies +
-					   adapter->keep_alive_timeout);
+	keep_alive_expired = adapter->last_keep_alive_jiffies +
+			     adapter->keep_alive_timeout;
 	if (unlikely(time_is_before_jiffies(keep_alive_expired))) {
 		netif_err(adapter, drv, adapter->netdev,
 			  "Keep alive watchdog timeout.\n");
@@ -2906,7 +2906,7 @@ static void ena_timer_service(unsigned long data)
 	}
 
 	/* Reset the timer */
-	mod_timer(&adapter->timer_service, jiffies + HZ);
+	mod_timer(&adapter->timer_service, round_jiffies(jiffies + HZ));
 }
 
 static int ena_calc_io_queue_num(struct pci_dev *pdev,
-- 
2.20.1

