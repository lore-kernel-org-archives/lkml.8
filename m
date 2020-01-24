Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E464C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FE920704
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579864769;
	bh=xNe8SbaqIwlAm/s478LjA2GxEsdSf+skVhQoiiGm8X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zJFfK9k2wgiZ6zUJMpJlyC36vpmGQ9SNuqiwC9QWwXisG4MCgQAlptcVm/DVSFa+k
	 lKs/FU8ynip6LqRKINkeWWd23ECw7vl7Gk8aRYFUMQJXIxw0WHKDeYE41ZeILXVEZ9
	 7xO0Nurm1TA8MSpQT5vGcYh/LIkH8seJnpX9STRI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390791AbgAXLT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:19:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56724 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390773AbgAXLTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:19:20 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CDA120704;
        Fri, 24 Jan 2020 11:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579864760;
        bh=xNe8SbaqIwlAm/s478LjA2GxEsdSf+skVhQoiiGm8X8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fkyyk4jX+As5aG+Hn3rOAfIdDAoo8tfC3VsnQjnPl45CvLtJEt8RYiEj/p90v+pKP
         hwXEu81pkMknYQ9e2TnqS4eUvXXzyUKIBzVcYw3Sv9U8OWLVLQHr9Xi+yUoXk8uR81
         YXAvpxtHh0wljZQ1ZoWCkS83u7ylc38gKIcyxZaw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saeed Bshara <saeedb@amazon.com>,
        Sameeh Jubran <sameehj@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 345/639] net: ena: fix swapped parameters when calling ena_com_indirect_table_fill_entry
Date:   Fri, 24 Jan 2020 10:28:35 +0100
Message-Id: <20200124093130.339121896@linuxfoundation.org>
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

From: Sameeh Jubran <sameehj@amazon.com>

[ Upstream commit 3c6eeff295f01bdf1c6c3addcb0a04c0c6c029e9 ]

second parameter should be the index of the table rather than the value.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Saeed Bshara <saeedb@amazon.com>
Signed-off-by: Sameeh Jubran <sameehj@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/amazon/ena/ena_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_ethtool.c b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
index 521607bc43937..eb9e07fa427ee 100644
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -695,8 +695,8 @@ static int ena_set_rxfh(struct net_device *netdev, const u32 *indir,
 	if (indir) {
 		for (i = 0; i < ENA_RX_RSS_TABLE_SIZE; i++) {
 			rc = ena_com_indirect_table_fill_entry(ena_dev,
-							       ENA_IO_RXQ_IDX(indir[i]),
-							       i);
+							       i,
+							       ENA_IO_RXQ_IDX(indir[i]));
 			if (unlikely(rc)) {
 				netif_err(adapter, drv, netdev,
 					  "Cannot fill indirect table (index is too large)\n");
-- 
2.20.1



