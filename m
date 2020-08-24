Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBF8C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:54:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36EC2206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 09:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598262863;
	bh=1w+ZeW5Eq4Fc9nQKvS9ZWp0Qrvgwjaw+QflNsi9usso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hPE9nabFodQkaTxki4dqqjkPHxTHshdNX9beiTRIpMaqqk+GJBhHPnHTtEeStZbYK
	 O9aSx/ElzE/wPryWl5k/1VMrB7ylCnu+J2SHtmp0YBiDZh7Fsld6cVCFc6uUhqqe6K
	 dKjz2Fzi0VK6ZAP/LZxeaEk9mlkIDKbA7AlaHGfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbgHXJyS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 05:54:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbgHXIhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 04:37:40 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF6452177B;
        Mon, 24 Aug 2020 08:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598258260;
        bh=1w+ZeW5Eq4Fc9nQKvS9ZWp0Qrvgwjaw+QflNsi9usso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uL9YntxfhFTAZJtWkyeh6q4lywCE/ugEgOwRWNvNVZF/P2UdL+3sy/YpaTnFfjyMC
         y2XVr8jhgfdV02lLSNNttNQbgM/uMEwG/ffoIjOE3T3zHO/WG/Cy4A+p3NREiWL42a
         AD5Jk5+NwccVZbMu098JpYhYxGwGQOSq2wfR4Ls0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shay Agroskin <shayagr@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 134/148] net: ena: Change WARN_ON expression in ena_del_napi_in_range()
Date:   Mon, 24 Aug 2020 10:30:32 +0200
Message-Id: <20200824082420.437260941@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200824082413.900489417@linuxfoundation.org>
References: <20200824082413.900489417@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shay Agroskin <shayagr@amazon.com>

[ Upstream commit 8b147f6f3e7de4e51113e3e9ec44aa2debc02c58 ]

The ena_del_napi_in_range() function unregisters the napi handler for
rings in a given range.
This function had the following WARN_ON macro:

    WARN_ON(ENA_IS_XDP_INDEX(adapter, i) &&
	    adapter->ena_napi[i].xdp_ring);

This macro prints the call stack if the expression inside of it is
true [1], but the expression inside of it is the wanted situation.
The expression checks whether the ring has an XDP queue and its index
corresponds to a XDP one.

This patch changes the expression to
    !ENA_IS_XDP_INDEX(adapter, i) && adapter->ena_napi[i].xdp_ring
which indicates an unwanted situation.

Also, change the structure of the function. The napi handler is
unregistered for all rings, and so there's no need to check whether the
index is an XDP index or not. By removing this check the code becomes
much more readable.

Fixes: 548c4940b9f1 ("net: ena: Implement XDP_TX action")
Signed-off-by: Shay Agroskin <shayagr@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 1a2a464fb2f5f..000f57198352d 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -2177,13 +2177,10 @@ static void ena_del_napi_in_range(struct ena_adapter *adapter,
 	int i;
 
 	for (i = first_index; i < first_index + count; i++) {
-		/* Check if napi was initialized before */
-		if (!ENA_IS_XDP_INDEX(adapter, i) ||
-		    adapter->ena_napi[i].xdp_ring)
-			netif_napi_del(&adapter->ena_napi[i].napi);
-		else
-			WARN_ON(ENA_IS_XDP_INDEX(adapter, i) &&
-				adapter->ena_napi[i].xdp_ring);
+		netif_napi_del(&adapter->ena_napi[i].napi);
+
+		WARN_ON(!ENA_IS_XDP_INDEX(adapter, i) &&
+			adapter->ena_napi[i].xdp_ring);
 	}
 }
 
-- 
2.25.1



