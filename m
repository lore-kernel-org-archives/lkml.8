Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23144C2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E808920848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 09:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585645431;
	bh=pp5N/R4n/WDg81xZuAGaiZO1dQVL7E7torSa5fcvnnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KGSe4RE1ft2u3bQ/dz3G0QBDqPrGon+mrVKyMG5JHiHA4BorpxXAM/Eh+aYxCAhDB
	 BYdSlEM4Pm2bKwznAy8wwJlu8P7DZX43bNrpv5tj4FZiTe8s6XdyCM/OWc6S4LuB1J
	 rehVTmDwQ6i2TOvMLObV/+kdRlf3H5TNJa75GY60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730879AbgCaJDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 05:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:43538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730868AbgCaJDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 05:03:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A68820787;
        Tue, 31 Mar 2020 09:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585645426;
        bh=pp5N/R4n/WDg81xZuAGaiZO1dQVL7E7torSa5fcvnnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mXJAqg+ThMFbqAcHot8efdjtWW70kAlFv2hOM23SucmR9PlENc2oq2U2YSrtrH3cc
         Zl2Zisen3SNh3aBzVW9eD00Pvja7EBnXMg17D8hhkynHQKJSTuLcxwefHfxdDM3jMD
         /gZ5LvjV4it7EldbCBSxs059WTGlszGTPC4aYWqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Noam Dagan <ndagan@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.5 049/170] net: ena: avoid memory access violation by validating req_id properly
Date:   Tue, 31 Mar 2020 10:57:43 +0200
Message-Id: <20200331085429.621233830@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200331085423.990189598@linuxfoundation.org>
References: <20200331085423.990189598@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Kiyanovski <akiyano@amazon.com>

[ Upstream commit 30623e1ed116bcd1785217d0a98eec643687e091 ]

Rx req_id is an index in struct ena_eth_io_rx_cdesc_base.
The driver should validate that the Rx req_id it received from
the device is in range [0, ring_size -1].  Failure to do so could
yield to potential memory access violoation.
The validation was mistakenly done when refilling
the Rx submission queue and not in Rx completion queue.

Fixes: ad974baef2a1 ("net: ena: add support for out of order rx buffers refill")
Signed-off-by: Noam Dagan <ndagan@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c |   15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -532,13 +532,9 @@ static int ena_refill_rx_bufs(struct ena
 		struct ena_rx_buffer *rx_info;
 
 		req_id = rx_ring->free_ids[next_to_use];
-		rc = validate_rx_req_id(rx_ring, req_id);
-		if (unlikely(rc < 0))
-			break;
 
 		rx_info = &rx_ring->rx_buffer_info[req_id];
 
-
 		rc = ena_alloc_rx_page(rx_ring, rx_info,
 				       GFP_ATOMIC | __GFP_COMP);
 		if (unlikely(rc < 0)) {
@@ -868,9 +864,15 @@ static struct sk_buff *ena_rx_skb(struct
 	struct ena_rx_buffer *rx_info;
 	u16 len, req_id, buf = 0;
 	void *va;
+	int rc;
 
 	len = ena_bufs[buf].len;
 	req_id = ena_bufs[buf].req_id;
+
+	rc = validate_rx_req_id(rx_ring, req_id);
+	if (unlikely(rc < 0))
+		return NULL;
+
 	rx_info = &rx_ring->rx_buffer_info[req_id];
 
 	if (unlikely(!rx_info->page)) {
@@ -943,6 +945,11 @@ static struct sk_buff *ena_rx_skb(struct
 		buf++;
 		len = ena_bufs[buf].len;
 		req_id = ena_bufs[buf].req_id;
+
+		rc = validate_rx_req_id(rx_ring, req_id);
+		if (unlikely(rc < 0))
+			return NULL;
+
 		rx_info = &rx_ring->rx_buffer_info[req_id];
 	} while (1);
 


